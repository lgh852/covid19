<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <head>
    <style>
      .map {
        height: 800px;
        width: 100%;
      }
    </style>
    <title>맵 띄우기</title>
  </head>
  <body>
    <div id="map" class="map"></div>
 <script type="text/javascript">
 		var vworld = {
 				key:'B8E8F54E-4AC9-3C95-95F1-3A0687C49DA3'
 		}    	
    	var layerSet = [];
    	
 		var baseLayer  = new ol.layer.Tile({
			title: "VWorld Base Map",
            name: "base",
            type: "base",
            visible:true,
            source : new ol.source.XYZ({
                url: "http://api.vworld.kr/req/wmts/2.0.0/"+vworld.key+"/Base/{z}/{y}/{x}.png"
            })
		});
 		
 		var hybridLayer = new ol.layer.Tile({
			title: "VWorld Hybrid Map",
            name: "Hybrid",
            type: "Hybrid",
            visible:true,
            source : new ol.source.XYZ({
                url:  'http://api.vworld.kr/req/wmts/1.0.0/'+vworld.key+'/Hybrid/{z}/{y}/{x}.png'
               
            })
		});
 		
 		var satelliteLayer = new ol.layer.Tile({
			title: "VWorld Satellite Map",
            name: "Satellite",
            type: "Satellite",
            visible:false,
            source : new ol.source.XYZ({
                url: "http://api.vworld.kr/req/wmts/1.0.0/"+vworld.key+"/Satellite/{z}/{y}/{x}.jpeg"
            })
		});
 		
 		layerSet['baseLayer'] = baseLayer;
 		layerSet['satelliteLayer'] = satelliteLayer;
 		layerSet['hybridLayer'] = hybridLayer;
        //openlayers 지도 띄우기 (EPSG : 4326)
        var map = new ol.Map({
            target: 'map',
            layers: [
            	satelliteLayer,baseLayer,hybridLayer
            ],
            view: new ol.View({
                //경도,위도 (EPSG : 4326)
                 center: ol.proj.transform([127.090616,37.502142], 'EPSG:4326', 'EPSG:900913'),
                zoom: 7,
                minZoom: 6,
                maxZoom: 15        
            }),
          });
           
        function selectLayer(str){
        	for(var i = 0; i < $("input[name=LayerBtn]").length ; i++ ){
        		varTagId = $("input[name=LayerBtn]")[i].id;
        		if( varTagId != str){
        			layerSet[ varTagId ].setVisible( false );
        			$("#"+varTagId).prop("checked", false);
        		}else{
        			$("#"+str).prop("checked", true);
            		layerSet[ str ].setVisible( true );
        		}
        	}
        	
        }
    
</script>
<div style=" box-shadow: 1px 1px 1px 1px #d0cec7;height: 170px;width: 160px;position: relative;top: -694px;left: 10px;background-color: white;border:1px solid #ddd">
	<ul style=" list-style:none;padding: 20px;">
		<li style="padding:0px;text-align: center;">
			<div class="ckbx-style-13" style="float: left;margin-top: 9px">
                 <input type="checkbox" id="satelliteLayer" value="0" name="LayerBtn" onclick="selectLayer('satelliteLayer')">
                 <label for="satelliteLayer"></label>
             </div>위성
        </li>
		<li style="padding:0px;text-align: center;">
			<div class="ckbx-style-13" style="float: left;margin-top: 9px">
                <input type="checkbox" id="hybridLayer" value="0" name="LayerBtn" onclick="selectLayer('hybridLayer')">
                <label for="hybridLayer" ></label>
            </div>도로
		</li>
		<li style="padding:0px;text-align: center;">
			<div class="ckbx-style-13" style="float: left;margin-top: 9px">
                <input type="checkbox" id="baseLayer" value="0" name="LayerBtn" checked="checked"  onclick="selectLayer('baseLayer')">
                <label for="baseLayer"></label>
            </div>배경
		</li>
	</ul>
</div>
<div id="map"></div>
  </body>
</html>