Return-Path: <linux-pwm+bounces-9151-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPuBAmO8FGpUPwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9151-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 23:17:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF55CED7E
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 23:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94983007F75
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917734EF15;
	Mon, 25 May 2026 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DceHwUns"
X-Original-To: linux-pwm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86E2DAFCB;
	Mon, 25 May 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743790; cv=none; b=ud+MxcNLUqq3dxE65ZrdJaYu46XwXz1M31c769hKY8ovr8tdQr6uYFlPA4et3AlJDdQh5ItY4SmD+ZNPW/2i7dlOeag9c00gLQMUJhxrZAsOmwJAPKNXpNIc1vsiKz9j+xFGYfLT+dbQcSRocMuSN2Cml1TipKHadhYsP5sNJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743790; c=relaxed/simple;
	bh=Q3KznSmPGXShIXkpUxQ+T6UiVEFFgAzT1PTN8IZQDcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVBjsQYAlqbI8UHRDgjAXfYiatojlAVmvM43h4YAyvD98HgYOyBArhku0WoV9jgC8yO6FHWXxVthSmxZ9RvPYMtugLOiPPCmN7QK74Ij6Xd9BG9INvV4b+niZlEy+0M0d6dIzgZEVU/kp6cMQWbO0Cv1vjf/q/a6m25xCkMZzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DceHwUns; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB001758;
	Mon, 25 May 2026 14:16:21 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29713F632;
	Mon, 25 May 2026 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779743786; bh=Q3KznSmPGXShIXkpUxQ+T6UiVEFFgAzT1PTN8IZQDcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DceHwUnsr+h9yMlBWX/oFjrCB/CAS+EBlWKkxrF7rijrwncPuyE1VOcEfF6eFEnUV
	 ERbPoaErMvi9f6rVI+fnr6fCMje0FFMj1FD+ANSgdfBohsCTdD5ydudgxRAk+BDj2Q
	 56tLHKt09r4Vai3S95SsZnNzDvx/rH9y9TwVIxEw=
Date: Mon, 25 May 2026 23:15:26 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Paul Kocialkowski <paulk@sys-base.io>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, John Stultz
 <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
 bigunclemax@gmail.com, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Introduce Allwinner H616 PWM controller
Message-ID: <20260525231526.0c5d9a10@ryzen.lan>
In-Reply-To: <20260416134037.3160537-1-richard.genoud@bootlin.com>
References: <20260416134037.3160537-1-richard.genoud@bootlin.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-9151-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.przywara@arm.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ryzen.lan:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 5EBF55CED7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 15:40:33 +0200
Richard Genoud <richard.genoud@bootlin.com> wrote:

Hi Richard,

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
>             _____      ______      ________
> OSC24M --->|     |    |      |    |        |
> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>            |_____|    |______|    |________|
>                           ________
>                          |        |
>                       +->| /div_k |---> PWM_clock_x
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_x
>                       |   |______|
> PWM_clock_src_xy -----+   ________
>                       |  |        |
>                       +->| /div_k |---> PWM_clock_y
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_y
>                           |______|
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

Didn't we discuss this choice of "highest clock" before? I dimly
remember asking whether we cannot use a least-error approach, so
considering all clocks and choosing the one which matches the target
best?

> And that's a perfectly fine choice for a PMW, because we still can
> change the duty cycle in the range [0-4]/4.
> But obviously for a clock, we don't care about the duty cycle, but more
> about the clock accuracy.

Thanks for your research into this and summarising this up! I see your
point, and always found the choice to use nanoseconds in PWM somewhat
problematic, especially when looking at the rounding errors.
And while turning the PWM into a clock provider looks like a clever
solution, this is somewhat arbitrary - why do we have this for those
SoCs and not the other (older) ones? The 24 MHz != 1/42ns problem is
the same there.
What also bugs me a bit is also that this is actually a decision
affecting the generic hardware devicetree description of the system,
but its rooted in a Linux implementation detail (ns resolution periods).

So before we consider going this route:
- Can we change the internal interface in Linux, maybe introducing
  some special interface from pwm-clock to the pwm drivers, to convey
  frequencies directly, instead of period lengths?
- Can we add an optional interface for pwm drivers in general, to use
  a frequency / duty-cycle pair to describe a PWM setup? I would naively
  think those to be some kind of natural PWM parameters.
- Can we at least add a picosecond precision interface? That doesn't
  solve the rounding issue for those number not only divisible by
  2 or 5 (like 24), but at least it seems to mitigate it:
  24 MHz => 41666 ps => 24.000384 MHz

I see that having a clock provider seems like a more sustainable and
fitting choice, but as mentioned it's something that affects the DT
description, so I don't want to change that lightly.

Cheers,
Andre

> And actually, this PWM is really a PWM AND a real clock when the bypass
> is set.
> 
> This series is based onto v7.0
> 
> NB: checkpatch is not happy with patch 2, but it's a false positive.
> It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
> it's more readable like that, I prefer keeping it that way.
> 
> Changes since v5:
> - remove trailing junk after commit message in patch 4
> - remove Tested-by when it doesn't make sense.
> (sorry for the noise)
> 
> Changes since v4:
> - Fix a bug on bypass for channels greater than 1
> - add colons to clarify 2 debug messages
> - switch from H616 to sun8i prefix (in code, filename, module name)
> - fix consistency issues in macro parameters
> - rename some macros with a confusing naming
> - rebase on v7.0
> 
> Changes since v3:
> - gather Acked-by/Tested-by
> - fix cast from pointer to integer of different size (kernel test robot
>   with arc platform)
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
> - add/remove missing/superfluous error messages
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
>   dt-bindings: pwm: allwinner: add h616 pwm compatible
>   pwm: sun8i: Add H616 PWM support
>   arm64: dts: allwinner: h616: add PWM controller
>   MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver
> 
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>  MAINTAINERS                                   |   5 +
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun8i.c                       | 938 ++++++++++++++++++
>  6 files changed, 1021 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
> 
> 
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> 


