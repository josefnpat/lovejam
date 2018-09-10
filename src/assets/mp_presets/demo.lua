return {
  name="Demo",
  gen = {
    first = "command_demo",
    default = {
      habitat=1,
      salvager=1,
    }
  },
  build = {
    priority = {
      --construction_command = 5,
      material_gather = 6,
      --ore_gather = 3,
      construction_civilian = 4,
      construction_military = 3,
      --ore_convert = 2,
      crew_gather = 5,
      military_small = 2,
      military_large = 0,
      --cargo = 2,
      --repair = -math.huge,
      --takeover = -math.huge,
    },
    max_count = {
      material_gather = 6,
      --ore_gather = 6,
      --construction_command = 1,
      construction_civilian = 4,
      construction_military = 8,
      --ore_convert = 4,
      crew_gather = 4,
      --cargo = 8,
      military_small = 16,
      military_large = math.huge,
    },
  },
}