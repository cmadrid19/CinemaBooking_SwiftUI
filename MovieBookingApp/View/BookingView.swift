//
//  BookingVIew.swift
//  MovieBookingApp
//
//  Created by Maxim Macari on 20/2/21.
//

import SwiftUI

struct BookingVIew: View {
    
    @State var bookedSeats: [Int] = [1, 10 , 11, 30, 45, 35]
    @State var selectedSaets: [Int] = []
    
    @State var date: Date = Date()
    
    @State var selectedTime = "11:30"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                Spacer()
            }
            .overlay(
                Text("Seelect seats")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            )
            .padding()
            
            //theater screen view
            
            GeometryReader{ geo in
                
                
                //to get width
                let width = geo.frame(in: .global).width
                
                Path{ path in
                    //Create curve
                    path.move(to: CGPoint(x: 0, y: 50))
                    
                    path.addCurve(to: CGPoint(x: width, y: 50), control1: CGPoint(x: width / 2, y: 10), control2: CGPoint(x: width / 2, y: 10))
                    
                }
                .stroke(Color.white.opacity(0.5), lineWidth: 1.5)
            }
            .frame(height: 50)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            
            //Grid view of seats
            
            //total seats = 60
            //Mock seats = 4 to adjust space
            let totalSeats = 60 + 4
            let leftSide = 0..<totalSeats/2
            let rightSide = totalSeats/2..<totalSeats
            
            HStack(spacing: 30){
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 4)
                LazyVGrid(columns: columns, spacing: 13, content: {
                    ForEach(leftSide, id: \.self){ index in
                        //getting correct seeat
                        let seat = index >= 29 ? index - 1 : index
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSaets, bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                //cheking add adding
                                if selectedSaets.contains(seat){
                                    //reemoving
                                    selectedSaets.removeAll() { (removeSeat) -> Bool in
                                        return removeSeat == seat
                                    }
                                    return
                                }
                                //adding
                                selectedSaets.append(seat)
                                print(seat)
                            }
                            //diasabled if seat is alreaedy booked
                            .disabled(bookedSeats.contains(seat))
                            .disabled(index == 0 || index == 28 || index == 35 || index == 63 ? true : false)
                    }
                    
                })
                
                LazyVGrid(columns: columns, spacing: 13, content: {
                    
                    ForEach(rightSide, id: \.self){ index in
                        //getting correct seeat
                        let seat = index >= 35 ? index - 2 : (index - 1)
                        
                        SeatView(index: index, seat: seat, selectedSeats: $selectedSaets, bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                //cheking add adding
                                if selectedSaets.contains(seat){
                                    //reemoving
                                    selectedSaets.removeAll() { (removeSeat) -> Bool in
                                        return removeSeat == seat
                                    }
                                    return
                                }
                                //adding
                                selectedSaets.append(seat)
                                print(seat)
                            }
                            //diasabled if seat is alreaedy booked
                            .disabled(bookedSeats.contains(seat))
                            .disabled(index == 0 || index == 28 || index == 35 || index == 63 ? true : false)
                    }
                })
            }
            .padding()
            .padding(.top, 30)
            
            //summary
            HStack(spacing: 15){
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
                
                Text("unavailable")
                    .font(.caption)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 20, height: 20)
                
                Text("available")
                    .font(.caption)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                Text("selected")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.top, 25)
            
            
            //Date
            HStack{
                Text("Date: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .foregroundColor(.white)
                    .background(Color.white.opacity(1))
                    .cornerRadius(15)
                
            }
            .padding()
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15){
                    ForEach(time, id: \.self) { currentTime in
                        Text("\(currentTime)")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .background( selectedTime == currentTime ? Color.green.opacity(0.9) : Color.white.opacity(0.15))
                            .cornerRadius(15)
                            .onTapGesture {
                                selectedTime = currentTime
                            }
                    }
                }
                .padding(.horizontal)
            })
            
            HStack(spacing: 15){
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("\(selectedSaets.count) Seats")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(selectedSaets.count * 9) €")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                })
                .frame(width: 100)
                
                Button(action: {
                    
                }, label: {
                    Text("Buy ticket")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(15)
                })
            }
            .padding()
            .padding(.top)
            
        })
        .background(Color.blue.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SeatView: View {
    
    var index: Int
    var seat: Int
    
    @Binding var selectedSeats: [Int]
    @Binding var bookedSeats: [Int]
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .stroke(bookedSeats.contains(seat) ? Color.gray : (selectedSeats.contains(seat) ? Color.green : Color.black.opacity(0.7)), lineWidth: 2)
                .frame(height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill( selectedSeats.contains(seat) ? Color.green : Color.clear)
                )
                //Hiding those for mock seats
                .opacity(index == 0 || index == 28 || index == 35 || index == 63 ? 0 : 1)
            
            if bookedSeats.contains(seat) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct BookingVIew_Previews: PreviewProvider {
    static var previews: some View {
        BookingVIew()
    }
}
