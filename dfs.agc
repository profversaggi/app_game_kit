rem **************************
rem Battleship dfs.agc
rem **************************


` ****** Depth First Search Operations ********

RemStart ` ***************************************************

    Type _edges
        parentNode             as integer
        destinationNode        as integer
        currentNodeVisited     as integer
        DestinationNodeVisited as integer
    EndType

    Type _nodes
        parent       as integer
        child        as integer
        nodeName$    as string
        index        as integer
        visited      as integer
        sprID
        x#
        y#
        width#
        height#
        absCtrX#
        absCtrY#
    EndType

    ` *** Stacks: Depth First Search Graph **********
    global dim DFSEdges[DFS_EDGES_MAX] as _edges
    global dim DFSAdjacencyMatrix[DFS_NODES_MAX, DFS_NODES_MAX] as _edges
    global dim DFSNodes[DFS_NODES_MAX]  as _nodes


    ` **** DFS Stack definitions
    global dim dfsStack[DFS_STACKMAX] as _edges
    global nullEdge                   as _edges
    global tempEdge                   as _edges
    global dfsStackTopIndex           as integer
    global dfsStackState              as integer


    ` **** Depth First Search Stack ************
    #constant DSF_STACK                  = "dfsStack"
    #constant DFS_STACKMAX               = 50
    #constant DFS_NODES_MAX              = 5
    #constant DFS_EDGES_MAX              = 50
    dfsStackTopIndex                     = NULL
    dfsStackState                        = NULL
    nullEdge.parentNode                  = NOTCONNECTED
    nullEdge.destinationNode             = NOTCONNECTED
    nullEdge.currentNodeVisited          = FALSE
    nullEdge.DestinationNodeVisited      = FALSE

    N   E1 - E2
    ------------
    1   1 - (-1)
        1 - 2
        1 - 3
        1 - 4
        1 - 5
    2   2 - 1
        2 - (-1)
        2 - 3
        2 - 4
        2 - 5
    3   3 - 1
        3 - 2
        3 - (-1)
        3 - 4
        3 - 5
       ....
       ....
    5  ....
                    Remember => Arays start at ZERO !!!


Execution Commands:

` ****** For the DepthFirst Search
`CreatePOVGraph()    ` Create the POV fully connected graph for the DFS
`PrintDFSGraph()
`DepthFirstSearch(4)


RemEnd ` ***************************************************

` **** Depth First Search UTD's
Type _edges
    parentNode             as integer
    destinationNode        as integer
    currentNodeVisited     as integer
    DestinationNodeVisited as integer
EndType

Type _nodes
    parent       as integer
    child        as integer
    nodeName$    as string
    index        as integer
    visited      as integer
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
EndType

` ********* Stacks and Queues: Generic
global dim myStack[MY_STACKMAX] as integer
global myStackTopIndex          as integer
global myStackState             as integer

global dim myQueue[MY_QUEUEMAX] as integer
global myQueueFrontIndex        as integer
global myQueueRearIndex         as integer
global myQueueState             as integer


` *** Stacks: Depth First Search Graph **********
global dim DFSEdges[50] as _edges
global dim DFSAdjacencyMatrix[5, 5] as _edges
global dim DFSNodes[5]  as _nodes


` **** DFS Stack definitions
global dim dfsStack[DFS_STACKMAX] as _edges
global nullEdge                   as _edges
global tempEdge                   as _edges
global dfsStackTopIndex           as integer
global dfsStackState              as integer


    ` **** DataStructures and Algorithyms Globals: Stacks and Queues
    #constant MY_STACK                  = "myStack"
    #constant MY_QUEUE                  = "myQueue"
    #constant MY_STACKMAX               = 5
    #constant MY_QUEUEMAX               = 5
    myStackTopIndex                     = NULL
    myQueueFrontIndex                   = NULL
    myQueueRearIndex                    = NULL
    myStackState                        = NULL
    myQueueState                        = NULL


    ` **** Depth First Search Stack ************
    #constant DSF_STACK                  = "dfsStack"
    #constant DFS_STACKMAX               = 50
    #constant DFS_NODES_MAX              = 5
    #constant DFS_EDGES_MAX              = 50
    dfsStackTopIndex                     = NULL
    dfsStackState                        = NULL
    nullEdge.parentNode                  = NOTCONNECTED
    nullEdge.destinationNode             = NOTCONNECTED
    nullEdge.currentNodeVisited          = FALSE
    nullEdge.DestinationNodeVisited      = FALSE




Function DepthFirstSearch(target)
    stdfile = OpenToWrite("dfs.txt", 0)
    ` Begin the DFS search by creating *Dummy Edge* at the start node, w/edges leading from
    ` the source node (1) to the source node (1) and put it on stack
    tempEdge = DFSAdjacencyMatrix[1,1]
    tempEdge.parentNode         = 1               ` This is the Origin Node (aka the *Parent* of the Destination Node: destinationNode)
    tempEdge.destinationNode    = 1                ` This is the Destination Node
    DFSNodes[tempEdge.parentNode].visited  = FALSE
    DFSNodes[tempEdge.destinationNode].visited  = FALSE ` This isn't a problem because it's a dummy edge (1-1)
    PushOnStack_DFS(tempEdge)

    while (IsStackEmpty_DFS() = NOT_EMPTY)                      ` While there are still unexplored edges on the stack...
        tempEdge = GetStackTop_DFS()                            ` Retrieve an AdjacencyMatrix Edge from the top of the stack
        PopOffStack_DFS()                                       ` Delete that Adjacency Matrix Edge off top of stack (aka: POP)
        DFSNodes[tempEdge.destinationNode].parent = tempEdge.parentNode ` [PDe:1 - De:1], edges destination node ->tempEdge.destinationNode, DFSNodes[tempEdge.destinationNode].parent is that nodes parent, which is tempEdge.parentEdge
        DFSNodes[tempEdge.destinationNode].visited = TRUE       ` Mark Destination node as 'Visited'
         WriteLine(stdfile, "DFSNodes["+str(tempEdge.destinationNode)+"].visited->"+str(DFSNodes[tempEdge.destinationNode].visited))
        if (tempEdge.destinationNode = target)                  ` Check Termination Condition...
            dfsResult = tempEdge.destinationNode ` SUCCESS
            exit
        else
            dfsResult = FAILURE
        endif

        i = tempEdge.destinationNode                           ` Set the X AdjacencyMatrix variable to the 'Current Node'
        tempEdge.parentNode = i
        for j = 1 to DFS_NODES_MAX                          ` add all of top's unvisited neighbors to the stack.
            tempEdge.destinationNode = j
            if (DFSNodes[tempEdge.destinationNode].visited = FALSE) AND (DFSAdjacencyMatrix[i,j].parentNode >= CONNECTED)
                tempEdge = DFSAdjacencyMatrix[i,j]                       ` Copy the AdjacencyMatrix Edge to the temporary edge
                PushOnStack_DFS(tempEdge)                                ` Put it on the stack
            endif
        next j

    PrintStack_DFS()
    endwhile
    WriteLine(stdfile, "Result: (S/F):=>"+Str(dfsResult))
    CloseFile(stdfile)
EndFunction dfsResult




Function CreatePOVGraph()
    ` Represent the Graph Data as 1 Array of Nodes and 1 Array of Edges
    totalPossibleEdges = DFS_NODES_MAX*DFS_NODES_MAX
    dim graphNodes$[DFS_NODES_MAX] as string = ["A", "B", "C", "D", "E"]
    dim adjacencyMatrixData[totalPossibleEdges] as integer = [0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0]
    index = 0 ` Index of the Data array - starts at zero

    ` Populate the Edges Array: DFSEdges
    for i = 1 to DFS_NODES_MAX
        for j = 1 to DFS_NODES_MAX
            DFSEdges[index].parentNode = i                   ` The first Edge Node is always the counter 'i'
            if (adjacencyMatrixData[index] = TRUE)
                DFSEdges[index].destinationNode  = j              ` If there is a connection, set the next Edge Node to 'j'

                DFSAdjacencyMatrix[i,j].parentNode = i       ` **** Adjacency Matrix Population w/Edge Data
                DFSAdjacencyMatrix[i,j].destinationNode = j
            else
                DFSEdges[index].destinationNode  = NOTCONNECTED   ` If there is *no* connection set the next node to "-1"

                DFSAdjacencyMatrix[i,j].parentNode = NOTCONNECTED  ` **** Adjacency Matrix Population w/Edge Data
                DFSAdjacencyMatrix[i,j].destinationNode = NOTCONNECTED
            endif
            inc index
        next j
    next i
    for i = 0 to DFS_NODES_MAX -1
        ` Populate the Nodes Array:  DFSNodes
        DFSNodes[i].nodeName$ = graphNodes$[i]          ` Set the Node Name to the given String
        DFSNodes[i].index = i                           ` Set the Node Index to 'i'
        DFSNodes[i].visited = FALSE                     ` Set visited to FALSE
    next i
EndFunction


Function PrintDFSGraph()
    stdfile = OpenToWrite("DFS_Graph.txt", 0)
    WriteLine(stdfile, "*** Begin Writing Graph Data ***")
    for i = 0 to 25 ` The edges array starts at zero
        WriteLine(stdfile, "DFSEdges["+Str(i)+"]: E:"+Str(DFSEdges[i].parentNode)+"-"+Str(DFSEdges[i].destinationNode))
        `Print("Node["+Str(i)+"]: E:"+Str(DFSEdges[i].parentNode)+"-"+Str(DFSEdges[i].destinationNode))
    next i

    for i = 0 to DFS_NODES_MAX -1
       WriteLine(stdfile, "DFSNodes["+str(i)+"]: "+str(DFSNodes[i].index)+", Name: "+DFSNodes[i].nodeName$+" Visited:=>"+Str(DFSNodes[i].visited))
       `Print("Node["+str(i)+"]: "+str(DFSNodes[i].index)+", Name: "+DFSNodes[i].nodeName$)
    next i

    for i = 1 to DFS_NODES_MAX
      for j = 1 to DFS_NODES_MAX
        WriteLine(stdfile, "DFSAdjacencyMatrix["+Str(i)+", "+Str(j)+"] E1: "+Str(DFSAdjacencyMatrix[i,j].parentNode)+"-E2: "+Str(DFSAdjacencyMatrix[i,j].destinationNode))
        `Print("Node["+Str(i)+", "+Str(j)+"] E1: "+Str(DFSAdjacencyMatrix[i,j].parentNode)+"-E2: "+Str(DFSAdjacencyMatrix[i,j].destinationNode))
      next j
    next i
    WriteLine(stdfile, "*** End Writing Graph Data ***")
    CloseFile(stdfile)
EndFunction


` ****** DFS Stack Operations *****

Function InitializeStack_DFS()
    dfsStackTopIndex = ZERO
EndFunction


Function IsStackEmpty_DFS()
    if (dfsStackTopIndex = NULL)
        stackState = EMPTY
    else
        stackState = NOT_EMPTY
    endif
EndFunction stackState


Function IsStackFull_DFS()
    if (dfsStackTopIndex = DFS_STACKMAX)
        stackState = FULL
    else
        stackState = NOT_FULL
    endif
EndFunction stackState


Function GetStackTop_DFS()
    returnItem as _edges
    if (IsStackEmpty_DFS() = NOT_EMPTY)
        returnItem = dfsStack[dfsStackTopIndex]
    elseif IsStackEmpty_DFS() = EMPTY
        returnItem = nullEdge
    endif
EndFunction returnItem


Function PushOnStack_DFS(item as _edges)
    if (IsStackFull_DFS() = NOT_FULL)
        inc dfsStackTopIndex
        dfsStack[dfsStackTopIndex] = item
        operationResult = SUCCESS
        if (dfsStackTopIndex = DFS_STACKMAX) then dfsStackState = FULL
    else
        operationResult = FAILURE
    endif
EndFunction operationResult


Function PopOffStack_DFS()
    if (IsStackEmpty_DFS() = NOT_EMPTY)
        dfsStack[dfsStackTopIndex] = nullEdge   ` Set the deleted edge record to a previously defined nullEdge record
        dec dfsStackTopIndex
        operationResult = SUCCESS
        if (dfsStackTopIndex = ZERO)
            dfsStackTopIndex = NULL    ` Signal an Empty Stack
            dfsStackState = EMPTY      ` Set the Stack Global Stack State
        endif
        else
        operationResult = FAILURE
    endif
EndFunction operationResult


Function PrintStack_DFS()
    stdfile = OpenToWrite("stack.txt", 1)
    WriteLine(stdfile, "*** Begin Writing Stack Data ***")
    WriteLine(stdfile, "Stack: ")
    if (IsStackEmpty_DFS() = EMPTY)
        WriteLine(stdfile, "Empty")
        Print("Stack Empty")
    else
        for i = 0 to dfsStackTopIndex
            WriteLine(stdfile, "dfsStack["+Str(i)+"]: "+Str(dfsStack[i].parentNode)+"-"+ Str(dfsStack[i].destinationNode))
            print("dfsStack["+Str(i)+"]: "+Str(dfsStack[i].parentNode)+"-"+ Str(dfsStack[i].destinationNode))
        next i
    endif
    WriteLine(stdfile, "*** End Writing Stack Data ***")
    CloseFile(stdfile)
EndFunction




` ****** STACK Operations ********
`global dim myStack[MY_STACKMAX] as integer

Function InitializeStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            myStackTopIndex = ZERO
        endcase
    endselect
EndFunction


Function IsStackEmpty(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = NULL)
                stackState = EMPTY
            else
                stackState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction stackState


Function IsStackFull(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = MY_STACKMAX)
                stackState = FULL
            else
                stackState = NOT_FULL
            endif
        endcase
    endselect
EndFunction stackState


Function GetStackTop(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                returnItem = myStack[myStackTopIndex]
            elseif IsStackEmpty(stack) = EMPTY
                returnItem = EMPTY
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnStack(stack as string, item)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackFull(stack) = NOT_FULL)
                inc myStackTopIndex
                myStack[myStackTopIndex] = item
                operationResult = SUCCESS
                if (myStackTopIndex = MY_STACKMAX) then myStackState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                myStack[myStackTopIndex] = NULL
                dec myStackTopIndex
                operationResult = SUCCESS
                if (myStackTopIndex = ZERO)
                    myStackTopIndex = NULL    ` Signal an Empty Stack
                    myStackState = EMPTY      ` Set the Stack Global Stack State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PrintStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = EMPTY)
                Print("Stack Empty")
            else
                for i = 1 to myStackTopIndex
                    print("myStack["+Str(i)+"]: "+Str(myStack[i]))
                next i
            endif
        endcase
    endselect
EndFunction




` ****** QUEUE Operations ********
`global dim myQueue[MY_QUEUEMAX] as integer

Function InitializeQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            myQueueFrontIndex = ZERO
            myQueueRearIndex  = ZERO
        endcase
    endselect
EndFunction


Function IsQueueEmpty(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (myQueueRearIndex = NULL)
                queueState = EMPTY
            else
                queueState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction queueState


Function IsQueueFull(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (myQueueRearIndex = MY_QUEUEMAX)
                queueState = FULL
            else
                queueState = NOT_FULL
            endif
        endcase
    endselect
EndFunction queueState


Function GetQueueFront(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueEmpty(queue) = NOT_EMPTY)
                returnItem = myQueue[myQueueFrontIndex]
            elseif (IsQueueEmpty(queue) = EMPTY)
                returnItem = EMPTY
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnQueue(queue as string, item)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueFull(queue) = NOT_FULL)
                inc myQueueRearIndex
                myQueue[myQueueRearIndex] = item
                operationResult = SUCCESS
                if (myQueueRearIndex = MY_QUEUEMAX) then myQueueState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueEmpty(queue) = NOT_EMPTY)
                myQueue[myQueueFrontIndex] = NULL
                ShiftQueueContentsDown(queue)
                operationResult = SUCCESS
                dec myQueueRearIndex
                if (myQueueRearIndex = ZERO)
                    myQueueRearIndex = NULL   ` Signal and empty queue
                    myQueueState = EMPTY      ` Set the Global Queue State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function ShiftQueueContentsDown(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            for i = 1 to MY_QUEUEMAX -1        ` Since we're copying from the next in line, stop at 1 before last element
                myQueue[i] = myQueue[i+1]
            next i
            myQueue[MY_QUEUEMAX] = NULL
        endcase
    endselect
EndFunction


Function PrintQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
                if (IsQueueEmpty(queue) = EMPTY)
                    Print("Queue Empty")
                else
                    for i = 1 to myQueueRearIndex
                        print("myQueue["+Str(i)+"]: "+Str(myQueue[i]))
                    next i
                endif
        endcase
    endselect
EndFunction






rem *****************************
rem EOF Battleship dfs.agc
rem *****************************

