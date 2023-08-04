Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9276FAF7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Aug 2023 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjHDHSj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Aug 2023 03:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHDHSi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Aug 2023 03:18:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2A3A80;
        Fri,  4 Aug 2023 00:18:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d0548cf861aso1967291276.3;
        Fri, 04 Aug 2023 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691133515; x=1691738315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02up3Yo6j1Q4K5Yrk3QK9n9ib7sHk5QDheuayqs3lHc=;
        b=OueMf2EWt60r58sF6mQcP5jb3MigIip523LZAVlQTW6shSp3PmMMF+rXKUDpQGqZre
         gxmWuC+oufqZA+Cunu3kqeMi3oczcFkU+DXbWuMeqEgTxEVjJUrmXFYHpmOwv81Cbd4e
         Um2W+XXdWzZMB+hN39+W0IUvTYe8zMQpEshpLP6vce9Ks/U/yyAN7tkLGTSyYz/PQc9V
         +ieJN7FH9GclciRJ9j1UIKC02PgPV0CUiKrezTeDsuV39pUsozpEiCKgcO63sWTWKkB3
         WTIfn+LPSYXUva6NuozEfmmd2UqdDOLTIZ9LcnZ/WPvnBfnwZCQJR+32+7Kw7KjT1j6S
         qRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691133515; x=1691738315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02up3Yo6j1Q4K5Yrk3QK9n9ib7sHk5QDheuayqs3lHc=;
        b=E1Igt4LFwb0jQPStD6PsBrg4wAHcdjHIbmzViB4LVGqO506SWnbTmukRy8BSrto1KU
         yGFGh/trouOyh531riTOhuBJ/GABihsUvhmTv7+no9JU7h/nr5EBXtDvCJSudkEQTyQi
         gOO0jb/z5cTrCZuZGoODIfBmW78ofkB0x3G5NnaQXMeLN8/SYrO1MTamp9ag4On2e5Nt
         eafY1ycVZSlTJXHS1F5sxVImwIpd4Kns3/i1zFOt9s0vQ1fgcYVy/PlG2YaKOUONERO5
         LFuTXDH4+iL5OHkZ82lLHwwRXZYkBBCffSh3g6hnXrGBUuRLrcwr/QJHxQtN3dSsq43J
         ePbA==
X-Gm-Message-State: AOJu0Yz/N6PKbYgpZg8rDVd00Yk1Uk5ccF5UQjugkz4M9mmzLFKHlewS
        0iioS/Oaztrex7a7m8sgEh0Acy1KPiLE43byMw==
X-Google-Smtp-Source: AGHT+IHEeMbtECjaoVdN3WktOHLJDIBggLU2H6ytqt6vG65qg9funkEzRmZPaDqqPP7/ZUOBeBmbjhnNP/LgDeVEKwk=
X-Received: by 2002:a0d:cd82:0:b0:575:4b1c:e5f0 with SMTP id
 p124-20020a0dcd82000000b005754b1ce5f0mr830629ywd.32.1691133515215; Fri, 04
 Aug 2023 00:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230627082334.1253020-1-privatesub2@gmail.com>
 <20230627082334.1253020-3-privatesub2@gmail.com> <20230710091413.fdl7j6eb3ln7uj4g@pengutronix.de>
In-Reply-To: <20230710091413.fdl7j6eb3ln7uj4g@pengutronix.de>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= 
        <privatesub2@gmail.com>
Date:   Fri, 4 Aug 2023 10:19:26 +0300
Message-ID: <CAF4idNmUn3G0=MU+PxTMNVb7u0xmQX4i5Z3zO6azUDBb1BezfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,
thanks for having a look!
Sorry for replying so late.

=D0=BF=D0=BD, 10 =D0=B8=D1=8E=D0=BB. 2023=E2=80=AF=D0=B3. =D0=B2 12:14, Uwe=
 Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>
> Hello,
>
> On Tue, Jun 27, 2023 at 11:23:25AM +0300, Aleksandr Shubin wrote:
> > Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> > controllers with ones supported by pwm-sun4i driver.
> >
> > This patch adds a PWM controller driver for Allwinner's D1,
> > T113-S3 and R329 SoCs. The main difference between these SoCs
> > is the number of channels defined by the DT property.
> >
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sun20i.c | 322 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 333 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sun20i.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 8df861b1f4a3..05c48a36969e 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -594,6 +594,16 @@ config PWM_SUN4I
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sun4i.
> >
> > +config PWM_SUN20I
> > +     tristate "Allwinner D1/T113s/R329 PWM support"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on COMMON_CLK
> > +     help
> > +       Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sun20i.
> > +
> >  config PWM_SUNPLUS
> >       tristate "Sunplus PWM support"
> >       depends on ARCH_SUNPLUS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 19899b912e00..cea872e22c78 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUN20I)     +=3D pwm-sun20i.o
> >  obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> > diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> > new file mode 100644
> > index 000000000000..63e9c64e0e18
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sun20i.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> > + *
> > + * Limitations:
> > + * - When the parameters change, current running period will not be co=
mpleted
> > + *   and run new settings immediately.
> > + * - It output HIGH-Z state when PWM channel disabled.
> > + *
> > + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +
> > +#define PWM_CLK_CFG_REG(chan)                (0x20 + (((chan) >> 1) * =
0x4))
> > +#define PWM_CLK_SRC                  GENMASK(8, 7)
> > +#define PWM_CLK_DIV_M                        GENMASK(3, 0)
> > +
> > +#define PWM_CLK_GATE_REG             0x40
> > +#define PWM_CLK_BYPASS(chan)         BIT((chan) - 16)
> > +#define PWM_CLK_GATING(chan)         BIT(chan)
> > +
> > +#define PWM_ENABLE_REG                       0x80
> > +#define PWM_EN(chan)                 BIT(chan)
> > +
> > +#define PWM_CTL_REG(chan)            (0x100 + (chan) * 0x20)
> > +#define PWM_ACT_STA                  BIT(8)
> > +#define PWM_PRESCAL_K                        GENMASK(7, 0)
> > +
> > +#define PWM_PERIOD_REG(chan)         (0x104 + (chan) * 0x20)
> > +#define PWM_ENTIRE_CYCLE             GENMASK(31, 16)
> > +#define PWM_ACT_CYCLE                        GENMASK(15, 0)
>
> Can you please adapt the register field names to include the register
> name? I'd use:
>
> #define PWM_CTL(chan)           (0x100 + (chan) * 0x20)
> #define PWM_CTL_ACT_STA                 BIT(8)
> #define PWM_CTL_PRESCAL_K               GENMASK(7, 0)
>
> then you get a chance to spot when PWM_CLK_BYPASS(x) is written to
> PWM_CLK_CFG.
>
>
> > +struct sun20i_pwm_chip {
> > +     struct pwm_chip chip;
> > +     struct clk *clk_bus, *clk_hosc;
> > +     struct reset_control *rst;
> > +     void __iomem *base;
> > +     /* Mutex to protect pwm apply state */
> > +     struct mutex mutex;
> > +};
> > +
> > +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_ch=
ip *chip)
> > +{
> > +     return container_of(chip, struct sun20i_pwm_chip, chip);
> > +}
> > +
> > +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> > +                                unsigned long offset)
> > +{
> > +     return readl(chip->base + offset);
> > +}
> > +
> > +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> > +                                  u32 val, unsigned long offset)
> > +{
> > +     writel(val, chip->base + offset);
> > +}
> > +
> > +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> > +                             struct pwm_device *pwm,
> > +                             struct pwm_state *state)
> > +{
> > +     struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > +     u64 clk_rate, tmp;
> > +     u32 val;
> > +     u16 ent_cycle, act_cycle;
> > +     u8 prescal, div_id;
> > +
> > +     mutex_lock(&sun20i_chip->mutex);
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG(pwm->hwpwm)=
);
> > +     div_id =3D FIELD_GET(PWM_CLK_DIV_M, val);
> > +     if (FIELD_GET(PWM_CLK_SRC, val) =3D=3D 0)
> > +             clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> > +     else
> > +             clk_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hwpwm));
> > +     state->polarity =3D (PWM_ACT_STA & val) ? PWM_POLARITY_NORMAL : P=
WM_POLARITY_INVERSED;
> > +
> > +     prescal =3D FIELD_GET(PWM_PRESCAL_K, val) + 1;
>
> If PWM_PRESCAL_K is 0xff, prescal ends up being 0. This isn't right, is
> it?
>
> > +     val =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> > +     state->enabled =3D (PWM_EN(pwm->hwpwm) & val) ? true : false;
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, PWM_PERIOD_REG(pwm->hwpwm))=
;
> > +     act_cycle =3D FIELD_GET(PWM_ACT_CYCLE, val);
> > +     ent_cycle =3D FIELD_GET(PWM_ENTIRE_CYCLE, val);
> > +     if (act_cycle > ent_cycle)
> > +             act_cycle =3D ent_cycle;
> > +
>
> A comment that with the width of the used factors this cannot overflow
> would be nice here.
>
> > +     tmp =3D (u64)(act_cycle) * prescal * (1U << div_id) * NSEC_PER_SE=
C;
>
> Can be simplified to:
>
>         tmp =3D (u64)act_cycle * prescal << div_id * NSEC_PER_SEC;
>
> > +     state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> > +     tmp =3D (u64)(ent_cycle) * prescal * (1U << div_id) * NSEC_PER_SE=
C;
> > +     state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> > +     mutex_unlock(&sun20i_chip->mutex);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     int ret =3D 0;
> > +     u32 clk_gate, clk_cfg, pwm_en, ctl, period;
> > +     u64 bus_rate, hosc_rate, clk_div, val;
> > +     u16 prescaler, div_m;
> > +     bool use_bus_clk, calc_div_m;
> > +     struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > +
> > +     mutex_lock(&sun20i_chip->mutex);
> > +
> > +     pwm_en =3D sun20i_pwm_readl(sun20i_chip, PWM_ENABLE_REG);
> > +
> > +     if (state->enabled !=3D pwm->state.enabled)
> > +             clk_gate =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE_R=
EG);
> > +
> > +     if (state->enabled !=3D pwm->state.enabled && !state->enabled) {
> > +             clk_gate &=3D ~PWM_CLK_GATING(pwm->hwpwm);
> > +             pwm_en &=3D ~PWM_EN(pwm->hwpwm);
> > +             sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
> > +             sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG=
);
> > +     }
> > +
> > +     if (state->polarity !=3D pwm->state.polarity ||
> > +         state->duty_cycle !=3D pwm->state.duty_cycle ||
> > +         state->period !=3D pwm->state.period) {
> > +             ctl =3D sun20i_pwm_readl(sun20i_chip, PWM_CTL_REG(pwm->hw=
pwm));
> > +             clk_cfg =3D sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG_REG=
(pwm->hwpwm));
> > +             hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> > +             bus_rate =3D clk_get_rate(sun20i_chip->clk_bus);
> > +             if (pwm_en & PWM_EN(pwm->hwpwm ^ 1)) {
> > +                     /* if the neighbor channel is enable, check perio=
d only */
> > +                     use_bus_clk =3D FIELD_GET(PWM_CLK_SRC, clk_cfg) !=
=3D 0;
> > +                     if (use_bus_clk)
> > +                             val =3D state->period * bus_rate;
> > +                     else
> > +                             val =3D state->period * hosc_rate;
> > +                     do_div(val, NSEC_PER_SEC);
> > +
> > +                     div_m =3D FIELD_GET(PWM_CLK_DIV_M, clk_cfg);
> > +                     calc_div_m =3D false;
> > +             } else {
> > +                     /* check period and select clock source */
> > +                     use_bus_clk =3D false;
> > +                     val =3D state->period * hosc_rate;
> > +                     do_div(val, NSEC_PER_SEC);
> > +                     if (val <=3D 1) {
> > +                             use_bus_clk =3D true;
> > +                             val =3D state->period * bus_rate;
> > +                             do_div(val, NSEC_PER_SEC);
> > +                             if (val <=3D 1) {
> > +                                     ret =3D -EINVAL;
> > +                                     goto unlock_mutex;
> > +                             }
> > +                     }
> > +                     div_m =3D 0;
> > +                     calc_div_m =3D true;
> > +
> > +                     /* set up the CLK_DIV_M and clock CLK_SRC */
> > +                     clk_cfg =3D FIELD_PREP(PWM_CLK_DIV_M, div_m);
> > +                     clk_cfg |=3D FIELD_PREP(PWM_CLK_SRC, use_bus_clk =
? 1 : 0);
> > +
> > +                     sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_C=
FG_REG(pwm->hwpwm));
> > +             }
> > +
> > +             /* calculate prescaler, M factor, PWM entire cycle */
> > +             clk_div =3D val;
>
> This assignment is useless as it is overwritten in the loop below, isn't
> it?
>
> > +             for (prescaler =3D 0;; prescaler++) {
> > +                     if (prescaler >=3D 256) {
> > +                             if (calc_div_m) {
> > +                                     prescaler =3D 0;
> > +                                     div_m++;
> > +                                     if (div_m >=3D 9) {
> > +                                             ret =3D -EINVAL;
> > +                                             goto unlock_mutex;
> > +                                     }
> > +                             } else {
> > +                                     ret =3D -EINVAL;
> > +                                     goto unlock_mutex;
> > +                             }
> > +                     }
> > +
> > +                     clk_div =3D val >> div_m;
> > +                     do_div(clk_div, prescaler + 1);
> > +                     if (clk_div <=3D 65534)
> > +                             break;
>
> This can be calculated without a loop.

Point me please where can I see the calculation of two divisors without a l=
oop?
>
> > +             }
> > +
> > +             period =3D FIELD_PREP(PWM_ENTIRE_CYCLE, clk_div);
> > +
> > +             /* set duty cycle */
> > +             if (use_bus_clk)
> > +                     val =3D state->duty_cycle * bus_rate;
> > +             else
> > +                     val =3D state->duty_cycle * hosc_rate;
> > +             do_div(val, NSEC_PER_SEC);
> > +             clk_div =3D val >> div_m;
> > +             do_div(clk_div, prescaler + 1);
> > +
> > +             if (state->duty_cycle =3D=3D state->period)
> > +                     clk_div++;
>
> I don't understand that one. Can you explain that in a comment please?

The formula of the output period and the duty-cycle for PWM are as follows.
T period =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * (PPR0.PWM_ENTIRE_CYCLE + 1)
T high-level =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * PPR0.PWM_ACT_CYCLE
Duty-cycle =3D T high-level / T period
In accordance with this formula, in order to set the duty-cycle to 100%,
it is necessary that PWM_ACT_CYCLE >=3D PWM_ENTIRE_CYCLE + 1
>
> > +             period |=3D FIELD_PREP(PWM_ACT_CYCLE, clk_div);
> > +             sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD_REG(pwm=
->hwpwm));
> > +
> > +             ctl =3D FIELD_PREP(PWM_PRESCAL_K, prescaler);
> > +             if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> > +                     ctl |=3D PWM_ACT_STA;
> > +
> > +             sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL_REG(pwm->hwpw=
m));
>
> Is this racy? I.e. does the write to PWM_PERIOD_REG(pwm->hwpwm) above
> already has an effect before PWM_CTL_REG(pwm->hwpwm) is written?
>
> > +     }
> > +
> > +     if (state->enabled !=3D pwm->state.enabled && state->enabled) {
> > +             clk_gate &=3D ~PWM_CLK_BYPASS(pwm->hwpwm);
> > +             clk_gate |=3D PWM_CLK_GATING(pwm->hwpwm);
> > +             pwm_en |=3D PWM_EN(pwm->hwpwm);
> > +             sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE_REG);
> > +             sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE_REG=
);
>
> This is (I guess) racy. If your PWM is running with
>
>         .period =3D 10000
>         .duty_cyle =3D 0
>         .enabled =3D true
>
> and you configure it to
>
>         .period =3D 10000
>         .duty_cyle =3D 10000
>         .enabled =3D false
>
> you get a short spike. For a enabled=3Dtrue -> enabled=3Dfalse transition
> you should disable first before configuring duty+period (or skip the
> latter completely).

When switching enabled=3Dtrue -> enabled=3Dfalse then before setting the pe=
riod,
the enable register will be written false and the pvm will become inactive.
this is the place:
if (state->enabled !=3D pwm->state.enabled && !state->enabled) {
>
> > +     }
> > +
> > +unlock_mutex:
> > +     mutex_unlock(&sun20i_chip->mutex);
> > +
> > +     return ret;
> > +}
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Cheers,
Aleksandr
