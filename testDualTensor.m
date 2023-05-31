% constructor test
z1 = rand(2,2,3);
fprintf("\nConstructor test\n")
z1 = DualTensor(z1,ones(size(z1)));
disp(z1);