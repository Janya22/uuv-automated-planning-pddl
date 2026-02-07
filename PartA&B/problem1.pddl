(define (problem windfarm-mission-1)
    (:domain windfarm)

;Lists the objects involved in the mission with their objects types
    (:objects
        uuv1 - uuv                   
        ship1 - ship                 
        w1 w2 w3 w4 - waypoint ; Waypoints involved in mission
    )

; Describes the initial state 

    (:init
    ;specifies ship location as w3
        (ship-at ship1 w3)
    ;specifies uuv is initially not deployed and is on ship
        (on-ship uuv1 ship1)

    ;specifies the connection between different waypoints through which the UUV can travel
        (connection w1 w2)
        (connection w2 w3)
        (connection w2 w1)
        (connection w3 w4)
        (connection w4 w3)
        (connection w4 w1)

    ;specifies that memory of uuv is clear initially
        (memory-clear uuv1)
    ;specifies the waypoints at which a image/sonar data need to be collected
        (need_image w3)
        (need_scan w4)
       
    )

;Describes the goal mission
    (:goal
        (and

        ;specifies the uuv and waypoints from which the image/sonar data needs to be collected
        ;specifies the uuv from which the collected image/sonar data need to be tranmitted
            (image-collected uuv1 w3)
            (image-transmitted uuv1)
            (memory-clear uuv1)
            (sonar-collected uuv1 w4)
            (sonar-transmitted uuv1)
            
        )
    )
)
