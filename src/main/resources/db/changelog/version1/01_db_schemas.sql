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