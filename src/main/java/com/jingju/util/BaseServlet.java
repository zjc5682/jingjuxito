package com.jingju.util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public class BaseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //获取method参数，反射调用对应方法
        String methodName = request.getParameter("method");
        if(methodName==null||methodName.trim().isEmpty()) methodName="index";
        try {
            Method method = this.getClass().getDeclaredMethod(methodName,HttpServletRequest.class,HttpServletResponse.class);
            method.invoke(this,request,response);
        }catch (Exception e){
            e.printStackTrace();
            // 确保异常时也能给客户端返回错误信息
            if (!response.isCommitted()) {
                response.getWriter().println("<h3>服务器内部错误</h3><p>" + e.getMessage() + "</p>");
            }
        }
    }
}