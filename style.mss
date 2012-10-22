Map {
  background-color: #b8dee6;
}

#countries {
  ::outline {
    line-color: #85c5d3;
    line-width: 2;
    line-join: round;
  }
  polygon-fill: #fff;
}

#Roads{
  line-color: #AAAAAA;
  line-width: 1;
  
  [type='cycleway']{
	
    
    ::outline {
      line-color: #008800;
  	line-width: 6;
      }
    
    ::inner{
      line-color: #55EE55;
  	line-width: 3;
      }
  }
}

#hillshadesrtm, #slopesrtmcolor {
  raster-scaling: bilinear;
    // note: in TileMill 0.9.x and earlier this is called raster-mode
    raster-comp-op: multiply;
  }


#hillshadesrtm {
  raster-opacity:1;
}


#slopesrtmcolor {
  raster-opacity:1;
}


#contour [zoom>13]{
  line-width:0.5;
  line-color:#168;
  line-smooth: 0.5;
    ::labels[zoom>14{
  	text-name: '[elev]';
  	text-face-name: "DejaVu Sans Book";
    text-placement: line;
    }
}


#contour50[zoom>10][zoom<14]{
  line-width:1;
  line-color:#168;
  line-smooth: 0.5;
  ::labels[zoom>12]{
  	text-name: '[elev]';
  	text-face-name: "DejaVu Sans Book";
    text-placement: line;
    }
}
