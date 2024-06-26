#Область ПрограммныйИнтерфейс
// ВКМ_Диплом Автор="ТомиловаО.Н." Комментарий="Работа с заявками клиентов. Договоры на абон.обслуживание", Дата = 18.04.2024{
Процедура ОтправитьСообщение() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВКМ_УведомленияТелеграмБоту.ТексСообщения,
		|	ВКМ_УведомленияТелеграмБоту.Ссылка
		|ИЗ
		|	Справочник.ВКМ_УведомленияТелеграмБоту КАК ВКМ_УведомленияТелеграмБоту";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
	
		ИдентификаторЧата = Константы.ВКМ_ИдентификаторГруппыДляОповещения.Получить(); // так можно или в запросе нужно?
		ТекстСообщения = ВыборкаДетальныеЗаписи.ТексСообщения;
		//Устанавливаем соединение с сервером
		
		Соединение = Новый HTTPСоединение("api.telegram.org", 443, , , , , Новый ЗащищенноеСоединениеOpenSSL( ) );
		
		Данные = Новый Структура;
		Данные.Вставить("chat_id", ИдентификаторЧата);
		Данные.Вставить("text", ТекстСообщения);
		
		СтрокаJSONN = СтрокаJSON(Данные);
		
		АдресЗапроса = "bot" + Константы.ВКМ_ТокенУправленияТелеграмБотом.Получить() + "/sendMessage";
		HTTPЗапрос = Новый HTTPЗапрос(АдресЗапроса);
		HTTPЗапрос.Заголовки.Вставить("Content-type", "application/json");
		HTTPЗапрос.УстановитьТелоИзСтроки(СтрокаJSONN);
		
		Ответ = Соединение.ОтправитьДляОбработки(HTTPЗапрос);
		
		Если НЕ Ответ.КодСостояния = 200 Тогда
			Ошибка = Ответ.ПолучитьТелоКакСтроку();
			ЗаписьЖурналаРегистрации("HTTPСервисы.Ошибка", УровеньЖурналаРегистрации.Ошибка,,,
				ОбработкаОшибок.ПодробноеПредставлениеОшибки(Ошибка));
		Иначе
			Объект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
			Объект.Удалить();
		КонецЕсли;	
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтрокаJSON(ОбъектJSON) 
	
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, Символы.Таб);
	
	Запись = Новый ЗаписьJSON;
	Запись.УстановитьСтроку(ПараметрыЗаписи);
	ЗаписатьJSON(Запись, ОбъектJSON);
	
	
	Возврат Запись.Закрыть();
	
КонецФункции

#КонецОбласти
//}ВКМ_Диплом