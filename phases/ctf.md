# FASE: CTF / REVERSING (módulo sob demanda)

Carregado quando: binário, hash, firmware, stego, ou reversing.

## Gates
```
binário + checksec → buffer overflow / ROP (pwntools)
binário desconhecido → disassembly (ghidra/radare2)
hash capturada     → identificar tipo → hashcat
arquivo suspeito   → stego (steghide/stegseek/binwalk)
binário p/ fuzzing → afl-fuzz
firmware           → binwalk -e / -A
```

## F2 — Flags adaptativas hashcat
```
hashid <hash> antes de tudo
MD5 -m 0 · SHA1 -m 100 · NTLM -m 1000 · bcrypt -m 3200 · krb5tgs RC4 -m 13100 / AES -m 19700
wordlist pura → +regras best64.rule → bruteforce -a 3 só em hash fraca
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Buffer overflow / ROP | `cybersecurity-skills:performing-binary-exploitation-analysis` |
| Binário desconhecido, disassembly | `cybersecurity-skills:reverse-engineering-malware-with-ghidra` |
| Hash p/ crack | `cybersecurity-skills:performing-hash-cracking-with-hashcat` |
| Arquivo com esteganografia | `cybersecurity-skills:performing-steganography-detection` |
| Binário p/ fuzzing | `cybersecurity-skills:performing-fuzzing-with-aflplusplus` |
| Firmware de dispositivo | `cybersecurity-skills:performing-firmware-extraction-with-binwalk` |
