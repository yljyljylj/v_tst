import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login'
import Home from '../components/Home'
import Welcome from '../components/Welcome'
import Admin from '../components/admin/Admin'
import System from '../components/system/System'
import List from '../components/aritcle/List'
import Auth from '../components/auth/Auth'
import Roles from '../components/auth/Roles'


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
                path:'/admin',
                component:Admin
            },
            {
                path:'/auth',
                component:Auth
            },
            {
                path:'/roles',
                component:Roles
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
