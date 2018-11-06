pragma solidity ^0.4.20;


interface AppZimmaToken {
    function payment(address _from, uint value) returns (bool);
}


contract Ownable {
    address public owner;
    event OwnershipTransfered(address indexed previouseOwner, address indexed newOwner);

    function Ownable() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        OwnershipTransfered(owner, newOwner);
        owner = newOwner;
    }
}


contract App is Ownable {

    string public message;
    address public lastDonator;
    AppZimmaToken public token;

    uint public price = 10;

    function App(AppZimmaToken _token) {
        token = _token;
    }

    function setPrice(uint _price) onlyOwner {
        price = _price;
    }

    function setMassage(string _message) returns (bool) {
        if (token.payment(msg.sender, price)) {
            message = _message;
            lastDonator = msg.sender;
            return true;
        } else {
            return false;
        }
    }
}
