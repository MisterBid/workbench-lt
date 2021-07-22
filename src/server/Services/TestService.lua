local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)

local TestService = Knit.CreateService {
    Name = "TestService";
    Client = {
        WoahCool = true
    };
}


function TestService.Client:Add(player, num1, num2)
    return num1 + num2
end

function TestService:KnitStart()
    Knit.Services.WorkbenchService:Print("Hello from TestService!")
end

function TestService:KnitInit()
    
end


return TestService