Return-Path: <linux-pwm+bounces-8644-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD5nIJYW5mnCrQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8644-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:05:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB442A69E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0BD303102C
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98A39EF09;
	Mon, 20 Apr 2026 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JznioJN5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD81E5724;
	Mon, 20 Apr 2026 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686563; cv=pass; b=X7RPqDugmrC/xhDLPDBZYzJRj5WF7lfQ6ay1NNfFW7Dr28tB/WRG41xN2XybU49x0bsCdzkaHNt25OkAcQ6WBqIJt91PyPXbMck2OuRle672WlNguHDLXQkH8HZi4xPVdVmugJDrwrXFx/KyHgZcqf2BZ+Us+b0N3GdOapg8s6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686563; c=relaxed/simple;
	bh=RcPc1OlRKwWMBhXzycGc+rGrbxc0ZUaYQ6Zh6lfuvmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjjHD28xLE3+f67qIfDi8bqVitJoldRsvnpT99PYQ3LG0qr49cn2UhkIjKeXOlNN/77BOk3Fdzdeoo8l/3gq7h34MSDU+3z0c85gMUKGLL+tUQuASpudg54dMQ3QE7sLOm5TxtwPzqLjXMn2uANf1Ppz1fsuRYvW2+JjIJ0tA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JznioJN5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776686532; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D4wV3c/yZdK1eU7KT/phx0dwslxU6lVYK+XH3o6odSa2T2bsmVNuPGkpPokO9odCGebd1VL6x+JQmJochSSU2+ZygtUA8PJjzyUuX0A9Qrl0XWGmVojg77UaxS/3Sny5w7IefWTfwjsdGx5f10vKP7mNZOOq3/lOb08dGJ1R+HE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776686532; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x5mFNmk8QCjW303+12nnTbEnOf0gTpLfX0AgHqHSXVk=; 
	b=O4SRXC9WiJ06iz4jU46oIS5HKKrQZDbZtgXUWFYVGQe2rswu3bj3BkygH+aWXgqxyyPaddoz9B1yPHO/KFVDzIh7GqYMIRjQejUCYGzFYaYlP5w7SL1/EArLcQBvCc9zv7INEtZGigKIoJ6D0I7RXLUuoYFc0bOQaEYeUm3rmnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776686531;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=x5mFNmk8QCjW303+12nnTbEnOf0gTpLfX0AgHqHSXVk=;
	b=JznioJN5R98NhLocaRwmQa8qpR7kvDOKjtwdelsT7L3l+7wbXLNSQEEGVvn+u95v
	UZwrLnpD0cFG5havrVDsKzAvRnbR7/565GTMHbXmCLQpi0wwBdn9P0HWyPwh07tJV4A
	s58b6CDl+WyyoJFKqUp6qGkh+0pcHFfjfmEpk9Mw=
Received: by mx.zohomail.com with SMTPS id 1776686529459133.0396587303926;
	Mon, 20 Apr 2026 05:02:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] counter: Add rockchip-pwm-capture driver
Date: Mon, 20 Apr 2026 14:02:03 +0200
Message-ID: <oA6h2S_2RQulBS91CKXxhw@collabora.com>
In-Reply-To: <20251206093419.40067-1-wbg@kernel.org>
References:
 <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
 <20251206093419.40067-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8644-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01CB442A69E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

finally got an opportunity to work on this again.

I'll respond to some things in-line. If a review isn't directly
addressed, you can assume I acknowledge it and will address it
in the next revision with no further comment needed.

On Saturday, 6 December 2025 10:34:17 Central European Summer Time William Breathitt Gray wrote:
> > +struct rockchip_pwm_capture {
> > +	struct rockchip_mfpwm_func *pwmf;
> > +	struct counter_device *counter;
> 
> Is this structure member used at all? If not, you should just remove it.

The counter member is used in the interrupt handler. I actually
noticed that I request the interrupt before pc->counter is set,
so if an interrupt fires before the probe function finishes then
I think the handler would run with a NULL counter member. Oops,
I'll rectify that.

> > +	bool is_enabled;
> 
> Does this device offer some way to probe whether PWM capture mode is
> enabled? I suspect so, because I see PWM_ENABLE.pwm_en enables the
> channel and PWM_CTRL.pwm_mode selects capture mode, so perhaps we're
> able to read the current state of those registers. If you're able to
> read those registers to determine the enable state, I'd suggest wrapping
> that into a helper function and calling it when you need to determine
> whether the capture mode is currently enabled.

I'm going to read the hardware state in the next revision, you're right
that this is generally a better idea.

> 
> If we're not able to probe the enable state, is it safe to assume we're
> in a disabled state when the module loads, or should we ensure it by
> unconditionally disabling PWM capture mode during
> rockchip_pwm_capture_probe()?

In my next revision, I've now modified it to mfpwm_acquire if the hardware
state has the counter enabled during probe. This sounds niche but I'm also
doing this on the PWM output side, where Uwe rightfully pointed out that
a bootloader may have enabled PWM output in hardware and Linux needs to
recognise that state without any heavy-handed actions. For the counter
PWM capture side, resetting it to a known state wouldn't be disruptive in
the same way as it would be for PWM output, but I think it's a good idea
to keep the state as-is since we can read it.

> [... snip ...]

> > +static int rkpwmc_count_read(struct counter_device *counter,
> > +			     struct counter_count *count, u64 *value)
> > +{
> > +	struct rockchip_pwm_capture *pc = counter_priv(counter);
> > +
> > +	guard(spinlock)(&pc->enable_lock);
> > +
> > +	if (!pc->is_enabled) {
> > +		*value = 0;
> > +		return 0;
> > +	}
> 
> I don't think there's a need to check whether capture mode is disabled.
> The user should be aware of the enable state of the Count by checking
> the respective "enable" attribute; and if they ignore that, a value of
> "0" doesn't inherently tell them that the Count is disabled which makes
> it moot to do so. I'd suggest just removing this check entirely and
> returning the register values unconditionally.

I see what you're going for, but if the counter isn't enabled, we can't
rely in the counter having an mfpwm_acquire, and consequently, we can't
rely on the PWM core clock being on, which is required for reading the
registers.

In my next revision, I'll still be returning 0 if the counter is disabled,
but the is_enabled member is gone, so there's a new function called
rkpwmc_acquire_if_enabled to still make this correct.

I could of course also extend the core driver to let me poke at these
non-shared registers without exclusive control over the hardware, but
that may be more trouble than it's worth.

I'll also no longer return 0 on bogus count IDs when the counter is
disabled.

> > +
> > +	switch (count->id) {
> > +	case COUNT_LPC:
> > +		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_LPC);
> > +		return 0;
> > +	case COUNT_HPC:
> > +		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_HPC);
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct counter_ops rkpwmc_ops = {
> > +	.count_read = rkpwmc_count_read,
> > +};
> 
> You should implement a signal_read() callback if its possible to probe
> the current state of PWM Clock. You should implement action_read() if
> its possible to probe the current polarity of "pwm_in" in order to set
> which Synapse is currently active.

Unfortunately, it doesn't seem like the hardware allows direct access to
read the signal. "pwm_in" as it appears in the block diagram seems to be
an entirely internal signal that's not accessible through MMIO.

Thank you for the reviews!

Kind regards,
Nicolas Frattaroli

> 
> William Breathitt Gray
> 
> [^1] https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf
> 





