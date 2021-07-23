local Players = game:GetService("Players")

local Player = Players.LocalPlayer

wait(3)

local CurrentCamera = workspace.CurrentCamera

CurrentCamera.CameraType = Enum.CameraType.Scriptable
CurrentCamera.CFrame = workspace.ToastieTable.ChoppingBoard.CameraReference.WorldCFrame