%mostra grafico del cluster e una volta eseguiti i dati sono pronti ad
%eseguire clusterOutput.m
figure;
plot(clusterData(:,1),clusterData(:,2),'.');
title 'Vertici';


opts = statset('Display','final');
[idx,C] = kmeans(clusterData,2,'Distance','sqeuclidean',...
    'Replicates',6,'Options',opts);

figure;
plot(clusterData(idx==1,1),clusterData(idx==1,2),'r.','MarkerSize',12)
hold on
plot(clusterData(idx==2,1),clusterData(idx==2,2),'b.','MarkerSize',12)

plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off


%{
load fisheriris
X = meas;
y = categorical(species);

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',1:10)

plot(eva)
%}
%{
categories(y)

Xred = nnmf(X,2);

gscatter(Xred(:,1),Xred(:,2),y)
xlabel('Column 1')
ylabel('Column 2')
grid on
%}

%{
%load('DatDepth.mat');
fullImm = [];
for i = 1:2788
    matrice = DepthDATA{i}{3};
    fullImm(i)=FixMatrix(matrice);
end
[idx,C] = kmeans(fullImm,2);
disp(idx);
%}
