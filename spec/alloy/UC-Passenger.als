open mts/entities
open mts/timing

//  No reservation can have the same Passenger in both owner and users
fact NoDuplicatePerson {
	no r:Request | r.owner  in  r.users
}

fact DifferentDestination {
	no r: Request | r.origin = r.destination
}

// No requests overlapping from the same user.
/**
* If this assertion is verified, also RequestNewStandardRide and RequestNewSharedRide 
* are verified because they does not need further verifiable requirements 
*/
assert NoConcurrentRequests {
	no disj r1, r2: Request |  r1.owner = r2.owner 
		 && (r1.time = r2.time)
}

assert RequestNewStandardRide {}
assert RequestNewSharedRide {}

//Booking time must be in the future within a month and at least 2 hour from actual time.
assert BookNewRide {
	no r: Reservation | r.time = Now
}

check NoConcurrentRequests
check BookNewRide

