int [][] M; //Matriz M
int cx, cy; //variaveis armazenam o valor do mouse/30 
int px, py; //variaveis armazenam a posição do personagem
int controle; //varivel de controle de direção do personagem
int aux; //variavel auxiliar
boolean jogando = false;

void setup() {
  size(900, 600);
  M = new int [30][20];
  textAlign(CENTER);
  colorMode(HSB, 360, 100, 100);
  textSize(20);
  aux = 0;
  px = 15;
  py = 10;
}

void draw() {
  background(0);
  display();
  if (jogando)
    sprite();
}

/*
* Função display()
 * percorre a matriz e verifica o valor das célular
 * dependendo do valor da celula (0,1,2), a função imprime um objeto diferente na tela
 */
void display() {
  for (int i = 0; i < M.length; i++) {
    for (int j = 0; j < M[0].length; j++) {
      if (M[i][j] == 0) { // livre
        stroke(240, 56, 20);
        fill(240, 56, 27);
        rect(i*30, j*30, 30, 30);
      }
      if (M[i][j] == 1) { // barreira
        noStroke();
        fill(21, 10, 100);
        rect(i*30, j*30, 30, 30);
      }
      if ( M[i][j] == 2) { // frutinha
        stroke(240, 56, 20);
        fill(240, 56, 27);
        rect(i*30, j*30, 30, 30);
        fill(24, 65, 97);
        circle(15+30*i, 15+30*j, 7);
      }
    }
  }
}

/*
* Função sprite()
 * define forma, posição e direção do personagem
 */
void sprite() {
  noStroke();
  fill(51, 62, 100);
  circle(px*30+15, py*30+15, 30);

  if (controle == 0) {
    fill(51, 62, 100);
    rect(px*30+10, py*30-6, 8, 12, 8);
    fill(240, 56, 27);
    rect(px*30+19, py*30, 4, 12, 10);
    fill(0);
    circle(px*30+10, py*30+8, 8);
  }
  if (controle == 1) {
    fill(51, 62, 100);
    rect(px*30+10, py*30+24, 8, 12, 8);
    fill(240, 56, 27);
    rect(px*30+19, py*30+18, 4, 12, 10);
    fill(0);
    circle(px*30+10, py*30+20, 8);
  }
  if (controle == 2) {
    fill(51, 62, 100);
    rect(px*30-6, py*30+8, 12, 8, 8);
    fill(240, 56, 27);
    rect(px*30, py*30+18, 12, 4, 10);
    fill(0);
    circle(px*30+10, py*30+8, 8);
  }
  if (controle == 3) {
    fill(51, 62, 100);
    rect(px*30+24, py*30+8, 12, 8, 8);
    fill(240, 56, 27);
    rect(px*30+18, py*30+17, 12, 4, 10);
    fill(0);
    circle(px*30+20, py*30+8, 8);
  }
}

/*
* Função frutinhas()
 * percorre a matriz e preenche com valor 2 cada celula com valor 0
 */
void frutinhas() {
  for (int i = 0; i < M.length; i++) {
    for (int j = 0; j < M[0].length; j++) {
      if (M[i][j] != 1)
        M[i][j] = 2;
    }
  }
}

/*
* Função limiteMouse()
 * impede erro array out of bounds para função do mouse
 */
boolean limiteMouse() {
  if (cx >= 0 && cx <= 29 && cy >= 0 && cy <= 19) return true;
  return false;
}

/*
* Função mouseDragged()
 * define como 1 valor da celula clicada com botão esquerdo
 * define como 0 valor da celula clicada com botão direito
 */
void mouseDragged() {
  cx = mouseX/30;
  cy = mouseY/30;
  if (limiteMouse()) {
    if (mouseButton == RIGHT) {
      M[cx][cy] = 0;
    }
    if (mouseButton == LEFT) {
      M[cx][cy] = 1;
    }
  }
}

/*
* Função comer()
 * transforma celula pela qual esteve o personagem de valor 2 para 0
 */
void comer() {
  if (limitesComer()) {
    if (M[px][py]==2) {
      M[px][py]=0;
    }
  }
}

/*
* Função limitesComer()
 * limita que a função comer() funcione apenas dentro do espaço de tela
 * possibilita desenvolver função para que o personagem apareça do outro lado da tela
 sempre que sair (não implementado)
 */
boolean limitesComer() {
  if (px > -1 && px < 30 && py > -1 && py < 20) return true;
  return false;
}

/*
* Função barreiras()
 * verifica existencia de barreiras ou obstaculos no caminho do personagem
 * se verdade, o personagem pode andar
 * se falso, o personagem nao pode andar
 */
boolean barreiras() {
  if (keyCode == UP)
    if (M[px][py-1] == 1) return false; //UP
  if (keyCode == DOWN)
    if (M[px][py+1] == 1) return false; //DOWN
  if (keyCode == LEFT)
    if (M[px-1][py] == 1) return false; //LEFT
  if (keyCode == RIGHT)
    if (M[px+1][py] == 1) return false; //RIGHT
  return true;
}


/*
* Função keyPressed()
 * quando o botão ENTER é pressionado o jogo começa, liberando a construção do personagem
 ** chamada da função frutinhas()
 *** aux impede que função frutinhas() seja chamada mais de uma vez
 *
 * quando botões UP, DOWN, LEFT e RIGHT são pressionados, há a movimentação do personagem
 e atualização da variável de controle de direçãp
 * chamada da função comer()
 */
void keyPressed() {
  if (keyCode == ENTER) {
    if (aux != 1) frutinhas();
    jogando = true;
    aux = 1;
  }
  if (keyCode == UP) {
    if (py>0 && barreiras()) {
      py-=1; 
      controle = 0;
    }
  }
  if (keyCode == DOWN) {
    if (py<19 && barreiras()) {
      py+=1;
      controle = 1;
    }
  }
  if (keyCode == LEFT) {
    if (px>0 && barreiras()) {
      px-=1;
      controle = 2;
    }
  }
  if (keyCode == RIGHT) {
    if (px<29 && barreiras()) {
      px+=1;
      controle = 3;
    }
  }
  comer();
}
