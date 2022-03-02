// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract Ticketing{
//struct definition 
    struct Event{
        uint8 ticketId;
        string ticketName;
        uint32 amount;
        string eventlocation;
        }
        //maps the key of string to the struct Event.
        mapping(string =>Event) EventDetails;

//creates a new struct with the function addEvent.
        function addEvent(uint8 _td, string memory _tn, uint32 _amount, string memory _el, string calldata eventTitle) external {
            Event storage events = EventDetails[eventTitle]; // equates the Evennt to a mapping with the key of string eventTitle
            events.ticketId = _td;
            events.ticketName = _tn;
            events.amount = _amount;
            events.eventlocation = _el;
        }
        // gets all the structs in an array form using an array of keys.

        function getAllEvent(string[] calldata _et) external view returns (Event[] memory _eventout){
            _eventout = new Event[](_et.length);
            for(uint i=0;i<_et.length;i++){
                _eventout[i]=EventDetails[_et[i]];
            }

        }
        //gets a singular struct using a key
        function getEvent(string calldata _et) external view returns(Event memory g){
            g = EventDetails[_et];
        }
}
