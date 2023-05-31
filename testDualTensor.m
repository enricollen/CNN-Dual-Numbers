% constructor test
z1 = ones(2,2,3);
fprintf("\nConstructor test\n")
z1 = DualTensor(z1,ones(size(z1)));
disp(z1);

% getAsDual2 test
fprintf("\ngetAsDual2 test\n")
z2 = getAsDual2(z1, 1, 1, 1);
disp(z2);

% getReal test
fprintf("\ngetReal test\n")
z2 = getReal(z1);
disp(z2);

% getDual test
fprintf("\ngetDual test\n")
z2 = getDual(z1);
disp(z2);

% abs test
fprintf("\nabs operation test\n")
z2 = abs(z1);
disp(z2);


%  test addition operation
fprintf("\nPlus operation test between DualTensor and double\n");
z2 = 1;
z3=z1+z2;
disp(z3);
fprintf("\nPlus operation test between DualTensor and Dual2\n");
z2 = Dual2(2,1);
z3=z1+z2;
disp(z3);
fprintf("\nPlus operation test between two DualTensor\n");
z2 = 2*ones(2,2,3);
z2 = DualTensor(z2,ones(size(z2)));
z3=z1+z2;
disp(z3);


%  test subtraction operation
fprintf("\nMinus operation test between DualTensor and double\n");
z2 = 1;
z3=z1-z2;
disp(z3);
fprintf("\nMinus operation test between DualTensor and Dual2\n");
z2 = Dual2(1,1);
z3=z1-z2;
disp(z3);
fprintf("\nMinus operation test between two DualTensor\n");
z2 = 2*ones(2,2,3);
z2 = DualTensor(z2,ones(size(z2)));
z3=z1-z2;
disp(z3);


%  test product operation
 fprintf("\nProduct operation test between DualTensor and double\n");
 z2 = 2;
 z3=times(z1,z2);
 disp(z3);
 fprintf("\nProduct operation test between DualTensor and Dual2\n");
 z2 = Dual2(2,2);
 z3=times(z1,z2);
 disp(z3);
 fprintf("\nProduct operation test between two DualTensor\n");
 z2 = 2*ones(2,2,3);
 z2 = DualTensor(z2,ones(size(z2)));
 z3=times(z1,z2);
 disp(z3);


 %  test division operation
 fprintf("\nDivision operation test between DualTensor and double\n");
 z2 = 2;
 z3=rdivide(z1,z2);
 disp(z3);
 fprintf("\nDivision operation test between DualTensor and Dual2\n");
 z2 = Dual2(2,2);
 z3=rdivide(z1,z2);
 disp(z3);
 fprintf("\nDivision operation test between two DualTensor\n");
 z2 = 2*ones(2,2,3);
 z2 = DualTensor(z2,ones(size(z2)));
 z3=rdivide(z1,z2);
 disp(z3);