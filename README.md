# Pseudo-CT-Reconstruction
A code package as a supplement document of paper "Pseudo-CT Image Reconstruction from Limited Projections using a MiSpinner and Standard Small-Animal Imager" in MATLAB version

Uploaded Code includes two parts:

GUI code: Main code of the paper, GUI mode in MATLAB version
          You can start from the FileSelection.m file and follow the instructions step by step. (Recommended to test with dicom file)
          It includes three parts: Image Read and pre-processing
                                   CT reconstruction in 2D/3D (FBP, FanRecon, FDK)
                                   Post-processing with Total Variation Algorithm
                                  
Hough_RANSAC: a template code to show strategy: Hough Transform + RANSAC in edge detection
              This stratey aims to fix off-centering problem in projection images.
