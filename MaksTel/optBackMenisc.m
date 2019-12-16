%[x, obj, info, iter, nf, lambda] = sqp (x0, phi)
%[…] = sqp (x0, phi, g, h, lb, ub, maxiter, tol)

%backMen=[45,-362.8,100,108.9,20,140,120,11.6,-108.9];
p5679init=[mtp5679(5),mtp5679(6),mtp5679(7),mtp5679(9)];
% initial parameters for Back Menisc configuration
%lb=[backMen(1)-0.01,backMen(2)-0.01,-300,-300,7,60,50,backMen(8)-0.01,-300];
%lb=[backMen(1)-0.01,backMen(2)-0.01,backMen(3)-0.01,backMen(4)-0.01,7,60,50,backMen(8)-0.01,-300];
%ub=[backMen(1)+0.01,backMen(2)+0.01,backMen(3)+0.01,backMen(4)+0.01,30,250,230,backMen(8)+0.01,0];
lb=[7,60,50,-300];
ub=[30,250,230,0];

[x,obj,info,iter,nf,lambda]=sqp(p5679init,@width5679,[],@ineq5679,lb,ub);

