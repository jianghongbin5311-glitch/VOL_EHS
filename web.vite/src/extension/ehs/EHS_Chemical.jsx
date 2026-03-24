let extension = {
  components: { gridHeader:'',gridBody:'',gridFooter:'',modelHeader:'',modelBody:'',modelRight:'',modelFooter:'' },
  tableAction: '',
  buttons: { view: [], box: [], detail: [] },
  methods: {
    onInit() {},
    onInited() {},
    searchBefore(param) { return true; },
    searchAfter(result) { return true; },
    addBefore(formData) { return true; },
    updateBefore(formData) { return true; },
    rowClick({ row, column, event }) {},
    modelOpenAfter(row) {}
  }
};
export default extension;
