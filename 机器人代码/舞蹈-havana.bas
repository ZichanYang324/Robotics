'******** 机器人实验片头 ********

DIM I AS BYTE
DIM J AS BYTE
DIM pose AS BYTE
DIM Action_mode AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM walk_speed AS BYTE
DIM L_R_speed AS BYTE
DIM L_R_speed2 AS BYTE
DIM walk_order AS BYTE
DIM now_volt AS BYTE
DIM mirror_check AS BYTE
DIM motorONOFF AS BYTE
DIM zyroONOFF AS BYTE
DIM tilt_F_B AS INTEGER
DIM tilt_L_R AS INTEGER
DIM DELAY_TIME AS BYTE
DIM DELAY_TIME2 AS BYTE
DIM TEMP AS BYTE
DIM grip_pose AS BYTE
DIM tilt_CNT AS BYTE

DIM S6 AS BYTE
DIM S7 AS BYTE
DIM S8 AS BYTE

DIM S12 AS BYTE
DIM S13 AS BYTE
DIM S14 AS BYTE

'****Action_mode ******************
CONST entertainment_mode  = 0 	'E
CONST fight_mode    	= 1 	'F
CONST game_mode       	= 2 	'G
CONST hurdle_game_mode 	= 3 	'G

'**** TILT SENSOR CHECK

CONST F_B_tilt_AD_port = 2
CONST L_R_tilt_AD_port = 3
CONST tilt_check_CNT = 10  'ms


CONST min = 95			
CONST max = 160			
CONST COUNT_MAX = 30
CONST low_volt = 106	

PTP SETON 				
PTP ALLON				

DIR G6A,1,0,0,1,0,0		'motor0~5
DIR G6B,1,1,1,1,1,1		'motor6~11
DIR G6C,0,0,0,0,0,0		'motor12~17
DIR G6D,0,1,1,0,1,0		'motor18~23

'***** First Program *********************************
motorONOFF = 0
walk_order = 0
mirror_check = 0
tilt_CNT = 0
Action_mode = 0			
grip_pose = 0

'**** Feedback *****************************

GOSUB MOTOR_ON

SPEED 5
GOSUB power_first_pose
GOSUB stand_pose


GOTO MAIN
'************************************************
'************************************************
mode1:
    TEMPO 200
    MUSIC "O18A>#CE#G#F#D#FB"
    RETURN
footballgame_music:
    TEMPO 180
    MUSIC "O28A#GABA"
    RETURN


mode3:
    TEMPO 190
    MUSIC "O28#C#D#F#G#A#G#F"
    RETURN

mode4:
    TEMPO 220
    MUSIC "O33C6D3C<6$B3A"
    RETURN


hurdle_game_music:
    TEMPO 200
    MUSIC "O37C<C#BCA"
    RETURN

    '************************************************
MOTOR_FAST_ON:

    MOTOR G6B
    MOTOR G6C
    MOTOR G6A
    MOTOR G6D

    motorONOFF = 0

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

    motorONOFF = 0
    GOSUB start_music			
    RETURN

    '************************************************
    start_music:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
    end_music:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    motorONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB end_music	
    RETURN
    '************************************************
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,0
    GETMOTORSET G6C,1,1,1,0,0,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3
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
     '************************************************
power_first_pose:
    MOVE G6A,95,  76, 145,  93, 105, 100
    MOVE G6D,95,  76, 145,  93, 105, 100
    MOVE G6B,100,  45,  90, 100, 100, 100
    MOVE G6C,100,  45,  90, 100, 100, 100
    WAIT
    pose = 0
    RETURN
    '************************************************
stabilized_pose:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0

    RETURN
    '******************************************	
    '************************************************
stand_pose:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0
    grip_pose = 0
    RETURN
    '******************************************	
standard_pose: 
    MOVE G6A,100,  76, 145,  93, 100, 100 
    MOVE G6D,100,  76, 145,  93, 100, 100 
    MOVE G6B,100,  30,  80, 100, 100, 100 
    MOVE G6C,100,  30,  80, 100, 100, 100 
    WAIT 
 RETURN     
 
  '******************************************	
MAIN:


    ERX 4800,A,MAIN
    A_old = A

    ON A GOTO MAIN,KEY1',KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,
        GOTO MAIN	
    '*******************************************
  
    '*******************************************

KEY1:

FOR A = 0 TO 2
'抬左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101,  54,  82,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
'抬右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  61,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
'放左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  68,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100
'放右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  55,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  22,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100
NEXT A
'前伸一手（左）

MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 139,  35,  81,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  36,  81,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  12,  48,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  35,  71,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 154,  36,  72,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C,  97,  37,  72,  ,  ,  
WAIT
DELAY 50

'伸展运动（头也能动）
FOR i = 1 TO 2
        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6A,  89,  76, 145,  93, 110,
        MOVE G6D,  90,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,38
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100


        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        '**********************************************后四拍

        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6D,  89,  76, 145,  93, 110,
        MOVE G6A,  93,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,150
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100



        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,101
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

    NEXT i
    DELAY 200
    
    FOR A = 0 TO 2
'抬左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101,  54,  82,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT

'抬右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  61,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT

'放左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  68,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT

'放右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  55,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  22,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
NEXT A
    
    '扩胸



        SPEED 15
        MOVE G6A,  90, 100,  95, 120, 114,
        MOVE G6D, 113,  76, 146,  93,  95,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT

        SPEED 15
        MOVE G6A,  92,  50, 139, 130, 108,
        MOVE G6D,  90, 110, 117,  91, 107,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT

        SPEED 16
        MOVE G6A,  92,  50, 139, 130, 108,
        MOVE G6D,  90, 110, 117,  91, 107,
        MOVE G6B, 187, 102,  99,  ,  ,
        MOVE G6C, 187,  98, 103,  ,  ,
        WAIT
        DELAY 100  '第一拍

        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 189, 103,  99,  ,  ,
        MOVE G6C, 187,  99, 104,  ,  ,
        WAIT

        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 186,  10,  54,  ,  ,
        MOVE G6C, 190,  10,  57,  ,  ,
        WAIT



        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT
        DELAY 100 '第二拍

        SPEED 15

        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 177,  15,  47,  ,  ,
        MOVE G6C, 179,  10,  56,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 190, 100, 101,  ,  ,
        MOVE G6C, 190,  95, 102,  ,  ,
        WAIT
        DELAY 100'第三拍

        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 190,  10,  99,  ,  ,
        MOVE G6C, 190,  10, 102,  ,  ,
        WAIT




        SPEED 15
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100 '第四拍


        '***************************************后四拍

        SPEED 15
        MOVE G6A, 113,  76, 146,  93, 100,
        MOVE G6D,  90, 100,  95, 120, 110,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT

        SPEED 15

        MOVE G6A,  93, 110, 117,  91, 107,
        MOVE G6D,  94,  50, 139, 130, 103,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT



        SPEED 15
        MOVE G6A,  93, 110, 117,  91, 107,
        MOVE G6D,  94,  50, 139, 130, 103,
        MOVE G6B, 187, 102,  99,  ,  ,
        MOVE G6C, 187,  98, 103,  ,  ,
        WAIT
        DELAY 100 '第一拍

        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 189, 103,  99,  ,  ,
        MOVE G6C, 187,  99, 104,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 186,  10,  54,  ,  ,
        MOVE G6C, 190,  10,  58,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT
        DELAY 100 '第二拍

        WAIT
        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 176,  15,  48,  ,  ,
        MOVE G6C, 179,  10,  55,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 190, 100, 106,  ,  ,
        MOVE G6C, 190,  95, 102,  ,  ,
        WAIT
        DELAY 100 '第三拍

        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 190,  10,  99,  ,  ,
        MOVE G6C, 190,  10, 102,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100 '第四拍


    
    DELAY 200
 
 '扩胸
 SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6A,  89,  76, 145,  93, 110,
        MOVE G6D,  90,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,38
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100


        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        '**********************************************后四拍

        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6D,  89,  76, 145,  93, 110,
        MOVE G6A,  93,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,150
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100



        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,101
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

 
 
 '第二次   
    
'抬左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101,  54,  82,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
'抬右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  61,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
DELAY 100
'放左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  68,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100
'放右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  55,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  22,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
DELAY 100

'前伸一手（右）
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 147,  24,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  19,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  13,  54,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  28,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 157,  22,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B,  99,  22,  81,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 50




'伸展运动（头也能动）
FOR i = 1 TO 2
        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6A,  89,  76, 145,  93, 110,
        MOVE G6D,  90,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,38
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100


        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        '**********************************************后四拍

        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6D,  89,  76, 145,  93, 110,
        MOVE G6A,  93,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,150
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100



        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,101
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

    NEXT i
    DELAY 200
    
    FOR A = 0 TO 2
'抬左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101,  54,  82,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 100,  30,  80,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT

'抬右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  61,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101, 110,  83,  ,  ,  
WAIT

'放左手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  68,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  99,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT

'放右手
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  55,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 101,  22,  81,  ,  ,  
MOVE G6C, 101,  19,  83,  ,  ,  
WAIT
NEXT A
    
    '扩胸
   


        SPEED 15
        MOVE G6A,  90, 100,  95, 120, 114,
        MOVE G6D, 113,  76, 146,  93,  95,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT

        SPEED 15
        MOVE G6A,  92,  50, 139, 130, 108,
        MOVE G6D,  90, 110, 117,  91, 107,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT

        SPEED 16
        MOVE G6A,  92,  50, 139, 130, 108,
        MOVE G6D,  90, 110, 117,  91, 107,
        MOVE G6B, 187, 102,  99,  ,  ,
        MOVE G6C, 187,  98, 103,  ,  ,
        WAIT
        DELAY 100  '第一拍

        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 189, 103,  99,  ,  ,
        MOVE G6C, 187,  99, 104,  ,  ,
        WAIT

        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 186,  10,  54,  ,  ,
        MOVE G6C, 190,  10,  57,  ,  ,
        WAIT



        SPEED 15
        MOVE G6A,  92,  64, 140, 116, 109,
        MOVE G6D,  88,  73, 137, 111, 108,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT
        DELAY 100 '第二拍

        SPEED 15

        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 177,  15,  47,  ,  ,
        MOVE G6C, 179,  10,  56,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 190, 100, 101,  ,  ,
        MOVE G6C, 190,  95, 102,  ,  ,
        WAIT
        DELAY 100'第三拍

        SPEED 15
        MOVE G6A,  91,  63, 120, 133, 105,
        MOVE G6D, 102, 108,  97, 112,  98,
        MOVE G6B, 190,  10,  99,  ,  ,
        MOVE G6C, 190,  10, 102,  ,  ,
        WAIT




        SPEED 15
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100 '第四拍


        '***************************************后四拍

        SPEED 15
        MOVE G6A, 113,  76, 146,  93, 100,
        MOVE G6D,  90, 100,  95, 120, 110,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT

        SPEED 15

        MOVE G6A,  93, 110, 117,  91, 107,
        MOVE G6D,  94,  50, 139, 130, 103,
        MOVE G6B, 101,  31,  81,  ,  ,
        MOVE G6C, 101,  34,  82,  ,  ,
        WAIT



        SPEED 15
        MOVE G6A,  93, 110, 117,  91, 107,
        MOVE G6D,  94,  50, 139, 130, 103,
        MOVE G6B, 187, 102,  99,  ,  ,
        MOVE G6C, 187,  98, 103,  ,  ,
        WAIT
        DELAY 100 '第一拍

        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 189, 103,  99,  ,  ,
        MOVE G6C, 187,  99, 104,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 186,  10,  54,  ,  ,
        MOVE G6C, 190,  10,  58,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  90,  64, 140, 116, 109,
        MOVE G6D,  91,  73, 137, 111, 108,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT
        DELAY 100 '第二拍

        WAIT
        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 188,  88,  10,  ,  ,
        MOVE G6C, 187,  95,  10,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 176,  15,  48,  ,  ,
        MOVE G6C, 179,  10,  55,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 190, 100, 106,  ,  ,
        MOVE G6C, 190,  95, 102,  ,  ,
        WAIT
        DELAY 100 '第三拍

        SPEED 15
        MOVE G6A,  99, 110, 104, 106,  99,
        MOVE G6D,  94,  45, 139, 137, 104,
        MOVE G6B, 190,  10,  99,  ,  ,
        MOVE G6C, 190,  10, 102,  ,  ,
        WAIT


        SPEED 15
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100 '第四拍


 
    DELAY 200
    
  '伸展
  
  '伸展运动（头也能动）
FOR i = 1 TO 2
        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6A,  89,  76, 145,  93, 110,
        MOVE G6D,  90,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,38
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100


        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        '**********************************************后四拍

        SPEED 11
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,101
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

        SPEED 9
        MOVE G6D,  89,  76, 145,  93, 110,
        MOVE G6A,  93,  76, 145,  93, 108,
        MOVE G6B, 100, 105, 100,  ,  ,150
        MOVE G6C, 101, 101, 100,  ,  ,
        WAIT
        DELAY 100

        'SPEED 13
        'MOVE G6A, 100,  76, 145,  93, 100,
        'MOVE G6D, 100,  76, 145,  93, 100,
        'MOVE G6B, 100,  30,  80,  ,  ,101
        'MOVE G6C, 100,  30,  80,  ,  ,
        'WAIT
        'DELAY 100

        SPEED 9
        MOVE G6A, 100,  95,  79, 163, 100,
        MOVE G6D, 100,  95,  79, 163, 100,
        MOVE G6B, 155,  32,  61,  ,  ,101
        MOVE G6C, 155,  32,  61,  ,  ,
        WAIT
        DELAY 100



        SPEED 8
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 101, 170, 110,  ,  ,101
        MOVE G6C, 100, 171, 110,  ,  ,
        WAIT
        DELAY 50

        SPEED 13
        MOVE G6A, 100,  76, 145,  93, 100,
        MOVE G6D, 100,  76, 145,  93, 100,
        MOVE G6B, 100,  30,  80,  ,  ,
        MOVE G6C, 100,  30,  80,  ,  ,
        WAIT
        DELAY 100

    NEXT i
    DELAY 200

'前伸一只手（左）
FOR i = 0 TO 1
SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 139,  35,  81,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  36,  81,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  12,  48,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  35,  71,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 154,  36,  72,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C,  97,  37,  72,  ,  ,  
WAIT
DELAY 100
NEXT i

'前伸一手（右）
FOR I = 0 TO 1
SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 147,  24,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  19,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  13,  54,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  28,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 157,  22,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B,  99,  22,  81,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

NEXT I


'最后左伸手
SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 139,  35,  81,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  36,  81,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  12,  48,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 188,  35,  71,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C, 154,  36,  72,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 101,  75, 144,  94,  99,  
MOVE G6D, 102,  76, 143,  95,  99,  
MOVE G6B, 101,  30,  80,  ,  ,  
MOVE G6C,  97,  37,  72,  ,  ,  
WAIT
DELAY 100

'原地踏步走
FOR I = 0 TO 3
    SPEED 4
        MOVE G6A,105,  76, 146,  93, 98, 100
        MOVE G6D,90,  73, 151,  90, 108, 100
        WAIT

        SPEED 12
        MOVE G6A,113,  76, 146,  93, 95, 100
        MOVE G6D,90,  100, 95,  120, 110, 100
        MOVE G6B,120
        MOVE G6C,80
        WAIT

        SPEED 10
        MOVE G6A,109,  76, 146,  93, 97, 100
        MOVE G6D,90,  76, 148,  92, 107, 100
        WAIT
        'DELAY 100

        SPEED 4	
        MOVE G6A,98,  76, 146,  93, 100, 100
        MOVE G6D,98,  76, 146,  93, 100, 100	
        WAIT

        '***********************************
        SPEED 4
        MOVE G6D,105,  76, 146,  93, 98, 100
        MOVE G6A,90,  73, 151,  90, 108, 100
        WAIT	

        SPEED 12
        MOVE G6D,113,  76, 146,  93, 95, 100
        MOVE G6A,90,  100, 95,  120, 110, 100
        MOVE G6C,120
        MOVE G6B,80
        WAIT	

        SPEED 10
        MOVE G6D,109,  76, 146,  93, 97, 100
        MOVE G6A,90,  76, 148,  92, 107, 100
        WAIT	

        SPEED 4	
        MOVE G6D,98,  76, 146,  93, 100, 100
        MOVE G6A,98,  76, 146,  93, 100, 100	
        WAIT
        
        NEXT I

'最后右伸手
SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 147,  24,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  19,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  13,  54,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 182,  28,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B, 157,  22,  80,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

SPEED 5
MOVE G6A, 100,  76, 145,  93, 100,  
MOVE G6D, 100,  76, 145,  93, 100,  
MOVE G6B,  99,  22,  81,  ,  ,  
MOVE G6C, 100,  30,  80,  ,  ,  
WAIT
DELAY 100

