Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9376A8CEB3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfHNImm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 04:42:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39714 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHNImm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 04:42:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so12414784otp.6
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IkI4Dc5yQ3wMtfrwJtwttJTxS0gEeDbLMUrxq5X1+e8=;
        b=ZBK8+ICYbCdVr/8Xh2o/iUG7FzQm8PJD6Se6/x1ANN7H+8W2ryeWPTJfLrO32GGJvD
         00xGUg6LVpngD1YUU//mU3sznLSwID61lnd/aaeQIrsYz8P6Wzc/aJVrj4qUMXAVJ5sm
         NGVJHe8sYwrpKEK68hXZnQkdbv23j7CEyo5z7dkGgn4dFJIzNsEc6iCezPFH9+/luF/H
         5V3vocPENmVqNmEiX2PZ25hPwIwB6mnKyE5n7vJ8rH2JeeEAzZ/+cZBx0zjUfRLS0OCZ
         6l1zuJyRq+JbHiUYaw8YPaROjQd7YG/0HLTwVqpDkOs2PDoYeBR4iL8eXMCiz+WD3z8X
         cETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IkI4Dc5yQ3wMtfrwJtwttJTxS0gEeDbLMUrxq5X1+e8=;
        b=nYsigDsCoTvzruFFpVpJBTauk8sI+Rk1WnHZjo2ousP+iM4Z0mt32DbSHhqI3g3mT5
         GV20eIMMOSpGFCZPM5SvpwFhF+/7U0kjRuCmmN065IVtjNPLdSvg23QXGrKbFKM/Xjgq
         qqtphT16MsqTEt8Mz4m8Ag6AsehxtkmFVMU6yavxDtOfivFmiwKq5JbnwgZvV/aCH+Dh
         rdEFGcMoSaUQRUtMIFunqOldoLHMJHBGFef8oQS/+Db3hUNBGDL5D3zGFqx8FVZLQL5B
         w59m8XcHbmrL0Rsc1UJeS83AuBl9LK+I7EUeMf1GXE50sCGg/vyVeBXJJnXyrB2yT0ih
         Pw6g==
X-Gm-Message-State: APjAAAUz96UTA6q/17Bd7RSd/DpdSL8OKrFkBN0bjX6FiQ03Uo+0lcNz
        Cgel0GIk4JahzcPgFdPDkbLjtZRXa7zOJMlnOz1k4Q==
X-Google-Smtp-Source: APXvYqwXYNXOn3LbXXojCjgXsGBl8vKmjJP78VGOFu78tJJl8B5R/IL1jk2L/oq+Ji2Lt41IQVbBl+Z9+PFU7PSWRfI=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr25804763otk.145.1565772160874;
 Wed, 14 Aug 2019 01:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
In-Reply-To: <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 16:42:28 +0800
Message-ID: <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > This patch adds the Spreadtrum PWM support, which provides maximum 4
> > channels.
> >
> > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Add depending on HAS_IOMEM.
> >  - Rename parameters' names.
> >  - Implement .apply() instead of .config(), .enable() and .disable().
> >  - Use NSEC_PER_SEC instead of 1000000000ULL.
> >  - Add some comments to make code more readable.
> >  - Remove some redundant operation.
> >  - Use standard clock properties to set clock parent.
> >  - Other coding style optimization.
> > ---
> >  drivers/pwm/Kconfig    |   11 ++
> >  drivers/pwm/Makefile   |    1 +
> >  drivers/pwm/pwm-sprd.c |  307 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 319 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sprd.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a7e5751..31dfc88 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -423,6 +423,17 @@ config PWM_SPEAR
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-spear.
> >
> > +config PWM_SPRD
> > +     tristate "Spreadtrum PWM support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     depends on HAS_IOMEM
> > +     help
> > +       Generic PWM framework driver for the PWM controller on
> > +       Spreadtrum SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sprd.
> > +
> >  config PWM_STI
> >       tristate "STiH4xx PWM support"
> >       depends on ARCH_STI
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 76b555b..26326ad 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)  +=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> > +obj-$(CONFIG_PWM_SPRD)               +=3D pwm-sprd.o
> >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > new file mode 100644
> > index 0000000..067e711
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sprd.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Spreadtrum Communications Inc.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +
> > +#define SPRD_PWM_PRESCALE    0x0
> > +#define SPRD_PWM_MOD         0x4
> > +#define SPRD_PWM_DUTY                0x8
> > +#define SPRD_PWM_ENABLE              0x18
> > +
> > +#define SPRD_PWM_MOD_MAX     GENMASK(7, 0)
> > +#define SPRD_PWM_DUTY_MSK    GENMASK(15, 0)
> > +#define SPRD_PWM_PRESCALE_MSK        GENMASK(7, 0)
> > +#define SPRD_PWM_ENABLE_BIT  BIT(0)
> > +
> > +#define SPRD_PWM_NUM         4
> > +#define SPRD_PWM_REGS_SHIFT  5
> > +#define SPRD_PWM_NUM_CLKS    2
> > +#define SPRD_PWM_OUTPUT_CLK  1
>
> These definitions could benefit from some explaining comments. Just from
> looking at the names it is for example not obvious what is the
> difference between SPRD_PWM_NUM and SPRD_PWM_NUM_CLKS is.

Sure, I will optimize the macros' names to make them understandable.

>
> > +struct sprd_pwm_chn {
> > +     struct clk_bulk_data clks[SPRD_PWM_NUM_CLKS];
> > +     u32 clk_rate;
> > +};
> > +
> > +struct sprd_pwm_chip {
> > +     void __iomem *base;
> > +     struct device *dev;
> > +     struct pwm_chip chip;
> > +     int num_pwms;
> > +     struct sprd_pwm_chn chn[SPRD_PWM_NUM];
> > +};
> > +
> > +/*
> > + * The list of clocks required by PWM channels, and each channel has 2=
 clocks:
> > + * enable clock and pwm clock.
> > + */
> > +static const char * const sprd_pwm_clks[] =3D {
> > +     "enable0", "pwm0",
> > +     "enable1", "pwm1",
> > +     "enable2", "pwm2",
> > +     "enable3", "pwm3",
> > +};
> > +
> > +static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
> > +{
> > +     u32 offset =3D reg + (hwid << SPRD_PWM_REGS_SHIFT);
> > +
> > +     return readl_relaxed(spc->base + offset);
> > +}
> > +
> > +static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
> > +                        u32 reg, u32 val)
> > +{
> > +     u32 offset =3D reg + (hwid << SPRD_PWM_REGS_SHIFT);
> > +
> > +     writel_relaxed(val, spc->base + offset);
> > +}
> > +
> > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +                            struct pwm_state *state)
> > +{
> > +     struct sprd_pwm_chip *spc =3D
> > +             container_of(chip, struct sprd_pwm_chip, chip);
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     u32 val, duty, prescale;
> > +     u64 tmp;
> > +     int ret;
> > +
> > +     /*
> > +      * The clocks to PWM channel has to be enabled first before
> > +      * reading to the registers.
> > +      */
> > +     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> > +     if (ret) {
> > +             dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > +                     pwm->hwpwm);
> > +             return;
> > +     }
> > +
> > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
> > +     if (val & SPRD_PWM_ENABLE_BIT)
> > +             state->enabled =3D true;
> > +     else
> > +             state->enabled =3D false;
> > +
> > +     /*
> > +      * The hardware provides a counter that is feed by the source clo=
ck.
> > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > +      * Thus the period_ns and duty_ns calculation formula should be:
> > +      * period_ns =3D NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
> > +      * duty_ns =3D NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
> > +      */
> > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > +     prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > +     state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > +
> > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > +     duty =3D val & SPRD_PWM_DUTY_MSK;
> > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > +
> > +     /* Disable PWM clocks if the PWM channel is not in enable state. =
*/
> > +     if (!state->enabled)
> > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> > +}
> > +
> > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_devic=
e *pwm,
> > +                        int duty_ns, int period_ns)
> > +{
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     u64 div, tmp;
> > +     u32 prescale, duty;
> > +
> > +     /*
> > +      * The hardware provides a counter that is feed by the source clo=
ck.
> > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > +      *
> > +      * To keep the maths simple we're always using MOD =3D SPRD_PWM_M=
OD_MAX.
> > +      * The value for PRESCALE is selected such that the resulting per=
iod
> > +      * gets the maximal length not bigger than the requested one with=
 the
> > +      * given settings (MOD =3D SPRD_PWM_MOD_MAX and input clock).
> > +      */
> > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > +
> > +     tmp =3D (u64)chn->clk_rate * period_ns;
> > +     div =3D NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > +     prescale =3D div64_u64(tmp, div) - 1;
> > +     if (prescale > SPRD_PWM_PRESCALE_MSK)
> > +             prescale =3D SPRD_PWM_PRESCALE_MSK;
>
> This isn't the inverse of .get_state(). Consider:
>
>         clk_rate =3D 3333333
>         SPRD_PWM_PRESCALE =3D 15
>
> then you calculate in .get_state():
>
>         period =3D 1224000
>
> If you then call apply with this value you calulate:
>
>         prescale =3D 14

OK. I will optimize the logics to fix this issue in next version.

> > +
> > +     /*
> > +      * Note: The MOD must be configured before DUTY, and the hardware=
 can
> > +      * ensure current running period is completed before changing a n=
ew
> > +      * configuration to avoid mixed settings.
>
> You write "the hardware can ensure ..". Does that actually means "The
> hardware ensures that ..." or is there some additional condition? Maybe

Yes, will update the comments.

> you mean:
>
>         /*
>          * Writing DUTY triggers the hardware to actually apply the
>          * values written to MOD and DUTY to the output. So write DUTY
>          * last.
>          */

Not really, our hardware's method is, when you changed a new
configuration (MOD or duty is changed) , the hardware will wait for a
while to complete current period, then change to the new period.

>
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
>
> If writing DUTY triggers the hardware to sample DUTY and MOD, what about
> PRESCALE?

See above comments.

>
> > +     return 0;
> > +}
> > +
> > +static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> > +                       struct pwm_state *state)
> > +{
> > +     struct sprd_pwm_chip *spc =3D
> > +             container_of(chip, struct sprd_pwm_chip, chip);
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     struct pwm_state cstate;
> > +     int ret;
> > +
> > +     pwm_get_state(pwm, &cstate);
>
> I don't like it when pwm drivers call pwm_get_state(). If ever
> pwm_get_state would take a lock, this would deadlock as the lock is
> probably already taken when your .apply() callback is running. Moreover
> the (expensive) calculations are not used appropriately. See below.

I do not think so, see:

static inline void pwm_get_state(const struct pwm_device *pwm, struct
pwm_state *state)
{
        *state =3D pwm->state;
}

>
> > +     if (state->enabled) {
> > +             if (!cstate.enabled) {
>
> To just know the value of cstate.enabled you only need to read the
> register with the ENABLE flag. That is cheaper than calling get_state.
>
> > +                     /*
> > +                      * The clocks to PWM channel has to be enabled fi=
rst
> > +                      * before writing to the registers.
> > +                      */
> > +                     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS=
,
> > +                                                   chn->clks);
> > +                     if (ret) {
> > +                             dev_err(spc->dev,
> > +                                     "failed to enable pwm%u clocks\n"=
,
> > +                                     pwm->hwpwm);
> > +                             return ret;
> > +                     }
> > +             }
> > +
> > +             if (state->period !=3D cstate.period ||
> > +                 state->duty_cycle !=3D cstate.duty_cycle) {
>
> This is a coarse check. If state->period and cstate.period only differ
> by one calling sprd_pwm_config(spc, pwm, state->duty_cycle,
> state->period) probably results in a noop. So you're doing an expensive
> division to get an unreliable check. It would be better to calculate the
> register values from the requested state and compare the register
> values. The costs are more or less the same than calling .get_state and
> the check is reliable. And you don't need to spend another division to
> calculate the new register values.

Same as above comment.

>
> > +                     ret =3D sprd_pwm_config(spc, pwm, state->duty_cyc=
le,
> > +                                           state->period);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +
> > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
> > +     } else if (cstate.enabled) {
> > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
> > +
> > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
>
> Assuming writing SPRD_PWM_ENABLE =3D 0 to the hardware completes the
> currently running period and the write doesn't block that long: Does
> disabling the clocks interfere with completing the period?

Writing SPRD_PWM_ENABLE =3D 0 will stop the PWM immediately, will not
waiting for completing the currently period.

>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops sprd_pwm_ops =3D {
> > +     .apply =3D sprd_pwm_apply,
> > +     .get_state =3D sprd_pwm_get_state,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> > +{
> > +     struct clk *clk_pwm;
> > +     int ret, i, clk_index =3D 0;
> > +
> > +     for (i =3D 0; i < SPRD_PWM_NUM; i++) {
> > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > +             int j;
> > +
> > +             for (j =3D 0; j < SPRD_PWM_NUM_CLKS; ++j)
> > +                     chn->clks[j].id =3D sprd_pwm_clks[clk_index++];
>
> I think this would be more understandable when written as:
>
>         for (j =3D 0; j < SPRD_PWM_NUM_CLKS; ++j)
>                 chn->clks[j].id =3D sprd_pwm_clks[i * SPRD_PWM_NUM_CLKS +=
 j];
>
> but I'm not sure I'm objective here.

Sure.

>
> > +
> > +             ret =3D devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, ch=
n->clks);
> > +             if (ret) {
> > +                     if (ret =3D=3D -ENOENT)
> > +                             break;
> > +
> > +                     dev_err(spc->dev, "failed to get channel clocks\n=
");
>
> if ret =3D=3D -EPROBE_DEFER you shouldn't issue an error message.

Yes.

>
> > +                     return ret;
> > +             }
> > +
> > +             clk_pwm =3D chn->clks[SPRD_PWM_OUTPUT_CLK].clk;
> > +             chn->clk_rate =3D clk_get_rate(clk_pwm);
> > +     }
> > +
> > +     if (!i) {
> > +             dev_err(spc->dev, "no available PWM channels\n");
> > +             return -EINVAL;
>
> ENODEV?

Yes

>
> > +     }
> > +
> > +     spc->num_pwms =3D i;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct sprd_pwm_chip *spc;
> > +     int ret;
> > +
> > +     spc =3D devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
> > +     if (!spc)
> > +             return -ENOMEM;
> > +
> > +     spc->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(spc->base))
> > +             return PTR_ERR(spc->base);
> > +
> > +     spc->dev =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, spc);
> > +
> > +     ret =3D sprd_pwm_clk_init(spc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     spc->chip.dev =3D &pdev->dev;
> > +     spc->chip.ops =3D &sprd_pwm_ops;
> > +     spc->chip.base =3D -1;
> > +     spc->chip.npwm =3D spc->num_pwms;
> > +
> > +     ret =3D pwmchip_add(&spc->chip);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "failed to add PWM chip\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pwm_remove(struct platform_device *pdev)
> > +{
> > +     struct sprd_pwm_chip *spc =3D platform_get_drvdata(pdev);
> > +     int ret, i;
> > +
> > +     ret =3D pwmchip_remove(&spc->chip);
> > +
> > +     for (i =3D 0; i < spc->num_pwms; i++) {
> > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > +
> > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
>
> If a PWM was still running you're effectively stopping it here, right?
> Are you sure you don't disable once more than you enabled?

Yes, you are right. I should check current enable status of the PWM channel=
.
Thanks for your comments.

--=20
Baolin Wang
Best Regards
