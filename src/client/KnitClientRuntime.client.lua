local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)

Knit.AddControllers(script.Parent.Controllers)

Knit.Start():Catch(warn)