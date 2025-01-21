---
author: Johannes Hörmann <me@aligator.dev>
date: DD.MM.YYYY
---

# Bash
Was ist das eigentlich?

---

## Was ist Bash

* Ursprünglich hatte ein Computer nur ein Textinterface.
* Um damit zu interagieren gibt es ein "Hauptprogramm" 
dass einfach direkt am Anfang gestartet wird. (eine sogenannte `Shell`)

---
## Was ist Bash
### Beispiele:

---
## Was ist Bash
### Beispiele:
* DOS: CMD
* Linux: bash
* Atari: hatte tatsächlich **nur** eine grafische UI 
  -> eine `Shell` muss nicht unbedingt *text* sein
* Windows: explorer.exe (auch grafisch)

---
## Was ist Bash
Man kann aber natürlich z.B. aus Windows heraus auch immer ein Terminal Fenster gestartet werden,
dass dann die Standard `Text-Shell` startet.  

(e.g. Windows Terminal fenster mit `cmd` oder `powershell`, in linux ein Terminal Fenster mit `sh`, `bash`, `zsh`, `fish`, ...)

---
## Was ist ein Shell-Script
Man kann die Befehle die diese Shell akzeptiert (meist) einfach in eine Datei Schreiben, und so auf ein mal ausführen.
* `.cmd` / `.bat` für `CMD`
* `.ps` für `Powershell`
* `.sh` für `sh`, `bash`, `zsh`, ...

---
## Was ist ein Shell-Script
Im einfachsten Fall kann man in einer Shell einfach den Programmnamen von anderen Programmen eingeben.

Diese werden dann einfach direkt ausgeführt:
z.B.
```bash
ls -l /
```

---
## Was ist ein Shell-Script
Das alleine ist ja schon extrem `Powerfull`, denn damit kann man ja eigentlich einfach alles starten.

Aber damit man aber auch `Programmlogik` erstellen kann, sind die meisten Shells eigentlich komplette 
`Interpreter` für vollständige `Programmiersprachen`.

Heist es gibt:
* `if`
* `for`
* `funktionen`
* ...

Man kann diese Dinge alle auch direkt in der `Interaktiven` Shell verwenden! (Aber in einer datei ist es einfacher zu handeln...)

---
## Was ist ein Shell-Script
Aber jede variante von shells hat natürlich einen eigenen Syntax.

Da die Shells z.T. recht sind (e.g. `CMD`, `bash`) sind die Sprachenfeatures natürlich `gewachsen`.

---
## Bash
Da wir hauptsächlich mit Linux zu tun haben, fokusieren wir uns die linux `bash`.

* `sh` Ist die simpelste / ursrprünglichste variante, die aber schon allen Grund-Syntax anbietet.
* `bash` Ist im Prinzip eine `sh` kompatible Erweiterung.
* `zsh` Ist wiederum eine Erweiterung auf bash aufbauend.
* `fish` Hat recht eigenen Syntax - aus kompatibilitätsgründen verzichte ich normal darauf.
* Es gibt noch massenweise weitere implementierungen, oder sogar komplett eigenständige Shells.

---
## Bash
Am verbreitesten ist `bash` und man kann meist davon ausgehen dass diese immer existiert.
Ausnahmen bestätigen die Regel:
* super kleine Docker images haben entweder gar keine shell, oder *nur* `sh`
* manche distros haben andere shells, z.B. aus Platzgründen: 
  * `busybox` variante `ash` in Alpine Linux
  * `busybox` ist eine recht platzsparende `singlebinary` shell, wird gerne in embedded linux und docker verwendet

---
## Grundlagen
### Shebang
In Linux / Unix ist prinzipiell die Dateiendung egal.
Stattdessen ist eine `ausführbare Datei` 
* entweder wirklich kompilierter Maschienencode (binär)
* oder eine einfache Textdatei, in der in der ersten Zeile steht, mit was diese datei ausgeführt werden soll.
```bash
#!/bin/bash
echo "Hello World"
```

--- 

```python
#!/bin/python
x = 1
if x == 1:
    # indented four spaces
    print("x is 1.")
```

---
## Grundlagen
### Shebang
Der kompatibelste (aber nicht verbreitetste) shebang ist:
```bash
#!/usr/bin/env bash
echo "Hello World"
```

Weil so ziemlich jedes Linux `/usr/bin/env` hat, aber nicht zwangsläufig jedes Linux (aber die meisten) die bash an `/bin/bash` hat.

-> Ich empfehle immer `#!/usr/bin/env bash` wenn mans sauber machen will.

---
## Grundlagen
### Shebang

-> Also man kann rein über den shebang steuern mit was genau eine textdatei ausgeführt wird.

Zum ausführen:
```bash
chmod +x myFile.sh
./myFile.sh

# Nicht 
myFile.sh
# Denn das würde nur im PATH guggen, ob das Programm wo ist, nicht die Datei im aktuellen Ordner.
# Mit ./myFile.sh oder /home/user/myFile.sh gibt man den direkten Pfad an und die shell weis was sie tun muss.
```
(__Note:__ In Windows cmd ist das anders! Dort kann man das ./ weglassen, weil die CMD immer auch im aktuellen Verzeichnis guggt!)

---
## Grundlagen
### Aufgaben
#### 1 - Hello World

Schreibe ein `bash` script, das "Hello World!" ausgibt.

---
## Grundlagen
### Aufgaben
#### 1 - Hello World

```bash
#!/usr/bin/env bash
echo Hello World
```
oder 
```bash
#!/usr/bin/env bash
echo "Hello World"
```

---
## Grundlagen
### Aufgaben
#### 2 - if 

If macht eigentlich nichts anderes, als ein Programm auszuführen und auf den `exit code` = `0` to testen.

e.g. 
```bash
if /bin/true; then
  echo "yes"
else 
  echo "no"
fi

if false; then
  echo "yes"
else 
  echo "no"
fi
```

---
## Grundlagen
### Aufgaben
#### 2 - if 
Was ist dann aber dieses `if [ ... ]; then` was man überall sieht?
```bash
if [ "a" = "a" ]; then
  echo "equal!"
fi
```

Das ist eigentlich nur `Sytaktischer Zucker`, der effektiv das macht:
```bash
if test "a" = "a"; then
  echo "equal!"
fi
```

---
## Grundlagen
### Aufgaben
#### 2 - if 
Um also alle Möglichkeiten zu erfahren benutze:

`man test`

Dort erfährst du was man mit einem If (mit `[` klammern) so testen kann.

---
## Grundlagen
### Aufgaben
#### 2 - if 
Es gibt noch weitere möglichkeiten, aber `[` ist die häufigste:
https://unix.stackexchange.com/questions/306111/what-is-the-difference-between-the-bash-operators-vs-vs-vs

* `if [ condition ]`
  `[` is another name for the traditional test command. `[` / test is a standard POSIX utility. All POSIX shells have it builtin (though that's not required by POSIX²). The test command sets an exit code and the if statement acts accordingly. Typical tests are whether a file exists or one number is equal to another.
* `if [[ condition ]]`
  This is a new upgraded variation on test¹ from ksh that bash, zsh, yash, busybox sh also support. This [[ ... ]] construct also sets an exit code and the if statement acts accordingly. Among its extended features, it can test whether a string matches a wildcard pattern (not in busybox sh).
* `if ((condition))`
  Another ksh extension that bash and zsh also support. This performs arithmetic. As the result of the arithmetic, an exit code is set and the if statement acts accordingly. It returns an exit code of zero (true) if the result of the arithmetic calculation is nonzero. Like [[...]], this form is not POSIX and therefore not portable.
* `if (command)`
  This runs command in a subshell. When command completes, it sets an exit code and the if statement acts accordingly.
  A typical reason for using a subshell like this is to limit side-effects of command if command required variable assignments or other changes to the shell's environment. Such changes do not remain after the subshell completes.

* `if command`
  command is executed and the if statement acts according to its exit code.

**Note that `[ ... ]` and `[[ ... ]]` require whitespace around them, while `(...)` and `((...))` do not.**

---
## Grundlagen
### Aufgaben
#### 2 - if 
Schreibe ein Programm, das 
* "Datei gefunden" ausgibt, wenn die Datei `` existiert.
* "Datei nicht gefunden" ausgibt, wenn die Datei `~/testfile.txt` nicht existiert.

---
## Grundlagen
### Aufgaben
#### 2 - if 
```bash
if [ -f "~/testfile.txt" ]; then
  echo "Datei gefunden"
else 
  echo "Datei nicht gefunden"
fi
```