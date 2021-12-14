<template>
    <div>
        <Crumbs :cru="cru"></Crumbs>
        <el-card>
            <!--添加角色-->
            <el-row>
                <el-col>
                    <el-button type="primary" @click="add_dialog = true">添加角色</el-button>
                </el-col>
            </el-row>
            <!--渲染数据-->
            <el-table :data="rulesList" border stripe style="width: 100%;margin-top: 10px;">
                <el-table-column type="index" label="#" width="50"></el-table-column>
                <el-table-column prop="name" label="角色名称" width="180"></el-table-column>
                <el-table-column prop="title" label="角色描述"></el-table-column>
                <el-table-column label="状态"  width="180">
                        <template slot-scope="scope">
                            <el-switch
                                    v-if="scope.row.id!=1"
                                    v-model="scope.row.status"
                                    :active-value="1" :inactive-value="0"
                                    @change="editStatus(scope.row)"
                                    active-color="#13ce66"
                                    inactive-color="#ff4949">
                            </el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="300">
                    <template slot-scope="scope">
                        <el-button type="primary" icon="el-icon-edit" size="mini" @click="editDialog(scope.row)" >编辑</el-button>
                        <el-button type="danger" icon="el-icon-delete" size="mini" @click="delRule(scope.row.id)" >删除</el-button>
                        <el-button type="warning" icon="el-icon-setting" size="mini" >分配权限</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <!--添加数据-->
            <Addform v-if="add_dialog" :add_dialog="add_dialog" @closeDialog="closeDialogFunc($event, 'add')" :form="addform" ></Addform>
            <!--//修改数据-->
            <Editform v-if="edit_dialog" :edit_dialog="edit_dialog" @closeDialog="closeDialogFunc($event, 'edit')" :form="editform"></Editform>


        </el-card>
    </div>
</template>

<script>
    import Crumbs from '../common/Crumbs'
    import Addform from '../../views/auth/Addform'
    import Editform from '../../views/auth/Editform'
    export default {
        name: "Roles",
        components:{Crumbs,Addform,Editform},
        created(){
            this.getRulesList()
        },
        data(){
            return{
                cru:['权限管理','角色列表'],
                rulesList:[],
                formLabelWidth:'140px',
                //添加
                add_dialog:false,
                addform:{status:1},
                //编辑
                edit_dialog:false,
                editform:{},

                list:{}
            }
        },
        methods:{
            //获取对应权限列表
            async getList(id){
                // console.log(info)
                this.list={}
                const {data:res}=await this.$axios.get('api/auth/list',{params:{id:info.id}})
                if(res.code===0) this.list=res.data
                console.log(this.list)
            },
            async getRulesList(){
                const {data:res}=await this.$axios.get('api/auth/rules')
                this.rulesList=res.data
            },
            //回调
            closeDialogFunc(e, f) {
                if (f == 'add') {
                    this.add_dialog = e.openDialog;
                    this.addform={status:1}
                    if (e.type == 'success') {
                        this.getRulesList();
                    }
                }
                if (f == 'edit') {
                    this.edit_dialog = e.openDialog;
                    if (e.type == 'success') {
                        this.getRulesList();
                    }
                }
            },
            editDialog(row){
                this.edit_dialog = true
                this.editform=row
            },
            //修改状态
            async editStatus(status){
                const {data:res}=await this.$axios.get('api/auth/editStatus',{params:{id:status.id,status:status.status}})
                if(res.code!==0){
                    status.status==1 ? status.status=0:status.status=1
                    return this.$message.error('修改状态失败')
                }
                this.$message.success('修改状态成功')
            },
            delRule(id){
                this.$confirm('此操作将永久删除该角色, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.get('api/auth/delRule',{params:{id:id}}).then(response => {
                            if(response.data.code!==0){
                                return this.$message.error('删除角色失败')
                            }
                            this.$message.success('删除角色成功')
                        this.getRulesList()
                        },
                        error => {
                            console.log('请求失败了',error.message)
                        })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            }
        }
    }
</script>

<style scoped>

</style>