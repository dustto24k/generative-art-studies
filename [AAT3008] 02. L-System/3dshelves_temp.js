let S = "S";
let Rule = "F[+F]F[-F]F";
let x = 0, y = 0, z = 0;
let th = 0, pi = HALF_PI;
let A = radians(-60);

function setup()
{
  createCanvas(800, 800, WEBGL);
}

function draw()
{
  background(220);
  rectMode(CENTER);
  // render(S);
}

function render(S)
{
  for (let i = 0; i < S.length(); i++)
    {
      switch(S[i])
        {
          case 'F':
            x = 50 * sin(pi) * sin(th);
            y = 50 * cos(pi);
            z = 50 * sin(pi) * cos(th);
            translate(x, y, z);
            box(50, 80, 7.5);
            break;
          case '+':
          case '[':
            push();
            break;
          case ']':
            pop();
            break;
          case '*':
            let nX = 0, nY = 0; nZ = 0;
        }
    }
}

function keyPressed()
{
  S = ApplyRule(S);
}

function ApplyRule(S)
{
  let result = "";
  for (let i = 0; i < S.length(); ++i)
    {
      let c = S[i];
      if (c === 'F')
      {
        result += Rule;
      }
      else
      {
        result += c;
      }
    }
  return result;
}