% computes a clustering solution total cost
function cost = compute_cost_pc(points, centroids)
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

	% TODO compute clustering solution cost
end

