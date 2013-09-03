<%inherit file="pyrxa:templates/layout.mako"/>
<p><a href="${request.route_url('admin')}">Admin Main Page</a></p>
<form action="${request.route_url('blog_action',action=action)}" method="post">
%if action =='edit':
${form.id()}
%endif

% for error in form.title.errors:
    <div class="error">${ error }</div>
% endfor

<div><label>${form.title.label}</label>${form.title()}</div>

% for error in form.body.errors:
<div class="error">${error}</div>
% endfor

<div><label>${form.body.label}</label>${form.body()}</div>
<div><input type="submit" value="Submit"></div>
</form>


<style type="text/css">
form{
    text-align: right;
}
label{
    min-width: 150px;
    vertical-align: top;
    text-align: right;
    display: inline-block;
}
input[type=text]{
    min-width: 505px;
}
textarea{
    color: #222;
    border: 1px solid #CCC;
    font-family: sans-serif;
    font-size: 12px;
    line-height: 16px;
    min-width: 505px;
    min-height: 100px;
}
.error{
    font-weight: bold;
    color: red;
}
</style>
