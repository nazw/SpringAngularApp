package com.summer.springangular.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;
import java.util.Calendar;
import com.summer.springangular.model.Announcement;

@Repository
public class AnnouncementService {

	
	@Autowired
	private MongoTemplate mongoTemplate;
	
	public static final String COLLECTION_NAME = "announcement";
	
	public void addAnnouncement(Announcement announcement) {
		if (!mongoTemplate.collectionExists(Announcement.class)) {
			mongoTemplate.createCollection(Announcement.class);
		}		
		announcement.setId(UUID.randomUUID().toString());
		Date date = new Date();
		announcement.setStartDate(date);
		announcement.setExpirydate(Calendar.getInstance().getTime());
		mongoTemplate.insert(announcement, COLLECTION_NAME);
	}
	
	public List<Announcement> listAnnouncement() {
		return mongoTemplate.findAll(Announcement.class, COLLECTION_NAME);
	}
	
	public void deleteAnnouncement(Announcement announcement) {
		mongoTemplate.remove(announcement, COLLECTION_NAME);
	}
	
	public void updateAnnouncement(Announcement announcement) {
		mongoTemplate.insert(announcement, COLLECTION_NAME);		
	}
	
}
