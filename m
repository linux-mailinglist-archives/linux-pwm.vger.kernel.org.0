Return-Path: <linux-pwm+bounces-8607-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPoDItG54GmIlAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8607-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 12:28:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EB40CE90
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8CC30413BD
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82420399360;
	Thu, 16 Apr 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzDaiW1i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA307395DB9
	for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335258; cv=none; b=auG3PAcH6l9vnPTwko0BxRi8ZF4CavLUZuaW8dzRH/bFRH0IVx/ri9D6RUUI0QbvfgNJySPPPs34MfREVyZjuDPXF3IpZpIT322IaU+47y3kktIuEj9zC+ooyJmZsztKrKWViS8AKAjgbLpz76/NrhELFo4sOII54xEcH85sJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335258; c=relaxed/simple;
	bh=w9q388Vzqwl8rvLdEaZHWTqCR0j9/zn7j9pEumntPY4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3L9D2ty4140c125CTv66L9f49z4AJUJCDKL2uer+QcGBxSw3hHZ44M6+XTm+O4kxxkXXWyF4xAzEEbYov7Zd8uvUHjZLr+udc00uz32A4kMxpk8wTy6WAQi1plzWDJHj0yOKLxsMEm5tlHrFsCMIPKX/JFJe4JA8MgFxwTmTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzDaiW1i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so3873998f8f.2
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2026 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776335255; x=1776940055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HCRqhH2DLFveExlKyLVA9G9WBAn4h6tRZdd4chEffg=;
        b=bzDaiW1i5OZaAZnjzclrCjivvi/q76gjygkY5Rvg/nSfLF/MMJnasGzoK7uTsGA53J
         JR3l8j3byiAudfEGyhuUPwWhe0UlEIaFu6EBod8eb9m+r2hD3EjIbXxKRmV86oddNNRd
         yT9rQyrAMFqeOoCRWmlVgJ9XhHv63TXjfxOnNzTd9kGvPzql+5ZwkW5ROX+GkhG2uSGy
         gj4Ep14yZr23Dp+CJuSGUpr1FtKD5fkUludeKQ3N6XgLA6W8uU6KnB52TNO99YSrYLvk
         HN15BG6Nt4qbat0B5lwiaBc5dE/7behB1RwAxhrb93d4YQtO4XGjkU19d6hypjzgcUsS
         V+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335255; x=1776940055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HCRqhH2DLFveExlKyLVA9G9WBAn4h6tRZdd4chEffg=;
        b=Medy/vJnZqtTkqty5d4aDRxdV2ZobvoNaKsIZX4cHPMbvd0w4sAPmsp+ygY+xvpyMB
         YpfeXnfg9uuwsn+ETawoN52SNOoyxR/ajXcHKkiGl+TUQOjVB1SON6MXD4Yp/4hqHj7A
         a/KIhRxNGSf5/yEy2VKdKWZpSx7UY3dtNjfLshjnkUX9sKV3rHluUh3qV5eaJ3TDHRQC
         aZxJcg2OmSG/F6bcRrWhiv24maSXBUCJYLVQuY86S9jHewL4P8HdNM8Mjn05ttfoRhWa
         v5oD+bfafomuLaPs0zeU5FlFDh0F3b+9dvT6rrOk5ZpeI2u2mtZieAws0eQJ3owjhqD+
         mCqA==
X-Forwarded-Encrypted: i=1; AFNElJ8U8DpokuxqUalcPcH0qLXL3rRo2dIxU2vmpwtEcMZjDXndq3Y86459rkAjmLpkkEy91ATo5Z2jWys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjIjC67bey9qbe6vD4vJerypQC92FUgRJWFXFzoZnAtDgRnIj
	SIRDjBjAPJyrzD2YlK8SlHKREAcFad1Gf+0JgPXmpVmwvFY+VpmGaKJgcniNNWoy3TY=
X-Gm-Gg: AeBDieuP7GEl4BSc0/JwkfFLPWp4nU7Jhkz3+NuwuQt+KF4nJdJt4AHsBEpFt04dwPx
	enKxC+cXMIYtbOK9192BL7OjQ/0KKDUF3EgsGyXGTS4YXr/KIec2b5cCRrhBKhzruUaAAbSWAoU
	+YjX56HiMNeMvFu0nV+z1sVYALJwaalzsfHJUpjQGNm31r9T4IRxx3swbR6zLfe1rMvRI2tXRke
	u5bAPc0czUSrSB0I9fr+F0K/B67b5z2tH99LZRa2DDM2yqVsSv+mHstGeyiY4KXX+Eosx/aE/Pg
	xkuj/+Grb7mKwHGN29EPuMjM7LgrojL2+mX3+dRj0yDak+1sijccIu2MkUzNu5bDRnteLJb4LSe
	D65ybWj+g7C2pWpls2x6JUTaKvQmHqpv46EBioNHZOPZleXlzRmZvsfn2+aff686IHSWzld7cEY
	FyqY1ITRCs9qzYAv+AaIABIrF1jFB0Xr5sxyJN2bAthJ3cXHl6DXdBYhm1qEXwHPV+PTF96lo1a
	aeOxMA=
X-Received: by 2002:a05:6000:25c2:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-43d642ccd7dmr38851820f8f.34.1776335254939;
        Thu, 16 Apr 2026 03:27:34 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3566b7sm13011883f8f.11.2026.04.16.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:27:34 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 16 Apr 2026 12:30:43 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <aeC6U7D6TfWm8JPx@apocalypse>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adkrHkANCzxO8KUP@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8607-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7EB40CE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 19:31 Fri 10 Apr     , Uwe Kleine-König wrote:
> Hello Andrea,
> 
> nice work for a v2!

Thanks!

> 
> On Fri, Apr 10, 2026 at 04:09:58PM +0200, Andrea della Porta wrote:

<...snip...>

> > +#define RP1_PWM_GLOBAL_CTRL	0x000
> > +#define RP1_PWM_CHANNEL_CTRL(x)	(0x014 + ((x) * 0x10))
> > +#define RP1_PWM_RANGE(x)	(0x018 + ((x) * 0x10))
> > +#define RP1_PWM_PHASE(x)	(0x01C + ((x) * 0x10))
> > +#define RP1_PWM_DUTY(x)		(0x020 + ((x) * 0x10))
> > +
> > +/* 8:FIFO_POP_MASK + 0:Trailing edge M/S modulation */
> > +#define RP1_PWM_CHANNEL_DEFAULT		(BIT(8) + BIT(0))
> 
> Please add a #define for BIT(8) and then use that and
> FIELD_PREP(RP1_PWM_MODE, RP1_PWM_MODE_SOMENICENAME) to define the
> constant. Also I would define it below the register defines.

Ack.

> 
> > +#define RP1_PWM_CHANNEL_ENABLE(x)	BIT(x)
> > +#define RP1_PWM_POLARITY		BIT(3)
> > +#define RP1_PWM_SET_UPDATE		BIT(31)
> > +#define RP1_PWM_MODE_MASK		GENMASK(1, 0)
> 
> s/_MASK// please
> 
> It would be great if the bitfield's names started with the register
> name.

Ack.

> 
> > +
> > +#define RP1_PWM_NUM_PWMS	4
> > +
> > +struct rp1_pwm {
> > +	struct regmap	*regmap;
> > +	struct clk	*clk;
> > +	unsigned long	clk_rate;
> > +	bool		clk_enabled;
> > +};
> > +
> > +struct rp1_pwm_waveform {
> > +	u32	period_ticks;
> > +	u32	duty_ticks;
> > +	bool	enabled;
> > +	bool	inverted_polarity;
> > +};
> > +
> > +static const struct regmap_config rp1_pwm_regmap_config = {
> > +	.reg_bits    = 32,
> > +	.val_bits    = 32,
> > +	.reg_stride  = 4,
> > +	.max_register = 0x60,
> 
> I'm not a fan of aligning the = in a struct, still more if it fails like
> here. Please consistently align all =s, or even better, use a single
> space before each =. (Same for the struct definitions above, but I won't
> insist.)

Let's use the single space.

> 
> > +};
> > +
> > +static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	u32 value;
> > +
> > +	/* update the changed registers on the next strobe to avoid glitches */
> > +	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
> > +	value |= RP1_PWM_SET_UPDATE;
> > +	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);
> 
> I assume there is a glitch if I update two channels and the old
> configuration of the first channel ends while I'm in the middle of
> configuring the second?

The configuration registers are per-channel but the update flag is global.
I don't have details of the hw insights, my best guess is that anything that
you set in the registers before updating the flag will take effect, so there
should be no glitches.

> 
> > +}
> > +
> > +static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +
> > +	/* init channel to reset defaults */
> > +	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), RP1_PWM_CHANNEL_DEFAULT);
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +				       struct pwm_device *pwm,
> > +				       const struct pwm_waveform *wf,
> > +				       void *_wfhw)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u64 clk_rate = rp1->clk_rate;
> > +	u64 ticks;
> 
> 	if (!wf->period_length_ns)
> 		wfhw->enabled = false
> 		return 0;
> 
> > +	ticks = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
> 
> To ensure this doesn't overflow please fail to probe the driver if
> clk_rate > 1 GHz with an explaining comment. (Or alternatively calculate
> the length of period_ticks = U32_MAX and skip the calculation if
> wf->period_length_ns is bigger.)

Ack.

> 
> > +	if (ticks > U32_MAX)
> > +		ticks = U32_MAX;
> > +	wfhw->period_ticks = ticks;
> 
> What happens if wf->period_length_ns > 0 but ticks == 0?

I've added a check, returning 1 to signal teh round-up, and a minimum tick of 1
in this case.

> 
> > +	if (wf->duty_offset_ns + wf->duty_length_ns >= wf->period_length_ns) {
> 
> The maybe surprising effect here is that in the two cases
> 
> 	wf->duty_offset_ns == wf->period_length_ns and wf->duty_length_ns == 0
> 
> and
> 	
> 	wf->duty_length_ns == wf->period_length_ns and wf->duty_offset_ns == 0
> 
> you're configuring inverted polarity. I doesn't matter technically
> because the result is the same, but for consumers still using pwm_state
> this is irritating. That's why pwm-stm32 uses inverted polarity only if
> also wf->duty_length_ns and wf->duty_offset_ns are non-zero.

Ack.

> 
> > +		ticks = mul_u64_u64_div_u64(wf->period_length_ns - wf->duty_length_ns,
> > +					    clk_rate, NSEC_PER_SEC);
> 
> The rounding is wrong here. You should pick the biggest duty_length not
> bigger than wf->duty_length_ns, so you have to use
> 
> 	ticks = wfhw->period_ticks - mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC):
> 
> . I see this is a hole in the pwmtestperf coverage.

Ack.

> 
> > +		wfhw->inverted_polarity = true;
> > +	} else {
> > +		ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> > +		wfhw->inverted_polarity = false;
> > +	}
> > +
> > +	if (ticks > wfhw->period_ticks)
> > +		ticks = wfhw->period_ticks;
> 
> You can and should assume that wf->duty_length_ns <=
> wf->period_length_ns. Then the if condition can never become true.

Ack.

> 
> > +	wfhw->duty_ticks = ticks;
> > +
> > +	wfhw->enabled = !!wfhw->duty_ticks;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const void *_wfhw,
> > +					 struct pwm_waveform *wf)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u64 clk_rate = rp1->clk_rate;
> > +	u32 ticks;
> > +
> > +	memset(wf, 0, sizeof(*wf));
> 
> 	wf = (struct pwm_waveform){ };
> 
> is usually more efficient.

Ack.

> 
> > +	if (!wfhw->enabled)
> > +		return 0;
> > +
> > +	wf->period_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->period_ticks * NSEC_PER_SEC, clk_rate);
> > +
> > +	if (wfhw->inverted_polarity) {
> > +		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
> > +						      clk_rate);
> > +	} else {
> > +		wf->duty_offset_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
> > +						      clk_rate);
> > +		ticks = wfhw->period_ticks - wfhw->duty_ticks;
> > +		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)ticks * NSEC_PER_SEC, clk_rate);
> > +	}
> 
> This needs adaption after the rounding issue in tohw is fixed.

Ack.

> 
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_write_waveform(struct pwm_chip *chip,
> > +				  struct pwm_device *pwm,
> > +				  const void *_wfhw)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u32 value;
> > +
> > +	/* set period and duty cycle */
> > +	regmap_write(rp1->regmap,
> > +		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
> > +	regmap_write(rp1->regmap,
> > +		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
> > +
> > +	/* set polarity */
> > +	regmap_read(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), &value);
> > +	if (!wfhw->inverted_polarity)
> > +		value &= ~RP1_PWM_POLARITY;
> > +	else
> > +		value |= RP1_PWM_POLARITY;
> > +	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), value);
> > +
> > +	/* enable/disable */
> > +	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
> > +	if (wfhw->enabled)
> > +		value |= RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
> > +	else
> > +		value &= ~RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
> > +	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);
> 
> You can exit early if wfhw->enabled is false after clearing the channel
> enable bit.

Ack.

> 
> > +	rp1_pwm_apply_config(chip, pwm);
> > +
> > +	return 0;
> > +}
> > +

<,...snip...>

> > +	}
> > +
> > +	return 0;
> > +
> > +err_disable_clk:
> > +	clk_disable_unprepare(rp1->clk);
> > +
> > +	return ret;
> > +}
> 
> On remove you miss to balance the call to clk_prepare_enable() (if no
> failed call to clk_prepare_enable() in rp1_pwm_resume() happend).

Since this driver now exports a syscon, it's only builtin (=Y) so
it cannot be unloaded.
I've also avoided the .remove callback via .suppress_bind_attrs.

> 
> > +
> > +static int rp1_pwm_suspend(struct device *dev)
> > +{
> > +	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
> > +
> > +	if (rp1->clk_enabled) {
> > +		clk_disable_unprepare(rp1->clk);
> > +		rp1->clk_enabled = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_resume(struct device *dev)
> > +{
> > +	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(rp1->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable clock on resume: %d\n", ret);
> 
> Please use %pe for error codes.

Ack.

Best regards,
Andrea

> 
> > +		return ret;
> > +	}
> > +
> > +	rp1->clk_enabled = true;
> > +
> > +	return 0;
> > +}
> 
> Best regards
> Uwe



