local level = {}

level.id = "7"
level.name = "Chapter 7:\nEmpty Threats"
level.next_level = "8"
level.victory = libs.levelshared.team_2_and_3_defeated
level.research_reward = 50

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
      diff = 4, -- difficulty
      race = 1,
    },
    gen = libs.levelshared.gen.campaign_valentina,
  },
  {
    config = {
      ai = 2, -- ID
      team = 2,
      diff = 4, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.dojeer,
  },
  {
    config = {
      ai = 3, -- ID
      team = 2,
      diff = 4, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.dojeer,
  },
  {
    config = {
      ai = 4, -- ID
      team = 2,
      diff = 4, -- difficulty
      race = 2,
    },
    gen = libs.levelshared.gen.dojeer,
  },
}

level.intro = function()
  return "Level 7 Prelude"
end

level.outro = function()
  return "Level 7 Complete"
end

return level
