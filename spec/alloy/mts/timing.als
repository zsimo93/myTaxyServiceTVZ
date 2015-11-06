module mts/timing

/*
 * Creates a single line of and provides some definitions of time intervals and instants
 * together with basic operations among them.
 *
 * author: Ennio Visconti
 * author: Simone Zocchi
 * author: Khanh Huy Paolo Tran
 */

private open util/boolean

sig TimeInterval{
	start: one Int,
	end: one Int
}

sig TimeInstant extends TimeInterval{}
/** Every TimeInterval which has same starting and ending is a TimeInstant and nothing else is a TimeInstant */
fact { all t: TimeInterval | t.start = t.end <=> t in TimeInstant}

fact  { all t1,t2: TimeInterval | (t1.start = t2.start && t1.end = t2.end) <=> t1 = t2 }

one sig Now in TimeInterval {}
fact { Now.start = 0 && Now.end = 0 }

/** Every TimeInterval must have a positive length **/
fact PositiveLength {
	no t : TimeInterval | t.end < t.start
}

/** Returns true iff intervals overlap **/
pred AreOverlapping[i1: TimeInterval, i2: TimeInterval] {
	i1.start =< i2.end && i2.start =< i1.end
}

/** Returns true iff intervals start at the same time **/
pred StartTogether[i1: TimeInterval, i2: TimeInterval] {
	i1.start = i2.start
}

/** Returns true iff intervals start at the same time **/
pred EndTogether[i1: TimeInterval, i2: TimeInterval] {
	i1.end = i2.end
}

pred show {}

run show for exactly 2 TimeInstant, 4 TimeInterval
