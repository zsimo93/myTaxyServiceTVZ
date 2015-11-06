open mts/entities


fact  NotificationToAvailable{
	all  n: Notification, r: Request | n.relatedRequest = r <=> 
		(r.relatedRide.means.status = Available)
}

assert AcceptRegularDrive {
	no t: Taxi, n:Notification, r:Request | (t.status = Busy or t.status = Shared) 
		&& n.driver = t.driver && n.relatedRequest = r
}

assert StartRide {
	no ride: Ride, request: Request | ride.owner not in request.owner  
		&& ride.relatedRequest= request && request.relatedRide=Ride
}

check AcceptRegularDrive
check StartRide

