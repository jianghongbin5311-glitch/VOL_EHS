<template>
    <view-grid ref="grid" :columns="columns" :detail="detail" :details="details"
               :editFormFields="editFormFields" :editFormOptions="editFormOptions"
               :searchFormFields="searchFormFields" :searchFormOptions="searchFormOptions"
               :table="table" :extend="extend" :onInit="onInit" :onInited="onInited"
               :searchBefore="searchBefore" :addBefore="addBefore" :updateBefore="updateBefore">
        <template #gridHeader>
            <EhsMobileQrCode />
        </template>
    </view-grid>
</template>
<script setup lang="jsx">
    import extend from "@/extension/ehs/EHS_Accident.jsx";
    import viewOptions from './EHS_Accident/options.js'
    import EhsMobileQrCode from '@/components/ehs/EhsMobileQrCode.vue'
    import { ref, reactive, getCurrentInstance } from "vue";
    const grid = ref(null);
    const { proxy } = getCurrentInstance()
    const { table, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details } = reactive(viewOptions())
    let gridRef;
    const onInit = async ($vm) => { gridRef = $vm; }
    const onInited = async () => { }
    const searchBefore = async (param) => { return true; }
    const addBefore = async (formData) => { return true; }
    const updateBefore = async (formData) => { return true; }
    defineExpose({})
</script>
