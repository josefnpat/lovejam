return function()
  local ship = require"assets.mp_objects.drydock.object"()
  ship.type = "alien_drydock"
  ship.actions = {
    "build_alien_salvager",
    "build_alien_habitat",
    "build_alien_mining",
    "build_alien_refinery",
    "build_alien_cargo",
    "build_alien_radar",
    "build_alien_command",
    "build_alien_repair",
    "build_alien_research",
  }
  return ship
end
