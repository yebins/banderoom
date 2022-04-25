package com.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.vo.ArticlesVO;

@RequestMapping(value="/board")
@Controller
public class BoardController {
   
   @RequestMapping(value="/notice.do")
   public String Notice(Model model) {
	   List<ArticlesVO> list = new ArrayList<ArticlesVO>();
	   for(int i=0;i<10;i++) {
	   ArticlesVO vo1=new ArticlesVO();
	   vo1.setbIdx(1);
	   vo1.setaIdx(i);
	   vo1.setContent("배치기가 노쿨이 되었습니다"+i);
	   vo1.setTitle("이번주 그라가스 버프입니다"+i);
	   vo1.setmIdx(1);
	   vo1.setmNickname("운영자");
	   
	   list.add(vo1);
	   }
	   
	   System.out.println(list.size());
      
	   
	   
      return "board/notice";
   }
   
   @RequestMapping(value="/freeBoard.do")
   public String freeBoard() {
      
      return "board/freeBoard";
   }
   
   @RequestMapping(value="/infomation.do")
   public String infomatino() {
      
      return "board/infomation";
   }
}
