use regex::Regex;
use std::fs;

fn main() {
    let games = fs::read_to_string("./games.txt").unwrap();
    let split_games: Vec<&str> = games.lines().collect();

    let possible_games = split_games.iter().filter(|game_line| {
        let blue_regex = Regex::new(r"(\d+)\sblue").unwrap();
        let red_regex = Regex::new(r"(\d+)\sred").unwrap();
        let green_regex = Regex::new(r"(\d+)\sgreen").unwrap();
        return !(not_possible(game_line, 14, blue_regex)
            || not_possible(game_line, 13, green_regex)
            || not_possible(game_line, 12, red_regex));
    });

    println!("{}", possible_games.count())
}

fn not_possible(game_line: &str, max_dice: u32, regex_str: Regex) -> bool {
    let dice_pulled = match regex_str.captures(game_line).map(|c| c.extract()) {
        Some((_full, dice_pulled)) => dice_pulled,
        None => ["0"],
    };

    return dice_pulled.iter().any(|num_color_dice| {
        println!("num color dice: {}", num_color_dice);
        return num_color_dice.parse::<u32>().unwrap_or(0) > max_dice;
    });
}
