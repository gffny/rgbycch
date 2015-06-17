/**
 * 
 */
package com.gffny.rgbycch.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gffny.rgbycch.model.Player;
import com.gffny.rgbycch.model.enums.PlayerPosition;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class PlayerRestController extends V1RestController {

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/player/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Player> getPlayer(@PathVariable String id) {
	LOG.debug("get player with id {}", id);
	Player player = new Player();
	player.setFirstName("John");
	player.setSurname("Gaffney");
	player.setPrimaryPosition(PlayerPosition.PP10);
	return new ResponseEntity<Player>(player, HttpStatus.OK);
    }

    /**
     * 
     * @param id
     * @param player
     * @return
     */
    @RequestMapping(value = "/player/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Player> setPlayer(@PathVariable String id,
	    @RequestBody Player player) {
	LOG.debug("update player with id {}, firstName {}, surname {}", id,
		player.getFirstName(), player.getSurname());
	return new ResponseEntity<Player>(player, HttpStatus.OK);
    }
}
