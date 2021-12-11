<template>
    <div>
        <!--导航区-->
        <Crumbs :cru="cru"></Crumbs>

        <!--卡片视图区-->
        <el-card class="box-card">
            <!--添加与查询-->
            <el-row :gutter="20">
                <el-col :span="6">
                    <el-input placeholder="请输入内容" clearable  v-model="queryInfo.query" class="input-with-select">
                        <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
                    </el-input>
                </el-col>
                <el-col :span="4">
                    <el-button type="primary" @click="add">新增</el-button>
                </el-col>
            </el-row>

            <!--数据表格-->
            <el-table :data="tableData" border style="width: 100%;margin-top: 10px;">
                <el-table-column
                        prop="create_time"
                        label="创建日期"
                        width="150">
                </el-table-column>
                <el-table-column
                        prop="title"
                        label="标题"
                        width="150">
                </el-table-column>
                <el-table-column
                        prop="sort"
                        label="排序"
                        width="150">
                </el-table-column>
                <el-table-column
                        prop="content"
                        label="内容">
                </el-table-column>
                <el-table-column label="操作"  width="150">
                    <template slot-scope="scope">
                        <el-button type="primary" size="mini" @click="edit(scope.row)">编辑</el-button>
                        <el-button type="danger" size="mini" @click="del(scope.row.id)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!--分页-->
            <Page :query="queryInfo" :total="total" :pages="pages" :pageSizes="pageSizes"></Page>
            <!--新增弹窗-->
            <el-dialog title="添加文章" :visible.sync="dialogFormVisible" >
                <el-form :model="saveform" :rules="saverules" ref="save">
                    <el-form-item label="文章标题" :label-width="formLabelWidth" prop="title">
                        <el-input v-model="saveform.title" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="文章排序" :label-width="formLabelWidth">
                        <el-input v-model="saveform.sort" type="number" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="文章状态" :label-width="formLabelWidth">
                        <el-radio v-model="saveform.status" :label="1">启用</el-radio>
                        <el-radio v-model="saveform.status" :label="0">禁用</el-radio>
                    </el-form-item>
                    <el-form-item label="文章内容" :label-width="formLabelWidth" prop="content">
                        <el-input v-model="saveform.content" autocomplete="off"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="saveAritcle">确 定</el-button>
                </div>
            </el-dialog>

            <!--编辑弹窗-->
            <el-dialog title="编辑文章" :visible.sync="editdialogFormVisible" >
                <Edit :editdialogFormVisible="editdialogFormVisible" :editforms="editforms" :formLabelWidth="formLabelWidth"></Edit>
            </el-dialog>
            <!--<el-form :model="editform" :rules="saverules" ref="save">-->
            <!--<el-form-item label="文章标题" :label-width="formLabelWidth" prop="title">-->
            <!--<el-input v-model="editform.title" autocomplete="off"></el-input>-->
            <!--</el-form-item>-->
            <!--<el-form-item label="文章排序" :label-width="formLabelWidth">-->
            <!--<el-input v-model="editform.sort" type="number" autocomplete="off"></el-input>-->
            <!--</el-form-item>-->
            <!--<el-form-item label="文章状态" :label-width="formLabelWidth">-->
            <!--<el-radio v-model="editform.status" :label="1">启用</el-radio>-->
            <!--<el-radio v-model="editform.status" :label="0">禁用</el-radio>-->
            <!--</el-form-item>-->
            <!--<el-form-item label="文章内容" :label-width="formLabelWidth" prop="content">-->
            <!--<el-input v-model="editform.content" autocomplete="off"></el-input>-->
            <!--</el-form-item>-->
            <!--</el-form>-->
            <!--<div slot="footer" class="dialog-footer">-->
            <!--<el-button @click="editdialogFormVisible = false">取 消</el-button>-->
            <!--<el-button type="primary" @click="editAritcle">确 定</el-button>-->
            <!--</div>-->


        </el-card>
    </div>
</template>

<script>
    import Page from '../common/Page'
    import Crumbs from '../common/Crumbs'
    import Edit from './Edit'
    export default {
        name: "List",
        components:{Page,Crumbs,Edit},
        created(){
            this.getUserList()
        },
        data(){
            return {
                // 分页搜索数据
                queryInfo:{
                    query:'',
                    page:1,
                    limit:5
                },
                pageSizes:[1,5,10,20],
                tableData: [],
                total:0,

                // 面包屑导航数据
                cru:['文章管理','文章列表'],

                dialogFormVisible:false,
                // 编辑
                editdialogFormVisible:false,
                formLabelWidth:'100px',
                editforms:{
                    id:0,
                    title:'',
                    content:'',
                    sort:1,
                    status:1
                },


                saveform:{
                    title:'',
                    content:'',
                    sort:1,
                    status:1
                },


                saverules: {
                    title: [
                        {required: true, message: '标题不能为空', trigger: 'blur'},
                    ],
                    content: [
                        {required: true, message: '内容不能为空', trigger: 'change'}
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
            search(){
                this.getUserList()
            },
            async getUserList(){
              const {data:res}=await this.$axios.get('api/aritcle/index',{params:this.queryInfo})
                this.tableData=res.data
                this.total=res.total
            },
            async del(id){
                const {data:res}=await this.$axios.get('api/aritcle/delete',{params:{id:id}})
                if(res.code!== 0){
                    this.$message.error(res.msg)
                }else{
                    this.$message.success('删除成功')
                    this.getUserList()
                }
            },
            add(){
                this.dialogFormVisible=true
            },
            saveAritcle(){
                this.$refs.save.validate(async valid=>{
                    if(!valid) return false
                    const {data:res}=await this.$axios.post('api/aritcle/save',this.saveform)
                    // console.log(res)
                    if(res.code!==0) return this.$message.error(res.msg)
                    this.$message.success('添加成功')
                    this.dialogFormVisible=false
                    this.saveform.title=''
                    this.saveform.content=''
                    this.$refs.save.resetFields()
                    this.getUserList()
                })
            },
            edit(info){
                this.editdialogFormVisible=true
                this.editform.id=info.id
                this.editform.title=info.title
                this.editform.content=info.content
                this.editform.sort=info.sort
                this.editform.status=info.status
            },
            async editAritcle(){
                    const {data:res}=await this.$axios.post('api/aritcle/edit',this.editform)
                    if(res.code!==0) return this.$message.error(res.msg)
                    this.$message.success('修改成功')
                    this.getUserList()
                    console.log(this.editform)

                    this.editdialogFormVisible=false
                    // console.log(this.editform)


            }
        },
    }
</script>

<style scoped>

</style>