public with sharing class SobjectTree {
	public sObject record {get; set;}
	public List<SobjectTree> children {get; set;}

	public SobjectTree(sObject record) {
		this.record = record;
		this.children = new List<SobjectTree>();
	}

}