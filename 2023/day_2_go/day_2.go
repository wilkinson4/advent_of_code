package main

import (
	"fmt"
	"os"
	"regexp"
	"slices"
	"strconv"
	"strings"
)

func main() {
	dat, err := os.ReadFile("./day_2_part_1.txt")
	check(err)
	fmt.Print(string(dat))

	games := strings.Split(string(dat), "\n")

	slices.DeleteFunc(games, func(game string) bool {
		blue_possible := game_not_possible(`blue\s(\d+)`, strings.TrimSpace(game), 14)
		fmt.Println("blue_possible", blue_possible)
		return blue_possible
	})
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func game_not_possible(regex_str string, game_str string, max_dice int) bool {
	re := regexp.MustCompile(regex_str)
	matches := re.FindAllStringSubmatch(game_str, -1)
	return slices.ContainsFunc(matches, func(match []string) bool {
		dice_int, err := strconv.Atoi(match[1])
		if err != nil {
			panic(err)
		}
		fmt.Println("dice_int", dice_int)
		fmt.Println("max_dice", max_dice)
		return dice_int >= max_dice
	})
}
