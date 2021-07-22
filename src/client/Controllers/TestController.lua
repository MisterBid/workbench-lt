local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)

local TestController = Knit.CreateController {
    Name = "TestController"
}


function TestController:KnitStart()
    local TestService = Knit.GetService("TestService")
    print(TestService:Add(10, 50))
end

function TestController:KnitInit()
    
end


return TestController