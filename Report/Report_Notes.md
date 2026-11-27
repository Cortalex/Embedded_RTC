# Lab 1
## Ex 1
We found out that the diagonal of the matrix of the keypad goes from '*' to 'A' instead of going from '1' to 'D'. We used the same I2C protocol for both slaves. We saved in 2 different areas of memory the values of the registers of the keypad.
## Ex 2
We used the switch case because it was the fastest method to handle the situation. We worked with the indices of the matrix.
## Ex 3
Same i2c line, change address for the line sensor
## Ex 4
We simply used the structure of the polling to implement the interrupt. as deafult and if it's pressed a key that is not a number, we chosed to used a frequency of 1hz, a period of 1 s
## Ex 5
We used the same loop of the lab0. we have the pin which turns o, delay, turns of, delay. we impement a switch case that convert what we read form the keypad into a period in milliseconds.

# Lab2
## Step 1
Abbiamo scelto la forward/brake mode perchè così abbiamo più controllo sul nostro robot, visto che possiamo effettivamente frenare. Inoltre usare la slow decay mode (quindi nei primi millisecondi la corrente scende lentamente e le ruote rallentano velocemente) ci permette di mantenere la linearità tra il voltaggio e la velocità angolare.
## Step 2
Abbiamo applicato vari voltaggi in input (6V, 5V, 4V, 3V, 2V, 1V, -3V, 3.84V) e abbiamo salvato gli screenshot e i file .mat dei segnali di input (voltaggi) e output (velocità angolari della ruota). Abbiamo messo un controllo che limita il voltaggio tra -6V e 6V in modo da non superare i limiti del nostro TurtleBot. Osservando le 2 costanti definite dal professore V2DUTY e DUTY2V abbiamo intuito che la variabile duty in realtà si riferisce al numero di tick del timer. Abbiamo deciso di usare la prior knowledge che ci ha fornito il prof e abbiamo deciso di usare 0.64 * 6V = 3.84V come tensione per i calcoli successivi.
## Step 3
Abbiamo letto la velocità angolare delle 2 ruote grazie ai 2 encoder dei 2 motori. Noi in realtà leggevamo quanti impulsi vedeva l'encoder e li abbiamo convertiti nella velocità angolare a cui effettivamente stavano girando le ruote.
## Step 4
Abbiamo usato il metodo 63.2% per calcolare i valori reali dei parametri del robot (μ e T). Abbiamo osservato tramite il grafico che non c'è delay τ.
## Step 5
Dopodichè abbiamo usato il metodo della tangente con un filtro iniziale. Il valore della frequenza di taglio non doveva essere nè troppo alto (perchè sarebbe stato un filtro inutile), nè troppo basso (perchè avrebbe creato troppo delay). Il nostro obiettivo era smussare la parte iniziale della curva, quando sta salendo rapidamente, per trovare la vera pendenza massima (senza essere ingannati da del rumore) e abbiamo calcolato per entrambe le ruote μ, τ e T. Qui abbiamo trovato un τ>0 dovuto all'aggiunta del filtro passa basso e dovuto all'approsimazione del polo che abbiamo trascurato.
## Step 6
Con i valori dei parametri che abbiamo trovato col metodo della tangente, abbiamo calcolato Kp e Ki per entrambe le ruote tramite il metodo Ziegler-Nicholas ad open loop. Questi valori saranno da usare per il closed-loop per il prossimo laboratorio.

# Lab 3
## Esercizio 1
Abbiamo implementato il closed feedback loop (uno per motore) con un controllore PI in modo che segua una reference speed decisa da noi. Ne abbiamo provate varie (anche negative) e abbiamo salvato gli screenshot e i file .mat dei segnali di voltaggio e velocità angolare. Abbiamo usato i valori di kp e ki trovati tramite il metodo della tangente del lab 2.
## Esercizio 2
Abbiamo implementato la forward/coast e tramite il valore di una variabile scegliamo in modo rapido se usare la forward/brake o la forward/coast. Con la forward/coast abbiamo notato che la ruota più lenta riesce a girare un po più velocemente (ed ha senso perchè in coast non freniamo e quindi la velocità angolare cala lentamente). Abbiamo provato varie reference speed e abbiamo salvato i file .mat
## Esercizio 3
Abbiamo implementato nel closed feedback loop il blocco "Anti Wind-Up" per bloccare l'accumulo nell'integratore quando il segnale satura (ovviamente uno per motore).
