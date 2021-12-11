<template>
    <div>
        <!--导航区-->
        <Crumbs :cru="cru"></Crumbs>
        <!--卡片视图区-->
        <el-card class="box-card">

            <el-row :gutter="20">
                <el-col :span="6">
                    <el-input placeholder="请输入内容"  class="input-with-select">
                        <el-button slot="append" icon="el-icon-search"></el-button>
                    </el-input>
                </el-col>
                <el-col :span="4">
                    <el-button type="primary" @click="userSave">添加用户</el-button>
                </el-col>
            </el-row>

            <!--用户列表区-->
            <el-table :data="userInfo" border stripe style="margin-top: 10px;">
                <el-table-column prop="id"  label="ID"  width="150"></el-table-column>
                <el-table-column prop="username"  label="用户名" width="150"></el-table-column>
                <el-table-column prop="groupid"  label="角色" width="150"></el-table-column>
                <el-table-column label="状态" width="150" >
                    <template slot-scope="scope">
                        <!--{{scope.row}}-->
                        <el-switch
                                v-model="scope.row.status  "
                                active-color="#13ce66"
                                inactive-color="#ff4949">
                        </el-switch>
                    </template>
                </el-table-column>
                <el-table-column prop="create_time" label="创建时间"  ></el-table-column>
                <el-table-column label="操作" >
                    <template slot-scope="scope">
                        <el-button type="primary"  icon="el-icon-edit" @click="edit(scope.row)" circle></el-button>
                        <el-button type="danger" icon="el-icon-delete"  circle></el-button>
                        <el-button type="info" icon="el-icon-setting"  circle></el-button>
                    </template>
                </el-table-column>
            </el-table>

            <!--分页效果组件-->
            <Page :query="queryInfo" :total="total" :pages="pages" :pageSizes="pageSizes"></Page>


            <!--添加-->
            <el-dialog title="添加用户" :visible.sync="savedialogFormVisible">
                <el-form :model="userform" ref="saveForm" :rules="rules">
                    <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
                        <el-input v-model="userform.username" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="密 码" :label-width="formLabelWidth" prop="password">
                        <el-input type="password" v-model="userform.password" autocomplete="off" ></el-input>
                    </el-form-item>

                    <el-form-item label="角 色" :label-width="formLabelWidth">
                        <el-select v-model="userform.groupid" placeholder="请选择用户角色">
                            <el-option label="炒鸡管理员" :value="1"></el-option>
                            <el-option label="用户管理员" :value="2"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="用户状态" :label-width="formLabelWidth">
                        <el-radio v-model="userform.status" :label="1">启用</el-radio>
                        <el-radio v-model="userform.status" :label="0">禁用</el-radio>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="savedialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="save">确 定</el-button>
                </div>
            </el-dialog>
        </el-card>
    </div>
</template>

<script>
    import Page from '../common/Page'
    import Crumbs from '../common/Crumbs'
    export default {
        name: "Users",
        components:{Page,Crumbs},
        created(){
            this.getUserList()
        },
        data(){
            return {
                // 分页搜索数据
                total:1,
                pageSizes:[1,5,10,20],
                queryInfo:{
                    query:'',
                    page:1,
                    limit:5
                },
                // 面包屑导航数据
                cru:['用户管理','用户列表'],
                userform:{
                    username:'',
                    password:'',
                    // groupid:1,
                    status:1
                },
                userInfo:[],
                formLabelWidth:'100px',
                savedialogFormVisible:false,
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
        methods:{
            pages(info){
                this.queryInfo.limit=info.limit
                this.queryInfo.page=info.page
                this.getUserList()
            },
            userSave(){
                this.savedialogFormVisible=true
            },
            save(){
                this.$refs.saveForm.validate(async vild=>{
                    if(!vild) return false
                    const {data:res}=await this.$axios.post('api/user/save',this.userform)
                    if(res.code!==0) return this.$message.error(res.msg)
                    this.Success()
                })
              // console.log(this.userform)
            },
            Success(){
                this.$message.success('添加成功')
                this.userform.username=''
                this.userform.password=''
                this.userform.status=1
                this.$refs.saveForm.resetFields()
                this.getUserList()
                this.savedialogFormVisible=false
               },
            edit(info){
                console.log(info)
            },
            async getUserList(){
              const {data:res}=await this.$axios.get('api/user/index',{params:this.queryInfo})
                this.userInfo=res.data
                this.total=res.total
            }
        },
    }
</script>

<style scoped>

</style>