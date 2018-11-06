//Указываем версию Solidity
pragma solidity ^0.4.11;


//Инициализация контракта
contract MyTokenERCZZZ {

  //Переменные: Имя токена, символ Токена, кол-во нулей после запятой
    string public name;
    string public symbol;
    uint256 public decimals;

    //Объявляем переменную в которой будет храниться общее число токенов
    uint256 public totalSupply;

    mapping (address => uint256) public balanseOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);

    function MyTokenERCZZZ() public {

        decimals = 8;
        totalSupply = 1000000 * (10 ** uint256(decimals));

        balanseOf[msg.sender] = totalSupply;

        name = "WTF_Coin";
        symbol = "WTF";
    }

    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_value <= allowance[_from][_to]);
        allowance[_from][_to] -= _value;
        _transfer(_from, _to, _value);
    }

    function approve(address _to, uint256 _value) public {
        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value);
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0);
        require(balanseOf[_from] >= _value);
        require(balanseOf[_to] + _value >= balanseOf[_to]);
        balanseOf[_from] -= _value;
        balanseOf[_to] += _value;

        Transfer(_from, _to, _value);
    }
}
