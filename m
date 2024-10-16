Return-Path: <linux-pwm+bounces-3688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC469A0E2C
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF81C2268C
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C220E02C;
	Wed, 16 Oct 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Ovbs5A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44D20CCEA;
	Wed, 16 Oct 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092505; cv=none; b=MTfZ4mLPl41mGWmCcvN+/dHWHACqWTlrI8e/nOzPxgWpsoz3L+RHTfSt2iiuREAlkH09Ah4Gq0vugcfXS/eLkJVSgyiLFvOFjXMRzcu4Dggr5LZ03KLcqesDUF9TrgfZpI5w8Ho03DlNv/0mHvDDVbQZLR5B9MDm6XUuUjYAnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092505; c=relaxed/simple;
	bh=aAuYtWkILqnx6A2Xxfedjzs4dQtq1HTwpmlcxuQpXx8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7q3a9dnR9a9dk+ktaDFMTD/V3Osygfz/bC/jxI7XUgWZQG/jLu1hw0b++P+k6OVjsC1U7058DbVWtCuI6+jP9fcfHn9OV7HNXjw7A5SNoG8Fg8KEvhoCfAgLonUl6BHF+QGOwn7yshBhRIo7J/sJgDAXRQZpZgF1K5l1gDC3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3Ovbs5A; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so4414777e87.1;
        Wed, 16 Oct 2024 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729092501; x=1729697301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=saZKAW0UGJseZ+w8IBbjt85ZVV1mtNyGSss2qQL+bCY=;
        b=h3Ovbs5ATZLe3bEHniBXyiPsL9LFuADkbxo5UbuYUIwM/triCVWULH2FISXKv1l5TY
         CjxXgFknMoEVyd8lcuGO6pC6J9lTaYOHhpTewv5f4KjgwO1oRdrUAuUgQOp6VThQixYd
         qfnzmkXqeQOPquRZCRpvhH1g6uJzHmaR8f8QESuFQfG0mVy/tlgzDwrH713K2M4Xaw7g
         RslBPhyiAoD9JS+3/gWzgkgk6+B01MCWlGDez2Uw/zs8wu1SNTOjdF3R/AOnhaKpTAHI
         Nj8c/VjNVen8uXNKkuyWkrTahq1jQM+qkQpAm3CRew6dsvFe0q7uB8UBk9mBjLpKE77C
         JwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092501; x=1729697301;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saZKAW0UGJseZ+w8IBbjt85ZVV1mtNyGSss2qQL+bCY=;
        b=BzyyCF1dOjtgQUU2gDES4bjTnaSwcSSQlcyesYhdH3HQUvPWXJMH3Vnx0nrEUT5N2i
         SDW5UQxPLfmCqg3KdgxLLL7l6fplL+OPNr7BqLA/JFfctRkurqmJA/1gCE06xtHHW30X
         Z4xK2sf7xI6lAT3xtPENVp5y9MFcOnoxfqObBPlsxd4zeaqzS6+Q1Ip1mRLjz5aVXBx+
         P7kiJ+IYLs6irN986bZyvcjIb8kJ2U7xTp5GkrbYZgc1fvrwYkVB+GMZ5tY8MKZpYFKQ
         XqrgIyQLYSdbUkv3b/iAP1MgvOvcRtbCinHZ93aoFsubcINDIgrzNrPWdsBctQXmdgWp
         AmTg==
X-Forwarded-Encrypted: i=1; AJvYcCVudSNN0M0kP7bQjXhNuCsmwPn3mPts1qDjhft0ynGjghDLZIolSHrQwvUkZ3bcfIuh/9fHSSROGnkt@vger.kernel.org, AJvYcCWd6zhhSk5FZb+9qDjEEJ976zFQ+7hGMTkMk0EA3M7cMAfoB+rGPxhGlW7FcqKY0h00QyKf6PlvXblMJw==@vger.kernel.org, AJvYcCXk1121Uwd71fRvT0izPE2Wg5fxyMyuhAW27VSMZLsOeIOJemtni4KpVDNmnteJMp6avzqWa03OJZw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf40yp9uw0FIzCTYq2BDu73eLE6r37Dg/pa5JvoRMTUyiOYhSO
	5/JPPoc2PDHrXE6rZbaBLj2ztu2CkFzOPNVo53iPvf3eUl+zfrMr
X-Google-Smtp-Source: AGHT+IGLBopEDxkxtLhLypJ1H+KrR+110xsvdIMHIN7/M68jZkFqqqTyNtLJJYFD/HtuW8CwSSOToA==
X-Received: by 2002:a05:6512:220b:b0:539:f886:31da with SMTP id 2adb3069b0e04-53a03f826eemr3084461e87.53.1729092501079;
        Wed, 16 Oct 2024 08:28:21 -0700 (PDT)
Received: from Ansuel-XPS. ([62.19.118.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2984338bsm197276666b.147.2024.10.16.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:28:20 -0700 (PDT)
Message-ID: <670fdb94.170a0220.88fbd.a384@mx.google.com>
X-Google-Original-Message-ID: <Zw_bjf_-VvvwbeuK@Ansuel-XPS.>
Date: Wed, 16 Oct 2024 17:28:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 6/6] pwm: airoha: Add support for EN7581 SoC
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
 <20241016-en7581-pinctrl-v7-6-4ff611f263a7@kernel.org>
 <069d220c-b682-40ba-a254-9f60167c56dd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <069d220c-b682-40ba-a254-9f60167c56dd@collabora.com>

On Wed, Oct 16, 2024 at 12:25:45PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > 
> > Introduce driver for PWM module available on EN7581 SoC.
> > 
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/pwm/Kconfig      |  11 ++
> >   drivers/pwm/Makefile     |   1 +
> >   drivers/pwm/pwm-airoha.c | 408 +++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 420 insertions(+)
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 0915c1e7df16d451e987dcc5f10e0b57edc32ee1..99aa87136c272555c10102590fcf9f911161c3d3 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -54,6 +54,17 @@ config PWM_ADP5585
> >   	  This option enables support for the PWM function found in the Analog
> >   	  Devices ADP5585.
> > +config PWM_AIROHA
> > +	tristate "Airoha PWM support"
> > +	depends on ARCH_AIROHA || COMPILE_TEST
> > +	depends on OF
> > +	select REGMAP_MMIO
> > +	help
> > +	  Generic PWM framework driver for Airoha SoC.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-airoha.
> > +
> >   config PWM_APPLE
> >   	tristate "Apple SoC PWM support"
> >   	depends on ARCH_APPLE || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9081e0c0e9e09713fe05479c257eebe5f02b91e9..fbf7723d845807fd1e2893c6ea4f736785841b0d 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -2,6 +2,7 @@
> >   obj-$(CONFIG_PWM)		+= core.o
> >   obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
> >   obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
> > +obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
> >   obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
> >   obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
> >   obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
> > diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f1587ebf5adf1950cdf953600a2772b2c9ab6e73
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-airoha.c
> > @@ -0,0 +1,408 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> > + *
> > + *  Limitations:
> > + *  - No disable bit, so a disabled PWM is simulated by setting duty_cycle to 0
> > + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> > + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> > + *    pins and 17 SIPO GPIO pins.
> > + *  - Supports only normal polarity.
> > + *  - On configuration the currently running period is completed.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/gpio.h>
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <asm/div64.h>
> > +
> > +#define REG_SGPIO_LED_DATA		0x0024
> > +#define SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> > +#define SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> > +
> > +#define REG_SGPIO_CLK_DIVR		0x0028
> > +#define REG_SGPIO_CLK_DLY		0x002c
> > +
> > +#define REG_SIPO_FLASH_MODE_CFG		0x0030
> > +#define SERIAL_GPIO_FLASH_MODE		BIT(1)
> > +#define SERIAL_GPIO_MODE		BIT(0)
> > +
> > +#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + ((_n) << 2))
> > +#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
> > +
> > +#define REG_GPIO_FLASH_MAP(_n)		(0x004c + ((_n) << 2))
> > +#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
> > +#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
> > +
> > +#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + ((_n) << 2))
> > +
> > +#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + ((_n) << 2))
> > +#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
> > +
> 
> Probably boils down to personal opinion, but I would do:
> 
> struct airoha_pwm_bucket {
> 	....stuff...
> }
> 
> > +struct airoha_pwm {
> > +	struct regmap *regmap;
> > +
> > +	struct device_node *np;
> > +	u64 initialized;
> > +
> 
> 	struct airoha_pwm_bucket bucket[EN7581_NUM_BUCKETS];
> 
> > +	struct {
> > +		/* Bitmask of PWM channels using this bucket */
> > +		u64 used;
> > +		u64 period_ns;
> > +		u64 duty_ns;
> > +	} bucket[8];
> > +};
> > +
> > +/*
> > + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
> > + * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
> > + * However, we've only got 8 concurrent waveform generators and can therefore
> > + * only use up to 8 different combinations of duty cycle and period at a time.
> > + */
> > +#define PWM_NUM_GPIO	16
> > +#define PWM_NUM_SIPO	17
> > +
> > +/* The PWM hardware supports periods between 4 ms and 1 s */
> > +#define PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
> > +#define PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> > +/* It is represented internally as 1/250 s between 1 and 250 */
> > +#define PERIOD_MIN	1
> > +#define PERIOD_MAX	250
> > +/* Duty cycle is relative with 255 corresponding to 100% */
> > +#define DUTY_FULL	255
> > +
> 
> ..snip..
> 
> > +
> > +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> > +{
> > +	u32 clk_divr_val = 3, sipo_clock_delay = 1;
> > +	u32 val, sipo_clock_divisor = 32;
> 
> u32 clk_divr_val, sipo_clock_delay, sipo_clock_divisor, val;
> int ret;
> 
> > +
> > +	if (!(pc->initialized >> PWM_NUM_GPIO))
> > +		return 0;
> > +
> > +	/* Select the right shift register chip */
> > +	if (of_property_read_bool(pc->np, "hc74595"))
> 
> "airoha,serial-gpio-mode"
> 

Hi, thanks for the review. I'm keeping the strange name and renaming
this to "airoha,74hc595-mode".

Contrary to the confusing (taken from documentation) register name,
this actually select what shift register chip is used with 0 as 74HC164
and 1 as 74HC595. The main difference between the 2 chip is the fact
that a latch pin needs to be triggered to the configuration to be
applied. This is handled internally by the SoC but require the correct
chip used in the device to be set in this register, hence the more
descriprtive property. Hope it's O.K.

(Off-topic and sorry for asking, any chance you can help and check also
the clock driver series? It's just some small fixup and regmap
conversion due to EN7581 strange registry mapping. [1]

[1] https://lore.kernel.org/linux-arm-kernel/172546204488.2561174.6649654649913061182.robh@kernel.org/T/
)

> > +		regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> > +				SERIAL_GPIO_MODE);
> > +	else
> > +		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> > +				  SERIAL_GPIO_MODE);
> > +
> > +	if (!of_property_read_u32(pc->np, "sipo-clock-divisor",
> > +				  &sipo_clock_divisor)) {
> 
> ret = of_property_read_u32(pc->np, "airoha,sipo-clock-divisor", &sipo_clock_divisor);
> if (ret)
> 	sipo_clock_divisor = 32;
> 
> switch (sipo_clock_divisor) {
> ......
> }
> 
> > +		switch (sipo_clock_divisor) {
> > +		case 4:
> > +			clk_divr_val = 0;
> > +			break;
> > +		case 8:
> > +			clk_divr_val = 1;
> > +			break;
> > +		case 16:
> > +			clk_divr_val = 2;
> > +			break;
> > +		case 32:
> > +			clk_divr_val = 3;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	/* Configure shift register timings */
> > +	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR, clk_divr_val);
> > +
> > +	of_property_read_u32(pc->np, "sipo-clock-delay", &sipo_clock_delay);
> 
> "airoha,sipo-clock-delay"
> 
> ret = ...
> if (ret)
> 	sipo_clock_delay = 1;
> 
> > +	if (sipo_clock_delay < 1 || sipo_clock_delay > sipo_clock_divisor / 2)
> > +		return -EINVAL;
> > +
> Everything else looks good to me.
> 
> Cheers,
> Angelo

-- 
	Ansuel

