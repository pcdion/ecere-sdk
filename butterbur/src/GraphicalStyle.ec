/******************************************************************************
 Styling of GraphicalElements from eC Cascading Style Sheets
******************************************************************************/
public import IMPORT_STATIC "ecere"
public import IMPORT_STATIC "EDA" // For FieldValue

import "eccss"
import "GraphicalElement"

public class GraphicalStyleMask : StylesMask
{
public:
   // Generic styles
   bool visibility         :1: 0;
   bool opacity            :1: 1;
   bool transform          :1: 2;
   bool transform3D        :1: 3;
   bool zOrder             :1: 4;
};

public class ShapesStyleMask : GraphicalStyleMask
{
public:
   // Shapes Styles
   bool fillPattern        :1: 5;
   bool fillColor          :1: 6;
   bool fillOpacity        :1: 7;
   bool fillStippleStyle   :1: 8;
   bool fillHatchStyle     :1: 9;
   bool fillGradient       :1:10;
   bool strokePattern      :1:11;
   bool strokeOpacity      :1:12;
   bool strokeWidth        :1:13;
   bool strokeColor        :1:14;
   bool strokeCenterWidth  :1:15;
   bool strokeCenterColor  :1:16;
   bool strokeCenterOpacity:1:17;
   bool strokeCasingWidth  :1:18;
   bool strokeCasingColor  :1:19;
   bool strokeCasingOpacity:1:20;
   bool strokeJoin         :1:21;
   bool strokeCap          :1:22;
   bool strokeDashPattern  :1:23;
};


public class TextStyleMask : GraphicalStyleMask
{
public:
   // Text Styles
   bool text               :1:24;
   bool fontFace           :1:25;
   bool fontSize           :1:26;
   bool fontBold           :1:27;
   bool fontItalic         :1:28;
   bool fontColor          :1:29;
   bool fontOpacity        :1:30;
   bool fontOutlineSize    :1:31;
   bool fontOutlineColor   :1:32;
   bool fontOutlineOpacity :1:33;
   bool alignmentHorzAlign :1:34;
   bool alignmentVertAlign :1:35;
};

public class ImageStyleMask : GraphicalStyleMask
{
public:
   // Image Styles
   bool image              :1:36;
};


public enum GraphicalStyleKind : GraphicalStyleMask
{
   fill = GraphicalStyleMask { fillPattern = true, fillColor = true, fillOpacity = true, fillStippleStyle = true, fillHatchStyle = true, fillGradient = true },
   fillPattern = GraphicalStyleMask { fillPattern = true },
   fillColor = GraphicalStyleMask { fillColor = true },
   fillOpacity = GraphicalStyleMask { fillOpacity = true },
   fillStippleStyle = GraphicalStyleMask { fillStippleStyle = true },
   fillHatchStyle = GraphicalStyleMask { fillHatchStyle = true },
   fillGradient = GraphicalStyleMask { fillGradient = true },
   stroke = GraphicalStyleMask { strokePattern = true, strokeOpacity = true, strokeWidth = true, strokeColor = true, strokeCenterWidth = true, strokeCenterColor = true, strokeCasingWidth = true, strokeCasingColor = true  },
   strokePattern = GraphicalStyleMask { strokePattern = true },
   strokeOpacity = GraphicalStyleMask { strokeOpacity = true },
   strokeWidth = GraphicalStyleMask { strokeWidth = true },
   strokeColor = GraphicalStyleMask { strokeColor = true },
   strokeCenter = GraphicalStyleMask { strokeCenterWidth = true, strokeCenterColor = true },
   strokeCenterWidth = GraphicalStyleMask { strokeCenterWidth = true },
   strokeCenterColor = GraphicalStyleMask { strokeCenterColor = true },
   strokeCasing = GraphicalStyleMask { strokeCasingWidth = true, strokeCasingColor = true },
   strokeCasingWidth = GraphicalStyleMask { strokeCasingWidth = true },
   strokeCasingColor = GraphicalStyleMask { strokeCasingColor = true },
   strokeJoin = GraphicalStyleMask { strokeJoin = true },
   strokeCap = GraphicalStyleMask { strokeCap = true },
   strokeDashPattern = GraphicalStyleMask { strokeDashPattern = true },
   text = GraphicalStyleMask { text = true },
   font = GraphicalStyleMask
   {
      fontFace = true, fontSize = true, fontBold = true, fontItalic = true, fontColor = true, fontOpacity = true,
      fontOutlineSize = true, fontOutlineColor = true, fontOutlineOpacity = true
   },
   fontFace = GraphicalStyleMask { fontFace = true },
   fontSize = GraphicalStyleMask { fontSize = true },
   fontBold = GraphicalStyleMask { fontBold = true },
   fontItalic = GraphicalStyleMask { fontItalic = true },
   fontColor = GraphicalStyleMask { fontColor = true },
   fontOpacity = GraphicalStyleMask { fontOpacity = true },
   fontOutline = GraphicalStyleMask { fontOutlineSize = true, fontOutlineColor = true, fontOutlineOpacity = true },
   fontOutlineSize = GraphicalStyleMask { fontOutlineSize = true },
   fontOutlineColor = GraphicalStyleMask { fontOutlineColor = true },
   fontOutlineOpacity = GraphicalStyleMask { fontOutlineOpacity = true },
   //outline = GraphicalStyleMask { outline = true },
   //color = GraphicalStyleMask { color = true },
   //casing = GraphicalStyleMask { casing = true },
   image = GraphicalStyleMask { image = true },
   alignment = GraphicalStyleMask { alignmentHorzAlign = true, alignmentVertAlign = true },
   alignmentHorzAlign = GraphicalStyleMask { alignmentHorzAlign = true },
   alignmentVertAlign = GraphicalStyleMask { alignmentVertAlign = true },
   zOrder = GraphicalStyleMask { zOrder = true },
   visibility = GraphicalStyleMask { visibility = true },
   transform = GraphicalStyleMask { transform = true },
   opacity = GraphicalStyleMask { opacity = true },
   transform3D = GraphicalStyleMask { transform3D = true },
};

// TODO: Replace these by class reflection
Map<String, GraphicalStyleMask> styleIdentifierMap
{ [
   { "fill", fill },
   { "fill.pattern", fillPattern },
   { "fill.color", fillColor },
   { "fill.opacity", fillOpacity },
   { "fill.stipple", fillStippleStyle },
   { "fill.hatch", fillHatchStyle },
   { "fill.gradient", fillGradient },
   { "stroke", stroke },
   { "stroke.pattern", strokePattern },
   { "stroke.opacity", strokeOpacity },
   { "stroke.color", strokeColor },
   { "stroke.width", strokeWidth },
   { "stroke.casing", strokeCasing },
   { "stroke.casing.width", strokeCasingWidth },
   { "stroke.casing.color", strokeCasingColor },
   { "stroke.join", strokeJoin },
   { "stroke.cap", strokeCap },
   { "stroke.dashPattern", strokeDashPattern },
   { "text", text },
   { "font", font },
   { "font.face", fontFace },
   { "font.size", fontSize },
   { "font.bold", fontBold },
   { "font.italic", fontItalic },
   { "font.color", fontColor },
   { "font.opacity", fontOpacity },
   { "font.outline", fontOutline },
   { "font.outline.size", fontOutlineSize },
   { "font.outline.color", fontOutlineColor },
   { "font.outline.opacity", fontOutlineOpacity },
   //{ "size", size },
   //{ "casing", strokeCasing },
   //{ "outline", outline },
   //{ "bold", bold },
   //{ "italic", italic },
   { "alignment", alignment },
   { "alignment.horzAlign", alignmentHorzAlign },
   { "alignment.vertAlign", alignmentVertAlign },
   { "opacity", opacity },
   { "transform", transform },
   { "transform3D", transform3D }
] };

Map<GraphicalStyleMask, const String> stringFromMaskMap
{ [
   { fill, "fill" },
   { fillPattern, "fill.pattern" },
   { fillColor, "fill.color" },
   { fillOpacity, "fill.opacity" },
   { fillStippleStyle, "fill.stippleStyle" },
   { fillHatchStyle, "fill.hatchStyle" },
   { fillGradient, "fill.gradient" },
   { stroke, "stroke" },
   { strokePattern, "stroke.pattern" },
   { strokeOpacity, "stroke.opacity" },
   { strokeColor, "stroke.color" },
   { strokeWidth, "stroke.width" },
   { strokeCasing, "stroke.casing" },
   { strokeCasingWidth, "stroke.casing.width" },
   { strokeCasingColor, "stroke.casing.color" },
   { strokeJoin, "stroke.join" },
   { strokeCap, "stroke.cap" },
   { strokeDashPattern, "stroke.dashPattern"  },
   { alignment, "alignment" },
   { alignmentHorzAlign, "alignment.horzAlign" },
   { alignmentVertAlign, "alignment.vertAlign" },
   { opacity, "opacity" },
   { transform, "transform" },
   { transform3D, "transform3D" },
   { text, "text" },
   { font, "font" },
   { fontFace, "font.face" },
   { fontSize, "font.size" },
   { fontBold, "font.bold" },
   { fontItalic, "font.italic" },
   { fontColor, "font.color" },
   { fontOpacity, "font.opacity" },
   { fontOutline, "font.outline" },
   { fontOutlineSize, "font.outline.size" },
   { fontOutlineColor, "font.outline.color" },
   { fontOutlineOpacity, "font.outline.opacity" },
   //{ size, "size" },
   //{ color, "color" },
   //{ casing, "casing" },
   { image, "image" }
] };

struct GraphicalStyleEvaluator : ECCSSEvaluator
{
   void applyStyle(GraphicalStyle object, GraphicalStyleMask mSet, const FieldValue value)
   {
      object.applyStyle(mSet, value);
   }
};

public class GraphicalStyle : struct
{
public:
   // Properties...
   Fill fill { };
   Stroke stroke { };
   Alignment2D alignment;
   int zOrder;
   bool visibility;
   float opacity;
   Transform transform;

   visibility = true;
   opacity = 1.0;

   // Internal...
   ExpFlags flags;

   //return sym for visualization classes
   public GraphicalStyle ::build(CMSSStyleSheet styleSheet, ECCSSEvaluator evaluator, Class stylesClass)
   {
      GraphicalStyle symbolizer = eInstance_New(stylesClass ? stylesClass : class(GraphicalStyle));
      GraphicalStyleMask m = 0xffffffffffffffff;
      ExpFlags flg = 0;
      if(styleSheet)
      {
         m = (GraphicalStyleMask)styleSheet.list.apply(symbolizer, m, evaluator, &flg);
      }
      if(m) symbolizer.applyDefaults(m);
      symbolizer.flags = flg;
      return symbolizer;
   }

   private void applyDefaults(GraphicalStyleMask mask)
   {
      if(mask.fillColor) fill.color = white;
      if(mask.strokeColor) stroke.color = black;
      if(mask.opacity) opacity = 1.0;
      if(mask.visibility) visibility = true;
   }

   private void applyStyle(GraphicalStyleKind mSet, const FieldValue value)
   {
      switch(mSet)
      {
         //pattern needs special code
         //case fillPattern: if(!fill.pattern) fill.pattern = { }; break;
         case fillColor: fill.color = (Color)value.i; break;
         case fillOpacity: fill.opacity = (float)value.r; break;
         case fillStippleStyle: fill.stipple = (StippleType)value.i; break;
         case fillHatchStyle: fill.hatch = (HatchType)value.i; break;
         case fillGradient: fill.gradient = value.b; break;
         case strokePattern: stroke.pattern = { }; break;
         case strokeOpacity: stroke.opacity = (float)value.r; break;
         case strokeColor: stroke.color = (Color)value.i; break;
         case strokeWidth: stroke.width = (float)value.r; break;
         case strokeCasingWidth:  stroke.casing.width = (float)value.r; break;
         case strokeCasingColor:  stroke.casing.color = (Color)value.i; break;
         case strokeJoin: stroke.join = (LineJoin)value.i; break;
         case strokeCap: stroke.cap = (LineCap)value.i; break;
         case strokeDashPattern: stroke.dashes = value.b; break;
         //case alignmentHorzAlign: alignment.horzAlign = (HAlignment)value.i; break;
         //case alignmentVertAlign: alignment.vertAlign = (VAlignment)value.i; break;
         // error for these:duplicate case value ; error: previously used here
         /*
         { "transform", transform },
         { "transform3D", transform3D },
         */
         case opacity: opacity = (float)value.r; break;
      }
   }
}
