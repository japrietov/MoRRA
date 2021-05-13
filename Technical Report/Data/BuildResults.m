percentages = {'10p', '25p', '50p'};
problems    = {'RRA1', 'RRA2', 'RRA3'};
%percentages = {'10p'};
%problems    = {'RRA1'};



for per_i = 1:length(percentages)
    per = percentages{per_i};
    for pro_i = 1:length(problems)
        pro = problems{pro_i};
        x = strcat('./Data/RRA/', per, '/RVEA/RVEA_', pro, '_M3_D631_1.mat');
        storedStructure = load(x, 'result');
        resultLoaded = getfield(storedStructure, 'result');
        %resultLoaded{1}
        resultLoaded = resultLoaded{2};
        
        fullDec = zeros(size(resultLoaded, 2), size(resultLoaded(1).dec, 2));
        fullObj = zeros(size(resultLoaded, 2), size(resultLoaded(1).obj, 2));

        for i=1: size(resultLoaded, 2)
            fullDec(i,:) = resultLoaded(i).dec;
            fullObj(i,:) = resultLoaded(i).obj;
        end
        C = {fullDec, fullObj};
        
        for j=2: 20
            x = strcat('./Data/RRA/', per, '/RVEA/RVEA_', pro, '_M3_D631_', int2str(j), '.mat');
            storedStructure = load(x, 'result');
            resultLoaded1 = getfield(storedStructure,'result');
            resultLoaded1 = resultLoaded1{2};

            fullDec = zeros(size(resultLoaded1, 2), size(resultLoaded1(1).dec, 2));
            fullObj = zeros(size(resultLoaded1, 2), size(resultLoaded1(1).obj, 2));

            for i=1: size(resultLoaded1, 2)
                fullDec(i,:) = resultLoaded1(i).dec;
                fullObj(i,:) = resultLoaded1(i).obj;
            end

            %fullDecFinal(:,:,j) = fullDec;
            %fullObjFinal(:,:,j) = fullObj;
            
            C(j, :) = {fullDec, fullObj};
        end

        %obj = result{2}.obj;
        x = strcat('./Results/FullResults_', per, '_', pro, '.mat');
        %save('x', 'fullDecFinal', 'fullObjFinal')
        save(x, 'C')
    end
end