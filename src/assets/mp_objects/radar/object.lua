return function()
  return {
    type = "radar",
    class = libs.net.classTypes.support,
    cost = {material=125,crew=5},
    points = 3,
    fow = 2,
    crew = 5,
    size = 32,
    speed = 75,
    health = {max = 13,},
    actions = {
      "build_satellite",
    },
    build_time = 2,
    unlock_cost = 25,
    weight = 6,
  }
end
