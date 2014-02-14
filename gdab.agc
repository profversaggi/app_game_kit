rem *****************************
rem Battleship gdab.agc
rem Goal Directed Agent Behavior
rem ****************************


` **** Goal UTD's
` Type _goal
`    goalName        as String
`    satisfied       as integer
`    localIndex      as integer
` EndType



Function ConstructGoalStack()
    #constant GOAL_STACK                  = "GoalStack"
    #constant GOAL_STACKMAX               = 50

    global dim goalStack[GOAL_STACKMAX] as _goal
    global goalStackTopIndex            as integer
    global goalStackState               as integer
    global nullGoal                     as _goal
    global tempGoal                     as _goal

    goalStackTopIndex                   = NULL
    goalStackState                      = NULL
    nullGoal.goalName                   = ""
    nullGoal.satisfied                  = NULL
    nullGoal.localIndex                 = NULL
EndFunction


Function InstantiateGoalConstants()
    #constant G_ENEMY_ATTACK_SHIP                   = "G_ENEMY_ATTACK_SHIP"
    #constant G_ENEMY_HIDE_FROM_SHIP                = "G_ENEMY_HIDE_FROM_SHIP"
    #constant G_ARRIVE_BALLSPRITE                   = "G_ARRIVE_BALLSPRITE"
    #constant G_SEEK_NODE_0                         = "G_SEEK_NODE_0"
    #constant G_ARRIVE_NODE_0                       = "G_ARRIVE_NODE_0"
    #constant G_ARRIVE_NODE_9                       = "G_ARRIVE_NODE_9"
    #constant G_ARRIVE_SHIP                         = "G_ARRIVE_SHIP"
    #constant G_PURSUE_SHIP                         = "G_PURSUE_SHIP"
    #constant G_FLEE_SHIP                           = "G_FLEE_SHIP"
    #constant G_EVADE_SHIP                          = "G_EVADE_SHIP"
    #constant G_PATROL_POV_GRAPH                    = "G_PATROL_POV_GRAPH"
    #constant G_WANDER                              = "G_WANDER"
    #constant G_IDLE                                = "G_IDLE"
    #constant G_AVOID_OBSTACLE_ENEMY_FT_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_FT_SENSOR"
    #constant G_AVOID_OBSTACLE_ENEMY_MT_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_MT_SENSOR"
    #constant G_AVOID_OBSTACLE_ENEMY_BT_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_BT_SENSOR"
    #constant G_AVOID_OBSTACLE_ENEMY_FB_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_FB_SENSOR"
    #constant G_AVOID_OBSTACLE_ENEMY_MB_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_MB_SENSOR"
    #constant G_AVOID_OBSTACLE_ENEMY_BB_SENSOR      = "G_AVOID_OBSTACLE_ENEMY_BB_SENSOR"

EndFunction


` ********* GOAL EXECUTION COMMAND SET *******


Function PrimeGoalStack()
    InitializeStack(GOAL_STACK)
                                            ` Take the temporary Goal Object,
    tempGoal.goalName = G_IDLE              ` ... set its name to the constant representing it's command to be executed,
    tempGoal.satisfied = FALSE              ` ... set it's 'Satisified' flag to FALSE,
    tempGoal.localIndex = NULL              ` ... set it's localIndex to NULL (-1)
    PushOnStack(GOAL_STACK, tempGoal)       ` Put it onto the stack for later execution

    tempGoal.goalName = G_ENEMY_HIDE_FROM_SHIP
    tempGoal.satisfied = FALSE
    tempGoal.localIndex = NULL
    PushOnStack(GOAL_STACK, tempGoal)
EndFunction



Function AddGoalToGoalStack(goalName$)
    isNewGoal = TRUE                               ` Assume the goal does NOT exists in the goalStack...
    for i = goalStackTopIndex to 0 step -1         ` Check the entire goalStack to see if this goal already exists
        tempGoal =  goalStack[i]
        if (tempGoal.goalName = goalName$)
            isNewGoal = FALSE                        ` If it's has been found, declare it a existing goal ...
        endif
    next i

    if (isNewGoal = TRUE)                           ` Only if it's truly a new goal ....
            tempGoal.goalName = goalName$           ` Set its name to the constant representing it's command to be executed
            tempGoal.satisfied = FALSE              ` Set it's 'Satisified' flag to FALSE
            tempGoal.localIndex = NULL              ` Set it's localIndex to NULL (-1)
            PushOnStack(GOAL_STACK, tempGoal)       ` Put it onto the stack for later execution.
    endif
EndFunction



Function ExecuteGoal(goal$)
    select goal$
        case G_ENEMY_ATTACK_SHIP: `["G_ENEMY_ATTACK_SHIP"]
            AttackTarget(enemy.sprID, ship.sprID, FAST)
        endcase
        case G_ENEMY_HIDE_FROM_SHIP: `["G_ENEMY_HIDE_FROM_SHIP"]
            Hide(enemy.sprID, ship.sprID, obstacle[9].sprID, myNodes[0].sprID)
        endcase
        case G_ARRIVE_BALLSPRITE: `["G_ARRIVE_BALLSPRITE"]
            ChangeEnemyBehaviorState(ARRIVE, ballSpriteID)
        endcase
        case G_SEEK_NODE_0:       `["G_SEEK_NODE_0"]
            ChangeEnemyBehaviorState(SEEK, myNodes[0].sprID)
        endcase
        case G_ARRIVE_NODE_0:     `["G_ARRIVE_NODE_0"]
            ChangeEnemyBehaviorState(ARRIVE, myNodes[0].sprID)
        endcase
        case G_ARRIVE_NODE_9:     `["G_ARRIVE_NODE_9"]
            ChangeEnemyBehaviorState(ARRIVE, myNodes[9].sprID)
        endcase
        case G_ARRIVE_SHIP:       `["G_ARRIVE_SHIP"]
            ChangeEnemyBehaviorState(ARRIVE, ship.SprID)
        endcase
        case G_PURSUE_SHIP:       `["G_PURSUE_SHIP"]
            ChangeEnemyBehaviorState(PURSUE, ship.SprID)
        endcase
        case G_FLEE_SHIP:         `["G_FLEE_SHIP"]
            ChangeEnemyBehaviorState(FLEE, ship.SprID)
        endcase
        case G_EVADE_SHIP:        `["G_EVADE_SHIP"]
            ChangeEnemyBehaviorState(EVADE, ship.SprID)
        endcase
        case G_PATROL_POV_GRAPH:  `["G_PATROL_POV_GRAPH"]
            ChangeEnemyBehaviorState(PATROL, SINGLETON)
        endcase
        case G_WANDER:            `["G_WANDER"]
            ChangeEnemyBehaviorState(WANDER, SINGLETON)
        endcase
        case G_IDLE:              `["G_IDLE"]
            ChangeEnemyBehaviorState(IDLE, SINGLETON)
        endcase
        case G_AVOID_OBSTACLE_ENEMY_FT_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_FT_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "frontTop"
            SetForceVectors(enemy.sprID, sensorLocation$)   ` Depending on the angle of the enemy, this FN will determine the proper vectors and their forces
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase
        case G_AVOID_OBSTACLE_ENEMY_MT_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_MT_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "midTop"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase
        case G_AVOID_OBSTACLE_ENEMY_BT_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_BT_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "backTop"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase
        case G_AVOID_OBSTACLE_ENEMY_FB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_FB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "frontBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)   ` Depending on the angle of the enemy, this FN will determine the proper vectors and their forces
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase
        case G_AVOID_OBSTACLE_ENEMY_MB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_MB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "midBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase
        case G_AVOID_OBSTACLE_ENEMY_BB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_BB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "backBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
            enemy.forceVector.x = 0
            enemy.forceVector.y = 0
        endcase

    endselect
EndFunction



Function InterrogateGoalStack(stack as string)                  ` To be run every frame in the main do loop ....
    select stack
        case GOAL_STACK:            `"goalStack"
            if (IsStackEmpty(GOAL_STACK) = NOT_EMPTY)           ` If the stack is not empty ....
                tempGoal = GetStackTop(GOAL_STACK)              ` Do a ReadOnly 'exam' of the goal object currently executing (top of stack)
                if (tempGoal.satisfied = TRUE)                  ` (1) If it's Goal has been satisified,
                    PopOffStack(GOAL_STACK)                     ` ...then remove it.
                    if (IsStackEmpty(GOAL_STACK) = NOT_EMPTY)   ` If the stack is not empty,
                        tempGoal = GetStackTop(GOAL_STACK)      ` ... fetch the next goal object (readonly),
                        ExecuteGoal(tempGoal.goalName)          ` ... then execute the command attached to it's goal name.
                    endif
                elseif (tempGoal.satisfied = FALSE)             ` (2) However if it has *not* been satisified,
                        ExecuteGoal(tempGoal.goalName)          ` ... then continue executing the command attached to it's goal name.
                endif
            endif
        endcase
    endselect
EndFunction



Function SetCurrentGoalSatisifiedFlag(flag)
        goalStack[goalStackTopIndex].satisfied = flag
EndFunction


` *********** GOAL STACK Operations ********
` global dim goalStack[GOAL_STACKMAX] as integer


Function InitializeStack(stack as string)
    select stack
        case GOAL_STACK:            `"goalStack"
            goalStackTopIndex = ZERO
        endcase
    endselect
EndFunction


Function IsStackEmpty(stack as string)
    select stack
        case GOAL_STACK:            `"goalStack"
            if (goalStackTopIndex = NULL)
                goalStackState = EMPTY
            else
                goalStackState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction goalStackState


Function IsStackFull(stack as string)
    select stack
        case GOAL_STACK:            `"goalStack"
            if (goalStackTopIndex = GOAL_STACKMAX)
                goalStackState = FULL
            else
                goalStackState = NOT_FULL
            endif
        endcase
    endselect
EndFunction goalStackState


Function GetStackTop(stack as string)
    returnItem as _goal
    select stack
        case GOAL_STACK:            `"goalStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                returnItem = goalStack[goalStackTopIndex]
            elseif IsStackEmpty(stack) = EMPTY
                returnItem = nullGoal
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnStack(stack as string, item as _goal)
    select stack
        case GOAL_STACK:            `"goalStack"
            if (IsStackFull(stack) = NOT_FULL)
                inc goalStackTopIndex
                goalStack[goalStackTopIndex] = item
                operationResult = SUCCESS
                if (goalStackTopIndex = GOAL_STACKMAX) then goalStackState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffStack(stack as string)
    select stack
        case GOAL_STACK:            `"goalStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                goalStack[goalStackTopIndex] = nullGoal ` Set the deleted Goal to a previously defined nullGoal record
                dec goalStackTopIndex
                operationResult = SUCCESS
                if (goalStackTopIndex = ZERO)
                    goalStackTopIndex = NULL    ` Signal an Empty Stack
                    goalStackState = EMPTY      ` Set the Stack Global Stack State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PrintStack(stack as string)
    select stack
        case GOAL_STACK:            `"goalStack"
            if (IsStackEmpty(stack) = EMPTY)
                Print("  Stack Empty")
            else
                for i = 1 to goalStackTopIndex
                    print("  goalStack["+Str(i)+"]: "+goalStack[i].goalName)
                next i
            endif
        endcase
    endselect
EndFunction




rem ************************
rem EOF Battleship gdab.agc
rem ************************
