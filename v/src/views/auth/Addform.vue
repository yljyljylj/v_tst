<template>
    <el-dialog title="新增角色" :visible.sync="dialogVisible">
        <el-form :model="form">
            <el-form-item label="角色名称" :label-width="formLabelWidth"
                          prop="name"
                          :rules="[{ required: true, message: '角色名称不能为空'},]">
                <el-input v-model.trim="form.name" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="角色状态" :label-width="formLabelWidth">
                <el-radio v-model="form.status" :label="1">开启</el-radio>
                <el-radio v-model="form.status" :label="0">禁用</el-radio>
            </el-form-item>
            <el-form-item label="角色描述" :label-width="formLabelWidth">
                <el-input type="textarea" v-model="form.title"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="resetAddDialog(false)">取 消</el-button>
            <el-button type="primary" @click="addRules">确 定</el-button>
        </div>
    </el-dialog>
</template>

<script>
    export default {
        name: "Addform",
        props:['add_dialog','form'],
        data(){
            return{
                /*左边长度*/
                formLabelWidth: '180px',
                /*是否显示*/
                dialogVisible: this.add_dialog,
            }
        },
        methods:{
            async addRules() {
                if(this.form.name=='' || this.form.name==null || this.form.name==undefined) return this.$message.error('角色名称不能为空')
                const {data:res}=await this.$axios.post('api/auth/add',this.form)
                if(res.code!==0) return this.$message.error('添加失败')
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