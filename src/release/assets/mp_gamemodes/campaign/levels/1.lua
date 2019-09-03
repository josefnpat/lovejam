local level = {}

level.id = "1"
level.next_level = "2"
level.victory = libs.levelshared.team_2_and_3_defeated

level.players_config_skel = {
  team = 1,
}

level.ai_players = {
  {
    config = {
      ai = 1, -- ID
      team = 2,
      diff = 1, -- difficulty
    },
    gen = libs.levelshared.gen.dojeer,
  },
  -- {
  --   config = {
  --     ai = 1, -- ID
  --     team = 2,
  --     diff = 1, -- difficulty
  --   },
  --   gen = libs.levelshared.gen.dojeer,
  -- },
  -- {
  --   config = {
  --     ai = 1, -- ID
  --     team = 2,
  --     diff = 1, -- difficulty
  --   },
  --   gen = libs.levelshared.gen.dojeer,
  -- },
  -- {
  --   config = {
  --     ai = 1, -- ID
  --     team = 2,
  --     diff = 1, -- difficulty
  --   },
  --   gen = libs.levelshared.gen.dojeer,
  -- },
}

level.intro = function()--self,dir)
  return "Level 1 Prelude"
end

level.outro = function()--self,dir)
  return "Level 1 Complete"
end

return level
