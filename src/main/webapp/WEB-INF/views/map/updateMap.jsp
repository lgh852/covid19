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
        height: 900px;
        width: 100%;
      }
      #marker {
        width: 20px;
        height: 20px;
        border: 1px solid #088;
        border-radius: 10px;
        background-color: #0FF;
        opacity: 0.5;
      }
      .box{
     	 left: 13px;
	    top: 105px;
	    width: 90px;
	    height: auto;
	    display: block;
	    text-align: center;
	    padding: 10px 0px 10px 0px;
	    z-index: 1001;
	    position: absolute;
	    background-color: #fff;
	    border-radius: 4px;
	    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
	    border: 1px solid rgba(0, 0, 0, 0.2);
	    background-clip: padding-box;
    }
    .title{
	    padding: 5px 10px 2px 10px;
	    height: 30px;
	    border-bottom: 1px solid #eee;
	    font-size: 15px;
	    font-weight: bold;
	    display: flex;
	    font-family: Arial, Helvetica, sans-serif !important;
	    justify-content: space-between;
	    align-items: center;
    }
    #popup {
		position: relative;
		background: #ffffff;
		border: 4px solid #ffffff;
		display: none;
	}
	#popup:after {
		right: 100%;
		top: 50%;
		border: solid transparent;
		content: " ";
		height: 0;
		width: 0;
		position: absolute;
		pointer-events: none;
	}
	
	#popup:after {
		border-color: rgba(255, 255, 255, 0);
		border-right-color: #ffffff;
		border-width: 25px;
		margin-top: -30px;
	}
    </style>
    <title>맵 띄우기</title>
  </head>
  <body>
 <script type="text/javascript">
 		var vworld = {
 				key:'B8E8F54E-4AC9-3C95-95F1-3A0687C49DA3'
 		}
	    var format = 'image/png';
    	var layerSet = [];
    	var map;
    	$(document).ready(function(){
    		
	    	initLayer();
	    	
	    	initMap();
	    	
	    	addTextCircle(layerSet['vectorLayer'].getSource());
	    	
        });
    	
    	function initLayer(){
    		
    		layerSet['baseLayer'] = new ol.layer.Tile({
    			title: "VWorld Base Map",
                name: "base",
                type: "base",
                visible:true,
                source : new ol.source.XYZ({
                    url: "http://api.vworld.kr/req/wmts/1.0.0/"+vworld.key+"/Base/{z}/{y}/{x}.png"
                })
    		});
     		
    		layerSet['hybridLayer'] = new ol.layer.Tile({
    			title: "VWorld Hybrid Map",
                name: "Hybrid",
                type: "Hybrid",
                visible:false,
                source : new ol.source.XYZ({
                    url:  'http://api.vworld.kr/req/wmts/1.0.0/'+vworld.key+'/Hybrid/{z}/{y}/{x}.png'
                   
                })
    		});
     		
    		layerSet['satelliteLayer'] = new ol.layer.Tile({
    			title: "VWorld Satellite Map",
                name: "Satellite",
                type: "Satellite",
                visible:false,
                source : new ol.source.XYZ({
                    url: "http://api.vworld.kr/req/wmts/1.0.0/"+vworld.key+"/Satellite/{z}/{y}/{x}.jpeg"
                })
    		});

    		layerSet['seoulLayer'] = new ol.layer.Tile({
    	       visible: false,
    	       opacity:0.4,
    	       source: new ol.source.TileWMS({
    	         url: 'http://localhost:8000/geoserver/student/wms',
    	         params: {'FORMAT': format, 
    	                  'VERSION': '1.1.1',
    	                  tiled: true,
    	               "LAYERS": 'student:tl_scco_sig_w',
    	               "exceptions": 'application/vnd.ogc.se_inimage',
    	            tilesOrigin: 126.767486572266 + "," + 37.4305419921875
    	         }
    	       })
    	     });
    		
    		layerSet['vectorLayer'] = new ol.layer.Vector({ 
    			name: "vectorLayer",
    			source: new ol.source.Vector() 
    		});
    		
    	}
// 		function addTextPoint(/* ol.source.Vector */ src) {
// 		    var feature = new ol.Feature({
// 		        geometry: new ol.geom.Point(ol.proj.fromLonLat([127.090616,37.502142]))
// 		    });

//  		     var style = new ol.style.Style({
//  		        text: new ol.style.Text({
//  		            text: '70000',
//  		            scale: 1,
//  		            offsetY: 0,
//  		           textBaseline:'ideographic',
//  		           	textAlign:'center',
//  		            stroke: new ol.style.Stroke({
//  		                color: 'yellow',
//  		                width: 100
//  		            }),
//  		            fill: new ol.style.Fill({
//  		                color: 'black'
//  		            })
//  		        })
//  		    });
		
//  		feature.setStyle(style);
// 		    src.addFeature(feature);
// 		}
		function ajaxGetJson( url , callback ){
			$.ajax({
			    url: url,
			    type: "GET",
			    //async: true,
			    dataType: "json",
			    success: function( data ){
			    	if( data.resultCode != 00 ){
			    		alert( data.resultMsg );
			    	}
			    	if ( callback ) {
			    		callback( data );
			        }
			    },
			    error: function ( request , status , error){        
			    	alert(error);
			    }
			});
		}		
		
		function circleStyle(){
			circleStyle['clean'] = new ol.style.Circle({
	        	radius: 10,
 	    	   	fill: new ol.style.Fill({
 	    	   		color: "rgba(26, 165, 49, 0.933)"
 	    	   	}),
 	    		stroke: new ol.style.Stroke({
 	    	       	color: "rgba(26, 165, 49, 0.933)",
 	    	    width: 2
 	    	    })
 	    	});
			
			circleStyle['occur'] = new ol.style.Circle({
 	    	   	fill: new ol.style.Fill({
 	    	   		color: "rgba(255, 149, 79, 0.75)"
 	    	   	}),
 	    		stroke: new ol.style.Stroke({
 	    	       	color: "rgba(255, 149, 79, 0.75)",
 	    	    	width: 2
 	    	    })
 	    	});
			
			return circleStyle;
		}
		function addTextCircle(src) {
			
			var featureLsit = [];
			var circleStyleArray = circleStyle();
			
			var url = '/covid19.do'
			ajaxGetJson(url,function(result){
				var resultList = result.resultValue;
	 			for(var i = 0 ; i < resultList.length ; i++){
	 				var data = resultList[i];
	 				//console.log(data);
	 				var feature = new ol.Feature({
	 					  geometry: new ol.geom.Point(ol.proj.fromLonLat([parseFloat(data.lat),parseFloat(data.lon)])),
	 					  info : data
	 				});
	 				var style = new ol.style.Style({
	 					text :  new ol.style.Text({
		 	              	text: data.localOccCnt,
		 	              	overflow: true,
		 	               	font: "14px",
		 	               	fill: new ol.style.Fill({ 
		 	               		color: "rgba(255, 255, 255, 1)" 
		 	               	}),
		 	               	stroke: new ol.style.Stroke({
		 	            	       	color: "rgba(50,50,50,1)",
		 	            	       	width: 0.5
		 	            	    }),
		 	               	padding: [0,0,0,0],
//		 	               	offsetY: 15
		 	             })
	 				})
	 				
	 			    style.setImage(circleStyleArray[data.localOccCnt < 1 ? 'clean' : 'occur']);
	 			    style.getImage().setRadius(data.localOccCnt < 1 ? 10 : data.localOccCnt * 3);
	 			    feature.setStyle(style);
	 			    featureLsit.push(feature);
	 			    src.addFeature(feature);
	 			}
	 			sumLabel(result.resultSum);
			});
			$("#sumLabel").css('display','block');
		}
		
		function sumLabel(sum){
			$("#allPeople").text(comma(sum.defCnt));
			$("#curePeople").text(comma(sum.isolClearCnt));
			$("#deadPeople").text(comma(sum.deathCnt));
		}
 		function initMap(){
 			map = new ol.Map({
 	            target: 'map',
 	            layers: [
 	            	//satelliteLayer,baseLayer,hybridLayer,seoulLayer,vectorLayer
 	            	layerSet['baseLayer'],layerSet['seoulLayer'],layerSet['satelliteLayer'],layerSet['hybridLayer']
 	            	,layerSet['vectorLayer']
 	            ],
 	            view: new ol.View({
 	                //경도,위도 (EPSG : 4326)
 	                center: ol.proj.transform([127.090616,36.502142], 'EPSG:4326', 'EPSG:900913'),
 	                zoom: 7,
 	                minZoom: 6,
 	                maxZoom: 15    
 	            }),
 	            controls : ol.control.defaults({
 	                attribution : false,
 	                zoom : false,
 	            })
 	          });
 			map.on('singleclick',function(evt){
 				var pixel = evt.pixel;
 	        	var coord = evt.coordinate;
 	        	var zoom = map.getView().getZoom();
 				
 	        	//console.log(inverseTransform(coord));
 	        	
 	        	var hitLayer = null;
 	      		var hitFeature = null;
 	      		
 	      		var funcFilter = function(layer) {
 	      			var name = layer.get("name");
 	      			return (layer.getVisible() && (name == "vectorLayer" || name == "multibeam" || name == "ais" || name == "buoy" || name == "radar"));
 	      		};
 	      		
 	      		var opt = { layerFilter: funcFilter, hitTolerance: 10 };
 	      		
 	      		var hit = map.hasFeatureAtPixel(pixel, opt);
 	      		if (hit) {
 	      			map.forEachFeatureAtPixel(pixel, function (feature, layer) {
 	      				if (hitFeature != null) return;
 	      				hitLayer = layer;
 	      				hitFeature = feature;
 	      			}, 
 	      			opt);
 	      		}
 	      		
 	      		if (hitFeature) {
 	      			var name = hitLayer.get("name");
 	    			console.log('asd'+name);
 	    			console.log('hitFeature'  + hitFeature.get('info'));
 	    			var info = hitFeature.get('info');
 	    			var movePopup = popupPixel(hitFeature.get('geometry').B);
 	    			$("#popup").css("display","block");
 	    			$("#popup").css("left",movePopup[0]) // 클릭위치로 이동 
 		        	$("#popup").css("top",movePopup[1]) // 클릭위치로 이동  
 		        	$("#popup #title").text(info.location);
	 	        	$("#popup #gubun").text(info.gubun);
	 	        	$("#popup #dt").text(info.dt);
	 	        	$("#popup #defCnt").text(info.defCnt);
	 	        	$("#popup #deathCnt").text(info.deathCnt);
	 	        	$("#popup #isolClearCnt").text(info.isolClearCnt);
	 	        	$("#popup #lon").text(info.lon);
	 	        	$("#popup #geometry").val(hitFeature.get('geometry').B)
					 	      		
 	      		}else{
 	      			$("#popup").css("display","none");
 	      		}
// 	        	map.getView().setCenter(coord);
 			})
 			
 			
//  			map.on('moveend',function(){
 				
 				
//  			});
// 			map.on('pointerdrag',function(){
//  				alert('pointerdrag');
//  			});
// 			map.on('pointermove',function(){
//  				alert('pointermove')
//  			});
  			map.on('postrender',function(){
  				//console.log('postrender');
  				if($("#popup").css('display') == 'block'){
  					var geometry = $("#popup #geometry").val().split(',');
  					//console.log('geometry' + map.getPixelFromCoordinate(geometry));
  					var movePixel = popupPixel(geometry);
					if($("#popup").css('left') != movePixel[0] 
						&& $("#popup").css('top') != movePixel[0] ){
	  					$("#popup").css('left',movePixel[0]);
	  					$("#popup").css('top',movePixel[1]);
					}
  					
  				}
  			});
//  			map.on('precompose ',function(){
//  				alert('precompose ')
//  			});
 		}
        
        /*Element Tag 를 이용한 tab 생성*/
//         var marker = new ol.Overlay({
// 		  position: ol.proj.fromLonLat([127.090616,37.502142]),
// 		  positioning: 'center-center',
// 		  element: document.getElementById('marker'),
// 		  stopEvent: false
// 		});
        
		//map.addOverlay(marker);
        
		function popupPixel(geometry){
			var pixel = map.getPixelFromCoordinate(geometry);
			var layoutTopWt = +Number($(".top").css("width").replace('px',''));
			var popLeft = (pixel[0]+layoutTopWt+35)+'px';
			var popTop = (pixel[1]-60)+'px';
			return [popLeft,popTop]
		}
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
	
	<div id="sumLabel" style="height: 58px;position: absolute;z-index: 10;left: 50%;font-size: initial;top:10px;background-color: #ffff; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);border-radius: 10px;/* transform:translate(-50%, -50%); */
    border: 1px solid rgba(0, 0, 0, 0.2);display:none;">
		<p style="line-height: 2;float:left;margin:5px 5px;font-family: Arial, Helvetica, sans-serif;user-select: none;font-weight: bold;color: #333;color: #333;">확진자: <span id="allPeople"> </span></p>
		<p style="line-height: 2;float:left;margin:5px 5px;font-family: Arial, Helvetica, sans-serif;user-select: none;font-weight: bold;color: #333;color:rgb(47,181,105);">완치: <span id="curePeople"> </span></p>
		<p style="line-height: 2;float:left;margin:5px 5px;font-family: Arial, Helvetica, sans-serif;user-select: none;font-weight: bold;color: #333;color: red;">사망: <span id="deadPeople"> </span></p>
		<p style="text-align:center;line-height: 0;margin:5px 5px;font-family: Arial, Helvetica, sans-serif;user-select: none;font-weight: bold;color: #333;color: red;">2020-07-27</p>
	</div>
	<div id="map" class="map"></div>
	<div id="popup" style="height: 58px;position: absolute;z-index: 1;font-size: initial;background-color: #ffff; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);border-radius: 10px;/* transform:translate(-50%, -50%); */
    border: 1px solid rgba(0, 0, 0, 0.2); width: 185px;height: 130px;"><!-- style="display:none;" -->
		<div class="title">
			<p style="margin: 0px"><span id="gubun"></span> 확진자</p></div>
		<div class="" style="margin: 0 10px;letter-spacing: -1px;">
			<p style="font-family: '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif;line-height: 1.5;margin:0px;font-size: 12px;">일자 : <span id="dt" style="color:black;font-weight: 900;"></span></p>
			<p style="font-family: '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif;line-height: 1.5;margin:0px;font-size: 12px;">누적 확진 : <span id="defCnt" style="color:black;font-weight: 900;"></span></p>
			<p style="font-family: '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif;line-height: 1.5;margin:0px;font-size: 12px;">사망 : <span id="deathCnt" style="color:black;font-weight: 900;"></span></p>
			<p style="font-family: '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif;line-height: 1.5;margin:0px;font-size: 12px;">격리해제 : <span id="isolClearCnt" style="color:black;font-weight: 900;"></span></p>
			<p style="font-family: '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif;line-height: 1.5;margin:0px;font-size: 12px;">10만명당 감염율 : <span id="lon" style="color:black;font-weight: 900;"></span></p>
			<input type="hidden" id="geometry"/>
		</div>	
	</div>
    <div id ="labels" style="position: absolute;">
      <!-- Clickable label for Vienna -->
     	<div id="marker" title="Marker"></div>
      <!-- Popup -->
    </div>

	<div style=" box-shadow: 1px 1px 1px 1px #d0cec7;height: 170px;width: 160px;position: relative;top: -694px;left: 10px;background-color: white;border:1px solid #ddd; z-index: 10">
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
  </body>
</html>