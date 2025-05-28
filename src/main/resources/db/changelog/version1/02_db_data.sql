--liquibase formatted sql


--changeset ABS:AddedBulkTransferApprovalPermission
INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id, permission_type)
VALUES
    (173, '84960d61-df5f-48fb-9e4c-90f4624e1b66', 'Approve Bulk Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::approve_bulk_inter_bank', 0, 'User has authority to approve bulk inter bank transfer', NOW(), 4, 'BUSINESS_CLIENT'),
    (174, '74867419-fa23-42fb-b0a3-1905b9610a1c', 'Assign Transfer Approval Mandate', 'TP_IB::BUS_CLIENT::_transfer::assign_transfer_approval_mandate', 0, 'User has authority to assign mandate for bulk inter bank transfer', NOW(), 4, 'BUSINESS_CLIENT');

--changeset ABS:addBulkNameInquiryProcessBlockInApplicationConfigurations
INSERT IGNORE INTO application_configurations(id, name, value, created_at)
VALUES
    (2, 'bulk_name_inquiry_processing_block', 'false', NOW());



--changeset ABS:AddedVasUtilityResource
INSERT IGNORE INTO resources(id, uuid, name, deleted, description, date_created)
VALUES
    (20, 'b6f5eb90-7214-4542-b977-ff990d7fb53d','VAS Utility', 0, 'TP IBanking VAS Utility Resource', NOW());


--changeset ABS:AddedVasUtilityVendingPermissions
INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id, permission_type)
VALUES
    (175, '8c6623c2-7ee7-4884-95f5-92170f0e2eb5', 'Initiate VAS Utility Vending', 'TP_IB::BUS_CLIENT::_vas::initiate_vas_vending', 0, 'User has authority to initiate vas utility vending', NOW(), 20, 'BUSINESS_CLIENT'),
    (176, '6d5973c8-6934-40a0-a6af-7b29f691ad48', 'Confirm VAS Utility Vending', 'TP_IB::BUS_CLIENT::_vas::confirm_vas_vending', 0, 'User has authority to confirm vas utility vending', NOW(), 20, 'BUSINESS_CLIENT');
