from pyramid.response import Response
from pyramid.view import view_config
from pyramid.httpexceptions import HTTPNotFound, HTTPFound
from pyramid.security import remember, forget
from sqlalchemy.exc import DBAPIError

from .models import (
    DBSession,
    Entry,
    MainPage,
    User,
    )
from .forms import BlogCreateForm, BlogUpdateForm


@view_config(route_name='blog', renderer='pyrxa:templates/blog.mako')
def blog_page(request):
    page = int(request.params.get('page', 1))
    paginator = Entry.get_paginator(request, page)
    return {'paginator':paginator}



# @view_config(route_name='view_page', renderer='pyrxa:templates/index.mako')
# def view_page(request):
#     mainpage = int(request.params.get('mainpage', 1))
#     mp = MainPage.by_id(mainpage)
#     return {'mainpage': mp}


@view_config(route_name='admin', renderer='pyrxa:templates/admin.mako')
def admin_page(request):
    page = int(request.params.get('page', 1))
    paginator = Entry.get_paginator(request, page)
    return {'paginator':paginator}


@view_config(route_name='home', renderer='pyrxa:templates/index.mako')
def index_page(request):
    mainpage = MainPage.all()
    return {'mainpage':mainpage}


@view_config(route_name='view_blog', renderer='pyrxa:templates/view_blog.mako')
def blog_view(request):
    id = int(request.matchdict.get('id', -1))
    entry = Entry.by_id(id)
    if not entry:
        return HTTPNotFound()
    return {'entry':entry}


@view_config(route_name='blog_action', match_param='action=edit',
             renderer='pyrxa:templates/edit_blog.mako', permission='edit')
def blog_update(request):
    id = int(request.params.get('id', -1))
    entry = Entry.by_id(id)
    if not entry:
        return HTTPNotFound()
    form = BlogUpdateForm(request.POST, entry)
    if request.method == 'POST' and form.validate():
        form.populate_obj(entry)
        return HTTPFound(location=request.route_url('blog', id=entry.id,
                                                    slug=entry.slug))
    return {'form':form, 'action':request.matchdict.get('action')}


@view_config(route_name='blog_action', match_param='action=create',
             renderer='pyrxa:templates/edit_blog.mako',
             permission='create')
def blog_create(request):
    entry = Entry()
    form = BlogCreateForm(request.POST)
    if request.method == 'POST' and form.validate():
        form.populate_obj(entry)
        DBSession.add(entry)
        return HTTPFound(location=request.route_url('admin'))
    return {'form':form, 'action':request.matchdict.get('action')}


@view_config(route_name='view_page', renderer='pyrxa:templates/view_blog.mako')
def page_view(request):
    id = int(request.matchdict.get('id', -1))
    entry = Entry.by_id(id)
    if not entry:
        return HTTPNotFound()
    return {'entry':entry}

@view_config(route_name='page_action', match_param='action=edit',
             renderer='pyrxa:templates/edit_page.mako', permission='edit')
def page_update(request):
    id = int(request.params.get('id', -1))
    mp = MainPage.by_id(id)
    if not mp:
        return HTTPNotFound()
    form = BlogUpdateForm(request.POST, mp)
    if request.method == 'POST' and form.validate():
        form.populate_obj(mp)
        return HTTPFound(location=request.route_url('admin', id=mp.id,
                                                    slug=mp.slug))
    return {'form':form, 'action':request.matchdict.get('action')}


@view_config(route_name='page_action', match_param='action=create',
             renderer='pyrxa:templates/edit_page.mako',
             permission='create')
def page_create(request):
    mp = MainPage()
    form = BlogCreateForm(request.POST)
    if request.method == 'POST' and form.validate():
        form.populate_obj(mp)
        DBSession.add(mp)
        return HTTPFound(location=request.route_url('admin'))
    return {'form':form, 'action':request.matchdict.get('action')}


@view_config(route_name='auth', match_param='action=in', renderer='string',
             request_method='POST')
@view_config(route_name='auth', match_param='action=out', renderer='string')
def sign_in_out(request):
    username = request.POST.get('username')
    if username:
        user = User.by_name(username)
        if user and user.verify_password(request.POST.get('password')):
            headers = remember(request, user.name)
        else:
            headers = forget(request)
    else:
        headers = forget(request)
    return HTTPFound(location=request.route_url('admin'),
                     headers=headers)


conn_err_msg = """\
Pyramid is having a problem using your SQL database.  The problem
might be caused by one of the following things:

1.  You may need to run the "initialize_pyrxa_db" script
    to initialize your database tables.  Check your virtual
    environment's "bin" directory for this script and try to run it.

2.  Your database server may not be running.  Check that the
    database server referred to by the "sqlalchemy.url" setting in
    your "development.ini" file is running.

After you fix the problem, please restart the Pyramid application to
try it again.
"""
