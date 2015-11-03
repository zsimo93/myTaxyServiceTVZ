open util/boolean

/*************************************************/
/**                                                  ENTITIES                                                     **/
/*************************************************/
abstract sig TaxiStatus {}
one sig Available, Shared, Busy {}

some sig Taxi {
	passengers: some Passenger,
	driver: one TaxiDriver,
	status: one TaxiStatus,
	location: one Place
}

sig Ride{
	owner: one Passenger,
	means: one Taxi,
	from: one Place,
	to: one Place,
}

sig Reservation{
	owner: one Passenger,
	users: some Passenger,
	origin: one Place,
	destination: one Place
}

sig Zone {
	places: some Place
}

sig Place {
}

/*************************************************/
/**                                            USER  ENTITIES                                                **/
/*************************************************/
abstract sig User {}

sig TaxiDriver extends User {
	taxi: one Taxi
}

sig Passenger extends User  {
	taxi: lone Taxi
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

fact MaximumTaxiSeats {
//	no t: Taxi |  #(t.passengers) > 4
}

//  No reservation can have the same Passenger in both owner and users
fact NoDuplicatePerson {
//	no r:Reservation | r.owner  in  r.users
}

fact LoneTaxiForAPassenger {
//	no p:Passenger | (p not in p.taxi.passengers)
}


fact AvailabilityPrinciple {
//	no t: Taxi | t.status = Available   && #(t.passengers) > 5
}

/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/
run show
