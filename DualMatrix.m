classdef DualMatrix
    % DualMatrix class (Bidimensional Matrix of Dual2 Numbers)
    %
    %   Constructors for the DualMatrix class:
    %
    %   DualMatrix(mat)  % builds a DualMatrix having the same number of rows
    %                   % and columns of mat, where the element (i,j) is
    %                   % exactly the value of mat(i,j), but represented as
    %                   % a Dual2 of the predetermined degree.
    %
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
                obj(dim) = obj;
                    for r = 1:dim
                        for c = 1:dim
                            obj(r,c).dArr = Dual2(0);
                        end
                    end
            end
            % With 2-dim, the user define both dimensions
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                obj(nR) = obj;
                    for r = 1:nR
                        for c = 1:nC
                            obj(r,c).dArr = Dual2(0);
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
            obj(dim,dim) = DualMatrix; % <-- Updated line
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
            obj(nR,nC) = DualMatrix; % <-- Updated line
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
        function obj = DualMatrix(mat, mat_du)
            % DualMatrix constructor
            if nargin ~= 0
                if nargin < 2
                    mat_du = zeros(size(mat));
                end
                if any( size(mat) ~= size(mat_du))
                    error('The matrices for the real part and dual part must have same size');
                end
                [nR,nC] = size(mat);
                obj(nR,nC)=obj;
                for r = 1:nR
                    for c = 1:nC
                        if isreal(mat)
                           obj(r,c).dArr = Dual2(mat(r,c), mat_du(r,c));
                        end
                    end
                end
            end
        end % constructor
        
        function disp(obj)
            [nR, nC] = size(obj);
                for r = 1:nR
                    for c = 1:nC
                        fprintf('(%f, %+fε)', getReal(obj(r,c).dArr), getDual(obj(r,c).dArr));
                        if c ~= nC
                            fprintf(' , ');
                        end
                    end
                    fprintf('\n');
                end
        end % disp
       

        function d2 = getAsDual2(obj, i, j) % get the Dual Number at row i and column j
             d2 = obj(i,j).dArr;
        end
        
        function mat_re = getReal(obj) % get the matrix extracting real values at row i and column j only
            mat_re = zeros(size(obj));
            
                for i=1:size(obj,1)
                    for j=1:size(obj,2)
                        d2 = getAsDual2(obj,i,j);
                        mat_re(i,j) = getReal(d2);
                    end
                end
        end

        function mat_du = getDual(obj) % get the matrix extracting dual values at row i and column j only
            mat_du = zeros(size(obj));

                for i=1:size(obj,1)
                    for j=1:size(obj,2)
                        d2 = getAsDual2(obj,i,j);
                        mat_du(i,j) = getDual(d2);
                    end
                end
        end
 
        function abs_as_a_new_DualMatrix = abs(obj) % return a matrix where element i,j is defined as |z|=|a|+sign(a)*eps                
            mat_re = abs(getReal(obj));
            mat_du = sign(getReal(obj));
            abs_as_a_new_DualMatrix = DualMatrix(mat_re, mat_du);
        end
        
        %-BEGIN ARITHMETIC OPERATIONS ----------------------------------------
        % Aritmetic operations between two DualMatrix or between
        % a DualMatrix and a double/Dual2
        
        function dMat3 = plus(dMat1, dMat2) % element-wise addition
           
           dMat3 = zeros(size(dMat1,1), size(dMat1,2), 'like', DualMatrix);

           if isa(dMat2, 'double') % addition between DualMatrix and a double
               for r=1:size(dMat1,1)
                    for c=1:size(dMat1,2)
                        dMat3(r,c).dArr = dMat1(r,c).dArr + dMat2; % addition of a DualMatrix by a double
                    end
               end
           elseif(isa(dMat2, 'Dual2'))
               for r=1:size(dMat1,1)
                    for c=1:size(dMat1,2)
                        dMat3(r,c).dArr = dMat1(r,c).dArr + dMat2; % addition of a DualMatrix by a Dual2
                    end
               end
           else
               if size(dMat1,1) ~= size(dMat2,1)
                    error ('The two DualMatrix must have the same length');
               else
                    for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            if isa(dMat2(r,c),'double')
                                dMat3(r,c).dArr = dMat1(r,c).dArr + dMat2(r,c);
                            else
                                dMat3(r,c).dArr = dMat1(r,c).dArr + dMat2(r,c).dArr;
                            end
                        end
                    end
               end
           end
        end % plus
        


        function dMat3 = minus(dMat1, dMat2) % element-wise subtraction
           dMat3 = zeros(size(dMat1,1), size(dMat1,2), 'like', DualMatrix);

           if isa(dMat2, 'double') % addition between DualMatrix and a double
               for r=1:size(dMat1,1)
                    for c=1:size(dMat1,2)
                        dMat3(r,c).dArr = dMat1(r,c).dArr - dMat2; % subtraction of a DualMatrix by a double
                    end
               end
           elseif(isa(dMat2, 'Dual2'))
               for r=1:size(dMat1,1)
                    for c=1:size(dMat1,2)
                        dMat3(r,c).dArr = dMat1(r,c).dArr - dMat2; % subtraction of a DualMatrix by a Dual2
                    end
               end
           else
               if size(dMat1,1) ~= size(dMat2,1)
                    error ('The two DualMatrix must have the same length');
               else
                    for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            if isa(dMat2(r,c),'double')
                                dMat3(r,c).dArr = dMat1(r,c).dArr - dMat2(r,c);
                            else
                                dMat3(r,c).dArr = dMat1(r,c).dArr - dMat2(r,c).dArr;
                            end
                        end
                    end
               end
           end
        end % minus


        
        function dMat3 = times(dMat1, dMat2) % element-wise product
           
           dMat3 = zeros(size(dMat1,1), size(dMat1,2), 'like', DualMatrix);

           if isa(dMat2, 'double') % product between DualMatrix and a double
                   for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            dMat3(r,c).dArr = dMat1(r,c).dArr * dMat2; % product of a DualMatrix by a double
                        end
                   end
           elseif(isa(dMat2, 'Dual2'))
                   for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            dMat3(r,c).dArr = dMat1(r,c).dArr * dMat2; % product of a DualMatrix by a Dual2
                        end
                   end
           else
               if size(dMat1,1) ~= size(dMat2,1)
                    error ('The two DualMatrix must have the same length');
               else
                    for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            if isa(dMat2(r,c),'double')
                                dMat3(r,c).dArr = dMat1(r,c).dArr * dMat2(r,c);
                            else
                                dMat3(r,c).dArr = dMat1(r,c).dArr * dMat2(r,c).dArr;
                            end
                        end
                    end
               end
           end
        end % mtimes
        

        function dMat3 = rdivide(dMat1, dMat2) % element-wise division
           
            dMat3 = zeros(size(dMat1,1), size(dMat1,2), 'like', DualMatrix);

           if isa(dMat2, 'double') % division between DualMatrix and a double
                   for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            dMat3(r,c).dArr = dMat1(r,c).dArr / dMat2; % division of a DualMatrix by a double
                        end
                   end
           elseif(isa(dMat2, 'Dual2'))
                   for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            dMat3(r,c).dArr = dMat1(r,c).dArr / dMat2; % division of a DualMatrix by a Dual2
                        end
                   end
           else
               if size(dMat1,1) ~= size(dMat2,1)
                    error ('The two DualMatrix must have the same length');
               else
                    for r=1:size(dMat1,1)
                        for c=1:size(dMat1,2)
                            if isa(dMat2(r,c),'double')
                                dMat3(r,c).dArr = dMat1(r,c).dArr / dMat2(r,c);
                            else
                                dMat3(r,c).dArr = dMat1(r,c).dArr / dMat2(r,c).dArr;
                            end
                        end
                    end
               end
           end
        end % mrdivide
        
        %-END ARITHMETIC OPERATIONS ----------------------------------------
        
        %-BEGIN STATISTICAL OPERATIONS -------------------------------------
        function avg = mean(dMat)
               
            sum = dMat(1,1).dArr;

            nR = size(dMat, 1);
            nC = size(dMat, 2);
                for i = 1:nR
                   for j = 2:nC
                        sum = sum + dMat(i,j).dArr;
                   end
                end
            avg = sum/(nR*nC);
        end % mean
        
        function v = var(dMat)
            
            avg = mean(dMat);
            slacks = dMat-avg;
            squared_slacks = times(slacks, slacks);
            v = mean(squared_slacks);
        end % var
        
        
        function exp_dMat = exp(dMat)
            
            exp_dMat = dMat;

            nR = size(dMat, 1);
            nC = size(dMat, 2);
            for i = 1:nR
               for j = 2:nC
                    exp_dMat(i,j) = exp(getReal(dMat(i,j).dArr)) * (1 + getDual(dMat(i,j).dArr));
               end
            end
        end % exp
        
        
    end % methods
end %classdef

