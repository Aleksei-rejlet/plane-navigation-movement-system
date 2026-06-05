pragma SPARK_Mode(on);
with AoA;
with PCU;
with HSU;

package SPU is
   

   pragma Elaborate_Body;
   Prev_Major : AoA.Sensor_Type := AoA.Undef_Value;
   Prev_ModeOn : Boolean := False;
   
   procedure Controller
     with
       Pre => True, -- write it to not forget about it like professor Hind said
       Global => (Input => (AoA.SensorState, PCU.ModeON), 
                  In_Out => (Prev_Major, Prev_ModeOn, PCU.AlarmON, PCU.AlarmCnt),
                  Output => HSU.TailplaneState),
       Depends => (Prev_ModeOn => PCU.ModeON,
                   Prev_Major => AoA.SensorState,
                   PCU.AlarmON => (AoA.SensorState, Prev_Major, PCU.AlarmON),
                   PCU.AlarmCnt => (PCU.AlarmCnt, PCU.AlarmON, Prev_Major, AoA.SensorState),
                   HSU.TailplaneState => (AoA.SensorState, Prev_ModeOn, PCU.ModeON)
                     
                     
                  );
         
   
   

end SPU;
