classdef RRA2 < PROBLEM
% <problem> <RRA>
% Constrained benchmark MOP proposed by Ma and Wang
% Amount --- --- Total amount of resources


%------------------------------- Reference --------------------------------
% Z. Ma and Y. Wang, Evolutionary constrained multiobjective optimization:
% Test suite construction and performance comparisons. IEEE Transactions on
% Evolutionary Computation, 2019.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    properties(Access = private)
        Amount;
        Type ;
        G_hat;
        chi_G
        R;
    end
    
    methods
        %% Initialization
        function obj = RRA2()
            [obj.Amount] = obj.Global.ParameterSet(round(obj.Global.D/10), 1);
            
            %filename = strcat('test_G', int2str(obj.Type), '.txt');
            %filename = strcat('G', int2str(obj.Type), '.csv');
            filename = strcat('G2.csv');
            G = csvread(filename);
            obj.Global.D = size(G, 1);
            
            %filename = strcat('test_Risk.txt');
            filename = strcat('Risk.csv');
            obj.R = csvread(filename);
            obj.Global.M = size(obj.R, 1);
            
            
            %obj.Global.lower    = zeros(1,obj.Global.D);
            %obj.Global.upper    = ones(1,obj.Global.D);
            %obj.Global.encoding = 'real';
            obj.Global.encoding = 'permutation';
            
            obj.G_hat = eye(size(G, 1)) + G;
            obj.chi_G = obj.G_hat > 0;
            
            disp(size(obj.R))
            disp(size(obj.G_hat))

        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj, X)
            %disp(X)
            X = X <= obj.Amount;
            X = 0.5*X;
            %disp(X)
            M       = size(obj.R, 1);
            PopObj  = zeros(size(X, 1), M);
            
            for c = 1: size(PopObj, 1) 
                OneObj = zeros(1, M);
                for j = 1:M
                    OneObj(j) = sum((obj.chi_G - (diag(X(c,:))*obj.G_hat))*obj.R(j,:).'); 
                end
                PopObj(c,:) = OneObj;
            end
            %disp(PopObj)
        end
        %% Calculate constraint violations
        %function PopCon = CalCon(obj,X)
%            PopCon = sum(X,2) >= obj.Amount;
%        end        
    end
end