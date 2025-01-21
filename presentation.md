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

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
In Bash gibt es hauptsächlich zwei Arten von Schleifen:
* `for` Schleifen
* `while` Schleifen

Die `for` Schleife wird meist verwendet um:
* über Listen zu iterieren
* über Dateien zu iterieren
* oder einfach etwas x-mal auszuführen

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
Beispiele für `for`:
```bash
# Über eine Liste iterieren
for i in 1 2 3 4 5; do
    echo $i
done

# Über einen Bereich iterieren
for i in {1..5}; do
    echo $i
done

# Über Dateien iterieren
for file in *.txt; do
    echo "Gefundene Datei: $file"
done

# C-style for Schleife
for ((i=0; i<5; i++)); do
    echo $i
done
```

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
Die `while` Schleife wird verwendet wenn man:
* solange etwas ausführen will, bis eine Bedingung erfüllt ist
* unendlich lange etwas ausführen will
* eine Datei Zeile für Zeile lesen will

Beispiele:
```bash
# Zähle bis 5
count=1
while [ $count -le 5 ]; do
    echo $count
    count=$((count + 1))
done

# Datei Zeile für Zeile lesen
while read -r line; do
    echo "Zeile: $line"
done < "dummy1.txt"

# Unendliche Schleife
# (auskommentiert um die Präsentation nicht aufzuhängen :-)
#
#while true; do
#    echo "Ich laufe für immer..."
#    sleep 1
#done
```

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
Aufgabe: Schreibe ein Programm das:
1. Die Zahlen von 1 bis 10 ausgibt
2. Bei jeder Zahl prüft ob sie gerade ist (Tipp: `$((n % 2))` gibt den Rest der Division durch 2)
3. "Gerade" oder "Ungerade" entsprechend ausgibt

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
Lösung:
```bash
#!/usr/bin/env bash

for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "$i ist gerade"
    else
        echo "$i ist ungerade"
    fi
done
```

---
## Grundlagen
### Aufgaben
#### 3 - Schleifen
Alternative Lösung mit while:
```bash
#!/usr/bin/env bash

i=1
while [ $i -le 10 ]; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "$i ist gerade"
    else
        echo "$i ist ungerade"
    fi
    i=$((i + 1))
done
```

---
## Grundlagen
### Aufgaben
#### 4 - Variablen
In Bash werden Variablen einfach durch Zuweisung erstellt:
```bash
name="Max"
alter=25
```

Wichtig: 
* KEINE Leerzeichen um das `=`
* Strings können mit oder ohne Anführungszeichen definiert werden
* Zugriff auf Variablen mit `$` davor

Beispiel:
```bash
name="Max"
echo "Hallo $name"
echo 'Hallo $name'   # Einzelne Anführungszeichen verhindern Variable-Ersetzung!
echo Hallo $name
```

---
## Grundlagen
### Aufgaben
#### 4 - Variablen
Besondere Variablen:
* `$1, $2, ...` - Kommandozeilenargumente
* `$#` - Anzahl der Kommandozeilenargumente
* `$?` - Exit-Code des letzten Befehls
* `$0` - Name des Scripts
* `$@` - Alle Kommandozeilenargumente als Liste

Beispiel:
```bash
#!/usr/bin/env bash
echo "Script Name: $0"
echo "Erstes Argument: $1"
echo "Zweites Argument: $2"
echo "Anzahl Argumente: $#"
echo "Alle Argumente: $@"
```

---
## Grundlagen
### Aufgaben
#### 4 - Variablen
Aufgabe: Schreibe ein Programm das:
1. Eine Variable `name` mit deinem Namen definiert
2. Eine Variable `geburtstag` mit deinem Geburtstag definiert
3. Beides in einem schönen Satz ausgibt
4. Zusätzlich prüft ob ein Kommandozeilenargument übergeben wurde
   * Wenn ja, wird statt dem definierten Namen der übergebene Name verwendet
   * Wenn nein, wird der definierte Name verwendet

---
## Grundlagen
### Aufgaben
#### 4 - Variablen
Lösung:
```bash
#!/usr/bin/env bash

name="Max"
geburtstag="01.01.2000"

if [ $# -gt 0 ]; then
    name=$1
fi

echo "Hallo, ich bin $name und wurde am $geburtstag geboren."
```

Test:
```bash
./script.sh         # Verwendet "Max"
./script.sh Peter   # Verwendet "Peter"
```

---
## Grundlagen
### Aufgaben
#### 5 - Funktionen
Funktionen helfen Code zu strukturieren und Wiederholungen zu vermeiden.
Syntax:
```bash
function name() {
    # Code hier
}

# oder kürzer:
name() {
    # Code hier
}
```

Die Funktion kann dann einfach mit ihrem Namen aufgerufen werden:
```bash
#!/usr/bin/env bash

hello() {
    echo "Hallo Welt!"
}

hello  # Ruft die Funktion auf
```

---
## Grundlagen
### Aufgaben
#### 5 - Funktionen
Funktionen können auch Parameter entgegennehmen:
```bash
greet() {
    echo "Hallo $1!"
}

greet "Max"     # gibt "Hallo Max!" aus
greet "Peter"   # gibt "Hallo Peter!" aus
```

Innerhalb der Funktion sind die Parameter wie bei Scripten zugänglich:
* `$1, $2, ...` - Parameter
* `$#` - Anzahl der Parameter
* `$@` - Alle Parameter als Liste

---
## Grundlagen
### Aufgaben
#### 5 - Funktionen
Rückgabewerte werden über den exit code zurückgegeben:
```bash
is_even() {
    if [ $(($1 % 2)) -eq 0 ]; then
        return 0    # true in bash
    else
        return 1    # false in bash
    fi
}

if is_even 4; then
    echo "4 ist gerade"
fi
```

---
## Grundlagen
### Aufgaben
#### 5 - Funktionen
Aufgabe: Schreibe ein Programm das:
1. Eine Funktion `check_file` enthält, die einen Dateinamen als Parameter nimmt
2. Die Funktion soll prüfen ob die Datei existiert
3. Wenn ja, soll sie den Inhalt der Datei ausgeben
4. Wenn nein, soll sie "Datei nicht gefunden" ausgeben
5. Teste die Funktion mit den Dateien "dummy1.txt" und "nicht-da.txt"

---
## Grundlagen
### Aufgaben
#### 5 - Funktionen
Lösung:
```bash
#!/usr/bin/env bash

check_file() {
    if [ -f "$1" ]; then
        echo "Inhalt von $1:"
        cat "$1"
    else
        echo "Datei $1 nicht gefunden"
    fi
}

check_file "dummy1.txt"
echo "---"
check_file "nicht-da.txt"
```

---
## Grundlagen
### Aufgaben
#### 6 - Arrays und Strings
Arrays werden in Bash mit runden Klammern definiert:
```bash
# Array definieren
farben=("rot" "grün" "blau")

# Einzelnes Element ausgeben (Index beginnt bei 0)
echo ${farben[0]}    # gibt "rot" aus

# Alle Elemente ausgeben
echo ${farben[@]}    # gibt "rot grün blau" aus

# Länge des Arrays
echo ${#farben[@]}   # gibt "3" aus
```

---
## Grundlagen
### Aufgaben
#### 6 - Arrays und Strings
String-Operationen sind in Bash sehr mächtig:
```bash
text="Hallo Welt"

# Länge
echo ${#text}        # gibt "10" aus

# Teilstring (von Position 6, Länge 4)
echo ${text:6:4}     # gibt "Welt" aus

# Ersetzen
echo ${text/Welt/Bash}   # gibt "Hallo Bash" aus

# Groß-/Kleinschreibung
echo ${text^^}       # gibt "HALLO WELT" aus
echo ${text,,}       # gibt "hallo welt" aus
```

---
## Grundlagen
### Aufgaben
#### 6 - Arrays und Strings
Aufgabe: Schreibe ein Programm das:
1. Ein Array mit mindestens 3 Dateinamen definiert
2. Für jeden Dateinamen im Array:
   * Prüft ob die Datei existiert
   * Den Dateinamen in Großbuchstaben ausgibt
   * Die Anzahl der Zeichen im Dateinamen ausgibt
3. Am Ende die Gesamtzahl der gefundenen Dateien ausgibt

---
## Grundlagen
### Aufgaben
#### 6 - Arrays und Strings
Lösung:
```bash
#!/usr/bin/env bash

# Array mit Dateinamen
files=("dummy1.txt" "dummy2.txt" "nicht-da.txt")
found=0

for file in "${files[@]}"; do
    echo "Prüfe ${file^^}"
    echo "Länge des Dateinamens: ${#file}"
    
    if [ -f "$file" ]; then
        echo "Datei existiert"
        found=$((found + 1))
    else
        echo "Datei existiert nicht"
    fi
    echo "---"
done

echo "Gefundene Dateien: $found von ${#files[@]}"
```

---
## Grundlagen
### Aufgaben
#### 7 - Kommando-Substitution
Mit `$(command)` kann man die Ausgabe eines Befehls in einem anderen Befehl oder einer Zuweisung verwenden:
```bash
# Aktuelles Datum in Variable speichern
datum=$(date)
echo "Heute ist: $datum"

# Anzahl Zeilen in einer Datei
zeilen=$(wc -l < dummy1.txt)
echo "Die Datei hat $zeilen Zeilen"

# Verschachtelte Kommandos
files=$(ls $(pwd))
```

---
## Grundlagen
### Aufgaben
#### 7 - Kommando-Substitution
Es gibt auch eine ältere Syntax mit Backticks:
```bash
datum=`date`    # Funktioniert, aber $(command) ist besser lesbar
```

Vorteile von `$(command)`:
* Besser lesbar
* Einfacher zu verschachteln
* Moderner Standard

---
## Grundlagen
### Aufgaben
#### 7 - Kommando-Substitution
Aufgabe: Schreibe ein Programm das:
1. Das aktuelle Verzeichnis ermittelt (`pwd`)
2. Alle .txt Dateien im Verzeichnis zählt (`ls *.txt | wc -l`)
3. Für jede gefundene Datei:
   * Die Größe ermittelt (`wc -c`)
   * Das Änderungsdatum ausgibt (`stat -c %y`)
4. Am Ende die Gesamtgröße aller Dateien ausgibt

---
## Grundlagen
### Aufgaben
#### 7 - Kommando-Substitution
Lösung:
```bash
#!/usr/bin/env bash

dir=$(pwd)
echo "Aktuelles Verzeichnis: $dir"

anzahl=$(ls *.txt 2>/dev/null | wc -l)
echo "Gefundene .txt Dateien: $anzahl"

gesamt=0
for file in *.txt; do
    if [ -f "$file" ]; then
        groesse=$(wc -c < "$file")
        datum=$(stat -c %y "$file")
        echo "Datei: $file"
        echo "  Größe: $groesse Bytes"
        echo "  Geändert: $datum"
        gesamt=$((gesamt + groesse))
    fi
done

echo "Gesamtgröße aller .txt Dateien: $gesamt Bytes"
```

---
## Grundlagen
### Aufgaben
#### 8 - Ein-/Ausgabe-Umleitung
In Bash gibt es verschiedene Möglichkeiten die Ein-/Ausgabe umzuleiten:

* `>` - Ausgabe in Datei schreiben (überschreibt)
* `>>` - Ausgabe an Datei anhängen
* `<` - Eingabe aus Datei lesen
* `|` - Ausgabe als Eingabe für nächsten Befehl verwenden (Pipe)

Beispiele:
```bash
# Ausgabe in Datei schreiben (überschreibt alte Datei)
echo "Hallo" > ausgabe.txt

# Ausgabe an Datei anhängen
echo "Welt" >> ausgabe.txt

# Eingabe aus Datei lesen
sort < namen.txt

# Mehrere Befehle verketten (Pipes)
cat datei.txt | grep "Hallo" | wc -l
```

---
## Grundlagen
### Aufgaben
#### 8 - Ein-/Ausgabe-Umleitung
Es gibt auch Umleitungen für Fehlerausgaben:
* `2>` - Fehler in Datei umleiten
* `2>>` - Fehler an Datei anhängen
* `2>&1` - Fehler zur normalen Ausgabe umleiten

Beispiele:
```bash
# Nur Fehler in Datei schreiben
ls nicht-da.txt 2> fehler.log

# Normale Ausgabe und Fehler in verschiedene Dateien
ls *.txt > ausgabe.log 2> fehler.log

# Beide in die gleiche Datei
ls *.txt > alle.log 2>&1
```

---
## Grundlagen
### Aufgaben
#### 8 - Ein-/Ausgabe-Umleitung
Aufgabe: Schreibe ein Programm das:
1. Eine Liste von Wörtern in eine Datei schreibt
2. Weitere Wörter an die Datei anhängt
3. Die Datei sortiert und Duplikate entfernt
4. Das Ergebnis in eine neue Datei schreibt

---
## Grundlagen
### Aufgaben
#### 8 - Ein-/Ausgabe-Umleitung
Lösung:
```bash
#!/usr/bin/env bash

# Erste Liste schreiben
echo "Apfel
Banane
Citrone" > fruechte.txt

# Weitere Früchte anhängen
echo "Banane
Dattel
Apfel" >> fruechte.txt

# Sortieren, Duplikate entfernen und in neue Datei schreiben
sort fruechte.txt | uniq > sortiert.txt

# Ergebnis anzeigen
echo "Sortierte Liste ohne Duplikate:"
cat sortiert.txt

# Beispiel aufräumen
rm fruechte.txt sortiert.txt
```

Erklärung der Pipe `sort | uniq`:
* `sort` sortiert die Zeilen alphabetisch
* `uniq` entfernt aufeinanderfolgende Duplikate
* Daher muss erst sortiert werden, damit `uniq` funktioniert

---
## Grundlagen
### Aufgaben
#### 9 - Wichtige Befehle
Bash Built-in Befehle (direkt in Bash eingebaut):
* `cd` - Verzeichnis wechseln
* `pwd` - Aktuelles Verzeichnis anzeigen
* `echo` - Text ausgeben
* `read` - Benutzereingabe lesen
* `exit` - Script beenden
* `export` - Umgebungsvariablen setzen
* `source` / `.` - Script im aktuellen Kontext ausführen

---
## Grundlagen
### Aufgaben
#### 9 - Wichtige Befehle
Wichtige Unix Tools (meist vorinstalliert):
* `ls` - Dateien auflisten
* `cat` - Datei ausgeben
* `grep` - Text suchen
* `sed` - Text ersetzen
* `awk` - Text verarbeiten
* `sort` - Zeilen sortieren
* `uniq` - Duplikate entfernen
* `wc` - Zeilen/Wörter/Zeichen zählen
* `find` - Dateien suchen
* `xargs` - Befehle mit Argumenten aufrufen

---
## Grundlagen
### Aufgaben
#### 9 - Wichtige Befehle
Beispiele für Kombinationen:
```bash
# Alle .txt Dateien finden und deren Inhalt durchsuchen
find . -name "*.txt" -exec grep "Hallo" {} \;

# Alternative mit Pipe
find . -name "*.txt" | xargs grep "Hallo"

# Text in allen Dateien ersetzen
sed -i 's/alt/neu/g' *.txt

# Komplexe Textverarbeitung mit awk
ls -l | awk '{sum += $5} END {print "Gesamtgröße: " sum " Bytes"}'
```

---
## Grundlagen
### Aufgaben
#### 9 - Wichtige Befehle
Aufgabe: Schreibe ein Programm das:
1. Den Benutzer nach einem Suchbegriff fragt
2. Alle .txt Dateien im aktuellen Verzeichnis nach diesem Begriff durchsucht
3. Die gefundenen Zeilen mit Dateinamen ausgibt
4. Am Ende die Anzahl der Fundstellen ausgibt

---
## Grundlagen
### Aufgaben
#### 9 - Wichtige Befehle
Lösung:
```bash
#!/usr/bin/env bash

echo "Nach was sollen wir suchen?"
read -r suchbegriff

echo "Suche nach: $suchbegriff"
echo "---"

# Suche durchführen und Ergebnisse in Variable speichern
ergebnisse=$(grep -n "$suchbegriff" *.txt 2>/dev/null)
anzahl=$(echo "$ergebnisse" | grep -c "")

if [ $anzahl -gt 0 ]; then
    echo "$ergebnisse"
    echo "---"
    echo "Gefunden: $anzahl mal"
else
    echo "Keine Treffer gefunden"
fi
```

Erklärung der Optionen:
* `grep -n` - Zeilennummern anzeigen
* `grep -c` - Nur Anzahl der Treffer ausgeben
* `2>/dev/null` - Fehlermeldungen ignorieren

---
## Grundlagen
### Aufgaben
#### 10 - Umgebungsvariablen
Umgebungsvariablen sind spezielle Variablen die:
* für alle Prozesse verfügbar sind
* von der Shell vererbt werden
* oft für Konfiguration verwendet werden

Wichtige Befehle:
```bash
# Alle Umgebungsvariablen anzeigen
env
printenv

# Eine spezifische Variable anzeigen
echo $PATH
printenv PATH

# Variable setzen (nur für aktuelles Script)
PATH="/usr/local/bin:$PATH"

# Variable exportieren (für alle Kindprozesse)
export PATH="/usr/local/bin:$PATH"
```

---
## Grundlagen
### Aufgaben
#### 10 - Umgebungsvariablen
Die wichtigste Umgebungsvariable: `PATH`
* Enthält Liste von Verzeichnissen
* Getrennt durch `:`
* Wird durchsucht wenn man Befehle eingibt
* Reihenfolge ist wichtig!

Beispiel:
```bash
echo $PATH
# /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Eigenes Verzeichnis zum PATH hinzufügen
export PATH="$HOME/bin:$PATH"

# Jetzt werden auch Programme in ~/bin gefunden
meinscript.sh   # funktioniert wenn es in ~/bin liegt
```

---
## Grundlagen
### Aufgaben
#### 10 - Umgebungsvariablen
Weitere wichtige Umgebungsvariablen:
* `HOME` - Heimatverzeichnis des Benutzers
* `USER` - Aktueller Benutzername
* `SHELL` - Pfad zur aktuellen Shell
* `PWD` - Aktuelles Arbeitsverzeichnis
* `LANG` - Spracheinstellungen
* `PS1` - Prompt-Format
* `TERM` - Terminal-Typ

---
## Grundlagen
### Aufgaben
#### 10 - Umgebungsvariablen
Aufgabe: Schreibe ein Programm das:
1. Den aktuellen PATH ausgibt (ein Verzeichnis pro Zeile)
2. Prüft ob `/usr/local/bin` im PATH ist
3. Wenn nicht, fügt es am Anfang des PATH hinzu
4. Den neuen PATH ausgibt

---
## Grundlagen
### Aufgaben
#### 10 - Umgebungsvariablen
Lösung:
```bash
#!/usr/bin/env bash

echo "Aktueller PATH:"
echo "$PATH" | tr ':' '\n'
echo "---"

if [[ $PATH != */usr/local/bin* ]]; then
    echo "/usr/local/bin nicht gefunden, füge hinzu..."
    export PATH="/usr/local/bin:$PATH"
    echo "---"
    echo "Neuer PATH:"
    echo "$PATH" | tr ':' '\n'
else
    echo "/usr/local/bin bereits im PATH"
fi
```

Erklärung:
* `tr ':' '\n'` - ersetzt `:` durch Zeilenumbrüche
* `*pattern*` - prüft ob Muster irgendwo im String vorkommt
* `export` macht die Änderung für Kindprozesse verfügbar

---
## Ende
Das war ein überblick über wie so eine Shell bzw. Shell scripte funktionieren.

Grundsätzlich gilt - Man kann **ALLES** mit bash machen, da man einfach jedes beliebige Programm aufrufen kann und dann den output davon weiterverarbeiten kann.

Es gibt für sehr viele nervige Tasks ganz spezielle Programme, mit denen man vieles mit einer kleinen Zeile automatisieren kann, wo man in anderen Sprachen (e.g. js) wesentlich mehr code braucht.

---
## Ende
### Beispiele:
* Zuschneiden von Bildern mit imagemagick:
  ```bash
  # Alle JPGs rekursiv verkleinern:
  find . -name "*.jpg" -exec convert {} -resize 800x {} \;
  ```

---
## Ende
### Beispiele:

* Durchhangeln durch JSON mit jq:
  ```bash
  # Alle Namen aus einem JSON Array extrahieren:
  cat data.json | jq -r '.users[].name'
  # Komplexere Transformation:
  cat data.json | jq '.users[] | select(.age > 18) | {name, email}'
  ```

---
## Ende
### Beispiele:

* Bulk Umbenennungen von Dateien:
  ```bash
  # Alle Leerzeichen durch Unterstriche ersetzen:
  find . -type f -name "* *" -exec bash -c 'mv "$1" "${1// /_}"' _ {} \;
  ```

---
## Ende
### Beispiele:

* Dateien finden und verarbeiten:
  ```bash
  # Alle PDFs finden die älter als 30 Tage sind:
  find . -name "*.pdf" -mtime +30
  # Alle leeren Dateien löschen:
  find . -type f -empty -delete
  ```

---
## Ende
### Beispiele:

* Text in vielen Dateien ersetzen:
  ```bash
  # In allen .txt Dateien 'alt' durch 'neu' ersetzen:
  find . -name "*.txt" -exec sed -i 's/alt/neu/g' {} \;
  ```

---
## Ende

Man muss nur für einige dinge die entsprechenden Programme auch installiert haben. 

(und schauen, das jeder, der das script benutzt diese einfach installieren kann / eh schon hat)

---
## Ende

Have FUN!