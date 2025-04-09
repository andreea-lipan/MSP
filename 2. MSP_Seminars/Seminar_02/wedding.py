from z3 import *
al, am, ar, bl, bm, br, cl, cm, cr = Bools('al am ar bl bm br cl cm cr')
s = Solver()

# Alice does not sit next to Charlie
s.add( And( Implies( Or(al, ar), Not(cm) ), Implies( am, And( Not(cl), Not(cr)))))

# Alice does not sit on the leftmost chair
s.add( Not(al) )

# Bob does not sit to the right of Charlie

s.add( And( Implies(cl, Not(bm)) , Implies(cm, Not(br)) ) )

# Each person gets a chair
s.add( AtLeast(al, am, ar, 1) )
s.add( AtLeast(bl, bm, br, 1) )
s.add( AtLeast(cl, cm, cr, 1) )

# Every person gets at most one chair
s.add( AtMost(al, am, ar, 1) )
s.add( AtMost(bl, bm, br, 1) )
s.add( AtMost(cl, cm, cr, 1) )


# Every chair gets at most one person
s.add( AtMost(al, bl, cl, 1) )
s.add( AtMost(am, bm, cm, 1) )
s.add( AtMost(ar, br, cr, 1) )


print( s.check() )
