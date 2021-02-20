//
//  Home.swift
//  MovieBookingApp
//
//  Created by Maxim Macari on 20/2/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders], content: {
                
                Section(footer: FooterView()) {
                    HStack{
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "bookmark")
                        })
                    }
                    .overlay(
                        Text("Detail Movie")
                            .font(.title2)
                            .fontWeight(.semibold)
                    )
                    .padding()
                    .foregroundColor(.white)
                    
                    ZStack{
                        //bottom shadow
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .padding(.horizontal)
                            .offset(y: 12)
                        
                        Image("fight_club")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(15)
                    }
                    .frame(width: getRect().width / 1.5, height: getRect().height / 2)
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        
                        
                        Text("Fight Club")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Director: David Fincher | 4.8/5")
                            .foregroundColor(.white)
                            .overlay(
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .offset(x: 25, y: -2)
                                , alignment: .trailing
                            )
                        
                        //Adaptive, will place how many views can possible be into a row with given minimum space
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading ,content: {
                            ForEach(genres, id: \.self) { genre in
                                Text("\(genre)")
                                    .font(.caption)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.white.opacity(0.08))
                                    .clipShape(Capsule())
                                
                            }
                         })
                        .padding(.top, 20)
                        
                        Text("Synopsis")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                        
                        Text("\(synopsis)")
                            .foregroundColor(.white)
                    })
                    .padding(.top, 50)
                    .padding(.horizontal)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            })
        })
        .background(Color.blue.ignoresSafeArea())
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Footer Button
struct FooterView: View{
    var body: some View{
        NavigationLink(
            destination: BookingVIew(),
            label: {
                Text("Buy Ticket")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: getRect().width / 2)
                    .background(Color.green.opacity(0.75))
                    .cornerRadius(15)
            })
            .shadow(color: Color.white.opacity(0.08), radius: 5, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.08), radius: 5, x: -5, y: -5)
    }
}

extension View{
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
