package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DateDAO {
   
   List<Map<String,String>> getWeekDateList();
   List<Map<String,String>> getMonthDateList();
   List<Map<String,String>> getYearDateList();
   
}