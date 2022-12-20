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
        (call-reservation ?patient - patient ?start_time - time ?end_time - time)
        (call-cancelled ?patient - patient ?time - time)
        (search-time ?patient - patient ?time - time)
        (searching ?patient)
        (occupied)
        (stop-time)
        (can-call ?patient)
        (calling ?patient - patient ?end_time - time)
        (completed ?patient - patient)
    )

    (:action pass-time
        :parameters (?curr_time ?next_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (next-time ?curr_time ?next_time)
            (not (stop-time))
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
            (stop-time)
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
        )
    )
    
    (:action greet-patient
        :parameters (?patient - patient ?greet_time ?start_time ?end_time - time)
        :precondition (and 
            (current-time ?greet_time)
            (robot-at video-room)
            (searching ?patient)
            (next-time ?greet_time ?start_time)
            (call-reservation ?patient ?start_time ?end_time)
        )
        :effect (and 
            (can-call ?patient)
            (not (current-time ?greet_time))
            (current-time ?start_time)
        )
    )
    

    (:action call-family
        :parameters (?patient - patient ?start_time ?end_time - time)
        :precondition (and
            (current-time ?start_time)
            (robot-at video-room)
            (can-call ?patient)
            (call-reservation ?patient ?start_time ?end_time)
            (stop-time)
            (searching ?patient)
        )
        :effect (and 
            (not (can-call ?patient))
            (calling ?patient ?end_time)
            (not (call-reservation ?patient ?start_time ?end_time))
            (not (stop-time))
            (not (searching ?patient))
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
            (stop-time)
        )
    )
    
    
    (:action return-to-base
        :parameters (?patient - patient ?curr_time - time ?loc - location)
        :precondition (and 
            (current-time ?curr_time)
            (robot-at ?loc)
            (stop-time)
            (not (search-time ?patient ?curr_time))
            (occupied)
        )
        :effect (and 
            (not (stop-time))
            (not (robot-at ?loc))
            (robot-at charging-base)
            (not (occupied))
        )
    )

    (:action next-patient
        :parameters (?patient - patient ?curr_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (stop-time)
            (occupied)
            (search-time ?patient ?curr_time)
        )
        :effect (and 
            (not (stop-time))
            (not (occupied))
        )
    )


    (:action cancel-call
        :parameters (?patient - patient ?curr_time ?start_time ?end_time - time)
        :precondition (and 
            (current-time ?curr_time)
            (searching ?patient)
            (call-cancelled ?patient ?curr_time)
            (call-reservation ?patient ?start_time ?end_time)
        )
        :effect (and 
            (completed ?patient)
            (stop-time)
            (not (searching ?patient))
            (not (call-reservation ?patient ?start_time ?end_time))
        )
    )
    
)
