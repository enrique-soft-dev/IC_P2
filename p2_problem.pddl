(define (problem prob1)
    (:domain waiter)
    (:objects
        bar kitchen buffet - location
        kettle coffee_maker - machine
        c1 c2 c3 c4 - client
        tea coffee - drink
    )
    (:init
        (robot-at bar)
        (produce kettle tea)
        (produce coffee_maker coffee)
        (located kettle kitchen)
        (located coffee_maker buffet)

        (request c1 tea)
        (request c2 coffee)
        (request c3 coffee)
        (request c4 tea)
        (takes-request)
    )
    (:goal 
        (and
            (served c1)
            (served c2)
            (served c3)
            (served c4)
        )
    )
)
