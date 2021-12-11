<template>
    <div style="margin-top: 10px;">
        <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="pageinfo.page"
                :page-sizes="sizes"
                :page-size="pageinfo.limit"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total">
        </el-pagination>
    </div>
</template>

<script>
    export default {
        name: "Page",
        props:['query','total','pages','pageSizes'],

        data(){
          return {
              pageinfo:{
                  // query:'',
                  page:this.query.page,
                  limit:this.query.limit
              },
              sizes:this.pageSizes
          }
        },
        methods:{
            // 每页条数
            handleSizeChange(val){
                this.pageinfo.limit=val
                this.pages(this.pageinfo);
            },
            //当前页
            handleCurrentChange(val){
                this.pageinfo.page=val
                this.pages(this.pageinfo);
            }
        }
    }
</script>

<style scoped>

</style>