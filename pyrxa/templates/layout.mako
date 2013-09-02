<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My template</title>
  <meta name="keywords" content="python web application" />
  <meta name="description" content="pyramid web application" />
  <link rel="shortcut icon" href="${request.static_url('pyrxa:static/favicon.ico')}" />
  <link rel="stylesheet" href="${request.static_url('pyrxa:static/style.css')}" type="text/css" media="screen" charset="utf-8" />
  <link rel="stylesheet" href="http://static.pylonsproject.org/fonts/nobile/stylesheet.css" media="screen" />
  <link rel="stylesheet" href="http://static.pylonsproject.org/fonts/neuton/stylesheet.css" media="screen" />
  <!--[if lte IE 6]>
  <link rel="stylesheet" href="${request.static_url('pyrxa:static/ie6.css')}" type="text/css" media="screen" charset="utf-8" />
  <![endif]-->
</head>
<body>

<div id="wrap">
    <div id="top">
      <div class="top align-center">
        <div>arg</div>
      </div>
    </div>
    <div id="bottom" style="padding-bottom:50px;">
      <div class="bottom">
        ${next.body()}
      </div>
    </div>
  </div>
  <div id="footer">
    <div class="footer">Footer of our application.</div>
  </div>
</body>
</html>
