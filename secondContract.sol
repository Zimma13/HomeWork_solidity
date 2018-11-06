
//Указываем версию solidity
pragma solidity ^0.4.11;


//Объявляем самрт-контракт
contract SecondContract {

  //Объявляем переменнтую donator, хранащую значение типа адрес
  //Public означает то, что значение этой переменной будет видно всем
    address public donator;

  //Объявляем переменную owner (владелец смарт-контракта), в которой содержиться значение типа Адрес
    address public owner;

  //Объявляем переменную value, в которой будет содержаться значение типа uint (купленное кол-во единец)
    uint public value;

  //Объявляем переменную lastTimeForDonate, в которой будет содержаться значение типа uint
    uint public lastTimeForDonate;

  //Объявляем переменную lastTimeForValue, в которой будет содержаться значение типа uint
    uint public lastTimeForValue;

  //Объявляем переменную timeOut, в которой будет содержаться заранее определенное значение типа uint
    uint timeOut = 120 seconds;

  //Функция инициализации смартконтракта
    function SecondContract() {
      //Присваиваем в owner адресс того, кто задиплоил СК
        owner = msg.sender;
    }

  //Функция для приема эфиров (без названия с модификатором payable
    function() payable {
    //Проверяем, что нам перевели достаточно средств
        require(msg.value > 1 finney);
    //Проверяем, что выполнено условие по времени
        require(lastTimeForDonate + timeOut < now);
    //вызываем внутреннюю функцию значения последнего отправления средств и значение переменной donator
        setDonator(msg.sender);
    }

  //Функция для приема эфиров и установки значение
  //Функция принимает параметр _value в формате uint
  //модификатор payable
    function buyValue(uint _value) payable {
    //Проверяем, что нам перевели достаточно средств
        require(msg.value > 1 finney);
    //Проверяем, что выполнено условие по времени
        require(lastTimeForDonate + timeOut < now);
    //вызываем внутреннюю функцию
        setValue(_value);
    }

  //Внутреннии функции
  //Функцияустановки нового значения
  //модификатор internal означает что функция не доступна вне С-К
    function setValue(uint _value) internal {
    //присваиваем новое значение переменной value
        value = _value;
    //установка нового времени
        lastTimeForValue = now;
    }

  //Функция установки нового адреса donator
  //модификатор internal означает что функция не доступна вне С-К
    function setDonator(address _donator) internal {
    //присваиваем новое значение переменной donator
        donator = _donator;
    //установка нового времени
        lastTimeForDonate = now;
    }

}
