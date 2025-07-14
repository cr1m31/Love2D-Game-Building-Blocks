return {
  map = {
    x = 0,
    y = 0,
    cellWidth = 32,
    cellHeight = 32,
    previousMap = "map-1"
  },
  
  tiles = {
    {1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,1,1,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1},
  },
  
  gates = {
    west = {x = 1, y = 3, targetMap = "map-1", targetGate = "east" },
    south = {x = 5, y = 6, targetMap = "map-3", targetGate = "north" }
  }
  
}

