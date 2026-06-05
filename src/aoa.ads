--
-- Author:              A. Ireland
-- Updateded:           30.6.2025
-- Description:         Manages the aircraft's Angle of Attack (AoA) sensor unit.
--                      Note that a single AoA sensor reading is calculated
--                      using a majority vote algorithm.

pragma SPARK_Mode (On);
package AoA

is

   pragma Elaborate_Body;

   Undef_Value: constant Integer := 61; -- undefined sensor reading

   subtype Sensor_Type is Integer range -60..61;
   subtype Sensor_Index_Type is Integer range 1..3;
   type Sensors_Type is array (Sensor_Index_Type) of Sensor_Type;

   SensorState: Sensors_Type;

   -- updates the SensorState with the 3 sensor readings, i.e., Value_1, Value_2, Value_3
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type)
   with
     Global => (In_Out => SensorState),
     Depends => (SensorState => (SensorState, Value_1, Value_2, Value_3));

   -- from SensorState, returns the sensor reading indexed by Sensor_Index (1..3)
   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type
   with
     Global  => (Input => SensorState),
     Depends => (Read_Sensor'Result => (SensorState, Sensor_Index));

   -- from SensorState, returns the majority sensor reading
   function Read_Sensor_Majority return Sensor_Type
   with
     Global  => (Input => SensorState),
     Depends => (Read_Sensor_Majority'Result => SensorState);

end AoA;
