Return-Path: <linux-pwm+bounces-4564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880EA07D5D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804503A0FD6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBA21B1A8;
	Thu,  9 Jan 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEJ/rsSN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5821A45C;
	Thu,  9 Jan 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439691; cv=none; b=h5osvLWRzK8QOEYdBe7ARMnlocwXZZlFmLkSdvRGZ2ZsYexcT4fJsKUxxA1HO+AsSmF06RRNLH7Q9s+CtixvBCox0vHjNZg8eGlY86JoSOR5Q6eA2IGLJKCfNgRvwzcnYgJokcbP+PxJmh3HiUrvL1D3YLxmnFzLh5BxtsdmRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439691; c=relaxed/simple;
	bh=ruWAIlVuoKB3oe7K0yEYaMar4qlb76YA8JrigB/Njpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8nN7hJkPVhMX0Mvi1Sc8jayFiZrAFhUHURpeSpud9af4TNppc+4Z2JGTxznPfOlLIIVnAs6R+75O/Q3ob+DYK+V24lltJqdilE+4f9iFOkydzP5pMhYzz1Dz+PEjwHAlDvDK02cQydzCqIGQA0liNXfrhkgAlxvGNp8z7ZjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEJ/rsSN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43624b2d453so12529115e9.2;
        Thu, 09 Jan 2025 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736439688; x=1737044488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9y16hhAGNFjyIGGf8qTwlz24CbDHqvVJnX/ZF9+2oeo=;
        b=QEJ/rsSNcJXV+VWSnwNgh2I3txGCLyM4VpSvk7dRFWZGJIDR8eamCb16H9QDGjCHWG
         G3as3OVNcqWfbEwExnVxoCltLPukuwoVCheFUF7z7vdjk0mAvXbfT333+bZy2DrFOxyt
         NW/XuA9cc2VsbJPTaYV6CzVkPn5wDIuLg85TyUT+z+JsXWMUuaaypt8nTacCey5fbMgL
         eVEbC634FchTdZg29ronlL0xdVH0Etd8uRXI8A7J5QHIZLn+HS1IWmCc1kaUUu4GU+Sh
         JOf/xJiiN0nTdeNcAQzqztv1iz9lY3nn8fi66XcrMB6y2xur/bUe+cnJho3f9oLhbjyz
         Kp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736439688; x=1737044488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y16hhAGNFjyIGGf8qTwlz24CbDHqvVJnX/ZF9+2oeo=;
        b=CKQYiF0Tv7F2PuuK0oaKDUesW3eNl4mcZDSeZ7AaghSL14uFcBetuIBbeZDzfhTu5h
         n6LaZzunlMdib9OTd5p3qLFM/2hmAKGcfH5OqOzQcC/a+IoxD1yYnLzbQ+5RtoYweuKP
         JOwuz0e38IssaqwPddjCkTl0qWyTGOx7mZXCqvU57xAiPQBlu4hQyNdr0/f350OgcdC7
         aF3IKn/OeqTS+v2z8jwpYkDjZsTfpx5SuyzzRX1BulJcMbVQnIYtiJPGe+SInkIhgf93
         Vjf/WlMg+TmCCnEjwps1y1yxSI9N5X3oI4ZUXdAatxA7hA7AhlUy9ROI4A8WgbwyUnts
         OATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPfE0Nbud866VGajMT5P0S5DCLyo/3fCqh6z1aqml9cRX7VwoPZ+xOsmAHX1sYCsvt/S4zudVif2hT@vger.kernel.org, AJvYcCXa7t5lmKVBgoNcuFp+tgSET5fEBKzt53mArHTR0mCm3aWE6qz/XMudFlYJIAa/+dGd7jHD2+XHYxQSUD7O@vger.kernel.org, AJvYcCXgECCiala7BKjrcrFd6hFOgaIBBorxl+i3O7ieNe8zyqVfgmqIWk+155l4S+bOKDsujAOxzsyU1VZg@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJeBQSq49SvEzXz8rEL03wQRNXZ/c+Sk3zgKl4BPvgWBNJpfA
	wsXJWsj9v83otqQwK0wqbNLztp3Ore+tInMQHEyg9M/qzTIfa9Ui
X-Gm-Gg: ASbGncsk2zrJELIDb9kqqTAsT8YoZoq4DuUIX6P9nk5zjD62Ko58DCNTgzjcaOwQjx4
	lzSEDshSkkjicmRP+kAfgZ/LvSRXbM5BsdPyE4j1yhiIdkhFiE1xTPQ+iJcp7nP+iQP+g759QOu
	R6iHpshXAqv1o7b6NkGencBo5Q6YlYz60LcGmKhau/2ZqIvNL2xPO73C+qT09sJe/GLYhPe62ny
	5Mmx7CMfMost4HJ8Eb/QYEDKAUFCJ0peClG9Z/2pYcLM1+BKSY=
X-Google-Smtp-Source: AGHT+IH4fKnUIItQ46Zi4oteryVSAnxyRcaSk3V/cowKHV3IxU5TQV3iXNiJWuD8SkAWJ2AGayIXfQ==
X-Received: by 2002:a05:600c:198c:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-436e26f2a30mr54779955e9.28.1736439687485;
        Thu, 09 Jan 2025 08:21:27 -0800 (PST)
Received: from debian ([2a00:79c0:648:800:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm2206919f8f.3.2025.01.09.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:21:26 -0800 (PST)
Date: Thu, 9 Jan 2025 17:21:24 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20250109162124.GA46029@debian>
References: <20241109174135.26292-1-dima.fedrau@gmail.com>
 <20241109174135.26292-3-dima.fedrau@gmail.com>
 <5msw2ptk2ip5h5ovqe2ficgofqmaryq2qf5h7qendygaa23lp4@gy754ev7cnqm>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5msw2ptk2ip5h5ovqe2ficgofqmaryq2qf5h7qendygaa23lp4@gy754ev7cnqm>

Hello Uwe,

Am Wed, Jan 08, 2025 at 09:01:07AM +0100 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> thanks for your patience. I'm mostly happy now. Just a few minor
> comments below:
> 
> On Sat, Nov 09, 2024 at 06:41:35PM +0100, Dimitri Fedrau wrote:
> > The MC33XS2410 is a four channel high-side switch. Featuring advanced
> > monitoring and control function, the device is operational from 3.0 V to
> > 60 V. The device is controlled by SPI port for configuration.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/pwm/Kconfig          |  12 ++
> >  drivers/pwm/Makefile         |   1 +
> >  drivers/pwm/pwm-mc33xs2410.c | 388 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 401 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-mc33xs2410.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 0915c1e7df16..f513513f9b2f 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -411,6 +411,18 @@ config PWM_LPSS_PLATFORM
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
> > index 9081e0c0e9e0..c75deeeace40 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> >  obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
> >  obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
> >  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
> > +obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
> >  obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
> >  obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
> >  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
> > diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> > new file mode 100644
> > index 000000000000..97cf31ef608a
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-mc33xs2410.c
> > @@ -0,0 +1,388 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> > + *
> > + * Reference Manual : https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf
> > + *
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
> > +#include <linux/spi/spi.h>
> > +
> > +#define MC33XS2410_GLB_CTRL		0x00
> > +#define MC33XS2410_GLB_CTRL_MODE	GENMASK(7, 6)
> > +#define MC33XS2410_GLB_CTRL_MODE_NORMAL	FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
> > +
> > +#define MC33XS2410_PWM_CTRL1		0x05
> > +/* x in { 1 ... 4 } */
> 
> Here x ranges over the 4 output channels, right? Maybe call it "chan" or
> similar instead of "x"?
> 
I will call it chan and do the same for MC33XS2410_PWM_CTRL3_EN,
MC33XS2410_PWM_FREQ and MC33XS2410_PWM_DC.

> > +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT((x - 1))
> 
> BIT((x) - 1)
> 
Will fix it for others too.

> > +
> > +#define MC33XS2410_PWM_CTRL3		0x07
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x - 1))
> > +
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_FREQ(x)		(0x08 + (x - 1))
> > +#define MC33XS2410_PWM_FREQ_STEP	GENMASK(7, 6)
> > +#define MC33XS2410_PWM_FREQ_COUNT	GENMASK(5, 0)
> > +
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_DC(x)		(0x0c + (x - 1))
> > +
> > +#define MC33XS2410_WDT			0x14
> > +
> > +#define MC33XS2410_PWM_MIN_PERIOD	488282
> > +/* x in { 0 ... 3 } */
> > +#define MC33XS2410_PWM_MAX_PERIOD(x)	(2000000000 >> (2 * x))
> 
> Here x ranges over the four period intervals. I suggest to call this x
> "step" instead. Also the parameter needs bracketing.
> 
Ok.

> > +#define MC33XS2410_FRAME_IN_ADDR	GENMASK(15, 8)
> > +#define MC33XS2410_FRAME_IN_DATA	GENMASK(7, 0)
> > +#define MC33XS2410_FRAME_IN_ADDR_WR	BIT(7)
> > +#define MC33XS2410_FRAME_IN_DATA_RD	BIT(7)
> > +#define MC33XS2410_FRAME_OUT_DATA	GENMASK(13, 0)
> > +
> > +#define MC33XS2410_MAX_TRANSFERS	5
> > +
> > [...]
> > +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				const struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u8 reg[4] = {
> > +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_CTRL1,
> > +			MC33XS2410_PWM_CTRL3
> > +		    };
> > +	u64 period, duty_cycle;
> > +	int ret, rel_dc;
> > +	u16 rd_val[2];
> > +	u8 wr_val[4];
> > +	u8 mask;
> > +
> > +	period = min(state->period, MC33XS2410_PWM_MAX_PERIOD(0));
> > +	if (period < MC33XS2410_PWM_MIN_PERIOD)
> > +		return -EINVAL;
> > +
> > +	ret = mc33xs2410_read_regs(spi, &reg[2], MC33XS2410_FRAME_IN_DATA_RD, rd_val, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* frequency */
> > +	wr_val[0] = mc33xs2410_pwm_get_freq(period);
> > +	/* Continue calculations with the possibly truncated period */
> > +	period = mc33xs2410_pwm_get_period(wr_val[0]);
> > +
> > +	/* duty cycle */
> > +	duty_cycle = min(period, state->duty_cycle);
> > +	rel_dc = div64_u64(duty_cycle * 256, period) - 1;
> > +	if (rel_dc < 0)
> > +		wr_val[1] = 0;
> > +	else
> > +		wr_val[1] = rel_dc;
> > +
> > +	/* polarity */
> > +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
> > +	wr_val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
> > +		    (rd_val[0] | mask) : (rd_val[0] & ~mask);
> > +
> > +	/* enable output */
> 
> /*
>  * As the hardware cannot generate a 0% relative duty cycle but emits a
>  * constant low signal when disabled, also disable in the duty_cycle = 0
>  * case.
>  */
>
Will add the comment as is, thanks.

> > +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
> > +	wr_val[3] = (state->enabled && rel_dc >= 0) ? (rd_val[1] | mask) :
> > +						      (rd_val[1] & ~mask);
> > +
> > +	return mc33xs2410_write_regs(spi, reg, wr_val, 4);
> > +}
> > +
> > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm,
> > +				    struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u8 reg[4] = {
> > +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_CTRL1,
> > +			MC33XS2410_PWM_CTRL3,
> > +		    };
> > +	u16 val[4];
> > +	int ret;
> > +
> > +	ret = mc33xs2410_read_regs(spi, reg, MC33XS2410_FRAME_IN_DATA_RD, val, 4);
> 
> ARRAY_SIZE(reg) instead of hardcoded 4?
>
I'm not sure, but I can change it.

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	state->period = mc33xs2410_pwm_get_period(val[0]);
> > +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1)) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1));
> > +	state->duty_cycle = DIV_ROUND_UP_ULL((val[1] + 1) * state->period, 256);
> > +
> > +	return 0;
> > +}
> > [...]
> > +static int mc33xs2410_probe(struct spi_device *spi)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410;
> > +	struct device *dev = &spi->dev;
> > +	struct pwm_chip *chip;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, 4, sizeof(*mc33xs2410));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	spi->bits_per_word = 16;
> > +	spi->mode |= SPI_CS_WORD;
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mc33xs2410 = mc33xs2410_from_chip(chip);
> > +	mc33xs2410->spi = spi;
> > +	chip->ops = &mc33xs2410_pwm_ops;
> 
> Given that struct mc33xs2410_pwm only has a single member you can pass 0
> as 3rd parameter to devm_pwmchip_alloc(), call pwmchip_set_drvdata(chip,
> spi). Then you can save on indirection.
> 
Yes, that makes sense.

> > +	ret = mc33xs2410_reset(dev);
> > +	if (ret)
> > +		return ret;
> > +
> 
Best regards,
Dimitri


