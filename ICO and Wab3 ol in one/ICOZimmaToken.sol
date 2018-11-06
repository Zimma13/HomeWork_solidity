pragma solidity ^0.4.11;


//Объявляем интерфейс токена
interface MyFirstERCICO {
    function transfer(address _reciever, uint256 _amount);
}


//Объявляем контракт
contract MyFirstSafeICO {

    //Объявляем перемкнную для указания стоимости токена
    uint public buyPrice;
    //Объявляем переменную для хранения токена
    MyFirstERCICO public token;

    //Функция инициализации (принимает токен)
    function MyFirstSafeICO(MyFirstERCICO _token) {

        //Присваиваем токен
        token = _token;

        //изначальная цена токена
        buyPrice = 1 finney;
    }

    //Функции для прямого перевода эфиров
    function () payable {
        //Вызов внутренней функции
        _buy(msg.sender, msg.value);
    }

    //Функция для вызова
    function buy() payable returns (uint) {

        //Вызов внутренней функции для покупки токенов
        uint tokens = _buy(msg.sender, msg.value);

        //Возвращаем значение
        return tokens;

    }

    //Внутренняя функция
    function _buy(address _sender, uint256 _amount) internal returns (uint) {

        //Расчитываем стоимость
        uint tokens = _amount / buyPrice;

        //Отправляем токены с помощью метода токена
        token.transfer(_sender, tokens);

        //Возвращаем значения
        return tokens;
    }
}
