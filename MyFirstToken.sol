//Указываем версию Solidity для компилятора
pragma solidity ^0.4.11;


//Инициализация контракта
contract MyTokenZ {

  //Создаем mapping (Dictionary)
  //ассоциативный массив, в котором ключом будет адресс, а значение баланс
    mapping (address => uint256) public balanceOf;

    //Функция для инициализации контракта (Принимает общее число токенов)
    //в переменную _supply передаем кол-во токинов при диплое
    function MyTokenZ(uint256 _supply) public {
        balanceOf[msg.sender] = _supply;
    }

    //Функция для отправки токенов
    //Функция принимает адресс того, кому нужно отправить токены
    //и число токенов, которое мы хотим отправить
    //Дя использования ее в Mist и кошельке Эфира ее надо называть transfer
    function transfer(address _to, uint256 _value) public {

        //Проверка, хватит ли токенов у того, кто хочет отправить
        require(balanceOf[msg.sender] >= _value);

        //ПРоверяем, не произошло ли переполнение
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        //Забираем токены у того, кто их отправил
        balanceOf[msg.sender] -= _value;

        //Передаем токены тому, кто их должен получить
        balanceOf[_to] += _value;
    }
}
