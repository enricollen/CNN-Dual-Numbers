classdef DualMatrix
    % DualArray class (Bidimensional Array of Dual2 Numbers)
    %
    %   Constructors for the DualArray class:
    %
    %   DualArray(mat)  % builds a DualArray having the same number of rows
    %                   % and columns of mat, where the element (i,j) is
    %                   % exactly the value of mat(i,j), but represented as
    %                   % a Dual2 of the predetermined degree.
    %
    %   % EXAMPLES of usage
    %
    %   Dual2.setgetPrefs('DISPLAY_FORMAT',0); % ASCII
    %   disp(' ');
    %   mat1 = [ 1 2; 4 5; 6,7]
    %   da1  = DualArray(mat1);
    %   disp(da1); fprintf('\n');
    %
    %   da2 = zeros(2, 3, 'like', DualArray); % this is a 2-by-3 matrix of Dual2 numbers,
    %                                         % all equal to zero.
    %   disp(da2); fprintf('\n');
    %
    %   da3 = eye(3, 'like', DualArray);      % this is a 3-by-3 identity matrix of Dual2
    %   disp(da3); fprintf('\n');
    %
    %
    %   da4 = randn(4, 1, 'like', DualArray); % this is a column vector of random Dual2,
    %                                         % following a normal distribution
    %   disp(da4); fprintf('\n');
    %
    %   da5 = DualArray(randn(5,1));              % this is a 5-by-1 matrix
    %                                             % of Dual2 numbers, with
    %                                             % real part random and dual
    %                                             % part equals to 0
    %                                        
    %   disp(da5); fprintf('\n');
    %
    %   da6 = DualArray(randn(5,3), ones(5,3));   % this is a 5-by-3 matrix of Dual numbers 
    %                                             % with Real part random 
    %                                             % and Dual part equals to
    %                                             % 1
    %                                            
    %   disp(da6); fprintf('\n');
    %
    %   co7 = complex(randn(5,3), ones(5,3));      % you can build a Dual Matrix
    %                                              % with a Matrix of
    %                                              % Complex numbers
    %   da7 = DualArray(co7);                 
    %                                         
    %   disp(da7); fprintf('\n');    
    %
    % See also Dual2, Dual2.setgetPrefs(...)
    
    properties
        dMat % is a nxm matrix of Dual2
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
            obj(dim,dim) = DualMatrix; % <-- Updated line
            for r = 1:dim
                for c = 1:dim
                    obj(r,c).dMat = Dual2(0);
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
                    obj(r,c).dMat = Dual2(0);
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
                    obj(r,c).dMat = Dual2(1);
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
                    obj(r,c).dMat = Dual2(1);
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
                            obj(r,c).dMat = Dual2(1);
                        else
                            obj(r,c).dMat = Dual2(0);
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
                        obj(r,c).dMat = Dual2(rand(1,1));
                    end
                end
            end
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                obj(nR,nC) = obj;
                for r = 1:nR
                    for c = 1:nC
                        obj(r,c).dMat = Dual2(rand(1,1));
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
                        obj(r,c).dMat = Dual2(randn(1,1));
                    end
                end
            end
            if nargin == 3
                nR = varargin{1};
                nC = varargin{2};
                obj(nR,nC) = obj;
                for r = 1:nR
                    for c = 1:nC
                        obj(r,c).dMat = Dual2(randn(1,1));
                    end
                end
            end
        end % END randn
    end
    
    methods
        % Constructor
        function obj = DualMatrix(mat, mat_du)
            % DualArray constructor for DualArray
            if nargin ~= 0
                if nargin < 2
                    mat_du = zeros(size(mat));
                end
                if any( size(mat) ~= size(mat_du))
                    error('The matrices for the real part and dual part must have same size');
                end
                [nR,nC] = size(mat);
                obj.dMat = repmat(Dual2, nR, nC); % Preallocate dMat
                for r = 1:nR
                    for c = 1:nC
                        if isreal(mat)
                           obj.dMat(r,c) = Dual2(mat(r,c), mat_du(r,c)); 
                        else % assuming complex
                           obj.dMat(r,c) = Dual2(real(mat(r,c)), imag(mat(r,c)));
                        end
                    end
                end
            end
        end % constructor
        
        function disp(obj)
            [nR, nC] = size(obj.dMat);
            for r = 1:nR
                for c = 1:nC
                    disp(obj.dMat(r,c));
                    if c ~= nC
                        fprintf(' , ');
                    end
                end
                fprintf('\n');
            end
        end % disp
       

        function d2 = getAsDual2(obj, i, j) % get the Dual Number at row i and column j
             d2 = obj.dMat(i,j);
        end
        
        function mat_re = getReal(obj) % get the matrix extracting real values at row i and column j only
            mat_re = zeros(size(obj.dMat));
            
            for i=1:size(obj.dMat,1)
                for j=1:size(obj.dMat,2)
                    d2 = getAsDual2(obj,i,j);
                    mat_re(i,j) = getReal(d2);
                end
            end
        end

        function mat_du = getDual(obj) % get the matrix extracting dual values at row i and column j only
            mat_du = zeros(size(obj.dMat));
            
            for i=1:size(obj.dMat,1)
                for j=1:size(obj.dMat,2)
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

           if isa(dMat2, 'double') % addition between DualMatrix and a double
               real_part = getReal(dMat1) + dMat2;
               dMat3 = DualMatrix(real_part, getDual(dMat1));
           elseif(isa(dMat2, 'Dual2'))
               real_part = getReal(dMat1) + getReal(dMat2); % addition between DualMatrix and Dual2
               dual_part = getDual(dMat1) + getDual(dMat2);
               dMat3 = DualMatrix(real_part, dual_part);
           elseif isequal(size(dMat1.dMat),size(dMat2.dMat)) % addition between two DualMatrix
               real_part = getReal(dMat1) + getReal(dMat2);
               dual_part = getDual(dMat1) + getDual(dMat2);
               dMat3 = DualMatrix(real_part, dual_part);
           else
               error ('The two DualMatrix must have the same length');
           end
        end % plus
        


        function dMat3 = minus(dMat1, dMat2) % element-wise subtraction
            if isa(dMat2, 'double') % subtraction between DualMatrix and a double
               real_part = getReal(dMat1) - dMat2;
               dMat3 = DualMatrix(real_part, getDual(dMat1));
           elseif(isa(dMat2, 'Dual2'))
               real_part = getReal(dMat1) - getReal(dMat2); % subtraction between DualMatrix and Dual2
               dual_part = getDual(dMat1) - getDual(dMat2);
               dMat3 = DualMatrix(real_part, dual_part);
           elseif isequal(size(dMat1.dMat),size(dMat2.dMat)) % subtraction between two DualMatrix
               real_part = getReal(dMat1) - getReal(dMat2);
               dual_part = getDual(dMat1) - getDual(dMat2);
               dMat3 = DualMatrix(real_part, dual_part);
           else
               error ('The two DualMatrix must have the same length');
            end
        end % minus


        
        function dMat3 = times(dMat1, dMat2) % element-wise product

           if isa(dMat2, 'double') % product between DualMatrix and a double
               real_part = getReal(dMat1) * dMat2;
               dual_part = getDual(dMat1) * dMat2;
               dMat3 = DualMatrix(real_part, dual_part);
           elseif(isa(dMat2, 'Dual2'))  % product between DualMatrix and Dual2
               real_part = getReal(dMat1) * getReal(dMat2); 
               dual_part = getReal(dMat1) * getDual(dMat2) + getReal(dMat2) * getDual(dMat1) ;
               dMat3 = DualMatrix(real_part, dual_part);
           elseif isequal(size(dMat1.dMat),size(dMat2.dMat)) % product between two DualMatrix
          
               if size(dMat1.dMat, 2) ~= size(dMat2.dMat, 1)
                    error('Inner matrix dimensions must agree for matrix multiplication.');
               end

               nR = size(dMat1.dMat, 1);
               nC = size(dMat2.dMat, 2);
               dMat3 = DualMatrix(zeros(nR, nC), zeros(nR, nC));

               for r = 1:nR
                   for c = 1:nC
                        for k = 1:size(dMat1.dMat, 2)
                            z1 = dMat1.dMat(r, k);
                            z2 = dMat2.dMat(k, c);
            
                            real_part = getReal(dMat3.dMat(r, c)) + getReal(z1) * getReal(z2);
                            dual_part = getDual(dMat3.dMat(r, c)) + getReal(z1) * getDual(z2) + getReal(z2) * getDual(z1);
                                        
                            dMat3.dMat(r, c) = Dual2(real_part, dual_part);
                        end
                    end
                end
           end
        end % mtimes
        

        function dMat3 = rdivide(dMat1, dMat2) % element-wise division
           

            if isa(dMat2, 'double') % division between DualMatrix and a double
               if dMat2 == 0 
                   error("Division by zero is not permitted")
               end
               real_part = getReal(dMat1) / dMat2;
               dual_part = (getDual(dMat1) * dMat2) / dMat2^2;
               dMat3 = DualMatrix(real_part, dual_part);
           elseif(isa(dMat2, 'Dual2')) % division between DualMatrix and Dual2
               if getReal(dMat2) == 0
                   error("Division by zero is not permitted")
               end
               real_part = getReal(dMat1) / getReal(dMat2);
               dual_part = (getDual(dMat1) * getReal(dMat2) - getDual(dMat2) * getReal(dMat1)) / getReal(dMat2)^2;
               dMat3 = DualMatrix(real_part, dual_part);
           elseif isequal(size(dMat1.dMat),size(dMat2.dMat)) % division between two DualMatrix
          
               if size(dMat1.dMat, 2) ~= size(dMat2.dMat, 1)
                    error('Inner matrix dimensions must agree for matrix division.');
               end

               nR = size(dMat1.dMat, 1);
               nC = size(dMat2.dMat, 2);
               dMat3 = DualMatrix(zeros(nR, nC), zeros(nR, nC));

               for r = 1:nR
                   for c = 1:nC
                        for k = 1:size(dMat1.dMat, 2)
                            z1 = dMat1.dMat(r, k);
                            z2 = dMat2.dMat(k, c);
            
                            real_part = getReal(dMat3.dMat(r, c)) + getReal(z1) / getReal(z2);
                            dual_part = getDual(dMat3.dMat(r, c)) + (getDual(z1) * getReal(z2) - getDual(z2) * getReal(z1)) / getReal(z2)^2;
                                       
                            dMat3.dMat(r, c) = Dual2(real_part, dual_part);
                        end
                    end
                end
           end
        end % mrdivide
        
        %-END ARITHMETIC OPERATIONS ----------------------------------------
        
        %-BEGIN STATISTICAL OPERATIONS -------------------------------------
        function avg = mean(dMat)
               
            sum = dMat.dMat(1,1);

            nR = size(dMat.dMat, 1);
            nC = size(dMat.dMat, 2);
            for i = 1:nR
                   for j = 2:nC
                        sum = sum + dMat.dMat(i,j);
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
            
            nR = size(dMat.dMat, 1);
            nC = size(dMat.dMat, 2);
            for i = 1:nR
                   for j = 1:nC
                    exp_dMat(i,j) = exp(getReal(dMat.dMat(i,j))) * (1 + getDual(dMat.dMat(i,j)));
                   end
            end
        end % exp
        
        
    end % methods
end %classdef

