% This function takes a stock and makes a 3D plot of the profit and loss
% against a change in ent and ext percentages. The variables are as
% follows:

% s - The stock concern, look - the look back period, x - Full%K parameter,
% y - Full%D parameter.
% minent - the Minimum enter %, maxent - the Maximum enter %.
% chk - the Check %,
% minext - the Minimum exit %, maxext - the Maximum exit %.

function stoccalcmat(s,look,w1,w2,minent,maxent,chk,minext,maxext)

close all;

% We first generate the appropriate independent matrices.

[x y] = meshgrid(minent:1:maxent,minext:1:maxext);



% First create a Z matrix filled with 0's.
clear Z;
Z(1,1:1:length(x(1,:))) = 0;
Z(1:1:length(x(:,1)),:) = 0;

% Now we fill up Z matrix using the stoccalcmat function.
for (i = 1:length(x(:,1)))
    for (j = 1:length(x(1,:)))
       [ret1 ret2] = stoccalc(s,look,w1,w2,x(i,j),chk,y(i,j));
       Z(i,j) = ret1;
    end 
end

figure
surf(x,y,Z)

end