
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
//ВКМ_Диплом Автор="ТомиловаО.Н." Комментарий="Заполнение Реализации товаров и услуг.", Дата = 22.04.2024{
	//п.2 Создать команду Заполнить
	НоваяКоманда = Команды.Добавить("Заполнить");
	НоваяКоманда.Действие= "Заполнить";
	
	КнопкаФормы = Элементы.Добавить("Заполнить", Тип("КнопкаФормы"),             
		КоманднаяПанель);
	КнопкаФормы.ПоложениеВКоманднойПанели = ПоложениеКнопкиВКоманднойПанели.ВКоманднойПанели;                   
		
	КнопкаФормы.ИмяКоманды = "Заполнить"; 
	КнопкаФормы.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели; 
	
	//Добавить в отбор вид договора Абонентское обслуживание
	ВидыДоговоров = Новый Массив;
	ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровКонтрагентов.Покупатель);
	МассивПараметровВыбора = Новый Массив;
	МассивПараметровВыбора.Добавить(Новый ПараметрВыбора("Отбор.ВидДоговора", ВидыДоговоров));
	НовыеПараметрыВыбора =  Новый ФиксированныйМассив(МассивПараметровВыбора);
	
	Элементы.Договор.ПараметрыВыбора = НовыеПараметрыВыбора;
	
	
//}ВКМ_Диплом 	
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры


&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
//ВКМ_Диплом Автор="ТомиловаО.Н." Комментарий="Заполнение Реализации товаров и услуг.", Дата = 23.04.2024{	 	
	 	ДоговорДокумента = Объект.Договор;
	 	Запрос = Новый Запрос;
	 	Запрос.Текст =
	 		"ВЫБРАТЬ
	 		|	ДоговорыКонтрагентов.ВидДоговора
	 		|ИЗ
	 		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	 		|ГДЕ
	 		|	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
	 		|	И ДоговорыКонтрагентов.Ссылка = &Ссылка";
	 	
	 	Запрос.УстановитьПараметр("ВидДоговора", Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	 	Запрос.УстановитьПараметр("Ссылка", ДоговорДокумента);
	 	
	 	РезультатЗапроса = Запрос.Выполнить();
	 	
		Если НЕ РезультатЗапроса.Пустой() Тогда 
			ДокументОбъект = РеквизитФормыВЗначение("Объект");
			ДокументОбъект.ВыполнитьАвтозаполнение(ДоговорДокумента);
	 	КонецЕсли;	
КонецПроцедуры
//}ВКМ_Диплом

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
