;   Author: Zinadine M. L.
;   Game about catching belongings and furniture to help a lady move.
;   Pending name: MOVERS INC.

    set kernel_options pfcolors

      playfield:
    ..XX...X...X...X...XX...........
    ..XXXXXXXXXXXXXXXXXXX...........
    ..XX...X...X...X...XX...........
    ..XX...X...X...X...XX...........
    ..XXXXXXXXXXXXXXXXXXX...........
    ..XX...X...X...X...XX...........
    ..XX...X...X...X...XX...........
    ..XXXXXXXXXXXXXXXXXXX.....XXXXXX
    ..XX...X...X...X...XX.....XXXXXX
    ..XX...X...X...X...XX....XXXXXXX
    ..XX...XXXXXXXXXXXXXX.......XX..
end 


    player0:
    %00111100
    %01000010
    %10111101
    %10000001
    %10110111
    %10100101
    %01000010
    %00111100
end

    player0color:
    $0E
    $0E
    $0E
    $0E
    $36
    $0E
    $0E
    $0E
end



;   Constants
    const WHITE = $0E
    const YELLOW = $1E
    const LIGHT_BLUE = $AE
    const DARK_RED = $44
    const GRAY = $04
    const SCREEN_HEIGHT = 192
    const SCREEN_WIDTH = 160

;   Initializing players
    player0x = SCREEN_WIDTH / 4 - 4
    player0y = SCREEN_HEIGHT - 114

;   Initialize background
    COLUBK = LIGHT_BLUE

;   Initialize missile1
    
    missile1x = 50
    missile1y = 50

;   Handle player0 movement
__p0movement
    if joy0right then player0x = player0x + 1
    if joy0left then player0x = player0x - 1
    goto mainloop

;   Missile status vars

;   Missile (Furniture) Generation
;   Using missile1 to have diff colors from player0
__randmissile1pos
    missile1x = rand & SCREEN_WIDTH
    goto mainloop


;   Main loop
mainloop
    pfcolors:
    DARK_RED
    DARK_RED
    DARK_RED
    DARK_RED
    DARK_RED
    DARK_RED
    DARK_RED
    GRAY
    GRAY
    GRAY
    GRAY
end
    drawscreen
    COLUP1 = YELLOW
    COLUP0 = WHITE      ;   Set player colors

    if joy0left then goto __randmissile1pos

    goto __p0movement

    goto mainloop


