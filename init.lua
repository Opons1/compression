compression.compressed_nodes = {
    "techage:basalt_cobble",
	"default:clay",
	"default:desert_stone",
	"default:desert_sand",
	"default:stone",
	"default:sand",
	"default:silver_sand",
	"default:dry_dirt",
	"default:gravel",
	"default:ice",
	"default:permafrost",
	"default:obsidian",
	"default:snowblock",
	"default:coalblock",
	"wool:white",
	"default:steelblock",
	"default:copperblock",
	"default:bronzeblock",
	"default:goldblock",
	"default:mese",
	"default:diamondblock",
	"default:tinblock",
	"basic_materials:brass_block",
	"ethereal:crystal_block",
	"moreores:mithril_block",
	"moreores:silver_block",
	"techage:iron_block",
	"technic:carbon_steel_block",
	"technic:cast_iron_block",
	"technic:chromium_block",
	"technic:lead_block",
	"technic:stainless_steel_block",
	"technic:uranium_block",
	"technic:zinc_block",
	"terumet:block_cgls",
	"terumet:block_raw",
	"terumet:block_tcha",
	"terumet:block_tcop",
	"terumet:block_tgol",
	"terumet:block_tste",
	"terumet:block_ttin",
	"amethyst_new:amethyst",
	"amethyst_new:basalt",
	"amethyst_new:calcite",
	"badlands:red_sandstone",
	"basic_materials:cement_block",
	"basic_materials:concrete_block",
	"darkage:basalt",
	"darkage:gneiss",
	"darkage:marble",
	"darkage:ors",
	"darkage:rhyolitic_tuff",
	"darkage:schist",
	"darkage:serpentine",
	"darkage:shale",
	"darkage:silt",
	"darkage:slate",
	"darkage:tuff",
	"ethereal:blue_marble",
	"ethereal:dry_dirt",
	"naturalbiomes:alpine_rock",
	"naturalbiomes:mediterran_rock",
	"naturalbiomes:outback_rock",
	"naturalbiomes:palmbeach_rock",
    "darks:darkblock",
    "brights:brightblock",
    "technic_many_machines:asteroid_stone",
    "technic_many_machines:forge_block",
    "technic_many_machines:thorium_block",
    "technic_many_machines:radiant_alloy_block",
    "birthstones:alexandriteblock",
    "birthstones:amethytstblock",
    "birthstones:aquamarineblock",
    "birthstones:diamondblock",
    "birthstones:emeraldblock",
    "birthstones:garnetblock",
    "birthstones:opalblock",
    "birthstones:peridotblock",
    "birthstones:rubyblock",
    "birthstonessapphireblock",
    "birthstones:topazblock",
    "birthstones:zirconblock",
    "opw_events:block_motillusion"
}

local moreblocks_available = core.get_modpath("moreblocks")
local max_compression_level = tonumber(core.settings:get("max_compression_level") or 10)
local maxlvl = tonumber(core.settings:get("max_compression_level") or 10)

compression.register_compressed_nodes(compression.compressed_nodes, maxlvl)

local mod = ""
local moreblocks_stone_output = ""
local moreblocks_desert_stone_output = ""

if moreblocks_available then
	compression.register_compressed_tiers("moreblocks:cobble_compressed", maxlvl)
	compression.register_compressed_tiers("moreblocks:desert_cobble_compressed", maxlvl)
	compression.register_compressed_tiers("moreblocks:dirt_compressed", maxlvl)

    if max_compression_level > 0 then
        moreblocks_stone_output, moreblocks_desert_stone_output = "compression:default_stone_compressed_level_1", "compression:default_desert_stone_compressed_level_1"
    else
        moreblocks_stone_output, moreblocks_desert_stone_output = "default:stone 9", "default:desert_stone 9"
    end

	core.register_craft({
        type = "cooking",
        recipe = "moreblocks:cobble_compressed",
        output = moreblocks_stone_output,
        cooktime = 9,
    })
	core.register_craft({
        type = "cooking",
        recipe = "moreblocks:desert_cobble_compressed",
        output = moreblocks_desert_stone_output,
        cooktime = 9,
    })

    mod = "moreblocks"
else
	compression.register_compressed_tiers("default:cobble", maxlvl)
	compression.register_compressed_tiers("default:desert_cobble", maxlvl)
	compression.register_compressed_tiers("default:dirt", maxlvl)

    mod = "default"
end

for level = 1, max_compression_level, 1 do
    core.register_craft({
        type = "cooking",
        recipe = "compression:" .. mod .. "_cobble_compressed_level_" .. level,
        output = "compression:default_stone_compressed_level_" .. level,
        cooktime = 3 ^ level,
    })
    core.register_craft({
        type = "cooking",
        recipe = "compression:" .. mod .. "_desert_cobble_compressed_level_" .. level,
        output = "compression:default_desert_stone_compressed_level_" .. level,
        cooktime = 3 ^ level,
    })
    if level < 8 then
        core.register_craft({
            type = "fuel",
            recipe = "compression:default_coalblock_compressed_level_" .. level,
            burntime = 370 * (9 ^ level),
        })
    end
end