package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/delete.do")
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest req, 
    		HttpServletResponse resp)
    				throws ServletException, IOException {
    	//로그인 확인
    	HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../06Session/LoginForm.jsp");
			return;
		}
		
		//게시물 얻어오기
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectView(idx);
		
		//작성자 본인 확인
		if(!dto.getId().equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 삭제할 수 있습니다.");
			return;
		}
		
		//게시물 삭제
		int result = dao.deletePost(idx);
		dao.close();
        if (result == 1) {  // 게시물 삭제 성공 시 첨부파일도 삭제
            String saveFileName = dto.getSfile();
            FileUtil.deleteFile(req, "/Uploads", saveFileName);
        }		
		
		JSFunction.alertLocation(resp, "삭제되었습니다.", 
				"../mvcboard/list.do");
    }
}



