<template>
    <vol-box :lazy="true" v-model="model" title="选择客户" :width="1200" :padding="0">
        <div><customer ref="customerRef"></customer></div>
        <template #footer>
            <div> <el-button type="primary" @click="onSelect">确认</el-button></div>
        </template>
    </vol-box>
</template>
<script setup>
import { ref, getCurrentInstance, nextTick } from 'vue'
const { proxy } = getCurrentInstance();
/******注意：如果出现提示没有权限的问题，见后台开发文档上的【重写后台权限】*****/
//直接引用生成的页面(也可以单独用table配置，单独配置下见下面【编辑弹出框明细表选择数据】)
import customer from '@/views/mes/mes/MES_Customer.vue';
const customerRef = ref();
const model = ref(false)
//回调
const emit = defineEmits('onSelectCustom')
const open = () => {
    //打开主表选择数据
    model.value = true;
    //打开时刷新界面数据
    nextTick(() => { customerRef.value?.$refs.grid?.search()});
}
//选择数据
const onSelect = () => {
    //主表的选择数据回写到主表的表单上
    let rows = customerRef.value.$refs.grid.getSelectRows();
    if (!rows.length) {
        return proxy.$message.error('请选择数据');
    }
    model.value=false;
    emit('onSelectCustom', rows)
}
//暴露选择弹出框方法
defineExpose({open})
</script>
<style lang="less" scoped>
.search-form {
    display: flex;
    padding: 10px;
    line-height: 34px;
    button {
        margin-left: 10px;
    }
}
</style>