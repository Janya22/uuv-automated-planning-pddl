(define (problem windfarm-mission-1)
    (:domain windfarm-1)

    (:objects
        uuv1 uuv2 - uuv                   ; The UUV vehicles
        ship1 ship2 - ship                 ; The ships
        w1 w2 w3 w4 w5 w6 - waypoint        ; The waypoints
        bay control-center - inship         ;loation inside the ship where the engineer is at
        e1 e2 - engineer                    ;The engineers involved in the mission
    )

    (:init
        (has_sample w5)
        (has_sample w1)

        (ship-at ship1 w2)
        (at uuv1 w2) ;UUV1 is initially at waypoint 2
        (engineer_loc e1 ship1 control-center) ;specifies the 1st engineer location in ship1 initially 

        (ship-at ship2 w3)
        (on-ship uuv2 ship2 e2 bay) ;specifies UUV2 is initially not deployed with engineer on bay
        (engineer_loc e2 ship2 bay) ;specifies the 1st engineer location in ship1 initially

    ;specifies connections between waypoint through which engineer can move
        (connection w1 w2)
        (connection w2 w1)
        (connection w2 w4)
        (connection w2 w3)
        (connection w3 w5)
        (connection w4 w2)
        (connection w5 w3)
        (connection w5 w6)
        (connection w6 w4)

    ;initially memory of uuvs are set to clear
        (memory-clear uuv1)
        (memory-clear uuv2)

    ;specifies the waypoints at which a image/sonar data need to be collected
        (need_image w3)
        (need_image w2)

        (need_scan w4)
        (need_scan w6)
    )

    (:goal
        (and
        ;specifies the uuv and waypoints from which the image/sonar data/sample needs to be collected.
        ;specifies the uuv from which the collected image/sonar data need to be tranmitted and location of the engineer in ship.

            (sonar-collected uuv1 w4)
            (sonar-transmitted uuv1 e1 control-center)
            (sample-collected uuv1 w1)

            (sonar-collected uuv2 w6)
            (sonar-transmitted uuv2 e2 control-center)
            (sample-collected uuv2 w5)

            (image-collected uuv1 w2)
            (image-transmitted uuv1 e1 control-center)

            (image-collected uuv2 w3)
            (image-transmitted uuv2 e2 control-center)

        ;pecifies the uuv from which the collected sample need to be sent to specified ship and location of engineer in ship.

            (sample-sent uuv2 ship2 e2 bay)
            (sample-sent uuv1 ship1 e1 bay)
        )
    )
)
