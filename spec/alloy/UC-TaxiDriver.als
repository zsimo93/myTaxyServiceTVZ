/*
 * Contains definitions for MyTaxyServer logic entities 
 * and provides common operations among them.
 * 
 * author: Ennio Visconti
 * author: Simone Zocchi
 * author: Khanh Huy Paolo Tran
 */
open mts/entities

sig Notification {
	relatedRequest : one Request,
	driver : one TaxiDriver
}

fact  {
	all  n: Notification, r: Request | n.relatedRequest = r <=> 
		(r.relatedRide.means.status = Available)
}

assert AcceptRegularDrive {
	no t: Taxi, n:Notification, r:Request | (t.status = Busy or t.status = Shared) 
									&& n.driver = t.driver 
									&& n.relatedRequest = r
}

assert AcceptSharedDrive {
	no t: Taxi | t.status = Busy // && new Request
}

assert DeclineRide {
	no t:Taxi | t.status = Shared // && new Request
}

assert StartRide {
	no ride: Ride, request: Request | ride.owner not in request.owner  && ride.relatedRequest= request && request.relatedRide=Ride
}

check AcceptRegularDrive

assert FinishRide {
	no t: Taxi | (t.status = Busy or t.status = Shared) // && already Started && don't finish if shared
}
