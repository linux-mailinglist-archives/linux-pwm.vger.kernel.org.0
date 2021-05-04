Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5E3727C0
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEDJFa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhEDJF3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 05:05:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9BC061761
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 02:04:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z24so4384290ioj.7
        for <linux-pwm@vger.kernel.org>; Tue, 04 May 2021 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZ8x0AmUK4Pzu79wykT/XFEidoyphF7QlRuuT6eOSs4=;
        b=F19MkKyLmNAksmXd4l3dnwb/LT982m/sCRK5mxSDW8z2e/m/m2so+ej0wfPncR9Vau
         CZC9bnEMZbwv2gfyzTKhommKOU1RLX80+TyVqMZ4pqw9DgiBfl5NyL86WNIbYyrdq2mw
         a73oNenvCZYnlbjkLxQvKTZZfgbAt+/HocVql10W83MKRDxfAcw+RAU21LfH1gkTJFwV
         A/GhujuKU2qJCfP7axo0nYQ3necUr+V+ql32PH7sFvbwqOvVC+5nnEH0pxLOXALez4zT
         IhnJiP0puDgnWZqHxZEjF9svLJiCtf6b6HMhcQv1O7MDowcbfkDeImuYRG48iBysKqvD
         jjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ8x0AmUK4Pzu79wykT/XFEidoyphF7QlRuuT6eOSs4=;
        b=EgWWuxWoR//MdHnf7NLVdAmRluaneEDy+kPoTUTRdIrV4FkbvNUqHZ7IeTFpSorEmo
         aiH8+o8CIZ9CHiYrl3ksJQWB7hQ7JzWWJvN2OPDrOUeKeuhGUgA01JyaJjBAUsymYFED
         1GgEr9MMxqoFhqiy89OIhzeHmrmm+kmzFq0Gpf9Aey0VsudaXAehkmNzIYm43YtJIKCG
         efRMqgQfvDyROwRomGcRGMsSKa9moKdP9PUp1P51nke5edsGc/kYyTuYnGv36oEE1xIF
         JWCWL3FE8ZS+Ct4uis+oRxwT6yaGVd1DDR6i+KMQ07CNqc1M4b1WYfDSVjh5UTKgDOn3
         Zj3Q==
X-Gm-Message-State: AOAM531aDJNZ+G4Mr78gIrnzGLaUoSzugX11nmSomFpGsoL9DE3kQAPg
        pjvuZFvaAQnMCJ55Em1R1DWJ9ebNH0hboJvRmn0ViA==
X-Google-Smtp-Source: ABdhPJx2urHVeDL4aK3w1uYF5NlSlH7LPxJFIrMQgVx1I7C7hDwYo19dx6Gic1pZSF33iZ2XzWb7Gib50FNkgp4uZMo=
X-Received: by 2002:a05:6638:3013:: with SMTP id r19mr23130110jak.36.1620119059947;
 Tue, 04 May 2021 02:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210503214413.3145015-2-sean.anderson@seco.com> <202105041013.VkdTa8rG-lkp@intel.com>
In-Reply-To: <202105041013.VkdTa8rG-lkp@intel.com>
From:   Alvaro Gamez <alvaro.gamez@hazent.com>
Date:   Tue, 4 May 2021 11:03:53 +0200
Message-ID: <CAM+bi4u0BKWzgVe7vVw-YGWZEJESCxZ4zwxMNpLa0Z=trC0udQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     kernel test robot <lkp@intel.com>
Cc:     Sean Anderson <sean.anderson@seco.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[ Sorry if you receive this twice, I think gmail is skipping the
emails I send via mutt so I'm resending this via the web interface ]

Hi,

On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. There is another driver for this device located
> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>

I wrote a patch to support this back in 2018, being the main difference that
I did try to make this PWM driver available also for Microblaze systems. Of
course, since a lot of time has passed since, even the PWM API seems to have
changed, so my original patch is probably no longer applicable.

You can see that old discussion here

https://lore.kernel.org/patchwork/patch/803890/
https://lore.kernel.org/patchwork/patch/935728/

It didn't went much further because no one from the device tree list
gave any feedback to my proposal, so it just kind of died there since I
didn't have the time to push further. Also, I didn't really send a patch as
such to devicetree list, since it looked like we needed some previous
discussion about it.

> ---
>
>  arch/arm64/configs/defconfig |   1 +
>  drivers/pwm/Kconfig          |  11 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..81794209f287 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_SL28CPLD=m
>  CONFIG_PWM_SUN4I=m
>  CONFIG_PWM_TEGRA=m
> +CONFIG_PWM_XILINX=m
>  CONFIG_SL28CPLD_INTC=y
>  CONFIG_QCOM_PDC=y
>  CONFIG_RESET_IMX7=y
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index d3371ac7b871..01e62928f4bf 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -628,4 +628,15 @@ config PWM_VT8500
>    To compile this driver as a module, choose M here: the module
>    will be called pwm-vt8500.
>
> +config PWM_XILINX
> + tristate "Xilinx AXI Timer PWM support"
> + depends on !MICROBLAZE

Here is probably the main difference between your patch and mine which
instead of depending on !MICROBLAZE had a dependency on ARCH_ZYNQ || MICROBLAZE
-apart from mine being too old to apply and useless now , of course-

> + help
> +  PWM framework driver for Xilinx LogiCORE IP AXI Timers. This
> +  timer is typically a soft core which may be present in Xilinx
> +  FPGAs. If you don't have this IP in your design, choose N.
> +
> +  To compile this driver as a module, choose M here: the module
> +  will be called pwm-xilinx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index d3879619bd76..fc1bd6ccc9ed 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_PWM_TIEHRPWM) += pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL) += pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED) += pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500) += pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX) += pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..240bd2993f97
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + */
> +#include <asm/io.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define TCSR0 0x00
> +#define TLR0 0x04
> +#define TCR0 0x08
> +#define TCSR1 0x10
> +#define TLR1 0x14
> +#define TCR1 0x18
> +
> +#define TCSR_MDT BIT(0)
> +#define TCSR_UDT BIT(1)
> +#define TCSR_GENT BIT(2)
> +#define TCSR_CAPT BIT(3)
> +#define TCSR_ARHT BIT(4)
> +#define TCSR_LOAD BIT(5)
> +#define TCSR_ENIT BIT(6)
> +#define TCSR_ENT BIT(7)
> +#define TCSR_TINT BIT(8)
> +#define TCSR_PWMA BIT(9)
> +#define TCSR_ENALL BIT(10)
> +#define TCSR_CASC BIT(11)
> +
> +/* Bits we need to set/clear to enable PWM mode, not including CASC */
> +#define TCSR_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_CLEAR (TCSR_MDT | TCSR_LOAD)
> +
> +#define NSEC_PER_SEC_ULL 1000000000ULL
> +
> +/**
> + * struct xilinx_pwm_device - Driver data for Xilinx AXI timer PWM driver
> + * @chip: PWM controller chip
> + * @clk: Parent clock
> + * @regs: Base address of this device
> + * @width: Width of the counters, in bits
> + */
> +struct xilinx_pwm_device {
> + struct pwm_chip chip;
> + struct clk *clk;
> + void __iomem *regs;
> + unsigned int width;
> +};
> +
> +static inline struct xilinx_pwm_device *xilinx_pwm_chip_to_device(struct pwm_chip *chip)
> +{
> + return container_of(chip, struct xilinx_pwm_device, chip);
> +}
> +
> +static bool xilinx_pwm_is_enabled(u32 tcsr0, u32 tcsr1)
> +{
> + return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
> + ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);
> +}
> +
> +static u32 xilinx_pwm_calc_tlr(struct xilinx_pwm_device *pwm, u32 tcsr,
> +       unsigned int period)
> +{
> + u64 cycles = DIV_ROUND_DOWN_ULL(period * clk_get_rate(pwm->clk),
> + NSEC_PER_SEC_ULL);
> +
> + if (tcsr & TCSR_UDT)
> + return cycles - 2;
> + else
> + return (BIT_ULL(pwm->width) - 1) - cycles + 2;
> +}
> +
> +static unsigned int xilinx_pwm_get_period(struct xilinx_pwm_device *pwm,
> +  u32 tlr, u32 tcsr)
> +{
> + u64 cycles;
> +
> + if (tcsr & TCSR_UDT)
> + cycles = tlr + 2;
> + else
> + cycles = (BIT_ULL(pwm->width) - 1) - tlr + 2;
> +
> + return DIV_ROUND_DOWN_ULL(cycles * NSEC_PER_SEC_ULL,
> +  clk_get_rate(pwm->clk));
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
> +    const struct pwm_state *state)
> +{
> + struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
> + u32 tlr0, tlr1;
> + u32 tcsr0 = readl(pwm->regs + TCSR0);
> + u32 tcsr1 = readl(pwm->regs + TCSR1);
> + bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
> +
> + if (state->polarity != PWM_POLARITY_NORMAL)
> + return -EINVAL;
> +
> + if (!enabled && state->enabled)
> + clk_rate_exclusive_get(pwm->clk);
> +
> + tlr0 = xilinx_pwm_calc_tlr(pwm, tcsr0, state->period);
> + tlr1 = xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
> + writel(tlr0, pwm->regs + TLR0);
> + writel(tlr1, pwm->regs + TLR1);
> +
> + if (state->enabled) {
> + /* Only touch the TCSRs if we aren't already running */
> + if (!enabled) {
> + /* Load TLR into TCR */
> + writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
> + writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
> + /* Enable timers all at once with ENALL */
> + tcsr0 = (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> + tcsr1 = TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> + writel(tcsr0, pwm->regs + TCSR0);
> + writel(tcsr1, pwm->regs + TCSR1);
> + }
> + } else {
> + writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
> + writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);
> + }
> +
> + if (enabled && !state->enabled)
> + clk_rate_exclusive_put(pwm->clk);
> +
> + return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> + struct pwm_device *unused,
> + struct pwm_state *state)
> +{
> + struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
> + u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> + tlr0 = readl(pwm->regs + TLR0);
> + tlr1 = readl(pwm->regs + TLR1);
> + tcsr0 = readl(pwm->regs + TCSR0);
> + tcsr1 = readl(pwm->regs + TCSR1);
> +
> + state->period = xilinx_pwm_get_period(pwm, tlr0, tcsr0);
> + state->duty_cycle = xilinx_pwm_get_period(pwm, tlr1, tcsr1);
> + state->enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
> + state->polarity = PWM_POLARITY_NORMAL;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops = {
> + .apply = xilinx_pwm_apply,
> + .get_state = xilinx_pwm_get_state,
> +};
> +
> +static struct dentry *debug_dir;
> +
> +#define DEBUG_REG(reg) { .name = #reg, .offset = (reg), }
> +static struct debugfs_reg32 xilinx_pwm_reg32[] = {
> + DEBUG_REG(TCSR0),
> + DEBUG_REG(TLR0),
> + DEBUG_REG(TCR0),
> + DEBUG_REG(TCSR1),
> + DEBUG_REG(TLR1),
> + DEBUG_REG(TCR1),
> +};

I didn't add any DEBUG_FS entries, so I really like this. It would have
helped me while developing my own version of this and will probably be
useful for people debugging their hardware.

> +
> +static int xilinx_pwm_debug_create(struct xilinx_pwm_device *pwm)
> +{
> + struct debugfs_regset32 *regset;
> +
> + if (!IS_ENABLED(CONFIG_DEBUG_FS))
> + return 0;
> +
> + regset = devm_kzalloc(pwm->chip.dev, sizeof(*regset), GFP_KERNEL);
> + if (!pwm)
> + return -ENOMEM;
> +
> + regset->regs = xilinx_pwm_reg32;
> + regset->nregs = ARRAY_SIZE(xilinx_pwm_reg32);
> + regset->base = pwm->regs;
> +
> + debugfs_create_regset32(dev_name(pwm->chip.dev), 0400, debug_dir,
> + regset);
> + return 0;
> +}
> +
> +static int xilinx_pwm_probe(struct platform_device *pdev)
> +{
> + bool enabled;
> + int i, ret;
> + struct device *dev = &pdev->dev;
> + struct xilinx_pwm_device *pwm;
> + u32 one_timer;
> +
> + ret = of_property_read_u32(dev->of_node, "xlnx,one-timer-only",
> +   &one_timer);
> + if (ret || one_timer) {
> + dev_err(dev, "two timers are needed for PWM mode\n");
> + return -EINVAL;
> + }
> +
> + for (i = 0; i < 2; i++) {
> + char fmt[] = "xlnx,gen%u-assert";
> + char buf[sizeof(fmt)];
> + u32 gen;
> +
> + snprintf(buf, sizeof(buf), fmt, i);
> + ret = of_property_read_u32(dev->of_node, buf, &gen);
> + if (ret || !gen) {
> + dev_err(dev, "generateout%u must be active high\n", i);
> + return -EINVAL;
> + }
> + }
> +
> + pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> + if (!pwm)
> + return -ENOMEM;
> + platform_set_drvdata(pdev, pwm);
> +
> + pwm->chip.dev = &pdev->dev;
> + pwm->chip.ops = &xilinx_pwm_ops;
> + pwm->chip.base = -1;
> + pwm->chip.npwm = 1;
> +
> + pwm->regs = devm_platform_ioremap_resource(pdev, 0);
> + if (IS_ERR(pwm->regs))
> + return PTR_ERR(pwm->regs);
> +
> + ret = of_property_read_u32(dev->of_node, "xlnx,count-width", &pwm->width);
> + if (ret) {
> + dev_err(dev, "missing counter width\n");
> + return -EINVAL;
> + }
> +
> + pwm->clk = devm_clk_get(dev, NULL);
> + if (IS_ERR(pwm->clk))
> + return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
> +
> + ret = clk_prepare_enable(pwm->clk);
> + if (ret) {
> + dev_err(dev, "clock enable failed\n");
> + return ret;
> + }
> +
> + ret = xilinx_pwm_debug_create(pwm);
> + if (ret) {
> + clk_disable_unprepare(pwm->clk);
> + return ret;
> + }
> +
> + ret = pwmchip_add(&pwm->chip);
> + if (ret) {
> + clk_disable_unprepare(pwm->clk);
> + return ret;
> + }
> +
> + enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
> + readl(pwm->regs + TCSR1));
> + if (enabled)
> + clk_rate_exclusive_get(pwm->clk);
> +
> + return ret;
> +}
> +
> +static int xilinx_pwm_remove(struct platform_device *pdev)
> +{
> + struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
> + bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
> +     readl(pwm->regs + TCSR1));
> +
> + if (enabled)
> + clk_rate_exclusive_put(pwm->clk);
> + clk_disable_unprepare(pwm->clk);
> + return pwmchip_remove(&pwm->chip);
> +}
> +
> +static const struct of_device_id xilinx_pwm_of_match[] = {
> + { .compatible = "xlnx,xps-timer-1.00.a" },
> + { .compatible = "xlnx,axi-timer-2.0" },
> + {},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);

And here lies culprit of my patch not being accepted, since defining the
driver to be "xlnx,axi-timer-2.0" compatible while still allowing MICROBLAZE
to be set, did make the kernel to misconfigure the interrupt timer used by
the processor.


> +
> +static struct platform_driver xilinx_pwm_driver = {
> + .probe = xilinx_pwm_probe,
> + .remove = xilinx_pwm_remove,
> + .driver = {
> + .name = "xilinx-pwm",
> + .of_match_table = of_match_ptr(xilinx_pwm_of_match),
> + },
> +};
> +
> +static int __init xilinx_pwm_init(void)
> +{
> + int ret = platform_driver_register(&xilinx_pwm_driver);
> +
> + if (ret)
> + return ret;
> +
> + if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> + debug_dir = debugfs_create_dir(xilinx_pwm_driver.driver.name, NULL);
> + if (IS_ERR(debug_dir)) {
> + platform_driver_unregister(&xilinx_pwm_driver);
> + return PTR_ERR(debug_dir);
> + }
> + }
> + return 0;
> +}
> +module_init(xilinx_pwm_init);
> +
> +static void __exit xilinx_pwm_exit(void)
> +{
> + platform_driver_unregister(&xilinx_pwm_driver);
> + if (IS_ENABLED(CONFIG_DEBUG_FS))
> + debugfs_remove_recursive(debug_dir);
> +}
> +module_exit(xilinx_pwm_exit);
> +
> +MODULE_ALIAS("platform:xilinx-pwm");
> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer PWM driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.25.1
>

All in all, I'd be very glad if this got accepted (I haven't tested it), but
I'd be still happier if some compromise could be found within the device
tree so that this driver can be used also for Microblaze systems without
interfering with the main timer used by such systems.

Best regards,

-- 
Alvaro G. M.
