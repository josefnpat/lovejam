return function()
  return {
    type = "turret_large",
    class = libs.net.classTypes.military,
    military_large = true,
    cost = {material=500,crew=100},
    points = 8,
    crew = 100,
    size = 64,
    health = {max = 200,},
    shoot = {
      type = "missile",
      reload = 0.25*5,
      damage = 8*5,
      speed = 800,
      range = 500,
      aggression = 800,
    },
    build_time = 20,
    subdangle_speed = 0,
    rotate = 0.5,
    unlock_cost = 60,
    weight = 6,
  }
end
