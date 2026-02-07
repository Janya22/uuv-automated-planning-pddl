(define (domain windfarm-1)
    (:requirements :strips :typing :negative-preconditions)

;The domain from Part A&B is extended by adding some additional features to handle the addition of engineer
    (:types
        uuv
        ship
        inship ; Represents different locations within a ship, such as the bay or control center.
        waypoint
        engineer ;Represents engineers that are onboard ships and handle the operations with UUVs.
    )

    (:predicates
        (at ?u - uuv ?w - waypoint)
        (image-collected ?u - uuv ?w - waypoint)
        (sonar-collected ?u - uuv ?w - waypoint)
        (sample-collected ?u - uuv ?w - waypoint)
        (connection ?w1 - waypoint ?w2 - waypoint)
        (image-transmitted ?u - uuv ?e - engineer ?i - inship) ;shows UUV transmits collected image data to an engineer in the ship.
        (sonar-transmitted ?u - uuv ?e - engineer ?i - inship);shows UUV transmits sonar data to an engineer onboard.
        (sample-sent ?u - uuv ?sh - ship ?e - engineer ?i - inship); shows UUV sends a collected sample to the ship, with an engineer on ship.
        (ship-at ?sh - ship ?w - waypoint)
        (on-ship ?u - uuv ?s - ship ?e - engineer ?i - inship) ; shows that the UUV is on ship and not deployed, with an engineer at a specific location on the ship.
        (storage-full ?s - ship)
        (memory-clear ?u - uuv)
        (has_sample ?w - waypoint)
        (need_image ?w - waypoint)
        (need_scan ?w - waypoint)
        (engineer_loc ?e - engineer ?sh - ship ?i - inship) ;shows an Engineer is located in a specific part of the ship (bay or control center).
    )

    (:action deploy-uuv
        :parameters (?u - uuv ?sh - ship ?w - waypoint ?e - engineer ?i - inship) 
        :precondition (and 
            (on-ship ?u ?sh ?e ?i) ; UUV must be on the ship, and the engineer should be in a specified location.
            (ship-at ?sh ?w) ; The ship must be at the designated waypoint.
            (engineer_loc ?e ?sh ?i) ;Engineer is in the correct part of the ship
        )
        :effect (and 
            (at ?u ?w) ; The UUV is deployed and now at the specified waypoint.
            (not (on-ship ?u ?sh ?e ?i)) ; The UUV is not on ship.
        )
    )

    (:action move_UUV
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

    (:action move_engineer
        :parameters (?e - engineer ?i1 - inship ?i2 - inship ?sh - ship)
        :precondition (and
            (engineer_loc ?e ?sh ?i1) ; Engineer is in a specific location on the ship.
        )
        :effect (and
            (not(engineer_loc ?e ?sh ?i1)) ; Engineer is no longer at initial location on ship.
            (engineer_loc ?e ?sh ?i2) ; Engineer is at the new location within the ship.
        )
    )

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

    (:action transmit-img
        :parameters (?u - uuv ?w - waypoint ?e - engineer ?sh - ship ?i - inship)
        :precondition (and
            (at ?u ?w)
            (image-collected ?u ?w)
            (not (memory-clear ?u))
            (engineer_loc ?e ?sh ?i) ;Engineer must be in the specified location in ship to receive the data.
        )
        :effect (and
            (image-transmitted ?u ?e ?i)
            (memory-clear ?u)
        )
    )

    (:action transmit-sonar
        :parameters (?u - uuv ?w - waypoint ?e - engineer ?sh - ship ?i - inship)
        :precondition (and
            (at ?u ?w)
            (sonar-collected ?u ?w)
            (not (memory-clear ?u))
            (engineer_loc ?e ?sh ?i) ;Engineer must be in the specified location in ship to receive the data.
        )
        :effect (and 
            (sonar-transmitted ?u ?e ?i)
            (memory-clear ?u)
        )
    )

    (:action collect-sample
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (has_sample ?w) 
            (at ?u ?w)
        )
        :effect (and
            (sample-collected ?u ?w)
        )
    )

    (:action return-sample
        :parameters (?u - uuv ?w - waypoint ?sh - ship ?l - waypoint ?e - engineer ?i - inship)
        :precondition (and
            (ship-at ?sh ?l) 
            (at ?u ?l)
            (sample-collected ?u ?w)
            (not (storage-full ?sh))
            (engineer_loc ?e ?sh ?i)  ; Engineer is in the correct location in the ship .
        )
        :effect (and
            (sample-sent ?u ?sh ?e ?i)
            (storage-full ?sh)
        )
    )
)
