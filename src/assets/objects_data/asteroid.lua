return function()
  return {
    type = "asteroid",
    display_name = "Asteroid",
    info = "This asteroid contains [Ore] which can be mined by a [Mining Rig] and then the [Ore] can be refined by a [Refinery].",
    variation = math.random(0,4),
    size = 32,
    ore_supply = math.random(125,175),
    rotate = (math.random(0,1)*2-1)/10,
    pc = false,
  }
end
