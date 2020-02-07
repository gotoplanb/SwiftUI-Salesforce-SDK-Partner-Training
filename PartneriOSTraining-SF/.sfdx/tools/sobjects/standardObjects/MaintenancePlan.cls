// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class MaintenancePlan {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String MaintenancePlanNumber;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global WorkType WorkType;
    global Id WorkTypeId;
    global Account Account;
    global Id AccountId;
    global String FrequencyType;
    global Integer Frequency;
    global Date StartDate;
    global Date EndDate;
    global Date NextSuggestedMaintenanceDate;
    global Integer MaintenanceWindowStartDays;
    global Integer MaintenanceWindowEndDays;
    global String WorkOrderGenerationStatus;
    global String GenerationTimeframeType;
    global Integer GenerationTimeframe;
    global String Description;
    global Location Location;
    global Id LocationId;
    global Contact Contact;
    global Id ContactId;
    global String MaintenancePlanTitle;
    global Integer GenerationHorizon;
    global Boolean DoesGenerateUponCompletion;
    global Boolean DoesAutoGenerateWorkOrders;
    global String WorkOrderGenerationMethod;
    global String SvcApptGenerationMethod;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<MaintenanceAsset> MaintenanceAssets;
    global List<MaintenancePlanFeed> Feeds;
    global List<MaintenancePlanHistory> Histories;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Task> Tasks;
    global List<TopicAssignment> TopicAssignments;
    global List<WorkOrder> WorkOrders;
    global List<WorkOrderLineItem> WorkOrderLineItems;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OutgoingEmail> RelatedTo;
    global List<TaskChangeEvent> What;

    global MaintenancePlan () 
    {
    }
}