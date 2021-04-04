{Пусть дан файл целых чисел. Сформируйте файл вещественных,
чисел из средних арифметических значений каждой 5-ки идущих
подряд чисел. Последняя группа может быть меньше 5}
program Files_t15;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

const
  n=5;

type
  TFive=array[1..n] of integer;

var
  Fin,f1: TextFile;
  Five: TFive;
  m: integer; {запоминаем кол-во идущих подряд чисел}

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

function SrArifm(var Five: TFive; m: integer): real;
  var
    i: integer;
  begin
    Result:=0;
    for i:=1 to m do
      Result:=Result+Five[i];
    Result:=Result/m;
  end; {SrArifm}

procedure ReadFile(var f: TextFile; var Five: TFive; var m: integer);
  begin
    m:=0;
    while (not eof(f)) and (m<n) do
      begin
        inc(m);
        read(f,Five[m]);
      end;
  end; {ReadFile}

begin {main}
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);

  writeln('Исходный файл:');
  OpenForRead(Fin);
  writeln('Файл-результат:');
  OpenForWrite(f1);

  while not eof(Fin) do
    begin
      ReadFile(Fin,Five,m);
      write(f1,SrArifm(Five,m):0:2,' ');
    end; {while not}

  Closefile(Fin);
  Closefile(f1);
  writeln;
  writeln('Ответ успешно записан в файл');
  readln;
end.

 