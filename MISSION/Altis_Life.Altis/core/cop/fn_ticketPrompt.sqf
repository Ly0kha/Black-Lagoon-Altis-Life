/*
	File: fn_ticketPrompt
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Prompts the player that he is being ticketed.
*/
private["_cop","_val","_display","_control"];
if(!isNull (findDisplay 2600)) exitwith {}; //Already at the ticket menu, block for abuse?
_cop = _this select 0;
if(isNull _cop) exitWith {};
_val = _this select 1;

createDialog "life_ticket_pay";
disableSerialization;
waitUntil {!isnull (findDisplay 2600)};
_display = findDisplay 2600;
_control = _display displayCtrl 2601;
life_ticket_paid = false;
life_ticket_val = _val;
life_ticket_cop = _cop;
_control ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>%1 hat dir einen Strafzettel gegeben. Du musst $%2 zahlen.",name _cop,_val];

[] spawn
{
	disableSerialization;
	waitUntil {life_ticket_paid OR (isNull (findDisplay 2600))};
	if(isNull (findDisplay 2600) && !life_ticket_paid) then
	{
		[[0,format["%1 will den Strafzettel nicht bezahlen.",name player]],"life_fnc_broadcast",west,false] spawn life_fnc_MP;
		[[1,format["%1 will den Strafzettel nicht bezahlen.",name player]],"life_fnc_broadcast",life_ticket_cop,false] spawn life_fnc_MP;
	};
};