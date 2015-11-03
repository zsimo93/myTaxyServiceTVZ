module mts/entities

/*
 * Contains definitions for MyTaxyServer logic entities 
 * and provides common operations among them.
 * 
 * author: Ennio Visconti
 * author: Simone Zocchi
 * author: Khanh Huy Paolo Tran
 */

/*************************************************/
/**                                       TAXI DEFINITIONS                                                  **/
/*************************************************/
abstract sig TaxiStatus {}
one sig Available, Shared, Busy {}

some sig Taxi {
	passengers: some Passenger,
	driver: one TaxiDriver,
	status: one TaxiStatus,
	location: one Place
}

fact MaximumTaxiSeats {
	no t: Taxi |  #(t.passengers) > 4
}

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
