'◊Ûπ¥»≠£∫Aº¸
'”“π¥»≠£∫Bº¸
'À´ ÷÷±π¥»≠£∫ª“…´…œº˝Õ∑
'À´ ÷∫Û“∆£∫ª“…´œ¬º˝Õ∑
'æœπ™Œ ∫√£∫2º¸
'ÃÙ–∆£∫3º¸
'”µ±ß£∫8º¸
'◊Û◊™£∫*◊÷º¸
'¥Û◊Û◊™£∫P1º¸
'”“◊™£∫#◊÷º¸
'¥Û”“◊™£∫P2º¸
'«∞Ω¯£∫¿∂…´…œº˝Õ∑
'∫ÛÕÀ£∫¿∂…´œ¬º˝Õ∑
'◊Û“∆“ª¥Û≤Ω£∫¿∂…´◊Ûº˝Õ∑
'”““∆“ª¥Û≤Ω£∫¿∂…´”“º˝Õ∑
'◊Û“∆“ª–°≤Ω£∫ª“…´Eº¸
'”““∆“ª–°≤Ω£∫ª“…´Gº¸
'¥Û≈Ù’π≥·£∫ª“…´◊Ûº˝Õ∑£®◊Û£©°¢ª“…´”“º˝Õ∑£®”“£©
'◊Û∂„±‹£∫ª“…´cº¸
'”“∂„±‹£∫ª“…´Dº¸



'******** ROBONOVA-2 Standard Program ********

DIM I AS BYTE
DIM J AS BYTE
DIM pose AS BYTE
DIM Action_mode AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM walk_speed AS BYTE
DIM LR_speed AS BYTE
DIM LR_speed2 AS BYTE
DIM walk_order AS BYTE
DIM now_voltage AS BYTE
DIM reverse_check AS BYTE
DIM motor_ONOFF AS BYTE
DIM gyro_ONOFF AS BYTE
DIM tilt_FB AS INTEGER
DIM tilt_LR AS INTEGER
DIM DELAY_TIME AS BYTE
DIM DELAY_TIME2 AS BYTE
DIM TEMP AS BYTE
DIM thing_chach_pose AS BYTE
DIM tilt_check_count AS BYTE
DIM fall_check AS BYTE

DIM repeat_order AS BYTE
DIM tilt_check_failure AS BYTE
DIM promote_dir_failure AS BYTE

DIM info_index AS BYTE

DIM S6 AS BYTE
DIM S7 AS BYTE
DIM S8 AS BYTE

DIM S11 AS BYTE
DIM S12 AS BYTE
DIM S13 AS BYTE
DIM S14 AS BYTE


'**** tilt_port *****

CONST FB_tilt_AD_port = 2
CONST LR_tilt_AD_port = 3

'**** OLD tilt Sensors *****
'CONST tilt_time_check = 10
'CONST min = 100			
'CONST max = 160			
'CONST COUNT_MAX = 30

'**** 2012 NEW tilt Sensors *****
CONST tilt_time_check = 5
CONST min = 61			
CONST max = 107			
CONST COUNT_MAX = 20
'*******************

CONST low_volt = 103	

PTP SETON 				
PTP ALLON				

DIR G6A,1,0,0,1,0,0		
DIR G6B,1,1,1,1,1,1		
DIR G6C,0,0,0,0,0,0		
DIR G6D,0,1,1,0,1,0		


'***** first_declaration *********************************
motor_ONOFF = 0
walk_order = 0
reverse_check = 0
tilt_check_count = 0
fall_check = 0
tilt_check_failure = 1
promote_dir_failure = 0
thing_chach_pose = 0
'****Action_mode()******************
Action_mode = 0		'D(CODE 27):dancemode
'Action_mode = 1	'F(CODE 32):fightmode
'Action_mode = 2	'G(CODE 23):gamemode
'Action_mode = 3	'B(CODE 20):footballmode
'Action_mode = 4	'E(CODE 18):steeplechase_racesmode
'Action_mode = 5	'C(CODE 17):cameramode
'Action_mode = 6	'A(CODE 15):promotemode



'*********************************
OUT 52,0	
DELAY 1000
GOSUB MOTOR_ON



SPEED 5
GOSUB first_power_pose
GOSUB standard_pose

PRINT "VOLUME 200 !"


GOSUB SOUND_MODE_SELECT





GOTO MAIN
'************************************************
'************************************************

MOTOR_FAST_ON:

    MOTOR G6B
    MOTOR G6C
    MOTOR G6A
    MOTOR G6D

    motor_ONOFF = 0
    RETURN

    '************************************************
    '************************************************
MOTOR_ON:

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    motor_ONOFF = 0
    GOSUB start_buzzer			
    RETURN

    '************************************************

MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    motor_ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB end_buzzer	
    RETURN
    '************************************************

MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,0,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1, , ,1
    MOTORMODE G6C,1,1,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2, , ,2
    MOTORMODE G6C,2,2,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3

    RETURN
    '************************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '************************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN

    '************************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '************************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '************************************************
Leg_motor_mode5:
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '************************************************
    '************************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1
    RETURN
    '************************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2
    RETURN
    '************************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3
    MOTORMODE G6C,3,3,3
    RETURN

    '************************************************
    '*******standard_pose*****************************
    '************************************************
first_power_pose:
    MOVE G6A,95,  76, 145,  93, 105, 100
    MOVE G6D,95,  76, 145,  93, 105, 100
    MOVE G6B,100,  45,  90, 100, 100, 100
    MOVE G6C,100,  45,  90, 100, 100, 100
    WAIT
    pose = 0
    RETURN
    '************************************************
stabilizing_pose:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0

    RETURN
    '************************************************
standard_pose:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0
    thing_chach_pose = 0
    RETURN
    '************************************************	
attention_pose:
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100, 20, 90, 100, 100, 100
    MOVE G6C,100, 20, 90, 100, 100, 100
    WAIT
    pose = 2
    RETURN
    '************************************************
sit_pose:

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    pose = 1

    RETURN

    '************************************************
RX_EXIT:
    'GOSUB SOUND_STOP
    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '************************************************
GOSUB_RX_EXIT:

    ERX 4800, A, GOSUB_RX_EXIT2

    GOTO GOSUB_RX_EXIT

GOSUB_RX_EXIT2:
    RETURN
    '************************************************
    '******* sound_module *************************
    '************************************************
MR_SOUND_OPEN:
    PRINT "OPEN MRSOUND.MRS !"
    RETURN
    '************************************************
SOUND_promote1:
    PRINT "SOUND 48!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote2:
    PRINT "SOUND 49!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote3:
    PRINT "SOUND 50!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote4:
    PRINT "SOUND 51!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote5:
    PRINT "SOUND 52!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote6:
    PRINT "SOUND 53!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote7:
    PRINT "SOUND 54!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote8:
    PRINT "SOUND 55!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
SOUND_promote9:
    PRINT "SOUND 56!"
    DELAY 500
    GOSUB GOSUB_RX_EXIT
    RETURN
    '************************************************
SOUND_people_dance: '
    PRINT "SOUND 47!"
    RETURN
SOUND_robo_link: '
    PRINT "SOUND 46!"
    RETURN
SOUND_HELLO: '
    PRINT "SOUND 12!"
    RETURN
SOUND_HELLO_miniROBOT_ROBONOVA_2: '
    PRINT "SOUND 0!"
    RETURN

    '************************************************
SOUND_MODE_SELECT:
    GOSUB MR_SOUND_OPEN

    IF Action_mode = 0 THEN			
        GOSUB  SOUND_dancemode
    ELSEIF Action_mode = 1 THEN		
        GOSUB SOUND_∞›≈ımode
    ELSEIF Action_mode = 2 THEN		
        GOSUB SOUND_gamemode
    ELSEIF Action_mode = 3 THEN		
        GOSUB SOUND_footballmode
    ELSEIF Action_mode = 4 THEN		
        GOSUB SOUND_steeplechase_racesmode
    ELSEIF Action_mode = 5 THEN		
        GOSUB SOUND_cameramode
    ELSEIF Action_mode = 6 THEN		
        GOSUB SOUND_promotemode
    ENDIF

    RETURN
    '************************************************
SOUND_dancemode:
    PRINT "SOUND 1!"
    RETURN
SOUND_∞›≈ımode:
    PRINT "SOUND 2!"
    RETURN
SOUND_gamemode:
    PRINT "SOUND 3!"
    RETURN
SOUND_footballmode:
    PRINT "SOUND 4!"
    RETURN
SOUND_steeplechase_racesmode:
    PRINT "SOUND 5!"
    RETURN
SOUND_promotemode:
    PRINT "SOUND 6!"
    RETURN
SOUND_cameramode:
    PRINT "SOUND 7!"
    RETURN
SOUND_blue_UP:
    PRINT "SOUND 26!"
    RETURN
SOUND_blue_DOWN:
    PRINT "SOUND 27!"
    RETURN
SOUND_white_UP:
    PRINT "SOUND 28!"
    RETURN
SOUND_white_DOWN:
    PRINT "SOUND 29!"
    RETURN


SOUND_BGM1:
    PRINT "AUTO 31!"
    RETURN
SOUND_BGM2:
    PRINT "AUTO 32!"
    RETURN
SOUND_BGM3:
    PRINT "AUTO 33!"
    RETURN
SOUND_BGM4:
    PRINT "AUTO 34!"
    RETURN
SOUND_BGM5:
    PRINT "AUTO 35!"
    RETURN
SOUND_BGM6:
    PRINT "AUTO 36!"
    RETURN
SOUND_BGM7:
    PRINT "AUTO 37!"
    RETURN
SOUND_BGM8:
    PRINT "AUTO 38!"
    RETURN
SOUND_BGM9:
    PRINT "AUTO 39!"
    RETURN
SOUND_BGM10:
    PRINT "AUTO 40!"
    RETURN
SOUND_BGM11:
    PRINT "AUTO 41!"
    RETURN
SOUND_BGM12:
    PRINT "AUTO 42!"
    RETURN

SOUND_ALL_OFF_MSG:
    PRINT "SOUND 20!"
    DELAY 1500
    GOSUB SOUND_VOLUME_0
    RETURN

SOUND_ALL_ON_MSG:
    GOSUB SOUND_VOLUME_30
    PRINT "SOUND 21!"

    RETURN

SOUND_ON_OK_MSG:
    PRINT "SOUND 22!"
    RETURN

SOUND_scissors:
    PRINT "SOUND 23!"
    RETURN
SOUND_rock:
    PRINT "SOUND 24 !"
    RETURN
SOUND_paper:
    PRINT "SOUND 25 !"
    RETURN
SOUND_Walk_Move:
    PRINT "SOUND 45 !"
    RETURN
SOUND_Walk_Ready:
    PRINT "PLAYNUM 43 !"
    RETURN
SOUND_walk:
    PRINT "SOUND 43 !"
    RETURN
SOUND_REPLAY:
    PRINT "!"
    RETURN

SOUND_VOLUME_50:
    PRINT "VOLUME 50 !"
    RETURN

SOUND_VOLUME_40:
    PRINT "VOLUME 40 !"
    RETURN

SOUND_VOLUME_30:
    PRINT "VOLUME 30 !"
    RETURN
SOUND_VOLUME_20:
    PRINT "VOLUME 20 !"
    RETURN
SOUND_VOLUME_10:
    PRINT "VOLUME 10 !"
    RETURN

SOUND_VOLUME_0:
    PRINT "VOLUME 0 !"
    RETURN



SOUND_STOP:
    PRINT "STOP !"
    RETURN

SOUND_UP:
    PRINT "UP 5 !"
    RETURN

SOUND_DOWN:
    PRINT "DOWN 5 !"
    RETURN


    '************************************************
    '******* buzzer ***********************
    '************************************************


start_buzzer:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
end_buzzer:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
entertainment_sound:
    TEMPO 220
    MUSIC "O28B>4D8C4E<8B>4D<8B>4G<8E>4C"
    RETURN
    '************************************************
game_sound:
    TEMPO 210
    MUSIC "O23C5G3#F5G3A5G"
    RETURN
    '************************************************
fight_sound:
    TEMPO 210
    MUSIC "O15A>C<A>3D"
    RETURN
    '************************************************
warning_sound:
    TEMPO 180
    MUSIC "O13A"
    DELAY 300

    RETURN
    '************************************************
buzzer_sound:
    TEMPO 180
    MUSIC "A"
    DELAY 300

    RETURN
    '************************************************
siren_sound:
    TEMPO 180
    MUSIC "O22FC"
    DELAY 10
    RETURN
    '************************************************

footballgame_sound:
    TEMPO 180
    MUSIC "O28A#GABA"
    RETURN
    '************************************************

steeplechase_racesmode_sound:
    TEMPO 200
    MUSIC "O37C<C#BCA"
    RETURN
    '************************************************
    '************************************************
    '************************************************

back_standup:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON				

    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode1


    SPEED 15
    MOVE G6A,100, 150, 170,  40, 100
    MOVE G6D,100, 150, 170,  40, 100
    MOVE G6B, 150, 150,  45
    MOVE G6C, 150, 150,  45
    WAIT

    SPEED 15
    MOVE G6A,  100, 155,  110, 120, 100
    MOVE G6D,  100, 155,  110, 120, 100
    MOVE G6B, 190, 80,  15
    MOVE G6C, 190, 80,  15
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 15	
    MOVE G6A,  100, 165,  25, 162, 100
    MOVE G6D,  100, 165,  25, 162, 100
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    DELAY 50
    SPEED 12	
    MOVE G6A,  100, 150,  25, 162, 100
    MOVE G6D,  100, 150,  25, 162, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT


    SPEED 8
    MOVE G6A,  100, 138,  25, 155, 100
    MOVE G6D,  100, 138,  25, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    DELAY 100
    SPEED 10
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    fall_check = 1
    RETURN

    '**********************************************
front_standup:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode1


    SPEED 15
    MOVE G6A,100, 15,  70, 140, 100,
    MOVE G6D,100, 15,  70, 140, 100,
    MOVE G6B,20,  140,  15
    MOVE G6C,20,  140,  15
    WAIT

    SPEED 12
    MOVE G6A,100, 136,  35, 80, 100,
    MOVE G6D,100, 136,  35, 80, 100,
    MOVE G6B,20,  30,  80
    MOVE G6C,20,  30,  80
    WAIT

    SPEED 12
    MOVE G6A,100, 165,  70, 30, 100,
    MOVE G6D,100, 165,  70, 30, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    SPEED 10
    MOVE G6A,100, 165,  45, 90, 100,
    MOVE G6D,100, 165,  45, 90, 100,
    MOVE G6B,130,  50,  60
    MOVE G6C,130,  50,  60
    WAIT

    SPEED 10
    GOSUB standard_pose
    fall_check = 1
    RETURN

    '******************************************
    '************************************************
    '****** walk ********************************
    '************************************************

front_walk_50:
    GOSUB SOUND_Walk_Ready
    walk_speed = 10'5
    LR_speed = 5'8'3
    LR_speed2 = 4'5'2
    fall_check = 0
    GOSUB Leg_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        '
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        SPEED 10'walk_speed
        '
        MOVE G6A, 90, 100, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT


        GOTO front_walk_50_1	
    ELSE
        walk_order = 0

        SPEED 4
        '
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 10'walk_speed
        '
        MOVE G6D, 90, 100, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO front_walk_50_2	

    ENDIF


    '*******************************


front_walk_50_1:

    SPEED walk_speed
    '
    MOVE G6A, 85,  44, 163, 113, 114
    MOVE G6D,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED LR_speed
    'GOSUB Leg_motor_mode3
    '
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,85, 93, 155,  71, 112
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF


    SPEED walk_speed
    'GOSUB Leg_motor_mode2
    '
    MOVE G6A,111,  77, 146,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, front_walk_50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        'GOSUB Leg_motor_mode3
        SPEED 5

        '
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	


        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        '
        GOTO RX_EXIT
    ENDIF
    '**********
FB_tilt_check:
    '  IF tilt_check_failure = 0 THEN
    '        RETURN
    '    ENDIF
    FOR i = 0 TO COUNT_MAX
        A = AD(FB_tilt_AD_port)	'
        IF A > 250 OR A < 5 THEN RETURN
        IF A > MIN AND A < MAX THEN RETURN
        DELAY tilt_time_check
    NEXT i

    IF A < MIN THEN GOSUB tilt_front
    IF A > MAX THEN GOSUB tilt_back

    GOSUB GOSUB_RX_EXIT

    RETURN
    '**************************************************
tilt_front:
    A = AD(FB_tilt_AD_port)
    'IF A < MIN THEN GOSUB front_standup
    IF A < MIN THEN  GOSUB back_standup
    RETURN

tilt_back:
    A = AD(FB_tilt_AD_port)
    'IF A > MAX THEN GOSUB back_standup
    IF A > MAX THEN GOSUB front_standup
    RETURN
    '**************************************************
LR_tilt_check:
    '  IF tilt_check_failure = 0 THEN
    '        RETURN
    '    ENDIF
    FOR i = 0 TO COUNT_MAX
        B = AD(LR_tilt_AD_port)	'
        IF B > 250 OR B < 5 THEN RETURN
        IF B > MIN AND B < MAX THEN RETURN
        DELAY tilt_time_check
    NEXT i

    IF B < MIN OR B > MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        GOSUB standard_pose	
        RETURN

    ENDIF
    RETURN

front_walk_50_2:


    SPEED walk_speed
    '
    MOVE G6D,85,  44, 163, 113, 114
    MOVE G6A,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED LR_speed
    'GOSUB Leg_motor_mode3
    '
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 85, 93, 155,  71, 112
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    'GOSUB Leg_motor_mode2
    '
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,111,  77, 146,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, front_walk_50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        'GOSUB Leg_motor_mode3
        SPEED 5

        '
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        '
        GOTO RX_EXIT
    ENDIF


    GOTO front_walk_50_1
    '************************************************
    '************************************************
    '************************************************
back_walk_50:
    GOSUB SOUND_Walk_Ready
    walk_speed = 12'6
    LR_speed = 6'3
    LR_speed2 = 4'2
    fall_check = 0
    GOSUB Leg_motor_mode3



    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        '
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        '
        MOVE G6A, 90, 95, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT

        GOTO back_walk_50_1	
    ELSE
        walk_order = 0

        SPEED 4
        '
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        '
        MOVE G6D, 90, 95, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT

        GOTO back_walk_50_2

    ENDIF


back_walk_50_1:
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    '
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED LR_speed2
    GOSUB Leg_motor_mode3
    '
    MOVE G6D,90,  46, 163, 110, 114
    MOVE G6A,110,  77, 147,  90,  94
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    '
    MOVE G6A,112,  77, 147,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, back_walk_50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        '
        GOTO RX_EXIT
    ENDIF
    '**********

back_walk_50_2:
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    '
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED LR_speed2
    GOSUB Leg_motor_mode3
    '
    MOVE G6A, 90,  46, 163, 110, 114
    MOVE G6D,110,  77, 147,  90,  94
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    '
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,112,  76, 147,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, back_walk_50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        '
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        '
        GOTO RX_EXIT
    ENDIF  	

    GOTO back_walk_50_1
    '**********************************************
    '******************************************
front_run_50:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON
    GOSUB Leg_motor_mode4

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  78, 145,  93, 98
        WAIT

        GOTO front_run_50_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  78, 145,  93, 98
        WAIT

        GOTO front_run_50_4
    ENDIF


    '**********************

front_run_50_1:
    MOVE G6A,95,  95, 100, 120, 104
    MOVE G6D,104,  78, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


front_run_50_2:
    MOVE G6A,95,  75, 122, 120, 104
    MOVE G6D,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

front_run_50_3:
    MOVE G6A,103,  70, 145, 103,  100
    MOVE G6D, 95, 88, 160,  68, 102
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_run_50_4
    IF A <> A_old THEN  GOTO front_run_50_stop

    '*********************************

front_run_50_4:
    MOVE G6D,95,  95, 100, 120, 104
    MOVE G6A,104,  78, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


front_run_50_5:
    MOVE G6D,95,  75, 122, 120, 104
    MOVE G6A,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

front_run_50_6:
    MOVE G6D,103,  70, 145, 103,  100
    MOVE G6A, 95, 88, 160,  68, 102
    WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_run_50_1
    IF A <> A_old THEN  GOTO front_run_50_stop


    GOTO front_run_50_1


front_run_50_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilizing_pose
    SPEED 5
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
back_run_40:
    fall_check = 0
    SPEED 10
    GOSUB SOUND_Walk_Ready
    HIGHSPEED SETON
    GOSUB Leg_motor_mode5

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,88,  73, 145,  96, 102
        MOVE G6D,104,  73, 145,  96, 100
        WAIT

        GOTO back_run_40_1
    ELSE
        walk_order = 0
        MOVE G6D,88,  73, 145,  96, 102
        MOVE G6A,104,  73, 145,  96, 100
        WAIT


        GOTO back_run_40_4
    ENDIF


    '**********************

back_run_40_1:
    'SPEED 10
    MOVE G6A,92,  92, 100, 115, 104
    MOVE G6D,103,  74, 145,  96,  100
    MOVE G6B, 120
    MOVE G6C,80
    'WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

back_run_40_2:
    'SPEED 10
    MOVE G6A,95,  100, 122, 95, 104
    MOVE G6D,103,  70, 145,  102,  100
    'WAIT

back_run_40_3:
    'SPEED 10
    MOVE G6A,103,  90, 145, 80, 100
    MOVE G6D,92,  64, 145,  108,  102
    'WAIT
    GOSUB SOUND_REPLAY



    ERX 4800,A, back_run_40_4
    IF A <> A_old THEN  GOTO back_run_40_stop
    '*********************************

back_run_40_4:
    'SPEED 10
    MOVE G6D,92,  92, 100, 115, 104
    MOVE G6A,103,  74, 145,  96,  100
    MOVE G6C, 120
    MOVE G6B,80
    'WAIT

    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

back_run_40_5:

    MOVE G6D,95,  100, 122, 95, 104
    MOVE G6A,103,  70, 145,  102,  100


back_run_40_6:

    MOVE G6D,103,  90, 145, 80, 100
    MOVE G6A,92,  64, 145,  108,  102
    ' WAIT
    GOSUB SOUND_REPLAY

    ERX 4800,A, back_run_40_1
    IF A <> A_old THEN  GOTO back_run_40_stop

    GOTO  back_run_40_1 	

back_run_40_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilizing_pose
    SPEED 5
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
stabilizing_stop:
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB stabilizing_pose
    SPEED 15
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    RETURN

    '******************************************
    '**********************************************

    '******************************************
front_short_step:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO front_short_step_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO front_short_step_4
    ENDIF


    '**********************

front_short_step_1:
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


front_short_step_2:
    MOVE G6A,95,  85, 130, 103, 104
    MOVE G6D,104,  79, 146,  89,  100
    WAIT

front_short_step_3:
    MOVE G6A,103,   85, 130, 103,  100
    MOVE G6D, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_step_4
    IF A <> A_old THEN  GOTO front_short_step_stop

    '*********************************

front_short_step_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


front_short_step_5:
    MOVE G6D,95,  85, 130, 103, 104
    MOVE G6A,104,  79, 146,  89,  100
    WAIT

front_short_step_6:
    MOVE G6D,103,   85, 130, 103,  100
    MOVE G6A, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_step_1
    IF A <> A_old THEN  GOTO front_short_step_stop


    GOTO front_short_step_1


front_short_step_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilizing_pose
    SPEED 10
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
back_short_step:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO back_short_step_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO back_short_step_4
    ENDIF


    '**********************

back_short_step_1:
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT


back_short_step_2:
    MOVE G6A,95,  90, 135, 90, 104
    MOVE G6D,104,  77, 146,  91,  100
    WAIT

back_short_step_3:
    MOVE G6A, 103,  79, 146,  89, 100
    MOVE G6D,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_step_4
    IF A <> A_old THEN  GOTO back_short_step_stop

    '*********************************

back_short_step_4:
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT


back_short_step_5:
    MOVE G6A,104,  77, 146,  91,  100
    MOVE G6D,95,  90, 135, 90, 104
    WAIT

back_short_step_6:
    MOVE G6D, 103,  79, 146,  89, 100
    MOVE G6A,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_step_1
    IF A <> A_old THEN  GOTO back_short_step_stop


    GOTO back_short_step_1


back_short_step_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilizing_pose
    SPEED 10
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '**********************************************

front_run_30: '
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON

    IF walk_order = 0 THEN
        MOVE G6A,100,  80, 119, 118, 103
        MOVE G6D,102,  75, 149,  93,  100
        MOVE G6B, 80,  30,  80
        MOVE G6C,120,  30,  80

        walk_order = 1
        GOTO front_run_30_2
    ELSE
        MOVE G6D,100,  80, 119, 118, 103
        MOVE G6A,102,  75, 149,  93,  100
        MOVE G6C, 80,  30,  80
        MOVE G6B,120,  30,  80

        walk_order = 0
        GOTO front_run_30_4

    ENDIF



    '********************************************
front_run_30_1:

    ':
    MOVE G6A,100,  80, 119, 118, 103
    MOVE G6D,102,  75, 147,  93,  100
    MOVE G6B, 80,  30,  80
    MOVE G6C,120,  30,  80
    GOSUB SOUND_REPLAY

    ERX 4800, A, front_run_30_2
    GOSUB standard_pose
    HIGHSPEED SETOFF
    GOTO RX_EXIT

front_run_30_2:

    ':
    MOVE G6A,102,  74, 140, 106,  100
    MOVE G6D, 95, 105, 124,  93, 103
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80

    ' GOSUB FB_tilt_check
    '    IF fall_check = 1 THEN
    '        fall_check = 0
    '        GOTO MAIN
    '    ENDIF

front_run_30_3:
    ':
    MOVE G6D,100,  80, 119, 118, 103
    MOVE G6A,102,  75, 147,  93,  100
    MOVE G6C, 80,  30,  80
    MOVE G6B,120,  30,  80
    GOSUB SOUND_REPLAY



    ERX 4800, A, front_run_30_4
    GOSUB standard_pose
    HIGHSPEED SETOFF
    GOTO RX_EXIT

front_run_30_4:
    ':
    MOVE G6D,102,  74, 140, 106,  100
    MOVE G6A, 95, 105, 124,  93, 103
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80

    ' GOSUB FB_tilt_check
    '    IF fall_check = 1 THEN
    '        fall_check = 0
    '        GOTO MAIN
    '    ENDIF

    '************************************************


    GOTO front_run_30_1


    GOTO RX_EXIT

    '*********************************************
    '******************************************
chach_run:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 15
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO chach_run_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO chach_run_4
    ENDIF


    '**********************

chach_run_1:
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6D,104,  77, 145,  87,  102
    WAIT
    DELAY 5

chach_run_2:
    MOVE G6D,104,  79, 145,  82,  100
    MOVE G6A,95,  85, 130, 95, 104
    WAIT
    DELAY 5
chach_run_3:
    MOVE G6A,103,   85, 130, 95,  100
    MOVE G6D, 97,  79, 145,  82, 102
    WAIT
    DELAY 5
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chach_run_4
    IF A <> A_old THEN  GOTO chach_run_stop

    '*********************************

chach_run_4:
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6A,104,  77, 145,  87,  102
    WAIT


chach_run_5:
    MOVE G6D,95,  85, 130, 95, 104
    MOVE G6A,104,  79, 145,  82,  100
    WAIT

chach_run_6:
    MOVE G6D,103,   85, 130, 95,  100
    MOVE G6A, 97,  79, 145,  82, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chach_run_1
    IF A <> A_old THEN  GOTO chach_run_stop


    GOTO chach_run_1


chach_run_stop:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
chach_back_walk:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO chach_back_walk_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO chach_back_walk_4
    ENDIF


    '**********************

chach_back_walk_1:
    MOVE G6D,104,  77, 146,  83,  102
    MOVE G6A,95,  95, 120, 92, 104
    WAIT


chach_back_walk_2:
    MOVE G6A,95,  90, 135, 82, 104
    MOVE G6D,104,  77, 146,  83,  100
    WAIT

chach_back_walk_3:
    MOVE G6A, 103,  79, 146,  81, 100
    MOVE G6D,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chach_back_walk_4
    IF A <> A_old THEN  GOTO chach_back_walk_stop

    '*********************************

chach_back_walk_4:
    MOVE G6D,95,  95, 120, 92, 104
    MOVE G6A,104,  77, 146,  83,  102
    WAIT


chach_back_walk_5:
    MOVE G6A,104,  77, 146,  83,  100
    MOVE G6D,95,  90, 135, 82, 104
    WAIT

chach_back_walk_6:
    MOVE G6D, 103,  79, 146,  81, 100
    MOVE G6A,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB FB_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chach_back_walk_1
    IF A <> A_old THEN  GOTO chach_back_walk_stop


    GOTO chach_back_walk_1


chach_back_walk_stop:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400


    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '*********************************************	
front_sit_walk:
    GOSUB All_motor_mode3
    SPEED 9

front_sit_walk_1:

    MOVE G6A,114, 143,  28, 142,  96, 100
    MOVE G6D, 87, 135,  28, 155, 110, 100
    WAIT


    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, front_sit_walk_2
    SPEED 6
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

front_sit_walk_2:
    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, front_sit_walk_1
    SPEED 6
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO front_sit_walk_1
    '*****************************
back_sit_walk:
    GOSUB All_motor_mode3
    SPEED 8

back_sit_walk_1:

    MOVE G6D,113, 140,  28, 142,  96, 100
    MOVE G6A, 87, 140,  28, 140, 110, 100
    WAIT

    MOVE G6A,98, 155,  28, 125, 102, 100
    MOVE G6D,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, back_sit_walk_2
    SPEED 6
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

back_sit_walk_2:
    MOVE G6A,113, 140,  28, 142,  96, 100
    MOVE G6D, 87, 140,  28, 140, 110, 100
    WAIT


    MOVE G6D,98, 155,  28, 125, 102, 100
    MOVE G6A,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, back_sit_walk_1
    SPEED 6
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO back_sit_walk_1
    '*****************************		

sit_right_walk:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,110, 145,  28, 140, 100, 100
    MOVE G6D, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6A, 90, 145,  28, 140, 110, 100
    MOVE G6D, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6A, 80, 135,  45, 135, 105, 100
    MOVE G6D,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6A, 90, 145,  28, 140, 100, 100
    MOVE G6D,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '*****************************	
sit_left_walk:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6D,110, 145,  28, 140, 100, 100
    MOVE G6A, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6D, 90, 145,  28, 140, 110, 100
    MOVE G6A, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6D, 80, 135,  45, 135, 105, 100
    MOVE G6A,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6D, 90, 145,  28, 140, 100, 100
    MOVE G6A,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  thing_chach_pose = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

left_side_up:

    SPEED 15
    MOVE G6B,,100
    WAIT

    GOSUB standard_pose
    RETURN
    '**********************************************
right_side_up:
    SPEED 15
    MOVE G6C,,100
    WAIT

    GOSUB standard_pose
    RETURN
    '**********************************************




    '******************************************


    '**********************************************

    '***************************************
CODE_EVENT_ALL_STOP:
    PRINT "EVENT_ALL_STOP !"
    PRINT "STOP !"
    SPEED 8
    MOVE G6B,, 40, 90, , , 100
    MOVE G6C,, 40, 90
    WAIT
    SPEED 4
    GOSUB standard_pose
    RETURN

    '**********************************************
    '**********************************************
    '**********************************************

bow_1:
    GOSUB SOUND_HELLO_miniROBOT_ROBONOVA_2
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  70, 125, 150, 100
    MOVE G6D,100,  70, 125, 150, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    DELAY 1000
    SPEED 6
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '************************************************
bow_2:
    GOSUB All_motor_mode3
    SPEED 4
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 8
    MOVE G6D, 90, 95, 115, 105, 112
    MOVE G6A,113,  76, 146,  93,  94
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,112,  86, 120, 120,  94
    MOVE G6D,90, 100, 155,  71, 112
    MOVE G6B,140,  30,  80
    MOVE G6C,70,  30,  80
    WAIT


    SPEED 10
    MOVE G6A,108,  85, 110, 140,  94
    MOVE G6D,85, 97, 145,  91, 112
    MOVE G6B,150,  20,  40
    MOVE G6C,60,  30,  80
    WAIT

    DELAY 1000
    '*******************
    GOSUB leg_motor_mode2
    SPEED 6
    MOVE G6D, 90, 95, 115, 105, 110
    MOVE G6A,114,  76, 146,  93,  96
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '************************************************


bow_3:
    GOSUB All_motor_mode3

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    '
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000
    '
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOSUB All_motor_Reset


    RETURN

    '***************************************

comeon_action:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6B,100,  40,  80
    MOVE G6C,180,  30,  80
    WAIT


    SPEED 15
    FOR i = 1 TO 3
        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  80	
        WAIT

        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  20	
        WAIT
    NEXT i

    SPEED 10
    MOVE G6B,80,  40,  90
    MOVE G6C,185,  25,  90	
    WAIT
    DELAY 400

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
hug_action:
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 15
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 6
    MOVE G6A, 90,  92, 115, 109, 125, 100
    MOVE G6D,103,  76, 141,  98,  82, 100
    MOVE G6B,160,  50,  80
    MOVE G6C,188,  50,  80
    WAIT	

    SPEED 5
    FOR i = 1 TO 6

        MOVE G6B,160,  50,  50
        MOVE G6C,188,  50,  50
        WAIT

        MOVE G6B,160,  55,  80
        MOVE G6C,188,  55,  80
        WAIT
    NEXT i


    SPEED 10
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  40,  80
    MOVE G6C,160,  60,  80
    WAIT

    SPEED 10
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  40,  80
    MOVE G6C,140,  60,  90
    WAIT

    SPEED 6
    MOVE G6A, 95,  75, 146,  93, 105
    MOVE G6D,109,  76, 146,  93,  92
    WAIT

    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN

front_LR_punch:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A, 92, 100, 110, 100, 107
    MOVE G6D, 92, 100, 110, 100, 107
    MOVE G6B,185, 130,  15
    MOVE G6C,185, 130,  15
    WAIT

    SPEED 10
    MOVE G6B,185, 50,  15
    MOVE G6C,185, 50,  15
    WAIT

    SPEED 13
    FOR I = 0 TO 1
        MOVE G6B,185,  10, 80
        MOVE G6C,185, 80,  10
        WAIT
        DELAY 200
        MOVE G6B,185, 80,  10
        MOVE G6C,185,  10, 80
        WAIT
        DELAY 200

    NEXT I

    MOVE G6A, 92, 100, 113, 100, 107
    MOVE G6D, 92, 100, 113, 100, 107
    MOVE G6B,185, 130,  10
    MOVE G6C,185, 130,  10
    WAIT

    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 102, 100, 113, 100, 98
    MOVE G6D, 102, 100, 113, 100, 98
    MOVE G6B,100,  80,  60
    MOVE G6C,100,  80,  60
    WAIT

    GOSUB standard_pose

    GOTO RX_EXIT
    '***************************************
 '************************************************
right_walk_20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6D, 93,  90, 120, 105, 104, 100
    MOVE G6A,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB standard_pose

    GOTO RX_EXIT
    '**********************************************

left_walk_20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6A, 93,  90, 120, 105, 104, 100
    MOVE G6D,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB standard_pose
    GOTO RX_EXIT

    '**********************************************

right_walk_70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 146,  93, 107, 100
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15
    GOSUB standard_pose

    GOTO RX_EXIT
    '*************

left_walk_70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 146,  93, 107, 100	
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15	
    GOSUB standard_pose

    GOTO RX_EXIT
    '************************************************

chack_right_walk_20:


    SPEED 12
    MOVE G6D, 93,  90, 120, 97, 104, 100
    MOVE G6A,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 85, 100, 100
    MOVE G6A,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  85, 100, 100
    MOVE G6A,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '**********************************************

chack_left_walk_20:


    SPEED 12
    MOVE G6A, 93,  90, 120, 97, 104, 100
    MOVE G6D,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 85, 100, 100
    MOVE G6D,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  85, 100, 100
    MOVE G6D,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************

chack_right_walk_70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 92, 110, 100
    MOVE G6A,100,  76, 146,  85, 107, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 85, 100, 100
    MOVE G6A,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  85, 100, 100
    MOVE G6A,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '*************

chack_left_walk_70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 97, 110, 100	
    MOVE G6D,100,  76, 146,  85, 107, 100	
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 85, 100, 100
    MOVE G6D,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  85, 100, 100
    MOVE G6D,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15	
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '************************************************
slow_left_walk_50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 128,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 120,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6D, 85,  80, 140, 95, 110, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 2
    GOSUB standard_pose
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************
    '************************************************
slow_right_walk_50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6D, 85,  80, 140, 95, 114, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 128,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 120,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6A, 85,  80, 140, 95, 110, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 2
    GOSUB standard_pose
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************

    '**********************************************
left_turn_10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOTO RX_EXIT
    '**********************************************
right_turn_10:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose

    GOTO RX_EXIT
    '**********************************************
    '**********************************************
left_turn_20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
right_turn_20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
left_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    MOVE G6B,115
    MOVE G6C,85
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
right_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    MOVE G6C,115
    MOVE G6B,85
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
left_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT

    '**********************************************
right_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100

    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
front_lift_attack:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,133, 15,  70
    MOVE G6C,133, 15,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  77, 146,  73, 100
    MOVE G6D,98,  77, 146,  73, 100
    MOVE G6B,185, 15,  70
    MOVE G6C,185, 15,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    GOSUB standard_pose

    GOTO RX_EXIT
    '*******************************************
back_lift_attack:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  79, 146,  83, 100
    MOVE G6D,98,  79, 146,  83, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,80, 20,  70
    MOVE G6C,80, 20,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  68, 146,  118, 100
    MOVE G6D,98,  68, 146,  118, 100
    MOVE G6B,15, 10,  70
    MOVE G6C,15, 10,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  68, 146,  103, 100
    MOVE G6D,98,  68, 146,  103, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 8
    GOSUB standard_pose

    GOTO RX_EXIT
    ''**********************************************
left_front_attack:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT

    SPEED 10
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A,95,  84, 105, 126,  105,
    MOVE G6D, 86, 110, 136,  69, 114,
    MOVE G6B, 189,  30,  80
    MOVE G6C,  50,  40,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 12
    MOVE G6A,93,  80, 130, 110,  105,
    MOVE G6D, 93, 80, 130,  110, 105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A,101,  80, 130, 110,  98,
    MOVE G6D, 101, 80, 130,  110, 98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
right_front_attack:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT

    SPEED 10
    MOVE G6A,112,  76, 146,  93, 98
    MOVE G6D, 85,  80, 140, 95, 114
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A, 86, 110, 136,  69, 114,
    MOVE G6D,95,  84, 105, 126,  105,
    MOVE G6B,  50,  40,  80
    MOVE G6C, 189,  30,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 93, 80, 130,  110, 105,
    MOVE G6D,93,  80, 130, 110,  105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A, 101, 80, 130,  110, 98,
    MOVE G6D,101,  80, 130, 110,  98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT
    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
left_side_attack:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6D,110,  76, 146,  93,  92
    MOVE G6A, 88,  85, 130,  100, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6D, 63, 76,  160, 85, 130	
    MOVE G6A, 88, 125,  70, 120, 115
    MOVE G6C,100,  70,  100
    MOVE G6B,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
right_side_attack:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6A,110,  76, 146,  93,  92
    MOVE G6D, 88,  85, 130,  100, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6A, 63, 76,  160, 85, 130	
    MOVE G6D, 88, 125,  70, 120, 115
    MOVE G6B,100,  70,  100
    MOVE G6C,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
    '**********************************************
left_side_back_attack:

    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,15,  40,  80
    MOVE G6C,115,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    GOSUB standard_pose

    GOTO RX_EXIT

    '**********************************************
right_side_back_attack:


    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,115,  40,  80
    MOVE G6C,15,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 12
    GOSUB standard_pose
    GOTO RX_EXIT





    '***************************************
    '**********************************************
    '**********************************************

motor_ONOFF_LED:
    IF motor_ONOFF = 1  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    RETURN
    '**********************************************
LOW_Voltage:

    B = AD(6)

    IF B < low_volt THEN
        GOSUB warning_sound

    ENDIF

    RETURN
    '**********************************************
    '******************************************	
MAIN: '


    'GOSUB LOW_Voltage
    GOSUB FB_tilt_check
    GOSUB LR_tilt_check


    GOSUB motor_ONOFF_LED

    ERX 4800,A,MAIN
    A_old = A

    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32

    GOTO MAIN	
    '*******************************************
    '		MAIN
    '*******************************************
    '*******************************************

KEY1:

    GOSUB bow_1


    GOTO RX_EXIT
    '*******************************************
KEY2:

    GOSUB bow_2


    GOTO RX_EXIT
    '*******************************************
KEY3:

    GOSUB comeon_action

    GOTO RX_EXIT
    '*******************************************
KEY4:



    GOTO RX_EXIT
    '*******************************************
KEY5:



    GOTO RX_EXIT
    '*******************************************
KEY6:



    GOTO RX_EXIT
    '*******************************************
KEY7:





    GOTO RX_EXIT
    '*******************************************
KEY8:

    GOSUB hug_action



    GOTO RX_EXIT
    '*******************************************
KEY9:





    GOTO RX_EXIT
    '*******************************************
KEY10: '0


    GOTO front_LR_punch


    GOTO RX_EXIT
    '*******************************************
KEY11: ' °„

    GOTO front_run_50



    GOTO RX_EXIT
    '*******************************************
KEY12: ' °Â


    GOTO back_run_40





GOTO RX_EXIT
'*******************************************
KEY13: '¢∫


    GOTO right_walk_70


    GOTO RX_EXIT
    '*******************************************
KEY14: ' ¢∏


    GOTO left_walk_70


    GOTO RX_EXIT
    '*******************************************
KEY15: ' A


    GOTO left_front_attack


    GOTO RX_EXIT
    '*******************************************
KEY16: ' POWER
    PRINT "OPEN MRSOUND.mrs !"
    GOSUB MOTOR_OFF
    GOSUB GOSUB_RX_EXIT

KEY16_1:

    GOSUB motor_ONOFF_LED	

    ERX 4800,A,KEY16_1
    GOSUB SOUND_STOP
    '****    ****
    IF motor_ONOFF = 1 AND A <> 16 THEN
        GOSUB MOTOR_FAST_ON
        GOSUB All_motor_mode3
    ENDIF
    IF A = 16 THEN		'
        IF motor_ONOFF = 1 THEN
            GOSUB MOTOR_ON
        ELSE
            GOSUB MOTOR_OFF
        ENDIF
    ELSEIF A = 27 OR A = 1 THEN	'D :dancemode
        Action_mode  = 0
        GOSUB SOUND_dancemode
        SPEED 10
        MOVE G6B,, 50, 90
        MOVE G6C,, 50, 90
        WAIT

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,100, 70, 30, , , 100
        MOVE G6C,100, 70, 30
        WAIT
        'GOSUB entertainment_sound
    ELSEIF A = 32 OR A = 2  THEN	'F :fightmode
        Action_mode  = 1
        GOSUB SOUND_∞›≈ımode
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 8
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,188, 15, 20, , , 100
        MOVE G6C,188, 20, 90
        WAIT
        'GOSUB fight_sound
    ELSEIF A = 23 OR A = 3  THEN	'G :gamemode
        Action_mode  = 2
        GOSUB SOUND_gamemode
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,170, 20, 80, , , 100
        MOVE G6C,140, 20, 80
        WAIT
        'GOSUB game_sound
    ELSEIF A = 20 OR A = 4  THEN	'B :footballmode
        Action_mode  = 3
        GOSUB SOUND_footballmode
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,93,  76, 145,  93, 105, 100
        MOVE G6D,105,  76, 145,  93, 96, 100
        MOVE G6B,70, 35, 80, , , 100
        MOVE G6C,140, 35, 80
        WAIT
        'GOSUB footballgame_sound
    ELSEIF A = 18 OR A = 5  THEN	'E :steeplechase_racesmode
        Action_mode  = 4
        GOSUB SOUND_steeplechase_racesmode
        SPEED 10
        MOVE G6B,, 60, 90
        MOVE G6C,, 60, 90
        WAIT     	

        SPEED 6
        MOVE G6A,100,  71, 145,  113, 100, 100
        MOVE G6D,100,  71, 145,  113, 100, 100
        MOVE G6B,70, 25, 80, , , 100
        MOVE G6C,70, 25, 80
        WAIT
        'GOSUB steeplechase_racesmode_sound
    ELSEIF A = 17 OR A = 6  THEN ' C: cameramode
        Action_mode  = 5
        GOSUB SOUND_cameramode
        SPEED 10
        MOVE G6B,100, 60, 90
        MOVE G6C,100, 60, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,140, 30, 30, , , 80
        MOVE G6C,140, 30, 30
        WAIT
    ELSEIF A = 15 OR A = 7  THEN	'A : promotemode
        Action_mode  = 6
        GOSUB SOUND_promotemode
        SPEED 10
        MOVE G6B,, 55, 90
        MOVE G6C,, 55, 90
        WAIT     	

        SPEED 10
        MOVE G6A,100,  76, 145,  93, 100, 100
        MOVE G6D,100,  76, 145,  93, 100, 100
        MOVE G6B,160, 70, 90, , , 60
        MOVE G6C,180, 30, 20
        WAIT
        'GOSUB start_buzzer

    ELSEIF A = 26 THEN	'°· :
        GOSUB MOTOR_FAST_ON
        SPEED 5
        MOVE G6A,97,  76, 145,  93, 102, 100
        MOVE G6D,97,  76, 145,  93, 102, 100
        WAIT
        SPEED 8
        MOVE G6B,, 50, 90, , , 100
        MOVE G6C,, 50, 90
        WAIT
        GOSUB standard_pose
        'GOSUB start_buzzer

        GOSUB All_motor_Reset
        GOSUB SOUND_MODE_SELECT
        GOTO RX_EXIT


    ELSEIF A = 21 THEN 	'
        GOSUB SOUND_ALL_ON_MSG
    ELSEIF A = 31 THEN  '
        GOSUB SOUND_ALL_OFF_MSG
    ELSEIF A = 30 THEN  '
        GOSUB SOUND_BGM2
        GOSUB SOUND_UP
        GOSUB buzzer_sound
    ELSEIF A = 28 THEN  '
        GOSUB SOUND_BGM2
        GOSUB SOUND_DOWN		
        GOSUB buzzer_sound
    ELSE
        GOSUB buzzer_sound
    ENDIF

    GOSUB GOSUB_RX_EXIT

    GOTO KEY16_1

    GOTO RX_EXIT

    '*******************************************
KEY17: ' C

    GOTO left_side_back_attack

    GOTO RX_EXIT
    '*******************************************
KEY18: ' E

    GOTO left_walk_20

    GOTO RX_EXIT
    '*******************************************


KEY19: ' P2


    GOTO right_turn_60

    GOTO RX_EXIT
    '*******************************************
KEY20: ' B	


    GOTO right_front_attack



    GOTO RX_EXIT
    '*******************************************
KEY21: ' °‚


    GOTO front_lift_attack

    GOTO RX_EXIT
    '*******************************************
KEY22: ' *	


    GOTO left_turn_20



    GOTO RX_EXIT
    '*******************************************
KEY23: ' G

    GOTO right_walk_20


    GOTO RX_EXIT
    '*******************************************
KEY24: ' #


    GOTO right_turn_20


    GOTO RX_EXIT
    '*******************************************
KEY25: ' P1

    GOTO left_turn_60


    GOTO RX_EXIT
    '*******************************************
KEY26: ' °·
    GOSUB SOUND_STOP
    IF pose = 1 THEN GOTO RX_EXIT

    IF Action_mode  = 4 THEN
        IF thing_chach_pose = 0 THEN
            SPEED 5
            GOSUB standard_pose

        ELSE
            GOSUB Arm_motor_mode3
            SPEED 10
            MOVE G6B, , 60
            MOVE G6C, , 60
            WAIT	
            SPEED 8
            GOSUB standard_pose	
        ENDIF
        GOSUB All_motor_Reset
        GOTO RX_EXIT
    ENDIF

    S7 = MOTORIN(7)
    S8 = MOTORIN(8)
    S13 = MOTORIN(13)
    S14 = MOTORIN(14)

    IF S7 < 25 OR S8 < 40 THEN
        SPEED 4
        MOVE G6B,,  50,  100
        MOVE G6C,,  50,  100
        WAIT
    ELSEIF S13 < 25 OR S14 < 40 THEN
        SPEED 4
        MOVE G6B,,  50,  100
        MOVE G6C,,  50,  100
        WAIT	
    ENDIF

    SPEED 5
    GOSUB standard_pose	
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '*******************************************
KEY27: ' D

    GOTO right_side_back_attack


    GOTO RX_EXIT
    '*******************************************
KEY28: ' ¢∑


    GOTO left_side_attack


    GOTO RX_EXIT
    '*******************************************
KEY29: ' °‡


    GOTO RX_EXIT
    '*******************************************
KEY30: ' ¢π


    GOTO right_side_attack


    GOTO RX_EXIT
    '*******************************************
KEY31: ' °‰

    GOTO back_lift_attack


    GOTO RX_EXIT
    '*******************************************

KEY32: ' F


    GOTO back_short_step


    GOTO RX_EXIT
    '*******************************************


