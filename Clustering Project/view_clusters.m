% outputs a graphical representation of the clustering solution
function view_clusters(points, centroids)
    
  indices = zeros(size(points, 1), 1);
  m = size(points, 1);
  NC = size(centroids, 1);

%finding the closest centroid
  for i = 1 : m
    k = 1;
    min_dist = sum((points(i, :) - centroids(1, :)) .^ 2);
    for j = 2 : NC
      dist = sum((points(i, :) - centroids(j, :)) .^ 2);
      if(dist < min_dist)
        min_dist = dist;
        k = j;
      endif
    endfor
    indices(i) = k;
  endfor

%assigning the point to its cluster
  points(:, 4) = indices;
%matrix for different colours
  C = [1 0 0; 1 0 1; 0 1 1; 1 1 0; 0 1 0];
%picking a colour for a cluster from the matrix of colours
  colours = C(points(:, 4), :);
  
	scatter3(points(:, 1), points(:, 2), points(:, 3), [], colours);
	% TODO graphical representation coded here 
end

