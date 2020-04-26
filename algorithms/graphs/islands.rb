def find_clusters(map)  
  visited = {}
  count = 0
  clusters = []
  max_rows = map.size
  max_columns = map[0].size
  
  map.each_with_index do |row, i|
    row.each_with_index do |column, j|
      coords = [i, j]
      next if (visited[coords] || map[i][j] == 0) # not sea
      count += 1
      cluster_coords = explore(i, j, visited, map) 
      clusters << cluster_coords
    end
  end
  puts "number of clusters: #{clusters.size}"
  puts "coordinates:"
  clusters.each do |c|
    puts c.inspect
    puts "-----"
  end

  count
end

def adjacent_coordinates(current_coords, map)
  x, y = current_coords
  max_rows = map.size
  max_colums = map[0].size
  
  neighbors = [
    [x+1, y], 
    [x-1, y],
    [x, y+1],
    [x, y-1]
  ]
  
  neighbors.select{|x, y|
    x >= 0 && 
    x < max_rows && 
    y >= 0 && 
    y < max_colums
  }
end

def explore(i, j, visited, map)
  puts "exploring: " + [i, j].inspect
  cluster_coords = []
  coordinates_list = []
  coordinates_list << [i, j]
  
  while !coordinates_list.empty?
    current_coords = coordinates_list.shift
    next if visited[current_coords]
    x, y = current_coords
    value = map[x][y]
    next if (value == 0) # sea
    
    visited[current_coords] = true
    cluster_coords << current_coords

    adjacent = adjacent_coordinates(current_coords, map)
    
    # check if this is needed
    adjacent.reject!{|x, y| visited[[x,y]] }
    coordinates_list = coordinates_list + adjacent
  end

  cluster_coords
end

map = [
  [0, 0, 0, 0, 0],
  [0, 1, 1, 1, 0],
  [0, 1, 1, 1, 0],
  [1, 0, 1, 1, 0],
  [0, 1, 1, 1, 0]
]

find_clusters(map)