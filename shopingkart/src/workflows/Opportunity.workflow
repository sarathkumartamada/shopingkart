<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Opportunity_Close_Won</fullName>
        <description>Opportunity Close Won</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/OpportunityClosedWon</template>
    </alerts>
    <fieldUpdates>
        <fullName>FlageUpdate</fullName>
        <field>Approved__c</field>
        <literalValue>0</literalValue>
        <name>FlageUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EmailNotificationForCloseWon</fullName>
        <actions>
            <name>Opportunity_Close_Won</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>FlageUpdate</fullName>
        <actions>
            <name>FlageUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(StageName )  &amp;&amp;  ISPICKVAL(StageName , &apos;Closed Won&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
