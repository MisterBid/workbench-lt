local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Knit = require(ReplicatedStorage.Knit)
local Maid = require(Knit.Util.Maid)

local Ingredient = {}
Ingredient.__index = Ingredient

Ingredient.Tag = "Ingredient"


_G.Dragging = false
_G.Selected = nil
_G.Hovering = false


function Ingredient.CreateDragInterface()
    local DragInterfaceSet = {}
    local DragInterface = Instance.new("ScreenGui")
    DragInterface.Parent = Lighting
    DragInterface.Name = "DragInterface"
    DragInterfaceSet.DragInterface = DragInterface
    
    local TestFrame = Instance.new("Frame")
    TestFrame.Parent = DragInterface
    TestFrame.Name = "TestFrame"
    TestFrame.Size = UDim2.new(0, 50, 0, 50)
    DragInterfaceSet.TestFrame = TestFrame

    return DragInterfaceSet
end

local DragInterfaceSet = Ingredient.CreateDragInterface()


function Ingredient.CreateInterface(IngredientObject)
    local InterfaceSet = {}
    local Interface = Instance.new("SurfaceGui")
    Interface.Parent = IngredientObject
    Interface.Name = "Interface"
    Interface.Face = Enum.NormalId.Top
    InterfaceSet.Interface = Interface

    local TextButton = Instance.new("TextButton")
    TextButton.Parent = Interface
    TextButton.Name = "InputButton"
    TextButton.Text = ""
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.BackgroundTransparency = 1
    InterfaceSet.TextButton = TextButton

    return InterfaceSet
end


function Ingredient.new(IngredientObject)
    
    local self = setmetatable({}, Ingredient)
    
    self._maid = Maid.new()

    local Debounce = false
    local MouseLeave = false
    local Touch = Enum.UserInputType.Touch
    local Mouse = Enum.UserInputType.MouseButton1

    if not IngredientObject:GetAttribute("IsBoard") then
        local InterfaceSet = self.CreateInterface(IngredientObject)
        local TextButton = InterfaceSet.TextButton

        TextButton.InputBegan:Connect(function(Input)
            local InputType = Input.UserInputType
            
            if InputType == Touch or InputType == Mouse then
                if Debounce then return end
                Debounce = true

                _G.Dragging = true
                _G.Selected = IngredientObject
                DragInterfaceSet.DragInterface.Parent = PlayerGui

                wait(.25) -- Replace with task.wait() once out of beta
                Debounce = false
            end
        end)

        TextButton.MouseEnter:Connect(function()
            _G.Hovering = true
        end)
    else
        PlayerGui:WaitForChild("Interface").Adornee = IngredientObject

        PlayerGui.Interface.BoardField.MouseEnter:Connect(function()
            _G.Hovering = false
        end)

        UserInputService.InputEnded:Connect(function(Input)
            local InputType = Input.UserInputType

            if InputType == Touch or InputType == Mouse then
                if not _G.Dragging or not _G.Selected then return end
                if Debounce then return end
                Debounce = true

                PlayerGui.Interface.Adornee = IngredientObject
                local MouseLocation = UserInputService:GetMouseLocation()
                local GuiObjects = PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y)

                if table.find(GuiObjects, PlayerGui.Interface.BoardField) and not _G.Hovering then
                    print(_G.Selected, "added to Chopping Board")
                end
  
                _G.Dragging = false
                _G.Selected = nil
                DragInterfaceSet.DragInterface.Parent = Lighting
                
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


function Ingredient:RenderUpdate()
    if not _G.Dragging or not _G.Selected then return end
    local MouseLocation = UserInputService:GetMouseLocation()
    DragInterfaceSet.TestFrame.Position = UDim2.fromOffset(MouseLocation.X, MouseLocation.Y - 20)
end


function Ingredient:Destroy()
    self._maid:Destroy()
end


return Ingredient