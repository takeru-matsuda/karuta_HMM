function y=kimariji(y0,Fs,kimariji_frame)
    frame_size_sec = 0.030;
    frame_shift_sec = 0.010;
    kimariji_second = frame_shift_sec*(kimariji_frame-1)+frame_size_sec;
    y = y0(1:ceil(kimariji_second*Fs));
end
