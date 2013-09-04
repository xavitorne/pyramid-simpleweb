<!DOCTYPE html>
<html>
        <head>
                <title>Project Name</title>
                <link rel="stylesheet" href="/static/css/uikit.min.css" />
                <!-- Almost Flat style -->
                <link rel="stylesheet" href="/static/css/uikit.almost-flat.min.css" />
                <!-- Gradient style -->
                <!-- <link rel="stylesheet" href="css/uikit.gradient.min.css" /> -->
                <script src="/static/js/jquery-1.10.2.min.js"></script>
                <script src="/static/js/uikit.min.js"></script>
        </head>
        <body>
                <nav class="uk-navbar">
                        <div class="uk-container uk-container-center">
                                <a href="/" class="uk-navbar-brand">Project name</a>
                                <ul class="uk-navbar-nav uk-hidden-small uk-navbar-attached">
                                        <li class="uk-active"><a href="${request.route_url('blog')}">Blog</a></li>
                                        <li><a href="">About</a></li>
                                        <li><a href="">Contact</a></li>
                                </ul>
                                <div class="uk-navbar-flip">
                                        <a href="#my-id" class="uk-navbar-toggle uk-visible-small" data-uk-offcanvas="{target:'#my-id'}"></a>
                                </div>
                        </div>
                </nav>

                <div id="my-id" class="uk-offcanvas">
                        <div class="uk-offcanvas-bar">
                                <ul class="uk-nav uk-nav-offcanvas" data-uk-nav>
                                        <li><a href="${request.route_url('blog')}">Blog</a></li>
                                        <li><a href="#about">About</a></li>
                                        <li><a href="#contact">Contact</a></li>
                                </ul>
                        </div>
                </div>

                <!-- Needed for padding at top of body, to look more like Bootstrap's example -->
                <br>

                <div class="uk-container uk-container-center">
                ${next.body()}
                </div>
        </body>
</html>
