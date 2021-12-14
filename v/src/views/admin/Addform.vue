<template>
    <div>
        <el-dialog title="添加用户" :visible.sync="dialogVisible">
            <el-form :model="form" ref="saveForm">
                <el-form-item label="用户名" :label-width="formLabelWidth" prop="username"
                              :rules="[{ required: true, message: '用户名称不能为空'},]">
                    <el-input v-model.trim="form.username" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="密 码" :label-width="formLabelWidth" prop="password"
                              :rules="[{ required: true, message: '用户密码不能为空'},]">
                    <el-input type="password" v-model.trim="form.password" autocomplete="off" ></el-input>
                </el-form-item>

                <el-form-item label="角 色" :label-width="formLabelWidth">
                    <el-select v-model="form.groupid" placeholder="请选择用户角色">
                        <el-option v-for="list in groupList" :label="list.name" v-if="list.rules!='#'" :value="list.id" :key="list.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="用户状态" :label-width="formLabelWidth">
                    <el-radio v-model="form.status" :label="1">启用</el-radio>
                    <el-radio v-model="form.status" :label="0">禁用</el-radio>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="resetAddDialog(false)">取 消</el-button>
                <el-button type="primary" @click="addAdmin">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "Addform",
        props:['add_dialog','form'],
        created(){
            this.getList()
        },
        data(){
            return{
                dialogVisible:this.add_dialog,
                formLabelWidth: '180px',
                groupList:[]
            }
        },
        methods:{
            async getList(){
                const {data:res}=await this.$axios.get('api/admin/getList')
                this.groupList=res.data
            },
            async addAdmin(){
                if(this.form.username=='' || this.form.username==null || this.form.username==undefined) return this.$message.error('角色名称不能为空')
                if(this.form.password=='' || this.form.password==null || this.form.password==undefined) return this.$message.error('角色密码不能为空')
                const {data:res}=await this.$axios.post('api/admin/add',this.form)
                if(res.code!==0) return this.$message.error(res.msg)
                this.$message.success('添加成功')
                this.resetAddDialog(true)
            },
            resetAddDialog(e){
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