(define (problem rescue-mission-5x5-solvable)
  (:domain rescue-drone-static)
  
  (:objects
    loc-1-1 loc-1-2 loc-1-3 loc-1-4 loc-1-5
    loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-2-5
    loc-3-1 loc-3-2 loc-3-3 loc-3-4 loc-3-5
    loc-4-1 loc-4-2 loc-4-3 loc-4-4 loc-4-5
    loc-5-1 loc-5-2 loc-5-3 loc-5-4 loc-5-5 - location
    drone1 - drone
    person1 person2 person3 - person
    capacity1 capacity2 capacity3 - capacity
  )

  (:init
    ; Set up the 5x5 grid
    (adjacent loc-1-1 loc-1-2) (adjacent loc-1-2 loc-1-1)
    (adjacent loc-1-2 loc-1-3) (adjacent loc-1-3 loc-1-2)
    (adjacent loc-1-3 loc-1-4) (adjacent loc-1-4 loc-1-3)
    (adjacent loc-1-4 loc-1-5) (adjacent loc-1-5 loc-1-4)
    (adjacent loc-2-1 loc-2-2) (adjacent loc-2-2 loc-2-1)
    (adjacent loc-2-2 loc-2-3) (adjacent loc-2-3 loc-2-2)
    (adjacent loc-2-3 loc-2-4) (adjacent loc-2-4 loc-2-3)
    (adjacent loc-2-4 loc-2-5) (adjacent loc-2-5 loc-2-4)
    (adjacent loc-3-1 loc-3-2) (adjacent loc-3-2 loc-3-1)
    (adjacent loc-3-2 loc-3-3) (adjacent loc-3-3 loc-3-2)
    (adjacent loc-3-3 loc-3-4) (adjacent loc-3-4 loc-3-3)
    (adjacent loc-3-4 loc-3-5) (adjacent loc-3-5 loc-3-4)
    (adjacent loc-4-1 loc-4-2) (adjacent loc-4-2 loc-4-1)
    (adjacent loc-4-2 loc-4-3) (adjacent loc-4-3 loc-4-2)
    (adjacent loc-4-3 loc-4-4) (adjacent loc-4-4 loc-4-3)
    (adjacent loc-4-4 loc-4-5) (adjacent loc-4-5 loc-4-4)
    (adjacent loc-5-1 loc-5-2) (adjacent loc-5-2 loc-5-1)
    (adjacent loc-5-2 loc-5-3) (adjacent loc-5-3 loc-5-2)
    (adjacent loc-5-3 loc-5-4) (adjacent loc-5-4 loc-5-3)
    (adjacent loc-5-4 loc-5-5) (adjacent loc-5-5 loc-5-4)
    (adjacent loc-1-1 loc-2-1) (adjacent loc-2-1 loc-1-1)
    (adjacent loc-2-1 loc-3-1) (adjacent loc-3-1 loc-2-1)
    (adjacent loc-3-1 loc-4-1) (adjacent loc-4-1 loc-3-1)
    (adjacent loc-4-1 loc-5-1) (adjacent loc-5-1 loc-4-1)
    (adjacent loc-1-2 loc-2-2) (adjacent loc-2-2 loc-1-2)
    (adjacent loc-2-2 loc-3-2) (adjacent loc-3-2 loc-2-2)
    (adjacent loc-3-2 loc-4-2) (adjacent loc-4-2 loc-3-2)
    (adjacent loc-4-2 loc-5-2) (adjacent loc-5-2 loc-4-2)
    (adjacent loc-1-3 loc-2-3) (adjacent loc-2-3 loc-1-3)
    (adjacent loc-2-3 loc-3-3) (adjacent loc-3-3 loc-2-3)
    (adjacent loc-3-3 loc-4-3) (adjacent loc-4-3 loc-3-3)
    (adjacent loc-4-3 loc-5-3) (adjacent loc-5-3 loc-4-3)
    (adjacent loc-1-4 loc-2-4) (adjacent loc-2-4 loc-1-4)
    (adjacent loc-2-4 loc-3-4) (adjacent loc-3-4 loc-2-4)
    (adjacent loc-3-4 loc-4-4) (adjacent loc-4-4 loc-3-4)
    (adjacent loc-4-4 loc-5-4) (adjacent loc-5-4 loc-4-4)
    (adjacent loc-1-5 loc-2-5) (adjacent loc-2-5 loc-1-5)
    (adjacent loc-2-5 loc-3-5) (adjacent loc-3-5 loc-2-5)
    (adjacent loc-3-5 loc-4-5) (adjacent loc-4-5 loc-3-5)
    (adjacent loc-4-5 loc-5-5) (adjacent loc-5-5 loc-4-5)

    ; Set initial locations
    (drone-location drone1 loc-1-1)
    (person-location person1 loc-2-3)
    (person-location person2 loc-4-2)
    (person-location person3 loc-5-5)
    
    ; Set safe zone
    (safe-zone loc-3-3)
    
    ; Set safe zone capacity
    (safe-zone-has-capacity loc-3-3 capacity1)
    (safe-zone-has-capacity loc-3-3 capacity2)
    (safe-zone-has-capacity loc-3-3 capacity3)
    
    ; Set initial drone state
    (drone-free)
  )

  (:goal (and
    (rescued person1)
    (rescued person2)
    (rescued person3)
  ))
)