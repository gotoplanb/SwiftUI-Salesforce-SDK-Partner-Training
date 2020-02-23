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
  var disabled: Bool = false

  var body: some View {
    HStack {
      Text(key).bold()
      TextField(value, text: $value).disabled(self.disabled)
    }
  }

}

struct ContactEditView: View {
  @Binding var contact:Contact

  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      ContactEditRow(key: "First Name", value: $contact.FirstName.nonOptional)
      ContactEditRow(key: "Last Name", value: $contact.LastName.nonOptional)
      ContactEditRow(key: "Phone Number", value: $contact.Phone.nonOptional)
      ContactEditRow(key: "Email", value: $contact.Email.nonOptional)
      ContactEditRow(key: "Mailing Street", value: $contact.MailingStreet.nonOptional)
      ContactEditRow(key: "Mailing City", value: $contact.MailingCity.nonOptional)
      ContactEditRow(key: "Mailing State", value: $contact.MailingState.nonOptional)
      ContactEditRow(key: "Mailing Postal Code", value: $contact.MailingPostalCode.nonOptional)
      ContactEditRow(key: "AccountId", value: $contact.AccountId.nonOptional, disabled: true)
      Spacer()
    }.padding()
  }
}

struct ContactEditView_Previews: PreviewProvider {
  @State static var contact = Contact(
    Id: "123456",
    FirstName: "Astro",
    LastName: "Nomical",
    Phone: "9198675309",
    Email: "Astro.Nomical@gmail.com",
    MailingStreet: "123 Sessame St",
    MailingCity: "Sunny Days",
    MailingState: "NJ",
    MailingPostalCode: "12345"
  )
  static var previews: some View {
    ContactEditView(contact: $contact )
  }
}
