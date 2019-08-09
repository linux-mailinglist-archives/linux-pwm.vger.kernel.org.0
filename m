Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AA876E9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406042AbfHIKGf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 06:06:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39452 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbfHIKGe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 06:06:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so124527320otq.6
        for <linux-pwm@vger.kernel.org>; Fri, 09 Aug 2019 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2b+/UUP5KzPK6WOQURLTDRHl5lpQY97AU1zt5VvvbdY=;
        b=bDJfouwcPbqBhX51o/RfK/tPM7PjzPsho9RvcuqYQZm81n3/kjpUdJogQ2ekS68qsw
         CrkjkN7cb3pHl/rXthP7F7ytWIajnCe8aIU+vN+2yvHWdb2bjUdVWdPV7WAscdzufqwX
         kRI62Q+8wHk9fuq4lVticm2ixXH8GQcPGESXA86u0lJAObSG0wWoDZ9IaIbMuE9dKl5W
         8O/fYVldF9SG+Q0Tml5IknNKpx2BlW2lT+SmVGVi939AAvYffXovSy8fWHvMWaW09cBm
         Ju5oGbvlOkO7bCTjSwaiigPsb6F68vWBJvsqKAx2PqTbL3v8EWFOkdnwWX+KToAupMYo
         LICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2b+/UUP5KzPK6WOQURLTDRHl5lpQY97AU1zt5VvvbdY=;
        b=r5HXFUeIoaOZdcf/aATVKSppCcjEyoGnyY8KheAYc73NZwWAD/bnXz93osG2QQQs1h
         o76pGy3qZ79Cf843vidmA3Hm/yhMBkMS8n1j5+Q8hnRrrCmG8a4Pds8IadIC9J3dm9Uj
         3alNLR0b3fcm+C50KCV4S6FaEOsRc08u/HREhnbhsjQUcbtVluERxQp6R8j7Mw6tZtXd
         eVkvo3WBUY2i6y7qUh0C9+taNoT8YshCLWdnkRc/7Jp2gNam7YLdK/vqhyH1/+wz+Lu6
         00icWyffCo5WJVakpH/b5uLEtJuXAXrZJS3xAXu7EoDe3n7pe8vSHnlBOMrACEd2b2Ff
         3fAg==
X-Gm-Message-State: APjAAAUtvmO+C8Jinx5npYP2DM+e0sXlAaMUdbhN9xnZvbLzDPFPjfBr
        0Rjnd0xfeRy6u9I6gXGFr5/7lcYuejQHJHKHBWRQKg==
X-Google-Smtp-Source: APXvYqx1ymrFu+OzIJBplSSc4SICHYRCNuKv/bSDoJaVOa5PzQhXUV+TRwqOqfcDJf226qudy9SJDYmruhwj2A+Ipq0=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr4678885otk.145.1565345193247;
 Fri, 09 Aug 2019 03:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de>
In-Reply-To: <20190809091013.vguj4wty7qiab64t@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 9 Aug 2019 18:06:21 +0800
Message-ID: <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

 Hi Uwe,

On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > From: Neo Hou <neo.hou@unisoc.com>
> >
> > This patch adds the Spreadtrum PWM support, which provides maximum 4
> > channels.
> >
> > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/pwm/Kconfig    |   10 ++
> >  drivers/pwm/Makefile   |    1 +
> >  drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 322 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sprd.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a7e5751..4963b4d 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -423,6 +423,16 @@ config PWM_SPEAR
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-spear.
> >
> > +config PWM_SPRD
> > +     tristate "Spreadtrum PWM support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
>
> I think you need
>
>         depends on HAS_IOMEM

OK.

>
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
> > index 0000000..f6fc793
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sprd.c
> > @@ -0,0 +1,311 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Spreadtrum Communications Inc.
>
> If there is a publicly available reference manual available, please add
> a link to it here.

Sure.

>
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
> > +#define SPRD_PWM_DIV         0xc
> > +#define SPRD_PWM_PAT_LOW     0x10
> > +#define SPRD_PWM_PAT_HIGH    0x14
> > +#define SPRD_PWM_ENABLE              0x18
> > +
> > +#define SPRD_PWM_MOD_MAX     GENMASK(7, 0)
> > +#define SPRD_PWM_REG_MSK     GENMASK(15, 0)
> > +#define SPRD_PWM_ENABLE_BIT  BIT(0)
> > +
> > +#define SPRD_PWM_NUM         4
> > +#define SPRD_PWM_REGS_SHIFT  5
> > +#define SPRD_PWM_NUM_CLKS    2
> > +#define SPRD_PWM_DEFAULT_CLK 26000000UL
> > +
> > +struct sprd_pwm_chn {
> > +     struct clk_bulk_data clks[SPRD_PWM_NUM_CLKS];
> > +     unsigned long clk_rate;
> > +     bool clk_enabled;
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
> > +/* list of clocks required by PWM channels */
> > +static const char * const sprd_pwm_clks[] =3D {
> > +     "enable0", "pwm0",
> > +     "enable1", "pwm1",
> > +     "enable2", "pwm2",
> > +     "enable3", "pwm3",
> > +};
> > +
> > +static u32 sprd_pwm_read(struct sprd_pwm_chip *chip, u32 num, u32 reg)
>
> num is the channel id here? Then maybe "hwid" or "chanid" would be a
> better name. Or pass struct pwm_chip only?

Yes, will change to 'hwid'.

>
> Please (if you keep sprd_pwm_chip) rename chip to spc which is the name
> used in other places for structures of this type. "chip" is for struct
> pwm_chip.

Yes, sure.

>
> > +{
> > +     u32 offset =3D reg + (num << SPRD_PWM_REGS_SHIFT);
> > +
> > +     return readl_relaxed(chip->base + offset);
> > +}
> > +
> > +static void sprd_pwm_write(struct sprd_pwm_chip *chip, u32 num,
> > +                        u32 reg, u32 val)
> > +{
> > +     u32 offset =3D reg + (num << SPRD_PWM_REGS_SHIFT);
> > +
> > +     writel_relaxed(val, chip->base + offset);
> > +}
> > +
> > +static int sprd_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> > +                        int duty_ns, int period_ns)
>
> Please implement .apply() instead of .config(), .enable() and
> .disable().

OK.

>
> > +{
> > +     struct sprd_pwm_chip *spc =3D
> > +             container_of(chip, struct sprd_pwm_chip, chip);
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     u64 div, tmp;
> > +     u32 prescale, duty;
> > +     int ret;
> > +
> > +     /*
> > +      * NOTE: the clocks to PWM channel has to be enabled first before
> > +      * writing to the registers.
> > +      */
> > +     if (!chn->clk_enabled) {
> > +             ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->c=
lks);
>
> Do you really need to enable all 8 clocks to configure a single channel?

We have 4 channels, and each channel use 2 clocks, so here only enable
2 clocks, see SPRD_PWM_NUM_CLKS.

>
> > +             if (ret) {
> > +                     dev_err(spc->dev, "failed to enable pwm%u clock\n=
",
> > +                             pwm->hwpwm);
> > +                     return ret;
> > +             }
> > +
> > +             chn->clk_enabled =3D true;
> > +     }
> > +
> > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
>
> @Baolin: until we're there that there are framework requirements how to
> round, please document at least how you do it here. Also describing the
> underlying concepts would be good for the driver reader.
>
> Something like:
>
> /*
>  * The hardware provides a counter that is feed by the source clock.
>  * The period length is (PRESCALE + 1) * MOD counter steps.
>  * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
>  *
>  * To keep the maths simple we're always using MOD =3D MOD_MAX.
>  * The value for PRESCALE is selected such that the resulting period
>  * gets the maximal length not bigger than the requested one with the
>  * given settings (MOD =3D MOD_MAX and input clock).
>  */

Yes, totally agree with you. I will add some documentation for our
controller's setting.

>
> @Thierry: having a framework guideline here would be good. Or still
> better a guideline and a debug setting that notices drivers stepping out
> of line.
>
> I assume using MOD =3D 0 is forbidden?
>
> > +     /*
> > +      * According to the datasheet, the period_ns calculation formula
> > +      * should be:
> > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > +      *
> > +      * Then we can get the prescale formula:
> > +      * prescale =3D (period_ns * clk_rate) / (10^9 * mod) -1
> > +      */
> > +     tmp =3D chn->clk_rate * period_ns;
> > +     div =3D 1000000000ULL * SPRD_PWM_MOD_MAX;
>
> Please use NSEC_PER_SEC instead of 1000000000ULL.

Sure.

>
> > +     prescale =3D div64_u64(tmp, div) - 1;
>
> If tmp is smaller than div you end up with prescale =3D 0xffffffff which
> should be catched. What if prescale > 0xffff?

Usually we can not meet this case, but you are right, the prescale has
a limit according to the register definition. So will add a validation
here.

>
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
>
> You're losing precision here as you always use SPRD_PWM_MOD_MAX, right?
> (Just for my understanding, if this simpler approach is good enough
> here that's fine.)

Yes, SPRD_PWM_MOD_MAX is good enough.

>
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_LOW, SPRD_PWM_REG_MS=
K);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_HIGH, SPRD_PWM_REG_M=
SK);
>
> Please describe these two registers in a short comment.

Sure.

>
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
>
> Is the configuration here atomic in the sense that the write of DUTY
> above only gets effective when PRESCALE is written? If not, please add

Yes.

> a describing paragraph at the top of the driver similar to what is
> written in pwm-sifive.c. When the PWM is already running before, how
> does a configuration change effects the output? Is the currently running
> period completed?

Anyway, I'll add some comments to explain how it works.

>
> > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +                            struct pwm_state *state)
> > +{
> > +     struct sprd_pwm_chip *spc =3D
> > +             container_of(chip, struct sprd_pwm_chip, chip);
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     u32 enabled, duty, prescale;
> > +     u64 tmp;
> > +     int ret;
> > +
> > +     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> > +     if (ret) {
> > +             dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > +                     pwm->hwpwm);
> > +             return;
> > +     }
> > +
> > +     chn->clk_enabled =3D true;
> > +
> > +     duty =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD_PWM=
_REG_MSK;
> > +     prescale =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE) & =
SPRD_PWM_REG_MSK;
> > +     enabled =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) & SPR=
D_PWM_ENABLE_BIT;
> > +
> > +     /*
> > +      * According to the datasheet, the period_ns and duty_ns calculat=
ion
> > +      * formula should be:
> > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > +      * duty_ns =3D 10^9 * (prescale + 1) * duty / clk_rate
> > +      */
> > +     tmp =3D (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
> > +     state->period =3D div64_u64(tmp, chn->clk_rate);
>
> This is not idempotent. If you apply the configuration that is returned
> here this shouldn't result in a reconfiguration.

Since we may configure the  PWM in bootloader, so in kernel part we
should get current PWM state to avoid reconfiguration if state
configuration are same.

>
> > +     tmp =3D (prescale + 1) * 1000000000ULL * duty;
> > +     state->duty_cycle =3D div64_u64(tmp, chn->clk_rate);
> > +
> > +     state->enabled =3D !!enabled;
> > +
> > +     /* Disable PWM clocks if the PWM channel is not in enable state. =
*/
> > +     if (!enabled) {
> > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> > +             chn->clk_enabled =3D false;
> > +     }
> > +}
> > +
> > +static const struct pwm_ops sprd_pwm_ops =3D {
> > +     .config =3D sprd_pwm_config,
> > +     .enable =3D sprd_pwm_enable,
> > +     .disable =3D sprd_pwm_disable,
> > +     .get_state =3D sprd_pwm_get_state,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> > +{
> > +     struct clk *clk_parent, *clk_pwm;
> > +     int ret, i, clk_index =3D 0;
> > +
> > +     clk_parent =3D devm_clk_get(spc->dev, "source");
> > +     if (IS_ERR(clk_parent)) {
> > +             dev_err(spc->dev, "failed to get source clock\n");
> > +             return PTR_ERR(clk_parent);
> > +     }
> > +
> > +     for (i =3D 0; i < SPRD_PWM_NUM; i++) {
> > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > +             int j;
> > +
> > +             for (j =3D 0; j < SPRD_PWM_NUM_CLKS; ++j)
> > +                     chn->clks[j].id =3D sprd_pwm_clks[clk_index++];
> > +
> > +             ret =3D devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, ch=
n->clks);
> > +             if (ret) {
> > +                     if (ret =3D=3D -ENOENT)
> > +                             break;
>
> devm_clk_bulk_get_optional ? I'm sure you don't want to get all 8 clocks
> 8 times.

This is not optional, each channel has 2 required clocks, and we have
4 channels. (SPRD_PWM_NUM_CLKS =3D=3D 2)

>
> > +
> > +                     dev_err(spc->dev, "failed to get channel clocks\n=
");
> > +                     return ret;
> > +             }
> > +
> > +             clk_pwm =3D chn->clks[1].clk;
>
> This 1 looks suspicious. Are you using all clocks provided in the dtb at
> all? You're not using i in the loop at all, this doesn't look right.

Like I said above, each channel has 2 clocks: enable clock and pwm
clock, the 2nd clock of each channel's bulk clocks is the pwm clock,
which is used to set the source clock. I know this's not easy to read,
so do you have any good suggestion?

>
> > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > +                     chn->clk_rate =3D clk_get_rate(clk_pwm);
> > +             else
> > +                     chn->clk_rate =3D SPRD_PWM_DEFAULT_CLK;
>
> I don't know all the clock framework details, but I think there are
> better ways to ensure that a given clock is used as parent for another
> given clock. Please read the chapter about "Assigned clock parents and
> rates" in the clock bindings and check if this could be used for the
> purpose here and so simplify the driver.

Actually there are many other drivers set the parent clock like this,
and we want a default clock if failed to set the parent clock.

>
> > +     }
> > +
> > +     if (!i) {
> > +             dev_err(spc->dev, "no availbale PWM channels\n");
>
> s/availbale/available/

Sure.

>
> > +             return -EINVAL;
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
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to add PWM chip\n");
> > +             return ret;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, spc);
>
> If you do this earlier you can simplify the last part of the driver to:
>
>         ret =3D pwmchip_add(&spc->chip);
>         if (ret)
>                 dev_err(&pdev->dev, "failed to add PWM chip\n");
>
>         return ret;

OK.

>
> > +     return 0;
> > +}
> > +
> > +static int sprd_pwm_remove(struct platform_device *pdev)
> > +{
> > +     struct sprd_pwm_chip *spc =3D platform_get_drvdata(pdev);
> > +     int i;
> > +
> > +     for (i =3D 0; i < spc->num_pwms; i++)
> > +             pwm_disable(&spc->chip.pwms[i]);
>
> This is wrong. You must not call pwm_disable here. It's the consumer's
> responsibility to disable the hardware.

Emm, I saw some drivers did like this, like pwm-spear.c.
Could you elaborate on what's the problem if the driver issues pwm_disable?

Very appreciated for your comments.

--=20
Baolin Wang
Best Regards
