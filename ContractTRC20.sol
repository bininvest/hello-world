перейти к содержанию
Найдите или перейдите к…
тянуть с
вопросы
Кодовые пространства
Торговая площадка
Исследовать
 
@бининвест 
бининвест
/
Z-PAR-D.МОНЕТА
Общественный
Код
вопросы
Пулл-реквесты
1
Действия
Проекты
Вики
Безопасность
Более
Z-PAR-D.МОНЕТА/ ContractTRC20.sol
@бининвест
bininvest Создать ContractTRC20.sol
…
Последний коммит 92695fc 1 hour ago
 История
 1 участник
398 строк (359 слотов)  18,5 КБ

// Лицензия SPDX-идентификатора: MIT

прагмы прочности ^ 0.8.0 ;

импортировать "./ITRC20.sol" ;
импортировать "./extensions/ITRC20Metadata.sol" ;
импортировать "../../utils/Context.sol" ;

/**
* @dev Реализация интерфейса {ITRC20}.
*
* Эта реализация не зависит от создания токенов. Это означает
* что возможность поставки должна быть добавлена ​​в производственный контракт с использованием {_mint}.
* Для общего механизма см. {TRC20PresetMinterPauser}.
*
* СОВЕТ. Подробное описание см. в нашем исследовании.
* https://forum.zeppelin.solutions/t/how-to-implement-TRC20-supply-mechanisms/226[Как
* реализация механизмов снабжения].
*
* Мы следовали общим рекомендациям OpenZeppelin Contracts: функции возвращаются
* вместо возврата `false` в случае ошибки. Тем не менее такое поведение
* обычным и неожиданным ожиданиям TRC20
* Приложения.
*
* Кроме того, при вызове {transferFrom} требуется событие {Approval}.
* Это позволяет приложениям восстанавливать резерв только для всех учетных записей.
* пути регистрации событий. Другие реализации EIP не могут излучать
* эти события, так как это не требуется по признакам.
*
* Наконец, нестандартные {decreaseAllowance} и {increaseAllowance}
* добавлены функции для решения проблем с настройкой
* надбавки. См. {ITRC20-одобрить}.
*/
контракт TRC20 — это Context , ITRC20 , ITRC20Metadata {
    типовые (адрес => uint256 ) частные _балансы;

    похожие ( адрес => похожие ( адрес => uint256 )) private _allowances;

    uint256 частный _totalSupply;

    строка частное _имя;
    строка частный _symbol;

    /**
     * @dev Задает значения {имя} и {символ}.
     *
     * Значение по умолчанию для {decimals} равно 6. Чтобы выбрать другое значение для
     * {десятичные знаки} вы должны перегрузить его.
     *
     * Все эти два являются неизменяемыми значениями: их можно установить только один раз во время
     * строительство.
     */
    конструктор ( имя строковой памяти_ , символ строковой памяти_ ) {
        _имя = имя_;
        _символ = символ_;
    }

    /**
     * @dev Возвращает имя токана.
     */
    имя функции () наблюдательного переопределения публичного представления возвращается ( строковая память ) {   
        вернуть _имя;
    }

    /**
     * @dev Возвращает символ токена, обычно более короткую версию
     * имя.
     */
    символ функции () публичное представление окружающего переопределения возвращается ( строковая память ) {
        вернуть _символ;
    }

    /**
     * @dev Возвращает количество десятичных знаков, использованных для получения пользовательского представления.
     * Например, если «десятичные числа» равны «2», баланс «505» токенов должен
     * присваивается как `5.05` (`505 / 10 ** 2`).
     *
     * Токены обычно выбирают значение 6, имитируя отношения между
     * Эфир и Вэй. Это значение использует {TRC20}, если эта функция не используется.
     * переопределено;
     *
     * ПРИМЕЧАНИЕ. Эта информация используется только для целей _отображения_: она
     * Никоим не встречается на любом арифметическом контракте, в том числе
     * {ITRC20-баланс} и {ITRC20-перевод}.
     */
    функция десятичных знаков () публичное представление окружающего переопределения возвращается ( uint8 ) {
        вернуть 6 ;
    }

    /**
     * @dev См. {ITRC20-общее предложение}.
     */
    функция totalSupply () обнаруживает виртуальное переопределение публичного представления ( uint256 ) {  
        вернуть _totalSupply;
    }

    /**
     * @dev См. {ITRC20-баланс}.
     */
    функция balanceOf ( адрес аккаунта )
        публичный
        Посмотреть
        виртуальный
        отменить
        возвращает ( uint256 )
    {
        вернуть _balances[счет];
    }

    /**
     * @dev См. {ITRC20-перевод}.
     *
     * Требования:
     *
     * - `получатель` не может быть нулевым адресом.
     * - у звонящего должен быть баланс не менее `количества`.
     */
    функция передачи ( адрес получателя , сумма uint256 )
        публичный
        виртуальный
        отменить
        возвращает ( логическое значение )
    {
        _transfer (_msgSender(), получатель, сумма);
        вернуть истину ;
    }

    /**
     * @dev См. {ITRC20-разрешение}.
     */
    функциональная надбавка ( владелец адреса , плательщик адреса )
        публичный
        Посмотреть
        виртуальный
        отменить
        возвращает ( uint256 )
    {
        return _allowances[владелец][спонсор];
    }

    /**
     * @dev См. {ITRC20-одобрить}.
     *
     * Требования:
     *
     * - `транжира` не может быть нулевым адресом.
     */
    функция одобряет ( адрес отправителя , сумма uint256 )
        публичный
        виртуальный
        отменить
        возвращает ( логическое значение )
    {
        _approve(_msgSender(),транжира,сумма);
        вернуть истину ;
    }

    /**
     * @dev См. {ITRC20-transferFrom}.
     *
     * Генерирует событие {Утверждение}, уведомляющее обновленное разрешение. Это не
     * требуется ЭИП. См. примечание в начале {TRC20}.
     *
     * Требования:
     *
     * - `отправитель` и `получатель` не могут быть нулевыми адресами.
     * - `отправитель` должен иметь баланс не менее `суммы`.
     * - у вызывающей стороны должно быть разрешение на токены отправителя не менее
     * `сумма`.
     */
    функция TransferFrom (
        адрес отправителя ,
        адрес получателя ,
         сумма uint256
    ) публичное окружение переопределение возвращает ( bool ) {
        _transfer (отправитель, получатель, сумма);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        Требовать (
            currentAllowance >= сумма,
            «TRC20: сумма перевода предельно допустима»
        );
        снято {
            _approve(sender, _msgSender(), currentAllowance - сумма);
        }

        вернуть истину ;
    }

    /**
     * @dev Атомарно добавляет пособие, предоставленное `расходующему` вызывающему абоненту.
     *
     * Это альтернатива {одобрить}, которую можно использовать для смягчения последствий
     * проблемы, описанные в {ITRC20-одобрить}.
     *
     * Генерирует событие {Утверждение}, уведомляющее обновленное разрешение.
     *
     * Требования:
     *
     * - `транжира` не может быть нулевым адресом.
     */
    функция увеличения разрешений ( расходующий адрес , uint256 addValue )
        публичный
        виртуальный
        возвращает ( логическое значение )
    {
        _одобрить (
            _msgSender(),
            транжира,
            _allowances[ _msgSender()][spender] + добавленное значение
        );
        вернуть истину ;
    }

    /**
     * @dev Атомарно сбор данных, предоставленное `отправителем` вызывающей поток.
     *
     * Это альтернатива {одобрить}, которую можно использовать для смягчения последствий
     * проблемы, описанные в {ITRC20-одобрить}.
     *
     * Генерирует событие {Утверждение}, уведомляющее обновленное разрешение.
     *
     * Требования:
     *
     * - `транжира` не может быть нулевым адресом.
     * - `sender`должен надбавку вызывать вызывающего абонента не менее
     * `вычитанное значение`.
     */
    функция reduceAllowance ( адрес тратящего , uint256 subtractedValue )
        публичный
        виртуальный
        возвращает ( логическое значение )
    {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        Требовать (
            currentAllowance >= subtractedValue,
            «TRC20: снижение надбавки ниже нуля»
        );
        снято {
            _approve(_msgSender(),spender,currentAllowance - subtractedValue);
        }

        вернуть истину ;
    }

    /**
     * @dev Переносит «количество» токенов от «отправителя» к «получателю».
     *
     * Эта внутренняя функция эквивалентна {переводу} и может быть для Российской Федерации
     * например, внедрить автоматическую комиссию по токенам, спасению и т.д. д.
     *
     * Генерирует событие {Transfer}.
     *
     * Требования:
     *
     * - `sender` не может быть нулевым адресом.
     * - `получатель` не может быть нулевым адресом.
     * - `отправитель` должен иметь баланс не менее `суммы`.
     */
    функция _transfer (
        адрес отправителя ,
        адрес получателя ,
         сумма uint256
    ) внутренний виртуальный {
        require (sender != address ( 0 ), "TRC20: перевод с нулевого адреса" );
        require (recipient != address ( 0 ), "TRC20: перевод на нулевой адрес" );

        _beforeTokenTransfer (отправитель, получатель, сумма);

        uint256 senderBalance = _balances[отправитель];
        Требовать (
            senderBalance >= сумма,
            "TRC20: перевод суммы баланса"
        );
        снято {
            _balances[отправитель] = баланс отправителя - сумма;
        }
        _balances[получатель] +=сумма;

        отправить Перевод (отправитель, получатель, сумма);

        _afterTokenTransfer (отправитель, получатель, сумма);
    }

/** @dev Создает токены `amount` и присваивает их `account`, увеличивая
     * общий запас.
     *
     * Генерирует событие {Transfer} с `from`, установленным на нулевой адрес.
     *
     * Требования:
     *
     * - `account` не может быть нулевым адресом.
     */
    функция _mint ( адрес аккаунта , сумма uint256 ) внутренний виртуальный {
        require (account != address ( 0 ), "TRC20: отчеканить до нулевого адреса" );

        _beforeTokenTransfer ( адрес ( 0 ), счет, сумма);

        _totalSupply += сумма;
        _balances[счет] += сумма;
        выдать Перевод ( адрес ( 0 ), счет, сумма);

        _afterTokenTransfer ( адрес ( 0 ), счет, сумма);
    }

    /**
     * @dev Уничтожает токены `amount` из `account`, уменьшение
     * общий запас.
     *
     * Генерирует событие {Transfer} с нулевым адресом для `to`.
     *
     * Требования:
     *
     * - `account` не может быть нулевым адресом.
     * - на `аккаунте` должно быть не меньше `количества` токенов.
     */
    функция _burn ( адрес аккаунта , сумма uint256 ) внутренний виртуальный {
        require (account != address ( 0 ), "TRC20: Потеря с нулевого адреса" );

        _beforeTokenTransfer (счет, адрес ( 0 ), сумма);

        uint256 accountBalance = _balances[счет];
        требуют (accountBalance >= сумма, "TRC20: сумма суммирования баланса" );
        снято {
            _balances[account] = accountBalance - сумма;
        }
        _totalSupply -= сумма;

        выдать Перевод (счет, адрес ( 0 ), сумма);

        _afterTokenTransfer (счет, адрес ( 0 ), сумма);
    }

    /**
     * @dev Устанавливает «сумму» как надбавку «расходующего» к токенам «владельца».
     *
     * Эта внутренняя функция эквивалентна «утверждению» и может быть для Республики
     * например, установить автоматические допуски для выявления подсистем и т. д.
     *
     * Генерирует событие {Одобрение}.
     *
     * Требования:
     *
     * - `владелец` не может быть нулевым адресом.
     * - `транжира` не может быть нулевым адресом.
     */
    функция _одобрить (
         владелец адреса ,
        адрес транжира ,
         сумма uint256
    ) внутренний виртуальный {
        require (владелец != адрес ( 0 ), "TRC20: осмотреть с нулевым адресом" );
        require (spender != address ( 0 ), "TRC20: одобрить нулевой адрес" );

        _allowances[владелец][спонсор] = сумма;
        выдать Одобрение (владелец, плательщик, сумма);
    }

    /**
     * Хук @dev, который вызвался перед любой передачей токенов. Это включает
     * чеканка и оценка.
     *
     * Условия вызова:
     *
     * - когда `от` и `до` непринуждённо, `количество` токенов ``от``
     * будет перенесено в `to`.
     * - когда `от` равно,употреблены токены `количество`, будут отчеканены для `до`.
     * - когда `to` равно, количество токенов будет сожжено.
     * - `от` и `до` никогда не противоречили друг другу.
     *
     * Чтобы узнать больше о хуках, важно по ссылке xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    функция _beforeTokenTransfer (
        адрес из ,
        адрес , _
         сумма uint256
    ) внутренний виртуальный {}

    /**
     * Хук @dev, который вызвался после передачи любых токенов. Это включает
     * чеканка и оценка.
     *
     * Условия вызова:
     *
     * - когда `от` и `до` непринуждённо, `количество` токенов ``от``
     * был передан `в`.
     * - когда `от` равно, потребляемые токены `количество` были отчеканены для `до`.
     * - когда `to` равно,количество токенов ``от`` было сожжено.
     * - `от` и `до` никогда не противоречили друг другу.
     *
     * Чтобы узнать больше о хуках, важно по ссылке xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    функция _afterTokenTransfer (
        адрес из ,
        адрес , _
         сумма uint256
    ) внутренний виртуальный {}
}
Нижний колонтитул
© 2022 GitHub, Inc.
Нижний колонтитул навигации
Условия
Конфиденциальность
Безопасность
Статус
Документы
Связаться с GitHub
Цены
API
Подготовка
Блог
О
Z-PAR-D.COIN/ContractTRC20.sol на bininvest-patch-2 · bininvest/Z-PAR-D.COIN
