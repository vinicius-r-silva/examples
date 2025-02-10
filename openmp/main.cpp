#include <iostream>
#include <omp.h>

int main() {
    int sum = 0;
    int n = 100;

    // Set the number of threads
    omp_set_num_threads(4);

    // Parallelize the for loop
    #pragma omp parallel for reduction(+:sum)
    for (int i = 0; i < n; ++i) {
        sum += i;
    }

    std::cout << "The sum of the first " << n << " integers is: " << sum << std::endl;
    return 0;
}
