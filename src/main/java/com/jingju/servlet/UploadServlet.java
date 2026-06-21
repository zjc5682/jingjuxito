package com.jingju.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * 图片上传 Servlet
 * 接收 multipart/form-data 格式的文件上传请求
 * 将文件保存到 img/ 目录，返回相对路径
 */
@WebServlet("/admin/UploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB 内存缓冲
    maxFileSize = 5 * 1024 * 1024,      // 单文件最大 5MB
    maxRequestSize = 10 * 1024 * 1024   // 请求最大 10MB
)
public class UploadServlet extends HttpServlet {

    private static final String[] ALLOWED_EXTENSIONS = {
        ".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp"
    };

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");

        try {
            Part filePart = request.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                writeJson(response, false, "请选择要上传的文件", null);
                return;
            }

            // Tomcat 7 兼容：从 Content-Disposition 头解析文件名
            String submittedFileName = getFileName(filePart);
            String ext = "";
            if (submittedFileName != null && submittedFileName.contains(".")) {
                ext = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();
            }

            // 校验文件类型
            boolean allowed = false;
            for (String e : ALLOWED_EXTENSIONS) {
                if (e.equals(ext)) { allowed = true; break; }
            }
            if (!allowed) {
                writeJson(response, false, "不支持的文件类型: " + ext + "，仅支持 jpg/png/gif/webp", null);
                return;
            }

            // 生成唯一文件名：UUID + 扩展名
            String newFileName = UUID.randomUUID().toString().replace("-", "") + ext;

            // 获取上传目录的绝对路径（img/ 目录，位于 webapp 根目录下）
            String uploadDir = request.getServletContext().getRealPath("/img");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 保存文件
            String filePath = uploadDir + File.separator + newFileName;
            filePart.write(filePath);

            // 返回相对于 webapp 根目录的路径（以 / 开头，从任何子目录都能正确引用）
            String contextPath = request.getContextPath();
            String relativePath = contextPath + "/img/" + newFileName;
            writeJson(response, true, "上传成功", relativePath);

        } catch (IllegalStateException e) {
            // 文件大小超限
            e.printStackTrace();
            writeJson(response, false, "文件大小超过限制（最大 5MB）", null);
        } catch (Exception e) {
            e.printStackTrace();
            writeJson(response, false, "上传失败：" + e.getMessage(), null);
        }
    }

    /**
     * Tomcat 7 兼容：从 Part 的 Content-Disposition 头解析文件名
     * Part.getSubmittedFileName() 在 Tomcat 7 中不可用
     */
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    /**
     * 输出 JSON 响应
     */
    private void writeJson(HttpServletResponse response, boolean success, String message, String url) throws IOException {
        String json = "{\"success\":" + success
            + ",\"message\":\"" + escapeJson(message) + "\""
            + (url != null ? ",\"url\":\"" + escapeJson(url) + "\"" : ",\"url\":null")
            + "}";
        response.getWriter().write(json);
    }

    /**
     * 转义 JSON 字符串中的特殊字符
     */
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
