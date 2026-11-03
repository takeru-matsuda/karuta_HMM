load('result.mat')
for i=1:nfuda
    fuda = fudas{i};
    for j=1:5
        if recog_fuda{i}{j} == 0 || ~isfinite(recog_time{i}{j})
            disp(['ans: ' fuda ' (' num2str(j) '), recog: undecided']);
            continue;
        end
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
