local mppresets = {}

mppresets._presets = {}
mppresets._dir = "assets/mp_presets/"
for _,filename in pairs(file.getAllDirectoryItems(mppresets._dir)) do
  local preset = require(file.name(filename))
  table.insert(mppresets._presets,preset)
end

function mppresets.getPresets()
  return mppresets._presets
end

function mppresets.getBuildPriority(id)
  local preset = mppresets._presets[id]
  return preset.build.priority
end

function mppresets.getBuildMaxCount(id)
  local preset = mppresets._presets[id]
  return preset.build.max_count
end

return mppresets
