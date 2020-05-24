Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC081E02AD
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 22:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgEXULV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 16:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgEXULV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 16:11:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C3BC061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 13:11:20 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcwxr-0006Qr-GB; Sun, 24 May 2020 22:11:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcwxo-000839-O6; Sun, 24 May 2020 22:11:16 +0200
Date:   Sun, 24 May 2020 22:11:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v2] pwm: Add DesignWare PWM Controller Driver
Message-ID: <20200524201116.pc7jmffr6jxlwren@pengutronix.de>
References: <20200508123233.712610-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200508123233.712610-1-jarkko.nikula@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Fri, May 08, 2020 at 03:32:33PM +0300, Jarkko Nikula wrote:
> Introduce driver for Synopsys DesignWare PWM Controller used on Intel
> Elkhart Lake.
> 
> Initial implementation is done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
> 
> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> v2. First version here https://www.spinics.net/lists/linux-pwm/msg12122.html
> Thanks to Uwe Kleine-König for good review comments, hopefully I captured
> them all.
> Changes:
> - Added Felipe's Signed-of-by. I added (Intel) to his kernel.org address
>   to highlight contribution was done while working at Intel
> - Version register read removed as result was unused
> - Order of dwc_pwm_writel() arguments changed to match with writel()
> - Structure initializers use one space instead of tab alignment
> - Error messages added to dwc_pwm_probe()
> - MODULE_LICENSE() Updated based on a review comment and commit bf7fbeeae6db
>   ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> - Polarity handled. HW supports only normal polarity and driver errors
>   out in case of wrong polarity in dwc_pwm_apply() and returns fixed
>   normal polarity in dwc_pwm_get_state()
> - Running timers are not stopped on probe and remove. Those may be set
>   running by a bootloader and driver should leave them runnning
> - pwm_is_enabled() call changed to pwm->state.enabled in wc_pwm_apply()
> - Co-authors added to MODULE_AUTHOR() and comment
> - mutex removed
> - Add struct dwc_pwm_ctx for register save/restore instead of word array
> - suspend prevented in case of active PWM consumers. Please note this
>   checks only PWMs enabled by Linux consumers and not the ones enabled
>   by bootloader
> - Duplicate linux/pm_runtime.h include removed
> - Only once used trivial functions moved to dwc_pwm_get_state()
> - struct dwc_pwm_driver_data removed and used hard coded properties
>   instead since currently driver supports single device type
> - Driver uses internally 64-bit duty and period calculation and caps
>   them to 32-bit ns max value for PWM core. HW supports 32-bit high and
>   low period counters with 10 ns resolution so HW can do ~42,9 s duty and
>   ~85.9 s period at maximum
> ---
>  drivers/pwm/Kconfig   |   9 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-dwc.c | 300 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c13d146cdde5..3a8fdba9b680 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -160,6 +160,15 @@ config PWM_CROS_EC
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.
>  
> +config PWM_DWC
> +	tristate "DesignWare PWM Controller"
> +	depends on PCI
> +	help
> +	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-dwc.
> +
>  config PWM_EP93XX
>  	tristate "Cirrus Logic EP93xx PWM support"
>  	depends on ARCH_EP93XX || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a59c710e98c7..da5d9fefd183 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
>  obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
> +obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
>  obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> new file mode 100644
> index 000000000000..21740273e7a3
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**

This isn't kernel-doc, is it? So this should use only a single *

> + * DesignWare PWM Controller driver
> + *
> + * Copyright (C) 2018-2020 Intel Corporation
> + *
> + * Author: Felipe Balbi (Intel)
> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> + * Author: Raymond Tan <raymond.tan@intel.com>
> + */

Is there publically available documentation available? If yes, please
add a link here.

> +
> +#include <linux/bitops.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +
> +#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
> +#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
> +#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
> +#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
> +#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
> +#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
> +
> +#define DWC_TIMERS_INT_STS	0xa0
> +#define DWC_TIMERS_EOI		0xa4
> +#define DWC_TIMERS_RAW_INT_STS	0xa8
> +#define DWC_TIMERS_COMP_VERSION	0xac
> +
> +#define DWC_TIMERS_TOTAL	8
> +#define DWC_CLK_PERIOD_NS	10
> +
> +/* Timer Control Register */
> +#define DWC_TIM_CTRL_EN		BIT(0)
> +#define DWC_TIM_CTRL_MODE	BIT(1)
> +#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
> +#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
> +#define DWC_TIM_CTRL_INT_MASK	BIT(2)
> +#define DWC_TIM_CTRL_PWM	BIT(3)
> +
> +struct dwc_pwm_ctx {
> +	u32 cnt;
> +	u32 cnt2;
> +	u32 ctrl;
> +};
> +
> +struct dwc_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +
> +	unsigned long clk_period_ns;
> +
> +	void __iomem *base;
> +
> +	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
> +};
> +#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> +
> +static inline u32 dwc_pwm_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static inline void dwc_pwm_writel(u32 value, void __iomem *base, u32 offset)
> +{
> +	writel(value, base + offset);
> +}

I would have chosen the following prototype:

	static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)

Passing a struct dwc_pwm * instead of a void __iomem * saves some
horizontal space and putting the base in the middle looks bad (but that
might be subjective?)

> +static void __dwc_pwm_configure(struct dwc_pwm *dwc, int pwm,
> +				unsigned int duty_ns,
> +				unsigned int period_ns)
> +{
> +	u32 ctrl;
> +	u32 high;
> +	u32 low;
> +
> +	high = DIV_ROUND_CLOSEST(duty_ns, dwc->clk_period_ns) - 1;

If duty_ns is zero, high ends up being 0xffffffff which looks wrong?!

DIV_ROUND_CLOSEST is wrong. Did you test your driver with PWM_DEBUG
enabled?

> +	low = DIV_ROUND_CLOSEST(period_ns - duty_ns, dwc->clk_period_ns) - 1;

Would be great to have a comment explaining the resulting waveform for
these two register values. If I interpret this correctly DWC_TIM_LD_CNT
defines the time the output is low (A value of x results in (x + 1) * 10
ns low). And DWC_TIM_LD_CNT2 defines the high time (with the same
formula). Right?

> +	dwc_pwm_writel(low, dwc->base, DWC_TIM_LD_CNT(pwm));
> +	dwc_pwm_writel(high, dwc->base, DWC_TIM_LD_CNT2(pwm));

Maybe add a comment that __dwc_pwm_configure is only called with the PWM
disabled. This way it gets obvious that there is no race here.

> +	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
> +	dwc_pwm_writel(ctrl, dwc->base, DWC_TIM_CTRL(pwm));
> +}
> +
> +static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
> +{
> +	u32 reg;
> +
> +	reg = dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(pwm));
> +
> +	if (enabled)
> +		reg |= DWC_TIM_CTRL_EN;
> +	else
> +		reg &= ~DWC_TIM_CTRL_EN;
> +
> +	dwc_pwm_writel(reg, dwc->base, DWC_TIM_CTRL(pwm));
> +}
> +
> +static void __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
> +				      struct pwm_device *pwm,
> +				      const struct pwm_state *state)
> +{
> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> +	__dwc_pwm_configure(dwc, pwm->hwpwm, state->duty_cycle,
> +			    state->period);
> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);

Is it necessary to disable the hardware for reconfiguration? Please
document if disabling the hardware completes the currently running
period.

> +}
> +
> +static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->enabled) {
> +		if (!pwm->state.enabled)
> +			pm_runtime_get_sync(dwc->dev);

I wonder if we should do this in the core instead (no action item for
this driver/patch now).

> +		__dwc_pwm_configure_timer(dwc, pwm, state);
> +	} else {
> +		if (pwm->state.enabled) {
> +			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> +			pm_runtime_put_sync(dwc->dev);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      struct pwm_state *state)
> +{
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +	u64 duty, period;
> +
> +	pm_runtime_get_sync(dwc->dev);
> +
> +	state->enabled = !!(dwc_pwm_readl(dwc->base,
> +				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
> +
> +	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm->hwpwm));
> +	duty += 1;
> +	duty *= dwc->clk_period_ns;

So the hardware doesn't support a zero duty_cycle? Please document this
in a Limitations paragraph as do some other drivers. (In the same format
please to make this easily greppable.)

> +	/* Cap the value to 2^32-1 ns */
> +	state->duty_cycle = min(duty, (u64)(u32)-1);
> +
> +	period = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(pwm->hwpwm));
> +	period += 1;
> +	period *= dwc->clk_period_ns;
> +	period += duty;

And the hardware also doesn't support a 100% duty cycle? -> document
please.

> +	/* Cap the value to 2^32-1 ns */
> +	state->period = min(period, (u64)(u32)-1);

Instead of describing in the comment what you do, please tell why.

> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	pm_runtime_put_sync(dwc->dev);
> +}
> +
> +static const struct pwm_ops dwc_pwm_ops = {
> +	.apply = dwc_pwm_apply,
> +	.get_state = dwc_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	struct dwc_pwm *dwc;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &pci->dev;
> +
> +	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
> +	if (!dwc)
> +		return -ENOMEM;
> +
> +	dwc->dev = dev;
> +	dwc->clk_period_ns = DWC_CLK_PERIOD_NS;

Given this is constant you could drop the member and use
DWC_CLK_PERIOD_NS instead of dwc->clk_period_ns.

> +	ret = pcim_enable_device(pci);
> +	if (ret) {
> +		dev_err(&pci->dev, "Failed to enable device (%d)\n", ret);

Please use %pE for error codes.

> +		return ret;
> +	}
> +
> +	pci_set_master(pci);
> +
> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> +	if (ret) {
> +		dev_err(&pci->dev, "Failed to iomap PCI BAR (%d)\n", ret);

Don't you need to undo pcim_enable_device?

> +		return ret;
> +	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
