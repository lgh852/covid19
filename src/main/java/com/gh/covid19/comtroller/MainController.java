package com.gh.covid19.comtroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController  {

//	@RequestMapping("dashBord.do")
//    public ModelAndView index() {
//
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("main/dashBord");
//        return mv;
//    }
//	@RequestMapping("")
//    public ModelAndView main() {
//
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("index");
//        return mv;
//    }
	@RequestMapping(value= {"/",""},method = RequestMethod.GET)
    public ModelAndView mainasd() {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
}