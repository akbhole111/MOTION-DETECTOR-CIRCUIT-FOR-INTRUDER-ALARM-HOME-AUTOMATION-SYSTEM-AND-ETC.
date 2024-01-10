%Take input images
%Reference image
I1 = imread('/MATLAB Drive/dsp image database/sampleimg0.png');
figure;
imshow(I1)
title('Reference image')

for i = 0:6
    I2 = imread(['/MATLAB Drive/dsp image database/sampleimg' num2str(i) '.png']);
    figure;
    subplot(2,2,1)
    imshow(I2)
    title(['Sample image ' num2str(i)]);

    %Compare the image with reference
    I1gray = im2gray(I1);
    I2gray = im2gray(I2);
    diffgray = imabsdiff(I2gray, I1gray);
    subplot(2,2,2)
    imshow(diffgray)
    title(['Gray scale image of sample image ' num2str(i)]);
    disp(['For sample image ' num2str(i) '-']);
    disp(['The maximum value on this image is ', num2str(max(max(diffgray)))])
    

    %Convert images to Black & White and visualize
    bindiffgray = imbinarize(diffgray);
    subplot(2,2,3)
    imshow(bindiffgray)
    title(['Binary image of sample image ' num2str(i) '    ']);
    
    %Check for significant difference
    imageSize = size(I1gray,1)*size(I1gray,2);
    total = sum(sum(bindiffgray));
    if total > (0.05*imageSize)
        disp('Some one is at your door')
    else
        disp('No change in the frames')
    end
    
    %We can see here that the image is noisy, Threshold the images to remove the noise
    diffgray(diffgray < 35) = 0;
    bindiffgray = imbinarize(diffgray);
    subplot(2,2,4)
    imshow(bindiffgray)
    title('Binary image after noise removal');
    
    %Check for significant difference
    imageSize = size(I1gray,1)*size(I1gray,2);
    total = sum(sum(bindiffgray));
    disp(['For sample image ' num2str(i) ' after noise removal - ']);
    if total > (0.05*imageSize)
        disp('Some one is at your door');disp(' ');
    else
        disp('No change in the frames');disp(' ');        
    end

end
