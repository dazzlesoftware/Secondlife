default
{
    link_message(integer sender, integer num, string str, key id)
    {
        if (num == 1010) {
            if (str == "Normal") {
                llRemoveInventory("xs_special");
            } else {
	      // add states for specific specails
            }
        }
    }
}

