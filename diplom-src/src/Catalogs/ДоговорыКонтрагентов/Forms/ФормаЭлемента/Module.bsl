
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
//НетологияДиплом Автор="ТомиловаО.Н." Комментарий="Работа с заявками клиентов. Договоры на абон.обслуживание", Дата = 09.04.2024{
	//Создать группу формы
	НоваяГруппа = Элементы.Добавить("ГруппаАбонентскоеОбслуживание",Тип("ГруппаФормы"), ЭтотОбъект);
	НоваяГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	НоваяГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
	НоваяГруппа.ОтображатьЗаголовок =Ложь;
	НоваяГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	НоваяГруппа.Видимость = Ложь;
	//Создать элементы формы
	НовыйЭлемент = Элементы.Добавить("ПериодДействияДоговора",Тип("ПолеФормы"), НоваяГруппа);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_ПериодДействияДоговора";
	
	НовыйЭлемент = Элементы.Добавить("ВКМ_СуммаАбонентскойПлаты",Тип("ПолеФормы"), НоваяГруппа);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_СуммаАбонентскойПлаты";
	
	НовыйЭлемент = Элементы.Добавить("ВКМ_СтоимостьЧасаРаботыСпециалиста",Тип("ПолеФормы"), НоваяГруппа);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_СтоимостьЧасаРаботыСпециалиста";
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
//НетологияДиплом}	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидДоговораПриИзменении(Элемент)
	ВидДоговораПриИзмененииНаСервере();
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ВидДоговораПриИзмененииНаСервере()
//НетологияДиплом Автор="ТомиловаО.Н." Комментарий="Работа с заявками клиентов. Договоры на абон.обслуживание", Дата = 09.04.2024{
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		Элементы.ГруппаАбонентскоеОбслуживание.Видимость = Истина;
	Иначе 
		Элементы.ГруппаАбонентскоеОбслуживание.Видимость = Ложь;
	КонецЕсли;
//НетологияДиплом}
КонецПроцедуры
#КонецОбласти
