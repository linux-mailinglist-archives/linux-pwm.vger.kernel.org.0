Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4797F071
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfHBJ1i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 05:27:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39152 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfHBJ1i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2019 05:27:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so31742639pfn.6;
        Fri, 02 Aug 2019 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmMYhEmhRaQPy5HQGC1bjPyErSOTSkAIYv3USe0z520=;
        b=efdqs3SG06JXyS9Ziq6adY0OatK2czwxDXZYA3o3T/59HXxwys2uJaTLC/kzjT91x8
         1Zs6G/32oe0BNExeQTF/0gooOJ0GtXzI7MoXtlrIns2QFcC7tglFJRJdVsunwOFVdneM
         ksHZtsW0dMwcnAgIO7e4VR4gf6Fr9P9vrKhdIlJPAdy8NM321V+0UTpvp6BXGnX5QNt+
         iQMKWaSRrUfK9J+kxFQwdWv9FRMM55HXveTpVvm+C5asDUZKXX/N3SRj+lF+JOtbuTAW
         DT2W0HQ95v7ZvCoUUktOFlO89HD4oe1ivdb5OtgEXaHrnJYzAMWgsoEms+WmeGNk3eEU
         iTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmMYhEmhRaQPy5HQGC1bjPyErSOTSkAIYv3USe0z520=;
        b=cLeByWpVIiR1uT40XFkY/BR0C6jL62PncqCpL8ckilY1dTFphhxPW42GararMZLj3H
         xXOP87KGXRaojIiXEx9cnup2JhujAA+2rN99NrXM+dyM5N5EpojqwNq5nV5ElddKSx6n
         DO97zbuRCN+Roci/zFpWGdeYpPe6in2QZji0HRBN5nGdWek3mFkd2+b6culFuc6Srgny
         kVZVt4S0q4MVw0iv1AXnEqQ0imsAK/wfN4LVGXkqJ1NkoweFyz1cBQnZH/pumscUaDgq
         iOeq+ASxzf1RH8707NHfivfDEFmZzEcxYwRqFeRcXUMrqu6qEciCwCj13Ek6CLp2PN1j
         VlxA==
X-Gm-Message-State: APjAAAXKAN3hRJvwxpwna+TQDovX8lwwLxSDQxMab4GeKI9rG1e8dt+W
        hnbeyByFosta7f+C5Ivp9sA=
X-Google-Smtp-Source: APXvYqx2aCnEchcSURSFANix4DMQd6lLdawln8nTL5+Qx8dml8vVge8sKDs5unQh8KdZtszkN3/utQ==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr3509108pjz.85.1564738056662;
        Fri, 02 Aug 2019 02:27:36 -0700 (PDT)
Received: from icarus ([2001:268:c146:e9f9:e343:65f1:6148:c56c])
        by smtp.gmail.com with ESMTPSA id f32sm8500297pgb.21.2019.08.02.02.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 02:27:35 -0700 (PDT)
Date:   Fri, 2 Aug 2019 18:27:27 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Message-ID: <20190802092727.GB30522@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722154538.5314-3-david@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 22, 2019 at 10:45:36AM -0500, David Lechner wrote:
> This adds a new counter driver for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) module.
> 
> Only very basic functionality is currently implemented - only enough to
> be able to read the position. The actual device has many more features
> which can be added to the driver on an as-needed basis.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Some changes suggested below, but most of the important stuff is there
and correct so good job.

William Breathitt Gray

> ---
>  MAINTAINERS               |   6 +
>  drivers/counter/Kconfig   |  12 ++
>  drivers/counter/Makefile  |   1 +
>  drivers/counter/ti-eqep.c | 381 ++++++++++++++++++++++++++++++++++++++
>  drivers/pwm/Kconfig       |   2 +-
>  5 files changed, 401 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/counter/ti-eqep.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..f3b5e275732b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16014,6 +16014,12 @@ S:	Maintained
>  F:	drivers/media/platform/davinci/
>  F:	include/media/davinci/
>  
> +TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
> +R:	David Lechner <david@lechnology.com>
> +L:	linux-iio@vger.kernel.org
> +F:	Documentation/devicetree/bindings/counter/ti-eqep.txt
> +F:	drivers/counter/ti-eqep.c
> +
>  TI ETHERNET SWITCH DRIVER (CPSW)
>  R:	Grygorii Strashko <grygorii.strashko@ti.com>
>  L:	linux-omap@vger.kernel.org
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
> index 000000000000..7aaa4abbc9c5
> --- /dev/null
> +++ b/drivers/counter/ti-eqep.c
> @@ -0,0 +1,381 @@
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
> +	TI_EQEP_SIGNAL_QEPI,	/* Index */
> +	TI_EQEP_SIGNAL_QEPS,	/* Strobe */
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
> +	err = kstrtouint(buf, 10, &res);

In Documentation/ABI/testing/sysfs-bus-counter, a base is not specified
for the ceiling attribute so the expectation is for the base of the
string to be automatically detected with the conventional semantics.

That means you should pass 0 here to kstrtouint instead of 10.

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
> +	err = kstrtouint(buf, 10, &res);

For the same reason as the ceiling attribute, you should pass 0 here to
kstrtouint instead of 10.

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
> +static const struct counter_ops ti_eqep_counter_ops = {
> +	.count_read	= ti_eqep_count_read,
> +	.count_write	= ti_eqep_count_write,
> +	.function_get	= ti_eqep_function_get,
> +	.function_set	= ti_eqep_function_set,
> +};

Are you able to provide a signal_read function, or are the Signals not
exposed to the user by this device? Sometimes quadrature encoder devices
provide an instanteous read of the signal lines to tell whether they are
high or low, so I figured I'd ask.

You should define an action_get function as well along with Synapses
corresponding to each Signal. This will allow users to know whether the
Synapse fires on a rising edge, falling edge, no edge, or both edges.

For example, consider the drivers/counter/104-quad-8.c file. Each count
register has three associated signal lines: Quadrature A, Quadrature B,
and Index.

Quadrature A and B are your typical quadrature encoder lines and
depending on the function mode selected (quadrature x4, pulse-direction,
etc.) could have a Synapse action mode of none, rising edge, falling
edge, or both edges; see the quad8_synapse_actions_list array.

In contrast, the Index signal line only has two Synapse action modes:
rising edge (in the case preset functionality is enabled) or none.

For the TI eQEP driver, there will be four Synapses corresponding to the
four Signals: QEPA, QEPB, QEPI, and QEPS. See if you are able to
implement the Synapses and action_get function by using the 104-quad-8.c
file as a reference. That file does have a lot of extra functionality
tossed in compared to yours, so if you have trouble groking it, just let
me know and I'll try to help.

> +
> +static const enum counter_count_function ti_eqep_position_functions[] = {
> +	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> +	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
> +	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
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
> +	[TI_EQEP_SIGNAL_QEPI] = {
> +		.id = TI_EQEP_SIGNAL_QEPI,
> +		.name = "QEPI"
> +	},
> +	[TI_EQEP_SIGNAL_QEPS] = {
> +		.id = TI_EQEP_SIGNAL_QEPS,
> +		.name = "QEPS"
> +	},
> +};
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
> +static struct counter_count ti_eqep_counts[] = {
> +	{
> +		.id		= 0,
> +		.name		= "QPOSCNT",
> +		.functions_list	= ti_eqep_position_functions,
> +		.num_functions	= ARRAY_SIZE(ti_eqep_position_functions),
> +		.ext		= ti_eqep_position_ext,
> +		.num_ext	= ARRAY_SIZE(ti_eqep_position_ext),

When you have your Synapses defined, pass them here to your Count via
the synapses and num_synapses members.

> +	},
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
> +
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
> +static int ti_eqep_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_put(dev),
> +	pm_runtime_disable(dev);
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
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e57516959e..ddcbb8573894 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -499,7 +499,7 @@ config  PWM_TIEHRPWM
>  
>  config  PWM_TIPWMSS
>  	bool
> -	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
> +	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM || TI_EQEP)
>  	help
>  	  PWM Subsystem driver support for AM33xx SOC.

I was surprised to see this pwm Kconfig change in this patch. Is
PWM_TIPWMSS required for TI_EQEP to work? If not required, then this
could be a separate patch; otherwise, put in a mention about why in the
commit message so that the purpose of this change is clearer.

>  
> -- 
> 2.17.1
> 
