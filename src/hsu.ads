--
-- Author:              A. Ireland
-- Updated:             30.6.2025
-- Description:         Implements the aircraft's Horizontal Stabilizer Unit (HSU).

pragma SPARK_Mode (On);
package HSU

is
   pragma Elaborate_Body;

   type Position is (UP, NORMAL, DOWN); -- position of tailplane
   
   TailplaneState:  Position;
   
   -- raises the tailplan to the UP position
   procedure TailplaneUP
   with
     Global => (Output => TailplaneState),
     Depends => (TailplaneState => null);

   -- lowers the tailplan to the DOWN position
   procedure TailplaneDOWN
   with
     Global => (Output => TailplaneState),
     Depends => (TailplaneState => null);

   -- moves the tailplane to the NORMAL (i.e., level) position
   procedure TailplaneNORMAL
   with
     Global => (Output => TailplaneState),
     Depends => (TailplaneState => null);

   -- returns True if tailplane is UP; otherwise returns False     
   function isTailplaneUP return Boolean
   with
     Global => (Input => TailplaneState),
     Depends => (isTailplaneUP'Result => TailplaneState);

   -- returns True if tailplane is DOWN; otherwise returns False     
   function isTailplaneDOWN return Boolean
   with
     Global => (Input => TailplaneState),
     Depends => (isTailplaneDOWN'Result => TailplaneState);

   -- returns True if tailplane is NORMAL; otherwise returns False     
   function isTailplaneNORMAL return Boolean
   with
     Global => (Input => TailplaneState),
     Depends => (isTailplaneNORMAL'Result => TailplaneState);

end HSU;
