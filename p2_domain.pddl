(define (domain waiter)
    (:requirements :typing :negative-preconditions)
    (:types
        location patient time - object
    )

    (:predicates
        (current-time ?curr_time - time)
        (next-time ?curr_time - time ?next_time - time)
        (robot-at ?loc - location)
        (maybe-patient-at ?patient - patient ?loc - location)
        (announced-patient-at ?patient - patient ?loc - location)
        (call-reservation ?patient - patient ?start_time - time ?end_time - time)
        (search-time ?patient - patient ?time - time)
        (searching ?patient)
        (occupied)
        (call-ended)
        (call-cancelled ?patient - patient ?time - time)
        (can-call ?patient)
        (calling ?patient - patient ?end_time - time)
        (completed ?patient - patient)
    )

    (:action pass-time
        :parameters (?curr_time ?next_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (next-time ?curr_time ?next_time)
            (not (call-ended))
        )
        :effect (and 
            (not (current-time ?curr_time))
            (current-time ?next_time)
        )
    )

    (:action search-patient
        :parameters (?patient - patient ?curr_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (search-time ?patient ?curr_time)
            (not (occupied))
        )
        :effect (and 
            (searching ?patient)
            (not (search-time ?patient ?curr_time))
            (occupied)
        )
    )

    (:action go-to-place
        :parameters (?patient - patient ?loc_i ?loc_f - location)
        :precondition 
            (and
                (robot-at ?loc_i)
                (searching ?patient)
            )
        :effect 
            (and
                (robot-at ?loc_f)
                (not (robot-at ?loc_i))
            )
    )

    (:action announce-patient
        :parameters (?patient - patient ?loc - location ?curr_time ?next_time - time)
        :precondition (and
            (current-time ?curr_time)
            (next-time ?curr_time ?next_time)
            (robot-at ?loc)
            (maybe-patient-at ?patient ?loc)
            (searching ?patient)
        )
        :effect (and 
            (not (current-time ?curr_time))
            (current-time ?next_time)
            (not (maybe-patient-at ?patient ?loc))
            (announced-patient-at ?patient ?loc)
        )
    )
    
    (:action greet-patient
        :parameters (?patient - patient ?start_time ?end_time - time)
        :precondition (and 
            (current-time ?start_time)
            (robot-at video-room)
            (searching ?patient)
            (call-reservation ?patient ?start_time ?end_time)
        )
        :effect (and 
            (not (searching ?patient))
            (can-call ?patient)
        )
    )
    

    (:action call-family
        :parameters (?patient - patient ?start_time ?end_time - time)
        :precondition (and
            (current-time ?start_time)
            (robot-at video-room)
            (can-call ?patient)
            (call-reservation ?patient ?start_time ?end_time)
        )
        :effect (and 
            (not (can-call ?patient))
            (calling ?patient ?end_time)
            (not (call-reservation ?patient ?start_time ?end_time))
        )
    )


    (:action end-call
        :parameters (?patient - patient ?curr_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (robot-at video-room)
            (calling ?patient ?curr_time)
        )
        :effect (and 
            (not (calling ?patient ?curr_time))
            (completed ?patient)
            (call-ended)
        )
    )
    
    
    (:action return-to-base
        :parameters (?patient - patient ?curr_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (robot-at video-room)
            (call-ended)
            (not (search-time ?patient ?curr_time))
            (occupied)
        )
        :effect (and 
            (not (call-ended))
            (not (robot-at video-room))
            (robot-at charging-base)
            (not (occupied))
        )
    )

    (:action next-patient
        :parameters (?patient - patient ?curr_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (robot-at video-room)
            (call-ended)
            (occupied)
            (search-time ?patient ?curr_time)
        )
        :effect (and 
            (not (call-ended))
            (not (occupied))
        )
    )
    
)
