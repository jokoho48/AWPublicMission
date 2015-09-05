// http://forums.bistudio.com/showthread.php?176691-Making-placed-units-be-editable-for-every-Zeus
params ["_curator", "_placed"];
{
    _x addCuratorEditableObjects [(units _placed),true]
} forEach (allCurators - [_curator]);

nil
