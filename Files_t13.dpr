{����� ��� ���� ����� �����. ����������� ��� �������� �����,
��������� � ��� ��������� �����, ������������ ����.
������������������}
program Files_t13;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

var
  Fin,f1,f2: TextFile;
  i,j: integer;

procedure OpenForRead(var f: TextFile);
  var
    Name: string;
    OK: boolean;
  begin
    write('������� ��� �����: ');
    readln(Name);
    AssignFile(f,Name);
    OK:=FileExists(Name);
    while not OK do
      begin
        write('���� �� ����������. ������� ��� �����: ');
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
      write('������� ��� �����: ');
      readln(Name);
      AssignFile(f,Name);
      if FileExists(Name)
        then
          begin
            write('���� ��� ����������. ������������? (Y-��): ');
            readln(c);
            OK:=c in ['y','Y'];
          end; {if File}
    until OK;
    Rewrite(f);
  end; {OpenForWrite}

begin {main}
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);

  writeln('�������� ����:');
  OpenForRead(Fin);
  writeln('������ ����-���������:');
  OpenForWrite(f1);
  writeln('������ ����-���������:');
  OpenForWrite(f2);

  read(Fin,i);
  write(f1,i,' ');
  while not eof(Fin) do
    begin
      read(Fin,j);
      while (i<j) and not eof(Fin) do
        begin
          write(f1,j,' ');
          i:=j;
          read(Fin,j);
        end;
      write(f2,j,' ');
      read(Fin,i);
      while (j<i) and not eof(Fin) do
        begin
          write(f2,i,' ');
          j:=i;
          read(Fin,i);
        end;
      write(f1,i,' ');
    end;
  Closefile(Fin);
  Closefile(f1);
  Closefile(f2);
  writeln;
  writeln('����� ������� ������� � �����');
  readln;
end.

 