CreateThread(function()
  while true do
      Wait(1000)
      local ped = PlayerPedId()
      local health = GetEntityHealth(ped)
      local armor = GetPedArmour(ped)
      
      SendNUIMessage({
          data = "updateHA",
          heal = health,
          armor = armor
      })
  end
end)

RegisterNetEvent("jax-minimap", function(color)
  SendNUIMessage({
      data = "updateColor",
      color = color
  })
end)

RegisterNetEvent("Map:InitMap", function()
  local resolutionX, resolutionY = GetActiveScreenResolution()

  SendNUIMessage({
      mapoutline = true,
      resolutionX = resolutionX,
      resolutionY = resolutionY
  })

  SetMinimapClipType(0)
  SetBlipAlpha(GetNorthRadarBlip(), 0)
  SetRadarZoom(1200)
  DisplayRadar(true)
end)

CreateThread(function()
  TriggerEvent("Map:InitMap")
end)

CreateThread(function()
  while true do
      Wait(0)

      HideHudComponentThisFrame(6)
      HideHudComponentThisFrame(7)
      HideHudComponentThisFrame(8)

      DisplayRadar(true)
  end
end)

CreateThread(function()
  local minimap = RequestScaleformMovie("minimap")
  while not HasScaleformMovieLoaded(minimap) do
      Wait(1)
  end
end)

CreateThread(function()
  SetRadarBigmapEnabled(true, false)
  Wait(1000)  -- Wait for 1 second to ensure the radar is initialized
  SetRadarBigmapEnabled(false, false)
  SetRadarZoom(1000)
end)
