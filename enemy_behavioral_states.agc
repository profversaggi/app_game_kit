rem ********************************
rem Battleship behavior_states.agc
rem *******************************



Function ChangeEnemyBehaviorState(newState, target)
    select newState
        case WANDER:            `[1061]
            enemy.behavior_state = WANDER
            WanderAround(enemy.sprID)
        endcase
        case SEEK:              `[1062]
            enemy.behavior_state = SEEK
            SeekTarget(enemy.sprID, target)
        endcase
        case FLEE:              `[1063]
            enemy.behavior_state = FLEE
            FleeTarget(enemy.sprID, target)
        endcase
        case PURSUE:            `[1064]
            enemy.behavior_state = PERSUE
            PursueTarget(enemy.sprID, target)
        endcase
        case EVADE:             `[1065]
            enemy.behavior_state = EVADE
            EvadeTarget(enemy.sprID, target)
        endcase
        case ARRIVE:           `[1066]
            enemy.behavior_state = ARRIVE
            enemy.arrivedAtTarget = FALSE
            ArriveAtTarget(enemy.sprID, target, FAST)
        endcase
        case PATROL:              `[1070]   <= This will change according to what needs patrolling
            enemy.behavior_state = PATROL
            if     ((enemy.node.lastVisited_1 = NONE))
                        ChangeEnemyBehaviorState(ARRIVE, myNodes[0].sprID)
            elseif ((enemy.node.lastVisited_2 = NONE))
                        ChangeEnemyBehaviorState(ARRIVE, myNodes[1].sprID)
            elseif ((enemy.node.lastVisited_3 = NONE))
                        ChangeEnemyBehaviorState(ARRIVE, myNodes[2].sprID)
            elseif ((enemy.node.lastVisited_4 = NONE))
                        ChangeEnemyBehaviorState(ARRIVE, myNodes[3].sprID)
            elseif ((enemy.node.lastVisited_5 = NONE))
                        ChangeEnemyBehaviorState(ARRIVE, myNodes[4].sprID)
            endif
        endcase
        case AVOID_OBSTACLE:    `[1067]
            enemy.behavior_state = AVOID_OBSTACLE
        endcase
        case FLOCK:             `[1068]
            enemy.behavior_state = FLOCK
        endcase
        case IDLE:              `[1069]
            enemy.behavior_state = IDLE
            ` *** Do Nothing ***
        endcase
        case ATTACK:            `[1071]
            enemy.behavior_state = ATTACK
        endcase
        case SAFE:              `[1072]
            enemy.behavior_state = SAFE
        endcase
        case ENGAGED:            `[1073]
            enemy.behavior_state = ENGAGED
        endcase
    endselect
EndFunction


Function ChangeAttackBoatsBehaviorState(index, newState)
    select newState
        case WANDER:            `[1061]
            attackBoats[index].behavior_state = WANDER
        endcase
        case SEEK:              `[1062]
            attackBoats[index].behavior_state = SEEK
        endcase
        case FLEE:              `[1063]
            attackBoats[index].behavior_state = FLEE
        endcase
        case PURSUE:            `[1064]
            attackBoats[index].behavior_state = PERSUE
        endcase
        case EVADE:             `[1065]
            attackBoats[index].behavior_state = EVADE
        endcase
        case ARRIVE:           `[1066]
            attackBoats[index].behavior_state = ARRIVE
        endcase
        case AVOID_OBSTACLE:    `[1067]
            attackBoats[index].behavior_state = AVOID_OBSTACLE
        endcase
        case FLOCK:             `[1068]
            attackBoats[index].behavior_state = FLOCK
        endcase
        case IDLE:              `[1069]
            attackBoats[index].behavior_state = IDLE
        endcase
    endselect
EndFunction




// *********************** DEBUG STUFF ****************


rem **********************************
rem EOF Battleship behavior_states.agc
rem **********************************

