package be.fastHeating.controller;

import be.fastHeating.model.Customer;
import be.fastHeating.model.Invoice;
import be.fastHeating.model.InvoiceNotFoundException;
import be.fastHeating.repository.CustomerRepository;
import be.fastHeating.repository.InvoiceRepository;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
class InvoiceController {
    private final InvoiceRepository invoiceRepository;
    private final CustomerRepository customerRepository;

    InvoiceController(InvoiceRepository invoiceRepository, CustomerRepository customerRepository) {
        this.invoiceRepository = invoiceRepository;
        this.customerRepository = customerRepository;
    }

    @GetMapping("/invoices")
    List<Invoice> all() {
        List<Invoice> result = new ArrayList<>();
        invoiceRepository.findAll().forEach(result::add);
        return result;
    }

    @PostMapping("/invoices")
    Invoice newInvoice(@RequestBody Invoice newInvoice) {
        Customer attachedCustomer = customerRepository.findById(newInvoice.getCustomer().getId()).orElse(null);
        newInvoice.setCustomer(attachedCustomer);
        return invoiceRepository.save(newInvoice);
    }

    @GetMapping("/invoices/{id}")
    Invoice one(@PathVariable Long id) {

        return invoiceRepository.findById(id)
                .orElseThrow(() -> new InvoiceNotFoundException(id));
    }

    @CrossOrigin(origins = "http://localhost:4200")
    @PutMapping("/invoices/{id}")
    Invoice replaceInvoice(@RequestBody Invoice newInvoice, @PathVariable Long id) {
        Customer attachedCustomer = customerRepository.findById(newInvoice.getCustomer().getId()).orElse(null);
        return invoiceRepository.findById(id)
                .map(invoice -> {
                    invoice.setType(newInvoice.getType());
                    invoice.setDate(newInvoice.getDate());
                    invoice.setDescription(newInvoice.getDescription());
                    invoice.setConditions(newInvoice.getConditions());
                    invoice.setCustomer(attachedCustomer);
                    invoice.setSubTotal(newInvoice.getSubTotal());
                    invoice.setVatRate(newInvoice.getVatRate());
                    invoice.setVatAmount(newInvoice.getVatAmount());
                    invoice.setTotal(newInvoice.getTotal());
                    invoice.setYearNumber(newInvoice.getYearNumber());
                    invoice.setIndexNumber(newInvoice.getIndexNumber());
                    invoice.setNumber(newInvoice.getNumber());
                    return invoiceRepository.save(invoice);
                })
                .orElseGet(() -> {
                    newInvoice.setId(id);
                    return invoiceRepository.save(newInvoice);
                });
    }

    @CrossOrigin(origins = "http://localhost:4200")
    @DeleteMapping("/invoices/{id}")
    void deleteInvoice(@PathVariable Long id) {
        invoiceRepository.deleteById(id);
    }

}