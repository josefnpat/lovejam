local level = {}

level.id = "1"
level.name = "Chapter 1:\nThe Long Goodbye"
level.next_level = "2"
level.victory = libs.levelshared.team_2_and_3_defeated

level.players_skel = {
  gen = libs.levelshared.gen.campaign_ruby,
}

level.players_config_skel = {
  team = 1,
}

level.ai_players = {
  {
    config = {
      ai = 1, -- ID
      team = 1,
      diff = 1, -- difficulty
      race = 1,
    },
    gen = libs.levelshared.gen.none,
  },
  {
    config = {
      ai = 2, -- ID
      team = 2,
      diff = 1, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.dojeer,
  },
  {
    config = {
      ai = 3, -- ID
      team = 2,
      diff = 1, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.none,
  },
  {
    config = {
      ai = 4, -- ID
      team = 2,
      diff = 1, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.none,
  },
}

level.intro = function()--self,dir)
  return "Level 1 Prelude"
end

level.outro = function()--self,dir)
  return "Level 1 Complete"
end

return level
