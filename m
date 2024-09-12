Return-Path: <linux-pwm+bounces-3225-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CD976E2A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C889B220BF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A391A0BCB;
	Thu, 12 Sep 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVGC/WcR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133044C8F;
	Thu, 12 Sep 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156301; cv=none; b=Zpi/XaO6dg9WCaGbpM1L6fRoWCKzSgc64OtWaycpzQU2zcHVJDCjlWFCOc56BooTB8CupxqxF8t9oSri3xVDFwbQawytWOTr2wl2AXyLMhudUCJe0slB0fJNmjKAvHf2d3MKRuEyrf6aOmSo0DphQp18cKlMkIwo6isGpbq3/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156301; c=relaxed/simple;
	bh=QKh8zXa+5yjg9YnbuoKwnpa1+WYO0n+RxPHHE7jVOxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHkhEhFa6PMxOTBmxGzU3/za57gCAvb/ONVAUtLTM4W0xG8rJaP3Yg8SlJcsVXdeApWeCSkP4+DjTjXjGdcKwYvg+C6piqXDVVt8GJOdDvYSSGddVVByd4yxhRYkuiwJgDOJ6dngUmZO8gkd1PvY7bu6ytasiAF90kvgzdjEz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVGC/WcR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8ce5db8668so178233466b.1;
        Thu, 12 Sep 2024 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726156297; x=1726761097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezhTfPoAsq9FgljhkX2JOHL62rcIpUALvpTdKdmLGPI=;
        b=bVGC/WcRCHD6CJxAKxQ2PexBy+J6KEYcMV1aEpjal7wDnFUjIieWbOXuKg4aUxaT3V
         RPS8ET1FtX9su075jHd2htPC3s4h6Dfju1tLhMGSBi4Q9JG+JGhlO6dUD1PnizHYCiqf
         xY+elwpcBIofz2o+/lgX3qr/6XcGBK5ZV6ECEl2HWlkQwM6cvGwgbvzsN9T3fTx8rqkt
         tpD+KXP0PC+Fa7Gvw7ZoiV/9RQrHwSb0FgUXbvAeiPhEXunhTuOW+qJc4pbONwTjf3jl
         Y8swRmww2Wc3FzOF6wkUc1Blms8Ea8chEA8B9PFOTcFgfAbVv3ehXnGIfrtpZXmggowf
         Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156297; x=1726761097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezhTfPoAsq9FgljhkX2JOHL62rcIpUALvpTdKdmLGPI=;
        b=FQyIs78xfL/0DkPX5LOnszwo2m8jyGvb5NojCDJeeTrSF2vHiLDkttyqJXCGIG6dHX
         FtYzUe/1cIWL9XWFTFLPFRcKn6IyM3uqYf3uAC7LrgrwQ09QgvG5t3+Z5GvXaSxpRVBr
         /rrJgYJ4IM/GB2I5skZj8HsDpuVEY8PVpjyaAGMUrnUi6Yogq8hS+AV3akBB1zSWKkmF
         peRxcGPVIxaP22fqpxexIidKsJPA7iCEcI0NYc7LaHkrfosHCMco7l9SuWUPDj+R0zNk
         pQhKLnzq1BuYXTwaovRnTAhLVSulA88MaONQc5Nit2OJ2cOOR2C54MCWRwD3orGr1veD
         7sIg==
X-Forwarded-Encrypted: i=1; AJvYcCUK5/Y2JnC5ChoIRALv+SOYK4cZIHcvGs8ND/wsT7342UBd9DHyNT6jpSJvd7AfgZ05+K6HKWHt+TuB@vger.kernel.org, AJvYcCWNP9PupOKeIQPNWTnXUJzi+Gj2iCyxnxEEpeRSR3CLmyIqNWeZGzGKxDJrnyE53UJGn1R/p3F5LrE9@vger.kernel.org, AJvYcCWT0e7PLo/pPThCoXwBVvLIN2RJexWyhTcW+e1XdOvYXfNw/4mS1YpLtqvFI/xBfAdNnTNOoPGuAFd9F1NT@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvaBMOuI2wMjJJJ0DBS9gDGoii0D11oLl+YD1WKCZStWYChiq
	9UlkWLEjB5drjvuIZUD5pYUzjv8EkDvuOJKixzUDR481RZXpXgiC71A8iw==
X-Google-Smtp-Source: AGHT+IGGJlhyIs4tHN65NT9QYeX79EWeoPp+BzoDEiT282iEy3AE5dU6jbiylGUrdSgtM3v/EsfIfA==
X-Received: by 2002:a17:906:fe47:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a90293c50d9mr403676666b.8.1726156296487;
        Thu, 12 Sep 2024 08:51:36 -0700 (PDT)
Received: from debian ([2a00:79c0:61c:8b00:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61279sm760487166b.108.2024.09.12.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:51:35 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:51:33 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20240912155133.GA107885@debian>
References: <20240802154408.135632-1-dima.fedrau@gmail.com>
 <20240802154408.135632-3-dima.fedrau@gmail.com>
 <ygrnedi3bzyoqb74k34lkk6ddkpxdlck3hyppkg2mcli6c5qlg@i4kc766x2eak>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ygrnedi3bzyoqb74k34lkk6ddkpxdlck3hyppkg2mcli6c5qlg@i4kc766x2eak>

Hi Uwe,

Am Tue, Sep 10, 2024 at 11:24:42AM +0200 schrieb Uwe Kleine-König:
> Hello,
> 
> On Fri, Aug 02, 2024 at 05:44:08PM +0200, Dimitri Fedrau wrote:
> > The MC33XS2410 is a four channel high-side switch. Featuring advanced
> > monitoring and control function, the device is operational from 3.0 V to
> > 60 V. The device is controlled by SPI port for configuration.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/pwm/Kconfig          |  12 +
> >  drivers/pwm/Makefile         |   1 +
> >  drivers/pwm/pwm-mc33xs2410.c | 419 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 432 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-mc33xs2410.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 1dd7921194f5..1e873a19a1cf 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,18 @@ config PWM_LPSS_PLATFORM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-lpss-platform.
> >  
> > +config PWM_MC33XS2410
> > +	tristate "MC33XS2410 PWM support"
> > +	depends on OF
> > +	depends on SPI
> > +	help
> > +	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
> > +	  channel high-side switch. The device is operational from 3.0 V
> > +	  to 60 V. The device is controlled by SPI port for configuration.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-mc33xs2410.
> > +
> >  config PWM_MESON
> >  	tristate "Amlogic Meson PWM driver"
> >  	depends on ARCH_MESON || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 90913519f11a..b9b202f7fe7e 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> >  obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
> >  obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
> >  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
> > +obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
> >  obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
> >  obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
> >  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
> > diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> > new file mode 100644
> > index 000000000000..63e6a48b0d02
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-mc33xs2410.c
> > @@ -0,0 +1,419 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> > + *
> Please add a link to the manual here. I found
> https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf.
>
Sure, will add the link.

> > + * Limitations:
> > + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> > + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> > + *   - 2 Hz steps from 2 Hz to 128 Hz
> > + *   - 8 Hz steps from 8 Hz to 512 Hz
> > + *   - 32 Hz steps from 32 Hz to 2048 Hz
> > + * - Cannot generate a 0 % duty cycle.
> > + * - Always produces low output if disabled.
> > + * - Configuration isn't atomic. When changing polarity, duty cycle or period
> > + *   the data is taken immediately, counters not being affected, resulting in a
> > + *   behavior of the output pin that is neither the old nor the new state,
> > + *   rather something in between.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/math64.h>
> > +#include <linux/minmax.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pwm.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +#include <linux/spi/spi.h>
> > +
> > +#define MC33XS2410_GLB_CTRL		0x00
> > +#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
> > +#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
> 
> I would have defined these as:
> 
> #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
>
Will fix it in V6.

> > +#define MC33XS2410_PWM_CTRL1		0x05
> > +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
> > +#define MC33XS2410_PWM_CTRL3		0x07
> > +/* x in { 0 ... 3 } */
> > +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
> > +#define MC33XS2410_PWM_FREQ1		0x08
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x - 1))
> > +#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
> > +#define MC33XS2410_PWM_FREQ_COUNT_MASK	GENMASK(5, 0)
> > +#define MC33XS2410_PWM_DC1		0x0c
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x - 1))
> > +#define MC33XS2410_WDT			0x14
> > +
> > +#define MC33XS2410_WR			BIT(7)
> > +#define MC33XS2410_RD_CTRL		BIT(7)
> > +#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
> > +
> > +#define MC33XS2410_MIN_PERIOD_STEP0	31250000
> > +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> > +/* x in { 0 ... 3 } */
> > +#define MC33XS2410_MIN_PERIOD_STEP(x)	(MC33XS2410_MIN_PERIOD_STEP0 >> (2 * x))
> > +/* x in { 0 ... 3 } */
> > +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2 * x))
> 
> So 
> MC33XS2410_MIN_PERIOD_STEP(3) = 31250000 >> 6 which is mathematically
> 488281.25. I haven't thought deeply about it, but I wonder if that .25
> is relevant in the calculation of the step to select.
>
It is relevant and used in mc33xs2410_pwm_get_freq to select the step
and in mc33xs2410_pwm_apply to check if the period is in range. As a
workaround I add +1 to make sure that the period is bigger then 488281.

I could get rid of the MC33XS2410_MIN_PERIOD_STEP define as it is used
only twice and both times with "MC33XS2410_MIN_PERIOD_STEP(3)" and
instead define "MC33XS2410_MIN_PERIOD	488282".

> > +
> > +#define MC33XS2410_MAX_TRANSFERS	5
> > +#define MC33XS2410_WORD_LEN		2
> > +
> > +struct mc33xs2410_pwm {
> > +	struct spi_device *spi;
> > +};
> > +
> > +static
> > +inline struct mc33xs2410_pwm *to_pwm_mc33xs2410_chip(struct pwm_chip *chip)
> 
> personally I'd prefer to call this mc33xs2410_from_chip() or something
> similar to have it use the same prefix as the other functions. But given
> there is some inconsistency and other people feel strong here and
> (rightly) claim this type of function is often called "to_*", I won't
> insist.
> 
I don't have a preference on this, renaming wouldn't be a big problem.

> > +{
> > +	return pwmchip_get_drvdata(chip);
> > +}
> > [...]
> > +static u8 mc33xs2410_pwm_get_freq(u64 period)
> > +{
> > +	u8 step, count;
> > +
> > +	/*
> > +	 * Check which step is appropriate for the given period, starting with
> > +	 * the highest frequency(lowest period). Higher frequencies are
> > +	 * represented with better resolution by the device. Therefore favor
> > +	 * frequency range with the better resolution to minimize error
> > +	 * introduced by the frequency steps.
> > +	 */
> > +
> > +	switch (period) {
> > +	case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3):
> > +		step = 3;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2):
> > +		step = 2;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1):
> > +		step = 1;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0):
> > +		step = 0;
> > +		break;
> > +	}
> > +
> > +	count = DIV_ROUND_UP((u32)MC33XS2410_MAX_PERIOD_STEP(step), (u32)period);
> 
> It took me a while to verify that DIV_ROUND_UP is right here. The
> reasoning is that a higher count results in a higher frequency and so a
> smaller period.
> 
I could add a comment.

> > +	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
> > +	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count - 1);
> > +}
> > +
> > +static u64 mc33xs2410_pwm_get_period(u8 reg)
> > +{
> > +	u32 freq, code, steps;
> > +
> > +	/*
> > +	 * steps:
> > +	 *   - 0 = 0.5Hz
> > +	 *   - 1 = 2Hz
> > +	 *   - 2 = 8Hz
> > +	 *   - 3 = 32Hz
> > +	 * frequency = (code + 1) x steps.
> > +	 *
> > +	 * To avoid division in case steps value is zero we scale the steps
> 
> Technically you don't avoid a division, but "only" avoid loosing
> precision in case you have to do (integer) division by 0.5.
> 
Yes, will fix the comment.

> > +	 * value for now by two and keep it in mind when calculating the period
> > +	 * that we have doubled the frequency.
> 
> Maybe reflect that doubling in the variable naming? "doubled_steps"?
> 
Ok.

> > +	 */
> > +	steps = 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, reg) * 2);
> > +	code = FIELD_GET(MC33XS2410_PWM_FREQ_COUNT_MASK, reg);
> > +	freq = (code + 1) * steps;
> > +
> > +	/* Convert frequency to period, considering the doubled frequency. */
> > +	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);
> > +}
> > +
> > +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
> > +{
> > +	/*
> > +	 * duty_cycle cannot overflow and period is not zero, since this is
> > +	 * guaranteed by the caller.
> > +	 */
> > +	duty_cycle *= 256;
> > +	duty_cycle = div64_u64(duty_cycle, period);
> > +
> > +	return duty_cycle - 1;
> > +}
> > +
> > +static void mc33xs2410_pwm_set_relative_duty_cycle(struct pwm_state *state,
> > +						   u16 duty_cycle)
> > +{
> > +	if (!duty_cycle && !state->enabled)
> > +		state->duty_cycle = 0;
> > +	else
> > +		state->duty_cycle = DIV_ROUND_UP_ULL((u64)(duty_cycle + 1) * state->period, 256);
> 
> Why does !duty_cycle matter in the if condition. I would have expected
> 
> 	if (!state->enabled)
> 		state->duty_cycle = 0;
> 	else
> 		state->duty_cycle = DIV_ROUND_UP_ULL....)
> 
I think you are right, just wanted to keep the duty_cycle information when
disabling the output by "echo 0 > enable". Will test this with PWM_DEBUG
and fix it if there aren't any complaints.

> That cast to (u64) in the last line can be dropped.
> 
Ok.

> > +}
> > +
> > +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				const struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u8 reg[4] = {
> > +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_CTRL1,
> > +			MC33XS2410_PWM_CTRL3
> > +		    };
> > +	bool ctrl[2] = { true, true };
> > +	u64 period, duty_cycle;
> > +	int ret, rel_dc;
> > +	u16 val[4];
> > +	u8 mask;
> > +
> > +	period = min(state->period, MC33XS2410_MAX_PERIOD_STEP(0));
> > +	if (period < MC33XS2410_MIN_PERIOD_STEP(3) + 1)
> > +		return -EINVAL;
> 
> That is only right because in the expression for
> MC33XS2410_MIN_PERIOD_STEP(3) the shift results in a one being shifted
> out. If there were only zeros, the right check would be
> 
> 	if (period < MC33XS2410_MIN_PERIOD_STEP(3))
> 
> . That's a bit unfortunate because it's unintuitive and at first sight
> I'd expect that MC33XS2410_MIN_PERIOD_STEP(3) is a possible period.
> 
> Hmm, you could only fix that by doing scaled math or a good code
> comment.
>
Thanks for pointing out. See my comment above regarding define
MC33XS2410_MIN_PERIOD_STEP. Introducing MC33XS2410_MIN_PERIOD and
removing MC33XS2410_MIN_PERIOD_STEP define should fix this.

Best regards

Dimitri

