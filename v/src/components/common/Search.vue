<template>
    <el-col :span="6">
        <el-input placeholder="请输入内容" clearable @clear="chaxun" v-model="query" class="input-with-select">
            <el-button slot="append" icon="el-icon-search" @click="chaxun"></el-button>
        </el-input>
    </el-col>
</template>

<script>
    export default {
        name: "Search",
        props:['queryInfo','search'],
        data(){
            return {
                query:this.queryInfo.query
            }
        },
        methods:{
            chaxun(){
                this.search(this.query)
            }
        }
    }
</script>

<style scoped>

</style>