% reads cluster count and points from input files 
function [NC points] = read_input_data(file_params, file_points)
  
	% set these values correctly
  
  %I have just loaded the data and transformed it to a matrix
	NC = load (file_params); 
  points = [struct2cell(load(file_points)){:}];

	% TODO read NC
	% TODO read points
end

