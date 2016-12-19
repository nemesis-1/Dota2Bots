----------------------------------------------------------------------------------------------------

local all_bot_heroes = {
  "npc_dota_hero_abaddon",
  "npc_dota_hero_abyssal_underlord",
  "npc_dota_hero_alchemist",
  "npc_dota_hero_ancient_apparition",
  "npc_dota_hero_antimage",
  "npc_dota_hero_arc_warden",
  "npc_dota_hero_axe",
  "npc_dota_hero_bane",
  "npc_dota_hero_batrider",
  "npc_dota_hero_beastmaster",
  "npc_dota_hero_bloodseeker",
  "npc_dota_hero_bounty_hunter",
  "npc_dota_hero_brewmaster",
  "npc_dota_hero_bristleback",
  "npc_dota_hero_broodmother",
  "npc_dota_hero_centaur",
  "npc_dota_hero_chaos_knight",
  "npc_dota_hero_chen",
  "npc_dota_hero_clinkz",
  "npc_dota_hero_crystal_maiden",
  "npc_dota_hero_dark_seer",
  "npc_dota_hero_dazzle",
  "npc_dota_hero_death_prophet",
  "npc_dota_hero_disruptor",
  "npc_dota_hero_doom_bringer",
  "npc_dota_hero_dragon_knight",
  "npc_dota_hero_drow_ranger",
  "npc_dota_hero_earth_spirit",
  "npc_dota_hero_earthshaker",
  "npc_dota_hero_elder_titan",
  "npc_dota_hero_ember_spirit",
  "npc_dota_hero_enchantress",
  "npc_dota_hero_enigma",
  "npc_dota_hero_faceless_void",
  "npc_dota_hero_furion",
  "npc_dota_hero_gyrocopter",
  "npc_dota_hero_huskar",
  "npc_dota_hero_invoker",
  "npc_dota_hero_jakiro",
  "npc_dota_hero_juggernaut",
  "npc_dota_hero_keeper_of_the_light",
  "npc_dota_hero_kunkka",
  "npc_dota_hero_legion_commander",
  "npc_dota_hero_leshrac",
  "npc_dota_hero_lich",
  "npc_dota_hero_life_stealer",
  "npc_dota_hero_lina",
  "npc_dota_hero_lion",
  "npc_dota_hero_lone_druid",
  "npc_dota_hero_luna",
  "npc_dota_hero_lycan",
  "npc_dota_hero_magnataur",
  "npc_dota_hero_medusa",
  "npc_dota_hero_meepo",
  "npc_dota_hero_mirana",
  "npc_dota_hero_monkey_king",
  "npc_dota_hero_morphling",
  "npc_dota_hero_naga_siren",
  "npc_dota_hero_necrolyte",
  "npc_dota_hero_nevermore",
  "npc_dota_hero_night_stalker",
  "npc_dota_hero_nyx_assassin",
  "npc_dota_hero_obsidian_destroyer",
  "npc_dota_hero_ogre_magi",
  "npc_dota_hero_omniknight",
  "npc_dota_hero_phantom_assassin",
  "npc_dota_hero_phantom_lancer",
  "npc_dota_hero_phoenix",
  "npc_dota_hero_puck",
  "npc_dota_hero_pudge",
  "npc_dota_hero_pugna",
  "npc_dota_hero_queenofpain",
  "npc_dota_hero_rattletrap",
  "npc_dota_hero_razor",
  "npc_dota_hero_riki",
  "npc_dota_hero_rubick",
  "npc_dota_hero_sand_king",
  "npc_dota_hero_shadow_demon",
  "npc_dota_hero_shadow_shaman",
  "npc_dota_hero_shredder",
  "npc_dota_hero_silencer",
  "npc_dota_hero_skeleton_king",
  "npc_dota_hero_skywrath_mage",
  "npc_dota_hero_slardar",
  "npc_dota_hero_slark",
  "npc_dota_hero_sniper",
  "npc_dota_hero_spectre",
  "npc_dota_hero_spirit_breaker",
  "npc_dota_hero_storm_spirit",
  "npc_dota_hero_sven",
  "npc_dota_hero_templar_assassin",
  "npc_dota_hero_terrorblade",
  "npc_dota_hero_tidehunter",
  "npc_dota_hero_tinker",
  "npc_dota_hero_tiny",
  "npc_dota_hero_treant",
  "npc_dota_hero_troll_warlord",
  "npc_dota_hero_tusk",
  "npc_dota_hero_undying",
  "npc_dota_hero_ursa",
  "npc_dota_hero_vengefulspirit",
  "npc_dota_hero_venomancer",
  "npc_dota_hero_viper",
  "npc_dota_hero_visage",
  "npc_dota_hero_warlock",
  "npc_dota_hero_weaver",
  "npc_dota_hero_windrunner",
  "npc_dota_hero_winter_wyvern",
  "npc_dota_hero_wisp",
  "npc_dota_hero_witch_doctor",
  "npc_dota_hero_zuus",
};

force_radiant_pick = {
  };

force_dire_pick = {
  "npc_dota_hero_lina",
};


----------------------------------------------------------------------------------------------------
--
-- UTILS
--
----------------------------------------------------------------------------------------------------
function tablelength(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end


----------------------------------------------------------------------------------------------------
--
-- BOTS
--
----------------------------------------------------------------------------------------------------

RADIANT_FIRST_PLAYER = 0;
RADIANT_LAST_PLAYER = 4;
DIRE_FIRST_PLAYER = 5;
DIRE_LAST_PLAYER = 9;

WAITING_LIMIT = 50;

function Think()
  local pickState = GetHeroPickState();
  if (pickState == HEROPICK_STATE_AP_SELECT) then
    AllPickThink();
  else
    error("don't know what to do");
  end
end

function AllPickThink()
  if (GetTeam() == TEAM_RADIANT)
  then
    if (not DireDonePicking() and GetGameStateTimeRemaining() > WAITING_LIMIT)
    then
      -- print ("waiting radiant to pick");
      return;
    end
    -- print("selecting radiant");
    local nPlayer = RADIANT_FIRST_PLAYER;
    for _,hForced in pairs(force_radiant_pick) do
      SelectHero(nPlayer, hForced);
      nPlayer = nPlayer + 1;
    end
    PickAll(nPlayer, RADIANT_LAST_PLAYER);
  elseif (GetTeam() == TEAM_DIRE)
  then
    if (not RadiantDonePicking() and GetGameStateTimeRemaining() > WAITING_LIMIT)
    then
      -- print ("waiting radiant to pick");
      return;
    end
    -- print("selecting dire");
    local nPlayer = DIRE_FIRST_PLAYER;
    for _,hForced in pairs(force_dire_pick) do
      SelectHero(nPlayer, hForced);
      nPlayer = nPlayer + 1;
    end
    PickAll(nPlayer, DIRE_LAST_PLAYER);
  end
end

function RadiantDonePicking()
  for i = RADIANT_FIRST_PLAYER, RADIANT_LAST_PLAYER do
    local hName = GetSelectedHeroName(i);
    if (hName == nil or hName == "")
    then
      return false;
    end
  end
  return true;
end

function DireDonePicking()
  for i = DIRE_FIRST_PLAYER, DIRE_LAST_PLAYER do
    local hName = GetSelectedHeroName(i);
    if (hName == nil or hName == "")
    then
      return false;
    end
  end
  return true;
end

function IsHeroPicked(hName)
  for i = RADIANT_FIRST_PLAYER, DIRE_LAST_PLAYER do
    local selName = GetSelectedHeroName(i);
    if (selName ~= nil and selName ~= "" and hName == selName)
    then
      -- print(selName .. " already picked!");
      return true;
    end
  end
  return false;
end

function PickAll(firstPlayer, lastPlayer)
  local numAvailable = tablelength(all_bot_heroes);
  for i = firstPlayer, lastPlayer
  do
    local hName = GetSelectedHeroName(i);
    if (hName == nil or hName == "")
    then
      local heroChoice = nil;
      local selIndex = nil;
      repeat
        selIndex = RandomInt(0, numAvailable);
        heroChoice = all_bot_heroes[selIndex];
      until (not IsHeroPicked(heroChoice));
      SelectHero(i, heroChoice);
    end
  end
end

----------------------------------------------------------------------------------------------------
