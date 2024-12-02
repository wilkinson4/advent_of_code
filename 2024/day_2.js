const fs = require('fs');

function isSafe(line) {
  const increasing = line[0] < line[1];
  return line.every((currVal, index, items) => {
    const nextVal = items[index + 1];

    if (!nextVal) {
      const prevVal = items[index - 1];
      return increasing
        ? prevVal < currVal && prevVal - currVal <= 3
        : prevVal > currVal && currVal - prevVal <= 3;
    } else if (increasing) {
      return currVal < nextVal && nextVal - currVal <= 3;
    } else {
      return currVal > nextVal && currVal - nextVal <= 3;
    }
  });
}

function isSafeDampened(line) {
  return line.some((_currVal, index, items) => {
    return isSafe(items.filter((_, i) => i !== index));
  });
}

function solvePartOne(input) {
  const numSafePartOne = input.reduce((acc, line) => {
    const increasing = line[0] < line[1];
    if (isSafe(line, increasing)) {
      return ++acc;
    } else {
      return acc;
    }
  }, 0);

  console.log('number of safe lines part one: ', numSafePartOne);
}

function solvePartTwo(input) {
  const numSafePartTwo = input.reduce((acc, line) => {
    if (isSafeDampened(line)) {
      return ++acc;
    } else {
      return acc;
    }
  }, 0);

  console.log('number of safe lines part two: ', numSafePartTwo);
}

fs.readFile('./day_2_input.txt', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  const input = data
    .split(new RegExp('\n'))
    .map((line) => line.split(' ').map((item) => parseInt(item)))
    .filter((line) => line.every((item) => Number.isInteger(item)));

  solvePartOne(input);

  solvePartTwo(input);
});
