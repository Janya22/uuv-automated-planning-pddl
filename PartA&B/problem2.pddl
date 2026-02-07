(define (problem windfarm-mission-2)
    (:domain windfarm)

    (:objects
        uuv1 - uuv                   ; The UUV vehicle
        ship1 - ship                 ; The ship
        w1 w2 w3 w4 w5 - waypoint       ; Waypoints 
    )

    (:init
    ;specifies uuv is initially not deployed and is on ship
    ;specifies ship location
        (ship-at ship1 w1)
        (on-ship uuv1 ship1)

    ;specifies the location at which sample is present
        (has_sample w1)

    ;specifies the connection between different waypoints through which the UUV can travel
        (connection w1 w2)
        (connection w1 w4)
        (connection w2 w3)
        (connection w3 w5)
        (connection w4 w3)
        (connection w5 w1)

    ;specifies that memory of uuv is clear initially
        (memory-clear uuv1)
    
    ;specifies the waypoints at which a image/sonar data need to be collected
        (need_image w5)
        (need_scan w3)
            
    )

    (:goal
        (and

        ;specifies the uuv and waypoints from which the image/sonar/sample needs to be collected
        ;specifies the uuv from which the collected image/sonar data need to be tranmitted
            (image-collected uuv1 w5)
            (image-transmitted uuv1)
            (sonar-collected uuv1 w3)
            (sonar-transmitted uuv1)
            (sample-collected uuv1 w1)

            ;specifies the uuv from which the collected sample need to be sent to specified ship
            (sample-sent uuv1 ship1)
            
        )
    )
)