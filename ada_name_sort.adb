--Joshua Brent Collins 3/22/2013 Ada name sort 
with Ada.Text_IO; 
with Ada.Strings.Unbounded; use  Ada.Strings.Unbounded;
with Ada.Containers.Vectors; use Ada.Containers;

procedure adsort is 
	package io renames Ada.Text_IO;
	package strng renames Ada.Strings.Unbounded;
	package stcont is new Vectors(Natural, unbounded_String); 
	use stcont;
			
	txtname : String := "unsortednames.txt";	
	File  : io.File_Type;
	fname : Vector;
	Lname : Vector;
	fhold : Unbounded_String;
	lhold : Unbounded_String;
	templine : Unbounded_String;
	lines    : Integer := 0;
	flag : Boolean := False;	
begin
	io.Open(File=>File,Mode=>io.In_File,Name=>txtname);
--Copy string to specified hold string for processing.
	while not io.End_of_File(File) loop
			
			templine:=strng.To_Unbounded_String(io.Get_Line(File));
			lines:=lines+1;
			for j in 1..strng.Length(templine) loop
				if strng.Element(templine, j) /= ' ' then 
				if flag then
				strng.Append(lhold,strng.Element(templine, j));				
				end if;				
				
				if not flag then
				strng.Append(fhold,strng.Element(templine, j));

				end if;				
				end if;
				
				if strng.Element(templine, j) = ' ' then 
				flag := True;
				end if ;
			end loop;
			flag := False; 

			fname.Append(fhold);
			lname.Append(lhold);
			
			fhold:=strng.To_Unbounded_String("");
			lhold:=strng.To_Unbounded_String("");
 	end loop;
io.Close(File);
--sort
for i in 0..(lines-1) loop
for j in 0..(lines-1) loop
if lname.Element(i) < lname.Element(j) then 
lname.Swap(i,j);
fname.Swap(i,j);
end if;
end loop;
end loop;
--end sort
io.Create(File,io.Out_File,"sortednames.txt");
--write to file and screen
for i in 0..(lines-1) loop
io.Put(strng.To_String(fname.Element(i)));
for v in 1..(20 - strng.Length(fname.Element(i))) loop io.put(" "); end loop;
io.Put_Line(strng.To_String(lname.Element(i)));
io.Put(File,strng.To_String(fname.Element(i)));
for v in 1..(20 - strng.Length(fname.Element(i))) loop io.put(File," "); end loop;
io.Put_Line(File,strng.To_String(lname.Element(i)));
end loop;
io.Close(File);
end;
