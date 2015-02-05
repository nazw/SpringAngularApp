package com.summer.springangular.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.summer.springangular.model.Person;

@Controller
public class EmployeeController {

	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView welcome() {
		
		return new ModelAndView("index");
	}

	
	@RequestMapping(value="/springAngularJS",method=RequestMethod.GET,produces={"application/xml", "application/json"})
    public @ResponseBody Person  getPerson() {	
		System.out.println("aaaaaaaaaaa");
		Person person = new Person();
		person.setFirstName("Java");
		person.setLastName("Honk");
		return person;
	}
	
}
