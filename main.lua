-- day 0 update
-- first render unto screen
-- importing a library

local push = require 'push'--[[  is a simple resolution-handling library that allows 
you to focus on making your game with a fixed resolution. ]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432 -- the course also suggested to create a virtual width and height
VIRTUAL_HEIGHT = 243 -- for the push graphics 2

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --[[ instead of using love.window.setMode we used push:setupScreen ]]
    -- key reason is to create a retro feel in the game 
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

end

playerOneScore = 0
playerTwoScore = 0

playerOneY = 30
playerTwoY = VIRTUAL_HEIGHT - 50

function love.update(dt)
    if love.keyboard.isDown('w') then
        playerOneY = playerOneY - PADDLE_SPEED * dt
    end
        
    if love.keyboard.isDown('s') then
        playerOneY = playerOneY + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        playerTwoY = playerTwoY - PADDLE_SPEED * dt
    end
        
    if love.keyboard.isDown('down') then
        playerTwoY = playerTwoY + PADDLE_SPEED * dt
    end
end



function love.draw()
    push:apply('start') -- start of the push graphics

    love.graphics.clear(40/255,45/255,52/255,255)

    --ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4 )
    -- left paddel
    love.graphics.rectangle('fill', 10, playerOneY, 5, 20)
    --right paddel
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, playerTwoY, 5, 20)
    
    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Welcome to Pong!', 0,
        20,
        VIRTUAL_WIDTH,
        'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(
        tostring(playerOneScore), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    
    love.graphics.print(
        tostring(playerTwoScore), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
    push:apply('end') -- end of the push graphics 
end

