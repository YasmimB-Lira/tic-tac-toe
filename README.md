# tic-tac-toe
Projeto construido durante as aulas de programação da unifacol para exemplificar a criação de um aplicativo usando flutter.

Funcionalidades já implementadas:

**Escolha de Jogador (O ou X)**:
   - O jogo alterna entre dois jogadores, "O" e "X", com base no turno.
   
**Lógica de Turno**:
   - O jogo alterna automaticamente entre os jogadores a cada jogada (jogador "O" e jogador "X").

**Contador de Tempo**:
   - Um temporizador de 10 segundos é iniciado assim que o jogo começa.
   - O temporizador é reiniciado a cada vez que um jogador faz uma jogada.
   - Quando o tempo acaba, o turno é trocado automaticamente, e o próximo jogador deve jogar.

**Verificação de Vencedor**:
   - O jogo verifica se algum jogador ganhou após cada jogada.
   - A verificação é feita comparando combinações de células vencedoras (linhas, colunas e diagonais).

**Declaração de Resultado**:
   - Quando um vencedor é encontrado, uma mensagem é exibida declarando o vencedor ("Player O Wins!" ou "Player X Wins!").
   - Se o jogo terminar em empate, é exibida uma mensagem indicando "It's a Draw!".

**Marcação de Células Vencedoras**:
   - As células que compõem a combinação vencedora são destacadas de maneira visual, mudando sua cor.
   - A lista `matchedIndexes` armazena os índices dessas células.

**Pontuação**:
   - O sistema mantém a pontuação para os jogadores "O" e "X".
   - Cada vez que um jogador vence, a pontuação é incrementada (usando as variáveis `oScore` e `xScore`).

**Botões de Controle**:
   - **Iniciar o Jogo**: Um botão "Iniciar Tempo" que começa o jogo e o temporizador.
   - **Reiniciar o Jogo**: Um botão "Restart Game" que reinicia o jogo, apagando o tabuleiro, zerando os resultados e redefinindo o estado inicial.

**Lógica de Jogo Interativo**:
    - O jogador pode tocar nas células do tabuleiro para fazer uma jogada.
    - O jogo bloqueia jogadas em células já preenchidas (não é possível colocar "O" ou "X" em uma célula já preenchida).

**Exibição da Pontuação**:
    - A pontuação dos jogadores é exibida a cima do tabuleiro, com o jogador "O" de um lado e o jogador "X" do outro.

### Como Funciona a Mecânica do Jogo:
- **Início do Jogo**: Quando o botão de "Iniciar Tempo" é pressionado, o temporizador começa a contagem regressiva de 10 segundos.
- **Troca de Turno**: A cada jogada, o turno do jogador é trocado, e o temporizador é reiniciado.
- **Verificação de Vitória**: Após cada jogada, o jogo verifica se algum jogador fez uma linha vencedora e, se sim, declara o vencedor.
- **Finalização de Jogo**: O jogo termina quando um jogador vence ou quando não há mais células disponíveis para jogar (empate).

Essas funcionalidades garantem que o jogo tenha uma experiência fluida e interativa, com controle de tempo e alternância de turnos, além de uma forma visual de destacar o vencedor. 
