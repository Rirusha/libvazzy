// ind-check=skip-file
// vala-lint=skip-file

using Vazzy;

void common_test (string str1, string str2, int expected) {
    var result = compute_damerau_levenshtein_distance (str1, str2);

    if (result != expected) {
        Test.fail_printf ("\n%s -- %s\nExpected: %d\nGot: %d", str1, str2, expected, result);
    }
}

public int main (string[] args) {
    Test.init (ref args);

    Test.add_func ("/damerau-levenshtein-distance-test/0", () => {
        common_test ("bebra", "bebar", 1);
    });

    Test.add_func ("/damerau-levenshtein-distance-test/2", () => {
        common_test ("bebra", "beytr", 3);
    });

    return Test.run ();
}
