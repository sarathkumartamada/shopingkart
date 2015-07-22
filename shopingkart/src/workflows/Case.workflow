<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CaseUpdateAlert</fullName>
        <description>CaseUpdateAlert</description>
        <protected>false</protected>
        <recipients>
            <field>OpportunityQwner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/case_Update</template>
    </alerts>
    <fieldUpdates>
        <fullName>StatusUpdatedToWorking</fullName>
        <field>Status</field>
        <literalValue>Working</literalValue>
        <name>StatusUpdatedToWorking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EmailNotificationForStatusWorking</fullName>
        <actions>
            <name>CaseUpdateAlert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>StatusUpdatedToWorking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CreatedDate  &lt;&gt;  LastModifiedDate &amp;&amp;CreatedDate  = PRIORVALUE(LastModifiedDate )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
