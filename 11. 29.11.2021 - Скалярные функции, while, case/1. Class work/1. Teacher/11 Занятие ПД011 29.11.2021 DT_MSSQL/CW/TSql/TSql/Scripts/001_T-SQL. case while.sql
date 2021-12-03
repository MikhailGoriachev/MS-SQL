-- ����������� ��������� - �����������


/* �������� �������������� ������ � ���������� */
/*
1-� �����, ������������� �������� ��������� � case, ������������� ��������
           ������������� � when
set @�������������1 = case ���������
                       when ���������1 then ��������1
					   when ���������2 then ��������2
					   ...
					   when ���������N then ��������N
					   else ���������������
                   end 
*/
declare @a int
declare @description nvarchar(50)
set @a = 1 + 6*rand();
set @description = case @a
                       when 1 then N'�����'
					   when 2 then N'�������������������'
					   when 3 then N'�����������������'
					   when 4 then N'������'
					   when 5 then N'�������'
					   else N'���������� �����'
                   end;

print char(10) + char(9) + N'������ ' + str(@a, 2) + N' - ��������: ' + @description;
go

-- select surnameNp, case owner when 0 then '������������' when 1 then '��������' end;

/* 2-� �����, ������� � when
set @�������������1 = case 
                       when �������1 then ��������1
					   when �������2 then ��������2
					   ...
					   when �������N then ��������N
					   else ���������������
                   end 
*/
declare @temperature int = -50 + 100*rand();
declare @description1 nvarchar(50)
set @description1 = case
                       when @temperature between -40 and -11  then N'�������...'
                       when @temperature between -10 and   0  then N'�����������...'
					   when @temperature between   1 and  10  then N'���������'
					   when @temperature between  11 and  25  then N'�����'
					   when @temperature between  26 and  35  then N'�����'
					   when @temperature between  36 and  46  then N'������'
					   else N'��� �� �����'
                   end
print char(10) + char(9) + N'����������� ' + str(@temperature, 3) + N' - ��������: ' + @description1;
go

/* 

  �������� ����������
  while ������������������ 
      �����������������

  ����� ���� ��������� �����

  �������� ����������� - �������� ���������� �� ������� �����������
  �����
  continue

  �������� ���������� - ����� �� �������� �����
  break

  �������� ������������ ��������
  goto

  �����:
     ��������1
	 ...
	 ��������N
	 goto �����

*/

--  ������ �� �������� ����������
declare @str nvarchar(80) = N'';

declare @i int = 1 
while @i <= 10 begin
	
    if @i %2 = 0 begin
		set @i += 1;  -- ����� �����, ��� ������ �� �����
		continue;
	end;
	
	if @i = 7 break;

    -- convert(���, ���������) - ������������� �������� ��������� � �������� ���
    set @str += convert(nvarchar, @i) + ' ';
    set @i += 1;
end;	 
print char(10) + char(9) + @str + char(10);
go

-------------------------------------------------
 
-- ������ �� case � ����������� � ����� when 
-- Start:  -- �����, �� ������� �������� ������� �� goto
-- ����� ������� ������ - ������� ���� �����
declare @code   int = 1                -- ��� ����
declare @weight float = 10000*rand()   -- ��� ��� ��������������
declare @kylos  float
declare @k      float;   -- ����������� ��������� ��� ���� � ��

while @code <= 5 begin

    -- ������ �� break - @code > 3 ����� �� ����� 
	-- if @code > 3 break;

	-- ������ �� continue - ���������� ������ ���� ������ ��������� ����
	-- if @code % 2 = 0 begin
	--     set @code += 1
	--    continue
    -- end;
  
    -- ����������� ������������ ��������� � ��
	set @k = case @code 
		when 1 then 1e-6  -- �� � ��
		when 2 then 1e-3  -- � � ��
		when 3 then 1     -- �� � ��, �������������� �� ��������� 
		when 4 then 1e2   -- � � ��
		when 5 then 1e3   -- � � ��
	end;   

	-- �������� ���� � �� 
    set @kylos = @weight * @k;

	-- ��������� �������� ���� ����
	declare @descr nvarchar(10) = case @code
		when 1 then N'��'
		when 2 then N'�'
		when 3 then N'��'
		when 4 then N'�'
		when 5 then N'�'
	end;

	print convert(nvarchar, @weight) + ' ' + @descr + char(9) +
		  N' ��� ' + char(9) + convert(nvarchar, @kylos) + N' ��';
    set @code += 1;
end
-- goto Start
go


-- ������ �� case � ���������� � ����� when
declare @nomHour int = 0; -- ���
print '';

Loop:
   
	declare @timesOfDay nvarchar(50) = case 
		when  @nomHour between  0 and  3 then N'����'
		when  @nomHour between  4 and 11 then N'����'
		when  @nomHour between 12 and 17 then N'����'
		when  @nomHour between 18 and 23 then N'�����'
		else  N'�� ���� ������� � ������ 24 ����'
	end;
	print char(9) + N'����� ����� ��� ���� � ������� ' + convert(nvarchar, @nomHour) + ': ' + @timesOfDay;
	
	-- ��������� ���, �������� � ���������� ��������
	set @nomHour += 4;
	if (@nomHour <= 23) goto Loop;
	
-- ��� ������ ������ �������'  ������� ��� ������
print char(10) + char(9) + N'���, that''s all, falks!';
go