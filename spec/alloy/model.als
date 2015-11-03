open util/boolean
open mts/entities

/*************************************************/
/**                                                  ENTITIES                                                     **/
/*************************************************/

sig Ride {
	owner: one Passenger,
	means: one Taxi,
	from: one Place,
	to: one Place,
}

sig Reservation {
	owner: one Passenger,
	users: some Passenger,
	origin: one Place,
	destination: one Place
}


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
	no r:Reservation | r.owner  in  r.users
}

fact AvailabilityPrinciple {
//	no t: Taxi | t.status = Available   && #(t.passengers) > 5
}

/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/
run show
