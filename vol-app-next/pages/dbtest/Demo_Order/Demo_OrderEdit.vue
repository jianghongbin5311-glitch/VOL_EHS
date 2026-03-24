<!--
这是生成的文件，事件处理、自定义配置，见移动端文档：表单、表格配置
Author:vol
QQ:283591387
Date:2024
-->
<template>
	<vol-edit ref="editRef" :id="id" :table="table" :detail="detail" :details="details" :editFormFields="editFormFields"
		:editFormOptions="editFormOptions" :saveBefore="saveBefore" :labelWidth="70" labelPosition="left"
		:saveAfter="saveAfter" :delBefore="delBefore" @onChange="onChange" :delRowBefore="delRowBefore"
		:delRowAfter="delRowAfter" :loadFormAfter="loadFormAfter" 
		 edit-change 
		@onInited="onInited"
	    :detailFormInited="detailFormInited"
		@detailExtraClick="detailExtraClick"
		@detailOnChange="detailOnChange"
		@detailInputConfirm="detailInputConfirm">
		<template #header>
			<view style="margin-bottom: 22rpx;">
				<vol-alert>1.移动端支持主从表零代码自动生成,并支持扩展
					<view> 2.框架5分钟配置即可解决繁琐配置,大幅提高开发效率</view>
				</vol-alert>
			</view>
		</template>
		<template #content>
			<view style="margin-bottom: 22rpx;">
				<vol-alert>
					同样支持支持明细表自动生成代码
				</vol-alert>
			</view>
		</template>
		<template #button>
			<view class="btn">
				<vol-button>自定义按钮</vol-button>
			</view>
		</template>
		<template #detail-button>
			<view class="fx fx-center" style="margin-right: 20rpx;font-size: 26rpx;"><u-icon size="20"
					name="search"></u-icon> 测试</view>
		</template>
		
		<template #modelHeader>
			<vol-alert>这里可以自定义一些内容</vol-alert>
		</template>

	</vol-edit>
</template>
<script setup>
	import options from "./Demo_OrderOptions.js";
	import {
		onLoad
	} from '@dcloudio/uni-app'
	import {
		defineComponent,
		ref,
		reactive,
		getCurrentInstance,
		defineEmits,
		defineExpose,
		defineProps,
		watch,
		nextTick
	} from "vue";

	const props = defineProps({
		id: ''
	})
	const id = ref(props.id); //编辑的主键值
	const isAdd = !id.value; //当前是新建还是编辑
	const {
		proxy
	} = getCurrentInstance();

	//发起请求proxy.http.get/post
	//消息提示proxy.$toast()

	//vol-edit组件对象
	const editRef = ref(null);

	//编辑、查询、表格配置
	//要对table注册事件、格式化、按钮等，看移动端文档上的table示例配置
	//表单配置看移动端文档上的表单示例配置，searchFormOptions查询配置，editFormOptions编辑配置
	const {
		table,
		editFormFields,
		editFormOptions,
		detail,
		details
	} = reactive(options());

	editFormOptions.splice(0)
	editFormOptions.push(...[{
			"title": "订单编号",
			"required": true,
			"field": "OrderNo",
			"disabled": false
		},
		[{
				"key": "订单类型",
				"data": [],
				"title": "订单类型",
				"required": true,
				"field": "OrderType",
				"type": "select"
			},
			{
				"key": "订单状态",
				"data": [],
				"title": "订单状态",
				"required": true,
				"field": "OrderStatus",
				"type": "select"
			}
		],
		[{
				"title": "总价",
				"field": "TotalPrice",
				"type": "decimal"
			},
			{
				"title": "总数量",
				"field": "TotalQty",
				"type": "number"
			}
		],
		{
			"title": "客户名称",
			"align": "left",
			"field": "Customer"
		},
		{
			"type": "group"
		},
		{
			"title": "订单日期",
			"required": true,
			"field": "OrderDate",
			"type": "datetime"
		},
		{
			"title": "备注",
			"field": "Remark"
		}
	])
	//proxy.base.setFormFocus(editFormOptions,'Customer')
	//下拉框、日期、radio选择事件
	const onChange = (field, value, item, data) => {}

	//表单数据加载后方法
	const loadFormAfter = (result) => {
		//isAdd通过判断是新还是编辑状态，可以页面加载后设置一些其他默认值(新建/编辑都可使用)
		//editFormFields.字段=值;
	}

	//新建、编辑保存前
	const saveBefore = (formData, isAdd, callback) => {
		callback(true); //返回false，不会保存
	}

	//新建、编辑保存后
	const saveAfter = (res, isAdd) => {}

	//主表删除前方法
	const delBefore = async (id, fields) => {
		return true; //返回false不会执行删除
	}
	//明细表删除前
	const delRowBefore = async (rows, table, ops) => {
		// await proxy.http.post(url,{}).then(x => {		
		// })
		return true
	}

	//明细表删除后前
	const delRowAfter = (rows, table, ops) => {}

	//初始化配置，这里可以隐藏按钮
	const onInited=(opiton)=>{
		//隐藏主表表单按钮
		// opiton.buttons.forEach(c=>{
		// 	c.hidden=true;
		// })
		// //隐藏明细表按钮
		// opiton.detailButtons.forEach(c=>{
		// 	c.hidden=true;
		// })
	}

	//注意上面vol-edit绑定这个方法
	//明细表单出框初始化事件，这里可以给明细表添加选择按钮
	const detailFormInited = (table) => {
		//给明细表[GoodsName]字段绑定选择按钮
		const option = table.edit.formOptions.find(x => {
			return x.field == 'GoodsName'
		});
		if (option) {
			option.extra = {
				text: "按钮",
				button: true,
				type: "primary", //default
				icon: "search",
				color: "#ffff",
				size: 13
			}
		}
		table.edit.formOptions.forEach(c => {
			if (c.field == 'GoodsCode') {
				c.titleStyle = "color:#007aff;font-weight:bolder"; //左边文本样式
				c.valueStyle = "color:#f70202;font-weight:bolder"; //右边文本样式
			}
		})
	}
	//上面的按钮选择事件(明细表弹出框)
	const detailExtraClick = (tableInfo, option, fields) => {
		//方式1：点击后可以给弹出框表单设置值
		details[0].edit.formFields.GoodsName = ~~(Math.random() * 100000)

		//方式2：点击按钮时，如果要跳转到其他页面选择数据，然后回写，请使用缓存
		// proxy.base.setItem('key',(res)=>{//key的名字自己定义，不能有重复的
		// 	//接收回写数据
		// 	  details[0].edit.formFields.GoodsName=res.GoodsName
		// });
		//在选择数据的页面调用上面的缓存
		//proxy.base.getItem('key')(参数);
	}
	//明细表弹出框日期、下拉框选择事件
	const detailOnChange = (field, value, optin, fields) => {
		proxy.$toast(field + '选择事件')
	}
	//明细表弹出框输入框回车事件
	const detailInputConfirm = (field, e, fields) => {
		proxy.$toast(field + '按了回车')
	}

	//如果是其他页面跳转过来的，获取页面跳转参数
	onLoad((ops) => {})

	//监听表单输入，做实时计算
	// watch(
	// 	() => editFormFields.字段,
	// 	(newValue, oldValue) => {
	// 	})
</script>
<style lang="less" scoped>

</style>