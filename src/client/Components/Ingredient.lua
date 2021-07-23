local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Knit = require(ReplicatedStorage.Knit)
local Maid = require(Knit.Util.Maid)

local Ingredient = {}
Ingredient.__index = Ingredient

Ingredient.Tag = "Ingredient"


function Ingredient.new(IngredientObject)
    
    local self = setmetatable({}, Ingredient)
    
    self._maid = Maid.new()

    _G.Dragging = false
    _G.Selected = nil
    local Debounce = false

    local Interface = Instance.new("SurfaceGui")
    Interface.Parent = IngredientObject
    Interface.Name = "Interface"
    Interface.Face = Enum.NormalId.Top

    local TextButton = Instance.new("TextButton")
    TextButton.Parent = Interface
    TextButton.Name = "InputButton"
    TextButton.Text = ""
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.BackgroundTransparency = 1

    if not IngredientObject:GetAttribute("IsBoard") then
        TextButton.InputBegan:Connect(function(Input)
            local InputType = Input.UserInputType
            local Touch = Enum.UserInputType.Touch
            local Mouse = Enum.UserInputType.MouseButton1
            
            if InputType == Touch or InputType == Mouse then
                if Debounce then return end
                Debounce = true

                _G.Dragging = true
                _G.Selected = IngredientObject

                wait(.25) -- Replace with task.wait() once out of beta
                Debounce = false
            end
        end)
    else
        TextButton.InputEnded:Connect(function(Input)
            local InputType = Input.UserInputType
            local Touch = Enum.UserInputType.Touch
            local Mouse = Enum.UserInputType.MouseButton1

            if InputType == Touch or InputType == Mouse then
                if not _G.Dragging or not _G.Selected then return end
                if Debounce then return end
                Debounce = true

                print(_G.Selected, "added to Chopping Board")
                _G.Selected = nil
                
                wait(.25) -- Replace with task.wait() once out of beta
                Debounce = false
            end
        end)
    end

    self._maid:GiveTask(function()
        print("Ingredient destroyed")
    end)
    
    return self
end

function Ingredient:Init()
end

function Ingredient:Deinit()
end

function Ingredient:Destroy()
    self._maid:Destroy()
end


return Ingredient