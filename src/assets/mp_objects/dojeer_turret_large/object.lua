return function()
  local ship = require"assets.mp_objects.turret_large.object"()
  ship.type = "dojeer_turret_large"
  ship.shoot.type = "laser"
  return ship
end