//
//  Lead.swift
//  Insuree Agent
//
//  Created by Amit Sen on 10/26/17.
//  Copyright © 2017 Insuree Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class Lead: Mappable {
    private struct Key {
        let id_key = "id"
        let user_id_key = "user_id"
        let agent_user_id_key = "agent_user_id"
        let alerts_id_key = "alerts_id"
        let enquiries_id_key = "enquiries_id"
        let is_requested_by_agent_key = "is_requested_by_agent"
        let is_accepted_by_user_key = "is_accepted_by_user"
        let created_at_key = "created_at"
        let user_profile_key = "user_profile"
        let agent_profile_key = "agent_profile"
        let enquiries_key = "enquiries"
    }
    
    internal var id: Int?
    internal var userId: Int?
    internal var agentUserId: Int?
    internal var alertId: Int?
    internal var enquiryId: Int?
    internal var isRequestedByAgent: String?
    internal var isAcceptedByUser: String?
    internal var createdAt: String?
    
    required internal init(map: Map) {
        mapping(map: map)
    }
    
    internal func mapping(map: Map) {
        let key = Key.init()
        
        id <- map[key.id_key]
        userId <- map[key.user_id_key]
        agentUserId <- map[key.agent_user_id_key]
        alertId <- map[key.alerts_id_key]
        enquiryId <- map[key.enquiries_id_key]
        isRequestedByAgent <- map[key.is_requested_by_agent_key]
        isAcceptedByUser <- map[key.is_accepted_by_user_key]
        createdAt <- map[key.created_at_key]
    }
}
