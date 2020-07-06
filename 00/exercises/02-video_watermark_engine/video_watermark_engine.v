`timescale 1ns/100ps

/**
 * Are you the owner of a bar who wants your bar's name to appear at the top left of all your
 * TV's? you're in luck!
 *
 * In a last ditch attempt to stay irrelevant, BoomerCorp has begun work on a new product that
 * will let users overlay their own watermark in a grayscale video stream.
 *                       ___________                                  ______
 * video stream in ---> | video box | ---> watermarked video out ---> | TV |
 *                       -----------                                  ------
 *
 * Their product works great on tiny 320 x 240 screens that run at 30 frames per second, but
 * because it's implemented right now with a microcontroller, it's too slow to handle higher
 * resolution screens, which need to process way more pixels per second.
 *
 * You've been brought in as a consultant to re-implement timing critical logic in a
 * super-fast combinational circuit.
 *
 * Their system will hand you a pixel read from the input video stream, tell you what the x and y
 * positions are, then your bit of hardware needs to either pass that same pixel out or replace it
 * with a corresponding pixel of their logo (also passed in to you).
 */

module video_watermark_engine();
    ////////////////////////////////////////////////////////////////
    // Circuit
    // inputs

    // (x_position, y_position) is the place on the screen where the currently drawn pixel will be.
    // If it's inside the box where the logo should be, instead of sending the video_pixel through,
    // you should send the logo_pixel through.
    reg [12:0] x_position;
    reg [12:0] y_position;

    // Pixel from the incoming video stream destined for location (x_position, y_position)
    reg  [7:0] video_pixel;

    // Pixel from the user-supplied logo that should be drawn at location (x_position, y_position),
    // if it's in the user-specified box.
    reg  [7:0] logo_pixel;

    // If this bit is 1, that part of the logo should be transparent, and the video_pixel should be
    // passed in anyways whether or not it goes to a place inside the logo box.
    reg        is_logo_transparent;

    // These describe the position and size of the logo box.
    reg [12:0] logo_top_corner;
    reg [12:0] logo_left_corner;
    reg [12:0] logo_width;
    reg [12:0] logo_height;

    // output. You've gotta drive this with an always @* block
    reg [7:0] pixel_out;

    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------

    ////////////////////////////////////////////////////////////////
    // Testbench
    initial begin
        $dumpfile("video_watermark_engine.vcd");
        $dumpvars(0, video_watermark_engine);

        // write us some test code!
        //----------------------------------------------------------------
        // your code here
        //----------------------------------------------------------------

        $finish;
    end
    // In addition to writing your own testbench, I've put together a fun little bit of code that
    // will use your hardware engine to actually overlay a watermark on an image!
    //
    // Uncomment this stuff when you want to try running it on a whole image! When you uncomment
    // this block, you should comment the above code. Having 2 'initial' blocks providing stimulus
    // at the same time can cause unexpected errors.
    //
    // Once your hardware module works, try creatively messing it up to draw different things over
    // the input image.
/*
`define IMAGE_WIDTH 320
`define IMAGE_HEIGHT 240
    integer file_handle;
    integer pix_index;
    reg [7:0] image_in [0:(`IMAGE_WIDTH * `IMAGE_HEIGHT) - 1];
    reg [7:0] logo_in [0:(`IMAGE_WIDTH * `IMAGE_HEIGHT) - 1];
    reg       logo_transparent [0:(`IMAGE_WIDTH * `IMAGE_HEIGHT) - 1];
    reg [7:0] image_out [0:(`IMAGE_WIDTH * `IMAGE_HEIGHT) - 1];
    initial begin
        $dumpfile("video_watermark_engine.vcd");
        $dumpvars(0, video_watermark_engine);

        $readmemh("image_resources/image_in.hex", image_in);
        $readmemh("image_resources/logo_in.hex", logo_in);
        $readmemh("image_resources/logo_transparency.hex", logo_transparent);

        logo_top_corner = 'd207;
        logo_left_corner = 'd231;
        logo_height = (`IMAGE_HEIGHT - logo_top_corner);
        logo_width = (`IMAGE_WIDTH - logo_left_corner);

        pix_index = 0;
        for (y_position = 0; y_position < `IMAGE_HEIGHT; y_position = y_position + 'h1) begin
            for (x_position = 0; x_position < `IMAGE_WIDTH; x_position = x_position + 'h1) begin
                video_pixel = image_in[pix_index];
                logo_pixel = logo_in[pix_index];
                is_logo_transparent = logo_transparent[pix_index];
                #1;
                image_out[pix_index] = pixel_out;
                pix_index = pix_index + 1;
                #9;
            end
        end

        // write to PGM image file
        file_handle = $fopen("output.pgm", "w");
        $fwrite(file_handle, "P2\n320 240\n255\n");
        pix_index = 0;
        for (y_position = 0; y_position < `IMAGE_HEIGHT; y_position = y_position + 'h1) begin
            for (x_position = 0; x_position < `IMAGE_WIDTH; x_position = x_position + 'h1) begin
                if (^image_out[pix_index] === 1'bx) begin
                    // We enter this 'if' statement if any of the bits in pixel_out were undefined.
                    $fwrite(file_handle, "  0 ");
                end else begin
                    $fwrite(file_handle, "%d ", image_out[pix_index]);
                end
                pix_index = pix_index + 1;
            end
            $fwrite(file_handle, "\n");
        end

        $fclose(file_handle);

        $display("Open the image file 'output.pgm'");
        $finish;
    end
*/
endmodule
