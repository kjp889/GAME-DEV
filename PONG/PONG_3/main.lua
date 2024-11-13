push = require 'push'

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

    smallFont = love.graphics.newFont('font.ttf',8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    
    p1Score = 0
    p2Score = 0

    p1Y = 30
    p2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        p1Y = p1Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        p1Y = p1Y + (PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        p2Y = p2Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        p2Y = p2Y + (PADDLE_SPEED * dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(64, 47, 116, 0)

    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Hello Pong!!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(p1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(p2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle('fill', 10, p1Y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, p2Y, 5, 20)

    love.graphics.rectangle('fill', (VIRTUAL_WIDTH / 2) - 2, (VIRTUAL_HEIGHT / 2) - 2, 4, 4)

    push:apply('end')
end

