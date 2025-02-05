within NHES.Fluid.Machines;
model Pump_Pressure "Pressure Booster Pump"
  extends TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple;

  parameter Boolean use_input=false "Use connector input for outlet pressure" annotation(choices(checkBox=true));
  parameter Modelica.Units.SI.Pressure p_nominal=1e5
    "Nominal outlet pressure (port_b.p)"
    annotation (Dialog(enable=not use_input));
   parameter Real eta=1 "Thermodynamic Efficiency of the pump";

  Modelica.Units.SI.Pressure p "Outlet pressure (port_b.p)";

  Modelica.Blocks.Interfaces.RealInput inputSignal(value=p_internal)
                                             if use_input annotation (Placement(
        transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={0,73})));
protected
  Modelica.Units.SI.Pressure p_internal;
equation
  eta_is=eta;
  if not use_input then
    p_internal =p_nominal;
  end if;
  p = p_internal;
  //port_a.m_flow + port_b.m_flow = 0;
  port_b.p = p;
  // Balance Equations
  //port_a.h_outflow = inStream(port_b.h_outflow);
  //port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);
  annotation (defaultComponentName="pump",
    Icon(graphics={
        Rectangle(
          extent={{-80,30},{-40,-30}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2,60},{80,0}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{60,60},{-60,-60}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-20,20},{-20,-22},{30,0},{-20,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
                   Text(extent={{-22,18},{28,-14}},
          lineColor={0,0,0},
          textString="p")}),
    Documentation(info="<HTML>
This component prescribes an outlet pressure. 
The change of specific enthalpy due to the pressure difference between the inlet and the outlet is calculated. 
<p><br><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p></HTML>",
        revisions="<html>
<ul>
<li><i>18 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end Pump_Pressure;
