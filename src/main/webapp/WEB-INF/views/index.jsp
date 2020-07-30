<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/ol.js"></script>
<link rel="stylesheet" type="text/css" href="/css/ol.css" />
 <script>
 $(function () {

     var pureCoverage = false;
     // if this is just a coverage or a group of them, disable a few items,
     // and default to jpeg format
     var format = 'image/png';
     var bounds = [126.767486572266, 37.4305419921875,
                   127.184204101563, 37.6950416564941];
     if (pureCoverage) {
       document.getElementById('antialiasSelector').disabled = true;
       document.getElementById('jpeg').selected = true;
       format = "image/jpeg";
     }

     var supportsFiltering = true;
     if (!supportsFiltering) {
       document.getElementById('filterType').disabled = true;
       document.getElementById('filter').disabled = true;
       document.getElementById('updateFilterButton').disabled = true;
       document.getElementById('resetFilterButton').disabled = true;
     }

     var mousePositionControl = new ol.control.MousePosition({
       className: 'custom-mouse-position',
       target: document.getElementById('location'),
       coordinateFormat: ol.coordinate.createStringXY(5),
       undefinedHTML: '&nbsp;'
     });
     
     
     
     
     var untiled = new ol.layer.Image({
    	 visible: false,
       source: new ol.source.ImageWMS({
         ratio: 1,
         url: 'http://localhost:8000/geoserver/student/wms',
         params: {'FORMAT': format,
                  'VERSION': '1.1.1',  
               "LAYERS": 'student:tl_scco_sig_w',
               "exceptions": 'application/vnd.ogc.se_inimage',
         }
       })
     });
     var tiled = new ol.layer.Tile({
       visible: true,
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
     
     var projection = new ol.proj.Projection({
         code: 'EPSG:404000',
         units: 'degrees',
         global: false
     });
     
     var map = new ol.Map({
       controls: ol.control.defaults({
         attribution: false
       }).extend([mousePositionControl]),
       target: 'map',
       layers: [
         untiled,
         tiled
//         , untiled1,
//          tiled1
         
       ],
       view: new ol.View({
          projection: projection
       })
     });
     map.getView().on('change:resolution', function(evt) {
       var resolution = evt.target.get('resolution');
       var units = map.getView().getProjection().getUnits();
       var dpi = 25.4 / 0.28;
       var mpu = ol.proj.METERS_PER_UNIT[units];
       var scale = resolution * mpu * 39.37 * dpi;
       if (scale >= 9500 && scale <= 950000) {
         scale = Math.round(scale / 1000) + "K";
       } else if (scale >= 950000) {
         scale = Math.round(scale / 1000000) + "M";
       } else {
         scale = Math.round(scale);
       }
       document.getElementById('info').innerHTML = "Scale = 1 : " + scale;
     });
     map.getView().fit(bounds, map.getSize());
     map.on('singleclick', function(evt) {
       document.getElementById('nodelist').innerHTML = "Loading... please wait...";
       var view = map.getView();
       var viewResolution = view.getResolution();
       var source = untiled.get('visible') ? untiled.getSource() : tiled.getSource();
       var url = source.getGetFeatureInfoUrl(
         evt.coordinate, viewResolution, view.getProjection(),
         {'INFO_FORMAT': 'text/html', 'FEATURE_COUNT': 50});
       if (url) {
         document.getElementById('nodelist').innerHTML = '<iframe seamless src="' + url + '"></iframe>';
       }
     });

        });
    </script>
</head>
<body>
    <div id="map"></div>
    <div id="info"></div>
    <div id="nodelist"></div>

</body>
</html>