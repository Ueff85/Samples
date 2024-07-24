codeunit 25028401 Samples
{
    //Переменные Instr - Instream, Outstr - Outstrem, TempBlob - Codeunit - обязательно объявить в глобальной области.

    //>>>>>>>  Оригинальный код
    procedure InitFile()
    var
        Encoding: DotNet Encoding;
    begin
        CompInfo.Get();

        Clear(TempBlob);
        TempBlob.Blob.CreateOutStream(OutputStream);

        StreamWriter := StreamWriter.StreamWriter(OutputStream, Encoding.UTF8);
        StreamWriter.WriteLine('<?xml version="1.0" encoding="utf-8"?>');
        StreamWriter.WriteLine('<DokANKBv2 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"');
        StreamWriter.WriteLine('xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        StreamWriter.WriteLine('<NmrKods>' + CompInfo."Registration No." + '</NmrKods>');
        StreamWriter.WriteLine('<ValdLoc>' + SignEmployeeName + '</ValdLoc>');
        StreamWriter.WriteLine('<GalvGramatv>' + RespEmployeeName + '</GalvGramatv>');
        StreamWriter.WriteLine('<Epasts>' + Format(SignEmployeeMail) + '</Epasts>');
        StreamWriter.WriteLine('<TalrFakss>' + PrepEmployeePhone + '</TalrFakss>');
        StreamWriter.WriteLine('<NmAdrese>' + CompInfo.Address + ' ' + CompInfo."Address 2" + '</NmAdrese>');
        StreamWriter.WriteLine('<Izpilditajs>' + PrepEmployeeName + '</Izpilditajs>');
        StreamWriter.WriteLine('<NmNosaukums>' + CompInfo.Name + ' ' + CompInfo."Name 2" + '</NmNosaukums>');
        StreamWriter.WriteLine('<ParskGads>' + Format(StartDate, 0, '<Year4>') + '</ParskGads>');
        StreamWriter.WriteLine('<ParskMen>' + Format(StartDate, 0, '<Month>') + '</ParskMen>');
        StreamWriter.WriteLine('<Licence>' + CompInfo."Licence No." + '</Licence>');
        StreamWriter.WriteLine('<LicenceDatIzsn>' + FORMAT(CompInfo."Licence Issue Date", 0, 9) + '</LicenceDatIzsn>');
        StreamWriter.WriteLine('<EUVert>' + Format(EUTotalSales, 0, '<Sign><Integer><Decimal><Comma,.>') + '</EUVert>');
        StreamWriter.WriteLine('<ExpVert>' + Format(ExportTotalSales, 0, '<Sign><Integer><Decimal><Comma,.>') + '</ExpVert>');
        StreamWriter.WriteLine('<Tab1>');
        StreamWriter.WriteLine('<Rs>');
    end;
    //<<<<<<<< Оригинальный код

    //>>>>>>>  Измененный код
    procedure InitFile()

    begin
        CompInfo.Get();

        TempBlob.CreateOutStream(OutputStream); // Создаем поток для записи во временный блоб

        OutputStream.WriteText('<?xml version="1.0" encoding="utf-8"?>'); // Записываем в поток начало XML-файла
        OutputStream.WriteText('<DokANKBv2 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"');
        OutputStream.WriteText('xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        OutputStream.WriteText('<NmrKods>' + CompInfo."Registration No." + '</NmrKods>');
        OutputStream.WriteText('<ValdLoc>' + SignEmployeeName + '</ValdLoc>');
        OutputStream.WriteText('<GalvGramatv>' + RespEmployeeName + '</GalvGramatv>');
        OutputStream.WriteText('<Epasts>' + Format(SignEmployeeMail) + '</Epasts>');
        OutputStream.WriteText('<TalrFakss>' + PrepEmployeePhone + '</TalrFakss>');
        OutputStream.WriteText('<NmAdrese>' + CompInfo.Address + ' ' + CompInfo."Address 2" + '</NmAdrese>');
        OutputStream.WriteText('<Izpilditajs>' + PrepEmployeeName + '</Izpilditajs>');
        OutputStream.WriteText('<NmNosaukums>' + CompInfo.Name + ' ' + CompInfo."Name 2" + '</NmNosaukums>');
        OutputStream.WriteText('<ParskGads>' + Format(StartDate, 0, '<Year4>') + '</ParskGads>');
        OutputStream.WriteText('<ParskMen>' + Format(StartDate, 0, '<Month>') + '</ParskMen>');
        OutputStream.WriteText('<Licence>' + CompInfo."Licence No." + '</Licence>');
        OutputStream.WriteText('<LicenceDatIzsn>' + Format(CompInfo."Licence Issue Date", 0, 9) + '</LicenceDatIzsn>');
        OutputStream.WriteText('<EUVert>' + Format(EUTotalSales, 0, '<Sign><Integer><Decimal><Comma,.>') + '</EUVert>');
        OutputStream.WriteText('<ExpVert>' + Format(ExportTotalSales, 0, '<Sign><Integer><Decimal><Comma,.>') + '</ExpVert>');
        OutputStream.WriteText('<Tab1>'); // Записываем в поток начало тега Tab1
        OutputStream.WriteText('<Rs>'); // Записываем в поток начало тега Rs
    end;
    //<<<<<<<< Измененный код


    trigger OnPostDataItem()
    begin
        //>>>>>>>  Оригинальный код
        if SaveToFile then begin
            StreamWriter.Close();
            FileMgt.BLOBExport(TempBlob, StrSubstNo('%1.xml', FileName), true);
        end;
        //<<<<<<<< Оригинальный код

        //>>>>>>>  Измененный код
        if SaveToFile then begin
            TempBlob.CreateInStream(InStr); // Создаем поток для чтения из временного BLOB
            FileName := StrSubstNo('%1.xml', FileName); // Добавляем расширение к имени файла
            DownloadFromStream(InStr, '', '', '', FileName);   // Скачиваем файл
        end;
        //<<<<<<<< Измененный код

    end;
}
