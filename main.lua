-- day 0 update
-- first render unto screen
-- importing a library

local push = require 'push'--[[  is a simple resolution-handling library that allows 
you to focus on making your game with a fixed resolution. ]]
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432 -- the course also suggested to create a virtual width and height
VIRTUAL_HEIGHT = 243 -- for the push graphics 2

PADDLE_SPEED = 200

function love.load() -- day 0 update
    love.graphics.setDefaultFilter('nearest', 'nearest') 
    love.window.setTitle("Tanginamo AJ!")
    math.randomseed(os.time())
    --[[ instead of using love.window.setMode we used push:setupScreen ]]
    -- key reason is to create a retro feel in the game 
    scoreFont = love.graphics.newFont('font.ttf', 32)
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })  

    player1 = Paddle(10, 30 , 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    player1Score = 0
    player2Score = 0

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' or key == 'enter' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ball:reset()
        end
    end

end

function love.draw()
    push:apply('start') -- start of the push graphics

    love.graphics.clear(40/255,45/255,52/255,255)

    love.graphics.setFont(smallFont)

    if(gameState == 'start') then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else 
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(
        tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    
    love.graphics.print(
        tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    player1:render()
    player2:render()
    ball:render()

    displayFPS()
    push:apply('end') -- end of the push graphics 
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' ..tostring(love.timer.getFPS()),10 ,10)
end

