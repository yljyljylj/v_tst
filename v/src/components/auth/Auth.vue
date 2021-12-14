<template>
    <div>
        <Crumbs :cru="cru"></Crumbs>
        <el-card>
            <el-row :gutter="20">
                <!--查询-->
                <Search :queryInfo="queryInfo" :search="search"></Search>
                <!--<el-col :span="4">-->
                    <!--<el-button type="primary" @click="add_dialog=true">添加规则</el-button>-->
                <!--</el-col>-->
            </el-row>
            <el-table :data="authList" border stripe style="margin-top: 10px;">
                <el-table-column type="index"></el-table-column>
                <el-table-column prop="title"  label="权限名称"></el-table-column>
                <el-table-column prop="path"  label="权限路径"></el-table-column>
                <el-table-column prop="level"  label="权限等級">
                    <template slot-scope="scope">
                        <el-tag type="primary" v-if="scope.row.level===0 ">一級</el-tag>
                        <el-tag type="success" v-if="scope.row.level===1 ">二級</el-tag>
                        <el-tag type="warning" v-if="scope.row.level===2 ">三級</el-tag>
                    </template>
                </el-table-column>
            </el-table>

            <Addform v-if="add_dialog" :add_dialog="add_dialog" :form="addform" @closeDialog="closeDialogFunc($event, 'add')"></Addform>
        </el-card>

    </div>
</template>

<script>
    import Crumbs from '../common/Crumbs'
    import Search from '../common/Search'
    import Addform from '../../views/rules/Addform'
    export default {
        name: "Auth",
        components:{Crumbs,Search,Addform},
        data(){
            return{
                cru:['权限管理','权限列表'],
                authList:[],
                queryInfo:{
                    query:'',
                    page:1,
                    limit:100
                },
                add_dialog:false,
                addform:{status:1,pid:0}
            }
        },
        created(){
            this.getAuthList()
        },
        methods:{
            search(query){
                this.queryInfo.query=query
                this.getAuthList()
            },
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
            async getAuthList(){
                const {data:res}=await this.$axios.get('api/auth/index',{params:this.queryInfo})
                if(res.code===0) return this.authList=res.data
            },
        }
    }
</script>

<style scoped>

</style>