Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16A18910E
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2019 11:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKJXy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Aug 2019 05:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfHKJXx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 11 Aug 2019 05:23:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F2D2085B;
        Sun, 11 Aug 2019 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565515431;
        bh=U0/RWoUZ3Y8ptzeSgOvYe/+VMocXX3HsssWOWyLlP3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hqt4AkQmDRl8011AKbZvYT/7Y0OXwlEZ2/IfG0a+QS/YUXVlrh0E54y9vNC+uq6/s
         y++m1cJyU7LP4VNQvIILrWzEf4pvsZezIHX7O8fX2Bplh6G9SeXljq6/NAd4V1dXVm
         T0PEzuc/vcOfaxJ5B5oKrppoxi+pf+AnU7ykqXJU=
Date:   Sun, 11 Aug 2019 10:23:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmVu?= =?UTF-8?B?b8OudA==?= Cousson 
        <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
Message-ID: <20190811102345.1af5c23c@archlinux>
In-Reply-To: <20190807194023.15318-4-david@lechnology.com>
References: <20190807194023.15318-1-david@lechnology.com>
        <20190807194023.15318-4-david@lechnology.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed,  7 Aug 2019 14:40:21 -0500
David Lechner <david@lechnology.com> wrote:

> This adds a new counter driver for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) module.
> 
> Only very basic functionality is currently implemented - only enough to
> be able to read the position. The actual device has many more features
> which can be added to the driver on an as-needed basis.
> 
> It is not possible to read the QEPA/B signal values in hardware, so
> that feature is omitted.
> 
> The TI_PWMSS kernel option is selected in Kconfig to enable the parent
> bus, which is needed for power management.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Hi David,

A few questions from me around runtime pm and interaction with the
userspace interface.

> ---
> 
> v2 changes:
> - Dropped unused index and strobe signals
> - Added synapses and actions
> - Fixed base in of kstrtouint()
> - Clarifications in commit message
> 
>  MAINTAINERS               |   6 +
>  drivers/bus/Kconfig       |   2 +-
>  drivers/counter/Kconfig   |  12 +
>  drivers/counter/Makefile  |   1 +
>  drivers/counter/ti-eqep.c | 460 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 480 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/counter/ti-eqep.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..53c28d52964c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16014,6 +16014,12 @@ S:	Maintained
>  F:	drivers/media/platform/davinci/
>  F:	include/media/davinci/
>  
> +TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
> +R:	David Lechner <david@lechnology.com>
> +L:	linux-iio@vger.kernel.org
> +F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
> +F:	drivers/counter/ti-eqep.c
> +
>  TI ETHERNET SWITCH DRIVER (CPSW)
>  R:	Grygorii Strashko <grygorii.strashko@ti.com>
>  L:	linux-omap@vger.kernel.org
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 4eeb15839ce0..04db7fce4604 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -142,7 +142,7 @@ config TEGRA_GMI
>  
>  config  TI_PWMSS
>  	bool
> -	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
> +	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM || TI_EQEP)
>  	help
>  	  PWM Subsystem driver support for AM33xx SOC.
>  
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2967d0a9ff91..7eeb310f0cda 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -49,6 +49,18 @@ config STM32_LPTIMER_CNT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
>  
> +config TI_EQEP
> +	tristate "TI eQEP counter driver"
> +	depends on (SOC_AM33XX || COMPILE_TEST)
> +	select PWM
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the Texas Instruments Enhanced Quadrature
> +	  Encoder Pulse (eQEP) counter driver.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ti-eqep.
> +
>  config FTM_QUADDEC
>  	tristate "Flex Timer Module Quadrature decoder driver"
>  	depends on HAS_IOMEM && OF
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 40d35522937d..55142d1f4c43 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_COUNTER) += counter.o
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> +obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
>  obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> new file mode 100644
> index 000000000000..a761b868c12b
> --- /dev/null
> +++ b/drivers/counter/ti-eqep.c
> @@ -0,0 +1,460 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2019 David Lechner <david@lechnology.com>
> + *
> + * Counter driver for Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP)
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/counter.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +/* 32-bit registers */
> +#define QPOSCNT		0x0
> +#define QPOSINIT	0x4
> +#define QPOSMAX		0x8
> +#define QPOSCMP		0xc
> +#define QPOSILAT	0x10
> +#define QPOSSLAT	0x14
> +#define QPOSLAT		0x18
> +#define QUTMR		0x1c
> +#define QUPRD		0x20
> +
> +/* 16-bit registers */
> +#define QWDTMR		0x0	/* 0x24 */
> +#define QWDPRD		0x2	/* 0x26 */
> +#define QDECCTL		0x4	/* 0x28 */
> +#define QEPCTL		0x6	/* 0x2a */
> +#define QCAPCTL		0x8	/* 0x2c */
> +#define QPOSCTL		0xa	/* 0x2e */
> +#define QEINT		0xc	/* 0x30 */
> +#define QFLG		0xe	/* 0x32 */
> +#define QCLR		0x10	/* 0x34 */
> +#define QFRC		0x12	/* 0x36 */
> +#define QEPSTS		0x14	/* 0x38 */
> +#define QCTMR		0x16	/* 0x3a */
> +#define QCPRD		0x18	/* 0x3c */
> +#define QCTMRLAT	0x1a	/* 0x3e */
> +#define QCPRDLAT	0x1c	/* 0x40 */
> +
> +#define QDECCTL_QSRC_SHIFT	14
> +#define QDECCTL_QSRC		GENMASK(15, 14)
> +#define QDECCTL_SOEN		BIT(13)
> +#define QDECCTL_SPSEL		BIT(12)
> +#define QDECCTL_XCR		BIT(11)
> +#define QDECCTL_SWAP		BIT(10)
> +#define QDECCTL_IGATE		BIT(9)
> +#define QDECCTL_QAP		BIT(8)
> +#define QDECCTL_QBP		BIT(7)
> +#define QDECCTL_QIP		BIT(6)
> +#define QDECCTL_QSP		BIT(5)
> +
> +#define QEPCTL_FREE_SOFT	GENMASK(15, 14)
> +#define QEPCTL_PCRM		GENMASK(13, 12)
> +#define QEPCTL_SEI		GENMASK(11, 10)
> +#define QEPCTL_IEI		GENMASK(9, 8)
> +#define QEPCTL_SWI		BIT(7)
> +#define QEPCTL_SEL		BIT(6)
> +#define QEPCTL_IEL		GENMASK(5, 4)
> +#define QEPCTL_PHEN		BIT(3)
> +#define QEPCTL_QCLM		BIT(2)
> +#define QEPCTL_UTE		BIT(1)
> +#define QEPCTL_WDE		BIT(0)
> +
> +/* EQEP Inputs */
> +enum {
> +	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> +	TI_EQEP_SIGNAL_QEPB,	/* QEPB/XDIR */
> +};
> +
> +/* Position Counter Input Modes */
> +enum {
> +	TI_EQEP_COUNT_FUNC_QUAD_COUNT,
> +	TI_EQEP_COUNT_FUNC_DIR_COUNT,
> +	TI_EQEP_COUNT_FUNC_UP_COUNT,
> +	TI_EQEP_COUNT_FUNC_DOWN_COUNT,
> +};
> +
> +enum {
> +	TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +	TI_EQEP_SYNAPSE_ACTION_RISING_EDGE,
> +	TI_EQEP_SYNAPSE_ACTION_NONE,
> +};
> +
> +struct ti_eqep_cnt {
> +	struct counter_device counter;
> +	struct regmap *regmap32;
> +	struct regmap *regmap16;
> +};
> +
> +static int ti_eqep_count_read(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      struct counter_count_read_value *val)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 cnt;
> +
> +	regmap_read(priv->regmap32, QPOSCNT, &cnt);
> +	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_count_write(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       struct counter_count_write_value *val)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 cnt, max;
> +	int err;
> +
> +	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
> +	if (err)
> +		return err;
> +
> +	regmap_read(priv->regmap32, QPOSMAX, &max);
> +	if (cnt > max)
> +		return -EINVAL;
> +
> +	return regmap_write(priv->regmap32, QPOSCNT, cnt);
> +}
> +
> +static int ti_eqep_function_get(struct counter_device *counter,
> +				struct counter_count *count, size_t *function)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qdecctl;
> +
> +	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> +	*function = (qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT;
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_function_set(struct counter_device *counter,
> +				struct counter_count *count, size_t function)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +
> +	return regmap_write_bits(priv->regmap16, QDECCTL, QDECCTL_QSRC,
> +				 function << QDECCTL_QSRC_SHIFT);
> +}
> +
> +static int ti_eqep_action_get(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      struct counter_synapse *synapse, size_t *action)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	size_t function;
> +	u32 qdecctl;
> +	int err;
> +
> +	err = ti_eqep_function_get(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	switch (function) {
> +	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> +		/* In quadrature mode, the rising and falling edge of both
> +		 * QEPA and QEPB trigger QCLK.
> +		 */
> +		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> +		/* In direction-count mode only rising edge of QEPA is counted
> +		 * and QEPB gives direction.
> +		 */
> +		switch (synapse->signal->id) {
> +		case TI_EQEP_SIGNAL_QEPA:
> +			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +			break;
> +		default:
> +			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> +			break;
> +		}
> +		break;
> +	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> +	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> +		/* In up/down-count modes only QEPA is counted and QEPB is not
> +		 * used.
> +		 */
> +		switch (synapse->signal->id) {
> +		case TI_EQEP_SIGNAL_QEPA:
> +			err = regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> +			if (err)
> +				return err;
> +
> +			if (qdecctl & QDECCTL_XCR)
> +				*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +			else
> +				*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +			break;
> +		default:
> +			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> +			break;
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops ti_eqep_counter_ops = {
> +	.count_read	= ti_eqep_count_read,
> +	.count_write	= ti_eqep_count_write,
> +	.function_get	= ti_eqep_function_get,
> +	.function_set	= ti_eqep_function_set,
> +	.action_get	= ti_eqep_action_get,
> +};
> +
> +static ssize_t ti_eqep_position_ceiling_read(struct counter_device *counter,
> +					     struct counter_count *count,
> +					     void *ext_priv, char *buf)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qposmax;
> +
> +	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
> +
> +	return sprintf(buf, "%u\n", qposmax);
> +}
> +
> +static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
> +					      struct counter_count *count,
> +					      void *ext_priv, const char *buf,
> +					      size_t len)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	int err;
> +	u32 res;
> +
> +	err = kstrtouint(buf, 0, &res);
> +	if (err < 0)
> +		return err;
> +
> +	regmap_write(priv->regmap32, QPOSMAX, res);
> +
> +	return len;
> +}
> +
> +static ssize_t ti_eqep_position_floor_read(struct counter_device *counter,
> +					   struct counter_count *count,
> +					   void *ext_priv, char *buf)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qposinit;
> +
> +	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
> +
> +	return sprintf(buf, "%u\n", qposinit);
> +}
> +
> +static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
> +					    struct counter_count *count,
> +					    void *ext_priv, const char *buf,
> +					    size_t len)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	int err;
> +	u32 res;
> +
> +	err = kstrtouint(buf, 0, &res);
> +	if (err < 0)
> +		return err;
> +
> +	regmap_write(priv->regmap32, QPOSINIT, res);
> +
> +	return len;
> +}
> +
> +static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
> +					    struct counter_count *count,
> +					    void *ext_priv, char *buf)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qepctl;
> +
> +	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> +
> +	return sprintf(buf, "%u\n", !!(qepctl & QEPCTL_PHEN));
> +}
> +
> +static ssize_t ti_eqep_position_enable_write(struct counter_device *counter,
> +					     struct counter_count *count,
> +					     void *ext_priv, const char *buf,
> +					     size_t len)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	int err;
> +	bool res;
> +
> +	err = kstrtobool(buf, &res);
> +	if (err < 0)
> +		return err;
> +
> +	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, res ? -1 : 0);
> +
> +	return len;
> +}
> +
> +static struct counter_count_ext ti_eqep_position_ext[] = {
> +	{
> +		.name	= "ceiling",
> +		.read	= ti_eqep_position_ceiling_read,
> +		.write	= ti_eqep_position_ceiling_write,
> +	},
> +	{
> +		.name	= "floor",
> +		.read	= ti_eqep_position_floor_read,
> +		.write	= ti_eqep_position_floor_write,
> +	},
> +	{
> +		.name	= "enable",
> +		.read	= ti_eqep_position_enable_read,
> +		.write	= ti_eqep_position_enable_write,
> +	},
> +};
> +
> +static struct counter_signal ti_eqep_signals[] = {
> +	[TI_EQEP_SIGNAL_QEPA] = {
> +		.id = TI_EQEP_SIGNAL_QEPA,
> +		.name = "QEPA"
> +	},
> +	[TI_EQEP_SIGNAL_QEPB] = {
> +		.id = TI_EQEP_SIGNAL_QEPB,
> +		.name = "QEPB"
> +	},
> +};
> +
> +static const enum counter_count_function ti_eqep_position_functions[] = {
> +	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> +	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
> +	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
> +};
> +
> +static const enum counter_synapse_action ti_eqep_position_synapse_actions[] = {
> +	[TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES]	= COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	[TI_EQEP_SYNAPSE_ACTION_RISING_EDGE]	= COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	[TI_EQEP_SYNAPSE_ACTION_NONE]		= COUNTER_SYNAPSE_ACTION_NONE,
> +};
> +
> +static struct counter_synapse ti_eqep_position_synapses[] = {
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPA],
> +	},
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPB],
> +	},
> +};
> +
> +static struct counter_count ti_eqep_counts[] = {
> +	{
> +		.id		= 0,
> +		.name		= "QPOSCNT",
> +		.functions_list	= ti_eqep_position_functions,
> +		.num_functions	= ARRAY_SIZE(ti_eqep_position_functions),
> +		.synapses	= ti_eqep_position_synapses,
> +		.num_synapses	= ARRAY_SIZE(ti_eqep_position_synapses),
> +		.ext		= ti_eqep_position_ext,
> +		.num_ext	= ARRAY_SIZE(ti_eqep_position_ext),
> +	},
> +};
> +
> +static const struct regmap_config ti_eqep_regmap32_config = {
> +	.name = "32-bit",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x24,
> +};
> +
> +static const struct regmap_config ti_eqep_regmap16_config = {
> +	.name = "16-bit",
> +	.reg_bits = 16,
> +	.val_bits = 16,
> +	.reg_stride = 2,
> +	.max_register = 0x1e,
> +};
> +
> +static int ti_eqep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ti_eqep_cnt *priv;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap32 = devm_regmap_init_mmio(dev, base,
> +					       &ti_eqep_regmap32_config);
> +	if (IS_ERR(priv->regmap32))
> +		return PTR_ERR(priv->regmap32);
> +
> +	priv->regmap16 = devm_regmap_init_mmio(dev, base + 0x24,
> +					       &ti_eqep_regmap16_config);
> +	if (IS_ERR(priv->regmap16))
> +		return PTR_ERR(priv->regmap16);
> +
> +	priv->counter.name = dev_name(dev);
> +	priv->counter.parent = dev;
> +	priv->counter.ops = &ti_eqep_counter_ops;
> +	priv->counter.counts = ti_eqep_counts;
> +	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
> +	priv->counter.signals = ti_eqep_signals;
> +	priv->counter.num_signals = ARRAY_SIZE(ti_eqep_signals);
> +	priv->counter.priv = priv;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get(dev);
I'm a little confused on the flow here.

pm_runtime_enable turns on runtime pm in general.

pm_runtime_get basically calls runtime_resume to ensrue the
device has power.

> +
> +	return devm_counter_register(dev, &priv->counter);

This registers the userspace interfaces and exposes the device.

> +}
> +
> +static int ti_eqep_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_put(dev),
> +	pm_runtime_disable(dev);

pm_runtime_put notifies the system that the device is idle
(and hence potentially turns it off).

Not good if the counter is still registered.

I'm assuming the presence of runtime pm at all is to interact
with a parent driver and hence stop that turning off if this
driver is probed?  That's probably fine, but add a few comments
to make it clear that this driver itself doesn't really do
runtime pm at all.

Thanks,

J
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_eqep_of_match[] = {
> +	{ .compatible = "ti,am3352-eqep", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
> +
> +static struct platform_driver ti_eqep_driver = {
> +	.probe = ti_eqep_probe,
> +	.remove = ti_eqep_remove,
> +	.driver = {
> +		.name = "ti-eqep-cnt",
> +		.of_match_table = ti_eqep_of_match,
> +	},
> +};
> +module_platform_driver(ti_eqep_driver);
> +
> +MODULE_AUTHOR("David Lechner <david@lechnology.com>");
> +MODULE_DESCRIPTION("TI eQEP counter driver");
> +MODULE_LICENSE("GPL v2");

