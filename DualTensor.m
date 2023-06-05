classdef DualTensor
    % DualTensor class (Multidimensional Matrix of Dual2 Numbers)
    %
    %   Constructors for the DualTensor class:
    %
    %   DualTensor(mat)  % builds a DualTensor having the same number of rows
    %                   % and columns of mat, where the element (i,j,k) is
    %                   % exactly the value of mat(i,j,k), but represented as
    %                   % a Dual2 of the predetermined degree.
    %
    % 
    %    
    
    properties
        dArr % is a nxm matrix of Dual2
    end
    methods (Hidden)
        % ------- Redefine the zeros -------
        function obj = zerosLike(obj,varargin)
            if nargin == 1
                error('Please provide the size');
            end
            % With 1-dim, considered a Squared Matrix
            if nargin == 2
                dim = varargin{1};
                obj(dim,dim,channels) = obj;
                for ch = 1:channels
                    for r = 1:dim
                        for c = 1:dim
                            obj(r,c,ch).dArr = Dual2(0);
                        end
                    end
                end
            end
            % With 2-dim, the user define both dimensions
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                channels = varargin{3};
                obj(nR,nC,channels) = obj;
                for ch = 1:channels
                    for r = 1:nR
                        for c = 1:nC
                            obj(r,c,ch).dArr = Dual2(0);
                        end
                    end
                end
            end
        end % END zeros
    % ------- Redefine the ones -------
    function obj = onesLike(obj,varargin)
        if nargin == 1
            error('Please provide the size');
        end
        % With 1-dim, considered a Squared Matrix
        if nargin == 2
            dim = varargin{1};
            obj(dim,dim) = DualMatrix; 
            for r = 1:dim
                for c = 1:dim
                    obj(r,c).dArr = Dual2(1);
                end
            end
        end
        % With 2-dim, the user define both dimensions
        if nargin == 3
            nR = varargin{1};
            nC = varargin{2};
            obj(nR,nC) = DualMatrix; 
            for r = 1:nR
                for c = 1:nC
                    obj(r,c).dArr = Dual2(1);
                end
            end
        end
    end % END ones
        % ------- Redefine the eye -------
        function obj = eyeLike(obj,varargin)
            if nargin == 1
                error('Please provide the size');
            end
            if nargin == 2 || ( nargin == 3 && ( varargin{1} == varargin{2}) )
                dim = varargin{1};
                obj(dim,dim) = obj;
                for r = 1:dim
                    for c = 1:dim
                        if r == c
                            obj(r,c).dArr = Dual2(1);
                        else
                            obj(r,c).dArr = Dual2(0);
                        end
                    end
                end
            else
                error('Eye requires that both dimensions are equal');
            end
        end % END eye
        % ------- Redefine the rand -------
        function obj = randLike(obj,varargin)
            if nargin == 1
                error('Please provide the size');
            end
            
            if nargin == 2
                dim = varargin{1};
                obj(dim,dim) = obj;
                for r = 1:dim
                    for c = 1:dim
                        obj(r,c).dArr = Dual2(rand(1,1));
                    end
                end
            end
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                obj(nR,nC) = obj;
                for r = 1:nR
                    for c = 1:nC
                        obj(r,c).dArr = Dual2(rand(1,1));
                    end
                end
            end
        end % END rand
        % ------- Redefine the randn -------
        function obj = randnLike(obj,varargin)
            if nargin == 1
                error('Please provide the size');
            end

            if nargin == 2
                dim = varargin{1};
                obj(dim,dim) = obj;
                for r = 1:dim
                    for c = 1:dim  
                        obj(r,c).dArr = Dual2(randn(1,1));
                    end
                end
            end
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                obj(nR,nC) = obj;
                for r = 1:nR
                    for c = 1:nC
                        obj(r,c).dArr = Dual2(randn(1,1));
                    end
                end
            end
        end % END randn
    end
    
    methods
        % Constructor
        function obj = DualTensor(mat, mat_du)
            % DualTensor constructor
            if nargin ~= 0
                if nargin < 2
                    mat_du = zeros(size(mat));
                end
                if any( size(mat) ~= size(mat_du))
                    error('The matrices for the real part and dual part must have same size');
                end
                [nR,nC,channels] = size(mat);
                obj(nR,nC,channels)=obj;
                for ch = 1:channels
                    for r = 1:nR
                        for c = 1:nC
                            if isreal(mat)
                               obj(r,c,ch).dArr = Dual2(mat(r,c,ch), mat_du(r,c,ch));
                            end
                        end
                    end
                end
            end
        end % constructor
        
        function disp(obj)
            [nR, nC, channels] = size(obj);
            for ch = 1:channels
                fprintf('Channel [%i]\n',ch);
                for r = 1:nR
                    for c = 1:nC
                        fprintf('(%f, %+fε)', getReal(obj(r,c,ch).dArr), getDual(obj(r,c,ch).dArr));
                        if c ~= nC
                            fprintf(' , ');
                        end
                    end
                    fprintf('\n');
                end
                    fprintf('\n-----------');
                    fprintf('\n');
            end
        end % disp
       

        function d2 = getAsDual2(obj, i, j, ch) % get the Dual Number at row i and column j
             d2 = obj(i,j,ch).dArr;
        end
        
        function mat_re = getReal(obj) % get the matrix extracting real values at row i and column j only
            mat_re = zeros(size(obj));
            
            for ch = 1:size(obj,3)
                for i=1:size(obj,1)
                    for j=1:size(obj,2)
                        d2 = getAsDual2(obj,i,j,ch);
                        mat_re(i,j,ch) = getReal(d2);
                    end
                end
            end
        end

        function mat_du = getDual(obj) % get the matrix extracting dual values at row i and column j only
            mat_du = zeros(size(obj));

            for ch = 1:size(obj,3)
                for i=1:size(obj,1)
                    for j=1:size(obj,2)
                        d2 = getAsDual2(obj,i,j,ch);
                        mat_du(i,j,ch) = getDual(d2);
                    end
                end
            end
        end
 
        function abs_as_a_new_DualTensor = abs(obj) % return a tensor where element i,j,ch is defined as |z|=|a|+sign(a)*eps        
           
            mat_re = abs(getReal(obj));
            mat_du = sign(getReal(obj));
            abs_as_a_new_DualTensor = DualTensor(mat_re, mat_du);
        end
        
        %-BEGIN ARITHMETIC OPERATIONS ----------------------------------------
        % Aritmetic operations between two DualTensor or between
        % a DualTensor and a double/Dual2
        
        function dTen3 = plus(dTen1, dTen2) % element-wise addition
           
           dTen3 = zeros(size(dTen1,1), size(dTen1,2), size(dTen1,3), 'like', DualTensor);

           if isa(dTen2, 'double') % addition between DualTensor and a double
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr + dTen2; % addition of a DualTensor by a double
                        end
                   end
               end
           elseif(isa(dTen2, 'Dual2'))
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr + dTen2; % addition of a DualTensor by a Dual2
                        end
                   end
               end
           else
               if size(dTen1,1) ~= size(dTen2,1) || size(dTen1,2) ~= size(dTen2,2) || size(dTen1,3) ~= size(dTen2,3)
                    error ('The two DualTensor must have the same length');
               else
                    for ch= 1:size(dTen1,3) 
                        for r=1:size(dTen1,1)
                            for c=1:size(dTen1,2)
                                if isa(dTen2(r,c,ch),'double')
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr + dTen2(r,c,ch);
                                else
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr + dTen2(r,c,ch).dArr;
                                end
                            end
                        end
                    end
               end
           end
        end % plus
        


        function dTen3 = minus(dTen1, dTen2) % element-wise subtraction
           dTen3 = zeros(size(dTen1,1), size(dTen1,2), size(dTen1,3), 'like', DualTensor);

           if isa(dTen2, 'double') % addition between DualTensor and a double
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr - dTen2; % subtraction of a DualTensor by a double
                        end
                   end
               end
           elseif(isa(dTen2, 'Dual2'))
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr - dTen2; % subtraction of a DualTensor by a Dual2
                        end
                   end
               end
           else
               if size(dTen1,1) ~= size(dTen2,1) || size(dTen1,2) ~= size(dTen2,2) || size(dTen1,3) ~= size(dTen2,3)
                    error ('The two DualTensor must have the same length');
               else
                    for ch= 1:size(dTen1,3) 
                        for r=1:size(dTen1,1)
                            for c=1:size(dTen1,2)
                                if isa(dTen2(r,c,ch),'double')
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr - dTen2(r,c,ch);
                                else
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr - dTen2(r,c,ch).dArr;
                                end
                            end
                        end
                    end
               end
           end
        end % minus


        
        function dTen3 = times(dTen1, dTen2) % element-wise product
           
           dTen3 = zeros(size(dTen1,1), size(dTen1,2), size(dTen1,3), 'like', DualTensor);

           if isa(dTen2, 'double') % product between DualTensor and a double
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr * dTen2; % product of a DualTensor by a double
                        end
                   end
               end
           elseif(isa(dTen2, 'Dual2'))
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr * dTen2; % product of a DualTensor by a Dual2
                        end
                   end
               end
           else
               if size(dTen1,1) ~= size(dTen2,1) || size(dTen1,2) ~= size(dTen2,2) || size(dTen1,3) ~= size(dTen2,3)
                    error ('The two DualTensor must have the same length');
               else
                    for ch= 1:size(dTen1,3) 
                        for r=1:size(dTen1,1)
                            for c=1:size(dTen1,2)
                                if isa(dTen2(r,c,ch),'double')
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr * dTen2(r,c,ch);
                                else
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr * dTen2(r,c,ch).dArr;
                                end
                            end
                        end
                    end
               end
           end
        end % mtimes
        

        function dTen3 = rdivide(dTen1, dTen2) % element-wise division
           
            dTen3 = zeros(size(dTen1,1), size(dTen1,2), size(dTen1,3), 'like', DualTensor);

           if isa(dTen2, 'double') % division between DualTensor and a double
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr / dTen2; % division of a DualTensor by a double
                        end
                   end
               end
           elseif(isa(dTen2, 'Dual2'))
               for ch= 1:size(dTen1,3) 
                   for r=1:size(dTen1,1)
                        for c=1:size(dTen1,2)
                            dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr / dTen2; % division of a DualTensor by a Dual2
                        end
                   end
               end
           else
               if size(dTen1,1) ~= size(dTen2,1) || size(dTen1,2) ~= size(dTen2,2) || size(dTen1,3) ~= size(dTen2,3)
                    error ('The two DualTensor must have the same length');
               else
                    for ch= 1:size(dTen1,3) 
                        for r=1:size(dTen1,1)
                            for c=1:size(dTen1,2)
                                if isa(dTen2(r,c,ch),'double')
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr / dTen2(r,c,ch);
                                else
                                    dTen3(r,c,ch).dArr = dTen1(r,c,ch).dArr / dTen2(r,c,ch).dArr;
                                end
                            end
                        end
                    end
               end
           end
        end % mrdivide
        
        %-END ARITHMETIC OPERATIONS ----------------------------------------
        
        %-BEGIN STATISTICAL OPERATIONS -------------------------------------
        function avg = mean(dTen)
               
            sum = dTen(1,1).dArr;

            nR = size(dTen, 1);
            nC = size(dTen, 2);
            channels = size(dTen, 3);
            for ch = 1:channels
                for i = 1:nR
                   for j = 2:nC
                        sum = sum + dTen(i,j,ch).dArr;
                   end
                end
            end
            avg = sum/(nR*nC*channels);
        end % mean
        
        function v = var(dTen)
            
            avg = mean(dTen);
            slacks = dTen-avg;
            squared_slacks = times(slacks, slacks);
            v = mean(squared_slacks);
        end % var
        
        
        function exp_dTen = exp(dTen)
            
            exp_dTen = dTen;

            nR = size(dTen, 1);
            nC = size(dTen, 2);
            channels = size(dTen, 3);
            for ch = 1:channels
                for i = 1:nR
                   for j = 2:nC
                        exp_dTen(i,j,ch) = exp(getReal(dTen(i,j,ch).dArr)) * (1 + getDual(dTen(i,j,ch).dArr));
                   end
                end
            end
        end % exp
        
        
    end % methods
end %classdef

