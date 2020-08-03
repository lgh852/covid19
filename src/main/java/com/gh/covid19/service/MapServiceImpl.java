package com.gh.covid19.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.gh.covid19.common.ErrorCode;
import com.gh.covid19.service.impl.MapService;
import com.gh.covid19.util.Covid19;
import com.gh.covid19.util.DateUtil;
import com.gh.covid19.util.HttpUtil;
import com.gh.covid19.util.JsonUtil;
@Service(value = "mapService" )
public class MapServiceImpl implements MapService{

	@Override
	public String getCovid19ToJson() {
		HashMap< String , String > paramMap = new HashMap<>();
		paramMap.put( "serviceKey", "a5az5KX1oQuLr4GtktcsFT%2FCToAUj8KuRrZcZflDzVmlPZia2rrXJS82m6fun48BMTp5Lq2XFWWQFovOhbwNAA%3D%3D" );
		paramMap.put( "targetUrl", "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson" );
		paramMap.put( "startCreateDt", DateUtil.getThisDay("yyyymmdd") );
		paramMap.put( "endCreateDt", DateUtil.getThisDay("yyyymmdd") );
		HashMap< String , Object > resultMap = HttpUtil.httpConnection( paramMap );
		if( resultMap.get( "resultCode" ).equals( ErrorCode.HTTP_SUCCES_CODE ) ) {
			resultMap = Covid19.covid19Parsing( ( String )resultMap.get( "resultValue" ) );
			if(resultMap.get( "resultCode" ).equals( ErrorCode.FAIL_CODE_LIST_NULL )){
				paramMap.put( "startCreateDt", DateUtil.getYesterday() );
				paramMap.put( "endCreateDt", DateUtil.getYesterday() );	
				resultMap = HttpUtil.httpConnection( paramMap );
				if( resultMap.get( "resultCode" ).equals( ErrorCode.HTTP_SUCCES_CODE ) ) {
					resultMap = Covid19.covid19Parsing( ( String )resultMap.get( "resultValue" ) );
				}
			}
		}
		return JsonUtil.mapToJson(resultMap);
	}


}
