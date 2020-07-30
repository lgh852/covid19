package com.gh.covid19.util;

import java.util.HashMap;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtil {
	
	
	public static String mapToJson( HashMap<String, Object> resultMap ) {
		ObjectMapper mapper = new ObjectMapper();
		String json = ""; 
		try {
			json = mapper.writeValueAsString( resultMap );
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	public static String listToJson( List< Object > list) {
		ObjectMapper mapper = new ObjectMapper();
		String json = ""; 
		try {
			json = mapper.writeValueAsString( list );
			System.out.println(json);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}

}
