------------------------------------------------------------------------
-- draw.ads - draw random numbers, package specification
------------------------------------------------------------------------
-- Author:
--   Erich H. Rast <erich@snafu.de>
--
-- License: This program is free software licensed under GNU Lesser
--          General Public License version 3. Please read the accompanying
--          License.Txt text for more Information. This program and
--          its packages come with ABSOLUTELY NO WARRANTY.
------------------------------------------------------------------------

with Ada.Numerics.Float_Random; use Ada.Numerics;

package draw is
   type Lottery_Number is range 1 .. 50;
   type Draw_Number is range 1 .. 10;
   type Full_Draw is array (1 .. Draw_Number'Last) of Lottery_Number;
   procedure Draw_Numbers
     (Num      : in Draw_Number;
      Total    : in Lottery_Number;
      Result   : in out Full_Draw);
private
   G           : Float_Random.Generator;
   Initialized : Boolean := False;
   function Draw1 (Total : in Lottery_Number) return Lottery_Number;
   procedure Sort (Draw  : in out Full_Draw; Max : in Draw_Number);
end draw;
