(define (problem windfarm-mission-3)
    (:domain windfarm)

    (:objects
        uuv1 uuv2 - uuv                   ; The UUV vehicles
        ship1 ship2 - ship                 ; The ships
        w1 w2 w3 w4 w5 w6 - waypoint        ; The waypoints involved in mission
    )

    (:init
    ;specifies the locations that has the sample
        (has_sample w5)
        (has_sample w1)

    ;specifies the locations of both the ships

        (ship-at ship1 w2)
        (at uuv1 w2) ;initial location of uuv1 is w2
        (ship-at ship2 w3)
        (on-ship uuv2 ship2) ;uuv2 is on ship and not deployes

    ;specifies the connection between different waypoints through which the UUV can travel
        (connection w1 w2)
        (connection w2 w1)
        (connection w2 w4)
        (connection w2 w3)
        (connection w3 w5)
        (connection w4 w2)
        (connection w5 w3)
        (connection w5 w6)
        (connection w6 w4)
        
    ;specifies that memory of uuv is clear initially
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

        ;specifies the uuv and waypoints from which the image/sonar data/sample needs to be collected
        ;specifies the uuv from which the collected image/sonar data need to be tranmitted

            (sonar-collected uuv1 w4)
            (sonar-transmitted uuv1)
            (sample-collected uuv1 w1)

            (sonar-collected uuv2 w6)
            (sonar-transmitted uuv2)
            (sample-collected uuv2 w5)

            (image-collected uuv1 w2)
            (image-transmitted uuv1)

            (image-collected uuv2 w3)
            (image-transmitted uuv2)

        ;specifies the uuv from which the collected sample need to be sent to specified ship

            (sample-sent uuv2 ship2)
            (sample-sent uuv1 ship1)
        )
    )
)       