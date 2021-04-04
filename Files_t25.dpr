{Пусть матрица A целых чисел размером 100х100 записана по строкам
в файле. Определите, является ли она единичной}
program Files_t25;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

const
  n=5; {Размер массива. Можно сделать больше фактического,
        но не рекомендуется делать меньше}

var
  Fin: TextFile;
  OK: boolean;
  El,i,j: integer;

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

begin {main}
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);

  writeln('Исходный файл:');
  OpenForRead(Fin);

  OK:=true;
  i:=1;
  while (i<=n) and OK and not eof(Fin) do
    begin
      j:=1;
      while (j<=n) and OK and not eoln(Fin) do
        begin
          read(Fin,El);
          if (i=j) and (El=1)
            then inc(j)
            else
              if (i<>j) and (El=0)
                then inc(j)
                else OK:=false;
        end;
      readln(Fin);
      inc(i)
    end;

  Closefile(Fin);
  writeln;
  writeln('Ответ:');
  if OK
    then writeln('Да, является единичной')
    else writeln('Нет, не является единичной');
  readln;
end.

 