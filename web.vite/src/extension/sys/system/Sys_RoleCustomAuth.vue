<template>
  <vol-box v-model="model" :padding="15" :title="title" :width="610">
    <el-alert
      style="margin-bottom: 5px"
      :title="$ts('指定自定义值、用户、角色、部门数据权限过滤')"
      class="alert-primary"
      :closable="false"
    ></el-alert>
    <el-radio-group v-model="radioValue" style="margin-bottom: 10px">
      <!-- <el-radio :value="0" :label="$ts('自定义值')"></el-radio>
      <el-radio :value="1" :label="$ts('当前用户')"></el-radio>
      <el-radio :value="2" :label="$ts('当前角色')"></el-radio>
      <el-radio :value="3" :label="$ts('当前部门')"></el-radio> -->
      <el-radio
        :value="item.value"
        :label="$ts(item.label)"
        v-for="(item, index) in radioData"
        :key="index"
      ></el-radio>
      <el-button type="primary" @click="addClick" size="small" plain>+ {{ $ts('添加') }}</el-button>
    </el-radio-group>
    <div style="min-height: 250px">
      <div class="field-item fx" v-for="(item, index) in filters" :key="index">
        <!-- <div>{{ $ts("字段") }}：</div> -->
        <label style="margin-right: 8px">{{ index + 1 }}. </label>
        <el-select
          style="width: 150px"
          @change="
            (field) => {
              fieldChange(field, index)
            }
          "
          v-model="item.field"
          :placeholder="$ts('请选择字段')"
        >
          <el-option
            v-for="data in fieldsOptions"
            :key="data.field"
            :label="data.title"
            :value="data.field"
          />
        </el-select>
        <!-- <label>{{ $ts("条件") }}：</label> -->
        <el-select
          style="width: 120px; margin: 0 10px"
          v-model="item.filterType"
          :placeholder="$ts('请选择条件')"
        >
          <el-option
            v-for="data in filterType"
            :key="data.value"
            :label="data.name"
            :value="data.value"
          />
        </el-select>
        <!-- <label>{{ $ts("过滤值") }}：</label> -->
        <div style="width: 250px">
          <div v-if="item.valueType > 0">
            {{ $ts(getValueText(item)) }}
          </div>
          <el-select
            v-else-if="item.data"
            multiple
            v-model="item.value"
            :placeholder="$ts('请选择')"
          >
            <el-option
              v-for="data in getDicData(item)"
              :key="data.key"
              :label="data.value"
              :value="data.key"
            />
          </el-select>
          <el-input-number
            v-else-if="item.type == 'int' || item.type == 'number' || item.type == 'decimal'"
            v-model="item.value"
            :placeholder="$ts('请输入值')"
            controls-position="right"
          />

          <el-date-picker
            v-else-if="['date', 'datetime', 'month', 'year'].indexOf(item.type) != -1"
            clearable
            v-model="item.value"
            :type="item.type"
            :placeholder="$ts('请选择')"
            :value-format="getDateFormat(item)"
          >
          </el-date-picker>
          <el-input
            v-else
            :placeholder="$ts('请输入值,多值以逗号隔开')"
            v-model="item.value"
          ></el-input>
        </div>
        <el-button @click="delItem(index)" link icon="Delete" style="margin-left: 10px"></el-button>
      </div>
    </div>
    <template #footer
      ><div class="btns">
        <el-button type="default" size="small" icon="Close" @click="model = false">{{
          $ts('关闭')
        }}</el-button>
        <el-button type="primary" plain size="small" icon="Check" @click="save">{{
          $ts('确定')
        }}</el-button>
      </div>
    </template>
  </vol-box>
</template>
<script setup>
import { getDateFormat } from '@/components/basic/VolForm/VolFormDate.js'
import { ref, getCurrentInstance, computed } from 'vue'
const { proxy } = getCurrentInstance()
const radioValue = ref(0)

const radioData = ref([
  {
    value: 0,
    label: '自定义值'
  },
  {
    value: 1,
    label: '当前用户'
  },
  {
    value: 2,
    label: '当前角色'
  },
  {
    value: 3,
    label: '当前部门'
  }
])

const title = ref('')
const fieldsOptions = ref([])

const filters = ref([{ valueType: '', field: '', value: null, data: null }])

const model = ref(false)
let tableName = ''

const dicInfo = ref([])
const getDic = () => {
  const keys = fieldsOptions.value
    .filter((x) => {
      return x.key
    })
    .map((x) => {
      return x.key
    })
  if (!keys.length) {
    return
  }
  proxy.http.post('api/Sys_Dictionary/GetVueDictionary', keys, false).then((x) => {
    dicInfo.value = x
  })
}

const getFields = async (item) => {
  const url = `api/role/getFields?menuId=${item.id}&roleId=${item.Role_Id}`
  await proxy.http.post(url, {}, false).then((x) => {
    fieldsOptions.value = x
  })
}
let menuId = 0
const currentItem = ref({})
const open = async (id, item) => {
  radioValue.value=0;
  currentItem.value = item
  if (
    item.authMenuData &&
    typeof item.authMenuData == 'string' &&
    item.authMenuData.indexOf(',') != -1
  ) {
    filters.value = JSON.parse(item.authMenuData)
  } else {
    filters.value = [{ valueType: '', field: '', value: null, data: null }]
  }
  title.value = proxy.$ts('自定义数据权限') + '(' + proxy.$ts(item.text) + ')'
  model.value = true
  if (menuId == id) {
    return
  }
  menuId = id
  await getFields(item)
  getDic()
}
// open();

const getDicData = (item) => {
  item = fieldsOptions.value.find((x) => {
    return item.field == x.field
  })
  if (!item || !item.key) {
    return []
  }
  const dicItem = dicInfo.value.find((x) => {
    return x.dicNo == item.key
  })
  if (!dicItem) {
    return []
  }
  return dicItem.data
}

const getValueText = (item) => {
  let data =
    radioData.value.find((c) => {
      return c.value == item.valueType
    }) || {}
  return data.label
}

const filterType = ref([
  { name: '等于(=)', value: '=' },
  { name: '不等于(!=)', value: '!=' },
  { name: '大于(>)', value: '>' },
  { name: '大于等于(>=)', value: '>=' },
  { name: '小于(<)', value: '<' },
  { name: '小于等于(<=)', value: '<=' },
  { name: '包括(in)', value: 'in' },
  // { name: "不包括(not in)", value: "notin" },
  { name: '模糊匹配(like)', value: 'like' },
  { name: '或者(or)', value: 'or' }
])

const fieldChange = (field, index) => {
  let option = fieldsOptions.value.find((x) => {
    return x.field == field
  })
  filters.value[index].type = option.type
  filters.value[index].field = option.field
  filters.value[index].value = option.key ? [] : null
  filters.value[index].data = option.key ? [] : null
}

const addClick = () => {
  filters.value.push({ filterType: null, valueType: radioValue.value, value: null })
}

const delItem = (index) => {
  filters.value.splice(index, 1)
}

const save = () => {
  const list= filters.value.filter(x=>{return x.field||x.value||x.valueType})
  let index = list.findIndex((x) => {
    return !x.field
  })
  if (index != -1) {
    proxy.$message.error(proxy.$ts(`请选择第${index + 1}行的字段`))
    return
  }
  index = list.findIndex((x) => {
    return !x.value && !x.valueType
  })
  if (index != -1) {
    proxy.$message.error(proxy.$ts(`请输入第${index + 1}行的值`))
    return
  }
  currentItem.value.authMenuData = JSON.stringify(list)
  model.value = false
}

defineExpose({
  open
})
</script>
<style scoped lang="less">
.fx {
  display: flex;
  align-items: center;
  label {
    display: inline-block;
    margin-left: 10px;
    font-size: 13px;
    color: #000;
  }
  label:first-child {
    margin-left: 0;
  }
}
.field-item {
  margin-bottom: 10px;
}
.btns {
  text-align: center;
}
</style>
