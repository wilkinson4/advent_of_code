const fs = require('fs');

function solvePartOne(input) {
  const result = input.reduce((acc, [num1, num2]) => {
    return (acc += num1 * num2);
  }, 0);

  console.log('Part One: ', result);
}
fs.readFile('./day_3_input.txt', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  const input = data
    .trim()
    .split('\n')
    .map((line) => {
      const re = /mul\(\d+,\d+\)/gm;
      return line.match(re);
    })
    .flatMap((line) => line)
    .map((line) => line.match(/\d+/gm));

  solvePartOne(input);
});
