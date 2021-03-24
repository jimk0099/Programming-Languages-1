fun     printList[] = ()
|       printList(x::xt) = (
        print(Int.toString(x));
        print("\n");
        printList(xt)
);