<template>
    <div>
        <!--导航区-->
        <Crumbs :cru="cru"></Crumbs>
        <!--卡片视图区-->
        <el-card class="box-card">
            <!--添加查询-->
            <el-row :gutter="20">
                <!--查询-->
                <Search :queryInfo="queryInfo" :search="search"></Search>
                <el-col :span="4">
                    <el-button type="primary" @click="add_dialog=true">添加用户</el-button>
                </el-col>
            </el-row>

            <!--用户列表区-->
            <el-table :data="userInfo" border stripe style="margin-top: 10px;">
                <el-table-column type="index" label="#" width="50"></el-table-column>
                <el-table-column prop="username"  label="用户名" width="150"></el-table-column>
                <el-table-column prop="groupid"  label="角色" width="150"></el-table-column>
                <el-table-column label="状态" width="150" >
                    <template slot-scope="scope">
                        <el-switch
                                v-if="scope.row.groupid!=1"
                                v-model="scope.row.status"
                                :active-value="1" :inactive-value="0"
                                @change="editStatus(scope.row)"
                                active-color="#13ce66"
                                inactive-color="#ff4949">
                        </el-switch>
                    </template>
                </el-table-column>
                <el-table-column prop="create_time" label="创建时间"  ></el-table-column>
                <el-table-column label="操作" width="150" >
                    <template slot-scope="scope">
                        <el-button type="primary"  icon="el-icon-edit" @click="edit(scope.row)" circle></el-button>
                        <el-button v-if="scope.row.groupid!=1" type="danger" icon="el-icon-delete" @click="userdelete(scope.row.id)" circle></el-button>
                    </template>
                </el-table-column>
            </el-table>

            <!--分页效果组件-->
            <Page :query="queryInfo" :total="total" :pages="pages" :pageSizes="pageSizes"></Page>


            <!--添加弹窗-->
            <Addform v-if="add_dialog" :add_dialog="add_dialog" :form="addform" @closeDialog="closeDialogFunc($event, 'add')"></Addform>
            <!--修改弹窗-->
            <Editform v-if="edit_dialog" :edit_dialog="edit_dialog" :form="editform" @closeDialog="closeDialogFunc($event, 'edit')"></Editform>


        </el-card>
    </div>
</template>

<script>
    import Page from '../common/Page'
    import Crumbs from '../common/Crumbs'
    import Search from '../common/Search'
    import Addform from '../../views/admin/Addform'
    import Editform from '../../views/admin/Editform'
    export default {
        name: "Users",
        components:{Page,Crumbs,Search,Addform,Editform},
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
                addform:{status:1},
                add_dialog:false,
                // 修改
                editform:{},
                edit_dialog:false,
            }
        },
        methods:{
            // 模糊查询
            search(query){
                this.queryInfo.query=query
                this.getUserList()
            },
            //分页
            pages(info){
                this.queryInfo.limit=info.limit
                this.queryInfo.page=info.page
                this.getUserList()
            },
            //回调
            closeDialogFunc(e, f) {
                if (f == 'add') {
                    this.add_dialog = e.openDialog;
                    this.addform={status:1}
                    if (e.type == 'success') {
                        this.getUserList();
                    }
                }
                if (f == 'edit') {
                    this.edit_dialog = e.openDialog;
                    if (e.type == 'success') {
                        this.getUserList();
                    }
                }
            },
            // 修改
            edit(info){
                this.edit_dialog=true
                this.editform=info
            },
            //修改状态
            async editStatus(info){
                const {data: res} = await this.$axios.get("/api/admin/editStatus", {
                    params: {
                        id: info.id,
                        status: info.status
                    }
                });
                if(res.code!==0){
                    info.status=!info.status
                    return this.$message.error('更新状态失敗')
                }
                this.$message.success('更新状态成功')
            },
            //删除
            async userdelete(id){
                if(confirm('确定要删除吗？')){
                    const {data:res}=await this.$axios.get('api/admin/delete',{params:{id:id}})
                        if(res.code!==0) return this.$message.error(res.msg)
                        this.$message.success('删除成功')
                        this.getUserList()
                }else{
                    return false
                }
            },

            async getUserList(){
              const {data:res}=await this.$axios.get('api/admin/index',{params:this.queryInfo})
                this.userInfo=res.data
                this.total=res.total
            },

        },
    }
</script>

<style scoped>

</style>