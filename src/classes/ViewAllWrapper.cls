public class ViewAllWrapper {

	public Boolean selected {get;set;}
	public SObject obj {get;set;}

	public ViewAllWrapper(SObject obj) {
		this.obj = obj;
		this.selected = false;
	}
}