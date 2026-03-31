function love.load()
    gameName = "Cyber Rakshak"
end

function love.draw()
    love.graphics.print("Gaming Name: " .. gameName, 100, 100)
end