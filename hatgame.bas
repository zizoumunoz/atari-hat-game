;   Author: Zinadine M. L.
;   Game about catching belongings and furniture to help a lady move.
;   Pending name: MOVERS INC.
    set tv ntsc
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
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 

;   Player Sprites
    player0:
    %0111100
    %0101000
    %0101000
    %0101000
    %0101000
    %0101000
    %0101000
    %0111000
    %1111111
    %1111100
    %1111100
    %0010000
    %0111000
    %0111000
    %0111110
    %0111000
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
    const GREEN = $CC
    const BLUE_LIGHT = $AE
    const BLUE = $8A
    const BLUE_DARK = $88
    const TAN = $FC
    const TAN_DARK = $FA 
    const BROWN = $18
    const BROWN_DARK = $16 
;   Constants - Screen Res
    const SCREEN_HEIGHT = 192
    const SCREEN_WIDTH = 160
;   Consant - Furniture Type

;   Initializing players
    player0x = SCREEN_WIDTH / 4 - 4
    player0y = SCREEN_HEIGHT - 105

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
    if joy0left then player0x = player0x - 1 : REFP0 = 8 : _Frame_Counter = _Frame_Counter + 1
    if _Frame_Counter = 50 then _Frame_Counter = 0
    if _Frame_Counter > 0 && _Frame_Counter < 20 then __p0walkframe0
    if _Frame_Counter > 20 && _Frame_Counter < 50  then __p0walkframe1
    _Frame_Counter = 0
    if _Frame_Counter = 0 then __p0idleframe
    



    goto mainloop

;   Missile status vars

;   Missile (Furniture) Generation
;   Using missile1 to have diff colors from player0
__randmissile1pos
    missile1x = rand - 60
    goto mainloop

;   Animation Frames    -----------------------------------------------
__p0walkframe0
    player0:
    %0110000
    %0101100
    %0101000
    %0101000
    %0101000
    %0111000
    %1111111
    %1111100
    %1111100
    %0010000
    %0111000
    %0111000
    %0111110
    %0111000
end
    goto mainloop
__p0walkframe1
    player0:
    %0001100
    %0111000
    %0101000
    %0101000
    %0101000
    %0111000
    %1111111
    %1111100
    %1111100
    %0010000
    %0111000
    %0111000
    %0111110
    %0111000
end
    goto mainloop
__p0idleframe
    player0:
    %0111100
    %0101000
    %0101000
    %0101000
    %0101000
    %0111000
    %1111111
    %1111100
    %1111100
    %0010000
    %0111000
    %0111000
    %0111110
    %0111000
end
    goto mainloop

;   Furniture 
__boxSprite
    player1color:
    BROWN_DARK
    BROWN_DARK
    BROWN
    BROWN
    BROWN
end
    goto mainloop
    player1:
    %111111
    %110011
    %111111
    %111111
    %111111
end


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
    GREEN
end
    player1color:
    BLUE
    BLUE
    BLUE
    BLUE
    BLUE_LIGHT
end
    player0color:
    BLUE_DARK
    BLUE_DARK
    BLUE_DARK
    BLUE
    BLUE
    BLUE_DARK
    TAN_DARK
    BLUE_DARK
    BLUE_DARK
    TAN
    TAN
    TAN_DARK
    BLUE_DARK
    BLUE
end

    drawscreen
    COLUP1 = YELLOW     ;   Set colors for furniture
    COLUP0 = WHITE      ;   Set player colors
    
    goto __p0movement
    goto mainloop



