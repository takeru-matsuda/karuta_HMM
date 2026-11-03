function y=kimariji(y0,Fs,kimariji_frame)
    frame_size = round(0.030*Fs);
    frame_shift = frame_size-round(0.020*Fs);
    kimariji_sample = frame_shift*(kimariji_frame-1)+frame_size;
    y = y0(1:kimariji_sample);
end
