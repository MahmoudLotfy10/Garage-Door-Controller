`timescale 1ns/1ps
module garage_tb ();
   reg  clk_tb,rst_tb;
   reg  activate_tb;
   reg  up_max_tb,dn_max_tb;
   wire up_m_tb,dn_m_tb;

   garage dut
   (.clk(clk_tb),
    .rst(rst_tb),
    .activate(activate_tb),
    .up_max(up_max_tb),
    .dn_max(dn_max_tb),
    .up_m(up_m_tb),
    .dn_m(dn_m_tb)
   );

   always #10 clk_tb=~clk_tb;

   initial begin
    $dumpfile("garage.vcd");
    $dumpvars;
    initialization();
    RST();
    // activate , up_max , dn_max
    takeinputs(0,0);
    @(negedge clk_tb)
    check();

    takeinputs(1,0);
    @(negedge clk_tb)
    check();

    takeinputs(0,1);
    @(negedge clk_tb)
    check();

    takeinputs(1,1);
    @(negedge clk_tb)
    check();
    $display("*******************************************************************************");
    $display("***---now will activate--- & want open the door*****");
    takeinputs(0,1);
    press_activate();
    
    $display("*******************************************************************************");
    $display("***---now will activate--- & want close the door*****");
    //when up_max=1  should go to idle .
    takeinputs(1,1);
    takeinputs(1,0);
    press_activate;
    takeinputs(1,1);

    #100
    $stop;
   end

   task initialization;
   begin
    clk_tb=0;
    activate_tb=0;
    up_max_tb=0;
    dn_max_tb=1;

   end

   endtask

   task RST;
    begin
        rst_tb=1;
        #1
        rst_tb=0;
        #1
        rst_tb=1;
    end
   endtask

   task takeinputs;
   input up_max_t;
   input dn_max_t;
   begin
    @(negedge clk_tb)
    begin
        up_max_tb=up_max_t;
        dn_max_tb=dn_max_t;
    end
   end
   endtask

   task press_activate;
   begin
    activate_tb=1;
    @(negedge clk_tb)
    check(); //check after activate
    #40
    activate_tb=0;
   end
   endtask

   task check;
    begin
        if(!activate_tb && !dn_max_tb && !up_max_tb)
        begin
               $display("*************************************Test case 1****************************************");
            if(up_m_tb==0 && dn_m_tb==0)
            begin
                $display("test case 1 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
            end
            else
               $display("test case 1 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);

        end
        else if(!activate_tb && !dn_max_tb && up_max_tb)
        begin
               $display("*************************************Test case 2****************************************");
            if(up_m_tb==0 && dn_m_tb==0)
            begin
                $display("test case 2 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
            end
            else
               $display("test case 2 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);

        end

        else if(!activate_tb && dn_max_tb && !up_max_tb)
        begin
               $display("*************************************Test case 3****************************************");
            if(up_m_tb==0 && dn_m_tb==0)
            begin
                $display("test case 3 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
            end
            else
               $display("test case 3 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);

        end

        else if(!activate_tb && dn_max_tb && up_max_tb)
        begin
               $display("*************************************Test case 4****************************************");
            if(up_m_tb==0 && dn_m_tb==0)
            begin
                $display("test case 4 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
            end
            else
               $display("test case 4 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);

        end
        else if(activate_tb && dn_max_tb && !up_max_tb)
        begin
               $display("*************************************Test case 5****************************************");
            if(up_m_tb==1 && dn_m_tb==0)
            begin
                $display("test case 5 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
                $display("the door open completely");
            end
            else begin
               $display("test case 5 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
               $display("the door not open ");
            end
        end
        else if(activate_tb && !dn_max_tb && up_max_tb)
        begin
               $display("*************************************Test case 6****************************************");
            if(up_m_tb==0 && dn_m_tb==1)
            begin
                $display("test case 6 passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
                $display("the door closed completely");
                $display("*******************************************************************************");

            end
            else begin
               $display("test case 6 not passed when activate =%d & up_max=%d & dn_max=%d the up_m=%d & dn_m=%d",activate_tb,up_max_tb,dn_max_tb,up_m_tb,dn_m_tb);
               $display("the door not closed ");
               $display("*******************************************************************************");

            end
        end
        
    end
   endtask
endmodule