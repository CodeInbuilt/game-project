-- Interface
DecisionMaker = {}

function DecisionMaker:decide(input)
    error("decide() not implemented!")
end

-- Class 1: FruitAI
FruitAI = {}
FruitAI.__index = FruitAI
setmetatable(FruitAI, {__index = DecisionMaker})

function FruitAI:new()
    local obj = {}
    setmetatable(obj, self)
    return obj
end

function FruitAI:decide(input)
    if input.type == "fruit" then
        return "🍎 Apple System Selected"
    end
    return "FruitAI: Unknown"
end

-- Class 2: VehicleAI
VehicleAI = {}
VehicleAI.__index = VehicleAI
setmetatable(VehicleAI, {__index = DecisionMaker})

function VehicleAI:new()
    local obj = {}
    setmetatable(obj, self)
    return obj
end

function VehicleAI:decide(input)
    if input.type == "vehicle" then
        return "🚗 Car System Selected"
    end
    return "VehicleAI: Unknown"
end

-- System using polymorphism
function runDecisionSystem(aiObject, input)
    print(aiObject:decide(input))
end

-- Test
local fruitAI = FruitAI:new()
local vehicleAI = VehicleAI:new()

runDecisionSystem(fruitAI, {type = "fruit"})
runDecisionSystem(vehicleAI, {type = "vehicle"})
runDecisionSystem(fruitAI, {type = "vehicle"})