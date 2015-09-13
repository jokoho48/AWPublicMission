/*
Author: SENSEI

Last modified: 7/22/2014

Description: removes multiple actions

        returns nothing
__________________________________________________________________*/
params ["_obj", "_id"];

{_obj removeAction _x} count _id;
