% computes the NC centroids corresponding to the given points using NC-Means
function centroids = clustering_pc(points, NC)
  
  %setting NC random indices from data points as centroids
  centroids = zeros(NC, size(points, 2));
  randidpoints = randperm(size(points, 1), NC);
  centroids = points(randidpoints(1 : NC), :);  
  err = 1;
  
  while err > 0.000001
    %Calculating the euclidean distance to each cluster centroid and
    %then assign points to the one with lowest distance
    indices = zeros(size(points, 1), 1);
    m = size(points, 1);
  
    for i = 1 : m
      k = 1;
      min_dist = sqrt(sum((points(i, :) - centroids(1, :)) .^ 2));
      for j = 2 : NC
        dist = sqrt(sum((points(i, :) - centroids(j, :)) .^ 2));
        if(dist < min_dist)
          min_dist = dist;
          k = j;
        endif
      endfor
      indices(i) = k;
    endfor
    
    %re-computing the cluster centroids: assign the calculated mean of
    %all points in each cluster, as new centroid of that
    [m n] = size(points);
    centroids_aux = centroids;
    centroids = zeros(NC, n);
    
    for i = 1 : NC
      points_i = points(indices == i, :);
      ck = size(points_i, 1);
      centroids(i, :) = (1 / ck) * [sum(points_i(:, 1)) sum(points_i(:, 2)) sum(points_i(:, 3))];
    endfor
    #calculating the error resulted
    err = abs(max(max(centroids-centroids_aux)));
  endwhile

  %centroids = [];
	% TODO K-Means code 
end
