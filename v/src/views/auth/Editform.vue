<template>
        <el-dialog title="新增角色" :visible.sync="dialogVisible">
            <el-form :model="form">
                <el-form-item label="角色名称" :label-width="formLabelWidth"
                prop="name"
                :rules="[{ required: true, message: '角色名称不能为空'},]">
                <el-input v-model.trim="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="角色描述" :label-width="formLabelWidth"
                prop="title"
                :rules="[]">
                <el-input type="textarea" v-model="form.title"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="resetEditDialog(false)">取 消</el-button>
                <el-button type="primary" @click="editRules">确 定</el-button>
            </div>
        </el-dialog>
</template>

<script>
    export default {
        name: "Editform",
        props:['edit_dialog','form'],
        data(){
            return{
                dialogVisible:this.edit_dialog,
                formLabelWidth: '180px',
            }
        },
        methods:{
            async editRules(){
                if(this.form.name=='' || this.form.name==null || this.form.name==undefined) return this.$message.error('角色名称不能为空')
                const {data:res}=await this.$axios.get('api/auth/edit',{params:this.form})
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