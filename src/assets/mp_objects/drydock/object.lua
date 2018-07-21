return function()
  return {
    type = "drydock",
    cost = {
      material=200,
      crew=15,
    },
    fow = 0.5,
    crew = 15,
    size = 32,
    speed = 50,
    health = {max = 25,},
    construction_civilian = true,
    actions = {
      "build_salvager",
      "build_habitat",
      "build_mining",
      "build_refinery",
      "build_cargo",
      "build_radar",
      "build_command",
      "build_repair",
      -- "build_research",
    },
    build_time = 5,
  }
end
