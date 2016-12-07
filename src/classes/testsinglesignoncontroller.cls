public class testsinglesignoncontroller {
    public testsinglesignoncontroller(ApexPages.standardcontroller controller) {
        throw new testexception();
    }
    
    public class testexception extends Exception{}
}