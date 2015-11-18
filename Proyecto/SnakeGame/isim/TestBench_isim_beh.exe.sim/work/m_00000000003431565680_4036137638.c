/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/guengo/Desktop/Proyecto/src/Colores.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {3840U, 0U};
static unsigned int ng4[] = {2U, 0U};
static unsigned int ng5[] = {255U, 0U};
static unsigned int ng6[] = {3U, 0U};
static unsigned int ng7[] = {3855U, 0U};
static unsigned int ng8[] = {4U, 0U};
static unsigned int ng9[] = {15U, 0U};
static unsigned int ng10[] = {5U, 0U};
static unsigned int ng11[] = {240U, 0U};



static void Always_14_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    int t28;
    char *t29;
    char *t30;

LAB0:    t1 = (t0 + 1708U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(14, ng0);
    t2 = (t0 + 1888);
    *((int *)t2) = 1;
    t3 = (t0 + 1732);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(15, ng0);

LAB5:    xsi_set_current_line(16, ng0);
    t5 = (t0 + 692U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t5) == 0)
        goto LAB6;

LAB8:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(19, ng0);

LAB13:    xsi_set_current_line(20, ng0);
    t2 = (t0 + 968U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t7 = *((unsigned int *)t3);
    t8 = *((unsigned int *)t2);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t6);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t6);
    t18 = (t16 | t17);
    t21 = (~(t18));
    t22 = (t15 & t21);
    if (t22 != 0)
        goto LAB15;

LAB14:    if (t18 != 0)
        goto LAB16;

LAB17:    t13 = (t4 + 4);
    t23 = *((unsigned int *)t13);
    t24 = (~(t23));
    t25 = *((unsigned int *)t4);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB18;

LAB19:
LAB20:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 876U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng6)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t7 = *((unsigned int *)t3);
    t8 = *((unsigned int *)t2);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t6);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t6);
    t18 = (t16 | t17);
    t21 = (~(t18));
    t22 = (t15 & t21);
    if (t22 != 0)
        goto LAB37;

LAB34:    if (t18 != 0)
        goto LAB36;

LAB35:    *((unsigned int *)t4) = 1;

LAB37:    t13 = (t4 + 4);
    t23 = *((unsigned int *)t13);
    t24 = (~(t23));
    t25 = *((unsigned int *)t4);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB38;

LAB39:
LAB40:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 784U);
    t3 = *((char **)t2);

LAB41:    t2 = ((char*)((ng1)));
    t28 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t28 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng2)));
    t28 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t28 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng4)));
    t28 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t28 == 1)
        goto LAB46;

LAB47:
LAB48:
LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(17, ng0);
    t19 = ((char*)((ng1)));
    t20 = (t0 + 1196);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 12);
    goto LAB12;

LAB15:    *((unsigned int *)t4) = 1;
    goto LAB17;

LAB16:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB17;

LAB18:    xsi_set_current_line(21, ng0);

LAB21:    xsi_set_current_line(22, ng0);
    t19 = (t0 + 968U);
    t20 = *((char **)t19);

LAB22:    t19 = ((char*)((ng2)));
    t28 = xsi_vlog_unsigned_case_compare(t20, 3, t19, 3);
    if (t28 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng4)));
    t28 = xsi_vlog_unsigned_case_compare(t20, 3, t2, 3);
    if (t28 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng6)));
    t28 = xsi_vlog_unsigned_case_compare(t20, 3, t2, 3);
    if (t28 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng8)));
    t28 = xsi_vlog_unsigned_case_compare(t20, 3, t2, 3);
    if (t28 == 1)
        goto LAB29;

LAB30:    t2 = ((char*)((ng10)));
    t28 = xsi_vlog_unsigned_case_compare(t20, 3, t2, 3);
    if (t28 == 1)
        goto LAB31;

LAB32:
LAB33:    goto LAB20;

LAB23:    xsi_set_current_line(23, ng0);
    t29 = ((char*)((ng3)));
    t30 = (t0 + 1196);
    xsi_vlogvar_assign_value(t30, t29, 0, 0, 12);
    goto LAB33;

LAB25:    xsi_set_current_line(24, ng0);
    t3 = ((char*)((ng5)));
    t5 = (t0 + 1196);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 12);
    goto LAB33;

LAB27:    xsi_set_current_line(25, ng0);
    t3 = ((char*)((ng7)));
    t5 = (t0 + 1196);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 12);
    goto LAB33;

LAB29:    xsi_set_current_line(26, ng0);
    t3 = ((char*)((ng9)));
    t5 = (t0 + 1196);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 12);
    goto LAB33;

LAB31:    xsi_set_current_line(27, ng0);
    t3 = ((char*)((ng11)));
    t5 = (t0 + 1196);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 12);
    goto LAB33;

LAB36:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB37;

LAB38:    xsi_set_current_line(31, ng0);
    t19 = ((char*)((ng11)));
    t29 = (t0 + 1196);
    xsi_vlogvar_assign_value(t29, t19, 0, 0, 12);
    goto LAB40;

LAB42:    xsi_set_current_line(33, ng0);
    t5 = ((char*)((ng1)));
    t6 = (t0 + 1196);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 12);
    goto LAB48;

LAB44:    xsi_set_current_line(34, ng0);
    t5 = ((char*)((ng11)));
    t6 = (t0 + 1196);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 12);
    goto LAB48;

LAB46:    xsi_set_current_line(35, ng0);
    t5 = ((char*)((ng9)));
    t6 = (t0 + 1196);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 12);
    goto LAB48;

}


extern void work_m_00000000003431565680_4036137638_init()
{
	static char *pe[] = {(void *)Always_14_0};
	xsi_register_didat("work_m_00000000003431565680_4036137638", "isim/TestBench_isim_beh.exe.sim/work/m_00000000003431565680_4036137638.didat");
	xsi_register_executes(pe);
}
