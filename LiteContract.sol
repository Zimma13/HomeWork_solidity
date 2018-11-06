//указываем версию solidity для компилятора
pragma solidity ^0.4.11;


contract MyFirstDapp {
  //Объявляем переменную donator, в которой будет содержаться значение типа адрес
    address public donator;
  //Функция для приема Эфиров
  
    function() payable {
    //присваиваем переменной donator значение адреса того, кто отправил эфир
        donator = msg.sender;
    }
}
