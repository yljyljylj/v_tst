module.exports = {
  pages: {
    index: {
      //入口
      entry: 'src/main.js',
    },
  },
	lintOnSave:false, //关闭语法检查
	//开启代理服务器（方式一）
	/* devServer: {
    proxy: 'http://localhost:5000'
  }, */
	//开启代理服务器（方式二）
	devServer: {
    proxy: {
      '/index.php': {
        target: 'http://vtst.com/',
        // ws: true, //用于支持websocket
        // changeOrigin: true //用于控制请求头中的host值
      },
    }
  }
}