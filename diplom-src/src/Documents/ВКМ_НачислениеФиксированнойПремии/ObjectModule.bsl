
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий



Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СформироватьДвижения();
	
КонецПроцедуры
// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвижения()
	
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записывать = Истина;
	
	Для Каждого Строка Из СписокСотрудников Цикл
		Движение = Движения.ВКМ_ДополнительныеНачисления.Добавить();
			Движение.ПериодРегистрации = Дата;
			Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.Премия;
			Движение.ПериодДействияНачало = НачалоМесяца(Дата);
			Движение.ПериодДействияКонец = КонецМесяца(Дата);
			Движение.Сотрудник = Строка.Сотрудник;
			Движение.Результат = Строка.СуммаПремии;
			
			ДвижениеНДФЛ = Движения.ВКМ_Удержания.Добавить();
			ДвижениеНДФЛ.ПериодРегистрации = Дата;
			ДвижениеНДФЛ.ПериодДействияНачало = НачалоМесяца(Дата);
			ДвижениеНДФЛ.ПериодДействияКонец = КонецМесяца(Дата);
			ДвижениеНДФЛ.Сотрудник = Строка.Сотрудник;
			ДвижениеНДФЛ.ВидРасчета = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
			ДвижениеНДФЛ.Результат = Строка.СуммаПремии * 0.13;
			
			ДвижениеСотрудники = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
			ДвижениеСотрудники.Сотрудник = Строка.Сотрудник;
			ДвижениеСотрудники.Сумма = Движение.Результат - ДвижениеНДФЛ.Результат;
			ДвижениеСотрудники.ВидДвижения = ВидДвиженияНакопления.Приход;
			ДвижениеСотрудники.Период = Дата;
			ДвижениеСотрудники.Регистратор = Ссылка;
			

	КонецЦикла;
	
	Движения.ВКМ_ДополнительныеНачисления.Записать();
	Движения.ВКМ_Удержания.Записать();
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записать();
	
КонецПроцедуры


#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
