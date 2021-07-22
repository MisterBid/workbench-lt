local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Knit)

local WorkbenchService = Knit.CreateService {
    Name = "WorkbenchService";
    Client = {};
}


function WorkbenchService:Print(message)
    print(message)
end

function WorkbenchService:KnitStart()
    print("Started")
end

function WorkbenchService:KnitInit()
    print("Initialized")
end


return WorkbenchService