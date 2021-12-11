<template>
    <div>
            <el-form :model="editform" ref="save">
                <el-form-item label="文章标题" :label-width="LabelWidth" prop="title">
                    <el-input v-model="editform.title" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="文章排序" :label-width="LabelWidth">
                    <el-input v-model="editform.sort" type="number" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="文章状态" :label-width="LabelWidth">
                    <el-radio v-model="editform.status" :label="1">启用</el-radio>
                    <el-radio v-model="editform.status" :label="0">禁用</el-radio>
                </el-form-item>
                <el-form-item label="文章内容" :label-width="LabelWidth" prop="content">
                    <el-input v-model="editform.content" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer" style="text-align: center;">
                <el-button @click="reset">取 消</el-button>
                <el-button type="primary" @click="editAritcle">确 定</el-button>
            </div>
    </div>
</template>

<script>
    export default {
        name: "Edit",
        props:['editforms','formLabelWidth','edits'],
        data(){
            return {
                editdialog:this.editdialogFormVisible,
                editform:this.editforms,
                LabelWidth:this.formLabelWidth
            }
        },
        methods:{
            editAritcle(){
                if(this.editform.title==='') return alert('标题不能为空')
                this.edits(this.editform,true)
            },
            reset(){
                this.edits(this.editform,false)
            }
        }
    }
</script>

<style scoped>

</style>