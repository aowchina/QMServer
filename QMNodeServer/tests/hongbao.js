 var leftSize = 10;
 var leftMoney = 100.0;
 
 function getRandomMoney() {
    if (leftSize == 1) {
        leftSize--;
        return leftMoney;   
    }
    
    var min = 0.01;
    var max = leftMoney / leftSize * 2;
    var money = Math.random() * max;
    money = money <= min ? 0.01 : money;
    money = Math.floor(money*100)/100;

    leftSize--;
    leftMoney-=money;
    
    return money;
}

for (var i=0;i<10;i++) {
    var money = getRandomMoney();
    console.log('money : ' + money + ' => ' + leftMoney + ' : '  + leftSize);
}

