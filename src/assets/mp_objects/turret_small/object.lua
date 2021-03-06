return function()
  return {
    type = "turret_small",
    class = libs.net.classTypes.military,
    military_large = true,
    cost = {material=125,crew=25},
    points = 2,
    crew = 25,
    size = 32,
    health = {max = 50,},
    fow = 2,
    shoot = {
      type = "missile",
      reload = 0.25*2.5,
      damage = 2*1.25,
      speed = 400,
      range = 600,
      aggression = 400,
    },
    build_time = 20,
    subdangle_speed = 0,
    rotate = 0.5,
    unlock_cost = 15,
    weight = 5,
  }
end
