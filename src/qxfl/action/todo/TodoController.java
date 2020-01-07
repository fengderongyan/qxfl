package qxfl.action.todo;


import qxfl.service.todo.TodoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import web.action.BaseController;

/**
 * 加载系统首页相关信息
 * @date 2016-2-22
 */
@Controller
@RequestMapping(value = "/todo/")
public class TodoController extends BaseController {
	
	@Autowired
	public TodoService todoService;
	
	/**
     * 首页展示
     * @return
     */
    @RequestMapping(value = "frame.do")
    public String dictFrame() {
        request.setAttribute("tcbgList", todoService.tcBgList(request));
        request.setAttribute("jhbgList", todoService.jhList(request));
        return COM_PATH + "qxfl/todo/todo";
    }
	
    /** 
     * 全部提出信息
     * @return
     */ 
    @RequestMapping(value = "allTcFrame.do")
    public String allTcFrame(){
    	request.setAttribute("yearsList", todoService.getNdList(request));
        return COM_PATH + "qxfl/todo/all/allTcFrame";
    }
    
    /** 
     * 全部提出信息查询列表
     * @return
     */ 
    @RequestMapping(value = "allTcList.do")
    public String allTcList(){
    	 request.setAttribute("tcbgList", todoService.tcBgList(request));
        return COM_PATH + "qxfl/todo/all/allTcList";
    }
    
    /** 
     * 全部校核（签发）信息
     * @return
     */
    @RequestMapping(value = "allJhFrame.do")
    public String allJhFrame(){
    	request.setAttribute("yearsList", todoService.getNdList(request));
        return COM_PATH + "qxfl/todo/all/allJhFrame";
    }
    
    /** 
     * 
     * @return
     */ 
    @RequestMapping(value = "allJhList.do")
    public String allJhList(){
    	request.setAttribute("jhbgList", todoService.jhList(request));
        return COM_PATH + "qxfl/todo/all/allJhList";
    }
}