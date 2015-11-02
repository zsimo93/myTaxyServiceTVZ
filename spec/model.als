open util/boolean

/* Taxi Entity Definition */
sig Taxi {
	seats: set Seat,
	driver: one TaxiDriver,
	available: one Bool,
	location: one Zone
}{
	#seats > 0
}

sig TaxiDriver {
}

sig Passenger {
}

sig Ride{
}

sig Reservation{
}

sig Zone{
}

sig Seat{
}

pred show() {}

run show for 2
