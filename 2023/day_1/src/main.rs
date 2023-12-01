use std::fs;

fn main() {
    let calibration_document = fs::read_to_string("./day_1.txt").unwrap();

    let split_document: Vec<&str> = calibration_document.lines().collect();

    let result: u32 = split_document
        .iter()
        .map(|line| line.chars().filter(|&c| c.is_digit(10)).collect())
        .map(|numbers| first_and_last_chars(numbers).parse::<u32>().unwrap())
        .sum();

    println!("Result is {}!", result);
}

fn first_and_last_chars(s: String) -> String {
    let first_char = s.chars().next().unwrap();
    let last_char = s.chars().last().unwrap();
    return format!("{}{}", first_char, last_char);
}
