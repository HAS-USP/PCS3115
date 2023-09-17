module grayenc (input [3:0] Nbin, output [3:0] Ngray);

assign Ngray[0] = (Nbin[1] == 1'b1) ? 1'b1 : 1'b0;
assign Ngray[1] = ((~Nbin[1] & Nbin[2]) | (Nbin[1] & Nbin[0] & ~Nbin[2]) | (Nbin[2] & ~Nbin[0])) ? 1'b1 : 1'b0;
assign Ngray[2] = ((Nbin[3] & ~Nbin[1] & ~Nbin[0]) | (~Nbin[3] & Nbin[2] & Nbin[0]) | (~Nbin[3] & Nbin[2] & Nbin[1]) | (Nbin[3] & ~Nbin[2])) ? 1'b1 : 1'b0;
assign Ngray[3] = ((~Nbin[3] & ~Nbin[2] & ~Nbin[1] & ~Nbin[0]) | (Nbin[3] & Nbin[0]) | (Nbin[3] & Nbin[1]) | (Nbin[3] | Nbin[2])) ? 1'b1 : 1'b0;


endmodule

