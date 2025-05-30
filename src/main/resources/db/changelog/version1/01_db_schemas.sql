--liquibase formatted sql


--changeset ABS:CreateTransferApprovalTable
CREATE TABLE transfer_approvals (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    transfer_id BIGINT NOT NULL,
    approved BOOLEAN NOT NULL,
    action_date TIMESTAMP,
    CONSTRAINT FK_UserTransferApproval FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT FK_BusinessInterBankTransferApproval FOREIGN KEY (transfer_id) REFERENCES business_client_inter_bank_transfers(id)

);

--changeset ABS:CreateTransferApprovalMandatePolicies
CREATE TABLE transfer_approval_mandate_policies (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    mandate_type VARCHAR(50) NOT NULL,
    client_id BIGINT NOT NULL,
    required_count INTEGER NULL,
    created_at TIMESTAMP,
    CONSTRAINT FK_ClientTransferApprovalMandatePolicy FOREIGN KEY (client_id) REFERENCES clients(id)
);

--changeset ABS:AddedTransferInitiatorAndApprovedAndBlockedColumnToBusinessClientInterBankTransfersTable
ALTER TABLE business_client_inter_bank_transfers
    ADD COLUMN transfer_initiator_id BIGINT,
    ADD COLUMN approved BOOLEAN,
    ADD COLUMN blocked BOOLEAN,
    ADD CONSTRAINT FK_UserBuinsessInterBankTransferInitiator FOREIGN KEY (transfer_initiator_id) REFERENCES users(id);


--changeset ABS:AddedStatusAndCallBackColumnToBusinessClientInterBankTransferDetailTable
ALTER TABLE business_client_inter_bank_transfer_detail
    ADD COLUMN status VARCHAR(50),
    ADD COLUMN callback VARCHAR(150);

--changeset ABS:CreateTestTable
CREATE TABLE test_table (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    mandate_type VARCHAR(50) NOT NULL,
    client_id BIGINT NOT NULL,
    required_count INTEGER NULL,
    created_at TIMESTAMP
);

--changeset ABS:DropTestTable
DROP TABLE test_table;

--changeset ABS:ModifiedFirstNameAndLastNameColumnsToNullOnUsersTableAndGenderColumnToNullOnClientsTable
ALTER TABLE users
    MODIFY COLUMN first_name VARCHAR(150) NULL,
    MODIFY COLUMN last_name VARCHAR(150) NULL;

ALTER TABLE clients
    MODIFY COLUMN gender VARCHAR(50) NULL;


--changeset ABS:CreateWebSocketConnectionsTable
CREATE TABLE websocket_connections (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    principal_id VARCHAR(170) NOT NULL,
    connection_id VARCHAR(50) NOT NULL,
    created_at BIGINT,
    session_attributes TEXT
);

--changeset ABS:ModifiedAddressColumnToNullableOnClientsTable
ALTER TABLE clients
    MODIFY COLUMN address VARCHAR(255) NULL;


--changeset ABS:ModifiedStateOfResidenceAndEmploymentStatusAndMaritalStatusColumnToNullableOnClientsTable
ALTER TABLE clients
    MODIFY COLUMN state_of_residence VARCHAR(255) NULL,
    MODIFY COLUMN employment_status VARCHAR(70) NULL,
    MODIFY COLUMN marital_status VARCHAR(70) NULL;


--changeset ABS:AddedAccountNameToClientsTable
ALTER TABLE clients
    ADD COLUMN account_name VARCHAR(200) NULL;

--changeset ABS:AddFieldsToBusinessClientInterBankTransferTable
ALTER TABLE business_client_inter_bank_transfer_detail
    ADD COLUMN sent_to_tp_gateway_for_bulk_name_inquiry BOOLEAN DEFAULT FALSE,
    ADD COLUMN approved_for_bulk_name_inquiry BOOLEAN DEFAULT FALSE,
    ADD COLUMN name_inquiry_status VARCHAR (255) NULL,
    ADD COLUMN valid_destination_account_name VARCHAR(255),
    ADD COLUMN deleted BOOLEAN DEFAULT FALSE;
