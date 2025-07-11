-- e = entry point door = 101 in ascii
-- x = exit point door = 120 in ascii
-- s = spawn point = 115 in ascii = entry spawn point
-- r = respawn point = 114 in ascii = spawn after exit
return {
  x = 0,
  y = 0,
  cellWidth = 32,
  cellHeight = 32,
  nextMap = "map-3",
  previousMap = "map-1",
  {1,1,101,101,101,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,0,0,115,0,0,0,0,0,1},
  {1,0,0,0,1,1,1,0,0,1},
  {1,0,0,0,0,0,0,0,0,120},
  {1,0,0,0,0,0,0,114,0,120},
  {1,0,0,0,0,0,0,0,0,120},
  {1,1,1,1,1,1,1,1,1,1},
}