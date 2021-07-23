local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)
local Component = require(Knit.Util.Component)

Knit.AddServices(script.Parent.Services)

Knit.Start():Then(function()
    Component.Auto(script.Parent.Components)
end):Catch(warn)