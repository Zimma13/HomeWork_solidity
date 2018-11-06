pragma solidity ^0.4.11;


contract Ownable {
    address public owner;
    event OwnershipTransferred(address indexed previouseOwner, address indexed newOwner);

    function Ownable() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}


contract ZimmaToken is Ownable {

    mapping (address => uint256) public balanceOf;
    address public appContract;

    function ZimmaToken() {
        balanceOf[msg.sender] = 1000000;
    }

    function transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    function setAppContract(address _app) onlyOwner {
        appContract = _app;
    }

    function payment(address _from, uint _value) returns (bool) {
        require(msg.sender == appContract);
        if (balanceOf[_from] >= _value) {
            balanceOf[appContract] += _value;
            balanceOf[_from] -= _value;
            return true;
        } else {
            return false;
        }
    }
}
