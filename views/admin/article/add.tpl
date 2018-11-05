<div class="layui-body" style="padding: 15px;">
    <form class="layui-form" action="/admin/article/addedit" method="POST"> 
        <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item">
        <label class="layui-form-label">分类</label>
        <div class="layui-input-block">
            <select name="category" lay-filter="fenlei">
                {{range .Categorys}}
                    <option value="{{.Id}}">{{.Name}}</option>
                {{end}}
            </select>
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容</label>
        <div id="editormd" class="layui-input-block">
            <textarea placeholder="请输入内容" class="layui-textarea" name="content"></textarea>
        </div>
        </div>
        <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*">保存</button>
        </div>
        </div>
    </form>
</div>
    
<script src="../../../static/layui-2.4.3/layui.js"></script>
<script src="../../../static/editor/jquery.min.js"></script>
<script src="../../../static/editor/editormd.min.js"></script>
<script type="text/javascript">
layui.use('form', function(){
    var form = layui.form;
    
    //各种基于事件的操作，下面会有进一步介绍
});
$(function() {
    var editor = editormd("editormd", {
        width: "100%",
        height: 640,
        emoji: true,
        path: '../../../static/editor/lib/' ,
        tocm:true,
        /*设置主题颜色*/
        // editorTheme: "pastel-on-dark",
        // theme: "gray",
        // previewTheme: "dark"
    });
});
</script>