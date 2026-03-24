/*****************************************************************************************
 **  Author:jxx 2022
 **  QQ:283591387
 **完整文档见：http://v2.volcore.xyz/document/api 【代码生成页面ViewGrid】
 **常用示例见：http://v2.volcore.xyz/document/vueDev
 **后台操作见：http://v2.volcore.xyz/document/netCoreDev
 *****************************************************************************************/
//此js文件是用来自定义扩展业务代码，可以扩展一些自定义页面或者重新配置生成的代码

import modelHeader from './orderModelHeader'
let extension = {
  components: {
    //查询界面扩展组件
    gridHeader: '',
    //自定义列表页面
    gridBody: '',
    gridFooter: '',
    //新建、编辑弹出框扩展组件
    modelHeader: modelHeader,
    modelBody: '',
    modelFooter: ''
  },
  text: '', //界面上的提示文字
  tableAction: '', //指定某张表的权限(这里填写表名,默认不用填写)
  buttons: { view: [], box: [], detail: [] }, //扩展的按钮
  methods: {
    searchAfter(rows) {
      return true
    },
    //下面这些方法可以保留也可以删除
    onInit() {
      // console.log('oninit')
      // //设置表格筛选
      // this.maxBtnLength = 5
      // this.queryFields = ['CreateDate']
    },
    onInited() {
     
    },
    saveConfirm(callback,formData,isAdd){
      callback()
    }
  }
}
export default extension
