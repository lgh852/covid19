<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="ko" style="height: 100%">
  <head>
    <meta charset="UTF-8">
    <title></title>
    <!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <tiles:insertAttribute name="header"/> <!--  /WEB-INF/views/common/layout/header.jsp -->
  </head>
  <body class="is-preload" style="height: 100%">
	<section id="cta" class="wrapper" style="padding: 0px;height: 100%">
		<tiles:insertAttribute name="body"/> <!-- body -->
	</section>
  </body>
</html>