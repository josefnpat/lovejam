return function()
  return {
    type = "scrap",
    display_name = "Scrap",
    info = "This scrap contains [Material] which can be collected by a [Salvager].",
    variation = math.random(0,5),
    size = 32,
    scrap_supply = math.random(10,30),
    rotate = (math.random(0,1)*2-1)/20,
    pc = false,
  }
end
