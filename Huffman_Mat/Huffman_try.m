%% ---------------------------------------------
%  code by WangYuan
%  date 2019/05/11
%----------------------------------------------------
%%
function [ m3,e ] =Huffman_try(p)
% Function input p, p is the probability distribution, the function of this function is to perform Huffman coding
 % Function output h, h is the code of each element
 % The function outputs e, e is the average code length of the output. I just initialize it without writing it.
e=2;
disp(['Huffman coding:' num2str(p) ]);
if length(find(p<0))
         error('Probability should not be less than 0!')
end
if abs(sum(p)-1)>10e-10
         error('The sum of probabilities is greater than 1, please check the input!')
end

 %% Generate Huffman tree
n=length(p);
q=ones(1,(2*n-1))
q(1,1:n)=p;

 % Define a structure that stores (2*n-1) nodes, initialize all index child nodes and parent nodes to -1, and assign the probability of failure s1-sn to the first n nodes.
for i=1:(2*n-1)
    Htree(i).lchild=-1;
    Htree(i).rchild=-1;
    Htree(i).parent=-1;
end
for i=1:n
    Htree(i).weight=p(i);
end

m1=0; 
m2=0;
for i=(n+1):(2*n-1)
    [min1,m1]= min(q); 
    q1=q;
    q1(m1)=1;
    [min2,m2]= min(q1); 
         Htree(i).weight=min1+min2; %The weight of the new node is equal to the sum of the weights of the smallest two nodes of the current weight
         Htree(i).lchild=m1;% The left subtree of the new node is recorded as the node with the smallest weight
         Htree(i).rchild=m2;% The right subtree of the new node is recorded as the node with the second smallest current weight
         Htree(m1).parent=i; %Save the parent node of the node with the smallest weight
         Htree(m2).parent=i;% Save the parent node of the node with the second smallest current weight
    
    q(i)=min1+min2;
    q(m1)=1;
         q(m2)=1;% update the current node to be coded
end

 %% is coded according to the Huffman tree 
m3=char(n,n);
for i=1:n
    j=i;
    a=n;
    while(Htree(j).parent~=-1)
        k=j;
        j=Htree(j).parent;
        if(Htree(j).lchild==k)
            m3(i,a)='0';
        else m3(i,a)='1';
        end 
        a=a-1;
    end
end

disp('> Finish coding');
end
