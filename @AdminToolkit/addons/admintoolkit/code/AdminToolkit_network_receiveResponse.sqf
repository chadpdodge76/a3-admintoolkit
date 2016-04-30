/**
 * AdminToolkit
 * 
 * Author: ole1986
 * Website: https://github.com/ole1986/a3-admintoolkit
 *
 * This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
 */
 
private["_request", "_params"];
try 
{
	_request = _this select 0; // what to do
    _params = _this select 1; // mixed value
    
	//systemChat format["[ADMINTOOLKIT]: networkResponse: %1", _request];
    
	switch(_request) do {
		case 'loginok': {
			missionNamespace setVariable ['AdminToolkit_permissionSet', _params];
			systemChat "AdminToolkit READY - Press F2 to open";
		};
		case 'loginfailed': {
			systemChat "AdminToolkit LOGIN FAILED - Check your server config.cpp";
		};
		case 'getplayers': {
			lbClear 1500;
			
			{
				lbAdd [1500, _x];
				lbSetData [1500, (lbSize 1500) - 1, _x];
			} forEach _params;
		};
		case 'specplayer': {
			// get the real player object from its netId
			_params = objectFromNetId _params;
			admintoolkit_specCam = "camera" camCreate (position _params);
			admintoolkit_specCam camSetRelPos [0, -1.5, 1.7];
			admintoolkit_specCam cameraEffect ["internal", "back"];
			admintoolkit_specCam attachTo [_params, [0,-1,1.8]];
			
			systemChat format["Spectating %1", name _params];
		};
        case 'build': {
            // the netId of its vehicle created from the server
            [_params] call AdminToolkit_moveStart;
        };
		case 'godmode': {
			if(_params) then { player allowDamage false; } else { player allowDamage true; };
			systemChat format["Godmode %1", str _params];
		};
	};
}
catch
{
    systemChat format["[ATK-RESPONSE]: EXCEPTION: %1", _exception];
};
