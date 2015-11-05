open mts/entities
open mts/timing

/*************************************************/
/**                                                  DOMAIN                                                      **/
/*************************************************/


//one sig MinTimeSpan extends TimeInterval {} { start = 0 && end = 2 }

//  No reservation can have the same Passenger in both owner and users
fact NoDuplicatePerson {
	no r:Request | r.owner  in  r.users
}

pred DifferentDestination {
	no r: Request | r.origin = r.destination
}


/*************************************************/
/**                                           REQUIREMENTS                                                **/
/*************************************************/
// R.4.2.2.4.a : No requests overlapping from the same user.
assert NoConcurrentRequests {
	no disj r1, r2: Request |  r1.owner = r2.owner 
		 && (r1.time = r2.time)
}

// R.4.2.2.4.b-c , R.4.2.2.5.b-c
assert RequestNewStandardRide {}
assert RequestNewSharedRide {}

//R.4.2.2.6.c : Booking time must be in the future within a month and at least 2 hour from actual time.
assert BookNewRide {
	no r: Reservation | r.time = Now
}

assert LookRidesLog {} //Not checkable... i.e: not consistent with the model


/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/

pred show{}

check BookNewRide

run show
