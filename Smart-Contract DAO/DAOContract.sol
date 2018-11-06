pragma solidity ^0.4.11;


//Интерфейс токена
interface ChengableToken {
    function stop();
    function start();
    function changeSymbol(string name);
    function balanceOf(address _user) returns (uint256);
}


//Контракт ДАО
contract DAOContract {

    //Переменная для хранения токена
    ChengableToken public token;

    //Минимальное число голосов
    uint minVotes = 6000000;

    //Переменная для хранения предложеного названия
    string public proposalName;

    //Переменная для хранения состояния голосования
    bool public voteActive = false;

    //Структура для голосования
    struct Votes {
        int current;
        uint numberOfVotas;
    }

    //Переменная для структуры голосования
    Votes public election;

    //Функция инициализации (принимает адрес токена)
    function DAOContract(ChengableToken _token) {
        token = _token;
    }

    //Функция для предложения нового символа
    function newName(string _proposalName) public {
        //Проверяем что голосование не идет
        require(!voteActive);
        proposalName = _proposalName;
        voteActive = true;
        //Останавливаем работу токена
        token.stop();
    }

    //Функция для голосования
    function vote(bool _vote) public {
        //Проверяем что голосование идет
        require(voteActive);
        //Логика для голосования
        if (_vote) {
            election.current += int(token.balanceOf(msg.sender));
        } else {
            election.current -= int(token.balanceOf(msg.sender));
        }
        election.numberOfVotas += token.balanceOf(msg.sender);
    }

    //Функция отмены голосования
    function stopVotes(bool _stopVotes) public {
        require(voteActive);

        if (_stopVotes) {
            //Сбрасываем все переменные для голосования
            voteActive = false;
            election.current = 0;
            election.numberOfVotas = 0;
            proposalName = "";
            //Возобнавляем работу токена
            token.start();
        }
    }

    //Функция для смены символа
    function chengeSymbol() public {
        //Проверяем, что голосование активно
        require(voteActive);
        //Проверяем, что голосов достаточно
        require(election.numberOfVotas >= minVotes);
        //Логика для смены символа
        if (election.current > 0) {
            token.changeSymbol(proposalName);
        }
        //Сбрасываем все переменные для голосования
        voteActive = false;
        election.current = 0;
        election.numberOfVotas = 0;
        proposalName = "";
        //Возобнавляем работу токена
        token.start();
    }

}
