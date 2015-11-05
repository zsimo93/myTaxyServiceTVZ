module mts/entities

/*
 * Contains definitions for MyTaxyServer logic entities 
 * and provides common operations among them.
 * 
 * author: Ennio Visconti
 * author: Simone Zocchi
 * author: Khanh Huy Paolo Tran
 */

private open mts/timing

/*************************************************/
/**                                       TAXI DEFINITIONS                                                  **/
/*************************************************/
abstract sig TaxiStatus {}
one sig Available, Shared, Busy extends TaxiStatus{}

some sig Taxi {
	passengers: some Passenger,
	driver: one TaxiDriver,
	status: one TaxiStatus,
	location: one Place
}

sig Ride {
	owner: one Passenger,
	means: one Taxi,
	from: one Place,
	to: one Place,
	duration: one TimeInterval
}

fact NoConcurrentRidesPerUser { no r1, r2: Ride | AreOverlapping[r1.duration, r2.duration] && r1.owner = r2.owner }

// Domain Properties:
fact DriverUnicity { all t: Taxi | t in t.driver.taxi }

fact MaximumTaxiSeats { no t: Taxi |  #(t.passengers) > 4 }

/*************************************************/
/**                                        USER  DEFINITIONS                                              **/
/*************************************************/
abstract sig User {}

sig TaxiDriver extends User {
	taxi: one Taxi
}

sig Passenger extends User  {
	taxi: lone Taxi
}

// Domain Properties:
fact LoneTaxiForAPassenger {
	no p:Passenger | (p not in p.taxi.passengers)
}

/*************************************************/
/**                                  POSITIONING  DEFINITIONS                                       **/
/*************************************************/
sig Zone {
	places: some Place
}

sig Place {}
