Return-Path: <linux-pwm+bounces-8346-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HNIFtR+wWknTgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8346-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 18:56:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE312FAAA4
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3213221BA8
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609F3BD634;
	Mon, 23 Mar 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TXowK2Ek"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522613B775A
	for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2026 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283238; cv=none; b=h3HRApXLdgxNdetm/psymz2Ky+D8UEg5AH2BwZL7yqYJScT6g1nLP7NVMibxiz7dnnomZcECl2R+iFFy5o9qX3jLuCLrEqtwoBYtmJeoRaqhwLqZB9+OxulsM/CjcR3mM1AKbkKC2606g+gGY8dAIeVynxrb2hlaaRzokkcIalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283238; c=relaxed/simple;
	bh=negpr9ymqdcFH8ARZ0fVPTcU/bLZrgK4U2z5BTwZzQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdzZXuPdXvU7xcpOfADzuBjTiGeDmTyvU45u3oT7wj1tz7/vJEVBGKpA8/mAxbvuh/skha+hPpDJOu/WpSIw/esm0Mu2MpE0/ws4AD3KdSkG0qJO9GTgwzqfXLD26BCYkvkadv0C7dI3G/OCzZ+1mLROF82dGhPPeHxtq2AWyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TXowK2Ek; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9CFEAC58081;
	Mon, 23 Mar 2026 16:27:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B55FA5FEF6;
	Mon, 23 Mar 2026 16:27:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E6CE10450D30;
	Mon, 23 Mar 2026 17:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774283232; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rNB46l86KhEE2SPNXttKfCE0ClL7ezUhxWzUZSM4r9U=;
	b=TXowK2EkL0zs85jOe3inW1IcVG7tXjhR3+1Xx8pd1rwRB0Pvka2AW6OGjwybZLXNw4YxLr
	2kfDMnsPnl06UmYne/mLGaxTNDdIo/D/QxDsDMuR3mrBm9vhAF3nNIS3dlOjN34a4wLFg5
	QItJ4JvuZ7k2USxBHlnPEV9Ac8+BTYAsVaAqHEJOQ0zeErFQF3+Rk+CWBZYbzZ2Ucaypyi
	d0vlXkSTYbmlPaGd0Qe8GsyRsjuluHjsvLlnJoOaFXHCsPjHv1340FR9Nv8zp1s1mTDE1f
	zc7wxTzTjYtHknt4bpQ2BbllBHvwnE2iti57YAJeXR+zOknZaFI1eR4JsiFjtg==
Message-ID: <b47801f9-3828-4c68-992c-e85373576f3d@bootlin.com>
Date: Mon, 23 Mar 2026 17:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Introduce Allwinner H616 PWM controller
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260305091959.2530374-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8346-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAE312FAAA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 05/03/2026 à 10:19, Richard Genoud a écrit :
> Allwinner H616 PWM controller is quite different from the A10 one.
> 
> It can drive 6 PWM channels, and like for the A10, each channel has a
> bypass that permits to output a clock, bypassing the PWM logic, when
> enabled.
> 
> But, the channels are paired 2 by 2, sharing a first set of
> MUX/prescaler/gate.
> Then, for each channel, there's another prescaler (that will be bypassed
> if the bypass is enabled for this channel).
> 
> It looks like that:
>              _____      ______      ________
> OSC24M --->|     |    |      |    |        |
> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>             |_____|    |______|    |________|
>                            ________
>                           |        |
>                        +->| /div_k |---> PWM_clock_x
>                        |  |________|
>                        |    ______
>                        |   |      |
>                        +-->| Gate |----> PWM_bypass_clock_x
>                        |   |______|
> PWM_clock_src_xy -----+   ________
>                        |  |        |
>                        +->| /div_k |---> PWM_clock_y
>                        |  |________|
>                        |    ______
>                        |   |      |
>                        +-->| Gate |----> PWM_bypass_clock_y
>                            |______|
> 
> Where xy can be 0/1, 2/3, 4/5
> 
> PWM_clock_x/y serve for the PWM purpose.
> PWM_bypass_clock_x/y serve for the clock-provider purpose.
> The common clock framework has been used to manage those clocks.
> 
> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
> This is needed for example by the embedded AC300 PHY which clock comes
> from PMW5 pin (PB12).
> 
> Usually, to get a clock from a PWM driver, we use the pwm-clock driver
> so that the PWM driver doesn't need to be a clk-provider itself.
> While this works in most cases, here it just doesn't.
> That's because the pwm-clock request a period from the PWM driver,
> without any clue that it actually wants a clock at a specific frequency,
> and not a PWM signal with duty cycle capability.
> So, the PWM driver doesn't know if it can use the bypass or not, it
> doesn't even have the real accurate frequency information (23809524 Hz
> instead of 24MHz) because PWM drivers only deal with periods.
> 
> With pwm-clock, we loose a precious information along the way (that we
> actually want a clock and not a PWM signal).
> That's ok with simple PWM drivers that don't have multiple input clocks,
> but in this case, without this information, we can't know for sure which
> clock to use.
> And here, for instance, if we ask for a 24MHz clock, pwm-clock will
> requests 42ns (assigned-clocks doesn't help for that matter). The logic
> is to select the highest clock (100MHz) with no prescaler and a duty
> cycle value of 2/4 => we have 25MHz instead of 24MHz.
> And that's a perfectly fine choice for a PMW, because we still can
> change the duty cycle in the range [0-4]/4.
> But obviously for a clock, we don't care about the duty cycle, but more
> about the clock accuracy.
> 
> And actually, this PWM is really a PWM AND a real clock when the bypass
> is set.
> 
> This series is based onto v6.19-rc4
> 
> NB: checkpatch is not happy with patch 2, but it's a false positive.
> It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
> it's more readable like that, I prefer keeping it that way.
> 
> NB2: for geopolitical reasons, I didn't re-use the old series that Paul
> was referring to.
> 

Hi Uwe, do you plan to grab this series or does it needs some further 
reviews?

Regards,
Richard

> Changes since v3:
> - gather Acked-by/Tested-by
> - fix cast from pointer to integer of different size (kernel test robot
>    with arc platform)
> - add devm_action for clk_hw_unregister_composite as suggested by Philipp
> - remove now unused pwm_remove as suggested by Philipp
> 
> Changes since v2:
> - use U32_MAX instead of defining UINT32_MAX
> - add a comment on U32_MAX usage in clk_round_rate()
> - change clk_table_div_m (use macros)
> - fix formatting (double space, superfluous comma, extra line feed)
> - fix the parent clock order
> - simplify code by using scoped_guard()
> - add missing const in to_h616_pwm_chip() and rename to
> h616_pwm_from_chip()
> - add/remove missing/superflous error messages
> - rename cnt->period_ticks, duty_cnt->duty_ticks
> - fix PWM_PERIOD_MAX
> - add .remove() callback
> - fix DIV_ROUND_CLOSEST_ULL->DIV_ROUND_UP_ULL
> - add H616_ prefix
> - protect _reg in macros
> - switch to waveforms instead of apply/get_state
> - shrink struct h616_pwm_channel
> - rebase on v6.19-rc4
> 
> Changes since v1:
> - rebase onto v6.19-rc1
> - add missing headers
> - remove MODULE_ALIAS (suggested by Krzysztof)
> - use sun4i-pwm binding instead of creating a new one (suggested by Krzysztof)
> - retrieve the parent clocks from the devicetree
> - switch num_parents to unsigned int
> 
> Richard Genoud (4):
>    dt-bindings: pwm: allwinner: add h616 pwm compatible
>    pwm: sun50i: Add H616 PWM support
>    arm64: dts: allwinner: h616: add PWM controller
>    MAINTAINERS: Add entry on Allwinner H616 PWM driver
> 
>   .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>   MAINTAINERS                                   |   5 +
>   .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>   drivers/pwm/Kconfig                           |  12 +
>   drivers/pwm/Makefile                          |   1 +
>   drivers/pwm/pwm-sun50i-h616.c                 | 936 ++++++++++++++++++
>   6 files changed, 1019 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pwm/pwm-sun50i-h616.c
> 
> 
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808


