require 'set'

require 'savon'
require 'netsuite/version'
require 'netsuite/errors'
require 'netsuite/xml_logger'
require 'netsuite/core_ext/string/lower_camelcase'

module NetSuite
  autoload :Configuration, 'netsuite/configuration'
  autoload :Response,      'netsuite/response'

  module Namespaces
    autoload :ListAcct,       'netsuite/namespaces/list_acct'
    autoload :ListRel,        'netsuite/namespaces/list_rel'
    autoload :PlatformCommon, 'netsuite/namespaces/platform_common'
    autoload :PlatformCore,   'netsuite/namespaces/platform_core'
    autoload :TranCust,       'netsuite/namespaces/tran_cust'
    autoload :TranGeneral,    'netsuite/namespaces/tran_general'
    autoload :TranSales,      'netsuite/namespaces/tran_sales'
    autoload :TranInvt,       'netsuite/namespaces/tran_invt'
    autoload :TranPurch,      'netsuite/namespaces/tran_purch'
    autoload :SetupCustom,    'netsuite/namespaces/setup_custom'
  end

  module Support
    autoload :Actions,    'netsuite/support/actions'
    autoload :Attributes, 'netsuite/support/attributes'
    autoload :Fields,     'netsuite/support/fields'
    autoload :RecordRefs, 'netsuite/support/record_refs'
    autoload :Records,    'netsuite/support/records'
    autoload :Requests,   'netsuite/support/requests'
    autoload :SearchResult, 'netsuite/support/search_result'
  end

  module Actions
    autoload :Add,        'netsuite/actions/add'
    autoload :Delete,     'netsuite/actions/delete'
    autoload :Get,        'netsuite/actions/get'
    autoload :Initialize, 'netsuite/actions/initialize'
    autoload :Update,     'netsuite/actions/update'
    autoload :Search, 'netsuite/actions/search'
    autoload :SearchMoreWithId, 'netsuite/actions/search_more_with_id'
  end

  module Records
    autoload :AssemblyItem,               'netsuite/records/assembly_item'
    autoload :Account,                    'netsuite/records/account'
    autoload :AccountingPeriod,           'netsuite/records/accounting_period'
    autoload :BillAddress,                'netsuite/records/bill_address'
    autoload :Classification,             'netsuite/records/classification'
    autoload :CreditMemo,                 'netsuite/records/credit_memo'
    autoload :CreditMemoApply,            'netsuite/records/credit_memo_apply'
    autoload :CreditMemoApplyList,        'netsuite/records/credit_memo_apply_list'
    autoload :CreditMemoItem,             'netsuite/records/credit_memo_item'
    autoload :CreditMemoItemList,         'netsuite/records/credit_memo_item_list'
    autoload :CustomField,                'netsuite/records/custom_field'
    autoload :CustomFieldList,            'netsuite/records/custom_field_list'
    autoload :CustomRecord,               'netsuite/records/custom_record'
    autoload :CustomRecordRef,            'netsuite/records/custom_record_ref'
    autoload :CustomRecordType,           'netsuite/records/custom_record_type'
    autoload :Customer,                   'netsuite/records/customer'
    autoload :CustomerAddressbook,        'netsuite/records/customer_addressbook'
    autoload :CustomerAddressbookList,    'netsuite/records/customer_addressbook_list'
    autoload :CustomerPayment,            'netsuite/records/customer_payment'
    autoload :CustomerRefund,             'netsuite/records/customer_refund'
    autoload :CustomerRefundApply,        'netsuite/records/customer_refund_apply'
    autoload :CustomerRefundApplyList,    'netsuite/records/customer_refund_apply_list'
    autoload :CustomerRefundDeposit,      'netsuite/records/customer_refund_deposit'
    autoload :CustomerRefundDepositList,  'netsuite/records/customer_refund_deposit_list'
    autoload :Department,                 'netsuite/records/department'
    autoload :Duration,                   'netsuite/records/duration'
    autoload :InventoryItem,              'netsuite/records/inventory_item'
    autoload :InventoryAdjustment,        'netsuite/records/inventory_adjustment'
    autoload :InventoryAdjustmentInventory,  'netsuite/records/inventory_adjustment_inventory'
    autoload :InventoryAdjustmentInventoryList,  'netsuite/records/inventory_adjustment_inventory_list'
    autoload :Invoice,                    'netsuite/records/invoice'
    autoload :InvoiceItem,                'netsuite/records/invoice_item'
    autoload :InvoiceItemList,            'netsuite/records/invoice_item_list'
    autoload :ItemFulfillment,            'netsuite/records/item_fulfillment'
    autoload :ItemFulfillmentItem,        'netsuite/records/item_fulfillment_item'
    autoload :ItemFulfillmentItemList,    'netsuite/records/item_fulfillment_item_list'
    autoload :ItemReceipt,                'netsuite/records/item_receipt'
    autoload :ItemReceiptExpense,         'netsuite/records/item_receipt_expense'
    autoload :ItemReceiptExpenseList,     'netsuite/records/item_receipt_expense_list'
    autoload :ItemReceiptItem,            'netsuite/records/item_receipt_item'
    autoload :ItemReceiptItemList,        'netsuite/records/item_receipt_item_list'
    autoload :Job,                        'netsuite/records/job'
    autoload :JournalEntry,               'netsuite/records/journal_entry'
    autoload :JournalEntryLine,           'netsuite/records/journal_entry_line'
    autoload :JournalEntryLineList,       'netsuite/records/journal_entry_line_list'
    autoload :Location,                   'netsuite/records/location'
    autoload :LandedCost,                 'netsuite/records/landed_cost'
    autoload :NonInventorySaleItem,       'netsuite/records/non_inventory_sale_item'
    autoload :PaymentMethod,              'netsuite/records/payment_method'
    autoload :PricingMatrix,              'netsuite/records/pricing_matrix'
    autoload :PurchLandedCostList,        'netsuite/records/purch_landed_cost_list'
    autoload :RecordRef,                  'netsuite/records/record_ref'
    autoload :ReturnAuthorization,        'netsuite/records/return_authorization'
    autoload :ReturnAuthorizationItem,    'netsuite/records/return_authorization_item'
    autoload :ReturnAuthorizationItemList,'netsuite/records/return_authorization_item_list'
    autoload :RevRecTemplate,             'netsuite/records/rev_rec_template'
    autoload :ShipAddress,                'netsuite/records/ship_address'
    autoload :SalesOrder,                 'netsuite/records/sales_order'
    autoload :SalesOrderItem,             'netsuite/records/sales_order_item'
    autoload :SalesOrderItemList,         'netsuite/records/sales_order_item_list'
    autoload :Term,                       'netsuite/records/term'
    autoload :Transaction,                'netsuite/records/transaction'
    autoload :TransferOrder,              'netsuite/records/transfer_order'
    autoload :TransferOrderItem,          'netsuite/records/transfer_order_item'
    autoload :TransferOrderItemList,      'netsuite/records/transfer_order_item_list'
    autoload :TransferOrderStatus,        'netsuite/records/transfer_order_status'
  end

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
    Savon.configure do |config|
      config.logger = NetSuite::XmlLogger.new(STDOUT)
    end
  end

end
