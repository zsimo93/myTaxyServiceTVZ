open mts/entities
open mts/timing

/*************************************************/
/**                                                  DOMAIN                                                      **/
/*************************************************/
sig Request {
	owner: one Passenger,
	users: set Passenger,
	origin: one Place,
	destination: one Place,
	time:  one TimeInstant
}

sig Reservation extends Request {}

fact {all r:Reservation, n:Now | r.time.start >= n.start + 2}

fact {all r1,r2: Request | r1.time = r2.time <=> r1 = r2}

one sig MinTimeSpan extends TimeInterval {} { start = 0 && end = 2 }

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
// R.4.2.2.4.a : No requests overlapping from the same user 
assert NoConcurrentRequests {
	no disj r1, r2: Request |  r1.owner = r2.owner 
		 && (r1.time = r2.time)
}

//
assert RequestNewStandardRide {
}

assert RequestNewSharedRide {}

assert BookNewRide {
	
}

assert LookRidesLog {} //Not checkable... i.e: not consistent with the model


/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/

pred show{}

check NoConcurrentRequests

run show for 6 but 1 Place, 1 Taxi, 3 Passenger, 4 Request
