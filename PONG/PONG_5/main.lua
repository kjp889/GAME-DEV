push = require 'push'

Class = require 'class'

require 'Paddle'

require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  --[[
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
  ]]  

    love.graphics.setDefaultFilter('nearest','nearest')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf',8)

    --scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    
    p1 = Paddle(10, 30, 5, 20)
    p2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        p1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        p1.dy = PADDLE_SPEED
    end

    if love.keyboard.isDown('up') then
        p2.dy = -PADDLE_SPEED 
    elseif love.keyboard.isDown('down') then
        p2.dy = PADDLE_SPEED 
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    p1:update(dt)
    p2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(64, 47, 116, 0)

    love.graphics.setFont(smallFont)
    if gameState == 'start' then
        love.graphics.printf('Hello Start Pong!!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play Pong!!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

   -- love.graphics.setFont(scoreFont)
   -- love.graphics.print(tostring(p1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
   -- love.graphics.print(tostring(p2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    p1:render()
    p2:render()

    ball:render()

    push:apply('end')
end
