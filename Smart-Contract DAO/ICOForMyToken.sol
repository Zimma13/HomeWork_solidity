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
    //Переменная для хранения времени
    uint public startTime;
    //Добавляем переменную для стоимости токена
    uint public buyPrice;

    //Функция инициализации (принимает токен)
    function MyForstSafeICO(Token _token) {

        //Присваиваем токен
        token = _token;

        //присваиваем переменной старта время старта
        startTime = now;

        // Каждые 24 часа цена вырастает в 2 раза
        //Указываем значение стоимости токена
        if (now > startTime + 48 hours) {
            buyPrice = 4000;
        } else if (now > startTime + 24 hours) {
            buyPrice = 2000;
        } else {
            buyPrice = 1000;
        }
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
