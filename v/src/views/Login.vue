<template>
<el-form ref="form" :model="loginForm" label-width="80px" style="text-align: center;margin-top: 25%;width: 50%;margin-left: 25%;">
    <el-form-item label="用户名">
        <el-input v-model="loginForm.username"></el-input>
    </el-form-item>
    <el-form-item label="密码">
        <el-input type="password" v-model="loginForm.password"></el-input>
    </el-form-item>


    <el-form-item>
        <el-button type="primary" @click="onSubmit">登陆</el-button>
        <el-button>取消</el-button>
    </el-form-item>
</el-form>
</template>
<script>
    export default {
        data() {
            return {
                loginForm: {
                    username: '',
                    password:''
                }
            }
        },
        methods: {
            onSubmit() {
                this.$axios.post('http://vtst.com/api/login/login',this.loginForm).then(success=>{
                    console.log(success)
                })
                // console.log(this.$axios);
            }
        }
    }
</script>