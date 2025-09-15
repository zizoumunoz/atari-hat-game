;   Author: Zinadine M. L.
;   Game about catching belongings and furniture to help a lady move.
;   Pending name: MOVERS INC.

    set kernel_options pfcolors playercolors player1colors 

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

;   Player Sprites
    player0:
    %00110110
    %00100100
    %00100100
    %00100100
    %00111100
    %00011000
    %01011010
    %01011010
    %01011010
    %00111100
    %00111100
    %00000000
    %00011000
    %00011000
    %00000000
    %00000000
end

    player1:
    %1111111
    %1111111
    %1111111
    %1100011
    %1111111
end
    
;   Constants - Colors
    const WHITE = $0E   ; Old colros
    const YELLOW = $1E

    const RED_LIGHT = $36
    const RED = $34
    const GRAY_LIGHT = $08
    const GRAY = $04
    const BLUE_LIGHT = $AE
    const BLUE = $7A
    const BLUE_DARK = $78
    const TAN = $EC
    const TAN_DARK = EA 
;   Constants - Screen Res
    const SCREEN_HEIGHT = 192
    const SCREEN_WIDTH = 160

;   Initializing players
    player0x = SCREEN_WIDTH / 4 - 4
    player0y = SCREEN_HEIGHT - 104

;   Initialize background
    COLUBK = BLUE_LIGHT

;   Initialize missile1
    dim _Frame_Counter = a
    _Frame_Counter = 0
    missile1x = 50
    missile1y = 2
    player1x = 50
    player1y = 50

;   Handle player0 movement
__p0movement
    if joy0right then player0x = player0x + 1 : _Frame_Counter = _Frame_Counter + 1
    if _Frame_Counter = 4 then _Frame_Counter = 0
    if _Frame_Counter = 0 ||_Frame_Counter = 1 then __p0frame0
    if _Frame_Counter = 2 || _Frame_Counter = 3 then __p0frame1
    if !joy0right then player0:
    %00110110
    %00100100
    %00100100
    %00100100
    %00111100
    %00011000
    %01011010
    %01011010
    %01011010
    %00111100
    %00111100
    %00000000
    %00011000
    %00011000
    %00000000
    %00000000
end


    if joy0left then player0x = player0x - 1
    goto mainloop

;   Missile status vars

;   Missile (Furniture) Generation
;   Using missile1 to have diff colors from player0
__randmissile1pos
    missile1x = rand - 60
    goto mainloop

;   Animation Frames
__p0frame0
    player0:
    %00000110
    %00110100
    %00100100
    %00100100
    %00111100
    %00011000
    %01011010
    %01011010
    %01011010
    %00111100
    %00111100
    %00000000
    %00011000
    %00011000
    %00000000
    %00000000
end
    goto mainloop
__p0frame1
    player0:
    %00110000
    %00100110
    %00100100
    %00100100
    %00111100
    %00011000
    %01011010
    %01011010
    %01011010
    %00111100
    %00111100
    %00000000
    %00011000
    %00011000
    %00000000
    %00000000
end
    goto mainloop

;   ========================
;   ====    MAIN LOOP   ====
;   ========================
mainloop
    ;   Playfield colors
    pfcolors:
    RED
    RED
    RED
    RED
    RED
    RED
    RED
    GRAY_LIGHT
    GRAY_LIGHT
    GRAY
    GRAY
end
    player1color:
    BLUE
    BLUE
    BLUE
    BLUE
    BLUE_LIGHT
end
    player0color:
    BLUE_LIGHT
    BLUE
    BLUE
    BLUE
    BLUE
    TAN
    TAN
    BLUE_LIGHT
end
    drawscreen
    COLUP1 = YELLOW     ;   Set colors for furniture
    COLUP0 = WHITE      ;   Set player colors
    goto __p0movement
    goto mainloop



