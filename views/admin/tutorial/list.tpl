

<div class="layui-body" style="padding: 20px;z-index:1000;">
    <form class="layui-form" action="/admin/tutorial/updateedit/{{.Detail.Id}}" method="POST"> 
        <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" value="{{.Detail.Title}}" autocomplete="off" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
            <input type="text" name="sort" value="{{.Detail.Sort}}" autocomplete="off" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容</label>
        <div id="editormd" class="layui-input-block">
            <textarea  class="layui-textarea" name="content">{{.Detail.Content}}</textarea>
        </div>
        </div>
        <div class="layui-form-item" >
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*">保存</button>

        </div>
        </div>
    </form>
</div>