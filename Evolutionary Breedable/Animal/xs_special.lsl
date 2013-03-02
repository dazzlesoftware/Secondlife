///////////////////////////////////////////////////////////////////////////////
// Evolutionary Breedable - Second Life Breedable Pets
//
// Copyright (C) 2013  Dazzle Software, LLC
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
///////////////////////////////////////////////////////////////////////////////

integer LINK_SPECIAL = 1010;          // xs_special, is str = "Normal", removes script

default
{
    link_message(integer sender, integer num, string str, key id)
    {
        if (num == LINK_SPECIAL) {
            if (str == "Normal") {
                llRemoveInventory("xs_special");
            } else {
                    // add states for specific specails
                }
        }
    }
}