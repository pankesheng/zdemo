package com.thanone.zdemo.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thanone.zdemo.common.Configuration;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/file")
@Scope("prototype")
@Component("fileAction")
public class FileAction extends BasicAction {

	private static final String DEFAULT_FOLDER = "temp";

	// 文件上传
	@RequestMapping("/upload.ajax")
	public void upload(String type, HttpServletRequest request, PrintWriter out) throws Exception {
		if (StringUtils.isBlank(type)) {
			type = DEFAULT_FOLDER;
		}
		ServiceResult sr = uploadFile(request, type, Configuration.getRealPath());
		out.write(ServiceResult.GSON_DT.toJson(sr));
	}

	/**
	 * 文件下载
	 * 
	 * @param path
	 *            相对项目的路径，如"/download/test.xls"
	 * @param fileName
	 *            保存的文件名，带文件后缀，可以是中文，如"用户信息.xls"
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/download")
	public String download(String path, String fileName, HttpServletRequest request, HttpServletResponse response) {

		try {
			File f = new File(Configuration.getRealPath() + path);

			InputStream ins = new BufferedInputStream(new FileInputStream(Configuration.getRealPath() + path));
			byte[] buffer = new byte[ins.available()];
			ins.read(buffer);
			ins.close();

			response.reset();
			response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
			response.addHeader("Content-Length", "" + f.length());
			OutputStream ous = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/vnd.ms-excel");
			ous.write(buffer);
			ous.flush();
			ous.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

}
