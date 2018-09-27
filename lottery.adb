------------------------------------------------------------------------
-- lottery - draw lottery numbers
------------------------------------------------------------------------
-- Author:
--   Erich H. Rast <erich@snafu.de>
--
-- License: This program is free software licensed under GNU Lesser
--          General Public License version 3. Please read the accompanying
--          License.Txt text for more Information. This program and
--          its packages come with ABSOLUTELY NO WARRANTY.
------------------------------------------------------------------------

with Ada.Text_IO;             use Ada.Text_IO;
with Draw;                    use Draw;
with Info;                    use Info;
with Ada.Command_Line;        use Ada;
with Ada.Command_Line.Remove;

procedure Lottery is
   N      : Draw_Number;
   Count  : Positive := 1;
   Total  : Lottery_Number;
   Result : Full_Draw;
   Do_It  : Boolean  := True;
begin
   -- process command line options
   Argument_Loop : for I in 1 .. Command_Line.Argument_Count loop
      if Command_Line.Argument (I) = "-c" or
         Command_Line.Argument (I) = "--count"
      then
         Count := Positive'Value (Command_Line.Argument (I + 1));
         Command_Line.Remove.Remove_Arguments (I, I + 1);
         exit Argument_Loop;
      elsif Command_Line.Argument (I) = "-h" or
            Command_Line.Argument (I) = "--help"
      then
         Command_Line.Remove.Remove_Argument (I);
         Print_Info;
         Do_It := False;
         exit Argument_Loop;
      elsif Command_Line.Argument (I) = "-C" or
            Command_Line.Argument (I) = "--copyright"
      then
         Command_Line.Remove.Remove_Argument (I);
         Copyright;
         Do_It := False;
         exit Argument_Loop;
      end if;
   end loop Argument_Loop;
   if Do_It then
      if Command_Line.Argument_Count >= 2 then
         -- get the two main arguments, draw N of Total
         N     := Draw_Number'Value (Command_Line.Argument (1));
         Total := Lottery_Number'Value (Command_Line.Argument (2));
         if Positive (Total) >= Positive (N) then
            -- now draw numbers Count times and display them
            -- the default value of Count = 1
            Main_Loop : for I in 1 .. Count loop
               -- draw the numbers
               Draw_Numbers (N, Total, Result);
               -- output the numbers to the screen
               for J in 1 .. N - 1 loop
                  Put (Lottery_Number'Image (Result (J)));
                  Put (",");
               end loop;
               Put_Line (Lottery_Number'Image (Result (N)));
            end loop Main_Loop;
            Command_Line.Set_Exit_Status (Command_Line.Success);
         else
            -- error: you cannot draw N unique values from an urn with less
            --than
            -- N unique elements
            Put ("error: sorry, you cannot draw");
            Put (Draw_Number'Image (N));
            Put (" unique elements from an urn that contains only");
            Put (Lottery_Number'Image (Total));
            Put_Line (" unique elements in total!");
            New_Line;
            Command_Line.Set_Exit_Status (Command_Line.Failure);
            Print_Info;
         end if;
      else
         -- error: at least two arguments have to be provided
         Put_Line ("error: you have to provide at least two arguments!");
         Command_Line.Set_Exit_Status (Command_Line.Failure);
         Print_Info;
      end if;
   else -- Do_It = False, so only some info has been displayed
      Command_Line.Set_Exit_Status (Command_Line.Success);
   end if;
exception
   when Constraint_Error =>
      Put_Line ("error: the numbers must be within the bounds given below!");
      New_Line;
      Command_Line.Set_Exit_Status (Command_Line.Failure);
      Print_Info;
end Lottery;
