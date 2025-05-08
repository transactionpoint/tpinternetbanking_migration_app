--liquibase formatted sql

-- changeset ABS:CreateUsersTable
CREATE TABLE IF NOT EXISTS users (
   id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
   uuid VARCHAR(150) NOT NULL,
   first_name VARCHAR(150) NOT NULL,
   last_name VARCHAR(150) NOT NULL,
   email VARCHAR(150) NOT NULL,
   user_type VARCHAR(50) NOT NULL,
   client_type VARCHAR(50),
   password VARCHAR(255) NOT NULL,
   is_enabled BOOLEAN NOT NULL,
   email_verified BOOLEAN NOT NULL,
   created_by VARCHAR (255),
   deleted BOOLEAN,
   two_factor_authentication VARCHAR (50),
   date_created TIMESTAMP,
   date_modified TIMESTAMP
);

-- changeset ABS:CreateUserVerificationTable
CREATE TABLE IF NOT EXISTS user_verification (
   id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
   code VARCHAR(10) NOT NULL,
   verify_type VARCHAR(100) NOT NULL,
   expire_at TIMESTAMP NOT NULL,
   created_at TIMESTAMP NOT NULL
);

-- changeset ABS:CreateClientsTable
CREATE TABLE IF NOT EXISTS clients (
     id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
     uuid VARCHAR(150) NOT NULL,
     phone_number VARCHAR (20),
     bvn VARCHAR(11),
     address VARCHAR(255) NOT NULL,
     state_of_residence VARCHAR(255) NOT NULL,
     employment_status VARCHAR(70) NOT NULL,
     marital_status VARCHAR(70) NOT NULL,
     gender VARCHAR(50) NOT NULL,
     date_of_birth TIMESTAMP,
     client_type VARCHAR(70),
     created_by VARCHAR (255),
     deleted BOOLEAN,
     date_created TIMESTAMP,
     date_modified TIMESTAMP

);

-- changeset ABS:CreateTokenTable
CREATE TABLE IF NOT EXISTS tokens (
    id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    access_token VARCHAR(2500) NOT NULL,
    expired BOOLEAN NOT NULL,
    expires_in BIGINT NOT NULL,
    revoked BOOLEAN NOT NULL
);

--changeset ABS:CreateCognitoJwksTable
CREATE TABLE IF NOT EXISTS cognito_jwks (
      key_id VARCHAR(500) PRIMARY KEY,
      algorithm VARCHAR(10) NOT NULL,
      key_type VARCHAR(10) NOT NULL,
      exponent VARCHAR(255) NOT NULL,
      modulus VARCHAR(1000) NOT NULL,
      use_parameter VARCHAR(10) NOT NULL
);

--changeset ABS:UpdateUsersAndClientsAndTokensAndUserVerificationTable
ALTER TABLE users
    ADD COLUMN token_id BIGINT,
    ADD FOREIGN KEY (token_id) REFERENCES tokens(id);

ALTER TABLE clients
    ADD COLUMN user_id BIGINT NOT NULL,
    ADD FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE tokens
    ADD COLUMN user_id BIGINT NOT NULL,
    ADD FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE user_verification
    ADD COLUMN user_id BIGINT NOT NULL,
    ADD FOREIGN KEY (user_id) REFERENCES users(id);

--changeset ABS:ModifyClientDateOfBirthToDate
ALTER TABLE clients MODIFY COLUMN date_of_birth DATE

-- changeset ABS:CreateBeneficiariesTable
CREATE TABLE beneficiaries (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       account_number VARCHAR(10) NOT NULL,
       account_name VARCHAR(100) NOT NULL,
       bank_name VARCHAR(255) NOT NULL,
       bank_code VARCHAR(20) NOT NULL,
       client_id BIGINT NOT NULL,
       deleted BOOLEAN,
       created_at TIMESTAMP NOT NULL,
       updated_at TIMESTAMP,
       FOREIGN KEY (client_id) REFERENCES clients(id)
)

--changeset ABS:AddProductIdToClientsTable
ALTER TABLE clients
    ADD COLUMN product_id BIGINT NOT NULL;

-- changeset ABS:CreateClientStagingTable
CREATE TABLE client_staging (
    id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    date_of_birth DATE NOT NULL,
    state_of_residence VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    employment_status VARCHAR(50) NOT NULL,
    marital_status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    completed_onboarding BOOLEAN NOT NULL,
    completed_onboarding_at TIMESTAMP
);

--changeset ABS:AddOnboardingStatusToClientStagingTable
ALTER TABLE client_staging
    ADD COLUMN basic_profile_status VARCHAR(100) NULL,
    ADD COLUMN basic_profile_comment VARCHAR(100) NULL,
    ADD COLUMN bvn_status VARCHAR(100) NULL,
    ADD COLUMN bvn_comment VARCHAR(100) NULL,
    ADD COLUMN nin_status VARCHAR(100)  NULL,
    ADD COLUMN nin_comment VARCHAR(100) NULL;

--changeset ABS:AddBvnAndNinToClientStagingTable
ALTER TABLE client_staging
    ADD COLUMN bvn VARCHAR(11) NULL,
    ADD COLUMN nin VARCHAR(11) NULL

--changeset ABS:AddUserIdToClientStagingTable
ALTER TABLE client_staging
    ADD COLUMN user_id BIGINT;

--changeset ABS:AddCoreBankingIdToClientsTable
ALTER TABLE clients
    ADD COLUMN core_banking_id BIGINT;

--changeset ABS:AddNameAndEmailToClientTable
ALTER TABLE clients
    ADD COLUMN first_name VARCHAR(255),
    ADD COLUMN last_name VARCHAR(255),
    ADD COLUMN email VARCHAR(255);

-- changeset ABS:CreateAccountsTable
CREATE TABLE accounts (
      id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
      nuban VARCHAR(10) NOT NULL,
      product_id BIGINT NOT NULL,
      client_id BIGINT NOT NULL,
      created_at TIMESTAMP NOT NULL,
      deleted BOOLEAN NOT NULL DEFAULT FALSE,
      FOREIGN KEY (client_id) REFERENCES clients(id)
);

--changeset ABS:ChangeClientsDateOfBirthToString
ALTER TABLE clients
    MODIFY COLUMN date_of_birth VARCHAR(255);

--changeset ABS:AddProductIdToClientStagingTable
ALTER TABLE client_staging
    ADD COLUMN product_id BIGINT NOT NULL;

--changeset ABS:ChangeClientStagingDateOfBirthToString
ALTER TABLE client_staging
    MODIFY COLUMN date_of_birth VARCHAR(255);

--changeset ABS:AddAccountTypeNameToAccountsTable
ALTER TABLE accounts
    ADD COLUMN account_type_name VARCHAR(255);

-- changeset ABS:CreateIntraBankTransfersTable
CREATE TABLE intra_bank_transfers (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      client_id BIGINT NOT NULL,
      source_account_number VARCHAR(10) NOT NULL,
      destination_account_number VARCHAR(10) NOT NULL,
      amount DECIMAL(20,2) NOT NULL,
      description VARCHAR(255) NOT NULL,
      sent_request_to_tp_gateway BOOLEAN NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_ClientIntraBankTransfer FOREIGN KEY (client_id)
      REFERENCES clients(id)
)

--changeset ABS:AddNewUserColumnToClientsTable
ALTER TABLE client_staging
    ADD COLUMN new_user BOOLEAN NOT NULL;

--changeset ABS:DeleteProductColumnClientsTable
ALTER TABLE clients
    DROP COLUMN product_id;

-- changeset ABS:CreateInterBankTransfersTable
CREATE TABLE inter_bank_transfers (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      client_id BIGINT NOT NULL,
      source_account_number VARCHAR(10) NOT NULL,
      destination_account_number VARCHAR(10) NOT NULL,
      destination_account_bank_verification_number VARCHAR(20) NOT NULL,
      destination_bank_code VARCHAR(20) NOT NULL,
      destination_bank_name VARCHAR(255) NOT NULL,
      destination_account_name VARCHAR(255) NOT NULL,
      name_inquiry_reference VARCHAR(255) NOT NULL,
      amount DECIMAL(20,2) NOT NULL,
      description VARCHAR(255) NOT NULL,
      sent_request_to_tp_gateway BOOLEAN NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_ClientInterBankTransfer FOREIGN KEY (client_id) REFERENCES clients(id)
)

-- changeset ABS:CreateBulkBankTransfersTable
CREATE TABLE bulk_transfers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    client_id BIGINT NOT NULL,
    sent_request_to_tp_gateway BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT FK_ClientBulkTransfer FOREIGN KEY (client_id) REFERENCES clients(id)
)

-- changeset ABS:AddBeneficiaryNameToBeneficiariesTable
ALTER TABLE beneficiaries
    ADD COLUMN beneficiary_name VARCHAR(255) NOT NULL;

-- changeset ABS:AddBulkTransferColumnsToInterBankTransferTable
ALTER TABLE inter_bank_transfers
    ADD COLUMN part_of_bulk_transfer BOOLEAN NOT NULL,
    ADD COLUMN bulk_transfer_id BIGINT;

-- changeset ABS:AddTransactionReferenceColumnToInterBankTransferTable
ALTER TABLE inter_bank_transfers
    ADD COLUMN transaction_reference VARCHAR(25) NOT NULL;

--changeset ABS:IncreaseTransactionReferenceColumnSize
ALTER TABLE inter_bank_transfers
    MODIFY COLUMN transaction_reference VARCHAR(255) NOT NULL;

-- changeset ABS:CreateSchedulePaymentTable
CREATE TABLE schedule_payments (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       uuid VARCHAR(100) NOT NULL,
       reference_number VARCHAR(100) NOT NULL,
       client_id BIGINT NOT NULL,
       source_account_number VARCHAR(10) NOT NULL,
       destination_account_number VARCHAR(10) NOT NULL,
       destination_bank_code VARCHAR(20) NOT NULL,
       destination_bank_name VARCHAR(255) NOT NULL,
       destination_account_name VARCHAR(255) NOT NULL,
       name_inquiry_reference VARCHAR(255) NOT NULL,
       amount DECIMAL(20,2) NOT NULL,
       status VARCHAR(70) NOT NULL,
       description VARCHAR(255) NOT NULL,
       transfer_type VARCHAR(70) NOT NULL,
       approved BOOLEAN,
       save_as_beneficiary BOOLEAN,
       deleted BOOLEAN,
       date_created TIMESTAMP NOT NULL,
       date_modified TIMESTAMP,
       created_by VARCHAR(255),
       schedule_payment_date TIMESTAMP NOT NULL ,
       FOREIGN KEY (client_id) REFERENCES clients(id)
)

-- changeset ABS:CreateDisableAccountRequestTable
CREATE TABLE disable_account_requests (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      client_id BIGINT NOT NULL,
      account_number VARCHAR(10) NOT NULL,
      sent_request_to_tp_gateway BOOLEAN NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_ClientDisableAccountRequest FOREIGN KEY (client_id) REFERENCES clients(id)
)

--changeset ABS:AddKycLevelToClientsTable
ALTER TABLE clients
    ADD COLUMN kyc_level INT;

-- changeset ABS:CreateKycRequestTable
CREATE TABLE kyc_requests (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      client_id BIGINT NOT NULL,
      level INT NOT NULL,
      status VARCHAR(50) NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_ClientKycRequest FOREIGN KEY (client_id) REFERENCES clients(id)
)

--changeset ABS:AddNinToClientsTable
ALTER TABLE clients
    ADD COLUMN nin VARCHAR(20);

-- changeset ABS:AlterSchedulePaymentTable
ALTER TABLE schedule_payments
    MODIFY destination_bank_code VARCHAR(20) NULL,
    MODIFY destination_bank_name VARCHAR(255) NULL,
    MODIFY destination_account_name VARCHAR(255) NULL,
    MODIFY name_inquiry_reference VARCHAR(255) NULL;

--changeset ABS:AddKycDocumenstToClientsTable
ALTER TABLE clients
    ADD COLUMN utility_bill_s3_key VARCHAR(500),
ADD COLUMN id_card_s3_key VARCHAR(500);

--changeset ABS:DivideKycStatusIntoLevels
ALTER TABLE kyc_requests
    ADD COLUMN level_1_status VARCHAR(50),
    ADD COLUMN level_2_status VARCHAR(50),
    ADD COLUMN level_3_status VARCHAR(50),
DROP COLUMN status;

--changeset ABS:CreateTicketTable
CREATE TABLE tickets (
     id BIGINT PRIMARY KEY AUTO_INCREMENT,
     subject VARCHAR(255) NOT NULL,
     resolved BOOLEAN NOT NULL,
     client_id BIGINT NOT NULL,
     created_at TIMESTAMP NOT NULL,
     CONSTRAINT FK_ClientTicket FOREIGN KEY (client_id) REFERENCES clients(id)
);

--changeset ABS:CreateMessageTable
CREATE TABLE messages (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      ticket_id BIGINT NOT NULL,
      message_text VARCHAR(1000) NOT NULL,
      created_by BIGINT NOT NULL,
      created_at TIMESTAMP NOT NULL,
      sender VARCHAR(50) NOT NULL,
      CONSTRAINT FK_MessageTicket FOREIGN KEY (ticket_id) REFERENCES tickets(id),
      CONSTRAINT FK_MessageCreatedBy FOREIGN KEY (created_by) REFERENCES users(id)
);

--changeset ABS:CreateAttachmentTable
CREATE TABLE attachments (
     id BIGINT PRIMARY KEY AUTO_INCREMENT,
     message_id BIGINT NOT NULL,
     s3Key VARCHAR(255) NOT NULL,
     name VARCHAR(255) NOT NULL,
     created_at TIMESTAMP NOT NULL,
     CONSTRAINT FK_AttachmentMessage FOREIGN KEY (message_id) REFERENCES messages(id)
);

--changeset ABS:CreateTransactionTable
CREATE TABLE transactions(
     id BIGINT PRIMARY KEY AUTO_INCREMENT,
     uuid VARCHAR(100) NOT NULL,
     amount DECIMAL(20,2) NOT NULL,
     balance DECIMAL(20,2) NOT NULL,
     client_id BIGINT NOT NULL,
     core_banking_client_id BIGINT NOT NULL,
     core_banking_transaction_id BIGINT NOT NULL,
     sessionID VARCHAR(100),
     transaction_reference VARCHAR(100) NOT NULL,
     transaction_status VARCHAR(70),
     account_number VARCHAR(10) NOT NULL,
     account_name VARCHAR(150) NOT NULL,
     product_id VARCHAR(20) NOT NULL,
     product_name VARCHAR(100),
     transaction_type VARCHAR(100) NOT NULL,
     transaction_date VARCHAR(100) NOT NULL,
     narration VARCHAR(250),
     deleted BOOLEAN,
     date_created TIMESTAMP NOT NULL,
     date_modified TIMESTAMP,
     created_by VARCHAR(255)
);

--changeset ABS:AddApprovalDataToKycRequestTable
ALTER TABLE kyc_requests
    ADD COLUMN approved_on TIMESTAMP,
    ADD COLUMN approved_by BIGINT,
    ADD CONSTRAINT Kyc_requestApprovedBy FOREIGN KEY (approved_by) REFERENCES users(id);

--changeset ABS:AddCurrentLevelToKycRequestTable
ALTER TABLE kyc_requests
    ADD COLUMN current_level INT;

--changeset ABS:AddBvnColumnVerifiedColumnToKycRequestTable
ALTER TABLE kyc_requests
    ADD COLUMN bvn_verified BOOLEAN,
    ADD COLUMN nin_verified BOOLEAN;

--changeset ABS:AddKycDocumentsUploadedColumnToKycRequestTable
ALTER TABLE kyc_requests
    ADD COLUMN utility_bill_uploaded BOOLEAN,
    ADD COLUMN identification_card_uploaded BOOLEAN;

--changeset ABS:AddBvnColumnVerifiedColumnToClientsTable
ALTER TABLE clients
    ADD COLUMN bvn_verified BOOLEAN,
    ADD COLUMN nin_verified BOOLEAN;

--changeset ABS:DropBvnColumnVerifiedColumnFromKycRequestTable
ALTER TABLE kyc_requests
    DROP COLUMN bvn_verified,
    DROP COLUMN nin_verified;

--changeset ABS:AddRegistrationTypeColumnToClientsTable
ALTER TABLE clients
    ADD COLUMN registration_type VARCHAR(70) NOT NULL;

--changeset ABS:ModifyTransactionReferenceOnTransactionsTableToBeNullable
ALTER TABLE transactions
    MODIFY COLUMN transaction_reference VARCHAR(255) NULL;

--changeset ABS:ModifySchedulePaymentDateColumnOnSchedulePaymentTableToBeDate
ALTER TABLE schedule_payments
    MODIFY COLUMN schedule_payment_date DATE NOT NULL;

--changeset ABS:AddthumbnailUrlToAttachments
ALTER TABLE attachments
    ADD COLUMN thumbnail_url VARCHAR(255);

--changeset ABS:CreateTransactionLimitTable
CREATE TABLE transaction_limits(
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       uuid VARCHAR(100) NOT NULL,
       nuban VARCHAR(10) NOT NULL,
       client_id BIGINT NOT NULL,
       product_id BIGINT NOT NULL,
       product_name VARCHAR(200),
       daily_transaction_limit DECIMAL(20,2) NOT NULL,
       single_transaction_limit DECIMAL(20,2) NOT NULL,
       current_daily_transaction_limit DECIMAL(20,2) NOT NULL,
       confirm BOOLEAN NOT NULL,
       deleted BOOLEAN,
       date_created TIMESTAMP NOT NULL,
       date_modified TIMESTAMP,
       created_by VARCHAR(255),
       FOREIGN KEY (client_id) REFERENCES clients(id)
);

--changeset ABS:ModifyBalanceColumnOnTransactionsTableToBeNullable
ALTER TABLE transactions
    MODIFY COLUMN balance DECIMAL(20,2) NULL;

--changeset ABS:AlterUserAndClientTableForBusinessApp
ALTER TABLE users
    ADD COLUMN full_name VARCHAR(250);

--changeset ABS:AlterClientTableMakeRegistrationTypeNullable
ALTER TABLE clients
    MODIFY COLUMN registration_type VARCHAR(255) NULL;

--changeset ABS:CreateBusinessInformation
CREATE TABLE business_information (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      client_id BIGINT,
      business_name VARCHAR(255),
      business_registration_number VARCHAR(255),
      registration_date DATE,
      tax_number VARCHAR(255),
      primary_business_activity VARCHAR(255),
      state VARCHAR(255),
      city VARCHAR(255),
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_ClientBusinessInformation FOREIGN KEY (client_id) REFERENCES clients(id)
);

--changeset ABS:CreateDocumentType
CREATE TABLE document_type (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       name VARCHAR(255) NOT NULL,
       description VARCHAR(255) NOT NULL,
       mandatory BOOLEAN,
       deleted BOOLEAN,
       created_at TIMESTAMP NOT NULL
);

--changeset ABS:CreateDocumentsTable
CREATE TABLE documents (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       client_id BIGINT,
       type_id BIGINT,
       verification_comment VARCHAR(255),
       status VARCHAR(255),
       s3_key VARCHAR(255),
       created_at TIMESTAMP,
       updated_at TIMESTAMP,
       CONSTRAINT FK_ClientDocument FOREIGN KEY (client_id) REFERENCES clients(id),
       CONSTRAINT FK_DocumentType FOREIGN KEY (type_id) REFERENCES document_type(id)
);

--changeset ABS:CreateOnboardingTale
CREATE TABLE onboarding (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    client_id BIGINT,
    basic_profile_status VARCHAR(50),
    basic_profile_comment VARCHAR(255),
    business_information_status VARCHAR(50),
    business_information_comment VARCHAR(255),
    document_status VARCHAR(50),
    document_comment VARCHAR(255),
    bvn_status VARCHAR(50),
    bvn_comment VARCHAR(255),
    nin_status VARCHAR(50),
    nin_comment VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT FK_ClientOnboarding FOREIGN KEY (client_id) REFERENCES clients(id)
)

--changeset ABS:AddedGoogleAuthenticatorSecretCodeColumnToUserTable
ALTER TABLE users
    ADD COLUMN google_authenticator_secret_code VARCHAR(250);

--changeset ABS:AddOnboardingcompletedColumn
ALTER TABLE onboarding
    ADD COLUMN completed_onboarding BOOLEAN NOT NULL,
    ADD COLUMN completed_onboarding_at TIMESTAMP

--changeset ABS:AddStatusColumnToOnboarding
ALTER TABLE onboarding
    ADD COLUMN status VARCHAR(255);

--changeset ABS:CreateApplicationConfigurationsTable
CREATE TABLE application_configurations (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(500) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- changeset ABS:CreateBusinessClientBeneficiariesTable
CREATE TABLE business_client_beneficiaries (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       beneficiary_name VARCHAR(255) NOT NULL,
       account_number VARCHAR(10) NOT NULL,
       account_name VARCHAR(100) NOT NULL,
       bank_name VARCHAR(255) NOT NULL,
       bank_code VARCHAR(20) NOT NULL,
       business_client_id BIGINT NOT NULL,
       deleted BOOLEAN NOT NULL,
       created_at TIMESTAMP NOT NULL,
       updated_at TIMESTAMP,
       CONSTRAINT FK_BusinessClientBeneficiary FOREIGN KEY (business_client_id) REFERENCES clients(id)
)

-- changeset ABS:CreateBusinessIntraBankTransfersTable
CREATE TABLE business_client_intra_bank_transfers (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      business_client_id BIGINT NOT NULL,
      sent_request_to_tp_gateway BOOLEAN NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_BusinessClientTransfer FOREIGN KEY (business_client_id) REFERENCES clients(id)
);

CREATE TABLE business_client_intra_bank_transfer_detail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    intra_bank_transfer_id BIGINT NOT NULL,
    source_account_number VARCHAR(10) NOT NULL,
    destination_account_number VARCHAR(10) NOT NULL,
    amount DECIMAL(20,2) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT FK_BusinessClientIntraBankTransferDetail FOREIGN KEY (intra_bank_transfer_id)
        REFERENCES business_client_intra_bank_transfers(id)
);

-- changeset ABS:CreateBusinessInterBankTransfersTable
CREATE TABLE business_client_inter_bank_transfers (
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      business_client_id BIGINT NOT NULL,
      sent_request_to_tp_gateway BOOLEAN NOT NULL,
      created_at TIMESTAMP NOT NULL,
      updated_at TIMESTAMP,
      CONSTRAINT FK_BusinessClientInterbankTransfer FOREIGN KEY (business_client_id) REFERENCES clients(id)
);

-- changeset ABS:CreateBusinessInterBankTransferDetailTable
CREATE TABLE business_client_inter_bank_transfer_detail (
id BIGINT PRIMARY KEY AUTO_INCREMENT,
    inter_bank_transfer_id BIGINT NOT NULL,
    source_account_number VARCHAR(10) NOT NULL,
    destination_account_number VARCHAR(10) NOT NULL,
    destination_account_bank_verification_number VARCHAR(20) NOT NULL,
    destination_bank_code VARCHAR(20) NOT NULL,
    destination_bank_name VARCHAR(255) NOT NULL,
    destination_account_name VARCHAR(255) NOT NULL,
    name_inquiry_reference VARCHAR(255) NOT NULL,
    transaction_reference VARCHAR(255) NOT NULL,
    amount DECIMAL(20,2) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT FK_BusinessClientInterBankTransferDetail FOREIGN KEY (inter_bank_transfer_id)
    REFERENCES business_client_inter_bank_transfers(id)
);

--changeset ABS:AddClientColumnToUserTable
ALTER TABLE users
    ADD COLUMN client_id BIGINT,
    ADD FOREIGN KEY (client_id) REFERENCES clients(id);

--changeset ABS:AddAccountNameProductShortNameAndProductCurrencyColumnsToAccountTable
ALTER TABLE accounts
    ADD COLUMN account_name VARCHAR(255),
    ADD COLUMN product_short_name VARCHAR(50),
    ADD COLUMN product_currency VARCHAR(10);

--changeset ABS:DropUserForeignKeyOnClientsTable
ALTER TABLE clients
    DROP FOREIGN KEY clients_ibfk_1,
    DROP COLUMN user_id;

--changeset ABS:AddPrimaryUserIdToClientsTable
ALTER TABLE clients
    ADD COLUMN primary_user_id BIGINT NULL,
    ADD CONSTRAINT FK_ClientPrimaryUser FOREIGN KEY (primary_user_id) REFERENCES users(id);

--changeset ABS:AddUserIdToClientsTable
ALTER TABLE clients
    ADD COLUMN user_id BIGINT NULL;

-- changeset ABS:CreateRolesAndResourcesAndPermissionsTable
CREATE TABLE roles (
       id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
       uuid VARCHAR(150) NOT NULL,
       name VARCHAR(150) NOT NULL,
       role_type VARCHAR(50) NOT NULL,
       created_by VARCHAR (255),
       deleted BOOLEAN,
       active BOOLEAN,
       date_created TIMESTAMP,
       date_modified TIMESTAMP
);


CREATE TABLE resources (
       id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
       uuid VARCHAR(150) NOT NULL,
       name VARCHAR(150) NOT NULL,
       resource_type VARCHAR(50) NOT NULL,
       created_by VARCHAR (255),
       deleted BOOLEAN,
       description VARCHAR(250) NOT NULL,
       date_created TIMESTAMP,
       date_modified TIMESTAMP
);

CREATE TABLE permissions (
     id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
     uuid VARCHAR(150) NOT NULL,
     name VARCHAR(150) NOT NULL,
     authority VARCHAR(150) NOT NULL,
     created_by VARCHAR (255),
     deleted BOOLEAN,
     description VARCHAR(250) NOT NULL,
     date_created TIMESTAMP,
     date_modified TIMESTAMP,
     resource_id BIGINT NOT NULL,
     CONSTRAINT FK_PermissionsResources FOREIGN KEY (resource_id) REFERENCES resources(id)
);

-- changeset ABS:AddRoleToUserTable
ALTER TABLE users
    ADD COLUMN user_name VARCHAR(100),
    ADD COLUMN status VARCHAR(100),
    ADD COLUMN role_id BIGINT,
    ADD CONSTRAINT FK_UsersRoles FOREIGN KEY (role_id) REFERENCES roles(id);

--changeset ABS:CreateRolesPermissionTable
CREATE TABLE roles_permissions (
       role_id BIGINT NOT NULL,
       permissions_id BIGINT NOT NULL,
       FOREIGN KEY (role_id) REFERENCES roles(id),
       FOREIGN KEY (permissions_id) REFERENCES permissions(id)
);

-- changeset ABS:AddClientToRoleTable
ALTER TABLE roles
    ADD COLUMN client_id BIGINT,
    ADD CONSTRAINT FK_RoleClient FOREIGN KEY (client_id) REFERENCES clients(id);

--changeset ABS:AddCompletedOnboardingColumnToClientsTable
ALTER TABLE clients
    ADD COLUMN completed_onboarding BOOLEAN NOT NULL DEFAULT TRUE;

--changeset ABS:AddBusinessInformationToClientsTable
ALTER TABLE clients
    ADD COLUMN business_name VARCHAR(255),
    ADD COLUMN business_registration_number VARCHAR(255),
    ADD COLUMN registration_date DATE,
    ADD COLUMN tax_number VARCHAR(255),
    ADD COLUMN primary_business_activity VARCHAR(255),
    ADD COLUMN state VARCHAR(255),
    ADD COLUMN city VARCHAR(255)

-- changeset ABS:AddPermissionTypeToPermissionsTable
ALTER TABLE permissions
    ADD COLUMN permission_type VARCHAR(50);

--changeset ABS:AddSingleAndDailyTransactionLimitToAccountTable
ALTER TABLE accounts
    ADD COLUMN single_transaction_limit DECIMAL(20,2),
    ADD COLUMN daily_transaction_limit DECIMAL(20,2);

--changeset ABS:AddAccountTypeToClient
ALTER TABLE clients
    ADD COLUMN account_type VARCHAR(50);

--changeset ABS:AddedModifiedByAndDeletedByColumnsToUsersAndRolesTable
ALTER TABLE users
    ADD COLUMN modified_by VARCHAR(100),
    ADD COLUMN deleted_by VARCHAR(100);

ALTER TABLE roles
    ADD COLUMN modified_by VARCHAR(100),
    ADD COLUMN deleted_by VARCHAR(100);

--changeset ABS:DroppedTokenIdOnUsersTableAndDropTokensTable
ALTER TABLE users
DROP FOREIGN KEY users_ibfk_1,
    DROP COLUMN token_id;

DROP TABLE tokens;

--changeset ABS:CreateTransactionResolutionTable
CREATE TABLE transaction_resolutions (
     id BIGINT PRIMARY KEY,
     client_id BIGINT NOT NULL,
     created_by BIGINT NOT NULL,
     attachment VARCHAR(255),
     account_name VARCHAR(255) NOT NULL,
     account_number VARCHAR(10) NOT NULL,
     amount DECIMAL(20,2) NOT NULL,
     narration VARCHAR(500) NULL,
     inter_bank_transfer BOOLEAN NOT NULL,
     intra_bank_transfer BOOLEAN NOT NULL,
     source_account_name VARCHAR(255) NOT NULL,
     source_account_number VARCHAR(10) NOT NULL,
     source_account_bank VARCHAR(255)  NOT NULL,
     destination_account_name VARCHAR(255) NOT NULL,
     destination_account_number VARCHAR(10) NOT NULL,
     destination_account_bank VARCHAR(255) NOT NULL,
     status VARCHAR(50) NOT NULL,
     session_id VARCHAR(255) NOT NULL,
     transaction_reference VARCHAR(255) NOT NULL,
     rejection_message VARCHAR(500) NULL,
     reason_for_flagging VARCHAR(500) NOT NULL,
     rejected_at TIMESTAMP,
     rejected_by BIGINT,
     created_at TIMESTAMP NOT NULL,
     updated_at TIMESTAMP,
     CONSTRAINT FK_TransactionResolutionClient FOREIGN KEY (client_id) REFERENCES clients(id),
     CONSTRAINT FK_TransactionResolutionCreatedBy FOREIGN KEY (created_by) REFERENCES users(id),
     CONSTRAINT FK_TransactionResolutionRejectedBy FOREIGN KEY (rejected_by) REFERENCES users(id)
);

--changeset ABS:UpdateTransactionResolutionTable
ALTER TABLE transaction_resolutions
    DROP COLUMN inter_bank_transfer,
    DROP COLUMN intra_bank_transfer,
    DROP COLUMN source_account_name,
    DROP COLUMN source_account_number,
    DROP COLUMN source_account_bank,
    DROP COLUMN destination_account_name,
    DROP COLUMN destination_account_number,
    DROP COLUMN destination_account_bank,
    ADD COLUMN transaction_status VARCHAR(100) NOT NULL,
    ADD COLUMN transaction_type VARCHAR(100) NOT NULL,
    ADD COLUMN transaction_date VARCHAR(100) NOT NULL;

--changeset ABS:AddAutoIncrementToTransactionResolutionTable
ALTER TABLE transaction_resolutions
    MODIFY COLUMN id BIGINT AUTO_INCREMENT;

--changeset ABS:CreateTransactionResolutionRefundTable
CREATE TABLE transaction_resolution_refund (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       transaction_resolution_id BIGINT NOT NULL,
       amount DECIMAL(10, 2) NOT NULL,
       created_at TIMESTAMP NOT NULL,
       refunded_at TIMESTAMP,
       refunded_by BIGINT NOT NULL,
       status VARCHAR(50) NOT NULL,
       CONSTRAINT FK_RefundTransactionResolution FOREIGN KEY (transaction_resolution_id) REFERENCES transaction_resolutions(id),
       CONSTRAINT FK_RefundRefundedBy FOREIGN KEY (refunded_by) REFERENCES users(id)
);

--changeset ABS:DropSessionIdFromTransactionResolutionTable
ALTER TABLE transaction_resolutions
    DROP COLUMN session_id;

--changeset ABS:DropTransactionReferenceColumnFromTransactionResolutionTable
ALTER TABLE transaction_resolutions
    DROP COLUMN transaction_reference;

--changeset ABS:AddTransactionColumnToTransactionResolutionTable
ALTER TABLE transaction_resolutions
    ADD COLUMN transaction_id BIGINT,
    ADD CONSTRAINT FK_TransactionResolutionTransaction FOREIGN KEY (transaction_id) REFERENCES transactions(id);

-- changeset ABS:MakeClientStagingTableColumnsNullable
ALTER TABLE client_staging
    MODIFY COLUMN first_name VARCHAR(255) NULL,
    MODIFY COLUMN last_name VARCHAR(255) NULL,
    MODIFY COLUMN email VARCHAR(255) NULL,
    MODIFY COLUMN state_of_residence VARCHAR(50) NULL,
    MODIFY COLUMN gender VARCHAR(50) NULL,
    MODIFY COLUMN address VARCHAR(255) NULL,
    MODIFY COLUMN employment_status VARCHAR(50) NULL,
    MODIFY COLUMN marital_status VARCHAR(50) NULL;

--changeset ABS:CreatePasswordResetBodies
CREATE TABLE password_reset_bodies(
      id BIGINT PRIMARY KEY AUTO_INCREMENT,
      reset_code VARCHAR(100) UNIQUE NOT NULL,
      created_at TIMESTAMP NOT NULL
);

--changeset ABS:ModifyBVNColumnOnClientsTableToBeMoreThanElevenCharacters
ALTER TABLE clients
    MODIFY COLUMN bvn VARCHAR(25);

--changeset ABS:AddSourceAndDestinationNameAndAccountNumberToTransactionsTable
ALTER TABLE transactions
    ADD COLUMN destination_account_number VARCHAR(10),
    ADD COLUMN destination_account_name VARCHAR(250),
    ADD COLUMN source_account_number VARCHAR(10),
    ADD COLUMN source_account_name VARCHAR(250);

--changeset ABS:AddUpdatedAtAndUpdatedByColumnsToTicketsTable
ALTER TABLE tickets
    ADD COLUMN updated_by VARCHAR(100) NULL,
    ADD COLUMN updated_at TIMESTAMP NULL;

--changeset ABS:AddCoreBankingDocumentIdAndDocumentTypeIdToDocumentsTable
ALTER TABLE documents
    ADD COLUMN core_banking_document_id BIGINT NULL,
    ADD COLUMN core_banking_document_type_id INTEGER NULL;

--changeset ABS:AddDescriptionToDocumentsTable
ALTER TABLE documents
    ADD COLUMN description VARCHAR(120) NULL;

--changeset ABS:AddCoreBankingResourceIdToDocumentsTable
ALTER TABLE documents
    ADD COLUMN core_banking_resource_id BIGINT NULL;

--changeset ABS:AddDocumentStatusAndDocumentCommentAndStatusToClientStagingTable
ALTER TABLE client_staging
    ADD COLUMN document_status VARCHAR(100) NULL,
    ADD COLUMN document_comment VARCHAR(100) NULL,
    ADD COLUMN status VARCHAR(100) NULL;

--changeset ABS:ModifyBVNandNINColumnOnClientStagingTableToBeMoreThanElevenCharacters
ALTER TABLE client_staging
    MODIFY COLUMN bvn VARCHAR(25),
    MODIFY COLUMN nin VARCHAR(25);
