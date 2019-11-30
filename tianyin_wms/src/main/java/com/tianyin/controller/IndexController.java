package com.tianyin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @RequestMapping("/")
    public String index() {
        return "redirect:/order/query";
    }
    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }
    @RequestMapping("/tologin")
    public String login(String username, String password, HttpSession session) {
        if (username == null || password == null) {
            return "redirect:/login";
        }
        if (!username.trim().equals("admin")) {
            return "redirect:/login";
        }
        if (!password.trim().equals("147852")) {
            return "redirect:/login";
        }
        session.setAttribute("role", "admin");
        return "redirect:/order/query";
    }
}
