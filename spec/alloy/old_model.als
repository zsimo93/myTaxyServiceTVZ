open util/integer
open mts/entities

/*************************************************/
/**                                                  ENTITIES                                                     **/
/*************************************************/
abstract sig Request {
	owner: one Passenger,
	users: some Passenger,
	origin: one Place,
	destination: one Place,
	beginningTime:  one Int,
	endingTime: one  Int
}

fact NoNegativeTime {
	no r:Request | r.beginningTime < 0 || r.endingTime < 0
}

/*
sig Ride {
	owner: one Passenger,
	means: one Taxi,
	from: one Place,
	to: one Place,
}*/




/*************************************************/
/**                                FUNCTIONS & PREDICATES                                         **/
/*************************************************/

// A TaxiDriver Cannot be a Passenger (if is working?!)

// Reservations from the same user must not temporally overlap


pred show() {}

/*************************************************/
/**                                        ASSERTIONS  & FACTS                                        **/
/*************************************************/

//  No reservation can have the same Passenger in both owner and users
fact NoDuplicatePerson {
	no r:Request | r.owner  in  r.users
}

fact TimeConsequency {
	no r:Request | r.beginningTime >= r.endingTime
}

fact AvailabilityPrinciple {
//	no t: Taxi | t.status = Available   && #(t.passengers) > 5
}

/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/


pred NoConcurrentRequests {
	no r1, r2: Request | r1.owner = r2.owner && (r2.beginningTime =< r1.beginningTime && r2.endingTime >= r1.beginningTime)
}

pred DifferentDestination {
	no r: Request | r.origin = r.destination
}


run DifferentDestination for 6 but 1 Taxi, 1 Zone, 3 Place
