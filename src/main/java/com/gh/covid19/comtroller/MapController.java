package com.gh.covid19.comtroller;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.gh.covid19.common.ErrorCode;
import com.gh.covid19.util.Covid19;
import com.gh.covid19.util.DateUtil;
import com.gh.covid19.util.HttpUtil;
import com.gh.covid19.util.JsonUtil;

@Controller
public class MapController {

	
	@RequestMapping("/backGroundMap.do")
	public String backGroundMap() {
		return "map/backGroundMap";
	}
	
	@RequestMapping(value = "/updateMap.do")
	public String updateMap() {
		return "map/updateMap";
	}
	
	@RequestMapping(value="/covid19.do" , method = RequestMethod.GET)
	@ResponseBody
	public String covid19() {
		List< HashMap > resultList;
		String resultJson = null;;
		HashMap< String , String > paramMap = new HashMap<>();
		paramMap.put( "serviceKey", "a5az5KX1oQuLr4GtktcsFT%2FCToAUj8KuRrZcZflDzVmlPZia2rrXJS82m6fun48BMTp5Lq2XFWWQFovOhbwNAA%3D%3D" );
		paramMap.put( "targetUrl", "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson" );
		paramMap.put( "startCreateDt", DateUtil.getThisDay("yyyymmdd") );
		paramMap.put( "endCreateDt", DateUtil.getThisDay("yyyymmdd") );
		
		HashMap< String , Object > resultMap = HttpUtil.httpConnection( paramMap );
		if( resultMap.get( "resultCode" ).equals( ErrorCode.HTTP_SUCCES_CODE ) ) {
			resultMap = Covid19.covid19Parsing( ( String )resultMap.get( "resultValue" ) );
 			if( resultMap.get( "resultCode" ).equals( ErrorCode.SUCCES_CODE ) ) {
 				 resultJson= JsonUtil.mapToJson(resultMap);
 			}
		}

		return resultJson;
	}
	
	public String apiCovid19() {
		List< HashMap > resultList;
		HashMap< String , String > paramMap = new HashMap<>();
		paramMap.put( "serviceKey", "=a5az5KX1oQuLr4GtktcsFT%2FCToAUj8KuRrZcZflDzVmlPZia2rrXJS82m6fun48BMTp5Lq2XFWWQFovOhbwNAA%3D%3D" );
		paramMap.put( "targetUrl", "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson" );
		
		
		
		HashMap< String , Object > resultMap = HttpUtil.httpConnection( paramMap );
		if( resultMap.get( "resultCode" ).equals( ErrorCode.HTTP_SUCCES_CODE ) ) {
			resultMap = Covid19.covid19Parsing( ( String )resultMap.get( "result" ) );
			if( resultMap.get( "resultCode" ).equals( ErrorCode.SUCCES_CODE ) ) {
				resultList = (List<HashMap>) resultMap.get("resultValue");

				for(HashMap val : resultList) {
						System.out.println(val.get("lat"));
						System.out.println(val.get("loc"));
						System.out.println(val.get("location"));
				}
			}
		}
		
		return "";
	}
	
	
    public static void main(String[] args) throws JsonProcessingException {
    	
		
	}
}
