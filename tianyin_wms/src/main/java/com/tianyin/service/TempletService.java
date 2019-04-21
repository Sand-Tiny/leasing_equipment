package com.tianyin.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tianyin.dao.TianyinBaseDao;
import com.tianyin.domain.Templete;

@Service
public class TempletService {

    @Autowired
    private TianyinBaseDao dao;
    
    public Templete getTemplet(int id) {
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("id", id);
        Templete result = dao.queryForObject("templet.getTemplet", whereParams);
        return result;
    }
}
