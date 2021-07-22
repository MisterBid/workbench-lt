local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)

Knit.AddServices(script.Parent.Services)

Knit.Start():Catch(warn)