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
        bookings.add(new Booking(1,1, null,null));
        bookings.add(new Booking(2,1,null,null));

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
        Booking booking = new Booking(1,1,null,null);
        given(bookingService.addBooking(booking)).willReturn(booking.getId());
        mockMvc.perform(
                post("/bookings")
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .accept(MediaType.APPLICATION_JSON_UTF8)
                    .content(asJsonString(booking)))
                .andExpect(status().isOk())
                // Actual is 0. booking.getId() resulted in 0, because there is no id
                .andExpect(jsonPath("$", is(booking.getId())));
        verify(bookingService, times(1)).addBooking(Mockito.any(Booking.class));
    }

    @Test
    public void shouldCancelBooking() throws Exception{
        Booking booking = new Booking(1,1, null, null);
        given(bookingService.addBooking(booking)).willReturn(booking.getId());
        doNothing().when(bookingService).deleteBooking(booking.getId());
        mockMvc.perform(
                delete("/bookings/{id}",booking.getId()))
                .andExpect(status().isOk());
        verify(bookingService,times(1)).deleteBooking(booking.getId());
    }
}
