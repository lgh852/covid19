package com.gh.covid19.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.gh.covid19.common.ErrorCode;

public class Covid19 {

	public static HashMap<String , Object >covid19Parsing(String xmlString) {
		HashMap< String , Object > resultMap = new HashMap< String, Object >();
		
		String []latArray = {"126.978357","129.075332","128.601243","126.705725","126.851454","127.384583","129.311242","127.289036","127.008965","127.730264","127.491392","126.673829","127.108213","126.463634","128.50489","128.691938","126.498122"};
		String []lonArray = {"37.566698","35.18021","35.871469","37.456244","35.160041","36.350383","35.538905","36.480062","37.275268","37.8856","36.635727","36.659178","35.819795","34.816853","36.57592","35.237489","33.488683"};
		String []location = {"서울","부산","대구","인천","광주","대전","울산","세종","경기","강원","충북","충남","전북","전남","경북","경남","제주"};
		
		HashMap<String,String> map = new HashMap<String,String>();
		List<HashMap<String,String>> list= new ArrayList<HashMap<String,String>>();
		
		for(int i = 0; i < latArray.length;i++) {
			map = new HashMap<String,String>();
			map.put("lat", latArray[i]);
			map.put("lon", lonArray[i]);
			map.put("location", location[i]);
			list.add(i, map);
		}
		List<HashMap> resultList = new ArrayList<HashMap>();
        BufferedReader br = null;
        //DocumentBuilderFactory 생성
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder;
        Document doc = null;
        InputSource is = new InputSource(new StringReader(xmlString));
        try {
			builder = factory.newDocumentBuilder();
	        doc = builder.parse(is);
	        XPathFactory xpathFactory = XPathFactory.newInstance();
	        XPath xpath = xpathFactory.newXPath();
	        XPathExpression expr = xpath.compile("//resultCode");
	        NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
	        if(nodeList.item(0).getChildNodes().item(0).getTextContent().equals("00")) {
	        	expr = xpath.compile("//items/item");
	        	nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
	        	HashMap<String,String> parsingMap = new HashMap<String,String>();
	        	if(0 < nodeList.getLength()){
		        	for (int i = 1; i < nodeList.getLength(); i++) {
		                NodeList child = nodeList.item(i).getChildNodes();
		                parsingMap = new HashMap<String,String>();
		                for (int j = 0; j < child.getLength(); j++) {
		                    Node node = child.item(j);
		
		                    switch (node.getNodeName()) {
							case "localOccCnt": //신규 확진자
								parsingMap.put("localOccCnt", node.getTextContent());
								break;
							case "gubun":
								parsingMap.put("gubun", node.getTextContent());
								for(int ii = 0; ii < list.size() ; ii++) {
									if(node.getTextContent().indexOf(list.get(ii).get("location"))> -1) {
										parsingMap.put("lat", list.get(ii).get("lat"));
										parsingMap.put("lon", list.get(ii).get("lon"));
										parsingMap.put("location", list.get(ii).get("location"));
									}
								}
								break;
							case "isolClearCnt": // 완치자
								parsingMap.put("isolClearCnt", node.getTextContent());
								break;
							case "defCnt": //누적 확진자
								parsingMap.put("defCnt", node.getTextContent());
								break;
							case "createDt": //일자 
								parsingMap.put("dt", node.getTextContent());
								break;
							case "deathCnt": // 사망자 
								parsingMap.put("deathCnt",node.getTextContent());
								break;
							case "qurRate":
								parsingMap.put("qurRate",node.getTextContent());
								break;
							}
		                }
		                if(i != nodeList.getLength()-1) {
		                	resultList.add( parsingMap );
		                }else {
		                	resultMap.put( "resultSum" , parsingMap );
		                }
		            }
		        	resultMap.put( "resultCode" , "00" );
		        	resultMap.put( "resultMsg" , "success" );
		        	resultMap.put( "resultValue", resultList ); 
	        	}else {
	        		resultMap.put( "resultCode" , ErrorCode.FAIL_CODE_LIST_NULL );
		        	resultMap.put( "resultMsg" , "Fail List is Null" );
		        	resultMap.put( "resultValue", resultList ); 
	        	}
	        }else {
	        	System.out.println("통신에러");
	        }
        }  catch (XPathExpressionException e) {
			e.printStackTrace();
			resultMap.put( "resultCode" , "00" );
        	resultMap.put( "resultMsg" , "fail" );
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put( "resultCode" , "00" );
        	resultMap.put( "resultMsg" , "fail" );
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put( "resultCode" , "00" );
        	resultMap.put( "resultMsg" , "fail" );
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put( "resultCode" , "00" );
        	resultMap.put( "resultMsg" , "fail" );
		}
        
        return resultMap;
	}
}
