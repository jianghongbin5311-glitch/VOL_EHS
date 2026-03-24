import {
	ref,
	toRefs
} from 'vue'
export const initAsync = (proxy, props, dataConfig, callback) => {
	props.editFormOptions.forEach(x => {
		if (x.type == 'img' || x.type == 'file' || x.type == 'excel') {
			x.url = x.url || `api/${props.table.tableName}/upload`;
			if (!Array.isArray(props.editFormFields[x.field])) {
				props.editFormFields[x.field] = []
			}
		}
	})


	let authFields = proxy.$store.getters.getAuthFields()
	let permission = proxy.$store.getters.getMenu();
	// console.log(callback)
	// return {}
	if ((!permission || !permission.length)) {
		proxy.http.get("api/menu/getTreeMenu", {}, false).then(result => {
			permission = (result.menu ? result.menu : result) || [];
			authFields = result.authFields || []
			proxy.$store.commit("setPermission", JSON.parse(JSON.stringify(permission)));
			proxy.$store.commit("setAuthFields", authFields);
			callback(initPermissionButtons(proxy, props, permission, authFields, dataConfig));
			return;
		})
	}
	callback(initPermissionButtons(proxy, props, permission, authFields, dataConfig));
}
const initPermissionButtons = (proxy, props, permission, authFields, dataConfig) => {
	const state = {
		del: false,
		save: false,
		permission: {},
	}
	const data = (permission.find(x => {
		return (props.tableAction || props.table.tableName).toUpperCase() == x.tableName
			.toUpperCase()
	}) || {});
	let _permission = data.permission;
	if (!_permission) {
		return state;
	}
	state.permission = data;
	if (_permission.indexOf("Delete") != -1) {
		state.del = true;
	}
	//新建、编辑弹出框按钮
	if (_permission.indexOf("Update") != -1 || _permission.indexOf("Add") != -1) {
		state.save = true;
	} else {
		//没有编辑权限，将编辑表单的全部设置为只读
		props.editFormOptions.forEach(x => {
			x.readonly = true;
			x.required = false;
		})

		props.details.forEach(x => {
			x.columns.forEach(col => {
				col.readonly = true;
			})
		})
	}
	initButtons(proxy, state, props, dataConfig)
	return state;
}

const initButtons = (proxy, state, props, dataConfig) => {
	if (props.readonly) {
		return;
	}
	if (state.del && !dataConfig.isAdd) {
		dataConfig.buttons.push({
			name: "删除",
			hidden: false,
			type: "default",
			click: () => {
				proxy.delClick();
			}
		})
	}
	if (state.save) {
		dataConfig.buttons.push({
			name: props.saveName,
			hidden: false,
			type: "primary",
			click: () => {
				proxy.saveClick();
			}
		})

		dataConfig.detailButtons.push(...[{
			name: "删除",
			hidden: false,
			type: "default",
			//icon: "./del.png",
			icon: "trash",
			click: () => {
				proxy.delRowClick();
			}
		}, {
			name: "添加",
			hidden: false,
			type: "default",
			//icon: "./add.png",
			icon: "plus",
			click: () => {
				proxy.addRowClick();
			}
		}])
	}
}


export const getFormData = async (props, proxy, id) => {
	if (proxy.loadFormBefore && !(await proxy.loadFormBefore())) {
		return
	}
	if (!props.id && !id) {
		proxy.loadFormAfter && proxy.loadFormAfter({}, {});
		return;
	}
	const params = {
		page: 1,
		rows: 1,
		wheres: JSON.stringify([{
			name: props.table.key,
			value: id || props.id
		}])
	}
	const url = 'api/' + props.table.tableName + '/getPageData'
	await proxy.http.post(url, params, true).then((result) => {
		if (!result.rows) {
			proxy.$toast(proxy.$ts('参数不正确'))
			return
		}
		proxy.base.resetForm(props.editFormFields, props.editFormOptions, result.rows[0]);
		props.editFormFields[props.table.key] = result.rows[0][props.table.key]
		proxy.loadFormAfter && proxy.loadFormAfter(result, result.rows[0])
	})
}