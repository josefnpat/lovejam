return function()
  return {
    type = "fighter",
    class = libs.net.classTypes.military,
    military_small = true,
    cost = {material=80,crew=15},
    points = 1,
    fow = 0.75,
    crew = 15,
    size = 16,
    speed = 300,
    health = {max = 15,},
    shoot = {
      type = "missile",
      reload = 0.25*10,
      damage = 0.6*10,
      speed = 300,
      range = 150,
      aggression = 400,
    },
    build_time = 10,
    unlock_cost = 15,
    weight = 1,
  }
end
