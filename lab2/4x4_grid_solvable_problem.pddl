(define (problem rescue-scenario)
  (:domain rescue-drone-static)

  (:objects
    loc11 loc12 loc13 loc14
    loc21 loc22 loc23 loc24
    loc31 loc32 loc33 loc34
    loc41 loc42 loc43 loc44 - location
    person1 person2 person3 - person
    drone1 - drone
    c1 c2 c3 - capacity  ; Four capacity objects representing the safe zone capacity
  )

  (:init
    ; Adjacency relations for a 4x4 grid
    ; Horizontal adjacencies
    (Adjacent loc11 loc12) (Adjacent loc12 loc11) (Adjacent loc12 loc13) (Adjacent loc13 loc12) (Adjacent loc13 loc14) (Adjacent loc14 loc13)
    (Adjacent loc21 loc22) (Adjacent loc22 loc21) (Adjacent loc22 loc23) (Adjacent loc23 loc22) (Adjacent loc23 loc24) (Adjacent loc24 loc23)
    (Adjacent loc31 loc32) (Adjacent loc32 loc31) (Adjacent loc32 loc33) (Adjacent loc33 loc32) (Adjacent loc33 loc34) (Adjacent loc34 loc33)
    (Adjacent loc41 loc42) (Adjacent loc42 loc41) (Adjacent loc42 loc43) (Adjacent loc43 loc42) (Adjacent loc43 loc44) (Adjacent loc44 loc43)
    ; Vertical adjacencies
    (Adjacent loc11 loc21) (Adjacent loc21 loc11) (Adjacent loc21 loc31) (Adjacent loc31 loc21) (Adjacent loc31 loc41) (Adjacent loc41 loc31)
    (Adjacent loc12 loc22) (Adjacent loc22 loc12) (Adjacent loc22 loc32) (Adjacent loc32 loc22) (Adjacent loc32 loc42) (Adjacent loc42 loc32)
    (Adjacent loc13 loc23) (Adjacent loc23 loc13) (Adjacent loc23 loc33) (Adjacent loc33 loc23) (Adjacent loc33 loc43) (Adjacent loc43 loc33)
    (Adjacent loc14 loc24) (Adjacent loc24 loc14) (Adjacent loc24 loc34) (Adjacent loc34 loc24) (Adjacent loc34 loc44) (Adjacent loc44 loc34)

    ; Initial location of the drone
    (Drone-location drone1 loc11)
    (Drone-free)


    ; Initial locations of people
    (Person-location person1 loc24)
    (Person-location person2 loc32)
    (Person-location person3 loc14)

    ; Everyone is not rescued
    (not (Rescued person1))
    (not (Rescued person2))
    (not (Rescued person3))
    ; Obstacles
    (Obstacle loc23)
    (Obstacle loc33)
    (Obstacle loc44)

    ; Safe zone with initial capacity
    (Safe-zone loc42)
    (Safe-zone-has-capacity loc42 c1)
    (Safe-zone-has-capacity loc42 c2)
    (Safe-zone-has-capacity loc42 c3))

  (:goal
    (and
      (Rescued person1)
      (Rescued person2)
      (Rescued person3))))
