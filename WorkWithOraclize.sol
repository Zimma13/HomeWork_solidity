pragma solidity ^0.4.11;
//подключаем библиотеку для работы с ораклайзером
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract DollarCost is usingOraclize {

  //объявляем переменную для хранения стоимости доллара
    uint public dollarCost;

    //функция в которую отдадут результат
    function __callback(bytes32 myid, string result) {
    //Проверяем, что эту функци вызвал ораклайзер
        if (msg.sender != oraclize_cbAddress()) throw;
    //обновит переменную стоимости доллора
        dollarCost = parseInt(result, 3);
    }

  //Функция вызова ораклайзера
    function updatePrice() public payable {
    //Проверяем хватает ли средств
        if (oraclize_getPrice("URL") > this.balance) {
            //Если средств не хватило - ничего не делае
            return;
        } else {
            //Если средств хватило - отправляем запрос в API
            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHUSD).result.XETHXUSD.c.[0]");
        }
    }
}
