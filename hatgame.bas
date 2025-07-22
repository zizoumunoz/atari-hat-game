;   Author: Zinadine M. L.

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X.............X.X..............X
    X.............XXX..............X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X.............XXX..............X
    X.............X.X..............X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

    player0:
    %011011
    %010010
    %000000
    %011110
    %011110
    %111111
    %111111
    %111111
end

    player1:
    %011011
    %010010
    %000000
    %011110
    %011110
    %111111
    %111111
    %111111
end

;   Constants
    const WHITE = $0E
    const YELLOW = $1E
    const SCREEN_HEIGHT = 192
    const SCREEN_WIDTH = 160

;   Initializing players
    player0x = SCREEN_WIDTH / 4 - 4
    player0y = SCREEN_HEIGHT / 4
    player1x = SCREEN_WIDTH - 50
    player1y = SCREEN_HEIGHT / 4


;   Main loop
mainloop
    drawscreen

    COLUPF = YELLOW     ;   Playfield color
    COLUP0 = WHITE      ;   Set player colors
    COLUP1 = WHITE

    goto mainloop


