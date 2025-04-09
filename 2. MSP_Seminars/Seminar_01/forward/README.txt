Forwards analysis is when we start with a precondition 
and we wanna find a postcondition.

For this at the start of the program we write the precondition, smth like this:

method a(x: Int, y: Int) returns (z: Int)
    requires 0 <= x && x <= y && y < 100
    ensures // TODO
{
    //  {0 <= x && x <= y && y < 100}   <--- HERE
    x := y - x
    if (x < 5) {
        y := y + 5
    } else {
        y := x 
    }
}

Next we go through the statements and apply the formula

if we have assigmnet:
    SP(P, x := a) ::= exists x0 :: P[x / x0] && x == a[x / x0]

    this means
    StrogestPostcondition(precondition, assignmentStatement) = 
        = exists x0 :: In preconditii inlocuiesti x cu x0 &&
        && si adauci la preconditii x == cu RightHandSide al assigmnet-ului unde inlocuiesti x cu x0


    de ex 
    SP({0 <= x && x <= y && y < 100}, x := y - x)
    unde preconditia devine
    {0 <= x0 && x0 <= y && y < 100 && x == y - x0}



method a(x: Int, y: Int) returns (z: Int)
    requires 0 <= x && x <= y && y < 100
    ensures // TODO
{
    //  {0 <= x && x <= y && y < 100}   
    x := y - x
    {0 <= x0 && x0 <= y && y < 100 && x == y - x0}    <--- HERE
    if (x < 5) {
        y := y + 5
    } else {
        y := x 
    }
}


    
If we have an if like: [if S1 else S2] we use:
    S1 [] S2 = SP(P && If cond, S1) || SP(P && Else cond, S2) 

    de ex:
    ({0 <= x0 && x0 <= y && y < 100 && x == y - x0 && x < 5}, S1) 
        || ({0 <= x0 && x0 <= y && y < 100 && x == y - x0}, S2)
    care defapt e 
    ({0 <= x0 && x0 <= y && y < 100 && x == y - x0 && x >= 5 && x < 5}, y := y + 5) 
        || ({0 <= x0 && x0 <= y && y < 100 && x == y - x0 && x >= 5}, y := x)
    acuma aplici aia de assigmnet pentru fiecare 
    y devine y0 iar noul y (ala din stg) ramane y
    {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && x < 5 && y := y0 + 5}
        ||  {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && y := x}



method a(x: Int, y: Int) returns (z: Int)
    requires 0 <= x && x <= y && y < 100
    ensures // TODO
{
    //  {0 <= x && x <= y && y < 100}   
    x := y - x
    {0 <= x0 && x0 <= y && y < 100 && x == y - x0}
    if (x < 5) {
        y := y + 5
        // {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && x < 5 && y := y0 + 5}   <--- HERE
    } else {
        y := x 
        // {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && y := x}     <--- HERE
    }
    // {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && x < 5 && y := y0 + 5}    <--- HERE
    //    ||  {0 <= x0 && x0 <= y0 && y0 < 100 && x == y0 - x0 && x >= 5 && y := x}
}


La final daca vrei sa folosesti chestia aia intr-un assert nu poti pt ca nu stie cn is x0 si y0
asa ca poti folosi exists. La mine nu a mers (am incercat vreo 2 ore, i hate it )

Profu a mai zis ca se pot si reduce chestiile alea. Adica in loc de chestia aia imensa, te uiti 
si tu acolo vizual si faci cumva sa scapi de x0 si toate alea :)