(define (problem problema3)
    (:domain robot)
    (:objects
        charging-base video-room room1 room2 room3 room4 room5 - location
        p1 p2 p3 - patient
        t01 t02 t03 t04 t05 t06 t07 t08 t09 t10 t11 t12 t13 t14 t15 - time
        t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 - time
        t31 t32 t33 t34 t35 t36 t37 t38 t39 t40 t41 t42 t43 t44 t45 - time
    )
    (:init
        (current-time t01)

        (robot-at charging-base)

        (maybe-patient-at p1 room1)
        (maybe-patient-at p1 room2)

        (maybe-patient-at p2 room2)
        (maybe-patient-at p2 room3)
        (maybe-patient-at p2 room4)

        (maybe-patient-at p3 room3)

        (search-time p1 t04)
        (call-reservation p1 t07 t10)

        (search-time p2 t12)
        (call-reservation p2 t16 t20)

        (search-time p3 t28)
        (call-reservation p3 t30 t35)
        
        (next-time t01 t02) (next-time t02 t03) (next-time t03 t04) (next-time t04 t05) 
        (next-time t05 t06) (next-time t06 t07) (next-time t07 t08) (next-time t08 t09) 
        (next-time t09 t10) (next-time t10 t11) (next-time t11 t12) (next-time t12 t13) 
        (next-time t13 t14) (next-time t14 t15) (next-time t15 t16) (next-time t16 t17) 
        (next-time t17 t18) (next-time t18 t19) (next-time t19 t20) (next-time t20 t21) 
        (next-time t21 t22) (next-time t22 t23) (next-time t23 t24) (next-time t24 t25) 
        (next-time t25 t26) (next-time t26 t27) (next-time t27 t28) (next-time t28 t29) 
        (next-time t29 t30) (next-time t30 t31) (next-time t31 t32) (next-time t32 t33) 
        (next-time t33 t34) (next-time t34 t35) (next-time t35 t36) (next-time t36 t37) 
        (next-time t37 t38) (next-time t38 t39) (next-time t39 t40) (next-time t40 t41) 
        (next-time t41 t42) (next-time t42 t43) (next-time t43 t44) (next-time t44 t45) 
    )
    (:goal 
        (and
            (completed p1)
            (completed p2)
            (completed p3)
        )
    )
)
