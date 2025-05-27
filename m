Return-Path: <linux-pwm+bounces-6136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C8AC45EE
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EC0179C15
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BB12B17C;
	Tue, 27 May 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMkE4d+E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F22CA9;
	Tue, 27 May 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309606; cv=none; b=YKBdOa5I/qNJB5mPyt8ZE3+cmQ5ol5O8yLSi5VVYnHU/9Cc33uMDYZf2pHO14xjLoCj8yDE0iXCqWn3XeaTe0JulLgqMzBdQ76woV0Xyt5IXPuHZj3iXyQuj8VLUMX+NyOXqPDMbu9busd2KzR5BE+QJNDnKxmt/2xPM/VYsF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309606; c=relaxed/simple;
	bh=3fzKUvCqrlK4HhYELjN5TpIfmG/9FcTorzD9b6D+M4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/xrV70GypjuizBw3rQmN7LkEcVGmklvsZ5hkPnwLrACGvFQLzCl8+0wCG5U0zvAixiHCGFHR0lAeavgPm8t+VG7hEp25kCpAAs3LvoNH7pnE6MUHtsqpavZQHt6HrgOLG6ixnjeEXE5JOXO99OeLFfqtPAmfFv43X5NxBC87tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMkE4d+E; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31118251071so1588086a91.1;
        Mon, 26 May 2025 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748309603; x=1748914403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OvJ3qRY7vvlwo6L+qtgNdDTxVIpt1gweYQIVKsNpVWw=;
        b=ZMkE4d+EEN2fAFYYGkKuuc441PQlCuBuu5uBrlFhMiA7fuOeTNZL5nqiT+iQS2/beg
         CnqFJpeQM/FLzSzB8jCWULcKOjFCqy4BS7GPptJG136G84AIYhOHf61zsrjlxLKc+gY8
         zJ4Z9YiTIajM58EFCXXZmIZBfQa5m+w4XSSFmEXGAUlPhOgFgF4ALwHxr+e0R6pP8omt
         QueMLARb2/zjkl3YwxRZUhEjfs0T2eJUY5cW4fSzEDPiMNmzigElKXgiN2YARS55JQFP
         9Jt5yE8ap+pDtbseru7wVz9EYtUWPt+9oElkKlAJDafVNhIxILPQQjTlhIhCDQIpk1TO
         zpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748309603; x=1748914403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvJ3qRY7vvlwo6L+qtgNdDTxVIpt1gweYQIVKsNpVWw=;
        b=dA6kibkeKJn4HGCUCTj7qfFYF+PeCbKUfCE3DXxR+T4jc9ftKgXH/0iL60wrJzPAaE
         uk+O0Dk7E0caTk5NxPfjS/QoboRCAO7e7A/0T1eM0whrNAONwJtkF+WueE7B47YOs5X3
         XHeFAlLy+nO01+1hiCVPDR7WzVxqkO/RXaVirRwoYbt5iLXOOQ6JggoNi0t/SC+ILFet
         EIBWNb4Etrq74gt6ZZ7VhuJxjPHYJQ+I5TBC4LJhWbjAtnSSZHq6sTYxJbyPZnUaZ6WP
         XQo4oM+RGCy6EkbO4EvMwq8gGH/UiNPFBtE61b0SKzsAsQPJ2osU6HEXTvjqx1zNa514
         wtNg==
X-Forwarded-Encrypted: i=1; AJvYcCUVi7Gi9LXWet6KD5GiYfR9n3EPTVt0wAv3o/dnokg4YSQ1hHBqD0Kt0M+5Cj1lV2WXRK1vwPqCbT4b@vger.kernel.org, AJvYcCXUaQ6L+CML6PdI0zvBxypzywXNo93O/sX1EpEJtIfXpP0o7K7A9+2nygCe+WyXD9uvxEQMyAmsYIqwzCTN@vger.kernel.org, AJvYcCXb5ByXGoK5J7Y6E6o+ikVKN7QT1Zw5A8G606yIOdujfrCk5f8hL2giK2Bh83s6nZjNt8S8+hQUNK7T@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqsia0lGWziz7Jp8o29vNBUDl+UPBsI7kKhqB8im0HHga0s26
	o3DRIQ3PUWfIIAGdb198I1QWmfh/oHifjzSDKfxvIptMulAlA1Imtans
X-Gm-Gg: ASbGncseBBctxI9RmDVaJCzJEt9i1CYW4khDMnBWHPJbQ5W+NkZCHpcvBRa2LGO/r27
	LNUQlwRaxwaCvwKEWGbhBoqjFaJ6ws5hTy7tRkOzNYn9D79DPIbO5/tVm+sJVle8xCgAt+Y8vF9
	iDLadsNCK/nzDls7RoFG4aasIVz8ITm7eZaeVeeTsSf2a0+G0mL2NRwzRdV8F7ybcMKGUr9ap/6
	grOWjb3WROSFfq19igTa3pICExfpP/DhDfGW8cMH5N0bkQmaBb6PQ6IVUPvFIrd5t93xUJ1uAGZ
	ueMIuEkhWPP1wnCSa4nwYyqEuvxsOMODrF4no112eBBc68Cfcn4X
X-Google-Smtp-Source: AGHT+IHIY+p1U9yGcxp85neZDiVtg1+leRzLjswY7T3Ox7/Uj83JLq+1T9pQYqyo3NpX7Ybgyie4yg==
X-Received: by 2002:a17:90b:5110:b0:311:9c9a:58e5 with SMTP id 98e67ed59e1d1-3119c9a5d30mr4363503a91.24.1748309602855;
        Mon, 26 May 2025 18:33:22 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-311a3f2eb6esm629071a91.22.2025.05.26.18.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 18:33:22 -0700 (PDT)
Date: Tue, 27 May 2025 09:33:20 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <xgk2ac6zkfs34coefjcrol3aklob7sn7ob6qerhzf7yfa3dqdo@b54syid35obp>
References: <20250428013501.6354-1-looong.bin@gmail.com>
 <20250428013501.6354-4-looong.bin@gmail.com>
 <jo4ustzbkswmeive5s4tepwhzeoeswa4knfihkzh6eylujeid4@dj2a2nzp2a5v>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jo4ustzbkswmeive5s4tepwhzeoeswa4knfihkzh6eylujeid4@dj2a2nzp2a5v>

On Mon, May 26, 2025 at 05:06:25PM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 28, 2025 at 09:34:50AM +0800, Longbin Li wrote:
> > Add PWM controller for SG2044 on base of SG2042.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >  drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 87 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> > index 23a83843ba53..5bb92c910540 100644
> > --- a/drivers/pwm/pwm-sophgo-sg2042.c
> > +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> > @@ -13,6 +13,9 @@
> >   *   the running period.
> >   * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
> >   *   be stopped and the output is pulled to high.
> > + * - SG2044 support polarity while SG2042 does not. When PWMSTART is
> > + *   false, POLARITY being NORMAL will make output being low,
> > + *   POLARITY being INVERSED will make output being high.
> 
> Without detailed knowledge about the hardware this isn't understandable.
> What is PWMSTART? I think this can just read:
> 
> 	SG2044 supports both polarities, SG2042 only normal polarity.
> 
> The rest is an implementation detail.
>

I will modify that, thanks.
 
> >   * See the datasheet [1] for more details.
> >   * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
> 
> This only describes SG2042, right? Can you please add a link for the new
> variant?
> 

Sorry, there is no public document for SG2044.

> >   */
> > @@ -26,6 +29,10 @@
> >  #include <linux/pwm.h>
> >  #include <linux/reset.h>
> > 
> > +#define SG2044_PWM_POLARITY		0x40
> > +#define SG2044_PWM_PWMSTART		0x44
> > +#define SG2044_PWM_OE			0xd0
> > +
> >  #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> >  #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
> > 
> > @@ -72,8 +79,8 @@ static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	period_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
> >  	hlperiod_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
> > 
> > -	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=%u, HLPERIOD=%u\n",
> > -		pwm->hwpwm, period_ticks, hlperiod_ticks);
> > +	dev_dbg(pwmchip_parent(chip), "chan[%u]: ENABLE=%u, PERIOD=%u, HLPERIOD=%u, POLARITY=%u\n",
> > +		pwm->hwpwm, state->enabled, period_ticks, hlperiod_ticks, state->polarity);
> > 
> >  	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
> >  }
> > @@ -123,6 +130,74 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	return 0;
> >  }
> > 
> > +static void pwm_sg2044_set_start(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
> > +				 bool enabled)
> > +{
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + SG2044_PWM_PWMSTART);
> 
> Please use a variable name that matches the register this is used for.
> 

I will fix that.

> > +	if (enabled)
> > +		pwm_value |= BIT(pwm->hwpwm);
> > +	else
> > +		pwm_value &= ~BIT(pwm->hwpwm);
> > +
> > +	writel(pwm_value, ddata->base + SG2044_PWM_PWMSTART);
> > +}
> > +
> > +static void pwm_sg2044_set_outputdir(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
> > +				     bool enabled)
> > +{
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + SG2044_PWM_OE);
> > +
> > +	if (enabled)
> > +		pwm_value |= BIT(pwm->hwpwm);
> > +	else
> > +		pwm_value &= ~BIT(pwm->hwpwm);
> > +
> > +	writel(pwm_value, ddata->base + SG2044_PWM_OE);
> > +}
> > +
> > +static void pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
> > +				    const struct pwm_state *state)
> > +{
> > +	u32 pwm_value;
> > +
> > +	pwm_value = readl(ddata->base + SG2044_PWM_POLARITY);
> > +
> > +	if (state->polarity == PWM_POLARITY_NORMAL)
> > +		pwm_value &= ~BIT(pwm->hwpwm);
> > +	else
> > +		pwm_value |= BIT(pwm->hwpwm);
> > +
> > +	writel(pwm_value, ddata->base + SG2044_PWM_POLARITY);
> > +}
> > +
> > +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> > +
> > +	pwm_sg2044_set_polarity(ddata, pwm, state);
> > +
> > +	pwm_set_dutycycle(chip, pwm, state);
> > +
> > +	/*
> > +	 * re-enable PWMSTART to refresh the register period
> > +	 */
> > +	pwm_sg2044_set_start(ddata, pwm, false);
> 
> I don't understand the effect of the START register. 
> 

PWMSTART[3:0] enable the output of the corresponding channel. Must re-enable
it to refresh the register period when changed the duty cycle. I will find 
a better name, thanks.

> > +	if (!state->enabled)
> > +		return 0;
> > +
> > +	pwm_sg2044_set_outputdir(ddata, pwm, true);
> > +	pwm_sg2044_set_start(ddata, pwm, true);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct sg2042_chip_data sg2042_chip_data = {
> >  	.ops = {
> >  		.apply = pwm_sg2042_apply,
> 
> Best regards
> Uwe



