//Указываем версию Solidity
pragma solidity ^0.4.11;


//Инициализация контракта
contract MyTokenERC20ZMA {

    //Объявляем переменную которая будет названием токена
    string public name;

    //Объявляем переменную в которой будет символ токена
    string public symbol;

    //Объявляем переменную в которой будет число нулей токена
    uint8 public decimals;

    //Объявляем переменную в которой будет храниться общее число токенов
    uint256 public totalSupply;

    //Объявляем мапинг для хранения баланса пользователей
    mapping (address => uint256) public balanseOf;

    //Объявляем маппинг для хранения одобренных транзакций
    mapping (address => mapping (address => uint256)) public allowance;

    //Объявляем эвент для логгирования события перевода токенов
    event Transfer(address from, address to, uint256 value);

    //Объявляем эвент для логгирования события одобрения перевода токенов
    event Approval(address from, address to, uint256 value);

    //Функция инициализации контракта
    function MyTokenERC20ZMA() public {

        //Указываем число нулей
        decimals = 8;

        //Объявляем общее число токенов, которое будет создано при инициализации
        //умнажаем кол-вотокенов на кол-во знаков после запятой
        //фактически работаем с копеками ВСЕГДА
        //10 в степени decimals (** - возведение в степень)
        totalSupply = 1000000 * (10 ** uint256(decimals));

        //"Отправляем" все токены на баланс того, кто инициализировал создание контракта токена
        balanseOf[msg.sender] = totalSupply;

        //Указываем название токена
        name = "ZimmaCoin";

        //Указываем символ токена
        symbol = "ZMC";
    }

    //Функция для перевода токенов (доступная для пользователей чтоб могли отправлять)
    function transfer(address _to, uint256 _value) public {

        //вызов внутренней функции перевода
        _transfer(msg.sender, _to, _value);
    }

    //Функция для перевода "одобренных" токенов
    function transferFrom(address _from, address _to, uint256 _value) public {

        //Проверка что токены были выделены аккаунтом _from для аккаунта _to
        require(_value <= allowance[_from][_to]);

        //Уменьшаем число "одобренных" токенов
        allowance[_from][_to] -= _value;

        //Отправка токенов
        _transfer(_from, _to, _value);
    }

    //Функция для "одобрения" перевода токена
    function approve(address _to, uint256 _value) public {

        //записываем в маппинг чилсо "одобренных" токенов
        allowance[msg.sender][_to] = _value;

        //Вызов эвента для логгирования события одобрения перевода токенов
        Approval(msg.sender, _to, _value);
    }

    //Внутренняя функция для перевода токенов
    function _transfer(address _from, address _to, uint256 _value) internal {

        //проверка на пустой адрес
        require(_to != 0x0);

        //Проверка того, что что отправителю хватает токенов для перевода
        require(balanseOf[_from] >= _value);

        //проверка на переполнение
        require(balanseOf[_to] + _value >= balanseOf[_to]);

        //токены списываются у отправителя
        balanseOf[_from] -= _value;

        //Токены прибавляются получателю
        balanseOf[_to] += _value;

        //Эвент перевода токенов
        Transfer(_from, _to, _value);
    }
}
