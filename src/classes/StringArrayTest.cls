public class StringArrayTest {
    public static List<String> generateStringArray(Integer noOfElems) {
        List<String> elems = new List<String>();
        for(integer i = 0; i < noOfElems; i++) {
            elems.add('Test ' + String.valueOf(i));
        }
        return elems;
    }
}