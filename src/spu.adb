pragma SPARK_Mode(on);
package body SPU is
   
   procedure Controller is
      Current_Major : AoA.Sensor_Type; -- creating now and previous vlues of variables
      Mode_Enabled : Boolean;
   begin
      HSU.TailplaneNORMAL; -- setting plane tail in initial normal position
      Current_Major := AoA.Read_Sensor_Majority; -- creating now and previous vlues of variables
      Mode_Enabled := PCU.isEnabledMode;
      
      if (Current_Major >= 25) and then (Prev_Major >= 25) and then (Current_Major >= Prev_Major) -- SC-1
      then if PCU.isEnabledAlarm then
            PCU.AlarmCnt := PCU.AlarmCnt; -- implementing increasing alarmcnt
         else 
            PCU.EnableAlarm;
         end if;
         
      elsif (Current_Major < 25) or else (Prev_Major < 25) or else (Current_Major < Prev_Major)
      then PCU.DisableAlarm; -- SC-2
      end if;
      
      if (not Mode_Enabled) and then Prev_ModeOn -- SC-5
      then 
         HSU.TailplaneNORMAL;
      elsif Mode_Enabled then
         if Current_Major >= 30 then HSU.TailplaneUP; -- SC-3
         else HSU.TailplaneNORMAL; -- SC-4
         end if;
      end if;
      Prev_Major := Current_Major; -- storing values of existing to previous
      Prev_ModeOn := Mode_Enabled;
      
         
   end Controller;
   
   

end SPU;
