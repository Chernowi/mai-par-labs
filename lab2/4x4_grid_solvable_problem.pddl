(define (problem rescue-scenario)
  (:domain rescue-drone-static)

  (:objects
    loc-1-1 loc-1-2 loc-1-3 loc-1-4
    loc-2-1 loc-2-2 loc-2-3 loc-2-4
    loc-3-1 loc-3-2 loc-3-3 loc-3-4
    loc-4-1 loc-4-2 loc-4-3 loc-4-4 - location
    person1 person2 person3 - person
    drone1 - drone
    c1 c2 c3 - capacity  ; four capacity objects representing the safe zone capacity
  )

  (:init
    ; adjacency relations for a 4x4 grid
    ; horizontal adjacencies
    (adjacent loc-1-1 loc-1-2) (adjacent loc-1-2 loc-1-1) (adjacent loc-1-2 loc-1-3) (adjacent loc-1-3 loc-1-2) (adjacent loc-1-3 loc-1-4) (adjacent loc-1-4 loc-1-3)
    (adjacent loc-2-1 loc-2-2) (adjacent loc-2-2 loc-2-1) (adjacent loc-2-2 loc-2-3) (adjacent loc-2-3 loc-2-2) (adjacent loc-2-3 loc-2-4) (adjacent loc-2-4 loc-2-3)
    (adjacent loc-3-1 loc-3-2) (adjacent loc-3-2 loc-3-1) (adjacent loc-3-2 loc-3-3) (adjacent loc-3-3 loc-3-2) (adjacent loc-3-3 loc-3-4) (adjacent loc-3-4 loc-3-3)
    (adjacent loc-4-1 loc-4-2) (adjacent loc-4-2 loc-4-1) (adjacent loc-4-2 loc-4-3) (adjacent loc-4-3 loc-4-2) (adjacent loc-4-3 loc-4-4) (adjacent loc-4-4 loc-4-3)
    ; vertical adjacencies
    (adjacent loc-1-1 loc-2-1) (adjacent loc-2-1 loc-1-1) (adjacent loc-2-1 loc-3-1) (adjacent loc-3-1 loc-2-1) (adjacent loc-3-1 loc-4-1) (adjacent loc-4-1 loc-3-1)
    (adjacent loc-1-2 loc-2-2) (adjacent loc-2-2 loc-1-2) (adjacent loc-2-2 loc-3-2) (adjacent loc-3-2 loc-2-2) (adjacent loc-3-2 loc-4-2) (adjacent loc-4-2 loc-3-2)
    (adjacent loc-1-3 loc-2-3) (adjacent loc-2-3 loc-1-3) (adjacent loc-2-3 loc-3-3) (adjacent loc-3-3 loc-2-3) (adjacent loc-3-3 loc-4-3) (adjacent loc-4-3 loc-3-3)
    (adjacent loc-1-4 loc-2-4) (adjacent loc-2-4 loc-1-4) (adjacent loc-2-4 loc-3-4) (adjacent loc-3-4 loc-2-4) (adjacent loc-3-4 loc-4-4) (adjacent loc-4-4 loc-3-4)

    ; initial location of the drone
    (drone-location drone1 loc-1-1)
    (drone-free)


    ; initial locations of people
    (person-location person1 loc-2-4)
    (person-location person2 loc-3-2)
    (person-location person3 loc-1-4)

    ; everyone is not rescued
    (not (rescued person1))
    (not (rescued person2))
    (not (rescued person3))
    ; obstacles
    (obstacle loc-2-3)
    (obstacle loc-3-3)
    (obstacle loc-4-4)

    ; safe zone with initial capacity
    (safe-zone loc-4-2)
    (safe-zone-has-capacity loc-4-2 c1)
    (safe-zone-has-capacity loc-4-2 c2)
    (safe-zone-has-capacity loc-4-2 c3))

  (:goal
    (and
      (rescued person1)
      (rescued person2)
      (rescued person3))))

