# ComputerVision

This project contains detailed computer vision techiniques. The lecture slides and assignments are from [CS543 UIUC Spring 2018](http://slazebni.cs.illinois.edu/spring18/).

## Machine Problems

The course offered some of the standered but immensely interesting machine problems in computer vision. 

### [Colorizing Prokudin-Gorskii images of the Russian Empire](MachineProblems/1\Colorizing_Prokudin-Gorskii_images_of_the_Russian_Empire)

The goal of this assignment is to learn to work with images by taking the digitized Prokudin-Gorskii glass plate images and automatically producing a color image with as few visual artifacts as possible. In order to do this, you will need to extract the three color channel images, place them on top of each other, and align them so that they form a single RGB color image.

### [Shape From Shading](MachineProblems/2\Shape_from_Shading)

The goal of this assignment is to implement shape from shading by assuming object to be standered lambertian in nature. The details are mentioned in the report. From provided sets of images, the 3D reconstruction shown below is created.
<p align="center">
  <img width="250" height="250" src="utils/3dFace.gif">
</p>

### [Blob Detector](3\MachineProblems/3\Scale_Space_blob_detection)

The goal of the assignment is to implement a Laplacian blob detector.This machine problem is based on application of the scale and rotation invariance in finding the features (corners) through laplacian of gaussian filter. The blob detectors 
detect the image corners and represent as blobs which plays an important role in tracking and object detection. 
