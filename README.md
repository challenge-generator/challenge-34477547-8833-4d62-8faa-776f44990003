# Optimización y aseguramiento de calidad en aplicación móvil

La aplicación móvil de finanzas personales ha experimentado un aumento significativo en el número de usuarios activos. Como desarrollador avanzado, tu misión es implementar pruebas unitarias y funcionales, aplicar técnicas de BDD, y analizar el perfilamiento de la aplicación para identificar y resolver cuellos de botella. Los actores clave incluyen el 'usuario final', el'motor de cálculo de finanzas' y el'servicio de notificaciones push'. La aplicación debe manejar al menos 10 000 transacciones por segundo con un tiempo de respuesta máximo de 200ms. La consistencia de los datos es crítica, especialmente durante las actualizaciones de saldo.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Técnicas de pruebas unitarias y fundamentos de perfilamiento de aplicaciones |
| **Nivel** | advanced-l2 |
| **Tipo** | mixed |
| **Tiempo estimado** | 20 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Implementación de pruebas unitarias

**Objetivo:** Asegurar que las funciones críticas de la aplicación se comportan como se espera en condiciones normales y de error.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Identificar las funciones críticas que requieren pruebas unitarias.
- Escribir pruebas unitarias para cada función identificada, cubriendo casos normales y de error.
- Ejecutar las pruebas y verificar que todas pasan con éxito.

**Entregable:** Conjunto de pruebas unitarias que cubren las funciones críticas de la aplicación.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de mocks para aislar las dependencias externas.
- Piensa en los posibles modos de falla y cómo podrían afectar a las pruebas.

</details>

### Fase 2: Aplicación de BDD y pruebas funcionales automatizadas

**Objetivo:** Garantizar que la aplicación cumple con los requisitos del negocio a través de pruebas funcionales automatizadas.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Escribir escenarios de BDD que describan el comportamiento esperado de la aplicación desde la perspectiva del usuario.
- Implementar pruebas funcionales automatizadas basadas en los escenarios de BDD.
- Ejecutar las pruebas y verificar que todas pasan con éxito.

**Entregable:** Conjunto de pruebas funcionales automatizadas basadas en escenarios de BDD.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de herramientas de automatización para ejecutar las pruebas.
- Piensa en cómo los escenarios de BDD pueden ayudar a comunicar los requisitos del negocio al equipo de desarrollo.

</details>

### Fase 3: Análisis de perfilamiento y optimización

**Objetivo:** Identificar y resolver cuellos de botella en la aplicación para mejorar su rendimiento.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Realizar un perfilamiento de la aplicación para identificar las áreas de mayor consumo de recursos.
- Analizar los resultados del perfilamiento y proponer optimizaciones para reducir el consumo de recursos.
- Implementar las optimizaciones propuestas y verificar que el rendimiento ha mejorado.

**Entregable:** Informe de perfilamiento con propuestas de optimización implementadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de herramientas de perfilamiento para obtener datos precisos.
- Piensa en cómo las optimizaciones pueden afectar a la consistencia y disponibilidad de la aplicación.

</details>

### Fase 4: Integración y verificación final

**Objetivo:** Asegurar que todas las fases anteriores se han completado correctamente y que la aplicación cumple con los requisitos de rendimiento y calidad.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Revisar todos los entregables de las fases anteriores para asegurar que se han cumplido los objetivos.
- Realizar una verificación final de la aplicación para asegurar que cumple con los requisitos de rendimiento y calidad.
- Documentar cualquier hallazgo o recomendación adicional.

**Entregable:** Documento final que resume los hallazgos y recomendaciones de todas las fases.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de herramientas de verificación para obtener datos objetivos.
- Piensa en cómo comunicar los hallazgos y recomendaciones al equipo de desarrollo y a los stakeholders.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son las pruebas unitarias y por qué son importantes en el desarrollo de aplicaciones?
- **paraQueSirve**: ¿Cómo se aplican las pruebas unitarias en una función crítica de la aplicación?
- **comoSeUsa**: ¿Cómo se interpreta el perfilamiento de una aplicación para identificar cuellos de botella?
- **erroresComunes**: ¿Cuáles son los errores comunes al escribir pruebas unitarias y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el análisis de perfilamiento y la implementación de optimizaciones?

## Criterios de Evaluacion

- Implementación de pruebas unitarias que cubren casos normales y de error.
- Aplicación de BDD y pruebas funcionales automatizadas.
- Análisis de perfilamiento y propuestas de optimización.
- Verificación final de la aplicación para asegurar que cumple con los requisitos de rendimiento y calidad.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
