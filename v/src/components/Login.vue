<template>
    <div class="login">
    <el-form ref="form" :model="loginForm" :rules="rules" label-width="80px" class="login_from">
        <el-form-item label="账 号" prop="username">
            <el-input v-model="loginForm.username" prefix-icon="el-icon-user"></el-input>
        </el-form-item>

        <el-form-item label="密 码" prop="password">
            <el-input type="password" v-model="loginForm.password" prefix-icon="el-icon-lock"></el-input>
        </el-form-item>

        <el-form-item>
            <el-button type="primary" @click="onSubmit">登陆</el-button>
            <el-button type="info" @click="reset">重置</el-button>
        </el-form-item>
    </el-form>
    </div>
</template>
<script>
    export default {
        name:'Login',
        data() {
            return {
                loginForm: {
                    username: '',
                    password: ''
                },
                rules: {
                    username: [
                        {required: true, message: '请输入账号', trigger: 'blur'},
                    ],
                    password: [
                        {required: true, message: '请输入密码', trigger: 'change'}
                    ],
                }
            }
        },
        methods: {
            onSubmit() {
                this.$refs.form.validate(async valid=>{
                    if(!valid) return
                        const {data:res}=await this.$axios.post('http://vtst.com/api/login/login',this.loginForm)
                        if(res.code !==0){
                            return  this.$message.error(res.msg)
                        }
                        this.$message.success('验证成功')
                    // console.log(res)
                        window.sessionStorage.setItem('token',res.data.token)
                        this.$router.push('/home')

                })

            },
            reset(){
                this.$refs.form.resetFields()
            }
        }
    }
</script>
<style scoped>
    .login{
        background-color: #6897BB;
        height: 100%;
    }
    .login_from{
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
    }
</style>