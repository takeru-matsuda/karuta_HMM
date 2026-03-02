addpath('Lee_HMM');
[mfccs_train,~] = wav_to_mfcc('./train');
karuta_HMM_train(mfccs_train,30,10);
[mfccs_test,fudas] = wav_to_mfcc('./test');
nfuda = length(mfccs_test);
recog_time = cell(1,nfuda);
recog_fuda = cell(1,nfuda);
posterior = cell(1,nfuda);
recog_rate = zeros(1,nfuda);
for i=1:nfuda
    nmfcc = length(mfccs_test{i});
    recog_time{i} = cell(1,nmfcc);
    recog_fuda{i} = cell(1,nmfcc);
    posterior{i} = cell(1,nmfcc);
    for j=1:nmfcc
        [recog_time{i}{j},recog_fuda{i}{j},posterior{i}{j}]=karuta_HMM_recog(mfccs_test{i}{j},'models_state30/iter10.mat',0.9999,0.1);
        if recog_fuda{i}{j} == i
            recog_rate(i) = recog_rate(i)+1/nmfcc;
        end
    end
end
for i=1:nfuda
    fuda = fudas{i};
    for j=1:length(mfccs_test{i})
        [y0,Fs] = audioread(sprintf(['./test/' fuda '/' fuda '_test%d.wav'],num));
        y = kimariji(y0,Fs,recog_time{i}{j});
        audiowrite(sprintf(['./test_kimariji/' fuda '/' fuda '_test%d_kimariji.wav'],j),y,Fs);
        if recog_fuda{i}{j} == i
            ote = '';
        else
            ote = '  otetsuki';
        end
        disp(['ans: ' fudas{i} ' (' num2str(j) '), recog: ' fudas{recog_fuda{i}{j}} ote]);
        sound(y,Fs);
        pause(2)
    end
end
