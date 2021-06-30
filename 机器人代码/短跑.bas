'持续前进：按灰色上箭头
'停止：灰色下箭头
'持续后退：灰色下箭头
'停止：灰色上箭头
'左跨一步：蓝色左箭头
'右跨一步：蓝色右箭头
'左转：A键
'右转：B键





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
        GOSUB SOUND_拜捧mode
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
SOUND_拜捧mode:
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
    '**********************************************************

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
    '*****************************************************************
    '*****************************************************************
    '*****************************************************************
    '*****************************************************************
    '*****************************************************************
cbl:
    PTP SETON
    GOSUB All_motor_mode3


    SPEED 6


    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT

    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT

    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B, 189,  12,  62,  ,  ,
    MOVE G6C, 189,  12,  62,  ,  ,
    WAIT


    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B, 189,  12,  62,  ,  ,
    MOVE G6C, 189,  12,  62,  ,  ,
    WAIT
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B, 189,  12,  62,  ,  ,
    MOVE G6C, 189,  12,  62,  ,  ,
    WAIT
    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B, 189,  12,  62,  ,  ,
    MOVE G6C, 189,  12,  62,  ,  ,
    WAIT
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 189,  12,  59,  ,  ,
    MOVE G6C, 189,  12,  59,  ,  ,
    WAIT
    RETURN




ca:
    PTP SETON
    GOSUB All_motor_mode3
    FOR i = 1 TO 4
        SPEED 6
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 189,  12,  59,  ,  ,
        MOVE G6C, 189,  12,  59,  ,  ,
        WAIT
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 157,  12,  60,  ,  ,
        MOVE G6C, 157,  12,  60,  ,  ,
        WAIT
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 184,  48,  11,  ,  ,
        MOVE G6C, 189,  18,  39,  ,  ,
        WAIT

        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6C, 184,  48,  11,  ,  ,
        MOVE G6B, 189,  18,  39,  ,  ,
        WAIT



        MOVE G6C, 164,  48,  11,  ,  ,
        MOVE G6B, 169,  18,  39,  ,  ,
        WAIT


        MOVE G6B, 164,  48,  11,  ,  ,
        MOVE G6C, 169,  18,  39,  ,  ,
        WAIT



        MOVE G6A, 100, 126,  92,  93, 100,
        MOVE G6D, 100, 126,  92,  93, 100,
        WAIT


        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        WAIT
        MOVE G6A, 100, 126,  92,  93, 100,
        MOVE G6D, 100, 126,  92,  93, 100,
        WAIT


        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        WAIT

        MOVE G6A, 100, 126,  92,  93, 100,
        MOVE G6D, 100, 126,  92,  93, 100,
        WAIT


        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        WAIT

        MOVE G6A, 100, 126,  92,  93, 100,
        MOVE G6D, 100, 126,  92,  93, 100,
        WAIT


        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        WAIT


    NEXT i

    RETURN


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
front_short_steps:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98

        WAIT

        GOTO front_short_steps_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98

        WAIT

        GOTO front_short_steps_4
    ENDIF


    '**********************

front_short_steps_1:
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102

    WAIT


front_short_steps_2:
    MOVE G6A,95,  85, 130, 103, 104
    MOVE G6D,104,  79, 146,  89,  100
    WAIT

front_short_steps_3:
    MOVE G6A,103,   85, 130, 103,  100
    MOVE G6D, 95,  79, 146,  89, 102
    WAIT

    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_steps_4
    IF A <> A_old THEN  GOTO front_short_steps_stop

    '*********************************

front_short_steps_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102

    WAIT


front_short_steps_5:
    MOVE G6D,95,  85, 130, 103, 104
    MOVE G6A,104,  79, 146,  89,  100
    WAIT

front_short_steps_6:
    MOVE G6D,103,   85, 130, 103,  100
    MOVE G6A, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    '  GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_steps_1
    IF A <> A_old THEN  GOTO front_short_steps_stop


    GOTO front_short_steps_1


front_short_steps_stop:
    HIGHSPEED SETOFF
    SPEED 15
    SPEED 10


    DELAY 400
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
stabilization_pose:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0

    RETURN
    '******************************************
back_short_steps:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98

        WAIT

        GOTO back_short_steps_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98

        WAIT

        GOTO back_short_steps_4
    ENDIF


    '**********************

back_short_steps_1:
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6A,95,  95, 120, 100, 104

    WAIT


back_short_steps_2:
    MOVE G6A,95,  90, 135, 90, 104
    MOVE G6D,104,  77, 146,  91,  100
    WAIT

back_short_steps_3:
    MOVE G6A, 103,  79, 146,  89, 100
    MOVE G6D,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    ' GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_steps_4
    IF A <> A_old THEN  GOTO back_short_steps_stop

    '*********************************

back_short_steps_4:
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6D,95,  95, 120, 100, 104

    WAIT


back_short_steps_5:
    MOVE G6A,104,  77, 146,  91,  100
    MOVE G6D,95,  90, 135, 90, 104
    WAIT

back_short_steps_6:
    MOVE G6D, 103,  79, 146,  89, 100
    MOVE G6A,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    ' GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_steps_1
    IF A <> A_old THEN  GOTO back_short_steps_stop


    GOTO back_short_steps_1


back_short_steps_stop:
    HIGHSPEED SETOFF
    SPEED 15
    SPEED 10
    DELAY 400
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '*****************************************************************
    '*****************************************************************
    '*****************************************************************

right_side_70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 146,  93, 107, 100

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

    GOTO RX_EXIT
    '*************

left_side_70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 146,  93, 107, 100	

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


    GOTO RX_EXIT


chuibei1:
    GOSUB All_motor_mode3
    PTP SETON
    SPEED 6
    FOR i = 1 TO 4
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 175,  61,  81,  ,  ,
        MOVE G6C, 175,  61,  81,  ,  ,
        WAIT
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 184,  67,  40,  ,  ,
        MOVE G6C, 184,  67,  40,  ,  ,
        WAIT
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 189,  50,  41,  ,  ,
        MOVE G6C, 189,  50,  41,  ,  ,
        WAIT
    NEXT i
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 175,  61,  81,  ,  ,
    MOVE G6C ,175,  61,  81,  ,  ,
    WAIT
    RETURN



chuibei2:

    GOSUB All_motor_mode3
    PTP SETON
    SPEED 6
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 175,  61,  81,  ,  ,
    MOVE G6C, 175,  61,  81,  ,  ,
    WAIT
    FOR i = 1 TO 15
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 189,  32,  61,  ,  ,
        MOVE G6C, 179,  32,  61,  ,  ,
        WAIT
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 179,  32,  61,  ,  ,
        MOVE G6C, 189,  32,  61,  ,  ,
        WAIT
    NEXT i
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 175,  61,  81,  ,  ,
    MOVE G6C, 175,  61,  81,  ,  ,
    WAIT
    RETURN




chuibei3:
    GOSUB All_motor_mode3
    PTP SETON
    SPEED 6
    FOR i = 1 TO 4

        MOVE G6A, 100, 105,  87, 129, 100,
        MOVE G6D, 100, 105,  87, 129, 100,
        MOVE G6B, 175,  61,  81,  ,  ,
        MOVE G6C, 175,  61,  81,  ,  ,
        WAIT


        MOVE G6B, 175,  61,  81,  ,  ,
        MOVE G6C, 175,  61,  81,  ,  ,
        WAIT

        MOVE G6B, 184,  67,  40,  ,  ,
        MOVE G6C, 184,  67,  40,  ,  ,
        WAIT

        MOVE G6B, 189,  50,  41,  ,  ,
        MOVE G6C, 189,  50,  41,  ,  ,
        WAIT
    NEXT i

    MOVE G6B, 175,  61,  81,  ,  ,
    MOVE G6C ,175,  61,  81,  ,  ,
    WAIT
    RETURN

chuibei4:

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100

    GOSUB All_motor_mode3
    PTP SETON
    SPEED 6
    FOR i = 1 TO 4

        MOVE G6A,100, 143,  50, 142, 100, 100
        MOVE G6D,100, 143,  50, 142, 100, 100
        MOVE G6B, 140,  61,  81,  ,  ,
        MOVE G6C, 140,  61,  81,  ,  ,
        WAIT


        MOVE G6B, 170  61,  81,  ,  ,
        MOVE G6C, 170,  61,  81,  ,  ,
        WAIT

        MOVE G6B, 170,  67,  40,  ,  ,
        MOVE G6C, 170,  67,  40,  ,  ,
        WAIT

        MOVE G6B, 170,  50,  41,  ,  ,
        MOVE G6C, 170,  50,  41,  ,  ,
        WAIT
    NEXT i

    MOVE G6B, 170,  61,  81,  ,  ,
    MOVE G6C ,170,  61,  81,  ,  ,
    WAIT


    GOSUB standard_pose
    RETURN

    '*****************************************************************

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

    GOSUB cbl
   
    GOTO RX_EXIT

key2:
    GOSUB ca
 
    GOTO RX_EXIT
key3:
    GOSUB chuibei1
    GOSUB standard_pose
    GOTO RX_EXIT

KEY4:
    GOSUB chuibei2
    GOSUB standard_pose
    GOTO RX_EXIT
KEY5:
    GOSUB chuibei3
    GOSUB standard_pose
    GOTO RX_EXIT
KEY6:
    GOSUB chuibei4
    GOSUB standard_pose
    GOTO RX_EXIT
KEY7:

    GOTO RX_EXIT
KEY8:

    GOTO RX_EXIT
KEY9:

    GOTO RX_EXIT
KEY10:

    GOTO RX_EXIT
KEY11:

    GOTO RX_EXIT
KEY12:

    GOTO RX_EXIT
KEY13:
    GOSUB  right_side_70
    GOTO RX_EXIT
KEY14:
    GOSUB     left_side_70
    GOTO RX_EXIT
KEY15:
    GOSUB left_turn_20
    GOTO RX_EXIT
KEY16:

    GOTO RX_EXIT
KEY17:

    GOTO RX_EXIT
KEY18:

    GOTO RX_EXIT
KEY19:

    GOTO RX_EXIT
KEY20:
    GOSUB right_turn_20
    GOTO RX_EXIT
KEY21:
    GOSUB front_short_steps
    GOTO RX_EXIT
KEY22:

    GOTO RX_EXIT
KEY23:

    GOTO RX_EXIT
KEY24:

    GOTO RX_EXIT
KEY25:

    GOTO RX_EXIT
KEY26:

    GOTO RX_EXIT
KEY27:

    GOTO RX_EXIT
KEY28:

    GOTO RX_EXIT
KEY29:

    GOTO RX_EXIT
KEY30:

    GOTO RX_EXIT
KEY31:
    GOSUB back_short_steps
    GOTO RX_EXIT
KEY32:

    GOTO RX_EXIT