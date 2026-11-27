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
Abbiamo scelto la forward/brake mode perchè così abbiamo più controllo sul nostro robot, perchè usa la slow decay mode (quindi nei primi millisecondi la corrente scende lentamente e le ruote velocemente). Inoltre ci permette di mantenere la linearità tra il voltaggio e la velocità angolare.
## Step 2
Abbiamo applicato vari voltaggi in input. Abbiamo messo un controllo che limita il voltaggio tra -6V e 6V in modo da non superare i limiti del nostro TurtleBot. Abbiamo fatto gli screen di 6V, 5V, 4V, 3V, 2V, 1V, -3V, 3.84V. Abbiamo deciso di usare la prior knowledge che ci ha fornito il prof e abbiamo usato 0.64 * 6V = 3.84V per i calcoli successivi.
## Step 3
Abbiamo letto la velocità angolare delle 2 ruote (in realtà leggevamo dall'encoder quante rotazioni vedeva e le abbiamo convertite nella velocità angolare a cui effettivamente stavano girando le ruote)
## Step 4
Abbiamo usato il metodo 63.2% per calcolare i valori reali dei parametri del robot (mu e T). Abbiamo osservato tramite il grafico che non c'è delay tau.
## Step 5
Dopodichè abbiamo usato il metodo della tangente con un filtro iniziale (non troppo alto, nè troppo basso, noi vogliamo smussare la parte iniziale della curva, quando sta salendo, ma non vogliamo creare troppo delay) e abbiamo calcolato per entrambe le ruote mu, tau e T.
## Step 6
Con i valori dei parametri che abbiamo trovato col metodo della tangente, abbiamo calcolato Kp e Ki per il nostro closed-loop per il prossimo laboratorio

# Lab 3
## Step 1
Abbiamo implementato il closed feedback loop (uno per motore) in modo che segua una reference speed. Abbiamo usato i valori di kp e ki trovati tramite il MATLAB del lab 2
## Step 2
Abbiamo implementato la forward/coast e una variabile per scegliere in modo rapido se usare la forward/brake o la forward/coast. Con la forward/coast abbiamo notato che la ruota più lenta riesce a girare un po più velocemente
## Step 3
Abbiamo implementato nel closed feedback loop il blocco della saturazione (ovviamente uno per motore) per inserire l'Anti Wind-Up
