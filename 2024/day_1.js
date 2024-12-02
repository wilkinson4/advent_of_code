const fs = require('fs');

fs.readFile('./day_1_part_1_input.txt', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  let leftList = [];
  let rightList = [];

  const parsedData = data
    .split(new RegExp('\n'))
    .map((line) => line.split('   '));

  for (let i = 0; i < parsedData.length; i++) {
    leftList.push(parseInt(parsedData[i][0]));
    rightList.push(parseInt(parsedData[i][1]));
  }

  const sortedLeft = leftList.sort().filter((item) => Number.isInteger(item));
  const sortedRight = rightList.sort().filter((item) => Number.isInteger(item));
  let total = 0;

  for (let i = 0; i < sortedLeft.length; i++) {
    total += Math.abs(sortedLeft[i] - sortedRight[i]);
  }

  console.log('total', total);

  let similarityScore = 0;

  for (let i = 0; i < leftList.length; i++) {
    if (Number.isNaN(leftList[i]) || Number.isNaN(rightList[i])) {
    } else {
      let occurrences = 0;
      occurrences = rightList.filter((item) => leftList[i] === item).length;
      similarityScore += occurrences * leftList[i];
    }
  }
  console.log('similarityScore', similarityScore);
});
