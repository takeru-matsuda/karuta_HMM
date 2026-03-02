load('main')
for i=1:nfuda
    fuda = fudas{i};
    for j=1:5
        if recog_fuda{i}{j} == i
            ote = '';
        else
            ote = '  otetsuki';
        end
        disp(['ans: ' fudas{i} ' (' num2str(j) '), recog: ' fudas{recog_fuda{i}{j}} ote]);
        [y,Fs] = audioread(sprintf(['./test_kimariji/' fuda '/' fuda '_test%d_kimariji.wav'],j));
        sound(y,Fs);
        pause(2)
    end
end
