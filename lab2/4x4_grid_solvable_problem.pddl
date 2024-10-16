(define (problem rescue-scenario)
  (:domain rescue-drone-static)

  (:objects
    loc-1-1 loc-1-2 loc-1-3 loc-1-4
    loc-2-1 loc-2-2 loc-2-3 loc-2-4
    loc-3-1 loc-3-2 loc-3-3 loc-3-4
    loc-4-1 loc-4-2 loc-4-3 loc-4-4 - location
    person1 person2 person3 - person
    drone1 - drone
    c1 c2 c3 - capacity  ; Four capacity objects representing the safe zone capacity
  )

  (:init
    ; Adjacency relations for a 4x4 grid
    ; Horizontal adjacencies
    (Adjacent loc-1-1 loc-1-2) (Adjacent loc-1-2 loc-1-1) (Adjacent loc-1-2 loc-1-3) (Adjacent loc-1-3 loc-1-2) (Adjacent loc-1-3 loc-1-4) (Adjacent loc-1-4 loc-1-3)
    (Adjacent loc-2-1 loc-2-2) (Adjacent loc-2-2 loc-2-1) (Adjacent loc-2-2 loc-2-3) (Adjacent loc-2-3 loc-2-2) (Adjacent loc-2-3 loc-2-4) (Adjacent loc-2-4 loc-2-3)
    (Adjacent loc-3-1 loc-3-2) (Adjacent loc-3-2 loc-3-1) (Adjacent loc-3-2 loc-3-3) (Adjacent loc-3-3 loc-3-2) (Adjacent loc-3-3 loc-3-4) (Adjacent loc-3-4 loc-3-3)
    (Adjacent loc-4-1 loc-4-2) (Adjacent loc-4-2 loc-4-1) (Adjacent loc-4-2 loc-4-3) (Adjacent loc-4-3 loc-4-2) (Adjacent loc-4-3 loc-4-4) (Adjacent loc-4-4 loc-4-3)
    ; Vertical adjacencies
    (Adjacent loc-1-1 loc-2-1) (Adjacent loc-2-1 loc-1-1) (Adjacent loc-2-1 loc-3-1) (Adjacent loc-3-1 loc-2-1) (Adjacent loc-3-1 loc-4-1) (Adjacent loc-4-1 loc-3-1)
    (Adjacent loc-1-2 loc-2-2) (Adjacent loc-2-2 loc-1-2) (Adjacent loc-2-2 loc-3-2) (Adjacent loc-3-2 loc-2-2) (Adjacent loc-3-2 loc-4-2) (Adjacent loc-4-2 loc-3-2)
    (Adjacent loc-1-3 loc-2-3) (Adjacent loc-2-3 loc-1-3) (Adjacent loc-2-3 loc-3-3) (Adjacent loc-3-3 loc-2-3) (Adjacent loc-3-3 loc-4-3) (Adjacent loc-4-3 loc-3-3)
    (Adjacent loc-1-4 loc-2-4) (Adjacent loc-2-4 loc-1-4) (Adjacent loc-2-4 loc-3-4) (Adjacent loc-3-4 loc-2-4) (Adjacent loc-3-4 loc-4-4) (Adjacent loc-4-4 loc-3-4)

    ; Initial location of the drone
    (Drone-location drone1 loc-1-1)
    (Drone-free)


    ; Initial locations of people
    (Person-location person1 loc-2-4)
    (Person-location person2 loc-3-2)
    (Person-location person3 loc-1-4)

    ; Everyone is not rescued
    (not (Rescued person1))
    (not (Rescued person2))
    (not (Rescued person3))
    ; Obstacles
    (Obstacle loc-2-3)
    (Obstacle loc-3-3)
    (Obstacle loc-4-4)

    ; Safe zone with initial capacity
    (Safe-zone loc-4-2)
    (Safe-zone-has-capacity loc-4-2 c1)
    (Safe-zone-has-capacity loc-4-2 c2)
    (Safe-zone-has-capacity loc-4-2 c3))

  (:goal
    (and
      (Rescued person1)
      (Rescued person2)
      (Rescued person3))))

