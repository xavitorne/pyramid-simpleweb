<%inherit file="pyrxa:templates/layout.mako"/>

<%
from pyramid.security import authenticated_userid
user_id = authenticated_userid(request)
%>

% if user_id:
    Welcome <strong>${user_id}</strong> ::
    <a href="${request.route_url('auth',action='out')}">Sign Out</a>
    <br/>

    <h2>Main Pages</h2>

    <ul>
    % for entry in paginator_pages.items:
    <li>
    <a href="${request.route_url('view_page', id=entry.id, slug=entry.slug)}">
    ${entry.title}</a> -> <a href="${request.route_url('page_action', action='edit',
_query=(('id',entry.id),))}">Edit Entry</a>

    </li>
    % endfor
    </ul>
    <p>
    <a href="${request.route_url('page_action',action='create')}">
    Create a new page
    </a>
    </p>


    <h2>Blog entries</h2>

    <ul>
    % for entry in paginator_blog.items:
    <li>
    <a href="${request.route_url('view_blog', id=entry.id, slug=entry.slug)}">
    ${entry.title}</a> -> <a href="${request.route_url('blog_action', action='edit',
_query=(('id',entry.id),))}">Edit Entry</a>

    </li>
    % endfor
    </ul>

    <p>
    <a href="${request.route_url('blog_action',action='create')}">
    Create a new blog entry
    </a>
    </p>


%else:
    <form action="${request.route_url('auth',action='in')}" method="post">
    <label>User</label><input type="text" name="username">
    <label>Password</label><input type="password" name="password">
    <input type="submit" value="Sign in">
    </form>
%endif
