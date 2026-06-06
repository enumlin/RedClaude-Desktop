# FASE: MOBILE (módulo sob demanda)

Carregado quando: APK/IPA ou app mobile no escopo.

## Gates
```
APK sem análise   → static (MobSF/apktool/jadx) PRIMEIRO
comportamento runtime → dynamic (frida/drozer) APÓS identificar alvo
SSL pinning bloqueando → frida bypass de pinning
interceptar tráfego   → burp + proxy no device
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| APK sem análise prévia | `cybersecurity-skills:performing-android-app-static-analysis-with-mobsf` |
| APK estático feito, runtime | `cybersecurity-skills:performing-dynamic-analysis-of-android-app` |
| App iOS, runtime e bypass | `cybersecurity-skills:performing-ios-app-security-assessment` |
| SSL pinning bloqueando | `cybersecurity-skills:performing-mobile-app-certificate-pinning-bypass` |
| Interceptar tráfego HTTP/S | `cybersecurity-skills:intercepting-mobile-traffic-with-burpsuite` |

## F1 — Dedup Mobile
static → dynamic é sequência obrigatória do mesmo branch. Estático primeiro;
dynamic só após identificar comportamento a confirmar em runtime.
