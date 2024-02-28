module garage (
    input      clk,rst,
    input      activate,
    input      up_max,
    input      dn_max,
    output reg up_m,
    output reg dn_m
);
    localparam [1:0] idle  = 2'b00,
                     mv_up = 2'b01,
                     mv_dn = 2'b11;
    
    reg [1:0] cur_state,next_state;

    always @(posedge clk , negedge rst ) begin
        if(!rst)
        begin
            cur_state<= idle;
        end
        else
        begin
            cur_state<=next_state;
        end
    end

    always @(*) begin
        // to avoid unintentional latch
        up_m=0;
        dn_m=0;
        next_state=idle;
        case (cur_state)
            idle: begin
                up_m=0;
                dn_m=0;
                if(activate && dn_max && !up_max)
                  next_state=mv_up;
                else if(activate && !dn_max && up_max)
                  next_state=mv_dn;
                else 
                  next_state=idle;
            end     
            mv_up: begin
                up_m=1;
                dn_m=0;
                if(up_max)
                next_state=idle;
                else
                next_state=mv_up;
            end
            mv_dn: begin
                up_m=0;
                dn_m=1;
                if(dn_max)
                next_state=idle;
                else
                next_state=mv_dn;
            end
            default: begin
                up_m=0;
                dn_m=0;
                next_state=idle;
            end
        endcase
    end
endmodule