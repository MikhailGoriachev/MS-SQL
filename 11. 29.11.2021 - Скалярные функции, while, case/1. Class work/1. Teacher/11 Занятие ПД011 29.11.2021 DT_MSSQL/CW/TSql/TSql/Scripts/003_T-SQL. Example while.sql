 -- ���� ��� ����� ����� A � B (A < B). 
 -- ����� ����� ���� ����� ����� �� A �� B ������������.

 -- round(���������, �������������������)
 -- rand() - ��������� ������������ ����� �� 0 �� 1
declare @a int = 10*rand();
declare @b int  = @a + 10*rand() + 1; 
declare @sum int = 0;

-- ���������� �����
declare @x int = @a;

while @x <= @b begin
    set @sum += @x;    -- ���������� �����
	set @x += 1;       -- ����������� �� �����, ��������� ���������
end;

-- ������������� ������� convert() ��� �������������� ����� � ��������� �������������
print char(10) + char(9) + N'����� ����� ����� �� ' + convert(nvarchar, @a) + N' �� ' + convert(nvarchar, @b)+ 
      N' ������������ ����� ' + convert(nvarchar, @sum);
go