% Define grid parameters
gridSize = 20;      % Size of the grid
visited = zeros(gridSize);  % Matrix to keep track of visited locations

% Initial position of the Roomba
currentX = randi(gridSize);
currentY = randi(gridSize);

% Create a figure for visualization
figure;
axis([0 gridSize+1 0 gridSize+1]);
hold on;

% Define marker style and size for the Roomba head
roombaMarkerStyle = 'bs';  % Blue square
roombaMarkerSize = 15;

% Main loop to move the Roomba until all locations are visited
while any(visited(:) == 0)
    % Mark the current location as visited
    visited(currentX, currentY) = 1;
    
    % Visualize the Roomba's current position as the Roomba head
    plot(currentX, currentY, roombaMarkerStyle, 'MarkerSize', roombaMarkerSize, 'MarkerFaceColor', 'b');
    
    % Check neighboring cells for unvisited locations
    neighbors = [
        currentX - 1, currentY;
        currentX + 1, currentY;
        currentX, currentY - 1;
        currentX, currentY + 1;
    ];
    
    unvisited_neighbors = [];
    
    for i = 1:size(neighbors, 1)
        x = neighbors(i, 1);
        y = neighbors(i, 2);
        
        if x >= 1 && x <= gridSize && y >= 1 && y <= gridSize && visited(x, y) == 0
            unvisited_neighbors = [unvisited_neighbors; x, y];
        end
    end
    
    % Choose the next move based on unvisited neighbors
    if ~isempty(unvisited_neighbors)
        % Select the first unvisited neighbor as the next move
        next_move = unvisited_neighbors(1, :);
        currentX = next_move(1);
        currentY = next_move(2);
    else
        % If all neighbors are visited, backtrack to the nearest unvisited location
        [backtrackX, backtrackY] = find(visited == 0, 1, 'first');
        currentX = backtrackX;
        currentY = backtrackY;
    end
    
    % Pause for visualization (you can adjust the speed)
    pause(0.1);
    
    % Clear the previous Roomba head marker
    if any(visited(:) == 0)
        plot(currentX, currentY, 'w.', 'MarkerSize', roombaMarkerSize);  % White dot to clear previous marker
    end
end

hold off;
title('Roomba Coverage');
