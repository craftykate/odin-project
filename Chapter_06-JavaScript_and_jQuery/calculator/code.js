// Activate "clear tape" link
$("#tape p.clear").click(function() {
    $("#tape p.tape").html("");
});

// Set height of tape to height of calculator
$("#tape").css({'height':($(".calculator").height()+'px')});

// Reset variables 
var num1 = [],
    num2 = [],
    memnum = null,
    current = null,
    operator = null,
    result = null,
    objDiv = null;

// When a key is pressed 
$(".keys").click(function() {
    var input = $(this).html();
    
    // If it's a number 
    if ($(this).hasClass("num")) {
        if (current === 1 || current === null) {
            num1.push(input);
            current = 1;
            $(".result").html(num1.join(''));
            removeClear();
        }
        if (current === 2) {
            num2.push(input);
            current = 2;
            $(".result").html(num2.join(''));
            removeClear();
        }
        if (current === 0) {
            num2 = [];
            num2.push(input);
            current = 2;
            $(".result").html(num2.join(''));
            removeClear();
        }
        if (current === 3) {
            clear();
            num1.push(input);
            current = 1;
            $(".result").html(num1.join(''));
            removeClear();
        }
    }
    
    // If it's an operator 
    if ($(this).hasClass("operator")) {
        if (num1 !== null) {
            if (current === 0) {
                operator = input;
            }
            if (current === 1) {
                operator = input;
                current = 0;
                $("#tape p.tape").append(num1.join(''));
                objDiv = document.getElementById("tape");
                objDiv.scrollTop = objDiv.scrollHeight;
            }
            if (current === 2) {
                calcResult();
                operator = input;
                current = 0;
                num2 = [];
                $("#tape p.tape").append(num1.join(''));
                objDiv = document.getElementById("tape");
                objDiv.scrollTop = objDiv.scrollHeight;
            }
            if (current === 3) {
                operator = input;
                num2 = [];
                current = 0;
                $("#tape p.tape").append(num1.join(''));
                objDiv = document.getElementById("tape");
                objDiv.scrollTop = objDiv.scrollHeight;
            }
        }
    }
    
    // If it's the equals sign 
    if ($(this).hasClass("equals")) {
        if (num1 !== []) {
            calcResult();
        }
    }
    
    // If it's the clear button 
    if ($(this).hasClass("clear")) {
        if ($(this).hasClass("all")) {
            clear();
        } else {
            if (current === 1) {
                num1 = [];
                $(".result").html(0);
                addClear();
            }
            if (current === 2) {
                num2 = [];
                $(".result").html(0);
                addClear();
            }
        }
    }
    
    // If it's the plus/minus button
    if ($(this).hasClass("pm")) {
        if (current === 1 || current === 3) {
            num1 = [+num1.join('') * -1];
            $(".result").html(num1.join(''));
        }
        if (current === 2) {
            num2 = [+num2.join('') * -1];
            $(".result").html(num2.join(''));
        }
    }
    
    // If it's the percent button 
    if ($(this).hasClass("percent")) {
        if (current === 1 || current === 3) {
            num1 = [num1 / 100];
            $(".result").html(num1.join(''));
        }
        if (current === 2) {
            num2 = [num2 / 100];
            $(".result").html(num2.join(''));
        }
    }
    
    if ($(this).hasClass("madd")) {
        memnum = (memnum === null) ? +$(".result").text() : memnum + +$(".result").text();
        $(".memory").html("m = " + memnum);
    }
    
    if ($(this).hasClass("msub")) {
        if (memnum !== null) {
            memnum = memnum - +$(".result").text();
            $(".memory").html("m = " + memnum);
        }
    }
    
    if ($(this).hasClass("mrec")) {
        if (memnum !== null) {
            $(".result").html(memnum);
            if (current === 1 || current === 3 || current === 0) {
                num1 = [memnum];
            }
            if (current === 2) {
                num2 = [memnum];
            }
        }
    }
    
    if ($(this).hasClass("mclr")) {
        memnum = null;
        $('.memory').html("");
    }
});

// Change behavior of clear button 
function removeClear() {
    $(".calculator .clear").removeClass("all");
    $(".calculator .clear").html("C");
}
function addClear() {
    $(".calculator .clear").addClass("all");
    $(".calculator .clear").html("AC");
}

// Calculate result 
function calcResult() {
    var n1 = +num1.join('');
    if (operator !== null) {
        if (num2 !== []) {
            n2 = +num2.join('');
        }  else {
            n2 = n1;
        }
        switch (operator) {
            case '+':
                result = n1 + n2;
                break;
            case '-':
                result = n1 - n2;
                break;
            case '*':
                result = n1 * n2;
                break;
            case '/':
                result = n1 / n2;
                break;
        }
        $(".result").html(formatNum(result));
        $("#tape p.tape").append(" " + operator + " " + n2 + "<br>= " + formatNum(result) + "<br>");
        objDiv = document.getElementById("tape");
        objDiv.scrollTop = objDiv.scrollHeight;
        num1 = [result];
        num2 = [n2];
        current = 3;
        addClear();
    }
}

// Trim extra zeros, trim too many decimals 
function formatNum(result) {
    return (result % 1 === 0) ? result : parseFloat(result.toFixed(8));
}

// Clear all numbers 
function clear() {
    num1 = [];
    num2 = [];
    operator = null;
    result = null;
    current = null;
    $(".result").html(0);
    $("#tape p.tape").append("<hr>");
    objDiv = document.getElementById("tape");
objDiv.scrollTop = objDiv.scrollHeight;
    addClear();
}