return function()
  return {
    type = "minelayer",
    class = libs.net.classTypes.military,
    cost = {material=150,crew=15},
    points = 2,
    crew = 15,
    size = 32,
    speed = 50,
    health = {max = 15,},
    actions = {
      "build_mine",
    },
    build_time = 30,
    unlock_cost = 25,
    weight = 8,
  }
end
