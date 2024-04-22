
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

//ВКМ_Диплом Автор="ТомиловаО.Н." Комментарий="Работа с заявками клиентов.", Дата = 12.04.2024{
//Проведение документа
	// регистр ВКМ_ВыполненныеКлиентуРаботы
	Движения.ВКМ_ВыполненныеКлиентуРаботы.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДоговорыКонтрагентов.ВКМ_СтоимостьЧасаРаботыСпециалиста,
		|	СУММА(ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.ФактическиПотраченоЧасов) КАК ФактическиПотраченоЧасов,
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка
		|ИЗ
		|	Документ.ВКМ_ОбслуживаниеКлиента.ВыполненныеРаботы КАК ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|		ПО ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор = ДоговорыКонтрагентов.Ссылка
		|ГДЕ
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка = &Ссылка
		|	И ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
		|	И ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Дата
		|		МЕЖДУ ДоговорыКонтрагентов.ВКМ_ДатаНачалаДействияДоговора И ДоговорыКонтрагентов.ВКМ_ДатаОкончанияДействияДоговора
		|СГРУППИРОВАТЬ ПО
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка,
		|	ДоговорыКонтрагентов.ВКМ_СтоимостьЧасаРаботыСпециалиста";
	
	Запрос.УстановитьПараметр("ВидДоговора", Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	 	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Движение = Движения.ВКМ_ВыполненныеКлиентуРаботы.Добавить();
		Движение.Период = Дата;
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Клиент = Клиент;
		Движение.Договор = Договор;
		Движение.КоличествоЧасов = ВыборкаДетальныеЗаписи.ФактическиПотраченоЧасов;
		Движение.СуммаКОплате = ВыборкаДетальныеЗаписи.ФактическиПотраченоЧасов * ВыборкаДетальныеЗаписи.ВКМ_СтоимостьЧасаРаботыСпециалиста;
	КонецЦикла;
	
КонецПроцедуры
// НетологияДиплом}



Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
Если ОбменДанными.Загрузка Тогда
     Возврат;
КонецЕсли;
	
//ВКМ_Диплом Автор="ТомиловаО.Н." Комментарий="Работа с заявками клиентов.", Дата = 18.04.2024{
//п.14 Добавляем в справочник УведомленияТелеграмБоту записи
	Если Не ЭтоНовый() Тогда
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	ВКМ_ОбслуживаниеКлиента.Специалист,
			|	ВКМ_ОбслуживаниеКлиента.ДатаПроведенияРабот,
			|	ВКМ_ОбслуживаниеКлиента.ВремяНачалаРаботПлан
			|ИЗ
			|	Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента
			|ГДЕ
			|	ВКМ_ОбслуживаниеКлиента.Ссылка = &Ссылка";
			
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ДатаРабот = ВыборкаДетальныеЗаписи.ДатаПроведенияРабот;
			ВремяРабот = ВыборкаДетальныеЗаписи.ВремяНачалаРаботПлан;
			СпециалистКомпании = ВыборкаДетальныеЗаписи.Специалист;
		КонецЦикла;
		Если ДатаРабот <> ДатаПроведенияРабот ИЛИ ВремяРабот <> ВремяНачалаРаботПлан ИЛИ СпециалистКомпании <> Специалист Тогда
			НоваяЗапись = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
			НоваяЗапись.ТексСообщения = СтрШаблон("Заявка номер %1 от %2  изменена: Дата работ: %3, время: %4, специалист: %5", Номер, Дата, Формат(ДатаПроведенияРабот,"ДФ=dd.MM.yyyy;"), Формат(ВремяНачалаРаботПлан,"ДЛФ=T;"), Специалист);
			НоваяЗапись.Записать();
		КонецЕсли;
		
	Иначе 
		НоваяЗапись = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
		НоваяЗапись.ТексСообщения = СтрШаблон("Новая заявка от %1: Дата работ: %2, время: %3, специалист: %4", Дата, Формат(ДатаПроведенияРабот,"ДФ=dd.MM.yyyy;"), Формат(ВремяНачалаРаботПлан,"ДЛФ=T;"), Специалист);
		НоваяЗапись.Записать();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
