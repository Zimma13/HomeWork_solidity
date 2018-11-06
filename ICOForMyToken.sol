pragma solidity ^0.4.11;


//Объявляем интерфейс токена
interface Token {
    function transfer(address _reciever, uint256 _amount);
}


//Объявляем контракт
contract MyForstSafeICO {

    //Объявляем перемкнную для указания стоимости токена
    uint public buyPrice;

    //Объявляем переменную для хранения токена
    Token public token;

    //Функция инициализации (принимает токен)
    function MyForstSafeICO(Token _token) {

        //Присваиваем токен
        token = _token;

        //Присваиваем стоимость
        buyPrice = 10000;
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
