<template>
    <div>
        <Crumbs :cru="cru"></Crumbs>
        <el-card>
            this is auth
            <el-table :data="authList" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column prop="title"  label="权限名称"></el-table-column>
                <el-table-column prop="path"  label="权限路径"></el-table-column>
                <el-table-column prop="type"  label="权限等級">
                    <template slot-scope="scope">
                        <el-tag type="success" v-if="scope.row.type===1 ">一級</el-tag>
                        <el-tag type="warning" v-if="scope.row.type===2 ">二級</el-tag>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>

    </div>
</template>

<script>
    import Crumbs from '../common/Crumbs'
    export default {
        name: "Auth",
        components:{Crumbs},
        data(){
            return{
                cru:['权限管理','权限列表'],
                authList:[]
            }
        },
        created(){
            this.getAuthList()
        },
        methods:{
            async getAuthList(){
                const {data:res}=await this.$axios.get('api/auth/index')
                if(res.code===0) return this.authList=res.data
            }
        }
    }
</script>

<style scoped>

</style>