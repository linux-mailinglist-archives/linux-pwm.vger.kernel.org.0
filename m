Return-Path: <linux-pwm+bounces-8764-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIxHM6ZY+GlStQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8764-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:28:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 724894BA373
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A1863034319
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D183368A8;
	Mon,  4 May 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="d12UfRqJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74C332EAE;
	Mon,  4 May 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883172; cv=pass; b=BFL6ttljz0NF6tO9Zcpo/ehXcOAnmcpycRpwaBo6weqBiGKMZ5BaOim9HZ63+gQgALPQcpyy3FnJKpzTue4oQizsadII72MR234zJ5N2vKcpd0fybthn6X2Yz1z/Xnxk6jyfBvEnaLrrWX2xie46sImmvijn7OOlA7ZX4eAXQ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883172; c=relaxed/simple;
	bh=i5t++v2Jtn7zwNOur7LCFfa0rQjEoxfXEyHSyDKEBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA318zync/3tmiz+9hQ5KSLP+zpZbJXu9eoNhpCPOLctLhn6rlkcjHnv6klkHyIAymc1uDUFhV1ROuOvDYJ+pAZKBErQ/SOwt411tsnzNWAnPrwU32xTgUeBGja/qUK5LqLdxPc0ii9kARTJN6VEVakTpOv3LHJDqEIu+vVjeOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=d12UfRqJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1777883135; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZDOJ1iMS6BbjMpR1z418oEEtC0vqd6UCTO8avOjxc9wKbIZvKMysUmvzYNo3OKqQRYH5hXNMTe6aN5S9gmzgIZDjsTH79Dpl3o0RahmWU/liu8PTQlduTe/TV+97iKlCALhnCQbNgO2qH+/Zw2pkfR4mQTBweCEjcVEKAlU3GTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777883135; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z489JKPDHOfXIXMi7nlez8unyEO4hm8q1SkFaDGqzso=; 
	b=HM5LnyZzYOs7p1xoYLDvpzbLC6UwWoMjy5ahsaqaNOLhmCPuQ/1c+7cLq2M4qjyc5hO88K40GRqrTOFt7UsB6+TFkZjdyQ2cnUhPuk5YkAKD/9yrplzjwTEnCy40WuQcC/0hPajSr50LihYshcN2cLYnYgSqjwTFxqopnqw019A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777883135;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=z489JKPDHOfXIXMi7nlez8unyEO4hm8q1SkFaDGqzso=;
	b=d12UfRqJgDEnkLM63lrzTbsNQ4liJzdOrXDlr8ZK58jJ3QQw8+/+Q/Zon2veh6xG
	vaAW1Z9AKv8Xmap8IiniyV5tNQNRldwzWazlMIDiog4lqZzPv31i53xeOpgNaJvQ9fH
	+m4SpSYaj8LCg+hPTQordubO0FlnfZSvkX3qY/wI=
Received: by mx.zohomail.com with SMTPS id 1777883133012498.91425057032257;
	Mon, 4 May 2026 01:25:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, Damon Ding <damon.ding@rock-chips.com>,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Date: Mon, 04 May 2026 10:25:27 +0200
Message-ID: <4Sq7M_BvSOqHZS-Mve-Dmg@collabora.com>
In-Reply-To: <20260503104624.459765-1-wbg@kernel.org>
References:
 <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
 <20260503104624.459765-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 724894BA373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-8764-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid,rock-chips.com:url]

On Sunday, 3 May 2026 12:46:23 Central European Summer Time William Breathitt Gray wrote:
> On Mon, Apr 20, 2026 at 03:52:41PM +0200, Nicolas Frattaroli wrote:
> > Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> > PWM capture functionality.
> > 
> > Add a basic driver for this that works to expose HPC/LPC counts and
> > state change events to userspace through the counter framework. It's
> > quite basic, but works well enough to demonstrate the device function
> > exclusion stuff that mfpwm does, in order to eventually support all the
> > functions of this device in drivers within their appropriate subsystems,
> > without them interfering with each other.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Hi Nicolas,
> 
> Forgive me if I asked this before, but I'm having trouble finding it
> online: do you have a link to a publicly available RK357 technical
> reference manual? I think that will help me better understand how this
> PWMv4 IP works.

Hi!

The RK3576 TRM isn't public, but the same hardware is used in the
RK3506, which does have its TRM online from Rockchip themselves:
https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf

See chapter 31 of this. Right now, this counter driver implements
what's briefly described in Chapter 31.3.1 "Capture Mode".

> 
> Regardless, some comments inline below from my current understanding.
> 
> > +static struct counter_signal rkpwmc_signals[] = {
> > +	{
> > +		.id = 0,
> > +		.name = "PWM Clock"
> > +	},
> > +};
> 
> If the capture mode is used to measure the duty cycle of the PWM input,
> then we actually have two Signals to define here: "PWM Clock" and "PWM
> Input".
> 
> I imagine the capture mode waveforms look something like this:
> 
>                __    __    __    __    __    __    __
>     clk     __|  |__|  |__|  |__|  |__|  |__|  |__|  |__
>     
>                       __________________ LPC: 2 edges ____
>     pwm_in  _________|   HPC: 3 edges   |____________|
> 
> So the level of the pwm_in signal is counted each rising edge of clk;
> the number of clk edges while pwm_in is high is the HPC count, whereas
> the number of clk edges while pwm_in is low is the LPC count.

Correct. In fact, your diagram is very close to what's in the
aforementioned chapter.

> 
> In the Generic Counter paradigm, this would look like the following:
> 
>     Signals             Synapses              Counts
>     =======             ========              ======
>     +-----------+                               _______________________
>     |           | <---- "Rising Edge" ---+---> /                       \
>     |"PWM Clock"|                        |     |"High Polarity Capture"|
>     |           |                    +---|---> \                       /
>     +-----------+                    |   |      -----------------------
>                                      |   |
>     +-----------+                    |   |      _______________________
>     |           |                    |   +---> /                       \
>     |"PWM Input"|                    |         | "Low Polarity Capture |
>     |           | <---- "None" ------+-------> \                       /
>     +-----------+                               -----------------------
> 
> The key idea is that the clock and PWM input Signals are associated to
> both Counts (HPC and LPC) through their respective Synapses. However,
> while the clock Synapse ("Rising Edge") indicates the clock Signal
> state triggers updates in the Counts, the PWM input Synapse ("None")
> indicates the PWM input Signal state does not trigger but is simply
> evaluated to determine the new Count value.
> 
> > +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +};
> 
> To simplify my above example, I assumed that the HPC and LPC counts are
> only updated on rising edges of the clock Signal. If the Count values
> actually update on both edges, then you don't need to make a change
> here. Otherwise, change the "both edges" enum constant to "rising edge"
> or "falling edge" as required.

I checked the TRM and couldn't see any word on whether the count
is updated on the clock's rising edge only, but judging by Damon
Ding's review, I assume that is the case. I'll modify it to
reflect that.

> > +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> > +	{
> > +		.actions_list = rkpwmc_hpc_lpc_actions,
> > +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> > +		.signal = &rkpwmc_signals[0]
> > +	},
> > +};
> 
> Add a Synapse here for the "PWM Input" Signal.
> 
> You should also implement an action_read() callback. Check the value of
> synapse->signal->id to determine which Signal is associated to the
> Synapse and set the respective action; i.e. for the PWM clock set
> COUNTER_SYNAPSE_ACTION_BOTH_EDGES, while for the PWM input set
> COUNTER_SYNAPSE_ACTION_NONE.

Will do!

> 
> > +static const enum counter_function rkpwmc_functions[] = {
> > +	COUNTER_FUNCTION_INCREASE,
> > +};
> 
> I wonder if we need a new enum counter_function constant to express
> what's happening in this driver. In theory, the
> COUNTER_FUNCTION_INCREASE represent a Count whose value only increases,
> but what we're describing here is more of a duty cycle sample, right?

Yeah, that's a great point. I think we can say it "increases",
in that either HPC or LPC are increased by the pwm_clk signal
based on the value of the pwm_in signal by the hardware.

But of course, the two counts are limited by the full period
of the PWM waveform. So reading a counter will give the
reader a snapshot view of the high cycles vs. low cycles of
the last observed PWM waveform period, which is both a duty
cycle sample and a period length sample, as the counts are
in clock cycles, so if we add the counts together we get the
PWM signal period in clock cycles.

This is also why you saw me convert counts to nanoseconds in a
previous revision; it felt like I should decouple it from the clock,
but I think the can of worms that this opens isn't worth it.

> 
> I haven't made up my mind on this, so for now you can stick with
> COUNTER_FUNCTION_INCREASE. I'll reconsider it in the next revision.
> 
> > +static int rkpwmc_enable_write(struct counter_device *counter,
> > +			       struct counter_count *count,
> > +			       u8 enable)
> > +{
> > +	struct rockchip_pwm_capture *pc = counter_priv(counter);
> > +	int ret;
> > +
> > +	ret = mfpwm_acquire(pc->pwmf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!!enable != rkpwmc_is_enabled(pc->pwmf)) {
> 
> The Counter subsystem gurantees enable is a boolean value so there's no
> need for the double negation here in the conditional.
> 
> Also, instead of checking if the enable value is different from
> rkpwm_is_enabled(), check if it is the same and exit early. That will
> avoid the large conditional block as what you have inside can now move
> outside after the conditional check.

Good call, will do.

> 
> > +		if (enable) {
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> > +					 PWMV4_EN(false));
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL,
> > +					 PWMV4_CTRL_CAP_FLAGS);
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
> > +					 PWMV4_INT_LPC_W(true) |
> > +					 PWMV4_INT_HPC_W(true));
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> > +					 PWMV4_EN(true) | PWMV4_CLK_EN(true));
> > +
> > +			ret = clk_enable(pc->pwmf->core);
> > +			if (ret)
> > +				goto err_release;
> > +
> > +			ret = clk_rate_exclusive_get(pc->pwmf->core);
> > +			if (ret)
> > +				goto err_disable_pwm_clk;
> > +
> > +			ret = mfpwm_acquire(pc->pwmf);
> > +			if (ret)
> > +				goto err_unprotect_pwm_clk;
> > +		} else {
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
> > +					 PWMV4_INT_LPC_W(false) |
> > +					 PWMV4_INT_HPC_W(false));
> > +			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> > +					 PWMV4_EN(false) | PWMV4_CLK_EN(false));
> > +			clk_rate_exclusive_put(pc->pwmf->core);
> > +			clk_disable(pc->pwmf->core);
> > +			mfpwm_release(pc->pwmf);
> > +		}
> > +	}
> > +
> > +	mfpwm_release(pc->pwmf);
> 
> The call to mfpwm_release() in the else block is redundant because it is
> called immediately again here.

It's actually intentional, and not redundant. The if (enable) branch
does an mfpwm_acquire() so that as long as the counter functionality
is enabled, the use count remains > 0. This way, the PWM output
driver can't tell the mfpwm driver that it'd like to have exclusive
use of the PWM device now, as the counter driver is claiming it.

To balance this, the else block here needs to release it.

The release outside the else block is to balance the acquire
earlier in the function, the pair of which is there to ensure
mfpwm has powered on the hardware and associated clocks for
the register reads and writes.

Admittedly, I could get rid of the additional mfpwm_acquire
in the if (enable) branch by letting the function entry acquire
"leak" on purpose, by getting rid of the function end mfpwm_release.
But this feels less obvious to me than the current way. I'll
definitely add comments though to indicate what's going on, and
maybe even define a cleanup.h guard() class for the function
level acquire-release.

Thanks for the review, and especially the explanations.

Kind regards,
Nicolas Frattaroli

> 
> William Breathitt Gray
> 





