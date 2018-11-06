<div class="layui-body" style="padding: 15px;z-index:1000;">
    <form class="layui-form" id="form" method="POST"> 
        <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" value="{{.Draft.Title}}" autocomplete="off" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item">
        <label class="layui-form-label">分类</label>
        <div class="layui-input-block">
            <select name="category" lay-filter="fenlei">
            {{$id := .Category.Id}}
            {{range .Categorys}}
                <option value="{{.Id}}" {{if eq .Id $id}} selected="selected" {{end}}>{{.Name}}</option>
            {{end}}
            </select>
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容</label>
        <div id="editormd" class="layui-input-block">
            <textarea  class="layui-textarea" name="content">{{.Draft.Content}}</textarea>
        </div>
        </div>
        <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*" onclick="release()">发表</button>
            <button class="layui-btn" lay-submit lay-filter="*" onclick="draft()">暂存</button>
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
        path: '../../../static/editor/lib/',
        tocm:true,
    });
});
function release(){
    $("#form").attr("action","/admin/draft/updaterelease/{{.Draft.Id}}");
    $("#form").submit();
}
function draft() {
    $("#form").attr("action","/admin/draft/updateedit/{{.Draft.Id}}");
    $("#form").submit();
}
</script>