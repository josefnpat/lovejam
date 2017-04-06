return function()
  return {
    type = "refinery",
    display_name = "Refinery",
    info ="A material refining ship with some material storage.",
    cost = {material=125,crew=10},
    fow = 0.5,
    crew = 10,
    size = 32,
    speed = 50,
    health = {max = 15,},
    material = 100,
    material_gather = 5,
    repair = false,
    refine = false,
    actions = {"salvage","repair","refine","upgrade_refine"},
    build_time = 5,
  }
end
