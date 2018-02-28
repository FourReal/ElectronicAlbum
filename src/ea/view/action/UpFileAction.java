package ea.view.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
public class UpFileAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 对应js里面的fileObjName，而不是input type ="text" 里面的name值,
	//这里也可以不用list，用File uploadify。因为虽然是批量上传，但还是一个一个的处理文件的
	//等一个文件处理完后才会处理第二个
	private File uploadify; 
	private String uploadifyFileName;
	private String uploadifyContentType;
	private String savePath;// 文件上传后保存的路径
	private String mvUrl;
	private int userid;//标记哪个用户上传
	


	/**
	 * ajax 上传图片并返回文件路径
	 * 
	 * @return
	 * @throws Exception
	 */
	public String upload() throws Exception {
		File dir = new File(getSavePath());
		if (!dir.exists()) {
			dir.mkdirs();
		}
		List<String> mfiles = new ArrayList<String>();
		System.out.println("getSavePath():"+getSavePath());
		System.out.println("userid:"+userid);
		
		//文件重命名，文件保存
			String fileName = new SimpleDateFormat("yyyyMMddHHmmss")
					.format(new Date()) + "_" + uploadifyFileName;
			ActionContext ac = ActionContext.getContext();
			ServletContext sc = (ServletContext) ac
					.get(ServletActionContext.SERVLET_CONTEXT);
			String realPath = sc.getRealPath("/");
			String dest = realPath + getSavePath() + "/" + fileName;
			System.out.println("目标路径:"+dest);
			FileUtils.copyFile(uploadify, new File(dest));
			mfiles.add(savePath + "/" + fileName);

		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		// 返回图片地址，这里我们实际用的时候可能返回实际图片和缩略图，
		//上传后真正显示的时候用缩略图,实际保存地址为原图片地址。那样加载更快
		out.write(mfiles.get(0));
		out.close();
		out.flush();
		
		System.out.println("mfiles.get(0):"+mfiles.get(0));
		System.out.println("uploadify:"+uploadify);
		System.out.println("uploadifyFileName:"+uploadifyFileName);
		System.out.println("savePath:"+savePath);
		return "success";
	}

	// 批量保存图片地址

	public String savePath() throws IOException {
		System.out.println("mvUrl:"+mvUrl);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write("保存成功");
		out.close();
		out.flush();
		return "success";

	}


	public File getUploadify() {
		return uploadify;
	}

	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}

	public String getUploadifyFileName() {
		return uploadifyFileName;
	}

	public void setUploadifyFileName(String uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}

	public String getUploadifyContentType() {
		return uploadifyContentType;
	}

	public void setUploadifyContentType(String uploadifyContentType) {
		this.uploadifyContentType = uploadifyContentType;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getMvUrl() {
		return mvUrl;
	}

	public void setMvUrl(String mvUrl) {
		this.mvUrl = mvUrl;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	
}
