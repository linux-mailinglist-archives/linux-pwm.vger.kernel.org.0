Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF41A312D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDIIsb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 04:48:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIIsb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 04:48:31 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jMSrO-00031U-6f; Thu, 09 Apr 2020 10:48:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jMSrM-0005SQ-6A; Thu, 09 Apr 2020 10:48:28 +0200
Date:   Thu, 9 Apr 2020 10:48:28 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] pwm: Add DesignWare PWM Controller Driver
Message-ID: <20200409084828.uzqjb65zh3vklqs2@pengutronix.de>
References: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jarkko,

On Wed, Apr 08, 2020 at 03:54:04PM +0300, Jarkko Nikula wrote:
> Introduce driver for Synopsys DesignWare PWM Controller used on Intel
> Elkhart Lake.
> 
> Initial implementation is done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
> 
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/pwm/Kconfig   |   9 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-dwc.c | 328 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 30190beeb6e9..cfded9efdb17 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -150,6 +150,15 @@ config PWM_CROS_EC
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
>  	depends on ARCH_EP93XX
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9a475073dafc..eb52012f0e79 100644
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
> index 000000000000..962d504c1281
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DesignWare PWM Controller driver
> + *
> + * Copyright (C) 2018-2020 Intel Corporation
> + *
> + * Author: Felipe Balbi

Is there a publicly available reference manual available? If so, adding
a link here would be great.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
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
> +
> +/* Timer Control Register */
> +#define DWC_TIM_CTRL_EN		BIT(0)
> +#define DWC_TIM_CTRL_MODE	BIT(1)
> +#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
> +#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
> +#define DWC_TIM_CTRL_INT_MASK	BIT(2)
> +#define DWC_TIM_CTRL_PWM	BIT(3)
> +
> +struct dwc_pwm_driver_data {
> +	unsigned long clk_period_ns;
> +	int npwm;
> +};
> +
> +struct dwc_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct mutex lock;
> +
> +	unsigned long clk_period_ns;
> +	unsigned int version;

version is a write-only variable, this can be dropped.

> +
> +	void __iomem *base;
> +
> +	u32 saved_registers[24];
> +};
> +#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> +
> +static inline u32 dwc_pwm_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static inline void dwc_pwm_writel(void __iomem *base, u32 offset, u32 value)
> +{
> +	writel(value, base + offset);

I think it's unfortunate that the order of parameters is different for
dwc_pwm_writel and writel.

> +}
> +
> +static void __dwc_pwm_configure(struct dwc_pwm *dwc, int pwm,
> +				unsigned int duty_ns,
> +				unsigned int period_ns)
> +{
> +	u32 ctrl;
> +	u32 high;
> +	u32 low;
> +
> +	high = DIV_ROUND_CLOSEST(duty_ns, dwc->clk_period_ns) - 1;
> +	low = DIV_ROUND_CLOSEST(period_ns - duty_ns, dwc->clk_period_ns) - 1;

Have you tested your driver with CONFIG_PWM_DEBUG? I would expect that
using ROUND_CLOSEST triggers

	.apply is supposed to round down period

in some situations.

Maybe soon duty_ns and period_ns will become 64 bit integers. I suggest
to already cope for this today and introduce proper range checking.

> +	dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(pwm), low);
> +	dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT2(pwm), high);
> +
> +	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
> +	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), ctrl);
> +}
> +
> +static u32 __dwc_pwm_duty_ns(struct dwc_pwm *dwc, int pwm)
> +{
> +	u32 duty;
> +
> +	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm));
> +	duty += 1;
> +	duty *= dwc->clk_period_ns;
> +
> +	return duty;
> +}
> +
> +static u32 __dwc_pwm_period_ns(struct dwc_pwm *dwc, int pwm, u32 duty)
> +{
> +	u32 period;
> +
> +	period = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(pwm));
> +	period += 1;
> +	period *= dwc->clk_period_ns;

Can this overflow? (Hmm, I wonder what should be done about this as
.get_state() returns void.)

> +	period += duty;
> +
> +	return period;
> +}
> +
> +static bool __dwc_pwm_is_enabled(struct dwc_pwm *dwc, int pwm)
> +{
> +	return !!(dwc_pwm_readl(dwc->base,
> +				DWC_TIM_CTRL(pwm)) & DWC_TIM_CTRL_EN);
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
> +	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), reg);

What happens to the output if the EN bit is cleared? Does the hardware
complete the currently running period? If not, does the output "freeze"
or get inactive?

> +}
> +
> +static void __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
> +				      struct pwm_device *pwm,
> +				      const struct pwm_state *state)
> +{
> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> +	__dwc_pwm_configure(dwc, pwm->hwpwm, state->duty_cycle,
> +			    state->period);

Is it necessary to stop the hardware before writing the counter
registers? Or is this only done to prevent race conditions that yield
unexpected cycles?

> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
> +}
> +
> +static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +
> +	mutex_lock(&dwc->lock);
> +
> +	if (state->enabled) {
> +		if (!pwm_is_enabled(pwm))

If pwm_is_enabled() would be changed to call .get_state() you'd run in a
dead lock. Please don't call PWM API functions in driver callbacks.

> +			pm_runtime_get_sync(dwc->dev);
> +		__dwc_pwm_configure_timer(dwc, pwm, state);
> +	} else {
> +		if (pwm_is_enabled(pwm)) {
> +			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> +			pm_runtime_put_sync(dwc->dev);
> +		}
> +	}

You don't check state->polarity here.

> +
> +	mutex_unlock(&dwc->lock);
> +
> +	return 0;
> +}
> +
> +static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      struct pwm_state *state)
> +{
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +
> +	pm_runtime_get_sync(dwc->dev);
> +
> +	mutex_lock(&dwc->lock);
> +	state->enabled = __dwc_pwm_is_enabled(dwc, pwm->hwpwm);
> +	state->duty_cycle = __dwc_pwm_duty_ns(dwc, pwm->hwpwm);
> +	state->period = __dwc_pwm_period_ns(dwc, pwm->hwpwm,
> +					    state->duty_cycle);

I wonder if doing the math in .get_state() directly
instead of introducing a function with IMHO strange semantics that is
only used once would be easier to understand.

> +	mutex_unlock(&dwc->lock);
> +
> +	pm_runtime_put_sync(dwc->dev);
> +}
> +
> +static const struct pwm_ops dwc_pwm_ops = {
> +	.apply		= dwc_pwm_apply,
> +	.get_state	= dwc_pwm_get_state,
> +	.owner		= THIS_MODULE,

I personally don't like aligning the = in structure initializers. There
seem to be different tastes involved. If you don't care, please use just
one space before and after the = please.

> +};
> +
> +static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	struct dwc_pwm_driver_data *data;
> +	struct dwc_pwm *dwc;
> +	struct device *dev;
> +	int ret;
> +	int i;
> +
> +	data = (struct dwc_pwm_driver_data *) id->driver_data;
> +	dev = &pci->dev;
> +
> +	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
> +	if (!dwc)
> +		return -ENOMEM;
> +
> +	dwc->dev = dev;
> +	dwc->clk_period_ns = data->clk_period_ns;
> +
> +	ret = pcim_enable_device(pci);
> +	if (ret)

Error message here ..

> +		return ret;
> +
> +	pci_set_master(pci);
> +
> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> +	if (ret)

.. and here ..

> +		return ret;
> +
> +	dwc->base = pcim_iomap_table(pci)[0];
> +	if (!dwc->base)

.. and here?

> +		return -ENOMEM;
> +
> +	dwc->version = dwc_pwm_readl(dwc->base, DWC_TIMERS_COMP_VERSION);
> +
> +	/* mask all interrupts and disable all timers */
> +	for (i = 0; i < data->npwm; i++) {
> +		dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(i), 0);
> +		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(i), 0);
> +		dwc_pwm_writel(dwc->base, DWC_TIM_CUR_VAL(i), 0);
> +	}

Does "disable all timers" result in stopping all outputs? If so, please
don't to allow taking over running hardware from the boot loader.

> +	mutex_init(&dwc->lock);

What does this mutex protect? I think it's save to assume that calls to
.get_state() and .apply_state() for a single channel are serialized by the
core, so locking might not be necessary at the driver level.

> +	pci_set_drvdata(pci, dwc);
> +
> +	dwc->chip.dev = dev;
> +	dwc->chip.ops = &dwc_pwm_ops;
> +	dwc->chip.npwm = data->npwm;
> +	dwc->chip.base = -1;
> +
> +	ret = pwmchip_add(&dwc->chip);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_allow(dev);
> +
> +	return 0;
> +}
> +
> +static void dwc_pwm_remove(struct pci_dev *pci)
> +{
> +	struct dwc_pwm *dwc = pci_get_drvdata(pci);
> +	int i;
> +
> +	pm_runtime_forbid(&pci->dev);
> +	pm_runtime_get_noresume(&pci->dev);
> +
> +	for (i = 0; i < dwc->chip.npwm; i++)
> +		pwm_disable(&dwc->chip.pwms[i]);

You're not supposed to call pwm_disable() here.

> +
> +	pwmchip_remove(&dwc->chip);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dwc_pwm_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
> +	int i, index_base;
> +
> +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
> +		index_base = i * 3;
> +		dwc->saved_registers[index_base] =
> +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(i));
> +		dwc->saved_registers[index_base+1] =
> +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(i));
> +		dwc->saved_registers[index_base+2] =
> +			dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(i));
> +	}

Does sleeping stop the output? If so (I think) you should prevent going
to sleep if the consumers didn't stop the output.

> +	return 0;
> +}
> +
> +static int dwc_pwm_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
> +	int i, index_base;
> +
> +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
> +		index_base = i * 3;
> +		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(i),
> +			       dwc->saved_registers[index_base]);
> +		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT2(i),
> +			       dwc->saved_registers[index_base+1]);
> +		dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(i),
> +			       dwc->saved_registers[index_base+2]);

I think this code would benefit from saved_registers having a better
type. Something like

	struct {
		u32 cnt;
		u32 cnt2;
		u32 ctrl;
	} saved_registers[DWC_TIMERS_TOTAL];

	
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
> +
> +static const struct dwc_pwm_driver_data ehl_driver_data = {
> +	.npwm = 8,
> +	.clk_period_ns = 10,
> +};
> +
> +static const struct pci_device_id dwc_pwm_id_table[] = {
> +	{ PCI_VDEVICE(INTEL, 0x4bb7), (kernel_ulong_t) &ehl_driver_data },

If there is only a single device type, you could better hard code (with
cpp symbols) the values contained in ehl_driver_data.

> +	{  }	/* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
> +
> +static struct pci_driver dwc_pwm_driver = {
> +	.name		= "pwm-dwc",
> +	.probe		= dwc_pwm_probe,
> +	.remove		= dwc_pwm_remove,
> +	.id_table	= dwc_pwm_id_table,
> +	.driver = {
> +		.pm = &dwc_pwm_pm_ops,
> +	},
> +};
> +
> +module_pci_driver(dwc_pwm_driver);
> +
> +MODULE_AUTHOR("Felipe Balbi>");
> +MODULE_DESCRIPTION("DesignWare PWM Controller");
> +MODULE_LICENSE("GPL v2");

Is "GPL v2" still the one that should be used? I thought "GPL" was the
one to use.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
