integer UNITS_OF_FOOD = 168;

integer food_left;

default
{
    state_entry()
    {
        food_left = UNITS_OF_FOOD;
    }
    
    link_message(integer sender, integer number, string str, key id)
    {
        if (number == 100) {
            // its a decrease message
            integer amount = (integer)str;
            
            food_left = food_left - amount;
            
            // do the pie slice thing
            float cut_amount = ((float)food_left / (float)UNITS_OF_FOOD) * 0.95;
            llSetPrimitiveParams([PRIM_TYPE, PRIM_TYPE_CYLINDER, PRIM_HOLE_DEFAULT, <0, cut_amount, 0>, 0.0, <0, 0, 0>, <1.0, 1.0, 0.0>, <0,0,0>]);
        }
    }
}
