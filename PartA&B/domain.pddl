(define (domain windfarm)
    (:requirements :strips :typing :negative-preconditions)

     ; -------------------------------
     ; Types
     ; -------------------------------
     
;Types of objects in the domain
    (:types
        uuv ;represents the unmanned underwater vehicle 
        ship ;represents the ship from which the UUVs are deployed and returns to.
        waypoint ;represents the locations that the UUV can travel through
    )

     ; -------------------------------
     ; Predicates
     ; -------------------------------

;Describes the state of the world
    (:predicates
        (at ?u - uuv ?w - waypoint) ;shows the location the UUV is at
        (image-collected ?u - uuv ?w - waypoint) ;shows that an image is collected by UUV at specific waypoint
        (sonar-collected ?u - uuv ?w - waypoint);shows that sonar data is collected by UUV at specific waypoint
        (sample-collected ?u - uuv ?w - waypoint);shows that a sample is collected by UUV at specific waypoin
        (connection ?w1 - waypoint ?w2 - waypoint);shows the connection between different waypoints/location
        (image-transmitted ?u - uuv);shows that an image is transmitted by UUV
        (sonar-transmitted ?u - uuv);shows that sonar is transmitted by UUV
        (sample-sent ?u - uuv ?sh - ship);shows that sample is sent by UUV to the ship
        (ship-at ?sh - ship ?w - waypoint);shows the location the ship is at
        (on-ship ?u - uuv ?s - ship);shows that the UUV is at the ship and is not deployed
        (storage-full ?s - ship);shows that the storage of ship is full and can not take any more samples
        (memory-clear ?u - uuv);shows that the memory of UUV is clear and it can collect image/sonar data
        (has_sample ?w - waypoint);shows that there is a sample at the specified waypoint
        (need_image ?w - waypoint);shows that an image needs to be taken at the specified waypoint
        (need_scan ?w - waypoint);shows that a sonar data needs to be collected at the specified waypoint
    )


;     ; -------------------------------
;     ; Actions
;     ; -------------------------------

    ; Describe how the state of the world can change.
    ; Each action has parameters, preconditions (only performs action if they are true), and effects.

     ;Deploys uuv from ship at specific location
     ;Preconditions: The UUV is on the ship, and the ship is at the desired waypoint.
     ;Effect: The UUV is now at the specified waypoint and no longer on the ship.

    (:action deploy-uuv
        :parameters (?u - uuv ?sh - ship ?w - waypoint)
        :precondition (and 
            (on-ship ?u ?sh) 
            (ship-at ?sh ?w)
        )
        :effect (and 
            (at ?u ?w) 
            (not (on-ship ?u ?sh))
        )
    )

;Moves UV from 1 waypoint to another.
;Preconditions: The UUV is at correct initial waypoint, and the two waypoints are connected.
;Effect: The UUV is now at the destination waypoint and not at the initial waypoint.

    (:action move
        :parameters (?u - uuv ?w1 - waypoint ?w2 - waypoint)
        :precondition (and 
            (at ?u ?w1)
            (connection ?w1 ?w2)
        )
        :effect (and
            (not (at ?u ?w1))
            (at ?u ?w2)
        )
    )

     ;Take a picture with the UUV at a specific waypoint.

    (:action take-pic
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)
            (memory-clear ?u)
            (need_image ?w)
        )
        :effect (and 
            (image-collected ?u ?w)
            (not (memory-clear ?u))
        )
    )



     ;Perform a sonar scan with the UUV at a specific waypoint.


    (:action sonar-scan
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)
            (memory-clear ?u)
            (need_scan ?w)
            
        )
        :effect (and 
            (sonar-collected ?u ?w)
            (not (memory-clear ?u))
        )
    )


     ;Transmit the image data collected by the UUV.


    (:action transmit-img
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)
            (image-collected ?u ?w)
            (not (memory-clear ?u))
        )
        :effect (and
            (image-transmitted ?u)
            (memory-clear ?u)
        )
    )



     ;Transmit the sonar data collected by the UUV.


    (:action transmit-sonar
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)
            (sonar-collected ?u ?w)
            (not (memory-clear ?u))
        )
        :effect (and 
            (sonar-transmitted ?u)
            (memory-clear ?u)
        )
    )


     ;Collect a sample with the UUV at a specific waypoint.

(:action collect-sample
        :parameters  (?u - uuv ?w - waypoint)
        :precondition (and
            (has_sample ?w) 
            (at ?u ?w)
        )
        :effect (and
            (sample-collected ?u ?w)
        )
    )
    

     ;Return the collected sample from the UUV to a ship.


    (:action return-sample
        :parameters  (?u - uuv ?w - waypoint ?sh - ship ?l - waypoint)
        :precondition (and
            (ship-at ?sh ?l) 
            (at ?u ?l)
            (sample-collected ?u ?w)
            (not(storage-full ?sh))
        )
        :effect (and
            (at ?u ?l)
            (sample-sent ?u ?sh)
            (storage-full ?sh)
            
        )
    )
)
