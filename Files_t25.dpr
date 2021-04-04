{����� ������� A ����� ����� �������� 100�100 �������� �� �������
� �����. ����������, �������� �� ��� ���������}
program Files_t25;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

const
  n=5; {������ �������. ����� ������� ������ ������������,
        �� �� ������������� ������ ������}

var
  Fin: TextFile;
  OK: boolean;
  El,i,j: integer;

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

begin {main}
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);

  writeln('�������� ����:');
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
  writeln('�����:');
  if OK
    then writeln('��, �������� ���������')
    else writeln('���, �� �������� ���������');
  readln;
end.

 