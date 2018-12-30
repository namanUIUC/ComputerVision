function K = caliberation(processed)

    vpx = processed(1,:);
    vpy = processed(2,:);
    vpz = processed(3,:);

    syms u v;
    coeff_u1 = vpy(1)+vpz(1)-vpx(1)-vpy(1);
    coeff_v1 = vpy(2)+vpz(2)-vpx(2)-vpy(2);
    constant1 = vpx(1)*vpy(1)  + vpx(2)*vpy(2) - vpy(1)*vpz(1) - vpy(2)*vpz(2);
    coeff_u2 = vpy(1)+vpz(1)-vpz(1)-vpx(1);
    coeff_v2 = vpy(2)+vpz(2)-vpz(2)-vpx(2);
    constant2 = vpz(1)*vpx(1) + vpz(2)*vpx(2) - vpy(1)*vpz(1) - vpy(2)*vpz(2);
    
    S1 = solve(u*coeff_u1 + v*coeff_v1 + constant1 == 0 ,u*coeff_u2 + v*coeff_v2 + constant2 == 0);
    
    syms f;
    solved_f = solve((S1.u - vpx(1))*(S1.u - vpy(1)) + (S1.v - vpx(2))*(S1.v - vpy(2)) + f*f == 0);
    
    f = double(solved_f);
    f = f(1);
    
    K = [f, 0, double(S1.u); 0, f, double(S1.v); 0, 0, 1];
end