package com.summer.springangular.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.summer.springangular.model.Announcement;

import com.summer.springangular.service.AnnouncementService;


@Controller 
public class AnnouncementController {

	@Autowired
	private AnnouncementService announcementService;
	
    @RequestMapping(value = "/announcement", method = RequestMethod.GET)  
	public String getAnnouncementList(ModelMap model) {    	
        model.addAttribute("announcementList", announcementService.listAnnouncement());  
        return "manageAnnouncement";  
    }  
    
    @RequestMapping(value = "/announcement/save", method = RequestMethod.POST)  
	public String createAnnouncement(@ModelAttribute Announcement announcement, ModelMap model) {
    	if(StringUtils.hasText(announcement.getId())) {
    		announcementService.updateAnnouncement(announcement);
    	} else {
    		announcementService.addAnnouncement(announcement);
    	}

        return "redirect:/announcement.html";  
    }
        
    @RequestMapping(value = "/announcement/delete", method = RequestMethod.GET)  
	public String deleteAnnouncement(@ModelAttribute Announcement announcement, ModelMap model) {  
    	announcementService.deleteAnnouncement(announcement);  
        return "redirect:/announcement.html";  
    } 
    
}
