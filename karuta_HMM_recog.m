% example: karuta_HMM_recog(mfccs{i}{j},'models_state30/iter10.mat',0.99,0.1)
function [recog_time,recog_fuda,posterior]=karuta_HMM_recog(mfcc,model,threshold,w)
    mfcc = mfcc';
    load(model, 'mean_vec_i_m', 'var_vec_i_m', 'a_i_j_m');
    num_fuda = size(mean_vec_i_m,3);
    N = size(mean_vec_i_m,2);
    T = size(mfcc,2);
    ll = zeros(num_fuda,T);
    for k=1:num_fuda
        mean_vec_i = mean_vec_i_m(:,:,k);
        var_vec_i = var_vec_i_m(:,:,k);
        a_i_j = a_i_j_m(:,:,k);
        log_a_i_j = log(a_i_j);
        log_alpha = [0; -inf(N-1,1)];
        tmp = zeros(N-2,1);
        for t=1:T
            log_pred = log_sum_exp(log_alpha + log_a_i_j,1).';
            for i=2:N-1
                tmp(i-1) = logDiagGaussian(mfcc(:,t),mean_vec_i(:,i),var_vec_i(:,i));
            end
            log_alpha = log_pred + [-inf; tmp; -inf];
            ll(k,t) = log_sum_exp(log_alpha,1);
        end
    end
    posterior = zeros(num_fuda,T);
    for t=1:T
        posterior(:,t) = exp(w*(ll(:,t)-max(ll(:,t))));
        posterior(:,t) = posterior(:,t)/sum(posterior(:,t));
    end
    recog_time = inf;
    recog_fuda = 0;
    for t=1:T
        if max(posterior(:,t)) > threshold
            recog_time = t;
            [~,recog_fuda] = max(posterior(:,t));
            break
        end
    end
end

function value=log_sum_exp(x,dim)
    largest = max(x,[],dim);
    value = largest + log(sum(exp(x-largest),dim));
    value(largest == -inf) = -inf;
end
