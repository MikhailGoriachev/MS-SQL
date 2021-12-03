-- ������ 1
-- ���� ��������� ����� ����� �� 1 �� 12
-- ��� ����� ����� ������� �������� ������, ��������� �������� case 
-- � �������������� ���������� 

print char(9) + N'������ 1'
declare @nomMonth int = 1 + 11*rand(); -- ��������� ����� �� 1 �� 12 - ����� ������
declare @nameMonth nvarchar(50) = case @nomMonth
    when  1 then N'������'
	when  2 then N'�������'
	when  3 then N'����'
    when  4 then N'������'
	when  5 then N'���'
	when  6 then N'����'
    when  7 then N'����'
	when  8 then N'������'
	when  9 then N'��������'
    when 10 then N'�������'
	when 11 then N'������'
	when 12 then N'�������'
end;
print char(9) + N'�������� ������ � ������� ' + convert(nvarchar, @nomMonth) + ': ' + @nameMonth;
go

-- ������ 2
-- ��� ���������� ����� � ��������� �� 1 �� 12
-- ��� ������ case � �������� ������� �������� ������� ���� (1, 2, 12 - ��� ����
-- 3, 4, 5 - ��� �����, ...)
declare @nomMonth int = 1 + 11*rand(); -- ��������� ����� �� 1 �� 12 - ����� ������
print char(10) + char(9) + N'������ 2';

declare @nameSeason nvarchar(50) = case 
    when  @nomMonth between 3 and 5 then N'�����'
	when  @nomMonth between 6 and 8 then N'����'
	when  @nomMonth between 9 and 11 then N'�����'
    else N'����'
end;
print char(9) + N'����� ���� ��� ������ � ������� ' + convert(nvarchar, @nomMonth) + ': ' + @nameSeason;
go

-- ������ 3
-- ��� ���������� ����� � ��������� �� 0 �� 23
-- ��� ������ case � �������� ������� �������� ������� �����
--  0 ...  3 ����
--  4 ... 11 ����
-- 12 ... 17 ����
-- 18 ... 23 �����
print char(10) + char(9) + N'������ 3'
declare @nomHour int = 23*rand(); -- ���, ��������� ����� �� 0 �� 23

declare @timesOfDay nvarchar(50) = case 
    when  @nomHour between  0 and  3 then N'����'
	when  @nomHour between  4 and 11 then N'����'
	when  @nomHour between 12 and 17 then N'����'
	when  @nomHour between 18 and 23 then N'�����'
end;

print char(9) + N'����� ����� ��� ���� � ������� ' + convert(nvarchar, @nomHour) + ': ' + @timesOfDay;
go


-- ������ 4
-- �������� ���������� �������� ������ (������ ������, ��������� �������� 
-- �������� ������ "�����",
-- red, green, blue, black), ��� ������ case � �������������� ����������
print char(10) + char(9) + N'������ 5'
declare @enColor nvarchar(20) = N'yet', @ruColor nvarchar(20);

set @ruColor = case @enColor
	when N'red'   then N'�������'
	when N'green' then N'�������'
	when N'blue'  then N'�����'
	when N'black' then N'������'
	else N'�����'
end;

print char(9) + N'����� "' + @enColor + N'" � ���������� ����� ������������� ���� "' + 
      @ruColor + N'" � ������� ����� ';
go