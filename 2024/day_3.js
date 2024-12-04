const fs = require('fs');

function solvePartOne(input) {
  const result = input
    .split('\n')
    .map((line) => {
      const re = /mul\(\d+,\d+\)/gm;
      return line.match(re);
    })
    .flatMap((line) => line)
    .map((line) => line.match(/\d+/gm))
    .reduce((acc, [num1, num2]) => {
      return (acc += num1 * num2);
    }, 0);

  console.log('Part One: ', result);
}

function solvePartTwo(input) {
  const result = input
    .replace(/don't\(\)[\s\S]+?do\(\)/g, '')
    .split('\n')
    .map((line) => {
      const re = /mul\(\d+,\d+\)/g;
      return line.match(re);
    })
    .flatMap((line) => line)
    .map((line) => line.match(/\d+/g))
    .reduce((acc, [num1, num2]) => {
      return (acc += num1 * num2);
    }, 0);

  console.log('Part Two: ', result);
}

fs.readFile('./day_3_input.txt', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  const input = data.trim();

  solvePartOne(input);
  solvePartTwo(input);
});

