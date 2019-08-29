return function()
  local ship = require"assets.mp_objects.advdrydock.object"()
  ship.type = "dojeer_advdrydock"
  ship.actions = {
    "build_dojeer_fighter",
    "build_dojeer_combat",
    "build_dojeer_artillery",
    "build_dojeer_minelayer",
    "build_dojeer_tank",
    "build_dojeer_turret_tiny",
    "build_dojeer_turret_small",
    "build_dojeer_turret_large",
    -- "build_jump",
    "build_dojeer_troopship",
    "build_dojeer_capital",
  }
  return ship
end
