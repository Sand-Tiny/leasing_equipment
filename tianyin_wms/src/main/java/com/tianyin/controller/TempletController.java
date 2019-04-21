package com.tianyin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tianyin.domain.XmlDemo;
import com.tianyin.service.TempletService;

@Controller
public class TempletController {

    @Autowired
    private TempletService templetService;
    
    @ResponseBody
    @RequestMapping("/templet")
    public Object templet() {
        return templetService.getTemplet(1);
    }
    @RequestMapping("/ftl")
    public String ftl() {
        System.out.println("ftl");
        return "ftl";
    }
    @ResponseBody
    @RequestMapping("xml")
    public XmlDemo xml() {
        XmlDemo demo = new XmlDemo();
        demo.setId(1);
        demo.setName("tiny");
        return demo;
    }
}
