
Drawable = {}

function Drawable:draw()
    error("draw() not implemented!")
end

function Drawable:update(dt)
    error("update() not implemented!")
end



Player = {}
Player.__index = Player
setmetatable(Player, { __index = Drawable })

function Player:new(x, y)
    local obj = {
        x = x,
        y = y,
        size = 40,
        speed = 200,
        inventory = {} 
    }
    setmetatable(obj, self)
    return obj
end

function Player:update(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end
end

function Player:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Player:addItem(itemName)
    table.insert(self.inventory, itemName)
end



Item = {}
Item.__index = Item
setmetatable(Item, { __index = Drawable })

function Item:new(x, y, name)
    local obj = {
        x = x,
        y = y,
        size = 20,
        name = name,
        collected = false
    }
    setmetatable(obj, self)
    return obj
end

function Item:update(dt)
    
end

function Item:draw()
    if not self.collected then
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
    end
end



player = nil
items = {}


function checkCollision(a, b)
    return a.x < b.x + b.size and
           b.x < a.x + a.size and
           a.y < b.y + b.size and
           b.y < a.y + a.size
end



function love.load()
    love.window.setTitle("Inventory System Example")

    player = Player:new(100, 100)

    
    table.insert(items, Item:new(300, 200, "Gold"))
    table.insert(items, Item:new(400, 300, "Potion"))
    table.insert(items, Item:new(200, 350, "Key"))
end

function love.update(dt)
    player:update(dt)

   
    for _, item in ipairs(items) do
        if not item.collected and checkCollision(player, item) then
            item.collected = true
            player:addItem(item.name)
        end
    end
end

function love.draw()
    
    player:draw()

    -- draw items
    for _, item in ipairs(items) do
        item:draw()
    end

    -- =========================
    -- INVENTORY UI
    -- =========================
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Inventory:", 10, 10)

    for i, itemName in ipairs(player.inventory) do
        love.graphics.print("- " .. itemName, 10, 10 + i * 20)
    end

    love.graphics.print("Move with Arrow Keys", 10, 300)
end