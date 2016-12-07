public with sharing class testselectpicklist {
    public String key {get;set;}
    public List<SelectOption> options {
        get{
            List<SelectOption> options = new List<SelectOption>{new SelectOption('key', 'test')};
            string newkey = ApexPages.currentPage().getParameters().get('id');
            options.add(new SelectOption('key1', newKey));
            return options;
        }
        set;
    }
    public String pictureId {get;set;}
    public testselectpicklist()
    {
        pictureId='00P24000002TWr8';
    }
    
    public void save()
    {
        system.debug(key);
    }
}