// cargo-deps: itertools
extern crate itertools;
use itertools::Itertools;

fn missing_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let all_edges = (0..n).combinations(2);
    all_edges.filter(|e| !edges.contains(e) && !edges.contains(&vec![e[1], e[0]]) )
             .collect()
}

fn main() {
    let edges = vec![vec![0,1], vec![1,2], vec![2,0]];
    let missing = missing_edges(4, edges);
    println!("{:?}", missing);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn trivial_graph_test() {
        let n = 1;
        let edges: Vec<Vec<i32>> = vec![];
        let actual = missing_edges(n, edges);
        let expected: Vec<Vec<i32>> = vec![];
        assert_eq!(actual, expected);
    }

    #[test]
    fn no_missing_edges_test() {
        let n = 3;
        let edges = vec![vec![0, 1], vec![1, 2], vec![0,2]];
        let actual = missing_edges(n, edges);
        let expected: Vec<Vec<i32>> = vec![];
        assert_eq!(actual, expected);
    }

    #[test]
    fn some_missing_edges_test() {
        let n = 4;
        let edges = vec![vec![0, 1], vec![1, 2], vec![2,0]];
        let actual = missing_edges(n, edges);
        let expected = vec![vec![0, 3], vec![1, 3], vec![2,3]];
        assert_eq!(actual, expected);
    }
}

// how to run
// $ cargo install cargo-script
// $ cargo script complete_graph_missing_edges.rs

// how to test:
// $ cargo script complete_graph_missing_edges.rs --test