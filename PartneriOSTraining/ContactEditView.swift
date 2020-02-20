//
//  ContactEditView.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/19/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import SwiftUI

struct ContactEditRow: View {
  var key: String
  @Binding var value: String
  
  var body: some View {
    HStack{
      Text(key).bold()
      Divider()
      TextField(key, text: $value)
    }
  }
  
}

struct ContactEditView: View {
  @State var contact:Contact

  var body: some View {
    VStack{
      ContactEditRow(key: contact.FirstName, value: $contact.FirstName)
      ContactEditRow(key: contact.LastName, value: $contact.LastName)
      ContactEditRow(key: contact.PhoneNumber, value: $contact.PhoneNumber)
      ContactEditRow(key: contact.Email, value: $contact.Email)
      ContactEditRow(key: contact.MailingStreet, value: $contact.MailingStreet)
      ContactEditRow(key: contact.MailingCity, value: $contact.MailingCity)
      ContactEditRow(key: contact.MailingState, value: $contact.MailingState)
      ContactEditRow(key: contact.MailingPostalCode, value: $contact.MailingPostalCode)
    }
  }
}

struct ContactEditView_Previews: PreviewProvider {
  static var previews: some View {
    ContactEditView(contact: Contact(
      Id: "123456",
      FirstName: "Astro",
      LastName: "Nomical",
      PhoneNumber: "9198675309",
      Email: "Astro.Nomical@gmail.com",
      MailingStreet: "123 Sessame St",
      MailingCity: "Sunny Days",
      MailingState: "NJ",
      MailingPostalCode: "12345"
    ))
  }
}
