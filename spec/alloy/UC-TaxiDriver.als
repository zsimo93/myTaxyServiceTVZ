





assert AcceptRegularDrive {
	no t: Taxi | (t.status = Busy or t.status = Shared) // && new Request
}

assert AcceptSharedDrive {
	no t: Taxi | t.status = Busy // && new Request
}

assert DeclineRide {
	no t:Taxi | t.status = Shared // && new Request
}

assert StartRide {
	no ride: Ride, request: Request | ride.passenger not in request.passenger
}

assert FinishRide {
	no t: Taxi | (t.status = Busy or t.status = Shared) // && already Started && don't finish if shared
}
