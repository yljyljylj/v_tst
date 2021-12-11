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
                <el-table-column prop="id"  label="#"  width="150"></el-table-column>
                <el-table-column prop="username"  label="用户名" width="150"></el-table-column>
                <el-table-column prop="groupid"  label="角色" width="150"></el-table-column>
                <el-table-column label="状态" width="150" >
                    <template slot-scope="scope">
                        <el-button type="success" v-if="scope.row.status===1" size="mini" disabled>正常</el-button>
                        <el-button type="danger" v-if="scope.row.status!==1" size="mini" disabled>禁用</el-button>
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


            <!--添加弹窗-->
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

            <!--修改弹窗-->
            <el-dialog title="修改信息" :visible.sync="editdialogFormVisible">
                <el-form :model="editform" ref="saveForm" :rules="rules">
                    <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
                        <el-input v-model="editform.username" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="密 码" :label-width="formLabelWidth" prop="password">
                        <el-input type="password" v-model="editform.password" autocomplete="off" ></el-input>
                    </el-form-item>

                    <el-form-item label="角 色" :label-width="formLabelWidth">
                        <el-select v-model="editform.groupid" placeholder="请选择用户角色">
                            <el-option label="炒鸡管理员" :value="1"></el-option>
                            <el-option label="用户管理员" :value="2"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="用户状态" :label-width="formLabelWidth">
                        <el-radio v-model="editform.status" :label="1">启用</el-radio>
                        <el-radio v-model="editform.status" :label="0">禁用</el-radio>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="editdialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="edits">确 定</el-button>
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
                // 列表数据
                userInfo:[],
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

                // 添加
                userform:{
                    username:'',
                    password:'',
                    // groupid:1,
                    status:1
                },
                savedialogFormVisible:false,
                formLabelWidth:'100px',

                // 修改
                editform:{},
                editdialogFormVisible:false,


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
            //分页
            pages(info){
                this.queryInfo.limit=info.limit
                this.queryInfo.page=info.page
                this.getUserList()
            },

            // 添加
            userSave(){
                this.savedialogFormVisible=true
            },
            save(){
                this.$refs.saveForm.validate(async vild=>{
                    if(!vild) return false
                    const {data:res}=await this.$axios.post('api/user/save',this.userform)
                    if(res.code!==0) return this.$message.error(res.msg)
                    this.$message.success('添加成功')
                    this.userform.username=''
                    this.userform.password=''
                    this.userform.status=1
                    this.getUserList()
                    this.$refs.saveForm.resetFields()
                    this.savedialogFormVisible=false
                })
            },

            // 修改
            edit(info){
                this.editdialogFormVisible=true
                this.editform=info
            },
            async edits(){
                // console.log(this.editform)
                const {data:res}=await this.$axios.post('api/user/edit',this.editform)
                if(res.code!==0) return this.$message.error('修改失败')
                this.$message.success('修改成功')
                this.editform={}
                this.editdialogFormVisible=false
                this.getUserList()
            },


            async getUserList(){
              const {data:res}=await this.$axios.get('api/user/index',{params:this.queryInfo})
                this.userInfo=res.data
                this.total=res.total
            },


        },
    }
</script>

<style scoped>

</style>