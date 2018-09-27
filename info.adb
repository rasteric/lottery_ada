------------------------------------------------------------------------
-- info.ads - print some info on the screen, implementation
------------------------------------------------------------------------
-- Author:
--   Erich H. Rast <erich@snafu.de>
--
-- License: This program is free software licensed under GNU Lesser
--          General Public License version 3. Please read the accompanying
--          License.Txt text for more Information. This program and
--          its packages come with ABSOLUTELY NO WARRANTY.
------------------------------------------------------------------------

with Draw;             use Draw;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada;

package body info is
   --------------------------------------------------------------------------
   procedure Print_Info is
   begin
      Put ("Usage: ");
      Put (Command_Line.Command_Name);
      Put_Line (" <n> <total>");
      Put ("   Example: ");
      Put (Command_Line.Command_Name);
      Put_Line ("  -c 3 6 49");
      Put_Line ("   Parameters:");
      Put ("     <n>     : the number of draws (");
      Put (Draw_Number'Image (Draw_Number'First));
      Put ("..");
      Put (Draw_Number'Image (Draw_Number'Last));
      Put_Line (" )");
      Put ("     <total> : the total to draw from (");
      Put (Lottery_Number'Image (Lottery_Number'First));
      Put ("..");
      Put (Lottery_Number'Image (Lottery_Number'Last));
      Put_Line (" )");
      Put_Line ("   Options:");
      Put_Line
        ("      -c <number> or --count <number>" &
         " : repeat drawing <number> times");
      Put_Line ("      -h or --help : show this help");
      Put_Line ("      -C or --copyright : show licensing information");
   end Print_Info;
   --------------------------------------------------------------------------
   procedure Copyright is
   begin
      Put_Line ("Copyright (c) 2011-2012 by Erich H. Rast.");
      Put_Line ("This program is free software licensed under the GNU Lesser General Public License version 3.");
   end Copyright;
   --------------------------------------------------------------------------
end info;
