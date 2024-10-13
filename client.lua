-- Health and armor updater for NUI (custom bars)
CreateThread(function()
  while true do
    Wait(1000)
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armor = GetPedArmour(ped)
    
    -- Update health and armor in NUI (your custom HTML display)
    SendNUIMessage({
      data = "updateHA",
      heal = health,
      armor = armor
    })
  end
end)

-- Event to dynamically update minimap color
RegisterNetEvent("jax-minimap", function(color)
  SendNUIMessage({
    data = "updateColor",
    color = color
  })
end)

-- Keep the minimap and radar setup
CreateThread(function()
  TriggerEvent("Map:InitMap")
end)

-- Adjust radar zoom and disable the large map after a delay
CreateThread(function()
  Wait(10000)
  SetRadarBigmapEnabled(false, false)  -- Make sure the big map is disabled
  SetRadarZoom(1000)  -- Adjust zoom as per your needs
end)

-- Load and handle custom minimap (if you need additional behavior)
CreateThread(function()
  local minimap = RequestScaleformMovie("minimap")
  while not HasScaleformMovieLoaded(minimap) do
    Wait(1)
  end
end)

-- Event to initialize the custom map and radar settings
RegisterNetEvent("Map:InitMap", function()
  local resolutionX, resolutionY = GetActiveScreenResolution()

  -- Send resolution data to NUI (for any custom adjustments)
  SendNUIMessage({
    mapoutline = true,
    resolutionX = resolutionX,
    resolutionY = resolutionY
  })

  -- Adjust radar settings but keep it visible
  SetMinimapClipType(0)  -- Disable minimap clipping
  SetBlipAlpha(GetNorthRadarBlip(), 0)  -- Hide the north radar blip
  SetRadarZoom(1200)  -- Adjust zoom for the radar
end)

-- Hide default HUD elements (health and armor) but keep the radar visible
CreateThread(function()
  while true do
    Wait(0) -- Continuously hide components every frame

    -- Hide default health and armor bars (Component IDs 6 and 7)
    HideHudComponentThisFrame(6)  -- Hides health bar
    HideHudComponentThisFrame(7)  -- Hides armor bar

    -- Ensure radar is still visible
    DisplayRadar(true)  -- Explicitly make sure the radar stays visible
  end
end)
