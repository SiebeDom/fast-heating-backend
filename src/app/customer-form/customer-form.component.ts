import { Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Customer } from '../model/customer';
import { CustomerType } from '../model/customerType';
import { InvoiceType } from '../model/invoiceType';
import { CustomerService } from '../service/customer.service';

@Component({
  selector: 'app-customer-form',
  templateUrl: './customer-form.component.html',
  styleUrls: ['./customer-form.component.css']
})
export class CustomerFormComponent {
  customerForm = this.fb.group({
    number: [{ value: null, disabled: true }, Validators.required],
    type: [{ value: null }, Validators.required],
    name: [null, Validators.required],
    taxNumber: [null],
    street: [null, Validators.required],
    houseNumber: [null, Validators.required],
    boxNumber: null,
    city: [null, Validators.required],
    postalCode: [null, Validators.compose([
      Validators.required, Validators.minLength(4), Validators.maxLength(4)])
    ],
    country: null,
    email: null,
    phone: null,
    mobile: null,
    foreign: null,
  });

  customer: Customer;
  pad = "000";
  invoiceAction: string;
  invoiceId: number;
  invoiceType: InvoiceType;
  invoiceDate: string;
  invoiceDescription: string;
  invoiceConditions: string;
  invoiceSubTotal: number;
  invoiceVatAmount: number;
  invoiceVatRate: number;
  invoiceTotal: number;

  constructor(
    private fb: FormBuilder,
    private customerService: CustomerService,
    private route: ActivatedRoute,
    private router: Router) {
  }

  ngOnInit(): void {
    let id = this.route.snapshot.paramMap.get('id');
    this.invoiceAction = this.route.snapshot.paramMap.get('invoiceAction');
    this.invoiceId = +this.route.snapshot.paramMap.get('invoiceId');
    this.invoiceType = this.route.snapshot.paramMap.get('invoiceType') === InvoiceType.INVOICE ? InvoiceType.INVOICE : InvoiceType.CREDIT_NOTE;
    this.invoiceDate = this.route.snapshot.paramMap.get('invoiceDate');
    this.invoiceDescription = this.route.snapshot.paramMap.get('invoiceDescription');
    this.invoiceConditions = this.route.snapshot.paramMap.get('invoiceConditions');
    this.invoiceSubTotal = +this.route.snapshot.paramMap.get('invoiceSubTotal');
    this.invoiceVatRate = +this.route.snapshot.paramMap.get('invoiceVatRate');
    this.invoiceVatAmount = +this.route.snapshot.paramMap.get('invoiceVatAmount');
    this.invoiceTotal = +this.route.snapshot.paramMap.get('invoiceTotal');
    //Edit mode
    if (id != null) {
      this.customerService.getcustomer(+id).subscribe(customer => {
        this.customer = customer;
        this.customerForm.patchValue({
          number: this.customer.number,
          type: this.customer.type,
          name: this.customer.name,
          taxNumber: this.customer.taxNumber,
          street: this.customer.street,
          houseNumber: this.customer.houseNumber,
          boxNumber: this.customer.boxNumber,
          postalCode: this.customer.postalCode,
          country: this.customer.country,
          city: this.customer.city,
          email: this.customer.email,
          phone: this.customer.phone,
          mobile: this.customer.mobile,
          foreign: this.customer.foreign,
        });
      });
    } else {//Create mode
      this.customer = new Customer();
      this.customer.type = CustomerType.INDIVIDUAL;
      this.customer.foreign = false;
      this.customerForm.patchValue({
        type: this.customer.type,
        foreign: this.customer.foreign,
      });
    }
  }

  save(returnToInvoiceForm:boolean): void {
    this.customer.type = this.customerForm.value.type;
    this.customer.name = this.customerForm.value.name;
    this.customer.taxNumber = this.customerForm.value.taxNumber;
    this.customer.street = this.customerForm.value.street;
    this.customer.houseNumber = this.customerForm.value.houseNumber;
    this.customer.boxNumber = this.customerForm.value.boxNumber;
    this.customer.postalCode = this.customerForm.value.postalCode;
    this.customer.country = this.customerForm.value.country;
    this.customer.city = this.customerForm.value.city;
    this.customer.email = this.customerForm.value.email;
    this.customer.phone = this.customerForm.value.phone;
    this.customer.mobile = this.customerForm.value.mobile;
    this.customer.foreign = this.customerForm.value.foreign;
    //Edit mode
    if (this.customer.id != null) {
      this.customerService.updatecustomer(this.customer, this.customer.id).subscribe(()=>{
          if(returnToInvoiceForm){
            this.returnToInvoice();
          }  
        }
      );
    } else {//Create mode
      this.customerService.getCustomersOfThisYear().subscribe(customers => {
        this.customer.year = new Date().getFullYear();
        this.customer.index = customers.length > 0 ? Math.max(...customers.map(t => t.index)) + 1 : 1;
        this.customer.number = "K" + this.customer.year.toString().substr(this.customer.year.toString().length - 2) + " " + (this.pad + this.customer.index.toString()).slice(-this.pad.length);
        this.customerService.addCustomer(this.customer).subscribe(customer => {
          this.customer = customer;
          this.customerForm.patchValue({
            number: this.customer.number,
          });
          if(returnToInvoiceForm){
            this.returnToInvoice();
          }  
        });
      });
    }
  }

  setForeign(checkboxValue: boolean) {
    this.customer.foreign = checkboxValue;
    this.customerForm.patchValue({
      foreign: this.customer.foreign
    });
  }

  returnToInvoice() {
    this.router.navigate(['/template/invoice/' + this.invoiceAction + '/' + (this.invoiceAction === 'new' ? '' : this.invoiceId), {
      customerId: this.customer.id,
      invoiceType: this.invoiceType,
      invoiceDate: this.invoiceDate,
      invoiceDescription: this.invoiceDescription,
      invoiceConditions: this.invoiceConditions,
      invoiceSubTotal: this.invoiceSubTotal,
      invoiceVatAmount: this.invoiceVatAmount,
      invoiceVatRate: this.invoiceVatRate,
      invoiceTotal: this.invoiceTotal,
    }]);
  }

  delete(): void {
    this.customerService.deletecustomer(this.customer).subscribe();
  }
}
