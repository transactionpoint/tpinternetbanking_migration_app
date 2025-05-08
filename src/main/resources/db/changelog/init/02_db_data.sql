--liquibase formatted sql

--changeset ABS:CreateDefaultDocuments
INSERT IGNORE INTO document_type(id, name, description, mandatory, deleted, created_at)
VALUES
    (1, 'Proof of Identity', 'Proof of Identity Document', 1, 0, NOW()),
    (2, 'Proof of Address', 'Proof of Identity Document', 0, 0, NOW());

--changeset ABS:InsertDefaultAdminCreatedConfiguration
INSERT IGNORE INTO application_configurations(id, name, value, created_at)
VALUES
    (1, 'default_admin_created', 'false', NOW());


--changeset ABS:InitialiseResourcesAndPermissions
INSERT IGNORE INTO resources(id, uuid, name, deleted, description, date_created)
VALUES
    (1, '400faa37-20b4-4371-8027-4c1fdc5c73d1', 'User Management', 0, 'TP IBanking Business user management resource',NOW()),
    (2, '6cc2fc83-2738-43c2-ba79-2ae0757665a0','Role Management', 0, 'TP IBanking Business role management resource', NOW()),
    (3, '635e0ed8-9de4-420c-b2fd-943b033562eb','Account Management', 0,'TP IBanking Business Account management resource', NOW()),
    (4, 'c4e02a13-57e5-4f0b-bfae-8365ee63354d','Transfer', 0, 'TP IBanking Business transfer resource', NOW()),
    (5, '6c6ccad5-cf7b-4044-8bee-ba59dc1829dc','Customer Service', 0, 'TP IBanking Business customer service resource', NOW()),
    (6, 'bdedd9a5-efcf-4719-8b15-250984ea6284','Schedule Payment', 0,'TP IBanking Business schedule payment resource', NOW()),
    (7, 'e30f7d63-bb52-4a9d-98c3-57e24fa07419','Transaction History', 0, 'TP IBanking Business transaction history resource',  NOW()),
    (8, '0531aa98-9fc6-437c-a85c-81f161e6f13e','Beneficiary', 0, 'TP IBanking Business beneficiary resource', NOW()),
    (9, 'e2b65c07-28db-49be-bbb0-ddc031521d7c','Dashboard', 0, 'TP IBanking Business Dashboard resource', NOW()),
    (10, '9f51af0f-2f77-45f7-a6ec-6813900a7f76','Client Onboarding', 0, 'TP IBanking Business client onboarding resource', NOW()),
    (11, 'af4b388d-cf41-4925-bb57-c26de8810e9b','Bill Payment', 0, 'TP IBanking Business bill payment resource', NOW());


INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id)
VALUES
    (1, '50cb6124-d448-407c-a5d4-8d9d06c6c7c9', 'Create User', 'TP_IB::BUS_CLIENT::_user::add', 0, 'User has authority to create a new business user', NOW(), 1),
    (2, 'dbf186e9-a906-4b5d-80eb-ae7ee30981b0', 'Delete User', 'TP_IB::BUS_CLIENT::_user::delete', 0, 'User has authority to delete a business user',  NOW(), 1),
    (3, '037b9b78-11a7-477b-a6ad-28001768de65', 'Update User', 'TP_IB::BUS_CLIENT::_user::edit', 0, 'User has authority to update the details of other business users', NOW(), 1),
    (4, '6f35668c-fc6a-4942-b42d-72ed195eb43a', 'View User', 'TP_IB::BUS_CLIENT::_user::view', 0, 'User has authority to view users list', NOW(), 1),
    (5, 'd43bf5ff-ecfe-4b48-8bf7-05c8c4a0dac9', 'Activate User', 'TP_IB::BUS_CLIENT::_user::activate', 0, 'User has authority to activate other users', NOW(), 1),
    (6, '1ea3765f-2001-4f02-bfe4-e10d052018e8', 'Deactivate User', 'TP_IB::BUS_CLIENT::_user::deactivate', 0, 'User has authority to deactivate other users', NOW(), 1),
    (7, '8974d4eb-8288-4515-8acf-98319c02e87b', 'Create Role', 'TP_IB::BUS_CLIENT::_role::add', 0, 'User has authority to create a new role', NOW(), 2),
    (8, '848630f0-ec5b-413a-b20e-1e2852d4915c', 'Delete Role', 'TP_IB::BUS_CLIENT::_role::delete', 0, 'User has authority delete a role', NOW(), 2),
    (9, 'a19cebe7-b2c2-4ca3-9ae8-731ee74f4faa', 'Update Role', 'TP_IB::BUS_CLIENT::_role::edit', 0, 'User has authority to update a role', NOW(), 2),
    (10, '9f593403-df35-4881-8b92-83d0e47b580c', 'View Role', 'TP_IB::BUS_CLIENT::_role::view', 0, 'User has the authority to view list of roles', NOW(), 2),
    (11, 'f67b741e-e5b5-4d46-aa7c-9cbe2d24eec4', 'Create Bank Account', 'TP_IB::BUS_CLIENT::_account::add', 0, 'User has authority to create a new Bank account', NOW(), 3),
    (12, '282ff47d-62e8-48af-a0dd-0fa6ca970e8d', 'View Account Balance', 'TP_IB::BUS_CLIENT::_account::view_balance', 0, 'User has authority to view account balance', NOW(), 3),
    (13, 'e30f7d63-bb52-4a9d-98c3-57e24fa07419', 'Activate Bank Account', 'TP_IB::BUS_CLIENT::_account::activate', 0, 'User has authority to activate bank account', NOW(), 3),
    (14, '9f51af0f-2f77-45f7-a6ec-6813900a7f76', 'Deactivate Bank Account', 'TP_IB::BUS_CLIENT::_account::deactivate', 0, 'User has authority to deactivate bank account', NOW(), 3),
    (15, '0531aa98-9fc6-437c-a85c-81f161e6f13e', 'Make Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::inter_bank', 0, 'User has authority to make interbank transfer', NOW(), 4),
    (16, 'e2b65c07-28db-49be-bbb0-ddc031521d7c', 'Make Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::intra_bank', 0, 'User has authority to make intra bank transfer', NOW(), 4),
    (17, 'af4b388d-cf41-4925-bb57-c26de8810e9b', 'Make Own Account Transfer', 'TP_IB::BUS_CLIENT::_transfer::own_account', 0, 'User has authority to make transfer between own accounts', NOW(), 4),
    (18, 'bdedd9a5-efcf-4719-8b15-250984ea6284', 'Make Bulk Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::bulk_inter_bank', 0, 'User has authority to make bulk inter bank transfer', NOW(), 4),
    (19, '6c6ccad5-cf7b-4044-8bee-ba59dc1829dc', 'Make Bulk Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::bulk_intra_bank', 0, 'User has authority to make bulk intra bank transfer', NOW(), 4),
    (20, 'c4e02a13-57e5-4f0b-bfae-8365ee63354d', 'Create Ticket', 'TP_IB::BUS_CLIENT::_customer_service::create_ticket', 0, 'User has authority to create ticket', NOW(), 5),
    (21, '635e0ed8-9de4-420c-b2fd-943b033562eb', 'View Ticket', 'TP_IB::BUS_CLIENT::_customer_service::view_ticket', 0, 'User has authority to list of tickets', NOW(), 5),
    (22, '6cc2fc83-2738-43c2-ba79-2ae0757665a0', 'Update Ticket', 'TP_IB::BUS_CLIENT::_customer_service::update_ticket', 0, 'User has authority to mark a ticket as resolved or unresolved', NOW(), 5),
    (23, '400faa37-20b4-4371-8027-4c1fdc5c73d1', 'Schedule Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_schedule_payment::inter_bank', 0, 'User has authority to schedule inter bank transfer', NOW(), 6),
    (24, '9da3ceb5-3fc0-4e5d-9d10-2da08bdc4382', 'Schedule Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_schedule_payment::intra_bank', 0, 'User has authority to schedule intra bank transfer', NOW(), 6),
    (25, '0e59d912-a65f-453b-a393-793f5a28a226', 'Schedule Own Account Transfer', 'TP_IB::BUS_CLIENT::_schedule_payment::own_account', 0, 'User has authority to schedule transfer between own accounts', NOW(), 6),
    (26, '1c7c6947-4e37-4fcb-be87-18598bcea0cf', 'Schedule Bulk Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_schedule_payment::bulk_inter_bank', 0, 'User has authority to schedule bulk inter bank transfer', NOW(), 6),
    (27, '3909afb6-a5e0-4e74-8a8f-925ca97e6b4d', 'Schedule Bulk Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_schedule_payment::bulk_intra_bank', 0, 'User has authority to schedule bulk intra bank transfer', NOW(), 6),
    (28, '846b7099-adc1-48bd-8b4e-c16e7b99bfb2', 'View Transactions', 'TP_IB::BUS_CLIENT::_transaction_history::view', 0, 'User has authority to view list of transactions', NOW(), 7),
    (29, '2a38c044-93dc-4514-b5e7-913305595ad4', 'Download Transaction Receipt', 'TP_IB::BUS_CLIENT::_transaction_history::download_receipt', 0, 'User has authority to download a transaction receipt', NOW(), 7),
    (30, '2af673dc-630f-4bae-9418-d12373b738cd', 'Request Statement Of Account', 'TP_IB::BUS_CLIENT::_transaction_history::request_statement', 0, 'User has authority to request for statement of account', NOW(), 7),
    (31, 'f44aee30-a432-4cd2-bb1d-271aab454318', 'Create Beneficiary', 'TP_IB::BUS_CLIENT::_beneficiary::add', 0, 'User has authority to create a new beneficiary', NOW(), 8),
    (32, '00e7951d-71e5-41fe-b1fe-4839f737d719', 'Delete Beneficiary', 'TP_IB::BUS_CLIENT::_beneficiary::delete', 0, 'User has authority to delete a beneficiary', NOW(), 8),
    (33, 'c3f67fa8-9dcd-4904-b009-9f0a69105086', 'View Beneficiary', 'TP_IB::BUS_CLIENT::_beneficiary::view', 0, 'User has authority to view beneficiary list', NOW(), 8);

--changeset ABS:SetPermissionTypeValueToPermissions
UPDATE permissions
SET permission_type = 'BUSINESS_CLIENT' WHERE id IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33);

--changeset ABS:AddedKYCPasswordReportTransactionLimitAndMFAResourceAndMorePermissions
INSERT IGNORE INTO resources(id, uuid, name, deleted, description, date_created)
VALUES
    (12, '4dd058a2-8d72-4cca-8467-af59c1d3d6c4','KYC Management', 0, 'TP IBanking Business know your customer(KYC) management resource', NOW()),
    (13, 'f11675b9-5abc-4319-bd73-d2854fdb3763','MFA Management', 0, 'TP IBanking Business multiple factor authentication(MFA) management resource', NOW()),
    (14, '434f31a1-4371-4fba-b63e-bc9f5e15780a','Password Management', 0, 'TP IBanking Business password management resource', NOW()),
    (15, 'a73f585e-4daf-4d19-9354-47895abf41b8','Report', 0, 'TP IBanking Business dashboard report resource', NOW()),
    (16, 'aeb88034-63d4-40da-913e-99510747e765','Transaction Limit', 0, 'TP IBanking Business transaction limit resource', NOW());

INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id)
VALUES
    (34, '8e1b61c0-3e79-428d-a07a-af502d80a7d0', 'View Accounts', 'TP_IB::BUS_CLIENT::_account::view', 0, 'User has authority to view accounts', NOW(), 3),
    (35, '5a7ad9ca-9576-41dd-a286-889b3a76e2ff', 'View Account Types', 'TP_IB::BUS_CLIENT::_account::view_types', 0, 'User has authority to view account types', NOW(), 3),
    (36, 'f9b02cf5-75cf-4030-934b-20ffed347224', 'View Beneficiary Details', 'TP_IB::BUS_CLIENT::_beneficiary::view_details', 0, 'User has authority to view a beneficiary details', NOW(), 8),
    (37, 'a1ef8333-afec-4a59-a0e2-eeb86cb24e63', 'Download Document', 'TP_IB::BUS_CLIENT::_client_onboarding::download_document', 0, 'User has authority to download document', NOW(), 10),
    (38, 'ea4e18b9-9d49-41ce-b037-ee2439a4f0a1', 'View Document', 'TP_IB::BUS_CLIENT::_client_onboarding::view_document', 0, 'User has authority to view document', NOW(), 10),
    (39, 'bee9089a-1fdb-4be9-917b-1ed6dfa47df9', 'Upload Document', 'TP_IB::BUS_CLIENT::_client_onboarding::upload_document', 0, 'User has authority to upload document', NOW(), 10),
    (40, '4bb111e6-767b-4da7-812e-b5e999c19c95', 'Delete Document', 'TP_IB::BUS_CLIENT::_client_onboarding::delete_document', 0, 'User has authority to delete document', NOW(), 10),
    (41, 'd5dfdbc1-381c-4cfe-9c64-53da0a44a307', 'Update Basic Profile', 'TP_IB::BUS_CLIENT::_client_onboarding::update_profile', 0, 'User has authority to update basic profile', NOW(), 10),
    (42, '8a7a1745-19ed-4b2f-9898-c361163ee60e', 'View Basic Profile', 'TP_IB::BUS_CLIENT::_client_onboarding::view_profile', 0, 'User has authority to view basic profile', NOW(), 10),
    (43, 'a7d737db-9fae-4818-9489-ca61647e2050', 'View Business Information', 'TP_IB::BUS_CLIENT::_client_onboarding::view_business_information', 0, 'User has authority to view business information', NOW(), 10),
    (44, 'f2200c8b-8800-4f15-b19a-c89ba61ee618', 'Update Business Information', 'TP_IB::BUS_CLIENT::_client_onboarding::update_business_information', 0, 'User has authority to update business information', NOW(), 10),
    (45, 'd3889711-ea0b-403c-8a23-55a1bdcea7bd', 'View Onboarding status', 'TP_IB::BUS_CLIENT::_client_onboarding::view_status', 0, 'User has authority to view onboarding status', NOW(), 10),
    (46, '48082ab3-3bd8-4966-8afe-a65ff9362ead', 'View KYC Level', 'TP_IB::BUS_CLIENT::_kyc::view_level', 0, 'User has authority to view kyc level', NOW(), 12),
    (47, '3756dd36-e330-4a96-b03b-10f92b442e30', 'Add KYC Level 1', 'TP_IB::BUS_CLIENT::_kyc::level_one', 0, 'User has authority to request for attaining kyc level one', NOW(), 12),
    (48, '474facc2-0af6-49cd-8009-44066502775b', 'Add KYC Level 2', 'TP_IB::BUS_CLIENT::_kyc::level_two', 0, 'User has authority to request for attaining kyc level two', NOW(), 12),
    (49, 'ee0edcc4-2313-4e2e-9440-12ce99cfb438', 'Add KYC Level 3', 'TP_IB::BUS_CLIENT::_kyc::level_three', 0, 'User has authority to request for attaining kyc level three', NOW(), 12),
    (50, 'f11675b9-5abc-4319-bd73-d2854fdb3763', 'View KYC Bio Data', 'TP_IB::BUS_CLIENT::_kyc::view_bio_data', 0, 'User has authority to view kyc bio data', NOW(), 12),
    (51, 'a0c06165-e299-4d22-8cdd-daac604cc0bb', 'View KYC Document', 'TP_IB::BUS_CLIENT::_kyc::view_kyc_document', 0, 'User has authority to view kyc document', NOW(), 12),
    (52, '5b13b9d5-00b2-4748-97c1-2bb91cecdf44', 'View MFA Type', 'TP_IB::BUS_CLIENT::_mfa::view_type', 0, 'User has authority to view multiple factor authentication type', NOW(), 13),
    (53, '0faf404c-f90a-486b-a6dc-7a1d47fb5576', 'Generate OTP MFA code', 'TP_IB::BUS_CLIENT::_mfa::generate_otp_code', 0, 'User has authority to generate one time password(otp) code for mfa', NOW(), 13),
    (54, '8c5acf62-8915-47f4-8b73-f24b58e685d4', 'Confirm OTP MFA', 'TP_IB::BUS_CLIENT::_mfa::confirm_otp_mfa', 0, 'User has authority to confirm otp as mfa option', NOW(), 13),
    (55, '35f401e8-5389-4cdb-86bc-0b9f4bccf68d', 'Generate Google Authenticator Qr Code', 'TP_IB::BUS_CLIENT::_mfa::generate_google_authenticator_qr_code', 0, 'User has authority to generate google authenticator qr code for mfa', NOW(), 13),
    (56, '434f31a1-4371-4fba-b63e-bc9f5e15780a', 'Confirm Google Authenticator MFA', 'TP_IB::BUS_CLIENT::_mfa::confirm_google_authenticator_mfa', 0, 'User has authority to confirm google authenticator as mfa option', NOW(), 13),
    (57, 'a73f585e-4daf-4d19-9354-47895abf41b8', 'Change Password', 'TP_IB::BUS_CLIENT::_password::change', 0, 'User has authority to change password', NOW(), 14),
    (58, '474bf5f8-b533-4e29-942c-332e5755b9f8', 'View Dashboard Data', 'TP_IB::BUS_CLIENT::_report::view_dashboard_data', 0, 'User has authority to dashboard data', NOW(), 15),
    (59, '5b13f682-6693-4f5d-b757-89ad4d17e041', 'View Dashboard Analytics', 'TP_IB::BUS_CLIENT::_report::view_analytics', 0, 'User has authority to dashboard analytics', NOW(), 15),
    (60, 'ef4787b0-5fee-4d6a-9c77-a7ad0770d621', 'View Role Details', 'TP_IB::BUS_CLIENT::_role::view_details', 0, 'User has authority to view details of a role', NOW(), 2),
    (61, '89f9272c-e36c-47c1-ac0f-e677794d229e', 'View Permissions', 'TP_IB::BUS_CLIENT::_role::view_permissions', 0, 'User has authority to view permissions', NOW(), 2),
    (62, '12248fc0-f4d2-4f8c-b1f7-490ea4714df1', 'View Scheduled Payments', 'TP_IB::BUS_CLIENT::_schedule_payment::view', 0, 'User has authority to view list of scheduled payments', NOW(), 6),
    (63, 'ef362444-ea5c-4a70-8ea5-0a9e1dcccca8', 'View Scheduled Payment Details', 'TP_IB::BUS_CLIENT::_schedule_payment::view_details', 0, 'User has authority to view details of a scheduled payment', NOW(), 6),
    (64, '0539ec94-71db-4db6-a2b4-5362d071e025', 'Update Scheduled Payment', 'TP_IB::BUS_CLIENT::_schedule_payment::edit', 0, 'User has authority to update a scheduled payment', NOW(), 6),
    (65, 'b3b908af-82b5-45b9-bfe0-8646929c9a4d', 'Approve Scheduled Payment', 'TP_IB::BUS_CLIENT::_schedule_payment::approve', 0, 'User has authority to approve a scheduled payment', NOW(), 6),
    (66, '0ca27ea9-2305-4ef8-a510-c92ed9d1087e', 'Create Message', 'TP_IB::BUS_CLIENT::_customer_service::create_message', 0, 'User has authority to create message for a ticket', NOW(), 5),
    (67, '9897fea4-9d5b-4ae5-aeeb-4d9934120f94', 'View Ticket Details', 'TP_IB::BUS_CLIENT::_customer_service::view_ticket_details', 0, 'User has authority to view details of a ticket', NOW(), 5),
    (68, '55b44c01-8478-4733-a212-e2a79185b4d6', 'Download Attachment', 'TP_IB::BUS_CLIENT::_customer_service::download_attachment', 0, 'User has authority to download ticket attachment', NOW(), 5),
    (69, 'aeb88034-63d4-40da-913e-99510747e765', 'View Transaction Details', 'TP_IB::BUS_CLIENT::_transaction_history::view_details', 0, 'User has authority to view details of a transaction', NOW(), 7),
    (70, '9f0bfd9f-b781-435a-bb00-8e99bbe64bc6', 'Set Transaction Limit', 'TP_IB::BUS_CLIENT::_transaction_limit::set_limit', 0, 'User has authority to set transaction limit', NOW(), 16),
    (71, 'fc8f7976-50f8-44f6-987d-e49793716624', 'View Transaction Limits', 'TP_IB::BUS_CLIENT::_transaction_limit::view', 0, 'User has authority to view transaction limits', NOW(), 16),
    (72, '9a77d05d-9936-4c15-bd48-bc9bfa1175ae', 'Confirm Transaction Limit', 'TP_IB::BUS_CLIENT::_transaction_limit::confirm', 0, 'User has authority to confirm transaction limit request', NOW(), 16),
    (73, '1707d804-9824-43fa-909f-2b7b201db6f8', 'View Onboarded Customers', 'TP_IB::BUS_CLIENT::_transfer::view_onboarded_customers', 0, 'User has authority to view onboarded customers', NOW(), 4),
    (74, '8def4262-2e42-493c-960f-942cdc299ccd', 'Make Interbank Name Enquiry', 'TP_IB::BUS_CLIENT::_transfer::name_enquiry', 0, 'User has authority to make an interbank name enquiry', NOW(), 4),
    (75, '9227f734-4003-491a-b280-3159a0ef6670', 'Make Intra Bank Name Enquiry', 'TP_IB::BUS_CLIENT::_transfer::intra_bank_name_enquiry', 0, 'User has authority to make an intra bank name enquiry', NOW(), 4),
    (76, '58721e8b-8304-4edd-88d6-60a811de04e1', 'View Balance', 'TP_IB::BUS_CLIENT::_transfer::view_balance', 0, 'User has authority to view balance', NOW(), 4),
    (77, 'dd6fd4a7-5630-4057-98d0-9f765d82b806', 'Initiate Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::initiate_intra_bank', 0, 'User has authority to initiate intra bank transfer', NOW(), 4),
    (78, '5aeada67-b9e3-46ee-9723-ee1789fbd1ef', 'Initiate Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::initiate_inter_bank', 0, 'User has authority to initiate inter bank transfer', NOW(), 4),
    (79, 'e0f9a473-ecd7-4ccd-a6cf-0258878b7a62', 'Confirm Intra Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::confirm_intra_bank', 0, 'User has authority to confirm intra bank transfer', NOW(), 4),
    (80, '609a2edd-b408-49f9-bc5b-67fa79765f9d', 'Confirm Inter Bank Transfer', 'TP_IB::BUS_CLIENT::_transfer::confirm_inter_bank', 0, 'User has authority to confirm inter bank transfer', NOW(), 4),
    (81, '481d369d-0ebb-4862-a2de-f9ab3466f346', 'Initiate Inter Bank Transfer To Beneficiary', 'TP_IB::BUS_CLIENT::_transfer::initiate_inter_bank_to_beneficiary', 0, 'User has authority to initiate inter bank transfer to beneficiary', NOW(), 4);

--changeset ABS:SetPermissionTypeValueToNewPermissions
UPDATE permissions
    SET permission_type = 'BUSINESS_CLIENT' WHERE id IN (34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81);

--changeset ABS:InitializeAdminPermissions
INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id, permission_type)
VALUES
    (82, '50cb6124-d448-407c-a5d4-8d9d06c6c7c9', 'Create User', 'TP_IB::ADMIN::_user::add', 0, 'User has authority to create a new admin user', NOW(), 1, 'ADMIN'),
    (83, 'dbf186e9-a906-4b5d-80eb-ae7ee30981b0', 'Delete User', 'TP_IB::ADMIN::_user::delete', 0, 'User has authority to delete a admin user',  NOW(), 1, 'ADMIN'),
    (84, '037b9b78-11a7-477b-a6ad-28001768de65', 'Update User', 'TP_IB::ADMIN::_user::edit', 0, 'User has authority to update the details of other admin users', NOW(), 1, 'ADMIN'),
    (85, '6f35668c-fc6a-4942-b42d-72ed195eb43a', 'View User', 'TP_IB::ADMIN::_user::view', 0, 'User has authority to view users list', NOW(), 1, 'ADMIN'),
    (86, 'd43bf5ff-ecfe-4b48-8bf7-05c8c4a0dac9', 'Activate User', 'TP_IB::ADMIN::_user::activate', 0, 'User has authority to activate other users', NOW(), 1, 'ADMIN'),
    (87, '1ea3765f-2001-4f02-bfe4-e10d052018e8', 'Deactivate User', 'TP_IB::ADMIN::_user::deactivate', 0, 'User has authority to deactivate other users', NOW(), 1, 'ADMIN'),
    (88, '8974d4eb-8288-4515-8acf-98319c02e87b', 'Create Role', 'TP_IB::ADMIN::_role::add', 0, 'User has authority to create a new role', NOW(), 2, 'ADMIN'),
    (89, '848630f0-ec5b-413a-b20e-1e2852d4915c', 'Delete Role', 'TP_IB::ADMIN::_role::delete', 0, 'User has authority delete a role', NOW(), 2, 'ADMIN'),
    (90, 'a19cebe7-b2c2-4ca3-9ae8-731ee74f4faa', 'Update Role', 'TP_IB::ADMIN::_role::edit', 0, 'User has authority to update a role', NOW(), 2, 'ADMIN'),
    (91, '9f593403-df35-4881-8b92-83d0e47b580c', 'View Role', 'TP_IB::ADMIN::_role::view', 0, 'User has the authority to view list of roles', NOW(), 2, 'ADMIN'),
    (92, 'ef4787b0-5fee-4d6a-9c77-a7ad0770d621', 'View Role Details', 'TP_IB::ADMIN::_role::view_details', 0, 'User has authority to view details of a role', NOW(), 2, 'ADMIN');

--changeset ABS:AddedClientManagementAndTransactionResource
INSERT IGNORE INTO resources(id, uuid, name, deleted, description, date_created)
VALUES
    (17, '91cfc848-4969-40b8-acd2-559c3a46f459','Client Management', 0, 'TP IBanking Client Management resource', NOW()),
    (18, '1a1a4d46-4e39-49ce-91e5-48fb29c18364','Transaction', 0, 'TP IBanking Transaction resource', NOW());

--changeset ABS:AddedMoreAdminPermissions
INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id, permission_type)
VALUES
    (93, '8bb5e46c-6941-440d-a229-04b7fcc1b69f', 'View Permissions', 'TP_IB::ADMIN::_role::view_permissions', 0, 'User has authority to view all admin permissions', NOW(), 2, 'ADMIN'),
    (94, '1a1a4d46-4e39-49ce-91e5-48fb29c18364', 'View Personal Tickets', 'TP_IB::ADMIN::_customer_service::complaint::view_person_ticket', 0, 'User has authority to view personal client complaint tickets', NOW(), 5, 'ADMIN'),
    (95, '91cfc848-4969-40b8-acd2-559c3a46f459', 'View Business Tickets', 'TP_IB::ADMIN::_customer_service::complaint::view_business_ticket', 0, 'User has authority to view business client complaint tickets', NOW(), 5, 'ADMIN'),
    (96, 'a1056451-da40-4cf6-859e-81e065837127', 'Update Complaint Ticket', 'TP_IB::ADMIN::_customer_service::complaint::update_ticket', 0, 'User has authority to update complaint ticket', NOW(), 5, 'ADMIN'),
    (97, 'cf7d062f-5327-41e4-9eed-8091258f074e', 'Create Complaint Message', 'TP_IB::ADMIN::_customer_service::complaint::create_message', 0, 'User has authority to create complaint message', NOW(), 5, 'ADMIN'),
    (98, 'd710d0dc-fb37-42d1-a718-b1b9545e3b30', 'View Complaint Ticket Details', 'TP_IB::ADMIN::_customer_service::complaint::view_ticket_details', 0, 'User has authority to view complaint ticket details', NOW(), 5, 'ADMIN'),
    (99, '3dca74f4-103c-4478-a3ae-5bd95503e048', 'Download Attachment', 'TP_IB::ADMIN::_customer_service::complaint::download_attachment', 0, 'User has authority to download complaint attachment', NOW(), 5, 'ADMIN'),
    (100, 'd30215fc-8b5c-4217-9943-650a9e565509', 'Register Transaction For Resolution', 'TP_IB::ADMIN::_customer_service::transaction_resolution::register', 0, 'User has authority to register a transaction for possible resolution', NOW(), 5, 'ADMIN'),
    (101, '33003cd6-88ec-4bba-a0b3-8aa758b909a0', 'View Transaction Resolutions', 'TP_IB::ADMIN::_customer_service::transaction_resolution::view', 0, 'User has authority to view transaction resolutions', NOW(), 5, 'ADMIN'),
    (102, '8a883439-c353-48ed-8faa-be060857255e', 'View Transaction Resolution Details', 'TP_IB::ADMIN::_customer_service::transaction_resolution::view_details', 0, 'User has authority to view a transaction resolution details', NOW(), 5, 'ADMIN'),
    (103, 'f3454d70-2ad3-414d-b7fd-9e9d3b28adf8', 'Reject or Decline Transaction Resolution', 'TP_IB::ADMIN::_customer_service::transaction_resolution::reject', 0, 'User has authority to reject of decline transaction resolution request', NOW(), 5, 'ADMIN'),
    (104, 'b0f3b118-9501-4197-93b0-e5b007fee82e', 'Initiate Refund', 'TP_IB::ADMIN::_customer_service::transaction_resolution::initiate_refund)', 0, 'User has authority to initiate transaction resolution refund', NOW(), 5, 'ADMIN'),
    (105, 'eab411a0-4e69-495e-a991-33c8e5662532', 'Confirm Refund', 'TP_IB::ADMIN::_customer_service::transaction_resolution::confirm_refund)', 0, 'User has authority to confirm transaction resolution refund', NOW(), 5, 'ADMIN'),
    (106, 'e8aeb52b-d092-4a52-b150-38c1a9204b33', 'View Clients', 'TP_IB::ADMIN::_client::view_clients', 0, 'User has authority to view all clients', NOW(), 17, 'ADMIN'),
    (107, 'c0ab0b03-65ad-4c79-ab11-8d28b496fea9', 'View Client General Information', 'TP_IB::ADMIN::_client::view_general_information', 0, 'User has authority to view a client general information', NOW(), 17, 'ADMIN'),
    (108, '4a065ad8-90af-40a4-b907-c6219a055ad4', 'View Client Address', 'TP_IB::ADMIN::_client::view_address', 0, 'User has authority to view a client address', NOW(), 17, 'ADMIN'),
    (109, 'b5eed826-aadb-474e-b502-fff625b6c4df', 'View Client Image', 'TP_IB::ADMIN::_client::view_image', 0, 'User has authority to view a client image', NOW(), 17, 'ADMIN'),
    (110, '18f20d07-81be-4ccb-a6a1-c458cf472451', 'View Client Transactions', 'TP_IB::ADMIN::_client::view_transactions', 0, 'User has authority to view a client transactions', NOW(), 17, 'ADMIN'),
    (111, '529dcb8b-fc96-4015-aa15-ffac631ceddf', 'View Client Transaction Details', 'TP_IB::ADMIN::_client::view_transaction_details', 0, 'User has authority to view a client transaction details', NOW(), 17, 'ADMIN'),
    (112, '327413dd-b662-4591-b3cf-83becde1fb4e', 'View Client Bank Accounts', 'TP_IB::ADMIN::_client::view_bank_accounts', 0, 'User has authority to view a client bank accounts', NOW(), 17, 'ADMIN'),
    (113, 'c933b2ee-b82d-41b9-afa3-c921ee2ae04f', 'View Client Security Information', 'TP_IB::ADMIN::_client::view_security_information', 0, 'User has authority to view a client security information', NOW(), 17, 'ADMIN'),
    (114, '53817dfd-d8b5-4afd-ac52-68296fefee70', 'Reset Client Password', 'TP_IB::ADMIN::_client::reset_password', 0, 'User has authority to reset a client password', NOW(), 17, 'ADMIN'),
    (115, '5c1db7a1-1c4f-42d0-8743-611c89208142', 'Confirm Reset Client Password', 'TP_IB::ADMIN::_client::confirm_reset_password', 0, 'User has authority to confirm the reset of a client password', NOW(), 17, 'ADMIN'),
    (116, 'e962381e-7b3d-4eb3-97d8-6adffc89313f', 'View All IBanking Transactions', 'TP_IB::ADMIN::_transaction::view', 0, 'User has authority to view all internet banking transactions', NOW(), 18, 'ADMIN'),
    (117, 'fce3d44b-fa10-4ca0-ba6c-7acfb8930694', 'View Transaction Details', 'TP_IB::ADMIN::_transaction::view_details', 0, 'User has authority to view a transaction details', NOW(), 18, 'ADMIN'),
    (118, '94fbbf1a-14dc-4331-823c-3d00a3acf9f2', 'View Transactions Filter Enums', 'TP_IB::ADMIN::_transaction::view_enums', 0, 'User has authority to view a transaction filter query enums', NOW(), 18, 'ADMIN'),
    (119, '044715a8-a00a-4de2-9411-68b3515f1d8c', 'Create Report', 'TP_IB::ADMIN::_report::add', 0, 'User has authority to create a report', NOW(), 15, 'ADMIN'),
    (120, '6da36c8f-185e-428c-b61d-c130d4940467', 'View Reports', 'TP_IB::ADMIN::_report::view', 0, 'User has authority to view reports', NOW(), 15, 'ADMIN'),
    (121, '3a31458c-3761-4170-a0f4-20e9ad8226af', 'View Report Details', 'TP_IB::ADMIN::_report::view_details', 0, 'User has authority to view report details', NOW(), 15, 'ADMIN'),
    (123, '07614899-0243-4209-801e-64e43c3e395c', 'View Report Types', 'TP_IB::ADMIN::_report::view_types', 0, 'User has authority to view report types', NOW(), 15, 'ADMIN'),
    (124, 'f4c6d233-8520-4c02-9b8a-8288404db509', 'View Report parameters', 'TP_IB::ADMIN::_report::view_parameters', 0, 'User has authority to view report parameters', NOW(), 15, 'ADMIN'),
    (125, '2770e1a5-3291-48f3-9d7f-a09b2ea035db', 'View Person Dashboard', 'TP_IB::ADMIN::_dashboard::view_personal', 0, 'User has authority to view person dashboard', NOW(), 9, 'ADMIN'),
    (126, 'a8523dd9-96de-43b0-a09a-6febbb6790d2', 'View Business Dashboard', 'TP_IB::ADMIN::_dashboard::view_business', 0, 'User has authority to view business dashboard', NOW(), 9, 'ADMIN'),
    (127, '5b6ec46d-19b7-4c02-8e03-558426f8a772', 'View Onboarding Person Clients', 'TP_IB::ADMIN::_onboarding::person::view_clients', 0, 'User has authority to view person clients awaiting onboarding', NOW(), 10, 'ADMIN'),
    (128, 'e2662407-7730-4185-a1ff-ac2f2e8e6025', 'View Onboarding Person Client details', 'TP_IB::ADMIN::_onboarding::person::view_details', 0, 'User has authority to view onboarding person client details', NOW(), 10, 'ADMIN'),
    (129, '407b8ebf-0c89-443a-a641-38c24c6163f8', 'View Onboarding Person Client status', 'TP_IB::ADMIN::_onboarding::person::view_status', 0, 'User has authority to view onboarding person client status', NOW(), 10, 'ADMIN'),
    (130, '9c6d9c01-affb-424e-8857-a831b72ce2c8', 'Approve Onboarding Person Client Basic Profile', 'TP_IB::ADMIN::_onboarding::person::approve_profile', 0, 'User has authority to approve onboarding person client basic profile', NOW(), 10, 'ADMIN'),
    (131, '27c4b704-1996-4ec4-ad3c-d8b1b28c4020', 'Decline Onboarding Person Client Basic Profile', 'TP_IB::ADMIN::_onboarding::person::decline_profile', 0, 'User has authority to decline onboarding person client basic profile', NOW(), 10, 'ADMIN'),
    (132, '75c746f8-78ad-443c-ae37-d47359119d8f', 'Approve Onboarding Person Client BVN', 'TP_IB::ADMIN::_onboarding::person::approve_bvn', 0, 'User has authority to approve onboarding person client BVN', NOW(), 10, 'ADMIN'),
    (133, '8085a5f3-6e93-4f02-90e3-835a6112e885', 'Decline Onboarding Person Client BVN', 'TP_IB::ADMIN::_onboarding::person::decline_bvn', 0, 'User has authority to decline onboarding person client BVN', NOW(), 10, 'ADMIN'),
    (134, '9f28e455-57e3-40ac-87f3-51c0f976075a', 'Approve Onboarding Person Client NIN', 'TP_IB::ADMIN::_onboarding::person::approve_nin', 0, 'User has authority to approve onboarding person client NIN', NOW(), 10, 'ADMIN'),
    (135, '9e3b92e5-312c-4b86-88f1-df98c0488036', 'Decline Onboarding Person Client NIN', 'TP_IB::ADMIN::_onboarding::person::decline_nin', 0, 'User has authority to decline onboarding person client NIN', NOW(), 10, 'ADMIN'),
    (136, '22efbd5f-a3f1-4b25-9b71-938c1f8752c3', 'Verify Onboarding Person Client BVN', 'TP_IB::ADMIN::_onboarding::person::verify_bvn', 0, 'User has authority to verify onboarding person client BVN', NOW(), 10, 'ADMIN'),
    (137, 'd10bcb48-2719-4642-b7c0-56da7ecec51d', 'Verify Onboarding Person Client NIN', 'TP_IB::ADMIN::_onboarding::person::verify_nin', 0, 'User has authority to verify onboarding person client NIN', NOW(), 10, 'ADMIN'),
    (138, '78fd211c-05de-4171-b843-79cf7ff46a22', 'View Onboarding Business Clients', 'TP_IB::ADMIN::_onboarding::business::view_clients', 0, 'User has authority to view business clients awaiting onboarding', NOW(), 10, 'ADMIN'),
    (139, '35310ee7-d89b-48f2-bc9b-91b4f0774a7b', 'Verify Onboarding Business Client BVN', 'TP_IB::ADMIN::_onboarding::business::verify_bvn', 0, 'User has authority to verify onboarding business clients BVN', NOW(), 10, 'ADMIN'),
    (140, 'b3f2cf73-838c-43e3-85f1-a081ef8bd4d9', 'Verify Onboarding Business Client NIN', 'TP_IB::ADMIN::_onboarding::business::verify_nin', 0, 'User has authority to verify onboarding business clients NIN', NOW(), 10, 'ADMIN'),
    (141, 'b3ed8fb7-86d9-4ac9-8ca7-7950ec39e5b2', 'Approve Onboarding Business Client Basic Profile', 'TP_IB::ADMIN::_onboarding::business::approve_profile', 0, 'User has authority to approve onboarding business clients basic profile', NOW(), 10, 'ADMIN'),
    (142, 'd81e8d2e-ba24-4c77-9f1e-67fb981edee3', 'Decline Onboarding Business Client Basic Profile', 'TP_IB::ADMIN::_onboarding::business::decline_profile', 0, 'User has authority to decline onboarding business clients basic profile', NOW(), 10, 'ADMIN'),
    (143, 'd397f25b-0fcc-4f4c-8bc1-e66d167d8ee5', 'Approve Onboarding Business Client BVN', 'TP_IB::ADMIN::_onboarding::business::approve_bvn', 0, 'User has authority to approve onboarding business client BVN', NOW(), 10, 'ADMIN'),
    (144, 'ec242952-14f2-4b87-a60e-b8df73ae5c4e', 'Decline Onboarding Business Client BVN', 'TP_IB::ADMIN::_onboarding::business::decline_bvn', 0, 'User has authority to decline onboarding business client BVN', NOW(), 10, 'ADMIN'),
    (145, '49e27251-d777-4d55-9594-056d9e127c3a', 'Approve Onboarding Business Client NIN', 'TP_IB::ADMIN::_onboarding::business::approve_nin', 0, 'User has authority to approve onboarding business client NIN', NOW(), 10, 'ADMIN'),
    (146, '968e7004-d2c3-49f1-9570-cbe8bc6a3f37', 'Decline Onboarding Business Client NIN', 'TP_IB::ADMIN::_onboarding::business::decline_nin', 0, 'User has authority to decline onboarding business client NIN', NOW(), 10, 'ADMIN'),
    (147, '3e8eecdd-2a8c-4c44-adca-68ce9c7e074e', 'Approve Onboarding Business Information', 'TP_IB::ADMIN::_onboarding::business::approve_information', 0, 'User has authority to approve onboarding business Information', NOW(), 10, 'ADMIN'),
    (148, '6a73a79e-3313-4955-8aa1-e6e813c1eef9', 'Decline Onboarding Business Information', 'TP_IB::ADMIN::_onboarding::business::decline_information', 0, 'User has authority to decline onboarding business Information', NOW(), 10, 'ADMIN'),
    (149, '73896163-a6a2-474a-9f3a-9e27c22acfe6', 'Approve Onboarding Business Document', 'TP_IB::ADMIN::_onboarding::business::approve_document', 0, 'User has authority to approve onboarding business document', NOW(), 10, 'ADMIN'),
    (150, 'bac2f632-3699-4d84-9aa4-1d673d55056b', 'Decline Onboarding Business Document', 'TP_IB::ADMIN::_onboarding::business::decline_document', 0, 'User has authority to decline onboarding business document', NOW(), 10, 'ADMIN'),
    (151, '61c2c494-affb-40bb-a4fe-d178966a43b3', 'View Onboarding Business Basic Profile', 'TP_IB::ADMIN::_onboarding::business::view_profile', 0, 'User has authority to view onboarding business basic profile', NOW(), 10, 'ADMIN'),
    (152, '8f7da9f5-5f6e-4d65-b225-1ebecd92b9d6', 'View Onboarding Business Document', 'TP_IB::ADMIN::_onboarding::business::view_document', 0, 'User has authority to view onboarding business document', NOW(), 10, 'ADMIN'),
    (153, 'e803b1a9-98cc-42be-a664-08a49f482e83', 'View Onboarding Business Information', 'TP_IB::ADMIN::_onboarding::business::view_information', 0, 'User has authority to view onboarding business Information', NOW(), 10, 'ADMIN'),
    (154, 'c36ee07d-c718-4231-b405-646adb7e5129', 'Download Onboarding Business Document', 'TP_IB::ADMIN::_onboarding::business::download_document', 0, 'User has authority to download onboarding business document', NOW(), 10, 'ADMIN'),
    (155, '94928b08-6ff6-48b3-a5bb-b8204cef4eaa', 'View Onboarding Business Status', 'TP_IB::ADMIN::_onboarding::business::view_status', 0, 'User has authority to view onboarding business status', NOW(), 10, 'ADMIN');

--changeset ABS:AddedConfigurationResource
INSERT IGNORE INTO resources(id, uuid, name, deleted, description, date_created)
VALUES
    (19, 'd2b5778f-89e7-4004-ac24-a3855e3ec358','Configuration', 0, 'TP IBanking Configuration Resource', NOW());

--changeset ABS:AddedKYCAndConfigurationPermissions
INSERT IGNORE INTO permissions(id, uuid, name, authority, deleted, description, date_created, resource_id, permission_type)
VALUES
    (156, '08599006-6d4d-4215-9d9c-2492cd9d256b', 'View Customers KYC Request', 'TP_IB::ADMIN::_kyc::view_request', 0, 'User has authority to view customers kyc request', NOW(), 12, 'ADMIN'),
    (157, '5612ed9e-9fef-4974-b4ce-34d997cd40b0', 'View Customers KYC Request Details', 'TP_IB::ADMIN::_kyc::view_details', 0, 'User has authority to view kyc request details', NOW(), 12, 'ADMIN'),
    (158, 'd2b5778f-89e7-4004-ac24-a3855e3ec358', 'View Customers KYC Document', 'TP_IB::ADMIN::_kyc::view_document', 0, 'User has authority to view kyc document', NOW(), 12, 'ADMIN'),
    (159, 'c1ced135-ebbc-4f52-a687-88425e231996', 'Verify Customers BVN', 'TP_IB::ADMIN::_kyc::verify_bvn', 0, 'User has authority to verify customers BVN', NOW(), 12, 'ADMIN'),
    (160, '55130e4c-75f2-4699-bdf2-09d4e1b02369', 'Verify Customers NIN', 'TP_IB::ADMIN::_kyc::verify_nin', 0, 'User has authority to verify customers NIN', NOW(), 12, 'ADMIN'),
    (161, '677709f2-97c4-4941-a035-7808f24caf63', 'View KYC Logs', 'TP_IB::ADMIN::_kyc::view_logs', 0, 'User has authority to view KYC logs', NOW(), 12, 'ADMIN'),
    (162, 'ef76e56f-d8da-4b8e-acca-7b66d4ff6305', 'Verify BVN Information', 'TP_IB::ADMIN::_kyc::verify_bvn_information', 0, 'User has authority to verify BVN Information', NOW(), 12, 'ADMIN'),
    (163, 'cf4dac15-8b82-45ff-b582-2222ed1cecf7', 'Verify NIN Information', 'TP_IB::ADMIN::_kyc::verify_nin_information', 0, 'User has authority to verify NIN Information', NOW(), 12, 'ADMIN'),
    (164, '7a136986-acc8-4f16-ac0c-71fa9e6a4fa7', 'View Status', 'TP_IB::ADMIN::_kyc::view_status', 0, 'User has authority to view KYC status', NOW(), 12, 'ADMIN'),
    (165, 'faf3425b-70a7-41ec-add4-57d91ed4494c', 'Set KYC Level', 'TP_IB::ADMIN::_kyc::set_level', 0, 'User has authority to set KYC level', NOW(), 12, 'ADMIN'),
    (166, '78a08062-f84e-4406-b3fd-7e5b0cd130b0', 'Send Mail', 'TP_IB::ADMIN::_kyc::send_mail', 0, 'User has authority to set KYC level', NOW(), 12, 'ADMIN'),
    (167, '1d793dc4-cf53-46e4-923e-9dfe2ffabb66', 'View Multiple Factor Authentication Types', 'TP_IB::ADMIN::_configuration::view_type', 0, 'User has authority to view multiple factor authentication types', NOW(), 19, 'ADMIN'),
    (168, '06bca8fb-febb-4c8b-91d5-7dee242c97c0', 'Generate OTP MFA code', 'TP_IB::ADMIN::_configuration::generate_otp_code', 0, 'User has authority to generate one time password(otp) code for mfa', NOW(), 19, 'ADMIN'),
    (169, 'c15c8271-4062-4510-9a25-e13fa5f3ef92', 'Confirm OTP MFA', 'TP_IB::ADMIN::_configuration::confirm_otp_mfa', 0, 'User has authority to confirm otp as mfa option', NOW(), 19, 'ADMIN'),
    (170, '7ef8466d-bae8-4987-8d85-626b27e757c4', 'Generate Google Authenticator Qr Code', 'TP_IB::ADMIN::_configuration::generate_google_authenticator_qr_code', 0, 'User has authority to generate google authenticator qr code for mfa', NOW(), 19, 'ADMIN'),
    (171, '84a51b56-d9ea-42b8-b7a6-cb49652a4bd9', 'Confirm Google Authenticator MFA', 'TP_IB::ADMIN::_configuration::confirm_google_authenticator_mfa', 0, 'User has authority to confirm google authenticator as mfa option', NOW(), 19, 'ADMIN'),
    (172, '3dd27b26-21fa-4315-9b0f-f055204cb1b8', 'Change Password', 'TP_IB::ADMIN::_password::change', 0, 'User has authority to change password', NOW(), 14, 'ADMIN');

--changeset ABS:UpdateCustomerServiceTransactionRefundPermissions
UPDATE permissions
    SET authority = 'TP_IB::ADMIN::_customer_service::transaction_resolution::initiate_refund'
    WHERE id = 104;

UPDATE permissions
    SET authority = 'TP_IB::ADMIN::_customer_service::transaction_resolution::confirm_refund'
    WHERE id = 105;

--changeset ABS:CreatePassportPhotographDocumentType
INSERT IGNORE INTO document_type(id, name, description, mandatory, deleted, created_at)
VALUES
    (3, 'Passport Photograph', 'Proof of Photograph Document', 1, 0, NOW());

