<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>OutFitAssignment</fullName>
        <active>false</active>
        <formula>!ISBLANK(STYLE__r.Account__r.Id)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
