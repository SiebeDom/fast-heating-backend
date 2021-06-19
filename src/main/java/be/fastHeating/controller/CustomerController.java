package be.fastHeating.controller;

import be.fastHeating.model.Customer;
import be.fastHeating.model.CustomerNotFoundException;
import be.fastHeating.repository.CustomerRepository;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
class CustomerController {
    private final CustomerRepository repository;

    CustomerController(CustomerRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/customers")
    List<Customer> all() {
        List<Customer> result = new ArrayList<>();
        repository.findAll().forEach(result::add);
        return result;
    }

    @PostMapping("/customers")
    Customer newCustomer(@RequestBody Customer newCustomer) {
        return repository.save(newCustomer);
    }

    @GetMapping("/customers/{id}")
    Customer one(@PathVariable Long id) {

        return repository.findById(id)
                .orElseThrow(() -> new CustomerNotFoundException(id));
    }

    @CrossOrigin(origins = "http://localhost:4200")
    @PutMapping("/customers/{id}")
    Customer replaceCustomer(@RequestBody Customer newCustomer, @PathVariable Long id) {
        return repository.findById(id)
                .map(customer -> {
                    customer.setType(newCustomer.getType());
                    customer.setName(newCustomer.getName());
                    customer.setStreet(newCustomer.getStreet());
                    customer.setHouseNumber(newCustomer.getHouseNumber());
                    customer.setBoxNumber(newCustomer.getBoxNumber());
                    customer.setPostalCode(newCustomer.getPostalCode());
                    customer.setCity(newCustomer.getCity());
                    customer.setPhone(newCustomer.getPhone());
                    customer.setMobile(newCustomer.getMobile());
                    customer.setEmail(newCustomer.getEmail());
                    return repository.save(customer);
                })
                .orElseGet(() -> {
                    newCustomer.setId(id);
                    return repository.save(newCustomer);
                });
    }

    @CrossOrigin(origins = "http://localhost:4200")
    @DeleteMapping("/customers/{id}")
    void deleteCustomer(@PathVariable Long id) {
        repository.deleteById(id);
    }

}