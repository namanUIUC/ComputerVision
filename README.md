# Computer Vision @ UIUC

This project contains detailed computer vision techiniques. The lecture slides and assignments are from [CS543 UIUC Spring 2018](http://slazebni.cs.illinois.edu/spring18/).

**Instructor: Svetlana Lazebnik**  (slazebni -at- illinois.edu)

<p align="center">
  <img width="50%" height="50%" src="utils/logo.png">
</p>

## Overview

In the simplest terms, computer vision is the discipline of `teaching machines how to see`. This field dates back more than fifty years, but the recent explosive growth of digital imaging and machine learning technologies makes the problems of automated image interpretation more exciting and relevant than ever. There are two major themes in the computer vision literature: 3D geometry and recognition. The first theme is about using vision as a source of **metric 3D information**: given one or more images of a scene taken by a camera with known or unknown parameters, how can we go from 2D to 3D, and how much can we tell about the 3D structure of the environment pictured in those images? The second theme, by contrast, is all about vision as a source of **semantic information**: can we recognize the objects, people, or activities pictured in the images, and understand the structure and relationships of different scene components just as a human would? This course will provide a coherent perspective on the different aspects of computer vision, and give students the ability to understand state-of-the-art vision literature and implement components that are fundamental to many modern vision systems.

### Prerequisites

Basic knowledge of probability, linear algebra, and calculus. MATLAB programming experience and previous exposure to image processing are highly desirable. 



## Syllabus

1. **Image formation and low-level vision**
   1. Camera models
   2. Light and color
   3. Linear filters and edges
   4. Feature extraction
   5. Optical flow and feature tracking
2. **Grouping and fitting**
   1. Hough transform
   2. RANSAC
   3. Alignment, image stitching
3. **Geometric vision**
   1. Camera calibration
   2. Epipolar geometry
   3. Two-view and multi-view stereo
   4. Structure from motion
4. **Recognition and beyond**
   1. Statistical learning framework
   2. Image classification
   3. Deep convolutional neural networks
   4. Object detection
   5. Segmentation

## Course Content - DB

I have create a database to download the lecture materials from the course. To download the material:

```
git clone https://github.com/namanUIUC/ComputerVision.git
cd ComputerVision
bash course_material_DB.sh
```

Demo:

<p align="center">
  <img width="50%" height="50%" src="utils/db.png">
</p>

## Machine Problems

### [Colorizing Prokudin-Gorskii images of the Russian Empire](src/1-Colorizing_Prokudin-Gorskii_images_of_the_Russian_Empire)

#### Background

[Sergei Mikhailovich Prokudin-Gorskii](http://en.wikipedia.org/wiki/Prokudin-Gorskii) (1863-1944) was a photographer who, between the years 1909-1915, traveled the Russian empire and took thousands of photos of everything he saw. He used an early color technology that involved recording three exposures of every scene onto a glass plate using a red, green, and blue filter. Back then, there was no way to print such photos, and they had to be displayed using a special projector. Prokudin-Gorskii left Russia in 1918. His glass plate negatives survived and were purchased by the Library of Congress in 1948. Today, a digitized version of the Prokudin-Gorskii collection is [available online](http://www.loc.gov/exhibits/empire/gorskii.html).

<p align="center">
  <img width="50%" height="50%" src="utils/outs/1-Colorizing_Prokudin-Gorskii_images_of_the_Russian_Empire/Collage/6.jpg">
</p>


#### Overview

The goal of this assignment is to learn to work with images by taking the digitized Prokudin-Gorskii glass plate images and automatically producing a color image with as few visual artifacts as possible. In order to do this, you will need to extract the three color channel images, place them on top of each other, and align them so that they form a single RGB color image. Some starter MATLAB code is available [here](http://slazebni.cs.illinois.edu/spring18/assignment0/sample_code.m), though you are not required to use it.

### [Shape From Shading](src/2-Shape_from_Shading)

#### Overview

The goal of this assignment is to implement shape from shading as described in Lecture 4

 (see also Section 2.2.4 of Forsyth & Ponce 2nd edition).

1. Download the **[sample code and data](http://slazebni.cs.illinois.edu/spring18/assignment1/assignment1_materials.zip)**. The data, in the `croppedyale` directory, consists of 64 images each of four subjects from the [Yale Face database](http://www.cad.zju.edu.cn/home/dengcai/Data/FaceData.html). The light source directions are encoded in the file names. The code consists of several .m functions. Your task will be to add some code to the top-level script, `run_me.m`, and to fill in the code in `photometric_stereo.m` and `get_surface.m`, as explained below. The remaining files are utilities to load the input data and display the output.

2. For each subject (subdirectory in croppedyale), read in the images and light source directions. This is accomplished by the function `LoadFaceImages.m` provided in the zip file (which, in turn, calls `getpgmraw.m` to read the PGM files). `LoadFaceImages` returns the images for the 64 light source directions and an *ambient* image (i.e., image taken with all the light sources turned off). 

3. Preprocess the data: subtract the ambient image from each image in the light source stack, set any negative values to zero, rescale the resulting intensities to between 0 and 1 (they are originally between 0 and 255).

   **Hint:** these operations can be done without using any loops whatsoever. You may want to look into MATLAB's `bsxfun` function.

4. Estimate the albedo and surface normals. For this, you need to fill in code in `photometric_stereo.m`, which is a function taking as input the image stack corresponding to the different light source directions and the matrix of of the light source directions, and returning an albedo image and surface normal estimates. The latter should be stored in a three-dimensional matrix. That is, if your original image dimensions are`h x w`, the surface normal matrix should be `h x w x 3`, where the third dimension corresponds to the x-, y-, and z-components of the normals. To solve for the albedo and the normals, you will need to set up a linear system as shown in slide 20 of Lecture 4.

   Hints:

   - To get the least-squares solution of a linear system, use MATLAB's backslash operator. That is, the solution to `Ax = b` is given by `x = A\b`.
   - If you directly implement the formulation of slide 20 of the lecture, you will have to loop over every image pixel and separately solve a linear system in each iteration. There is a way to get all the solutions at once by stacking the unknown **g** vectors for every pixel into a `3 x npix` matrix and getting all the solutions with a single application of the backslash operator.
   - You will most likely need to reshape your data in various ways before and after solving the linear system. Useful MATLAB functions for this include `reshape` and `cat`.
   - You may also need to use element-wise operations. For example, for two equal-size matrices X and Y, `X .* Y`multiplies corresponding elements, and `X.^2` squares every element. As before, `bsxfun` can also be a very useful function here.

5. Compute the surface height map by integration. The method is shown in slide 23 of Lecture 4, except that instead of continuous integration of the partial derivatives over a path, you will simply be summing their discrete values. Your code implementing the integration should go in the `get_surface.m` file. As stated in the slide, to get the best results, you should compute integrals over multiple paths and average the results. You should implement the following variants of integration:

   1. Integrating first the rows, then the columns. That is, your path first goes along the same row as the pixel along the top, and then goes vertically down to the pixel. It is possible to implement this without nested loops using the `cumsum` function.
   2. Integrating first along the columns, then the rows.
   3. Average of the first two options.
   4. Average of multiple random paths. For this, it is fine to use nested loops. You should determine the number of paths experimentally.

6. Display the results using functions `display_output` and `plot_surface_normals` included in the zip archive. 

<p align="center">
  <img width="250" height="250" src="utils/3dFace.gif">
</p>



### [Blob Detector](src/3-Scale_Space_blob_detection)

The goal of the assignment is to implement a Laplacian blob detector as discussed in the [this lecture](http://slazebni.cs.illinois.edu/spring18/lec09_sift.pptx). 

#### Algorithm outline

1. Generate a Laplacian of Gaussian filter.
2. Build a Laplacian scale space, starting with some initial scale and going for n iterations:
   1. Filter image with scale-normalized Laplacian at current scale.
   2. Save square of Laplacian response for current level of scale space.
   3. Increase scale by a factor k.
3. Perform nonmaximum suppression in scale space.
4. Display resulting circles at their characteristic scales.

<p align="center">
  <img width="50%" height="50%" src="utils/mp3-1.gif">
</p>

#### Test images

Here are [four images](http://slazebni.cs.illinois.edu/spring18/assignment2/assignment2_images.zip) to test your code, and [sample output images](http://slazebni.cs.illinois.edu/spring18/assignment2/assignment2_sample_output.zip) for your reference. Keep in mind, though, that your output may look different depending on your threshold, range of scales, and other implementation details. In addition to the images provided, also **run your code on at least four images of your own choosing**.

<p align="center">
  <img width="75%" height="75%" src="utils/mp3-2.jpg">
</p>
