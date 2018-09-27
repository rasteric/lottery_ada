------------------------------------------------------------------------
-- draw.adb - draw random numbers
------------------------------------------------------------------------
-- Author:
--   Erich H. Rast <erich@snafu.de>
--
-- License: This program is free software licensed under GNU Lesser
--          General Public License version 3. Please read the accompanying
--          License.Txt text for more Information. This program and
--          its packages come with ABSOLUTELY NO WARRANTY.
------------------------------------------------------------------------

with Draw;

package body draw is
   --------------------------------------------------------------------------
   -- draw one number using the pseudo-random
   -- number generator and return it
   function Draw1 (Total : in Lottery_Number) return Lottery_Number is
   begin
      return Lottery_Number ((Float'Floor
                                 (Float_Random.Random (G) *
                                  (Float (Total)) +
                                  1.0)));
   end Draw1;
   --------------------------------------------------------------------------
   -- the good old slow bubblesort!
   procedure Sort (Draw : in out Full_Draw; Max : in Draw_Number) is
      Buffer  : Lottery_Number;
      Swapped : Boolean;
   begin
      loop
         Swapped := False;
         for i in 2 .. Max loop
            if Draw (i - 1) > Draw (i) then
               Buffer       := Draw (i);
               Draw (i)     := Draw (i - 1);
               Draw (i - 1) := Buffer;
               Swapped      := True;
            end if;
         end loop;
         exit when Swapped = False;
      end loop;
   end Sort;
   --------------------------------------------------------------------------
   -- draw all the numbers and return the result
   -- in a Full_Draw array
   procedure Draw_Numbers
     (Num    : in Draw_Number;
      Total  : in Lottery_Number;
      Result : in out Full_Draw)
   is
      Buffer      : Lottery_Number;
      Unique_Draw : Boolean;
   begin
      if not Initialized then
         Float_Random.Reset (G);
         Initialized := True;
      end if;
      Result (1) := Draw1 (Total);
      for i in 2 .. Num loop
         check_loop : loop
            Unique_Draw := True;
            Result (i)  := Draw1 (Total);
            inner_for_loop : for j in 1 .. i - 1 loop
               if Result (j) = Result (i) then
                  Unique_Draw := False;
                  exit inner_for_loop;
               elsif j > 1 and then Result (j - 1) > Result (j) then
                  -- we presort the array as much as possible
                  -- in the hope of speeding up final sorting
                  Buffer         := Result (j);
                  Result (j)     := Result (j - 1);
                  Result (j - 1) := Buffer;
               end if;
            end loop inner_for_loop;
            exit check_loop when Unique_Draw = True;
         end loop check_loop;
      end loop;
      Sort (Result, Num);
   end Draw_Numbers;
   --------------------------------------------------------------------------
end draw;
