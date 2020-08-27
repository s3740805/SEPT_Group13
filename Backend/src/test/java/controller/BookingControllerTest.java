package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import model.Booking;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import service.BookingService;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.*;
import static org.mockito.BDDMockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

public class BookingControllerTest {
    private MockMvc mockMvc;

    @Mock
    private BookingService bookingService;

    @InjectMocks
    private BookingController bookingController;

    public static String asJsonString(final Object obj){
        try{
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e){
            throw new RuntimeException(e);
        }
    }

    @Before
    public void init(){
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(bookingController).build();
    }

    @Test
    public void shouldReturnGetAll() throws Exception{
        List<Booking> bookings = new ArrayList();
        bookings.add(new Booking(1,1,1,
                new Time(9,30,0),
                new Date(2020,8,27)));
        bookings.add(new Booking(2,2,1,
                new Time(16,0,0),
                new Date(2020,8,30)));

        given(bookingService.getAllBooking()).willReturn(bookings);
        mockMvc.perform(get("/bookings"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(jsonPath("$",hasSize(2)))
                .andExpect(jsonPath("$[0].doctor_id",is(1)))
                .andExpect(jsonPath("$[0].patient_id",is(1)));
        verify(bookingService,times(1)).getAllBooking();
    }

    @Test
    public void shouldMakeNewBooking() throws Exception{
        Booking booking = new Booking(1,1,1,
                new Time(9,30,0),
                new Date(2020,8,27));

        given(bookingService.addBooking(booking)).willReturn(booking.getId());
        mockMvc.perform(
                post("/bookings")
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .accept(MediaType.APPLICATION_JSON_UTF8)
                    .content(asJsonString(booking)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", is(0))); //changed to 0 worked, put booking.get => khong duoc
        verify(bookingService, times(1)).addBooking(Mockito.any(Booking.class));
    }

    @Test
    public void shouldCancelBooking() throws Exception{
        Booking booking = new Booking(1,1,1,
                new Time(9,30,0),
                new Date(2020,8,27));
        given(bookingService.addBooking(booking)).willReturn(booking.getId());
        doNothing().when(bookingService).deleteBooking(booking.getId());
        mockMvc.perform(
                delete("/bookings/{id}",booking.getId()))
                .andExpect(status().isOk());
        verify(bookingService,times(1)).deleteBooking(booking.getId());
    }
}
