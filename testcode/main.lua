-- Runs once when the game starts
function love.load()
    player = {
        x = 100,
        y = 100,
        speed = 200
    }
end

-- Runs every frame (Game Logic + Input)
function love.update(dt)
    -- Input handling
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end
end

-- Runs every frame (Rendering)
function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, 50, 50)
end