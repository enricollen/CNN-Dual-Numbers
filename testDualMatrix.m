 z1 = [1 2 ; 3 4];

%  constructor test
 fprintf("\nConstructor test\n")
 z1 = DualMatrix(z1,ones(size(z1)));
 disp(z1);

% disp test
 fprintf("\ndisp test\n")
 disp(z1);

%  getAsDual2 test
 fprintf("\ngetAsDual2 test\n");
 z2=getAsDual2(z1,2,2);
 disp(z2);

%  getReal test
 fprintf("\ngetReal test\n");
 mat_re=getReal(z1);
 disp(mat_re);

%  getDual test
 fprintf("\ngetDual test\n");
 mat_du=getDual(z1);
 disp(mat_du);

%  abs_as_a_new_DualMatrix test
 z1 = [-1 -2 ; -3 -4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nabs_as_a_new_DualMatrix test\n");
 abs_matrix = abs(z1);
 disp(abs_matrix);

%  test addition operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nPlus operation test between DualMatrix and double\n");
 z2 = 1;
 z3=z1+z2;
 disp(z3);
 fprintf("\nPlus operation test between DualMatrix and Dual2\n");
 z2 = Dual2(1,1);
 z3=z1+z2;
 disp(z3);
 fprintf("\nPlus operation test between two DualMatrix\n");
 z2 = [10 10 ; 10 10];
 z2 = DualMatrix(z2,ones(size(z2)));
 z3=z1+z2;
 disp(z3);


%  test subtraction operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nMinus operation test between DualMatrix and double\n");
 z2 = 1;
 z3=z1-z2;
 disp(z3);
 fprintf("\nMinus operation test between DualMatrix and Dual2\n");
 z2 = Dual2(1,1);
 z3=z1-z2;
 disp(z3);
 fprintf("\nMinus operation test between two DualMatrix\n");
 z2 = [10 10 ; 10 10];
 z2 = DualMatrix(z2,ones(size(z2)));
 z3=z1-z2;
 disp(z3);


%  test product operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nProduct operation test between DualMatrix and double\n");
 z2 = 2;
 z3=times(z1,z2);
 disp(z3);
 fprintf("\nProduct operation test between DualMatrix and Dual2\n");
 z2 = Dual2(2,2);
 z3=times(z1,z2);
 disp(z3);
 fprintf("\nProduct operation test between two DualMatrix\n");
 z2 = [2 2 ; 2 2];
 z2 = DualMatrix(z2,ones(size(z2)));
 z3=times(z1,z2);
 disp(z3);


%  test division operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nDivision operation test between DualMatrix and double\n");
 z2 = 2;
 z3=rdivide(z1,z2);
 disp(z3);
 fprintf("\nDivision operation test between DualMatrix and Dual2\n");
 z2 = Dual2(2,2);
 z3=rdivide(z1,z2);
 disp(z3);
 fprintf("\nDivision operation test between two DualMatrix\n");
 z2 = [2 2 ; 2 2];
 z2 = DualMatrix(z2,ones(size(z2)));
 z3=rdivide(z1,z2);
 disp(z3);


%  test mean operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nMean test of a DualMatrix\n");
 disp(mean(z1));

%  test var operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nVar test of a DualMatrix\n");
 disp(var(z1));

%  test exp operation
 z1 = [1 2 ; 3 4];
 z1 = DualMatrix(z1,ones(size(z1)));
 fprintf("\nExp test of a DualMatrix\n");
 disp(exp(z1));