import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './plugins/element.js'
import axios from 'axios'
import './assets/css/global.css'

// axios.defaults.baseUrl = 'http://vtst.com/api/'
axios.defaults.baseURL = '/index.php'
axios.defaults.withCredentials = true;
axios.defaults.responseType = 'json';
axios.interceptors.request.use(config=>{
  // console.log(config)
    config.headers.Authorization = window.sessionStorage.getItem('token')
    return config
})
Vue.prototype.$axios=axios

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
