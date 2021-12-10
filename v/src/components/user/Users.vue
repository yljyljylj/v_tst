<template>
    <div>
        <!--导航区-->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>活动管理</el-breadcrumb-item>
            <el-breadcrumb-item>活动列表</el-breadcrumb-item>
            <el-breadcrumb-item>活动详情</el-breadcrumb-item>
        </el-breadcrumb>
        <!--卡片视图区-->
        <el-card class="box-card">

            <el-row :gutter="20">
                <el-col :span="6">
                    <el-input placeholder="请输入内容"  class="input-with-select">
                        <el-button slot="append" icon="el-icon-search"></el-button>
                    </el-input>
                </el-col>
                <el-col :span="4">
                    <el-button type="primary">添加用户</el-button>
                </el-col>
            </el-row>
        </el-card>
    </div>
</template>

<script>
    export default {
        name: "Users",
        created(){
            // this.getUserList()
        },
        mounted(){
            this.getUserList()
        },
        data(){
            return {
                queryInfo:{
                    query:'',
                    pagenum:1,
                    pageSize:2
                }
            }
        },
        methods:{
            async getUserList(){
              const {data:res}=await this.$axios.get('http://vtst.com/api/user/index',{params:this.queryInfo})
            }
        },
    }
</script>

<style scoped>

</style>