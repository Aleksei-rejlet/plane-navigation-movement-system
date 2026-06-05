pragma SPARK_Mode (On);
package body AoA is
   procedure Write_Sensors (Value_1, Value_2, Value_3 : in Sensor_Type)
   is begin -- writing information from sensors
      SensorState(1) := Value_1;
      SensorState(2) := Value_2;
      SensorState(3) := Value_3;
   end Write_Sensors;
   
   function Read_Sensor (Sensor_Index: in Sensor_Index_Type) return Sensor_Type is
   begin -- reading information that we wrote
      return SensorState (Sensor_Index);
   end Read_Sensor; 
   
   function Read_Sensor_Majority return Sensor_Type
   is  -- finging majority of information from sensors 
      Values : Sensors_Type := SensorState;
      Defined_Count : Natural := 0;
      Maj_V : Sensor_Type;
   begin
      for I in Sensor_Index_Type loop -- trying to find undefined read
         if Values(I) /= Undef_Value then
            Defined_Count := Defined_Count + 1;
         end if;
      end loop;
      
      if Defined_Count = 0 then -- catching errors 
         return Undef_Value;
      end if;
      
      if Values(1) = Values(2) or else Values(1) = Values(3) then -- logic behind choosing major value
         Maj_V := Values(1);
      elsif Values(2) = Values(3) then
         Maj_V := Values(2);
      else -- if all different values on sensors 
         declare
            Temp : Sensors_Type := (1 => Values(1), 2 => Values(2), 3 => Values(3));-- making new variables as a back up to not change initial values
            Minim, Maxim : Sensor_Type;
         begin
            Minim := Temp(1);
            If Temp(2) < Minim then
               Minim := Temp(2);
            end if;
            if Temp(3) < Minim then
               Minim := Temp(3);
            end if;
            
            Maxim := Temp(1);
            If Temp(2) > Maxim then
               Maxim := Temp(2);
            end if;
            if Temp(3) > Maxim then
               Maxim := Temp(3);
            end if; -- Using formula for finding majority value
            Maj_V := Temp(1) + Temp(2) +  Temp(3) - Minim - Maxim;
         end;
      end if;
      return Maj_V;
   end Read_Sensor_Majority;
  
      
            

   

end AoA;
