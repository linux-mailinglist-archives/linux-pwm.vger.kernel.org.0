Return-Path: <linux-pwm+bounces-2226-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21228CCB05
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 05:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42C11C208E3
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 03:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B9433A2;
	Thu, 23 May 2024 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="fW+SsOKt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BB8475
	for <linux-pwm@vger.kernel.org>; Thu, 23 May 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434237; cv=none; b=OX2JeeieRTTa7KSLxKSP+b/Bwml0r8Iv7DMVy00icgp6tG76/IsfcSXNQ0wFbaSn/B5iiceT0SfEswhA2/Jj2nNWwHj2oFUYtkc6e6eeWQJPoUiZDVv2OfLxBHpErvmUPlxfc044MeHTLR8kytUKCML5q9N3DfaZBJAjs5w6ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434237; c=relaxed/simple;
	bh=mmip/Fmtcp8q2RqKrZFvswuRwnbSMGnRUk9BvaM36LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP+x/bo0x2iEbHj3CnkBfBdRx3472Z9NvhKpql/LfZuRAvQidXtCjtkAB5QS00Rl26XoUUbnkJRF049HYsu6BoiWN+IvMoiw/ZWvkfULJ20FYoGufMqBHRLQCqm3BhHd9O5OBd6qxXqxwk7cY5dHjIG5dMDv5GhwvVnzGanZBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=fW+SsOKt; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Envelope-To: privatesub2@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1716434233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlkXcThfgU+Weh7FowP8bX9amJyy2rYrJoLZLZdXl6E=;
	b=fW+SsOKt1InGER2nyZUsklau+h6jfkQZ6d5LAt/sqdexUzzua6yvkOvOnSykAiKTc325OD
	kEdRSQq5hd2cfoB9gzlCtXGBudBH507ioOA6tHjMyHkx+NTw8tlqC1Sy93ZX+C4lmVXxMr
	0ZsYWliPNAHffDofoyE0ljhFoY19tC627zytcfs/6bKJfgFwm2umSWPeo5RkoqUvv9DBBa
	SHL+/EcFzSWM/vdtzOit88gEE5yuZItNIBbkeTm2sdzWS4c9Yd9ezVCgwqNGPhfvWKNdk2
	y3jUKiIhQjshWHNwp28gkaUnzMw6+cBeX3lridRy7+aDOoIxC5Vbp6OCzh62Kg==
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: fusibrandon13@gmail.com
X-Envelope-To: ukleinek@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: wens@csie.org
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: samuel@sholland.org
X-Envelope-To: paul.walmsley@sifive.com
X-Envelope-To: palmer@dabbelt.com
X-Envelope-To: aou@eecs.berkeley.edu
X-Envelope-To: p.zabel@pengutronix.de
X-Envelope-To: mkl@pengutronix.de
X-Envelope-To: bigunclemax@gmail.com
X-Envelope-To: linux-pwm@vger.kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-sunxi@lists.linux.dev
X-Envelope-To: linux-riscv@lists.infradead.org
Date: Thu, 23 May 2024 13:16:47 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <Zk61H05-BTVUarFV@titan>
References: <20240520184227.120956-1-privatesub2@gmail.com>
 <20240520184227.120956-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520184227.120956-3-privatesub2@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi,

Here's a quick review based on the experience of me writing my own driver.

On Mon, May 20, 2024 at 09:42:20PM +0300, Aleksandr Shubin wrote:
> +	act_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle = ent_cycle;
> +
> +	/*
> +	 * We have act_cycle <= ent_cycle <= 0xffff, prescale_k <= 0x100,
> +	 * div_m <= 8. So the multiplication fits into an u64 without
> +	 * overflow.
> +	 */
> +	tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);

Doesn't ent_cycle require a + 1 here?
Shouldn't act_cycle be > ent_cycle on 0% duty cycles?

> +			/* if the neighbor channel is enable, check period only */
> +			use_bus_clk = FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) != 0;
> +			val = mul_u64_u64_div_u64(state->period,
> +						  (use_bus_clk ? bus_rate : hosc_rate),
> +						  NSEC_PER_SEC);

It would be nice if it reclocked both channels.

> +		/* calculate prescale_k, PWM entire cycle */
> +		ent_cycle = val >> div_m;
> +		prescale_k = DIV_ROUND_DOWN_ULL(ent_cycle, 65537);
> +		if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> +			prescale_k = SUN20I_PWM_CTL_PRESCAL_K_MAX;
> +
> +		do_div(ent_cycle, prescale_k + 1);
> +
> +		/* for N cycles, PPRx.PWM_ENTIRE_CYCLE = (N-1) */
> +		reg_period = FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1);
> +
> +		/* set duty cycle */
> +		val = mul_u64_u64_div_u64(state->duty_cycle,
> +					  (use_bus_clk ? bus_rate : hosc_rate),
> +					  NSEC_PER_SEC);
> +		act_cycle = val >> div_m;
> +		do_div(act_cycle, prescale_k + 1);

I'm not sure about this code. I don't quite get where the 65537 comes from or
what's really happening here.

To my understanding you either want to limit PWM_ENTIRE_CYCLE to 0xFFFE so and
scale PWM_ACTIVE_CYCLE from 0 to 65535 so it can be 0x0 at 100% duty cycles and
0xFFFF at 0% duty cycles, OR you want to scale it from 0 to 65536 and check if
the value is 65536, and if it is wrap it around to 0 and flip the polarity.

Thanks,
John.

