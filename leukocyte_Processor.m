% =========================================================================
% PROJECT: Digital Image Enhancement for Leukocyte Analysis
% OBJECTIVE:Automate contrast stretching and data normalization for 
%            medical-grade .tiff imaging datasets.
% =========================================================================

%% 1. Data Acquisition
% Locate all .tiff files in the working directory
allFiles = dir('*.tiff'); 
if isempty(allFiles)
    error('Error: No medical image files found in directory.');
end

%% 2. Universal Data Loader & Normalization
% Read the primary sample for analysis
img = imread(allFiles(1).name);

% Handle multi-layer bit-depths and alpha channels
% This ensures compatibility regardless of imaging hardware used.
if size(img, 3) > 3
    % Case: Remove 4th transparency/alpha layer
    img = img(:,:,1:3); 
elseif size(img, 3) == 1
    % Case: Convert grayscale data to RGB for standard processing
    img = cat(3, img, img, img); 
end

%% 3. Clinical Enhancement (Contrast Stretching)
% Calculate optimal intensity limits for the cell features
limits = stretchlim(img); 

% Map the image to a wider dynamic range to highlight the nucleus
enhanced = imadjust(img, limits, []);

%% 4. Visual Result Generation
% Create a side-by-side comparison for clinical reporting
figure('Name', 'Medical Image Enhancement Result');
subplot(1,2,1); 
imshow(img); 
title('Original Raw Cell Data');

subplot(1,2,2); 
imshow(enhanced); 
title('Enhanced for Clinical Analysis');
