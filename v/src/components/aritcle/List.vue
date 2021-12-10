<template>
    <div>
        <!--导航区-->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>文章管理</el-breadcrumb-item>
            <el-breadcrumb-item>文章列表</el-breadcrumb-item>
        </el-breadcrumb>
        <!--卡片视图区-->
        <el-card class="box-card">

            <el-row :gutter="20">
                <el-col :span="6">
                    <el-input placeholder="请输入内容" clearable  v-model="queryInfo.query" class="input-with-select">
                        <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
                    </el-input>
                </el-col>
                <el-col :span="4">
                    <el-button type="primary">新增</el-button>
                </el-col>
            </el-row>
            <el-table :data="tableData" border style="width: 100%;margin-top: 10px;">
                <el-table-column
                        prop="create_time"
                        label="创建日期"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="title"
                        label="标题"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="sort"
                        label="排序"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="content"
                        label="内容">
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button type="primary" size="mini">编辑</el-button>
                        <el-button type="danger" size="mini" @click="del(scope.row.id)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="currentPage"
                    :page-sizes="[1, 5, 10, 20]"
                    :page-size="queryInfo.limit"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="total" style="margin-top: 10px;">
            </el-pagination>
        </el-card>
    </div>
</template>

<script>
    export default {
        name: "List",
        created(){
            this.getUserList()
        },
        data(){
            return {
                queryInfo:{
                    query:'',
                    page:1,
                    limit:10
                },
                tableData: [],
                currentPage:1,
                total:0
            }
        },
        methods:{
            search(){
                this.getUserList()
            },
            handleCurrentChange(val){
                this.queryInfo.page=val
                this.getUserList()
            },
            handleSizeChange(val){
                this.queryInfo.limit=val
                this.getUserList()
            },
            async getUserList(){
              const {data:res}=await this.$axios.get('http://vtst.com/api/aritcle/index',{params:this.queryInfo})
                this.tableData=res.data
                this.total=res.total
            },
            async del(id){
                const {data:res}=await this.$axios.get('http://vtst.com/api/aritcle/delete',{params:{id:id}})
                if(res.code!== 0){
                    this.$message.error(res.msg)
                }else{
                    this.$message.success(res.msg)
                }
            }
        },
    }
</script>

<style scoped>

</style>