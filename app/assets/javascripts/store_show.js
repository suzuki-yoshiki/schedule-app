import Vue from "vue";

const vm = new Vue({
  el: "#app",
  data: {
    show: {}
  },
  methods: {
    toggle: function (key) {
      this.$set(this.show , key, !this.show[key])
    }
  }
});