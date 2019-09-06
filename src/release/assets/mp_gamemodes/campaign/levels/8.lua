local level = {}

level.id = "8"
level.next_level = "9"
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
}

level.intro = function()
  return "Level 8 Prelude"
end

level.outro = function()
  return "Level 8 Complete"
end

return level