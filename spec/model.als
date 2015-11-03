open util/boolean

/*************************************************/
/**                                                  ENTITIES                                                     **/
/*************************************************/
sig Taxi {
	seats: some Seat,
	driver: one TaxiDriver,
	available: one Bool,
	shared: one Bool,
	location: one Zone
}

sig Ride{
	owner: one Passenger,
	means: one Taxi,
	from: one Place,
	to: one Place,
}

sig Reservation{
	users: some Passenger,
	origin: one Zone,
	destination: one Zone
}

sig Zone{
	places: some Place
}

sig Place{
	name: one String
}

sig Seat{}

/*************************************************/
/**                                            USER  ENTITIES                                                **/
/*************************************************/
abstract sig User {}
sig TaxiDriver extends User{
	taxi: one Taxi
}

sig Passenger extends User  {
	taxi: lone Taxi,
	seat: lone Seat
}

sig Administrator extends User {
}

/*************************************************/
/**                                FUNCTIONS & PREDICATES                                         **/
/*************************************************/

fun passengersInTaxi[t:Taxi] : set Passenger {
	//t.seats.
}

// A TaxiDriver Cannot be a Passenger (if is working?!)
// 

pred show() {}

/*************************************************/
/**                                        ASSERTIONS  & FACTS                                        **/
/*************************************************/
fact AvailabilityPrinciple {
	//no t: Taxi | t.available = True & (t.seats = 
}

/*************************************************/
/**                                               EXECUTION                                                    **/
/*************************************************/
run show for 2
