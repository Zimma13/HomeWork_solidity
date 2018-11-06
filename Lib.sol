//Версия солидити
pragma solidity ^0.4.16;

//Объявляем название библиотеки

library SimleSearch {

  //Функция для прохода по массиву
    function searchFor(uint[] storage self, uint _value) returns (uint) {
    //проходим по массиву
        for (uint i = 0; i < self.length; i++) {
        //если нашли число, возвращаем его индекс
            if (self[i] == _value) return i;
        }
        //Если число не нашли - возвращаем uint(-1) ("-1" - это типо nil)
        return uint(-1);
    }
}

//Создаем простой контракт
contract LibTestContract {
  //Указываем что будем использовать библиотекудля массива uint
    using SimleSearch for uint[];
  //Объявляем наш массив
    uint[] public bigArrayOfNumbers;

    //Функция добавления числа в массив
    function addToArray(uint _value) {
        bigArrayOfNumbers.push(_value);
    }

    //Функция замены числа в массиве
    function changeNumberrInArray(uint _numberToChange, uint _number) public {
      //ищем индекс с помощью библиотеки
        uint position = bigArrayOfNumbers.searchFor(_numberToChange);
      //если нашли, заменяем
      //не нашли, добавляем элемент
        if (position == uint(-1)) {
            bigArrayOfNumbers.push(_number)
        } else {
            bigArrayOfNumbers[position] = _number
        }
    }
}
