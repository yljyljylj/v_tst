<template>

        <el-container class="home_container">
            <!--头部-->
            <el-header>
                <div>
                    <img src="../assets/sss.png" alt="">
                    <span class="spa">test</span>
                </div>
                <el-button type="danger" @click="logout">退出</el-button>
            </el-header>
            <!--主体区-->
            <el-container>
                <!--侧边栏-->
                <el-aside :width="isCollapse ? '64px': '200px'">
                    <div class="toggle-button" @click="toggleCollapse">|||</div>
                    <el-menu
                            :default-active="defaultActive"
                            class="el-menu-vertical-demo"
                            @open="handleOpen"
                            @close="handleClose"
                            background-color="#333744"
                            text-color="#fff"
                            unique-opened
                            :collapse-transition="false"
                            :collapse="isCollapse"
                            router
                            active-text-color="#409EFF">
                        <!--一级菜单-->
                        <el-submenu :index="home.id + ''" v-for="home in homeList" :key="home.id">
                            <!--一级菜单模板区-->
                            <template slot="title">
                                <i :class="home.icon"></i>
                                <span style="margin-left: 10px;">{{home.authName}}</span>
                            </template>
                            <!--二级菜单-->
                            <el-menu-item  :index="'/'+item.path" v-for="item in home.children" :key="item.id" >
                                <template slot="title">
                                    <i :class="item.icon"></i>
                                    <span style="margin-left: 10px;">{{item.authName}}</span>
                                </template>
                            </el-menu-item>
                        </el-submenu>
                    </el-menu>

                </el-aside>
                <!--右侧主体区-->
                <el-main>
                    <router-view></router-view>


                </el-main>
            </el-container>
        </el-container>


</template>

<script>
    export default {
        name: "Home",
        created(){
            // this.getHomeList()
        },
        mounted(){
            this.getHomeList()
            this.defaultActive=this.$route.path
        },
        data() {
            return{
                homeList:[],
                isCollapse:false,
                defaultActive:''
            }
        },
        methods:{
            logout(){
                window.sessionStorage.clear();
                this.$router.push('/login')
            },
            handleOpen(){

            },
            handleClose(){

            },
            async getHomeList(){
                const {data:res}=await this.$axios.get('http://vtst.com/api/home/index')
                if(res.code!==0) return this.$message.error(res.msg)
                this.homeList=res.data
                // console.log(res)
            },
            //左边菜单折叠
            toggleCollapse(){
                this.isCollapse = !this.isCollapse
                // alert(111)
            },


        }
    }
</script>

<style scoped>
    .home_container{
        height: 100%;
    }
    .el-header{
        background-color:#373D41;
        display: flex;
        justify-content: space-between;
        padding-left: 0;
        align-items: center;
        color: #fff;
        font-size: 20px;
    }
    .el-menu{
        border-right: none;
    }
    .spa{
        position: absolute;
        top: 15px;
        padding-left: 10px;
    }
    .el-aside{
        background-color: #333744;
    }
    .el-main{
        background-color: #EAEDF1;
    }
    .toggle-button{
        background-color: #4A5064;
        font-size: 10px;
        line-height: 24px;
        color: white;
        text-align: center;
        letter-spacing: 0.2em;
        cursor: pointer;
    }

</style>