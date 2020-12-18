clear all;
clc;

vidReader = VideoReader('visiontraffic.avi','CurrentTime',11);
opticFlow = opticalFlowHS

h = figure;
movegui(h);
hViewPanel = uipanel(h,'Position',[0 0 1 1],'Title','Plot of Optical Flow Vectors');
hPlot = axes(hViewPanel)

frame_ind = 0;
% while hasFrame(vidReader)
while frame_ind < 3
    frameRGB = readFrame(vidReader);
    frameGray = rgb2gray(frameRGB);  
    flow = estimateFlow(opticFlow,frameGray);
    imshow(frameRGB)
    hold on
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',60,'Parent',hPlot);
    hold off
    pause(1)
    frame_ind = frame_ind + 1;
end

