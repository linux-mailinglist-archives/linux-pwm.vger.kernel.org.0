Return-Path: <linux-pwm+bounces-5353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEAA7DAA8
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF4C16FE44
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638D22FF2E;
	Mon,  7 Apr 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBMUvYk4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D6204F94;
	Mon,  7 Apr 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020184; cv=none; b=OATMTHQnJwfzpahEOszMW0tPFxhMcER0D8PD0o/00j0HfloG9Xr7nHe4b/BtW/hzWnC9wtYRYyFMKDQmzx6qj07PtMo96N6vsnxSNacd1Yh0BijgeOOPK04pRz/ZiXvXFd4D1ZRvd/fvf8zLJ52Ay9KCspcRt939RymrrybZ0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020184; c=relaxed/simple;
	bh=w78LXxApCj4OTSgjgaM64oKrRjxrGY8VBQ8Wzi/jdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbSVzExHjat/XuXSvxqxqN/V6QqT6YeaZkMp/15OSF99m2AdyNmmSeKKQfHHjveHwpfZQd4MBT/oXtY+/m4RGlDPcdpuGxL9+nQrtp2GA+8Zm8r+Aq69AieDqCVyqBkQsgQkDlN1H8E3ZtmHTkN5XT5qnC72wCZJZFaqekBhBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBMUvYk4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c3e7b390so3547108b3a.2;
        Mon, 07 Apr 2025 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744020181; x=1744624981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RACmTc9Rgs7JJUW7G658o4PTbUfl18GoBK9O7BQsyEY=;
        b=gBMUvYk4Src6BikFjggOsV5Jo8l+ndhF05fKNqfStz2Ofr3tsZijwKOeT/bk8nKkBh
         dVuvkkLhcQYbj9VqvCQogXOXfDC83/S8UfMikMTka09JdbKu2LsIDG7WLzTyr13Nfvli
         6E2pWU5VC5w516zNOnwN9MnIGFQfQDSy+LTciKWLEHqNJFrzvPxZNBnOFmMjgI9/k7RY
         R/ONPySuIj6TuxlpTrPQaYJ2d+XlsLfVPl+Y0bu1BHJyc06Kq0THJkPs0Z9IIGX1s2WH
         IF7mnyfrQsltNiNA1oxdVt+dePVR6SjtrVFN3PuDQSUO4JgbFZiV+6Q6hozrM339L9Wb
         vEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744020181; x=1744624981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RACmTc9Rgs7JJUW7G658o4PTbUfl18GoBK9O7BQsyEY=;
        b=YSCdpByEdMoCOgy9eMt5TbB6KRNGggWOrZplnVTbjAURUx5M4ieWj+p4czZmlQdJ+9
         SVU/O7E9XviCzaMHohgz96whIorT9elxmWqHZJeoW+Ba9CoWsRNMONlCCkwhXxWWm4f4
         C7zY1+Ow6o6dYUhgTqG3q9u2v+YE8Rr0oOGUEN5NUoq/EzeLWXJME1zzSSWfVXWkq1D6
         uQfEqnid7bl1XBbJbP6TIBVC9nk6eiuhOy+HYpl1iv9coMtZqwyoqI79An7+CJYURRk4
         OaMea9oOW+M9yD6bjJvEIQYrMoXryanZaiqHtqdbeeA9WUV07hRPBfvVy56nZE0qBRyu
         Syyw==
X-Forwarded-Encrypted: i=1; AJvYcCUKS8ssAZTMfy48n3RZ/3cpxdxwPS1b90flyf3KX+/m1UVyqhNJqiZf1nFNQeRrcmCoKg3vz52iGzM7@vger.kernel.org, AJvYcCUgv/pWCBA6d4ijXlZIZxrcnzfRSWMLODbHtislYEMws/hnaX9dNiOX+He4BGyA6AyNkRgyVyxrOf67@vger.kernel.org, AJvYcCX8l8e3FeqzgLWM9W+Zyc99lAdPHx1CnVfwfI+y4meAIp+SE/12YfZVNJJAwN0ttaq1+x4w48YaXd3Q3aLC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TzC2O3/W0ThX9uv1TP/9uKlgLiEqRCIhIqqlkh94tka49rXf
	/uwxoXKCAh5qni3JyZIpTsBBbURz1WPMVBWdJfw/+Gk4qJFH8n+b
X-Gm-Gg: ASbGnctBDY5a38OTQhpilifjbUIDHillaPfRMZ3EtpcWlRGT+Bs7uSeq0L5v42QRsJr
	vGD2T8+pWewyNsiKcrtzihaCraoLgwAMlB2ArFtuOlYaMnDhKmm7zTtaKYUIVRZ5qPLVmZHD1ma
	80O93AoR+8rb+C6suHxbPrVkN0gl4z9xG+mISMSR6gLTPtd9uhLAHIB9wB2qfDlPgAnFcdbquUy
	xx++94fcEGFvr3s+6bR3gVRNNlzzbGAtH6qPGleMLUKcbROyzY69Mljeny2zvXugYg92p4szzbC
	N71kHNsiJ9xK3AZ/AXWHb/7E7s1+En7h/ldtNMKU1ko9qg==
X-Google-Smtp-Source: AGHT+IGoAl7RP6vz9q7ZNLerCe+QiTDOPUWcDP8mG3WjvZ3rSUZqx0QcgAvTWNBxY4h5EHMN4sK3VA==
X-Received: by 2002:a05:6a00:179e:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-739e6e6fb3cmr13738787b3a.0.1744020181171;
        Mon, 07 Apr 2025 03:03:01 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739da0b45b4sm8086532b3a.151.2025.04.07.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:03:00 -0700 (PDT)
Date: Mon, 7 Apr 2025 18:02:57 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for SG2044
Message-ID: <jd46vvxgrmpk7dhaogio6wsut4l7keshhujw6k3kw2enodgwiw@wtaxbwgaykrr>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-3-looong.bin@gmail.com>
 <jnvlo3su4xzsvzte2s3noosycxae5uxhi3vusefpgq462ymqst@jgta6xxmcbtd>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jnvlo3su4xzsvzte2s3noosycxae5uxhi3vusefpgq462ymqst@jgta6xxmcbtd>

On Mon, Apr 07, 2025 at 11:38:27AM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 07, 2025 at 03:20:39PM +0800, Longbin Li wrote:
> > From: ghost <2990955050@qq.com>
> 
> Huh, is that a real name?
>

My fault,i will change it.
 
> > Add PWM controller for SG2044.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >  drivers/pwm/pwm-sophgo-sg2042.c | 162 +++++++++++++++++++++++++++-----
> >  1 file changed, 138 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> > index ff4639d849ce..c62e8c758d87 100644
> > --- a/drivers/pwm/pwm-sophgo-sg2042.c
> > +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> 
> The Limitations paragraph needs updating. E.g. SG2044 seems to support
> polarity while SG2042 doesn't.
> 

Thanks,i will add that.

> > @@ -26,20 +26,22 @@
> >  #include <linux/pwm.h>
> >  #include <linux/reset.h>
> > 
> > -/*
> > - * Offset RegisterName
> > - * 0x0000 HLPERIOD0
> > - * 0x0004 PERIOD0
> > - * 0x0008 HLPERIOD1
> > - * 0x000C PERIOD1
> > - * 0x0010 HLPERIOD2
> > - * 0x0014 PERIOD2
> > - * 0x0018 HLPERIOD3
> > - * 0x001C PERIOD3
> > - * Four groups and every group is composed of HLPERIOD & PERIOD
> > - */
> > -#define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> > -#define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
> > +#define REG_HLPERIOD		0x0
> > +#define REG_PERIOD		0x4
> > +#define REG_GROUP		0x8
> 
> REG_GROUP belongs to a different category than REG_PERIOD. So please use
> a different schema to name it (or drop it, see below).
> 

I will improve it.

> > +#define REG_POLARITY		0x40
> > +
> > +#define REG_PWMSTART		0x44
> > +#define REG_PWMUPDATE		0x4C
> > +#define REG_SHIFTCOUNT		0x80
> > +#define REG_SHIFTSTART		0x90
> 
> REG_SHIFTCOUNT and REG_SHIFTSTART are unused.
> 

I will drop it.

> > +#define REG_PWM_OE		0xD0
> 
> Actually I liked the old prefix better. E.g. "REG_POLARITY" looks more
> generic that it actually is.
> 

I will reconsider that.

> > +
> > +#define PWM_REG_NUM		0x80
> 
> This is unused?
> 

I will drop it,thanks!

> > +
> > +#define PWM_POLARITY_MASK(n) BIT(n)
> > +#define PWM_HLPERIOD(chan) ((chan) * REG_GROUP + REG_HLPERIOD)
> > +#define PWM_PERIOD(chan) ((chan) * REG_GROUP + REG_PERIOD)
> 
> ((chan) * 8 + 0) is IMHO better. I guess this is subjective because at
> least the *8 is repeated several times, but the advantage of not using a
> define for 8 (and 0 and 4) is that by looking at
> 
> 	#define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> 
> you immediatly see the offsets of the HLPERIOD register, while for
> 
> 	#define PWM_HLPERIOD(chan) ((chan) * REG_GROUP + REG_HLPERIOD)
> 
> you have to lookup two additional symbols.
> 
> Also PWM is a prefix that is too generic.
> 

I will reconsider that.

> >  #define SG2042_PWM_CHANNELNUM	4
> > 
> > @@ -51,6 +53,12 @@
> >  struct sg2042_pwm_ddata {
> >  	void __iomem *base;
> >  	unsigned long clk_rate_hz;
> > +	struct mutex lock;
> 
> What does this lock protect? Note that there is a chip lock that is held
> when .apply() is called, to serialize apply calls for a single chip. I
> guess this can and should be dropped.
> 

I will retest it, and if possible i will drop it, thanks.

> > +};
> > +
> > +struct sg2042_chip_data {
> > +	const struct pwm_ops ops;
> > +	bool atomic;
> >  };
> > 
> >  /*
> > @@ -62,8 +70,8 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
> >  {
> >  	void __iomem *base = ddata->base;
> > 
> > -	writel(period_ticks, base + SG2042_PWM_PERIOD(chan));
> > -	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
> > +	writel(period_ticks, base + PWM_PERIOD(chan));
> > +	writel(hlperiod_ticks, base + PWM_HLPERIOD(chan));
> 
> The register renaming adds really quite some noise that is actually
> unrelated to this patch. If you really think the register defines need
> renaming, do that in a separate patch (and justify it well).
> 

Sorry, i will modify here.

> >  }
> > 
> >  static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > @@ -104,8 +112,8 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	u32 hlperiod_ticks;
> >  	u32 period_ticks;
> > 
> > -	period_ticks = readl(ddata->base + SG2042_PWM_PERIOD(chan));
> > -	hlperiod_ticks = readl(ddata->base + SG2042_PWM_HLPERIOD(chan));
> > +	period_ticks = readl(ddata->base + PWM_PERIOD(chan));
> > +	hlperiod_ticks = readl(ddata->base + PWM_HLPERIOD(chan));
> > 
> >  	if (!period_ticks) {
> >  		state->enabled = false;
> > @@ -123,13 +131,112 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	return 0;
> >  }
> > 
> > -static const struct pwm_ops pwm_sg2042_ops = {
> > -	.apply = pwm_sg2042_apply,
> > -	.get_state = pwm_sg2042_get_state,
> > +static void pwm_sg2044_config(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm, bool enabled)
> > +{
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + REG_PWMSTART);
> > +
> > +	if (enabled)
> > +		writel(pwm_value | BIT(pwm->hwpwm), ddata->base + REG_PWMSTART);
> > +	else
> > +		writel(pwm_value & ~BIT(pwm->hwpwm), ddata->base + REG_PWMSTART);
> > +}
> > +
> > +static void pwm_sg2044_set_outputenable(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
> > +					bool enabled)
> > +{
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + REG_PWM_OE);
> > +
> > +	if (enabled)
> > +		writel(pwm_value | BIT(pwm->hwpwm), ddata->base + REG_PWM_OE);
> > +	else
> > +		writel(pwm_value & ~BIT(pwm->hwpwm), ddata->base + REG_PWM_OE);
> > +}
> > +
> > +static int pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
> > +				   const struct pwm_state *state)
> > +{
> > +	enum pwm_polarity polarity;
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + REG_POLARITY);
> > +
> > +	polarity = state->polarity;
> > +
> > +	if (polarity == PWM_POLARITY_NORMAL)
> > +		pwm_value &= ~BIT(pwm->hwpwm);
> > +	else
> > +		pwm_value |= BIT(pwm->hwpwm);
> > +
> > +	writel(pwm_value, ddata->base + REG_POLARITY);
> 
> I like this idiom better than the one used in
> pwm_sg2044_set_outputenable() and pwm_sg2044_config(). However drop the
> local variable polarity.
> 

I will modify that, thanks.

> > +	return 0;
> > +}
> > +
> > +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> > +	u32 hlperiod_ticks;
> > +	u32 period_ticks;
> > +
> > +	if (!state->enabled) {
> > +		pwm_sg2044_config(ddata, pwm, false);
> > +		return 0;
> > +	}
> > +
> > +	pwm_sg2044_set_polarity(ddata, pwm, state);
> > +
> > +	/*
> > +	 * Duration of High level (duty_cycle) = HLPERIOD x Period_of_input_clk
> > +	 * Duration of One Cycle (period) = PERIOD x Period_of_input_clk
> > +	 */
> > +	period_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period,
> > +					       NSEC_PER_SEC), U32_MAX);
> > +	hlperiod_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle,
> > +						 NSEC_PER_SEC), U32_MAX);
> 
> This is the same calculation as for sg2042. I think I'd put that in a
> function that is used by both variants.
> 

Thanks, i will modify that.

> > +	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=%u, HLPERIOD=%u\n",
> > +		pwm->hwpwm, period_ticks, hlperiod_ticks);
> 
> Now that there are more register values, please add them all to the
> debug output.
> 

I will, thanks.

> > +	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
> > +
> > +	guard(mutex)(&ddata->lock);
> > +
> > +	/*
> > +	 * re-enable PWMSTART to refresh the register period
> > +	 */
> > +	pwm_sg2044_config(ddata, pwm, false);
> 
> pwm_sg2044_config() is conceptually different to pwm_sg2042_config().
> This is irritating, so please find a better name.
> 

I will modify that, thanks.

> > +	pwm_sg2044_set_outputenable(ddata, pwm, true);
> > +	pwm_sg2044_config(ddata, pwm, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct sg2042_chip_data sg2042_chip_data = {
> > +	.ops = {
> > +		.apply = pwm_sg2042_apply,
> > +		.get_state = pwm_sg2042_get_state,
> > +	},
> > +	.atomic = true,
> > +};
> > +
> > +static const struct sg2042_chip_data sg2044_chip_data = {
> > +	.ops = {
> > +		.apply = pwm_sg2044_apply,
> > +		.get_state = pwm_sg2042_get_state,
> > +	},
> > +	.atomic = false,
> 
> If you drop the mutex don't forget to drop this one, too.
> 

I will, thanks for your reminder.

> >  };
> 
> Best regards
> Uwe

Best regards
Longbin Li

