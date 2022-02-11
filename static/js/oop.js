$( document ).ready(function() {
    var consolePrintFirstSymbol = "_";
    var consolePrintSecondSymbol = "█";
    var secCount = 3;

    var consolePrint = $("#console");

    $(".row2").css({"max-height":$(".row2").get(0).offsetHeight});

    window.addEventListener('resize', () => {
        $(".row2").css({"max-height":$(".row2").get(0).offsetHeight});
    }, false);

    setInterval(() => {
        let html = consolePrint.html();
        let temp = consolePrintFirstSymbol;
        consolePrintFirstSymbol = consolePrintSecondSymbol;
        consolePrintSecondSymbol = temp;
        html = html.replace(consolePrintFirstSymbol, consolePrintSecondSymbol);
        consolePrint.html(html);
    }, 500);

    $("#go").on("click", (e) => {
        e.srcElement.style.backgroundColor = "red";
        e.srcElement.disabled = true;
        let message = "";
        $("#duck-1-go").addClass("mark-duck");
        setTimeout(() => {
            message = "[Утка] Не могу выполнить функцию Идти() - нет реализации, потому что Утка - абстрактный класс";
            sendConsole(message);
            $("#duck-1-go").addClass("half");
            $("#duck-2-go").addClass("mark-duck");
            $("#duck-3-go").addClass("mark-duck");
            setTimeout(() => {
                e.srcElement.style.backgroundColor = "rgb(11 15 175)";
                $("#duck-2-go").removeClass("mark-duck");
                $("#duck-3-go").removeClass("mark-duck");
                $("#duck-2-go").addClass("mark-duck-2");
                $("#duck-3-go").addClass("mark-duck-2");
                message = "[РоботУтка] Реализация найдена, выполняю функцию Идти()";
                sendConsole(message);
                message = "[ОбычнаяУтка] Реализация найдена, выполняю функцию Идти()";
                sendConsole(message);
                setTimeout(() => {
                    $("#duck-2-go").addClass("half");
                    $("#duck-3-go").addClass("half");
                    $("#duck-2-go-1").addClass("mark-duck-2");
                    $("#duck-3-go-1").addClass("mark-duck-2");
                    setTimeout(() => {
                        message = "[РоботУтка] Выполняю включение системы бега";
                        sendConsole(message);
                        message = "[ОбычнаяУтка] *топ*";
                        sendConsole(message);
                        $("#duck-2-go-1").removeClass("mark-duck-2");
                        $("#duck-3-go-1").removeClass("mark-duck-2");
                        // setTimeout(() => {
                            $("#duck-2-go-2").addClass("mark-duck-2");
                            $("#duck-3-go-2").addClass("mark-duck-2");
                            setTimeout(() => {
                                message = "[РоботУтка] Произвожу подготовку";
                                sendConsole(message);
                                message = "[ОбычнаяУтка] *топ*";
                                sendConsole(message);
                                $("#duck-2-go-2").removeClass("mark-duck-2");
                                $("#duck-3-go-2").removeClass("mark-duck-2");
                                // setTimeout(() => {
                                    $("#duck-2-go-3").addClass("mark-duck-2");
                                    $("#duck-3-go-3").addClass("mark-duck-2");
                                    setTimeout(() => {
                                        message = "[РоботУтка] Начинаю супер быстро бежать";
                                        sendConsole(message);
                                        message = "[ОбычнаяУтка] *топ*";
                                        sendConsole(message);
                                        $("#duck-2-go-3").removeClass("mark-duck-2");
                                        $("#duck-3-go-3").removeClass("mark-duck-2");
                                        $("#duck-1-go").removeClass("mark-duck");
                                        $("#duck-2-go").removeClass("mark-duck-2");
                                        $("#duck-3-go").removeClass("mark-duck-2");
                                        $("#duck-1-go").removeClass("half");
                                        $("#duck-2-go").removeClass("half");
                                        $("#duck-3-go").removeClass("half");
                                        setTimeout(() => {
                                            message = "[РоботУтка] Функция 'Идти()' выполнена успешно";
                                            sendConsole(message);
                                            message = "[ОбычнаяУтка] Функция 'Идти()' выполнена успешно";
                                            sendConsole(message);
                                            e.srcElement.style.backgroundColor = "";
                                            e.srcElement.disabled = false;
                                        }, 1000 * secCount);
                                    }, 1000 * secCount);
                                // }, 1000 * secCount);
                            }, 1000 * secCount);
                        // }, 1000 * secCount);
                    }, 1000 * secCount);
                }, 1000 * secCount);
            }, 1000 * secCount);
        }, 1000 * secCount);
    });

    $("#attack").on("click", (e) => {
        e.srcElement.style.backgroundColor = "red";
        e.srcElement.disabled = true;
        let message = "";
        $("#duck-1-attack").addClass("mark-duck");
        setTimeout(() => {
            message = "[Утка] Не могу выполнить функцию Атаковать() - нет реализации, потому что Утка - абстрактный класс";
            sendConsole(message);
            $("#duck-1-attack").addClass("half");
            $("#duck-2-attack").addClass("mark-duck");
            $("#duck-3-attack").addClass("mark-duck");
            setTimeout(() => {
                e.srcElement.style.backgroundColor = "rgb(11 15 175)";
                $("#duck-2-attack").removeClass("mark-duck");
                $("#duck-3-attack").removeClass("mark-duck");
                $("#duck-2-attack").addClass("mark-duck-2");
                $("#duck-3-attack").addClass("mark-duck-2");
                message = "[РоботУтка] Реализация найдена, выполняю функцию Атаковать()";
                sendConsole(message);
                message = "[ОбычнаяУтка] Реализация найдена, выполняю функцию Атаковать()";
                sendConsole(message);
                setTimeout(() => {
                    $("#duck-2-attack").addClass("half");
                    $("#duck-3-attack").addClass("half");
                    $("#duck-2-attack-1").addClass("mark-duck-2");
                    $("#duck-3-attack-1").addClass("mark-duck-2");
                    setTimeout(() => {
                        message = "[РоботУтка] Выполнена разработка плана";
                        sendConsole(message);
                        message = "[ОбычнаяУтка] Кря!";
                        sendConsole(message);
                        $("#duck-2-attack-1").removeClass("mark-duck-2");
                        $("#duck-3-attack-1").removeClass("mark-duck-2");
                        // setTimeout(() => {
                            $("#duck-2-attack-2").addClass("mark-duck-2");
                            $("#duck-3-attack-2").addClass("mark-duck-2");
                            setTimeout(() => {
                                message = "[РоботУтка] Производится сбор команды КРЯстителей";
                                sendConsole(message);
                                message = "[ОбычнаяУтка] Кря!";
                                sendConsole(message);
                                $("#duck-2-attack-2").removeClass("mark-duck-2");
                                $("#duck-3-attack-2").removeClass("mark-duck-2");
                                // setTimeout(() => {
                                    $("#duck-2-attack-3").addClass("mark-duck-2");
                                    $("#duck-3-attack-3").addClass("mark-duck-2");
                                    setTimeout(() => {
                                        message = "[РоботУтка] Начинаю атаку супер крутой командой";
                                        sendConsole(message);
                                        message = "[ОбычнаяУтка] Кря!";
                                        sendConsole(message);
                                        $("#duck-2-attack-3").removeClass("mark-duck-2");
                                        $("#duck-3-attack-3").removeClass("mark-duck-2");
                                        $("#duck-1-attack").removeClass("mark-duck");
                                        $("#duck-2-attack").removeClass("mark-duck-2");
                                        $("#duck-3-attack").removeClass("mark-duck-2");
                                        $("#duck-1-attack").removeClass("half");
                                        $("#duck-2-attack").removeClass("half");
                                        $("#duck-3-attack").removeClass("half");
                                        setTimeout(() => {
                                            message = "[РоботУтка] Функция 'Атаковать()' выполнена успешно";
                                            sendConsole(message);
                                            message = "[ОбычнаяУтка] Функция 'Атаковать()' выполнена успешно";
                                            sendConsole(message);
                                            e.srcElement.style.backgroundColor = "";
                                            e.srcElement.disabled = false;
                                        }, 1000 * secCount);
                                    }, 1000 * secCount);
                                // }, 1000 * secCount);
                            }, 1000 * secCount);
                        // }, 1000 * secCount);
                    }, 1000 * secCount);
                }, 1000 * secCount);
            }, 1000 * secCount);
        }, 1000 * secCount);
    });

    function sendConsole(message) {
        let html = consolePrint.html();
        html = html.replace(consolePrintFirstSymbol, "");
        html = html.replace(consolePrintSecondSymbol, "");
        html += "<div>" + message +"</div><br>" + consolePrintFirstSymbol;
        consolePrint.html(html);
        consolePrint.scrollTop(consolePrint.prop('scrollHeight'));
    }
});