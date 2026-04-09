Return-Path: <linux-pwm+bounces-8541-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOuxLlLi12kVUQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8541-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 19:30:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7F3CE247
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2518E301A434
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BFF3DA5A9;
	Thu,  9 Apr 2026 17:30:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408044317D;
	Thu,  9 Apr 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755855; cv=none; b=p2Ch9/213IeIZ4/F8s8U61P202xE6iwYMMO6+Kjg0xjzKWDyew5tnvTwgy8gDYP2bQaTC0Thqyn3qCGnVZCh3kE2blC3J8oAHIWmVw3T8Gm3ou9786lpTxnQ+wkVjD7QzqPp3qMiaeN6Syx+g4BSBIOGBKA8/L6OWoqm1p1OUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755855; c=relaxed/simple;
	bh=n6ZhTvDI/gO7vRnPYKTQOQKVkLDFI51YC7FfF+h0E9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBBlgu8ZGzbgZOGu/n2S0OCBrxF37fxJOoj3bm4W2kNBggyjarMsyA+A5QaG6Vc/yaqnOG3DbWzSnmkzW8k0xclKd05hys1FF05VEBeinUQNLvcXtFa90ld0jAI0ZrnDZ55opnVtmpfjLPfQFMQ4kQnw7w2Nrox5hNC1rrfq3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id A7DB81F8005F;
	Thu,  9 Apr 2026 17:30:45 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 9D7EBB401BA; Thu,  9 Apr 2026 17:30:43 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 83915B401B9;
	Thu,  9 Apr 2026 17:30:41 +0000 (UTC)
Date: Thu, 9 Apr 2026 19:30:38 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <adfiPo4Jq1IRMM0h@shepard>
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
 <20260305091959.2530374-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33pU5tb6RmcLLlSB"
Content-Disposition: inline
In-Reply-To: <20260305091959.2530374-3-richard.genoud@bootlin.com>
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8541-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sys-base.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulk@sys-base.io,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sys-base.io:url,paulk.fr:url]
X-Rspamd-Queue-Id: 2AE7F3CE247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--33pU5tb6RmcLLlSB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu 05 Mar 26, 10:19, Richard Genoud wrote:
> +/* PWM IRQ Enable Register */
> +#define H616_PWM_IER				0x0

I think it would make more sense to keep the full register names from the
manual after the suffix and stick to them. It makes things easier when
comparing the code with documentation or the reference implementation.

So something like SUN8I_PWM_PIER here.

> +
> +/* PWM IRQ Status Register */
> +#define H616_PWM_ISR				0x4
> +
> +/* PWM Capture IRQ Enable Register */
> +#define H616_PWM_CIER				0x10
> +
> +/* PWM Capture IRQ Status Register */
> +#define H616_PWM_CISR				0x14
> +
> +/* PWMCC Pairs Clock Configuration Registers */
> +#define H616_PWM_XY_CLK_CR(pair)		(0x20 + ((pair) * 0x4))
> +#define H616_PWM_XY_CLK_CR_SRC_SHIFT		7
> +#define H616_PWM_XY_CLK_CR_SRC_MASK		1
> +#define H616_PWM_XY_CLK_CR_GATE_BIT		4
> +#define H616_PWM_XY_CLK_CR_BYPASS_BIT(chan)	((chan) % 2 + 5)
> +#define H616_PWM_XY_CLK_CR_DIV_M_SHIFT		0
> +
> +/* PWMCC Pairs Dead Zone Control Registers */
> +#define H616_PWM_XY_DZ(pair)			(0x30 + ((pair) * 0x4))
> +
> +/* PWM Enable Register */
> +#define H616_PWM_ENR				0x40
> +#define H616_PWM_ENABLE(x)			BIT(x)
> +
> +/* PWM Capture Enable Register */
> +#define H616_PWM_CER				0x44
> +
> +/* PWM Control Register */
> +#define H616_PWM_CTRL_REG(chan)		(0x60 + (chan) * 0x20)

You're sometimes calling the register offset _REG and sometimes not.
Both options are fine but you need to keep it consistent across the whole
definitions. I would be enclined to not use it after using the register nam=
es
coming from the manual as suggested above.

Also you're sometimes using "chan", sometimes "ch" for the argument to the
register macros. This is inconsistent and you might as well just use "c"
everywhere so it doesn't take too much space.

> +#define H616_PWM_CTRL_PRESCAL_K_SHIFT	0
> +#define H616_PWM_CTRL_PRESCAL_K_WIDTH	8
> +#define H616_PWM_CTRL_ACTIVE_STATE	BIT(8)
> +
> +/* PWM Period Register */
> +#define H616_PWM_PERIOD_REG(ch)		(0x64 + (ch) * 0x20)
> +#define H616_PWM_PERIOD_MASK		GENMASK(31, 16)
> +#define H616_PWM_DUTY_MASK		GENMASK(15, 0)
> +#define H616_PWM_REG_PERIOD(reg)	(FIELD_GET(H616_PWM_PERIOD_MASK, reg) +=
 1)
> +#define H616_PWM_REG_DUTY(reg)		FIELD_GET(H616_PWM_DUTY_MASK, reg)
> +#define H616_PWM_PERIOD(prd)		FIELD_PREP(H616_PWM_PERIOD_MASK, (prd) - 1)
> +#define H616_PWM_DUTY(dty)		FIELD_PREP(H616_PWM_DUTY_MASK, dty)
> +#define H616_PWM_PERIOD_MAX		(FIELD_MAX(H616_PWM_PERIOD_MASK) + 1)

Using REG as a prefix feels a bit confusing here. I would rather see:
#define SUN8I_PWM_PPR(c)		(0x64 + (c) * 0x20)
#define SUN8I_PWM_PPR_PERIOD(p)		FIELD_PREP(...)
#define SUN8I_PWM_PPR_PERIOD_VALUE(r)	FIELD_GET(...)
#define SUN8I_PWN_PPR_PERIOD_MAX	FIELD_MAX(...)
#define SUN8I_PWM_PPR_DUTY(d)		FIELD_PREP(...)
#define SUN8I_PWM_PPR_DUTY_VALUE(r)	FIELD_GET(...)

> +
> +/* PWM Count Register */
> +#define H616_PWM_CNT_REG(x)		(0x68 + (x) * 0x20)
> +
> +/* PWM Capture Control Register */
> +#define H616_PWM_CCR(x)			(0x6c + (x) * 0x20)
> +
> +/* PWM Capture Rise Lock Register */
> +#define H616_PWM_CRLR(x)		(0x70 + (x) * 0x20)
> +
> +/* PWM Capture Fall Lock Register */
> +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
> +
> +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
> +
> +/*
> + * Block diagram of the PWM clock controller:
> + *
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> H616_PWM_clock_src=
_xy
> + *            |_____|    |______|    |________|
> + *                               ________
> + *                              |        |
> + *                           +->| /div_k |---> H616_PWM_clock_x
> + *                           |  |________|
> + *                           |    ______
> + *                           |   |      |
> + *                           +-->| Gate |----> H616_PWM_bypass_clock_x
> + *                           |   |______|
> + * H616_PWM_clock_src_xy ----+   ________
> + *                           |  |        |
> + *                           +->| /div_k |---> H616_PWM_clock_y
> + *                           |  |________|
> + *                           |    ______
> + *                           |   |      |
> + *                           +-->| Gate |----> H616_PWM_bypass_clock_y
> + *                               |______|
> + *
> + * NB: when the bypass is set, all the PWM logic is bypassed.
> + * So, the duty cycle and polarity can't be modified (we just have a clo=
ck).
> + * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle w=
ith the
> + * fastest clock.
> + *
> + * H616_PWM_clock_x/y serve for the PWM purpose.
> + * H616_PWM_bypass_clock_x/y serve for the clock-provider purpose.
> + *
> + */
> +
> +/*
> + * Table used for /div_m (diviser before obtaining H616_PWM_clock_src_xy)
> + * It's actually CLK_DIVIDER_POWER_OF_TWO, but limited to /256
> + */
> +#define CLK_TABLE_DIV_M_ENTRY(i) { \
> +	.val =3D (i), .div =3D 1 << (i) \
> +}
> +
> +static const struct clk_div_table clk_table_div_m[] =3D {
> +	CLK_TABLE_DIV_M_ENTRY(0),
> +	CLK_TABLE_DIV_M_ENTRY(1),
> +	CLK_TABLE_DIV_M_ENTRY(2),
> +	CLK_TABLE_DIV_M_ENTRY(3),
> +	CLK_TABLE_DIV_M_ENTRY(4),
> +	CLK_TABLE_DIV_M_ENTRY(5),
> +	CLK_TABLE_DIV_M_ENTRY(6),
> +	CLK_TABLE_DIV_M_ENTRY(7),
> +	CLK_TABLE_DIV_M_ENTRY(8),
> +	{ /* sentinel */ }
> +};
> +
> +#define H616_PWM_XY_SRC_GATE(_pair, _reg)		\
> +struct clk_gate gate_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.bit_idx =3D H616_PWM_XY_CLK_CR_GATE_BIT,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_gate_ops,			\
> +	}						\
> +}
> +
> +#define H616_PWM_XY_SRC_MUX(_pair, _reg)		\
> +struct clk_mux mux_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D H616_PWM_XY_CLK_CR_SRC_SHIFT,		\
> +	.mask =3D H616_PWM_XY_CLK_CR_SRC_MASK,		\
> +	.flags =3D CLK_MUX_ROUND_CLOSEST,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_mux_ops,			\
> +	}						\
> +}
> +
> +#define H616_PWM_XY_SRC_DIV(_pair, _reg)		\
> +struct clk_divider rate_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D H616_PWM_XY_CLK_CR_DIV_M_SHIFT,	\
> +	.table =3D clk_table_div_m,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define H616_PWM_X_DIV(_idx, _reg)			\
> +struct clk_divider rate_x_##_idx =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D H616_PWM_CTRL_PRESCAL_K_SHIFT,		\
> +	.width =3D H616_PWM_CTRL_PRESCAL_K_WIDTH,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define H616_PWM_X_BYPASS_GATE(_idx)			\
> +struct clk_gate gate_x_bypass_##_idx =3D {		\
> +	.reg =3D (void *)H616_PWM_ENR,			\
> +	.bit_idx =3D _idx,				\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_gate_ops,			\
> +	}						\
> +}
> +
> +#define H616_PWM_XY_CLK_SRC(_pair, _reg)			\
> +	static H616_PWM_XY_SRC_MUX(_pair, _reg);		\
> +	static H616_PWM_XY_SRC_GATE(_pair, _reg);		\
> +	static H616_PWM_XY_SRC_DIV(_pair, _reg)
> +
> +#define H616_PWM_X_CLK(_idx)					\
> +	static H616_PWM_X_DIV(_idx, H616_PWM_CTRL_REG(_idx))
> +
> +#define H616_PWM_X_BYPASS_CLK(_idx)				\
> +	H616_PWM_X_BYPASS_GATE(_idx)
> +
> +#define REF_CLK_XY_SRC(_pair)						\
> +	{								\
> +		.name =3D "pwm-clk-src" #_pair,				\
> +		.mux_hw =3D &mux_xy_##_pair.hw,				\
> +		.gate_hw =3D &gate_xy_##_pair.hw,				\
> +		.rate_hw =3D &rate_xy_##_pair.hw,				\
> +	}
> +
> +#define REF_CLK_X(_idx, _pair)						\
> +	{								\
> +		.name =3D "pwm-clk" #_idx,				\
> +		.parent_names =3D (const char *[]){ "pwm-clk-src" #_pair }, \
> +		.num_parents =3D 1,					\
> +		.rate_hw =3D &rate_x_##_idx.hw,				\
> +		.flags =3D CLK_SET_RATE_PARENT,				\
> +	}
> +
> +#define REF_CLK_BYPASS(_idx, _pair)					\
> +	{								\
> +		.name =3D "pwm-clk-bypass" #_idx,				\
> +		.parent_names =3D (const char *[]){ "pwm-clk-src" #_pair }, \
> +		.num_parents =3D 1,					\
> +		.gate_hw =3D &gate_x_bypass_##_idx.hw,			\
> +		.flags =3D CLK_SET_RATE_PARENT,	\
> +	}
> +
> +/*
> + * H616_PWM_clock_src_xy generation:
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> H616_PWM_clock_src=
_xy
> + *            |_____|    |______|    |________|
> + */
> +H616_PWM_XY_CLK_SRC(01, H616_PWM_XY_CLK_CR(0));
> +H616_PWM_XY_CLK_SRC(23, H616_PWM_XY_CLK_CR(1));
> +H616_PWM_XY_CLK_SRC(45, H616_PWM_XY_CLK_CR(2));
> +
> +/*
> + * H616_PWM_clock_x_div generation:
> + *                            ________
> + *                           |        | H616_PWM_clock_x/y
> + * H616_PWM_clock_src_xy --->| /div_k |--------------->
> + *                           |________|
> + */
> +H616_PWM_X_CLK(0);
> +H616_PWM_X_CLK(1);
> +H616_PWM_X_CLK(2);
> +H616_PWM_X_CLK(3);
> +H616_PWM_X_CLK(4);
> +H616_PWM_X_CLK(5);
> +
> +/*
> + * H616_PWM_bypass_clock_xy generation:
> + *                             ______
> + *                            |      |
> + * H616_PWM_clock_src_xy ---->| Gate |-------> H616_PWM_bypass_clock_x
> + *                            |______|
> + *
> + * The gate is actually H616_PWM_ENR register.
> + */
> +H616_PWM_X_BYPASS_CLK(0);
> +H616_PWM_X_BYPASS_CLK(1);
> +H616_PWM_X_BYPASS_CLK(2);
> +H616_PWM_X_BYPASS_CLK(3);
> +H616_PWM_X_BYPASS_CLK(4);
> +H616_PWM_X_BYPASS_CLK(5);
> +
> +struct clk_pwm_data {
> +	const char *name;
> +	const char **parent_names;
> +	unsigned int num_parents;
> +	struct clk_hw *mux_hw;
> +	struct clk_hw *rate_hw;
> +	struct clk_hw *gate_hw;
> +	unsigned long flags;
> +};
> +
> +#define CLK_BYPASS(h616chip, ch) ((h616chip)->data->npwm + (ch))
> +#define CLK_XY_SRC_IDX(h616chip, ch) ((h616chip)->data->npwm * 2 + ((ch)=
 >> 1))
> +static struct clk_pwm_data pwmcc_data[] =3D {
> +	REF_CLK_X(0, 01),
> +	REF_CLK_X(1, 01),
> +	REF_CLK_X(2, 23),
> +	REF_CLK_X(3, 23),
> +	REF_CLK_X(4, 45),
> +	REF_CLK_X(5, 45),
> +	REF_CLK_BYPASS(0, 01),
> +	REF_CLK_BYPASS(1, 01),
> +	REF_CLK_BYPASS(2, 23),
> +	REF_CLK_BYPASS(3, 23),
> +	REF_CLK_BYPASS(4, 45),
> +	REF_CLK_BYPASS(5, 45),
> +	REF_CLK_XY_SRC(01),
> +	REF_CLK_XY_SRC(23),
> +	REF_CLK_XY_SRC(45),
> +	{ /* sentinel */ }
> +};

We'll probably need a way to tie these static definitions to a particular
instance of the unit for a given chip. But I guess that can be done later
when adding more chips to the driver.

I'm not too versed in the clk and pwm APIs but the rest generally looks good
to me.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--33pU5tb6RmcLLlSB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnX4j4ACgkQhP3B6o/u
lQwdTQ//ch93yoRTG9gLChC5/R+m1lTPe1/tIOk1Vi4GIILWe8IA+aJSf72kNsRx
vMFalFHp44nFK4GIRAfx+r9zrZ+mLR3lQM4wsxGp2K65pPrmciw5qSky1v0l1ZRC
eCOafd2S2ZBYq0Epzb1xje7piuqZp2ZDgbrquUWMeE39PcpHcC/miVPWTnbGB/5w
VBPFbIfLlMNvGcv57l0t3zK8X3HnK60Tjlaqdi/iKdRAewm77tM+5SgyeMU4P7yd
BGjiJn3FzonBTt64mWGSyjW1vjNAhiPRHklOkAUvbfBdRotlXoTZZieokinELK5v
9/+38h/bpAlObLlIEmOCBAM4EPfGvVeX3iWIfiAoaxH7bh5jU6G5EuR4q+zWJRP8
yNCW8vyn6jgAlq9p9hVc8J72mUvL8s1qidgxnErW583/wKhQY6au92l5uZkYykLi
5eNF8jian3f/Hnh6ZweXfD2/SLFL4I+zO9Ez2jX3d4z748JrH9XiV6odQlyqHcYT
duFqWWDNGD83wa+1/7yDeSN05u+Z/t3F56qJBycA/ESiOJneTHhccXnbNpKsLPpQ
MeHraPw+D/tYUAQMxdeywU2HkVp704gGPOxOZn77ga6dSLr+As4eFa6eYgrDeD8R
VJXulqovR4Ob8C0tyrWn8LYJTGR+HTngeHVWweyrJ6vtYqJcdCI=
=v+2L
-----END PGP SIGNATURE-----

--33pU5tb6RmcLLlSB--

