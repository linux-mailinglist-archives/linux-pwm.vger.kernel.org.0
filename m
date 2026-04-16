Return-Path: <linux-pwm+bounces-8595-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBhlDIyV4Gn/jwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8595-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:53:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D653040B386
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6F2F3043D0A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A138C2D8;
	Thu, 16 Apr 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SPLZAtjO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035F38B7B8;
	Thu, 16 Apr 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326024; cv=none; b=Bt3z/2sQRdZKUvRVArTtvewosQc8XjYRPgulWByTQCy9cknREANKQ3MNbexxhR5YUG9pB0QkNwbLdOmBtm/7jnbtt5vo5g9imrWY6VmOUYDETGu9YQY+yi8OWbyHBV9jNEURdTcYDoFY1AtRAoBVKYVnEnCzXcNh/DbmEzHrWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326024; c=relaxed/simple;
	bh=f0uVB6nrgAe+o5PFGAW5jwH6o9+un/eB1jMRfY2gQYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9IiDw2vzBHA7laEbg7LBTeclvKxAnNO+cKJ0OOfMkp3IUpGP1Nehp7h8wOAx3bux8KXrVcxfNHxVqjrI+dlqBTF98li4t27qJaNvJXUoNIMYjQki7zFiz+szLiSfS3XA3H2DUobTzpgkYahvRfeRvh9dy+D+dX9RhztVlxPhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SPLZAtjO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7897C1A3292;
	Thu, 16 Apr 2026 07:53:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CF705FDEB;
	Thu, 16 Apr 2026 07:53:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E73201045936D;
	Thu, 16 Apr 2026 09:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776326013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=h03d3L3RIMbRysrs7PXhRcaB+z8iT2+PHrt8ol9UKlQ=;
	b=SPLZAtjOOVFFttf7YFKDyMkF85FLMp+oUYehGNS/3yYv6BnsZNHiDZweyk61gPg/5u2loZ
	ZTsznKSaRNahkQQJMI7nQJMsvZRblqE7uA+MKCSPcCLcmC5J1OkI5lJXuzcu4e5EPrsNfa
	EZ3GtZ8Z5TUcAf17ySdRY0/l2ruDnpQdsnmG8iGKzmKspp4esZ/FMekJvoiGL4Ma/LRSnv
	1xyKNnF3quzE6ld+Suk0f6awGXxZEPfxa88Y+58aiSaLiN3vrvO6+mPcj+je3+dVyS+lzi
	p/Up8SWgzJ1vV8ApdnIkz/rkM22OdD5DDEIKuZGkaTvsMIydkICaN4uV/AFhRA==
Message-ID: <26f86593-a561-497e-bd47-b9cbda67bbf4@bootlin.com>
Date: Thu, 16 Apr 2026 09:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
 <20260305091959.2530374-3-richard.genoud@bootlin.com>
 <adfiPo4Jq1IRMM0h@shepard>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <adfiPo4Jq1IRMM0h@shepard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8595-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D653040B386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul,
Le 09/04/2026 à 19:30, Paul Kocialkowski a écrit :
> Hi Richard,
> 
> On Thu 05 Mar 26, 10:19, Richard Genoud wrote:
>> +/* PWM IRQ Enable Register */
>> +#define H616_PWM_IER				0x0
> 
> I think it would make more sense to keep the full register names from the
> manual after the suffix and stick to them. It makes things easier when
> comparing the code with documentation or the reference implementation.
> 
> So something like SUN8I_PWM_PIER here.
Ok, that make sense.

> 
>> +
>> +/* PWM IRQ Status Register */
>> +#define H616_PWM_ISR				0x4
>> +
>> +/* PWM Capture IRQ Enable Register */
>> +#define H616_PWM_CIER				0x10
>> +
>> +/* PWM Capture IRQ Status Register */
>> +#define H616_PWM_CISR				0x14
>> +
>> +/* PWMCC Pairs Clock Configuration Registers */
>> +#define H616_PWM_XY_CLK_CR(pair)		(0x20 + ((pair) * 0x4))
>> +#define H616_PWM_XY_CLK_CR_SRC_SHIFT		7
>> +#define H616_PWM_XY_CLK_CR_SRC_MASK		1
>> +#define H616_PWM_XY_CLK_CR_GATE_BIT		4
>> +#define H616_PWM_XY_CLK_CR_BYPASS_BIT(chan)	((chan) % 2 + 5)
>> +#define H616_PWM_XY_CLK_CR_DIV_M_SHIFT		0
>> +
>> +/* PWMCC Pairs Dead Zone Control Registers */
>> +#define H616_PWM_XY_DZ(pair)			(0x30 + ((pair) * 0x4))
>> +
>> +/* PWM Enable Register */
>> +#define H616_PWM_ENR				0x40
>> +#define H616_PWM_ENABLE(x)			BIT(x)
>> +
>> +/* PWM Capture Enable Register */
>> +#define H616_PWM_CER				0x44
>> +
>> +/* PWM Control Register */
>> +#define H616_PWM_CTRL_REG(chan)		(0x60 + (chan) * 0x20)
> 
> You're sometimes calling the register offset _REG and sometimes not.
> Both options are fine but you need to keep it consistent across the whole
> definitions. I would be enclined to not use it after using the register names
> coming from the manual as suggested above.
I see what you mean, so H616_PWM_CTRL_REG() would become SUN8I_PWM_PCR()

> 
> Also you're sometimes using "chan", sometimes "ch" for the argument to the
> register macros. This is inconsistent and you might as well just use "c"
> everywhere so it doesn't take too much space.
Indeed.

> 
>> +#define H616_PWM_CTRL_PRESCAL_K_SHIFT	0
>> +#define H616_PWM_CTRL_PRESCAL_K_WIDTH	8
>> +#define H616_PWM_CTRL_ACTIVE_STATE	BIT(8)
>> +
>> +/* PWM Period Register */
>> +#define H616_PWM_PERIOD_REG(ch)		(0x64 + (ch) * 0x20)
>> +#define H616_PWM_PERIOD_MASK		GENMASK(31, 16)
>> +#define H616_PWM_DUTY_MASK		GENMASK(15, 0)
>> +#define H616_PWM_REG_PERIOD(reg)	(FIELD_GET(H616_PWM_PERIOD_MASK, reg) + 1)
>> +#define H616_PWM_REG_DUTY(reg)		FIELD_GET(H616_PWM_DUTY_MASK, reg)
>> +#define H616_PWM_PERIOD(prd)		FIELD_PREP(H616_PWM_PERIOD_MASK, (prd) - 1)
>> +#define H616_PWM_DUTY(dty)		FIELD_PREP(H616_PWM_DUTY_MASK, dty)
>> +#define H616_PWM_PERIOD_MAX		(FIELD_MAX(H616_PWM_PERIOD_MASK) + 1)
> 
> Using REG as a prefix feels a bit confusing here. I would rather see:
> #define SUN8I_PWM_PPR(c)		(0x64 + (c) * 0x20)
> #define SUN8I_PWM_PPR_PERIOD(p)		FIELD_PREP(...)
> #define SUN8I_PWM_PPR_PERIOD_VALUE(r)	FIELD_GET(...)
> #define SUN8I_PWN_PPR_PERIOD_MAX	FIELD_MAX(...)
> #define SUN8I_PWM_PPR_DUTY(d)		FIELD_PREP(...)
> #define SUN8I_PWM_PPR_DUTY_VALUE(r)	FIELD_GET(...)
That's right, that would be less confusing.

> 
>> +
>> +/* PWM Count Register */
>> +#define H616_PWM_CNT_REG(x)		(0x68 + (x) * 0x20)
>> +
>> +/* PWM Capture Control Register */
>> +#define H616_PWM_CCR(x)			(0x6c + (x) * 0x20)
>> +
>> +/* PWM Capture Rise Lock Register */
>> +#define H616_PWM_CRLR(x)		(0x70 + (x) * 0x20)
>> +
>> +/* PWM Capture Fall Lock Register */
>> +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
>> +
>> +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
>> +
>> +/*
>> + * Block diagram of the PWM clock controller:
>> + *
>> + *             _____      ______      ________
>> + * OSC24M --->|     |    |      |    |        |
>> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> H616_PWM_clock_src_xy
>> + *            |_____|    |______|    |________|
>> + *                               ________
>> + *                              |        |
>> + *                           +->| /div_k |---> H616_PWM_clock_x
>> + *                           |  |________|
>> + *                           |    ______
>> + *                           |   |      |
>> + *                           +-->| Gate |----> H616_PWM_bypass_clock_x
>> + *                           |   |______|
>> + * H616_PWM_clock_src_xy ----+   ________
>> + *                           |  |        |
>> + *                           +->| /div_k |---> H616_PWM_clock_y
>> + *                           |  |________|
>> + *                           |    ______
>> + *                           |   |      |
>> + *                           +-->| Gate |----> H616_PWM_bypass_clock_y
>> + *                               |______|
>> + *
>> + * NB: when the bypass is set, all the PWM logic is bypassed.
>> + * So, the duty cycle and polarity can't be modified (we just have a clock).
>> + * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle with the
>> + * fastest clock.
>> + *
>> + * H616_PWM_clock_x/y serve for the PWM purpose.
>> + * H616_PWM_bypass_clock_x/y serve for the clock-provider purpose.
>> + *
>> + */
>> +
>> +/*
>> + * Table used for /div_m (diviser before obtaining H616_PWM_clock_src_xy)
>> + * It's actually CLK_DIVIDER_POWER_OF_TWO, but limited to /256
>> + */
>> +#define CLK_TABLE_DIV_M_ENTRY(i) { \
>> +	.val = (i), .div = 1 << (i) \
>> +}
>> +
>> +static const struct clk_div_table clk_table_div_m[] = {
>> +	CLK_TABLE_DIV_M_ENTRY(0),
>> +	CLK_TABLE_DIV_M_ENTRY(1),
>> +	CLK_TABLE_DIV_M_ENTRY(2),
>> +	CLK_TABLE_DIV_M_ENTRY(3),
>> +	CLK_TABLE_DIV_M_ENTRY(4),
>> +	CLK_TABLE_DIV_M_ENTRY(5),
>> +	CLK_TABLE_DIV_M_ENTRY(6),
>> +	CLK_TABLE_DIV_M_ENTRY(7),
>> +	CLK_TABLE_DIV_M_ENTRY(8),
>> +	{ /* sentinel */ }
>> +};
>> +
>> +#define H616_PWM_XY_SRC_GATE(_pair, _reg)		\
>> +struct clk_gate gate_xy_##_pair = {			\
>> +	.reg = (void *)(_reg),				\
>> +	.bit_idx = H616_PWM_XY_CLK_CR_GATE_BIT,		\
>> +	.hw.init = &(struct clk_init_data){		\
>> +		.ops = &clk_gate_ops,			\
>> +	}						\
>> +}
>> +
>> +#define H616_PWM_XY_SRC_MUX(_pair, _reg)		\
>> +struct clk_mux mux_xy_##_pair = {			\
>> +	.reg = (void *)(_reg),				\
>> +	.shift = H616_PWM_XY_CLK_CR_SRC_SHIFT,		\
>> +	.mask = H616_PWM_XY_CLK_CR_SRC_MASK,		\
>> +	.flags = CLK_MUX_ROUND_CLOSEST,			\
>> +	.hw.init = &(struct clk_init_data){		\
>> +		.ops = &clk_mux_ops,			\
>> +	}						\
>> +}
>> +
>> +#define H616_PWM_XY_SRC_DIV(_pair, _reg)		\
>> +struct clk_divider rate_xy_##_pair = {			\
>> +	.reg = (void *)(_reg),				\
>> +	.shift = H616_PWM_XY_CLK_CR_DIV_M_SHIFT,	\
>> +	.table = clk_table_div_m,			\
>> +	.hw.init = &(struct clk_init_data){		\
>> +		.ops = &clk_divider_ops,		\
>> +	}						\
>> +}
>> +
>> +#define H616_PWM_X_DIV(_idx, _reg)			\
>> +struct clk_divider rate_x_##_idx = {			\
>> +	.reg = (void *)(_reg),				\
>> +	.shift = H616_PWM_CTRL_PRESCAL_K_SHIFT,		\
>> +	.width = H616_PWM_CTRL_PRESCAL_K_WIDTH,		\
>> +	.hw.init = &(struct clk_init_data){		\
>> +		.ops = &clk_divider_ops,		\
>> +	}						\
>> +}
>> +
>> +#define H616_PWM_X_BYPASS_GATE(_idx)			\
>> +struct clk_gate gate_x_bypass_##_idx = {		\
>> +	.reg = (void *)H616_PWM_ENR,			\
>> +	.bit_idx = _idx,				\
>> +	.hw.init = &(struct clk_init_data){		\
>> +		.ops = &clk_gate_ops,			\
>> +	}						\
>> +}
>> +
>> +#define H616_PWM_XY_CLK_SRC(_pair, _reg)			\
>> +	static H616_PWM_XY_SRC_MUX(_pair, _reg);		\
>> +	static H616_PWM_XY_SRC_GATE(_pair, _reg);		\
>> +	static H616_PWM_XY_SRC_DIV(_pair, _reg)
>> +
>> +#define H616_PWM_X_CLK(_idx)					\
>> +	static H616_PWM_X_DIV(_idx, H616_PWM_CTRL_REG(_idx))
>> +
>> +#define H616_PWM_X_BYPASS_CLK(_idx)				\
>> +	H616_PWM_X_BYPASS_GATE(_idx)
>> +
>> +#define REF_CLK_XY_SRC(_pair)						\
>> +	{								\
>> +		.name = "pwm-clk-src" #_pair,				\
>> +		.mux_hw = &mux_xy_##_pair.hw,				\
>> +		.gate_hw = &gate_xy_##_pair.hw,				\
>> +		.rate_hw = &rate_xy_##_pair.hw,				\
>> +	}
>> +
>> +#define REF_CLK_X(_idx, _pair)						\
>> +	{								\
>> +		.name = "pwm-clk" #_idx,				\
>> +		.parent_names = (const char *[]){ "pwm-clk-src" #_pair }, \
>> +		.num_parents = 1,					\
>> +		.rate_hw = &rate_x_##_idx.hw,				\
>> +		.flags = CLK_SET_RATE_PARENT,				\
>> +	}
>> +
>> +#define REF_CLK_BYPASS(_idx, _pair)					\
>> +	{								\
>> +		.name = "pwm-clk-bypass" #_idx,				\
>> +		.parent_names = (const char *[]){ "pwm-clk-src" #_pair }, \
>> +		.num_parents = 1,					\
>> +		.gate_hw = &gate_x_bypass_##_idx.hw,			\
>> +		.flags = CLK_SET_RATE_PARENT,	\
>> +	}
>> +
>> +/*
>> + * H616_PWM_clock_src_xy generation:
>> + *             _____      ______      ________
>> + * OSC24M --->|     |    |      |    |        |
>> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> H616_PWM_clock_src_xy
>> + *            |_____|    |______|    |________|
>> + */
>> +H616_PWM_XY_CLK_SRC(01, H616_PWM_XY_CLK_CR(0));
>> +H616_PWM_XY_CLK_SRC(23, H616_PWM_XY_CLK_CR(1));
>> +H616_PWM_XY_CLK_SRC(45, H616_PWM_XY_CLK_CR(2));
>> +
>> +/*
>> + * H616_PWM_clock_x_div generation:
>> + *                            ________
>> + *                           |        | H616_PWM_clock_x/y
>> + * H616_PWM_clock_src_xy --->| /div_k |--------------->
>> + *                           |________|
>> + */
>> +H616_PWM_X_CLK(0);
>> +H616_PWM_X_CLK(1);
>> +H616_PWM_X_CLK(2);
>> +H616_PWM_X_CLK(3);
>> +H616_PWM_X_CLK(4);
>> +H616_PWM_X_CLK(5);
>> +
>> +/*
>> + * H616_PWM_bypass_clock_xy generation:
>> + *                             ______
>> + *                            |      |
>> + * H616_PWM_clock_src_xy ---->| Gate |-------> H616_PWM_bypass_clock_x
>> + *                            |______|
>> + *
>> + * The gate is actually H616_PWM_ENR register.
>> + */
>> +H616_PWM_X_BYPASS_CLK(0);
>> +H616_PWM_X_BYPASS_CLK(1);
>> +H616_PWM_X_BYPASS_CLK(2);
>> +H616_PWM_X_BYPASS_CLK(3);
>> +H616_PWM_X_BYPASS_CLK(4);
>> +H616_PWM_X_BYPASS_CLK(5);
>> +
>> +struct clk_pwm_data {
>> +	const char *name;
>> +	const char **parent_names;
>> +	unsigned int num_parents;
>> +	struct clk_hw *mux_hw;
>> +	struct clk_hw *rate_hw;
>> +	struct clk_hw *gate_hw;
>> +	unsigned long flags;
>> +};
>> +
>> +#define CLK_BYPASS(h616chip, ch) ((h616chip)->data->npwm + (ch))
>> +#define CLK_XY_SRC_IDX(h616chip, ch) ((h616chip)->data->npwm * 2 + ((ch) >> 1))
>> +static struct clk_pwm_data pwmcc_data[] = {
>> +	REF_CLK_X(0, 01),
>> +	REF_CLK_X(1, 01),
>> +	REF_CLK_X(2, 23),
>> +	REF_CLK_X(3, 23),
>> +	REF_CLK_X(4, 45),
>> +	REF_CLK_X(5, 45),
>> +	REF_CLK_BYPASS(0, 01),
>> +	REF_CLK_BYPASS(1, 01),
>> +	REF_CLK_BYPASS(2, 23),
>> +	REF_CLK_BYPASS(3, 23),
>> +	REF_CLK_BYPASS(4, 45),
>> +	REF_CLK_BYPASS(5, 45),
>> +	REF_CLK_XY_SRC(01),
>> +	REF_CLK_XY_SRC(23),
>> +	REF_CLK_XY_SRC(45),
>> +	{ /* sentinel */ }
>> +};
> 
> We'll probably need a way to tie these static definitions to a particular
> instance of the unit for a given chip. But I guess that can be done later
> when adding more chips to the driver.
> 
> I'm not too versed in the clk and pwm APIs but the rest generally looks good
> to me.

Thanks!

> 
> All the best,
> 
> Paul
> 


