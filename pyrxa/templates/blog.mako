<%inherit file="pyrxa:templates/layout.mako"/>

% if paginator.items:

    ${paginator.pager()}

    <h2>Blog entries</h2>

    <ul>
    % for entry in paginator.items:
    <li>
    <a href="${request.route_url('view_blog', id=entry.id, slug=entry.slug)}">
    ${entry.title}</a>
    </li>
    % endfor
    </ul>

    ${paginator.pager()}

% else:

<p>No blog entries found.</p>

%endif
