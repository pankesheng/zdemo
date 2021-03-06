<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title></title>
    <style type="text/css">
        html, body{
            background-color: #eeedec;
            height: 100%;
            padding: 0;
            margin: 0;
        }
        .not-found{
            width: 100%;
            height: 100%;
        }
        .btn{
            display: block;
            width: 140px;
            height: 28px;
            line-height: 28px;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 2px;
            background-color: #2cc8f4;
            cursor: pointer;
        }
        .bg{
            display: block;
            margin-bottom: 20px;
            max-width: 70%;
            max-height: 70%;
        }
    </style>
</head>
<body>
    <div class="not-found">
        <table width="100%" height="100%">
            <tr>
                <td align="center" valign="middle">
                    <img class="bg" src="<%=request.getContextPath() %>/admin/images/404.png" alt="404" />
                    <a class="btn" href="<%=request.getContextPath() %>/login.jsp">返回首页</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>