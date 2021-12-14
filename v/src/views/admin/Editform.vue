<template>
    <el-dialog title="修改信息" :visible.sync="dialogVisible">
        <el-form :model="form" ref="editFormRef">
            <el-form-item label="用户名" :label-width="formLabelWidth" prop="username"
                          :rules="[{ required: true, message: '用户名称不能为空'},]">
                <el-input v-model="form.username" autocomplete="off" ></el-input>
            </el-form-item>
            <el-form-item label="密 码" :label-width="formLabelWidth" prop="password"
                          :rules="[{ required: true, message: '用户密码不能为空'},]">
                <el-input type="password" v-model="form.password" autocomplete="off" pr></el-input>
            </el-form-item>

            <el-form-item v-if="form.groupid!=1" label="角 色" :label-width="formLabelWidth">
                <el-select v-model="form.groupid" placeholder="请选择用户角色">
                    <el-option v-for=" list in groupList" :label="list.name" :value="list.id"></el-option>
                </el-select>
            </el-form-item>
            <!--<el-form-item label="用户状态" :label-width="formLabelWidth">-->
                <!--<el-radio v-model="form.status" :label="1">启用</el-radio>-->
                <!--<el-radio v-model="form.status" :label="0">禁用</el-radio>-->
            <!--</el-form-item>-->
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="resetEditDialog(false)">取 消</el-button>
            <el-button type="primary" @click="editAdmin">确 定</el-button>
        </div>
    </el-dialog>
</template>

<script>
    export default {
        name: "Editform",
        props:['edit_dialog','form'],
        created(){
            this.getList()
        },
        data(){
            return{
                dialogVisible:this.edit_dialog,
                formLabelWidth: '180px',
                groupList:[]
            }
        },
        methods:{
            async getList(){
                const {data:res}=await this.$axios.get('api/admin/getList')
                this.groupList=res.data
                // console.log(this.groupList)
            },
            async editAdmin(){
                console.log(this.form)
                const {data:res}=await this.$axios.post('api/admin/edit',this.form)
                if(res.code!==0) return this.$message.error('修改失败')
                this.$message.success('修改成功')
                this.resetEditDialog(true)
            },
            resetEditDialog(e){
                if (e) {
                    this.$emit('closeDialog', {
                        type: 'success',
                        openDialog: false
                    })
                } else {
                    this.$emit('closeDialog', {
                        type: 'error',
                        openDialog: false
                    })
                }
            }
        }
    }
</script>

<style scoped>

</style>