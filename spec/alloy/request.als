open util/integer
open mts/entities

/*************************************************/
/**                                                  ENTITIES                                                     **/
/*************************************************/
sig Request {
	owner: one Passenger,
	users: set Passenger,
	origin: one Place,
	destination: one Place,
	beginningTime:  one Int,
	endingTime: one  Int
}

/*************************************************/
/**                                        ASSERTIONS  & FACTS                                        **/
/*************************************************/
fact NoNegativeTime {
	no r:Request | r.beginningTime < 0 || r.endingTime < 0
}

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

pred DifferentDestination {
	no r: Request | r.origin = r.destination
}


/*************************************************/
/**                                           REQUIREMENTS                                                **/
/*************************************************/
// R.4.2.2.4.a : No requests overlapping from the same user 
pred NoConcurrentRequests {
	no r1, r2: Request |  r1.owner = r2.owner 
		 && (r2.beginningTime =< r1.beginningTime 
				&& (r2.endingTime >= r1.beginningTime || r2.endingTime = r1.endingTime)
			)
		//&& #Request > 1
}

fact AtLeastOneRequest {
	# Request > 1
}

/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/

pred show{}

run show for 6 but 1 Place, 1 Taxi, 3 Passenger
