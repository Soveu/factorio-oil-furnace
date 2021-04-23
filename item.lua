-- OIL FURNACE
local oil_furnace_entity = table.deepcopy(data.raw["furnace"]["electric-furnace"])
oil_furnace_entity.name = "soveu-oil-furnace-entity"

oil_furnace_entity.energy_source = {
  type = "fluid",
  effectivity = 2,
  render_no_network_icon = false,
  burns_fluid = true,

  fluid_box = {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -2} }},
    secondary_draw_orders = { north = -1 },
    filter = "soveu-oil-furnace-oil"
  },
}

oil_furnace_entity.minable.result = "soveu-oil-furnace-item"
oil_furnace_entity.energy_usage = "90kW"

local oil_furnace_item = table.deepcopy(data.raw["item"]["electric-furnace"])
oil_furnace_item.name = "soveu-oil-furnace-item"
oil_furnace_item.place_result = "soveu-oil-furnace-entity"

local oil_furnace_recipe = table.deepcopy(data.raw["recipe"]["electric-furnace"])
oil_furnace_recipe.enabled = false
oil_furnace_recipe.name = "soveu-oil-furnace-recipe"
oil_furnace_recipe.result = "soveu-oil-furnace-item"
oil_furnace_recipe.ingredients = {
  {"pump", 1},
  {"electric-furnace", 1}
}

local furnace_oil = {
  type = "fluid",
  name = "soveu-oil-furnace-oil",
  default_temperature = 25,
  base_color = {r=1, g=0, b=0},
  flow_color = {r=1, g=0.6, b=0.6},

  icon = "__oil-furnace__/furnace-oil.png",
  icon_mipmaps = 4,
  icon_size = 64,

  fuel_value = "120kJ", -- 1:10 ratio with solid fuel
}

local furnace_oil_recipe = {
  type = "recipe",
  name = "soveu-oil-furnace-oil-recipe",
  category = "chemistry",
  subgroup = "fluid-recipes",
  enabled = false,

  icon = "__oil-furnace__/furnace-oil.png",
  icon_mipmaps = 4,
  icon_size = 64,

  energy_required = 2,
  ingredients = {
    {amount = 100, name = "light-oil", type = "fluid"}
  },
  results = {
    {amount = 100, name = "soveu-oil-furnace-oil", type = "fluid"}
  }
}

data:extend{furnace_oil, furnace_oil_recipe}
data:extend{oil_furnace_entity, oil_furnace_item, oil_furnace_recipe}

-- OIL BOILER
local oil_boiler_entity = table.deepcopy(data.raw["boiler"]["boiler"])
oil_boiler_entity.name = "soveu-oil-boiler-entity"
--oil_boiler_entity.energy_consumption = "5MJ"
oil_boiler_entity.energy_source = {
  type = "fluid",
  effectivity = 2.5,
  render_no_network_icon = false,
  burns_fluid = true,
  --scale_fluid_usage = true,
  --maximum_temperature = 499,
  --target_temperature = 490,

  fluid_box = {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, 1.5} }},
    secondary_draw_orders = { north = -1 },
    filter = "soveu-oil-furnace-oil"
  },
}

local oil_boiler_item = table.deepcopy(data.raw["item"]["boiler"])
oil_boiler_item.name = "soveu-oil-boiler-item"
oil_boiler_item.place_result = "soveu-oil-boiler-entity"

local oil_boiler_recipe = table.deepcopy(data.raw["recipe"]["boiler"])
oil_boiler_recipe.enabled = false
oil_boiler_recipe.name = "soveu-oil-boiler-recipe"
oil_boiler_recipe.result = "soveu-oil-boiler-item"
oil_boiler_recipe.ingredients = {
  {"pump", 1},
  {"boiler", 1}
}

data:extend{oil_boiler_entity, oil_boiler_item, oil_boiler_recipe}

local oil_technology = {
  type = "technology",
  name = "soveu-oil-furnace-technology",

  effects = {
    {type="unlock-recipe", recipe="soveu-oil-furnace-recipe"},
    {type="unlock-recipe", recipe="soveu-oil-boiler-recipe"},
    {type="unlock-recipe", recipe="soveu-oil-furnace-oil-recipe"}
  },

  icon = "__base__/graphics/technology/advanced-material-processing.png",
  icon_mipmaps = 4,
  icon_size = 256,

  prerequisites = {
    "advanced-material-processing-2",
    "advanced-oil-processing",
  },

  unit = {
    count = 100,
    time = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1}
    }
  }
}

data:extend{oil_technology}
