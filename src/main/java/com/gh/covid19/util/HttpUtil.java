package com.gh.covid19.util;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import com.gh.covid19.common.ErrorCode;

public class HttpUtil {

	public static HashMap<String, Object> httpConnection(HashMap<String,String> param) {
		HashMap< String , Object > resultMap = new HashMap< String , Object >();
		StringBuilder urlBuilder = new StringBuilder(param.get("targetUrl")); /*URL*/
		StringBuilder sb = null;
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") +"=" + param.get("serviceKey"));
		    urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=-" + URLEncoder.encode(param.get("serviceKey"), "UTF-8")); /*공공데이터포털에서 받은 인증키*/
		    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
			urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(param.get("startCreateDt"), "UTF-8")); /*검색할 생성일 범위의 시작*/
			urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(param.get("endCreateDt"), "UTF-8")); /*검색할 생성일 범위의 종료*/
		    //urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode("20200727", "UTF-8")); /*검색할 생성일 범위의 시작*/
			//urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode("20200727", "UTF-8")); /*검색할 생성일 범위의 종료*/
		    URL url = new URL(urlBuilder.toString());
		    conn = (HttpURLConnection) url.openConnection();
		    conn.setRequestMethod("GET");
		    conn.setRequestProperty("Content-type", "application/json");
		    
		    if(conn.getResponseCode() == 200 ) {
		    	rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    } 
		    
		    sb = new StringBuilder();
		    String line;
		    while ((line = rd.readLine()) != null) {
		        sb.append(line);
		    }
		    rd.close();
		    resultMap.put("resultCode", String.valueOf(conn.getResponseCode()));
		    resultMap.put("resultMsg", "succes" );
		    resultMap.put("resultValue", sb.toString());
		}catch (IOException e) {
			e.printStackTrace();
			resultMap.put("resultCode", "99");
		    resultMap.put("resultMsg", "fail");
		} finally {
		    conn.disconnect();
		}
        return resultMap;
	}

}
