Return-Path: <linux-pwm+bounces-6244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F051ACED09
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCED4175D0B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA893202F87;
	Thu,  5 Jun 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT/TIgm/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE672C3242;
	Thu,  5 Jun 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116760; cv=none; b=Gf/Cs21GqAGovGFOouux3GK1Q5N3V9vm7Kz/MEdOxTb9ZhNgD0Zz5qn8JR9ACxOulNT28wzcvfKUz9w80JvBd4Mx2aKyjsF2aE7si/aGneSzbLFBrFlFIaAdtA7zmYY/V0lVoU/+EKLAC04/8J1yqVkANoQ5lmd/fRiGWSP2zLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116760; c=relaxed/simple;
	bh=zy//n73rOfJyxJBh+Cb2NaKLRJavJ9M9WQ4/hpjeOaM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBG41ro6gpwWwJu6FAk5hZigpP7enmek4ymZ1gqK5BA9zZrWnvivY1LhqMUWVcpTHi5FoTB/bRm4g/4p09uKo+gpSaMyGfi4AV3u4Fdf+KQ0+TYPIMzZq0OdC0xNaAZpdXL0z8B6B292SDL9u7gJEwr28rmPAN6Y/pxeT85cW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT/TIgm/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so5767445e9.3;
        Thu, 05 Jun 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749116756; x=1749721556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNj14m4d+QqXNVeCyekRoSXVA2pe4UcGaauy4egVLDg=;
        b=lT/TIgm/e9C4tvtVOGk2YXL3uX6nF4ABB5eT1kH7+IzwTkX9ujvqSIjLR4Wobj7+Xx
         bs36dsukVZP+1lc2XqE7HdVbz4QPL6kuDPDq2PaC8Ri1mgU13ngBtMCqo1KLMsupfd8I
         2anavkFM+HwxeFVyxvgWtgXQdCOQP+uqQ3kVNuUSmuWjFr219nIU/MBwnqMdB/3GIjaC
         0tadVvEe/e/t86NbWs7QKcwkzsiaS0V/vIZWfgENE6VJHm3HRZdC6pfSdNtuuP+B4WqR
         YEEHhKku/oymnb2szvdEuKMhH+/qNEiVO/9e7+EN3P+jQGp6Sm1g6W0DadON0MSnm12H
         5+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749116756; x=1749721556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNj14m4d+QqXNVeCyekRoSXVA2pe4UcGaauy4egVLDg=;
        b=UzqGN1UlG/p1BoxtpgmIO8EhIcs0pEDgjq+nl9BO/a4fLLTM8cGvnvymR+15HfsCAz
         mENeraXB8FWdJO5G+v5NUs8iX/sZzJcCEmn8A0Q0Fm5sUy64g/fySIH+oHYgZL4IdVqz
         xYR4UxehTdoEeQv+jCFb1FK4R28nhRXMeJ0hcf9uaemuJ25RT1hH0uge/wg+nST+MU9T
         4nhlcXJLLFrZozFCWcCC4wP//rJbw0xK4iFfeBdofHFwV+69jfPZAfgUCMsB9EswYUWC
         HnW4ihi/NAr0hooT31JwJj0wgB1Ym9ukqSMLWUQ4y+sliM7+nD089qyKtu0gCTSsrIWS
         N4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCfIv0bQp7wJwBTCKoVIpb6AlmGmC8g6oax6QCdtoPxbfsK5Xt2DAz1osw4TBt290YQ7DdR4BoXIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6TSsp1XrtVvMQRgd9ixtZ/eHAKAqcJpQsmBfyiecxohUpKrIY
	E4rcVUesb9VOKi3KsmQlj+gxOAq5qRyOTjMmtvPldM/E2oVbB3QzBSuF
X-Gm-Gg: ASbGnctZimsiHyMEIQkcztehs6DJrGgu8rdMbN3x3DXDdOzypKMzDOL4yViid/jI4QJ
	WS63ysWhTBVxildHod/fjfU2JThfEQ6eiAToAgkFPkacOdXlOLzz62nAjhX+Z4AE0Qe/Ij9MpmH
	9oaVHXydH6O+xuSDglwrSiheVGCCsbgPN6+hvmbpJNJ6/qeI0h65Nf+4jikkZ1V7nzlDCIDI0cq
	/clSEPpPUtlCe0k82WsGU/R9hgybHwuVXgk03grfmVRJ4MfDQyNIp1Hq29foCp7omzpQi5NWSLv
	upP0J1mj9sFIgKB32URB7idZJMJe0MrMxITv3+2Mpu2y6/okRloIavQbaqRVHs3CI3R950BP2C0
	dqRW6EVU=
X-Google-Smtp-Source: AGHT+IHbRwHolfCy/K21M5p8TMVyGNeYSzD1JlzwFOPMNhCc97+J4+xPD9djkEo69jqqzpUx7NZntw==
X-Received: by 2002:a05:600c:3b01:b0:44a:b793:9e4f with SMTP id 5b1f17b1804b1-451f0b101c8mr56034845e9.19.1749116755931;
        Thu, 05 Jun 2025 02:45:55 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9924a41sm18919245e9.40.2025.06.05.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 02:45:55 -0700 (PDT)
Message-ID: <68416753.050a0220.1b2d45.505c@mx.google.com>
X-Google-Original-Message-ID: <aEFnUAqQcszKZ7Sl@Ansuel-XPS.>
Date: Thu, 5 Jun 2025 11:45:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v13] pwm: airoha: Add support for EN7581 SoC
References: <20250509223653.8800-1-ansuelsmth@gmail.com>
 <ndntz3ttiosqmduyg5lur6m2rdsg7zbiyrkxjhzknml5bprd4r@76wu76ddp4uj>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ndntz3ttiosqmduyg5lur6m2rdsg7zbiyrkxjhzknml5bprd4r@76wu76ddp4uj>

On Tue, Jun 03, 2025 at 06:57:36PM +0200, Uwe Kleine-König wrote:
> On Sat, May 10, 2025 at 12:36:52AM +0200, Christian Marangi wrote:
> > diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> > new file mode 100644
> > index 000000000000..eaf946a53c81
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-airoha.c
> > @@ -0,0 +1,536 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> > + *
> > + *  Limitations:
> > + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> > + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> > + *    pins and 17 SIPO GPIO pins.
> > + *  - Supports only normal polarity.
> > + *  - On configuration the currently running period is completed.
> > + *  - Minimum supported period is 4ms
> > + *  - Maximum supported period is 1s
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define AIROHA_PWM_REG_SGPIO_LED_DATA		0x0024
> > +#define AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> > +#define AIROHA_PWM_SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> > +
> > +#define AIROHA_PWM_REG_SGPIO_CLK_DIVR		0x0028
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR		GENMASK(1, 0)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_32		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_16		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x2)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_8		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x1)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_4		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x0)
> > +
> > +#define AIROHA_PWM_REG_SGPIO_CLK_DLY		0x002c
> > +
> > +#define AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG	0x0030
> > +#define AIROHA_PWM_SERIAL_GPIO_FLASH_MODE	BIT(1)
> > +#define AIROHA_PWM_SERIAL_GPIO_MODE_74HC164	BIT(0)
> > +
> > +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (4 * (_n)))
> > +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(_n) (16 * (_n))
> > +#define AIROHA_PWM_GPIO_FLASH_PRD_LOW		GENMASK(15, 8)
> > +#define AIROHA_PWM_GPIO_FLASH_PRD_HIGH		GENMASK(7, 0)
> > +
> > +#define AIROHA_PWM_REG_GPIO_FLASH_MAP(_n)	(0x004c + (4 * (_n)))
> > +#define AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(_n) (4 * (_n))
> > +#define AIROHA_PWM_GPIO_FLASH_EN		BIT(3)
> > +#define AIROHA_PWM_GPIO_FLASH_SET_ID		GENMASK(2, 0)
> > +
> > +/* Register map is equal to GPIO flash map */
> > +#define AIROHA_PWM_REG_SIPO_FLASH_MAP(_n)	(0x0054 + (4 * (_n)))
> > +
> > +#define AIROHA_PWM_REG_CYCLE_CFG_VALUE(_n)	(0x0098 + (4 * (_n)))
> > +#define AIROHA_PWM_REG_CYCLE_CFG_SHIFT(_n)	(8 * (_n))
> > +#define AIROHA_PWM_WAVE_GEN_CYCLE		GENMASK(7, 0)
> > +
> > +/* GPIO/SIPO flash map handles 8 pins in one register */
> > +#define AIROHA_PWM_PINS_PER_FLASH_MAP		8
> > +/* Cycle cfg handles 4 generators in one register */
> > +#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4
> > +/* Flash producer handles 2 generators in one register */
> > +#define AIROHA_PWM_BUCKET_PER_FLASH_PROD	2
> > +
> > +#define AIROHA_PWM_NUM_BUCKETS			8
> > +/*
> > + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
> > + * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
> > + * However, we've only got 8 concurrent waveform generators and can therefore
> > + * only use up to 8 different combinations of duty cycle and period at a time.
> > + */
> > +#define AIROHA_PWM_NUM_GPIO			16
> > +#define AIROHA_PWM_NUM_SIPO			17
> > +#define AIROHA_PWM_MAX_CHANNELS			(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_SIPO)
> > +
> > +struct airoha_pwm_bucket {
> > +	/* Bitmask of PWM channels using this bucket */
> > +	u64 used;
> > +	u64 period_ns;
> > +	u64 duty_ns;
> > +};
> > +
> > +struct airoha_pwm {
> > +	struct regmap *regmap;
> > +
> > +	u64 initialized;
> > +
> > +	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> > +
> > +	/* Cache bucket used by each pwm channel */
> > +	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> > +};
> > +
> > +/* The PWM hardware supports periods between 4 ms and 1 s */
> > +#define AIROHA_PWM_PERIOD_TICK_NS	(4 * NSEC_PER_MSEC)
> > +#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> > +/* It is represented internally as 1/250 s between 1 and 250. Unit is ticks. */
> > +#define AIROHA_PWM_PERIOD_MIN		1
> > +#define AIROHA_PWM_PERIOD_MAX		250
> > +/* Duty cycle is relative with 255 corresponding to 100% */
> > +#define AIROHA_PWM_DUTY_FULL		255
> > +
> > +static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> > +						    u32 *addr, u32 *shift)
> > +{
> > +	unsigned int offset, hwpwm_bit;
> > +
> > +	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> > +		unsigned int sipohwpwm = hwpwm - AIROHA_PWM_NUM_GPIO;
> > +
> > +		offset = sipohwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +		hwpwm_bit = sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +
> > +		/* One FLASH_MAP register handles 8 pins */
> > +		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> > +		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> > +	} else {
> > +		offset = hwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +		hwpwm_bit = hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +
> > +		/* One FLASH_MAP register handles 8 pins */
> > +		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> > +		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> > +	}
> > +}
> > +
> > +static u32 airoha_pwm_get_period_ticks_from_ns(u64 period_ns)
> > +{
> > +	return div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > +}
> > +
> > +static u32 airoha_pwm_get_duty_ticks_from_ns(u64 period_ns, u64 duty_ns)
> > +{
> > +	return mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > +				   period_ns);
> > +}
> > +
> > +static void airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
> > +				  u64 *period_ns, u64 *duty_ns)
> > +{
> > +	u32 period_tick, duty_tick;
> > +	unsigned int offset;
> > +	u32 shift, val;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
> > +
> > +	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> > +	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +		    &val);
> > +
> > +	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> > +	/*
> > +	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
> > +	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
> > +	 * u64.
> > +	 */
> > +	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
> > +}
> > +
> > +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> > +				    u64 period_ns)
> > +{
> > +	int i, best = -ENOENT, unused = -ENOENT;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> > +		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> > +		u32 duty_ticks, duty_ticks_bucket;
> > +
> > +		/* If found, save an unused bucket to return it later */
> > +		if (!bucket->used && unused == -ENOENT) {
> > +			unused = i;
> > +			continue;
> > +		}
> > +
> > +		if (duty_ns == bucket->duty_ns) {
> > +			/* We found a matching bucket */
> > +			if (period_ns == bucket->period_ns)
> > +				return i;
> > +
> > +			/*
> > +			 * Save a bucket for later that is not bigger than the
> > +			 * requested period_ns (to be used if we don't have
> > +			 * any unused bucket)
> > +			 */
> > +			if (bucket->period_ns <= period_ns)
> > +				best = i;
> 
> So if there is no free bucket but two used ones that have the right duty
> and a period <= the requested period, the bucket with the highest index
> is used. That is wrong. This has to be something like:
> 
> 	unused = -ENOENT;
> 	best = -ENOENT;
> 
> 	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> 		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> 		u64 bucket_period_ns = bucket->period_ns;
> 		u64 bucket_duty_ns = bucket->duty_ns;
> 
> 		if (!bucket->used) {
> 			unused = i;
> 			continue;
> 		}
> 
> 		/* With a 100% relative duty the actual period doesn't matter */
> 		if (bucket_period_ns == bucket_duty_ns) {
> 			bucket_period_ns = period_ns;
> 			bucket_duty_ns = period_ns;
> 		}
> 
> 		if (bucket_period_ns == period_ns &&
> 		    bucket_duty_ns == duty_ns)
> 			/* exact match */
> 			return i;
> 
> 		/*
> 		 * If we already found an unused bucket we're only
> 		 * interested in exact matches and so can skip the rest
> 		 * of the loop.
> 		 */
> 		if (unused >= 0)
> 			continue;
> 
> 		/* Don't consider invalid configs */
> 		if (bucket_period_ns > period_ns ||
> 		    bucket_duty_ns > duty_ns)
> 			continue;
> 
> 		if (best < 0) {
> 			best = i;
> 		} else {
> 			struct airoha_pwm_bucket *best_bucket = &pc->buckets[best];
> 			u64 best_period_ns = best_bucket->period_ns;
> 			u64 best_duty_ns = best_bucket->duty_ns;
> 
> 			if (best_period_ns == best_duty_ns) {
> 				best_period_ns = period_ns;
> 				best_duty_ns = period_ns;
> 			}
> 
> 			if (
> 			    (bucket_period_ns == best_bucket_period_ns && bucket_duty_ns > best_bucket_duty_ns && bucket_duty_ns <= duty_ns) ||
> 
> 			    (bucket_period_ns > best_bucket_period_ns && bucket_period_ns <= period_ns))
> 				best = i;
> 		}
> 	}
> 
> 	return unused == -ENOENT ? best : unused;
> 
> It took me a while to come up with that, and it's completely untested.
>

Mhhh it looks quite confusing. Also just to understand and looking at
the PWM core, we should search for the bucket that is both closer to the
requested duty and the requested period correct? In v12 I was with the
idea that only period had to be closer.

Anyway do you think this alternative version can work? I applied a more
simple logic.

static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
				    u64 period_ns)
{
	unsigned long best_bucket_diff = ULONG_MAX;
	int i, best = -ENOENT, unused = -ENOENT;

	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
		unsigned long duty_diff, period_diff, bucket_diff;
		u64 bucket_period_ns = bucket->period_ns;
		u64 bucket_duty_ns = bucket->duty_ns;
		u32 duty_ticks, duty_ticks_bucket;

		/* If found, save an unused bucket to return it later */
		if (!bucket->used && unused == -ENOENT) {
			unused = i;
			continue;
		}

		/* We found a matching bucket, exit early */
		if (duty_ns == bucket_duty_ns &&
		    period_ns == bucket_period_ns)
		    	return i;

		/*
		 * Unlike duty cycle zero, which can be handled by
		 * disabling PWM, a generator is needed for full duty
		 * cycle but it can be reused regardless of period
		 */
		duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
		duty_ticks_bucket = airoha_pwm_get_duty_ticks_from_ns(bucket_period_ns,
								      bucket_duty_ns);
		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
		    duty_ticks_bucket == AIROHA_PWM_DUTY_FULL)
			return i;

		/*
		 * With an unused bucket available, skip searching for
		 * a bucket to recycle (closer to the requested period/duty)
		 */
		if (unused != -ENOENT)
			continue;

		/* Ignore bucket with invalid configs */
		if (bucket_period_ns > period_ns ||
		    bucket_duty_ns > duty_ns)
			continue;

		/*
		 * Search for a bucket closer to the requested period/duty
		 * following this logic:
		 *  1. Calculate the bucket period diff from the requested period
		 *  2. Calculate the duty period diff from the requested duty
		 *  3. Sum the 2 diff
		 *  4. Search for the bucket that have the minor diff across all
		 *     buckets.
		 */
		period_diff = period_ns - bucket_period_ns;
		duty_diff = duty_ns - bucket_duty_ns;
		bucket_diff = period_diff + duty_diff;

		/* Save the best found bucket as we test each one */
		if (bucket_diff < best_bucket_diff) {
			best_bucket_diff = bucket_diff;
			best = i;
		}
	}

	/* With no unused bucket, return the best one found (if ever) */
	return unused == -ENOENT ? best : unused;
}

This way we should search all the bucket and find the one that is closer
to the target by both duty and period.

> > +		}
> > +
> > +		/*
> > +		 * Unlike duty cycle zero, which can be handled by
> > +		 * disabling PWM, a generator is needed for full duty
> > +		 * cycle but it can be reused regardless of period
> > +		 */
> > +		duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > +		duty_ticks_bucket = airoha_pwm_get_duty_ticks_from_ns(bucket->period_ns,
> > +								      bucket->duty_ns);
> > +		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
> > +		    duty_ticks_bucket == AIROHA_PWM_DUTY_FULL)
> > +			return i;
> > +	}
> > +
> > +	/* With no unused bucket, return the best one found (if ever) */
> > +	return unused == -ENOENT ? best : unused;
> > +}
> > +
> > +static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
> > +					     unsigned int hwpwm)
> > +{
> > +	int bucket;
> > +
> > +	/* Nothing to clear, PWM channel never used */
> > +	if (!(pc->initialized & BIT_ULL(hwpwm)))
> > +		return;
> > +
> > +	bucket = pc->channel_bucket[hwpwm];
> > +	pc->buckets[bucket].used &= ~BIT_ULL(hwpwm);
> > +}
> > +
> > +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> > +					u64 duty_ns, u64 period_ns,
> > +					unsigned int hwpwm)
> > +{
> > +	int bucket;
> > +
> > +	/*
> > +	 * Search for a bucket that already satisfy duty and period
> > +	 * or an unused one.
> > +	 * If not found, -ENOENT is returned.
> > +	 */
> > +	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
> > +	if (bucket < 0)
> > +		return bucket;
> > +
> > +	airoha_pwm_release_bucket_config(pc, hwpwm);
> > +	pc->buckets[bucket].used |= BIT_ULL(hwpwm);
> > +	pc->buckets[bucket].period_ns = period_ns;
> > +	pc->buckets[bucket].duty_ns = duty_ns;
> 
> pc->buckets[bucket].period_ns and pc->buckets[bucket].duty_ns should
> only get assigned if pc->buckets[bucket].used == 0.
> 

Yesp micro optimization but I changed the logic. Also I notice releasing
the bucket is not useful in this function.

> > +
> > +	return bucket;
> > +}
> > +
> > +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> > +{
> > +	u32 val;
> > +
> > +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +		return 0;
> > +
> > +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +			  AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
> > +
> > +	/* Configure shift register chip clock timings, use 32x divisor */
> > +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
> > +		     AIROHA_PWM_SGPIO_CLK_DIVR_32);
> > +
> > +	/*
> > +	 * Configure the shift register chip clock delay. This needs
> > +	 * to be configured based on the chip characteristics when the SoC
> > +	 * apply the shift register configuration.
> > +	 * This doesn't affect actual PWM operation and is only specific to
> > +	 * the shift register chip.
> > +	 *
> > +	 * For 74HC164 we set it to 0.
> > +	 *
> > +	 * For reference, the actual delay applied is the internal clock
> > +	 * feed to the SGPIO chip + 1.
> > +	 *
> > +	 * From documentation is specified that clock delay should not be
> > +	 * greater than (AIROHA_PWM_REG_SGPIO_CLK_DIVR / 2) - 1.
> > +	 */
> > +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> > +
> > +	/*
> > +	 * It is necessary to explicitly shift out all zeros after muxing
> > +	 * to initialize the shift register before enabling PWM
> > +	 * mode because in PWM mode SIPO will not start shifting until
> > +	 * it needs to output a non-zero value (bit 31 of led_data
> > +	 * indicates shifting in progress and it must return to zero
> > +	 * before led_data can be written or PWM mode can be set)
> > +	 */
> > +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +				     10, 200 * USEC_PER_MSEC))
> > +		return -ETIMEDOUT;
> > +
> > +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,
> > +			  AIROHA_PWM_SGPIO_LED_DATA_DATA);
> > +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +				     10, 200 * USEC_PER_MSEC))
> > +		return -ETIMEDOUT;
> > +
> > +	/* Set SIPO in PWM mode */
> > +	regmap_set_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +			AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> > +
> > +	return 0;
> > +}
> > +
> > +static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int bucket,
> > +					  u64 duty_ns, u64 period_ns)
> > +{
> > +	u32 period_ticks, duty_ticks;
> > +	u32 mask, shift, val;
> > +	u64 offset;
> > +
> > +	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
> > +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	/* Configure frequency divisor */
> > +	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), mask, val);
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	/* Configure duty cycle */
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +			   mask, val);
> > +
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> > +			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +			   mask, val);
> > +}
> > +
> > +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> > +					unsigned int hwpwm, int index)
> > +{
> > +	unsigned int addr;
> > +	u32 shift;
> > +
> > +	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
> > +
> > +	/* index -1 means disable PWM channel */
> > +	if (index < 0) {
> > +		/*
> > +		 * If we need to disable the PWM, we just put low the
> > +		 * GPIO. No need to setup buckets.
> > +		 */
> > +		regmap_clear_bits(pc->regmap, addr,
> > +				  AIROHA_PWM_GPIO_FLASH_EN << shift);
> > +		return;
> > +	}
> > +
> > +	regmap_update_bits(pc->regmap, addr,
> > +			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
> > +			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
> > +	regmap_set_bits(pc->regmap, addr, AIROHA_PWM_GPIO_FLASH_EN << shift);
> > +}
> > +
> > +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
> > +			     u64 duty_ns, u64 period_ns)
> > +{
> > +	unsigned int hwpwm = pwm->hwpwm;
> > +	int bucket;
> > +
> > +	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> > +					      hwpwm);
> > +	if (bucket < 0)
> > +		return -EBUSY;
> > +
> > +	airoha_pwm_calc_bucket_config(pc, bucket, duty_ns, period_ns);
> > +	airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> 
> If a bucket is reused, the configuration doesn't need to be
> recalculated.
> 

Yep you are right, I moved the calc_bucket_config in the
consume_generator. (the config_flash_map is still used to assign the
hwpwm to the generator/bucket)

> > +	pc->initialized |= BIT_ULL(hwpwm);
> > +	pc->channel_bucket[hwpwm] = bucket;
> > +
> > +	/*
> > +	 * SIPO are special GPIO attached to a shift register chip. The handling
> > +	 * of this chip is internal to the SoC that takes care of applying the
> > +	 * values based on the flash map. To apply a new flash map, it's needed
> > +	 * to trigger a refresh on the shift register chip.
> > +	 * If we are configuring a SIPO, always reinit the shift register chip
> > +	 * to make sure the correct flash map is applied.
> > +	 * We skip reconfiguring the shift register if we related hwpwm
> > +	 * is disabled (as it doesn't need to be mapped).
> > +	 */
> > +	if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >= AIROHA_PWM_NUM_GPIO)
> > +		airoha_pwm_sipo_init(pc);
> > +
> > +	return 0;
> > +}
> > +
> > +static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
> > +{
> > +	/* Disable PWM and release the bucket */
> > +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> > +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> > +
> > +	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
> > +
> > +	/* If no SIPO is used, disable the shift register chip */
> > +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> > +}
> > +
> > +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> > +	u64 duty_ns = state->duty_cycle;
> > +	u64 period_ns = state->period;
> > +
> > +	/* Only normal polarity is supported */
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		airoha_pwm_disable(pc, pwm);
> > +		return 0;
> > +	}
> 
> Maybe swap the two ifs to ensure that disabling always works.
> 

Done.

> > +	/* Exit early if period is less than minimum supported */
> > +	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Period goes at 4ns step, normalize it to check if we can
> > +	 * share a generator.
> > +	 */
> > +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> 
> Do the same for duty_ns?
> 

Duty is in % so we really can't round it. Am I wrong?

> > +	/* Clamp period to MAX supported value */
> > +	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS) {
> > +		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
> > +
> > +		if (duty_ns > period_ns)
> > +			duty_ns = period_ns;
> > +	}
> > +
> > +	return airoha_pwm_config(pc, pwm, duty_ns, period_ns);
> > +}
> 
> Best regards
> Uwe



-- 
	Ansuel

