#!/bin/bash
# analyze-screenshot.sh — analiza colores, composición y texto de capturas
# Uso: analyze-screenshot.sh <imagen>

IMG="$1"
[[ -f "$IMG" ]] || { echo "ERROR: no existe $IMG"; exit 1; }

W=$(identify -format "%w" "$IMG")
H=$(identify -format "%h" "$IMG")

echo "=== INFORMACIÓN ==="
echo "Dimensiones: ${W}x${H}"

echo ""
echo "=== COLORES DOMINANTES (Global) ==="
convert "$IMG" -colors 8 -depth 8 -format "%c" histogram:info: | sort -rn | head -8

echo ""
echo "=== BARRA SUPERIOR (Waybar area, top 40px) ==="
WAYBAR_H=40
[[ $H -lt 60 ]] && WAYBAR_H=$((H/3))
convert "$IMG" -crop "${W}x${WAYBAR_H}+0+0" -colors 4 -depth 8 -format "%c" histogram:info: | sort -rn

echo ""
echo "=== ESQUINAS (para verificar bordes redondeados) ==="
for corner in "topleft" "topright" "bottomleft" "bottomright"; do
  echo "--- $corner ---"
  case $corner in
    topleft)     convert "$IMG" -crop "10x10+0+0" -colors 3 -depth 8 -format "%c" histogram:info: ;;
    topright)    convert "$IMG" -crop "10x10+$((W-10))+0" -colors 3 -depth 8 -format "%c" histogram:info: ;;
    bottomleft)  convert "$IMG" -crop "10x10+0+$((H-10))" -colors 3 -depth 8 -format "%c" histogram:info: ;;
    bottomright) convert "$IMG" -crop "10x10+$((W-10))+$((H-10))" -colors 3 -depth 8 -format "%c" histogram:info: ;;
  esac
done

echo ""
echo "=== TEXTO DETECTADO (OCR) ==="
tesseract "$IMG" - --psm 6 2>/dev/null | head -20

echo ""
echo "=== BRILLO PROMEDIO (mide transparencia/blur) ==="
BRIGHT=$(convert "$IMG" -colorspace Gray -format "%[mean]" info:)
printf "Brillo medio: %.0f/65535 (%.0f%%)\n" "$BRIGHT" "$(echo "scale=2; $BRIGHT/655.35" | bc -l)"

echo ""
echo "=== COLOR CENTRO PANTALLA ==="
CX=$((W/2))
CY=$((H/2))
convert "$IMG" -crop "1x1+${CX}+${CY}" -depth 8 -format "%[pixel:p{0,0}]" info:

echo ""
echo "=== ANÁLISIS COMPLETO ==="
