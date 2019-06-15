function view_cost_vs_nc(file_points)
  points = [struct2cell(load(file_points)){:}];
  
  for it = 1 : 10
  %setting NC random indices from data points as centroids
    NC = it;
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
  
    cost = 0; 
    m = size(points, 1);
    NC = size(centroids, 1);

    %calculating the distance to the closest centroids in order to see the cost
    %of a cluster and the final cost
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
      cost = cost + sqrt(min_dist);
    endfor
    final_cost(it,:) = cost;
  endfor
  
  final_cost
  plot(final_cost);

	% TODO compute cost for NC = [1..10] and plot 
end

