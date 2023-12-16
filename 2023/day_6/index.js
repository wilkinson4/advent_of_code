const fs = require('fs');

const data = fs.readFileSync('input.txt', { encoding: 'utf8', flag: 'r' });
const [time, currentRecord] = data.split('\n').map((line) => parseInt(line.replace(/\s/g, '')));
const results = [];

for (let j = 0; j <= time; j += 1) {
  const distance = j * (time - j);

  if (distance > currentRecord) {
    results.push(distance);
  }
}
console.log(results.length);
