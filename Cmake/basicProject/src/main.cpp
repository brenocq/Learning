#include <iostream>
#include <vector>
#include "sum.h"
using namespace std;

int main()
{
	cout << "Hello " << sum(1,1) << endl;
	vector<int> test(1);
	int i = 2;
	bool val = i<test.size();// Warning
	return 0;
}
