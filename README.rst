Vélosm
******

Introduction
============

Trying to build a nice map for everyday cyclists.

To achieve that, we have at least the following goals:

* Make streets less visible that aren't cycliste friendly
* Exagerate relief data to know when it's going to be hard (or fun)

Getting things running
======================

We use TileMill http://mapbox.com/tilemill/ to configure the rendering of the
map.

If you create a directory in ~/Documents/MapBox/project/ containing the
``project.mml`` and ``style.mss`` files. Edit ``project.mml`` to set the different sources
(we will have to improve this!).

StreetData comes from OpenStreetMap, imported with http://imposm.org into
a http://postgis.refractions.net/ database.

At last, elevation data comes from the *Shuttle Radar Topography Mission (SRTM)* 

Elevation
=========

Most instructions are based on : http://mapbox.com/tilemill/docs/guides/terrain-data/

We used GDAL (http://www.gdal.org/) to convert those elevation data.

#. Get elevation data as a tiff file http://srtm.csi.cgiar.org/
#. Reproject into the "google"-projection::
  
    glwarp -s_srs EPSG:4269 -t_srs EPSG:900913 srtm_37_03.tif projected_srtm.tif::

#. Generate a hillshade file. It will cast a shadow on one side of the hills. We use -s 0.2 to exagerate the shading::

    gdaldem hillshade -s 0.2  -co compress=lzw projected_srtm.tif hillshade_srtm.tif

#. Generate a file that indicates steep slopes::

    gdaldem slope projected_srtm.tif slope_srtm.tif

#. However, we want some colors to that. We say that flat is white, 5° orange and 10° red. So we write a file ``slope_ramp.txt`` containing::

    0 255 255 255
    5 255 127 0
    10 255 0 0

#. We generate the file with colors::

    gdaldem color-relief -co compress=lzw slope_srtm.tif slope_ramp.txt slope_srtm_color.tif

#. We might also want some elevation contour, at 10 and 50 meters::

    gdal_contour -a elev projected_srtm.tif contour10.shp -i 10.0
    gdal_contour -a elev projected_srtm.tif contour50.shp -i 50.0

When importing the raster layers (``slope_srtm_color.tif`` and ``hilshade.tif``),
we need to specify the following styles in order to have a better interpolation
and to merge the layers::

    #hillshadesrtm, #slopesrtmcolor {
              raster-scaling: bilinear;
              raster-comp-op: multiply;
    }



