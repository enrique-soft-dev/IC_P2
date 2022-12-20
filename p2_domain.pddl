(define (domain waiter)
    (:requirements :typing :negative-preconditions)
    (:types
        location machine client drink - object
    )

    (:predicates
        (robot-at ?loc - location)
        (request ?c - client ?d - drink)
        (produce ?m - machine ?d - drink)
        (located ?m - machine ?loc - location)
        (fetching ?c - client ?d - drink)
        (serving ?c - client ?d - drink)
        (served ?c - client)
        (takes-request)
    )

    (:action take-request
        :parameters (?c - client ?d - drink ?m - machine ?loc - location)
        :precondition 
            (and
                (robot-at bar)
                (request ?c ?d)
                (produce ?m ?d)
                (located ?m ?loc)
                (takes-request)
            )
        :effect 
            (and
                (fetching ?c ?d)
                (not (request ?c ?d))
                (not (takes-request))
            )
    )

    (:action go-to-place
        :parameters ( ?loc_i ?loc_f - location)
        :precondition 
            (and
                (robot-at ?loc_i)
            )
        :effect 
            (and
                (robot-at ?loc_f)
                (not (robot-at ?loc_i))
            )
    )

    (:action get-drink
        :parameters (?c - client ?d - drink ?m - machine ?loc - location)
        :precondition 
            (and
                (fetching ?c ?d)
                (produce ?m ?d)
                (located ?m ?loc)
                (robot-at ?loc)
            )
        :effect 
            (and
                (not (fetching ?c ?d))
                (serving ?c ?d)
            )
    )

    (:action give-drink
        :parameters (?c - client ?d - drink)
        :precondition 
            (and
                (serving ?c ?d)
                (robot-at bar)
            )
        :effect 
            (and
                (served ?c)
                (takes-request)
                (not (serving ?c ?d))
            )
    )
)
