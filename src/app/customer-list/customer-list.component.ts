import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTable } from '@angular/material/table';
import { Router } from '@angular/router';
import { Customer } from '../model/customer';
import { CustomerService } from '../service/customer.service';
import { CustomerListDataSource } from './customer-list-datasource';

@Component({
  selector: 'app-customer-list',
  templateUrl: './customer-list.component.html',
  styleUrls: ['./customer-list.component.css']
})
export class CustomerListComponent implements AfterViewInit {
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild(MatTable) table: MatTable<Customer>;
  dataSource: CustomerListDataSource;

  displayedColumns = ['number', 'type', 'name'];

  constructor(
    private customerService: CustomerService,
    private router: Router) {
    this.customerService = customerService;
  }

  getcustomers(): void {
    this.customerService.getcustomers()
      .subscribe(customers => {
        this.dataSource = new CustomerListDataSource(customers);
        this.dataSource.sort = this.sort;
        this.dataSource.paginator = this.paginator;
        this.table.dataSource = this.dataSource;
      });
  }

  selectCustomer(row: any) {
    this.router.navigate(['/template/customer/edit/' + row.id]);
  }

  ngAfterViewInit() {
    this.getcustomers();
  }
}
