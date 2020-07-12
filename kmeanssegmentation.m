%% K-means Segmentation (Unsupervised Segmentation Technique for Image Segmentation)
% Nitin Rai 
% Ph.D. student 
% Department of Agricultural and Biosystems Engineering
% CE793 - Machine Learning for Engineers
% Taught by Dr. Ravi K. Yellavajjala
% Department of Civil and Environmental Engineering
%% Load Image
I = im2double(imread('purepng.com-mariomariofictional-charactervideo-gamefranchisenintendodesigner-1701528634653vywuz.png'));       
J = imresize(I, 0.2);
imshow(J);
title('Original Image');
% Load Image
%%
F = reshape(J,size(J,1)*size(J,2),3);                 % Color Features
%% K-means
K     = 2;                                            % Cluster Numbers
CENTS = F( ceil(rand(K,1)*size(F,1)) ,:);             % Cluster Centers
DAL   = zeros(size(F,1),K+2);                         % Distances and Labels
KMI   = 10;                                           % K-means Iteration
for n = 1:KMI
   for i = 1:size(F,1)
      for j = 1:K  
        DAL(i,j) = norm(F(i,:) - CENTS(j,:));      
      end
      [Distance, CN] = min(DAL(i,1:K));               % 1:K are Distance from Cluster Centers 1:K 
      DAL(i,K+1) = CN;                                % K+1 is Cluster Label
      DAL(i,K+2) = Distance;                          % K+2 is Minimum Distance
   end
   for i = 1:K
      A = (DAL(:,K+1) == i);                          % Cluster K Points
      CENTS(i,:) = mean(F(A,:));                      % New Cluster Centers
      if sum(isnan(CENTS(:))) ~= 0                    % If CENTS(i,:) Is Nan Then Replace It With Random Point
         NC = find(isnan(CENTS(:,1)) == 1);           % Find Nan Centers
         for Ind = 1:size(NC,1)
         CENTS(NC(Ind),:) = F(randi(size(F,1)),:);
         end
      end
   end
end
X = zeros(size(F));
for i = 1:K
idx = find(DAL(:,K+1) == i);
X(idx,:) = repmat(CENTS(i,:),size(idx,1),1); 
end
T = reshape(X,size(J,1),size(J,2),3);
%% Show
figure();
segmented_original = imresize(T, 1);
imshow(segmented_original); 
title('Segmented Image using K-means Clustering');