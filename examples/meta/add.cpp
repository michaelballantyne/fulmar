/* This file was generated by fulmar version 0.9.2. */

struct Zero {};

template<typename N >
 struct Succ {};

template<typename M, typename N >
 struct Add;

template<typename A, typename B >
 struct MEqual;

template<typename NMinusOne, typename M >
 struct Add<Succ<NMinusOne >, M > {
   typename Add<NMinusOne, Succ<M > >::result typedef result;
};

template<typename M >
 struct Add<Zero, M > { M typedef result; };

template<typename V >
 struct MEqual<V, V > { V typedef result; };
int main(int argc, const char *argv[])
{
    typename Add<Succ<Succ<Zero > >, Succ<Zero> >::result typedef result;

    typename MEqual<result, Succ<Succ<Succ<Zero> > > >::result typedef assert;

    return 0;
}
