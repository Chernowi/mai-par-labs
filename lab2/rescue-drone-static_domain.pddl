(define (domain rescue-drone-static)
  (:requirements :typing :strips :negative-preconditions)

  (:types
    location - object
    person - object
    drone - object
    capacity - object
  )

  (:predicates
    (Drone-location ?d - drone ?loc - location)
    (Person-location ?p - person ?loc - location)
    (Drone-free)
    (Drone-carry ?p - person)
    (Obstacle ?loc - location)
    (Safe-zone ?loc - location)
    (Adjacent ?loc1 ?loc2 - location)
    (Rescued ?p - person)
    (Safe-zone-has-capacity ?loc - location ?c - capacity)
  )

  (:action Move
    :parameters (?dr - drone ?loc1 ?loc2 - location)
    :precondition (and 
                   (Drone-location ?dr ?loc1)
                   (Adjacent ?loc1 ?loc2)
                   (not (Obstacle ?loc2)))
    :effect (and
             (not (Drone-location ?dr ?loc1))
             (Drone-location ?dr ?loc2))
  )

  (:action Pick-up
    :parameters (?dr - drone ?p - person ?loc - location)
    :precondition (and 
                   (Drone-location ?dr ?loc)
                   (Person-location ?p ?loc)
                   (not (Rescued ?p))
                   (Drone-free))
    :effect (and 
             (not (Person-location ?p ?loc))
             (Drone-carry ?p)
             (not (Drone-free)))
  )

  (:action Drop-off
    :parameters (?dr - drone ?p - person ?safe_loc - location ?c - capacity)
    :precondition (and 
                   (Drone-location ?dr ?safe_loc)
                   (not (Rescued ?p))
                   (Safe-zone ?safe_loc)
                   (Drone-carry ?p)
                   (Safe-zone-has-capacity ?safe_loc ?c)
                   (not (Drone-free)))
    :effect (and
             (not (Safe-zone-has-capacity ?safe_loc ?c))
             (Person-location ?p ?safe_loc)
             (not (Drone-carry ?p))
             (Rescued ?p)
             (Drone-free))
  )
)