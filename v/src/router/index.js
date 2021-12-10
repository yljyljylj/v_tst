import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login'
import Home from '../components/Home'
import Welcome from '../components/Welcome'
import Users from '../components/user/Users'
import System from '../components/system/System'
import List from '../components/aritcle/List'


Vue.use(VueRouter)

const routes = [
    {
      path:'/',
      redirect:'/login'
    },
    {
      path:'/login',
      component:Login
    },
    {
        path:'/home',
        component:Home,
        redirect:'/welcome',
        children:[
            {
                path:'/welcome',
                component:Welcome
            },
            {
                path:'/users',
                component:Users
            },
            {
                path:'/list',
                component:List
            },
            {
                path:'/system',
                component:System
            }
        ]
    }
]

const router = new VueRouter({
  routes
})

router.beforeEach((to,from,next)=>{
    if(to.path==='/login') return next()
    const token=window.sessionStorage.getItem('token')
    if(!token) return next('/login')
    next()
})

export default router
