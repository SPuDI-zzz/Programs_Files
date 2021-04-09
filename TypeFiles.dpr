{Пусть дан файл целых чисел. Сформируйте файл вещественных,
чисел из средних арифметических значений каждой 5-ки идущих
подряд чисел. Последняя группа может быть меньше 5}
program TypeFiles;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

type
  TRec=
  record
    Title: string[50];
    Auth: string[30];
    Date: integer;
  end;
  TFileRec=file of TRec;

var
  FIn,FOut: TextFile;
  FT: TFileRec;
  Rec: TRec;

procedure OpenForRead(var f: TextFile);
  var
    Name: string;
    OK: boolean;
  begin
    write('Введите имя файла: ');
    readln(Name);
    AssignFile(f,Name);
    OK:=FileExists(Name);
    while not OK do
      begin
        write('Файл не существует. Введите имя файла: ');
        readln(Name);
        AssignFile(f,Name);
        OK:=FileExists(Name);
      end; {while not}
    Reset(f);
  end; {OpenForRead}

procedure OpenForWrite(var f: TextFile);
  var
    Name: string;
    OK: boolean;
    c: char;
  begin
    OK:=true;
    repeat
      write('Введите имя файла: ');
      readln(Name);
      AssignFile(f,Name);
      if FileExists(Name)
        then
          begin
            write('Файл уже существует. Перезаписать? (Y-да): ');
            readln(c);
            OK:=c in ['y','Y'];
          end; {if File}
    until OK;
    Rewrite(f);
  end; {OpenForWrite}

procedure CreateTF(var f: TextFile; var ft: TFileRec; var Rec: TRec);
  begin
    OpenForRead(f);
    Assign(ft,'TF.dat');
    Rewrite(ft);
    with Rec do
      while not eof(f) do
        begin
          readln(f,Title);
          readln(f,Auth);
          readln(f,Date);
          write(ft,Rec);
          if not eof(f)
            then readln(f);
        end;
    writeln('Типизированный файл успешно создан');
    CloseFile(f);
    CloseFile(ft);
    writeln;
  end; {CreateTF}

procedure ReadTF(var ft: TFileRec; var Rec: TRec);
  var
    OK: boolean;
    c: char;
  begin
    Assign(ft,'TF.dat');
    Rewrite(ft);
    OK:=true;
    with Rec do
      while OK do
        begin
          writeln('Введите заголовок');
          readln(Title);
          writeln('Введите автора');
          readln(Auth);
          writeln('Введите дату');
          readln(Date);
          write(ft,Rec);
          writeln('Продолжить ввод? Y,y - да');
          readln(c);
          OK:=c in ['Y','y','н','Н']
        end;
    writeln('Типизированный файл успешно создан');
    CloseFile(ft);
    writeln;
  end; {ReadTF}

procedure ViewTF(var ft: TFileRec; var Rec: TRec);
  begin
    Assign(ft,'TF.dat');
    Reset(ft);
    while not eof(ft) do
      begin
        read(ft,Rec);
        with Rec do
          begin
            writeln(Title);
            writeln(Auth);
            writeln(Date);
            writeln;
          end;
      end;
    writeln('Типизированный файл успешно выведен на экран');
    CloseFile(ft);
    writeln;
  end; {ViewTF}

procedure Generate(var f: TextFile; var ft: TFileRec; var Rec: TRec);
  begin
    Assign(ft,'TF.dat');
    Reset(ft);
    OpenForWrite(f);
    while not eof(ft) do
      begin
        read(ft,Rec);
        with Rec do
          begin
            writeln(f,Title);
            writeln(f,Auth);
            writeln(f,Date);
            writeln(f);
          end;
      end;
    writeln('Типизированный файл успешно записан в текстовый файл');
    CloseFile(ft);
    CloseFile(f);
    writeln;
  end; {Generate}

procedure EditTF(var ft: TFileRec; var Rec: TRec);
  var
    Typ,OK: boolean;
    c: char;
    i: integer;
  begin
    writeln('Введите св-во:');
    writeln('Y,y - запись в конец; другое - модифицировать запись');
    readln(c);
    Assign(ft,'TF.dat');
    Reset(ft);
    Typ:=c in ['Y','y','н','Н'];
    OK:=true;
    with Rec do
      case Typ of
        true:
          begin
            Seek(ft,filesize(ft));
            while OK do
              begin
                writeln('Введите заголовок');
                readln(Title);
                writeln('Введите автора');
                readln(Auth);
                writeln('Введите дату');
                readln(Date);
                write(ft,Rec);
                writeln('Продолжить ввод? Y,y - да');
                readln(c);
                OK:=c in ['Y','y','н','Н']
              end;
          end;
        false:
          while OK do
            begin
              writeln('Введите номер записи для редактирования');
              readln(i);
              while (i<1) or (i>FileSize(ft)) do begin
                writeln('Ошибка. Повторите ввод');
                readln(i);
              end;
              Seek(ft,i-1);
              writeln('Введите заголовок');
              readln(Title);
              writeln('Введите автора');
              readln(Auth);
              writeln('Введите дату');
              readln(Date);
              write(ft,Rec);
              writeln('Продолжить редактирование? Y,y - да');
              readln(c);
              OK:=c in ['Y','y','н','Н'];
            end;
      end;
    writeln('Редактирование типизированного файла прошло успешно');
    CloseFile(ft);
    writeln;
  end; {EditTF}

procedure Menu;
  var
    i: integer;
  begin
    i:=0;
    while i<>6 do begin
      writeln('Введите действие');
      writeln('1-создать типизированный файл из текстового;');
      writeln('2-ввести типизированный файл с клавиатуры;');
      writeln('3-просмотр типизированного файла;');
      writeln('4-генерация отчёта в текстовый файл;');
      writeln('5-редактировать типизированный файл;');
      writeln('6-выход.');
      readln(i);
      while (i<1) or (i>6) do
        begin
          writeln('Ошибка. Повторите ввод действия:');
          readln(i);
        end; {while i}
      case i of
        1: CreateTF(FIn,FT,Rec);
        2: ReadTF(FT,Rec);
        3: ViewTF(FT,Rec);
        4: Generate(FOut,FT,Rec);
        5: EditTF(FT,Rec);
        else;
      end;
    end;
  end; {Menu}

begin {main}
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);

  Menu;

end.

 