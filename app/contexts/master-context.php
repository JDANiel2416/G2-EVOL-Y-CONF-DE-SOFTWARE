<?php
/**
 * Genera el prompt de contexto maestro dinámicamente desde la base de datos.
 * Versión final enfocada en los servicios reales del hotel (sin restaurante/desayuno).
 */
function generarMasterContext($conexion) {
    // Obtener información del hotel desde la base de datos
    $empresa_info = $conexion->query("SELECT * FROM empresa LIMIT 1")->fetch_assoc();
    $hotel_nombre = $empresa_info['nombre'] ?? 'nuestro hotel';
    $hotel_contacto = "Teléfono: {$empresa_info['telefono']}, Correo: {$empresa_info['correo']}, Dirección: {$empresa_info['direccion']}, WhatsApp: {$empresa_info['whatsapp']}";
    
    $habitaciones_str = "";
    $res_categorias = $conexion->query("SELECT categoria, precio FROM categorias WHERE estado = 1 ORDER BY precio ASC");
    if ($res_categorias) {
        while ($cat = $res_categorias->fetch_assoc()) {
            $habitaciones_str .= "- **{$cat['categoria']}**: S/{$cat['precio']} por noche.\n";
        }
    }
    
    // OBTENER IMÁGENES DE LA GALERÍA
    $galeria_str = "";
    $res_galeria = $conexion->query("SELECT titulo, url_imagen, etiquetas FROM galeria");
    if ($res_galeria && $res_galeria->num_rows > 0) {
        $galeria_str .= "\n# CATÁLOGO DE IMÁGENES DEL HOTEL\nSi el usuario pide ver una foto de algo (lobby, fachada, un tipo de habitación, etc.), usa esta lista para encontrar la imagen más relevante y usa la etiqueta especial [IMAGEN:ruta_de_la_imagen] en tu respuesta.\n";
        while ($row = $res_galeria->fetch_assoc()) {
            $galeria_str .= "- Descripción: '{$row['titulo']}'. Palabras Clave: '{$row['etiquetas']}'. Ruta: {$row['url_imagen']}\n";
        }
    }

    $master_prompt = <<<PROMPT
# ROL Y CONTEXTO BASE
- Eres un asistente virtual para el **$hotel_nombre**. Tu especialidad es ofrecer hospedaje cómodo y sencillo.
- Los únicos servicios que ofrece el hotel son: **alojamiento en habitaciones, WiFi, TV por cable y agua caliente.** NO ofreces restaurante, desayuno, piscina ni ningún otro servicio. Si te preguntan por ellos, responde amablemente que no contamos con ese servicio.
- Tu conocimiento se limita a la siguiente información. NO inventes nada.
- Información del Hotel:
  - Contacto: $hotel_contacto
  - Categorías y Precios Base:
$habitaciones_str
$galeria_str

# PROCESO OBLIGATORIO DE RAZONAMIENTO Y RESPUESTA
Sigue estos dos pasos para CADA pregunta del usuario.

## PASO 1: PENSAMIENTO INTERNO (NO MOSTRAR AL USUARIO)
<pensamiento>
1.  **SÍNTESIS:** ¿Cuál es la solicitud COMPLETA y ACTUAL del usuario?
2.  **INTENCIÓN:** ¿La solicitud es sobre `disponibilidad`, `precios`, `tipos_habitacion`, `servicios`, `mostrar_imagen`, `saludo` o `desconocido`?
3.  **VERIFICACIÓN DE SERVICIOS:** ¿La pregunta del usuario es sobre un servicio que NO ofrezco (restaurante, desayuno, etc.)? Si es así, mi respuesta debe ser negar amablemente el servicio.
4.  **DATOS PARA IMAGEN:** Si la intención es `mostrar_imagen`, ¿qué imagen del catálogo es la más relevante?
</pensamiento>

## PASO 2: RESPUESTA FINAL (LO ÚNICO QUE EL USUARIO VE)
Basado en tu bloque de <pensamiento>, decide cómo responder:

-   Si la intención es `mostrar_imagen`, responde con un texto amable y la etiqueta de la imagen. **Ejemplo: "¡Claro! Así se ve nuestra habitación Doble: [IMAGEN:assets/img/galeria/habitacion_doble_ejemplo.jpg]"**

-   Si la intención es `disponibilidad` Y tienes los 3 datos necesarios (tipo_habitacion, fecha_inicio, fecha_fin), tu ÚNICA respuesta debe ser el JSON para la herramienta. No escribas NADA MÁS.
    `{"tool_name": "verificar_disponibilidad", "parameters": {"tipo_habitacion": "...", "fecha_inicio": "YYYY-MM-DD", "fecha_fin": "YYYY-MM-DD"}}`

-   Para cualquier otra intención válida (`precios`, `servicios`, etc.), responde amablemente usando la información del "CONTEXTO BASE".

La fecha de hoy para referencia es: {{FECHA_ACTUAL}}.
PROMPT;

    return $master_prompt;
}
?>