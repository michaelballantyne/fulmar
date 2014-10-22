/* This file was generated by fulmar version 0.9.2. */

struct SingleValue;
struct SomethingElse;
template<typename L1, typename L2 >
 struct JoinLocation;

template<typename A, typename B >
 struct MEqual;

template< >
 struct JoinLocation<SingleValue, SingleValue > { SingleValue typedef result; };

template<typename L >
 struct JoinLocation<SingleValue, L > { L typedef result; };

template<typename L >
 struct JoinLocation<L, SingleValue > { L typedef result; };

template<typename L >
 struct JoinLocation<L, L > { L typedef result; };

template<typename V >
 struct MEqual<V, V > { V typedef result; };
int main(int argc, const char *argv[])
{
    typename JoinLocation<SingleValue, SingleValue>::result typedef result1;
    typename MEqual<result1, SingleValue>::result typedef assert1;

    typename JoinLocation<SingleValue, SomethingElse>::result typedef result2;
    typename MEqual<result2, SomethingElse>::result typedef assert2;

    typename JoinLocation<SomethingElse, SingleValue>::result typedef result3;
    typename MEqual<result3, SomethingElse>::result typedef assert3;

    typename JoinLocation<SomethingElse, SomethingElse>::result typedef result4;
    typename MEqual<result4, SomethingElse>::result typedef assert4;

    return 0;
}
