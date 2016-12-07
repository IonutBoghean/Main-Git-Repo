public with sharing class BuildSobjectTree {
	public Map<Id, sObject> allrecords;
	public BuildSobjectTree() {
		allrecords = new Map<Id, sObject>();
		Map<Id, Account> accountRecords = new Map<Id, Account>([SELECT Id FROM Account]);
		Map<Id, Contact> contactRecords = new Map<Id, Contact>([SELECT Id, AccountId FROM Contact]);
		allrecords.putAll((Map<Id, sObject>)accountRecords);
		allrecords.putAll((Map<Id, sObject>)contactRecords);
	}

	public List<SobjectTree> tree{get; set;}
	private Set<String> recordsInTree;
	public void buildTree() {
		tree = new List<SobjectTree>();
		recordsInTree = new Set<String>();
		for(sObject tempRecord :allrecords.values()) {
			addToTree(tempRecord);
		}
		system.debug(tree);
	}

	private void addToTree(sObject record) {
		//check if its in tree
		if(!recordsInTree.contains((String)record.get('Id'))) {
			//check if its parent or child
			if(record.getSObjectType() == Contact.sObjectType) {
				addToTree(allrecords.get((String)record.get('AccountId')));
				addToParent(record, tree);
			} else {
				tree.add(new SobjectTree(record));
			}
			recordsInTree.add((String)record.get('Id'));
		}
	}

	private void addToParent(sObject record, List<SobjectTree> treeNodes) {
		for(SobjectTree treeNode : treeNodes) {
			if((String)treeNode.record.get('Id') == (String)record.get('AccountId')) {
				treeNode.children.add(new SobjectTree(record));
			}
		}
	}
}