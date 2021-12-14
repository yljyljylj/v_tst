<template>
    <el-dialog title="新增权限" :visible.sync="dialogVisible">
        <el-form :model="form">
            <el-form-item label="权限标题" :label-width="formLabelWidth"
                          prop="title"
                          :rules="[{ required: true, message: '权限标题不能为空'},]">
                <el-input v-model.trim="form.title" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="一级权限" :label-width="formLabelWidth">
                <el-select v-model="form.pid" placeholder="请选择父级权限" @change="quanxian">
                    <el-option label="添加一级权限" :value="0"></el-option>
                    <el-option v-for="list in topList" :label="list.title" :value="list.id" :key="list.id"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item v-if="isSecond" label="二级权限" :label-width="formLabelWidth">
                <el-select v-model="trl" placeholder="请选择父级权限">
                    <el-option label="添加二级权限" :value="1"></el-option>
                    <el-option v-for="list in secondList" :label="list.title" :value="list.id" :key="list.id"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="权限路径" :label-width="formLabelWidth">
                <el-input v-model.trim="form.path" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="权限状态" :label-width="formLabelWidth">
                <el-radio v-model="form.status" :label="1">开启</el-radio>
                <el-radio v-model="form.status" :label="0">禁用</el-radio>
            </el-form-item>
            <el-form-item label="icon样式" :label-width="formLabelWidth">
                <el-input v-model.trim="form.css" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="权限描述" :label-width="formLabelWidth">
                <el-input type="textarea" v-model="form.condition"></el-input>
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
        props:['form','add_dialog'],

        data(){
            return{
                dialogVisible:this.add_dialog,
                formLabelWidth: '180px',
                topList:[],
                secondList:[],
                trl:1,
                isSecond:false,
                level:0
            }
        },
        created(){
          this.getTopRule()
        },
        methods:{
            addRules(){
                if(this.trl!=1){
                    console.log(this.form)
                    console.log(this.trl)
                }else{

                }

            },
            quanxian(){
                if(this.form.pid==0){
                    this.isSecond=false
                    console.log('00000')
                }else{
                    this.isSecond=true
                    this.getSecondList()
                    // console.log('不等于0')
                }

            },
            async getSecondList(){
                const {data:res}=await this.$axios.get('api/auth/secondList',{params:{pid:this.form.pid}})
                this.secondList=res.data
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
            },
            async getTopRule(){
                const {data:res}=await this.$axios.get('api/auth/getTopRule')
                this.topList=res.data
            },
        }
    }
</script>

<style scoped>

</style>