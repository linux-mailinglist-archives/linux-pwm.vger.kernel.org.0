Return-Path: <linux-pwm+bounces-9535-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hiv4CWDNR2orfgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9535-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:55:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E6703A51
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="e+7lz/PP";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9535-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9535-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648BC309A6DD
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC343F889E;
	Fri,  3 Jul 2026 14:48:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8135AC20
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 14:48:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090134; cv=none; b=oMzGw/uMzDdwCvrrE3ns/uOfdLtnn+kVnaKJKnoT2IFK6MHYEcS+hmHsVDVeZcf27FZIsTBM7/YwP9fPGiHrh6XEaQOX5K97esZX1a4Dwt0tHcJZztgEV2JLID1g4wyrf8tTtjB2G+9G7apSxLw9A+dhQaaKBio/CYHpTFb1ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090134; c=relaxed/simple;
	bh=HqK0apG2WBVp9keeHQN4EfAdivjOtfyBmEcKP8064hw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riRQIpcselYotoLBdJr7x1aHKzADeDkZvljjPEuRGuEKB9irJ/CtHpsaDMTPBsaL63zFn0+28om6Qv2/xJCwZD8cm/sAFnxFlPh4Xkdb3tJU9EeTKb1I0/6h8icWS4603wnnCtHuwLG2Y8Kty5ZB6DW5I5hs/tzzpLePhVcr018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e+7lz/PP; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c733f15aso5958075e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783090131; x=1783694931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtbeAb4anjju2Gg5Hr2svmQH8LAj1CgUb05x/8fx3ZI=;
        b=e+7lz/PPnTzecXOAHSvZyU3R8gflwVZHQobEZRvjqS0VJt1OD2OxEdy7uypE1VSXhW
         Wo2KlJRzSCCadbsZ3g6xor/zF/CAXgJy6mmpT3K1jfMsg8F79YWpFcfLzyeZzCUsqyAv
         Z38B0wbs9LazAhImGpTwxhyrRbFe+rB6YqhnWSPxRIwvZ6bxF6qt9zg6794DgkVcD8GA
         2QwPxfSpHgUdlj55ugttafXDrD1xYpkTFOjhBZqJZtQDe+jOxlrDvErQrG0kxvvBIxxJ
         L7A0zCVWI1NwbNMbs4zpW+/VO1jsEH50fgePG27cYspi5SJLTDHDEESLHvoSWn3LNgj3
         +ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090131; x=1783694931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtbeAb4anjju2Gg5Hr2svmQH8LAj1CgUb05x/8fx3ZI=;
        b=p84aDVez4rfeSGiT6XIAfW2msy7mW8GlfnPFaK2H8ppR1uSRlL6gf0W5QYDxOhrcH5
         QJIlJVamyDzLVUnK6+h+TuugoCAsAgcZiE/X6EUOnOk3VLn7sb8spjaGvsoiLEGDKNPD
         1xjejoHUAoNAjaZPUzfoiGl8bdw9VGJD45cgKEV5Obi7sABEd43gNMT45btSkUhS0mYZ
         0gSnJZ5G8jsQUzCaZBg5RxPdQTKVBs+F6S9N3X5NOC7/PTfSCsS4U45SYJfQb0rr39Wh
         oCxfZ52tFca+wlXr/bsC7MR3QiOJ3ZtZipDFcLwuyxnrPHrfoBFz425sHis//LEkPMzY
         8p8Q==
X-Forwarded-Encrypted: i=1; AFNElJ95Avgerv/FAECuYDfC/iJV4W4jeNnHa8WAadK4sa1qU6EUBpIvKrwvqteDlD0GPm6CMvrmviAtI7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG60C99r2u1B3Pjoz3hkNGDyHpvb0yJroHo348blPCoXQxKZIX
	gXYeF60I5giAsNLAW1Hwlh7qOY8o8OSLQ4GUnLXrNA49JKo4mPT8d2jykLE2yA21UFQ=
X-Gm-Gg: AfdE7ckniDmBm3Rm+G5N8vuhX8yx26KiqqNz1ZSYJTuxdkucT3GZKDjfE0mQ50j9VCc
	F6d9ForjXcHFOYwlpl/cERTogcT+vzq3g2qgURGXtMcv/0FDJMHhM3hfvSVTzI3G8J3J0TbMlfD
	WjEDMPAV4vRwhMefAhQR9YcXJUkgadwnhpuAJvz3WgOqmjm006OkQDQ8XQTPZHMtPIhj97As0/E
	AOHIICunycBIsYtzio8hyC5z9XGGJyA97fbBHmPPJT5OOn7nk/i/oyFU6uIxY+ue14DSwg4ziH8
	zk8szO5VWmbjnO/E8rFdQgPU4OWVFwWk+3xUqSP1mxPG00ER9i9ZhtsoYRmnL0o46gWtUfvNYBu
	sTxIRGVSMJniY+e1MdUQQp1PLezidM6ruXsRb3l60RKhn+/zsqGCaRGHN0JXlOOGodN1Uya7XtO
	qF/2A72VzP3bg=
X-Received: by 2002:a05:600c:34c5:b0:493:bc4a:e7d3 with SMTP id 5b1f17b1804b1-493d0f4efa6mr1735385e9.39.1783090131280;
        Fri, 03 Jul 2026 07:48:51 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637568dsm149767675e9.4.2026.07.03.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:48:50 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 3 Jul 2026 16:52:17 +0200
To: Sean Young <sean@mess.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <akfMoQfzmEEiH9VC@apocalypse>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <aiwX2YWVJnDNTNiu@extorris.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiwX2YWVJnDNTNiu@extorris.mess.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9535-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean@mess.org,m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:dkim,vger.kernel.org:from_smtp,apocalypse:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,raspberrypi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A73E6703A51

Hi Sean,

On 15:29 Fri 12 Jun     , Sean Young wrote:
> On Fri, Jun 12, 2026 at 04:01:27PM +0200, Andrea della Porta wrote:
> > From: Naushir Patuck <naush@raspberrypi.com>
> > 
> > The Raspberry Pi RP1 southbridge features an embedded PWM
> > controller with 4 output channels, alongside an RPM interface
> > to read the fan speed on the Raspberry Pi 5.
> > 
> > Add the supporting driver.
> > 

<...snip...>
> 
> I don't understand the point of the clk_enabled field. If the probe
> function succeeds, then clk_enabled = true. It is set to false during
> suspend, but after suspend the only thing which can follow is resume,
> I think. In resume, we set it in to true again unconditionally. So
> it is always true, no?

It's true unless enabling the clock again in rp1_pwm_resume() will fail.
That will trap the unbalanced condition mentioned by Uwe in:
https://lore.kernel.org/all/adiW1tBC8Imd14LD@monoceros/

> 
> > +};
> > +
> > +struct rp1_pwm_waveform {
> > +	u32 period_ticks;
> > +	u32 duty_ticks;
> > +	bool enabled;
> > +	bool inverted_polarity;
> > +};
> > +

<...snip...>

> > +
> > +	/*
> > +	 * The period is limited to U32_MAX, and it will be decremented by one later
> > +	 * to allow 100% duty cycle.
> > +	 */
> > +	if (period_ticks > U32_MAX) {
> > +		period_ticks = U32_MAX;
> > +	} else if (period_ticks < 2) {
> > +		period_ticks = 2;
> > +		ret = 1;
> > +	}
> 
> period_ticks = clamp(period_ticks, 2, U32_MAX);
> 
> Although that misses out the `ret = 1;` which I am not sure about anyway.

But we need that ret = 1 to announce that values have been rounded.

> 
> > +
> > +	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> > +	duty_ticks = min(duty_ticks, period_ticks);
> > +	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, clk_rate, NSEC_PER_SEC);
> > +	if (offset_ticks >= period_ticks)
> > +		offset_ticks %= period_ticks;
> > +	if (duty_ticks && offset_ticks &&
> > +		ret = dev_err_probe(dev, -EINVAL, "Clock rate > 1 GHz is not supported\n");

<...snip...>

> > +		goto err_disable_clk;
> > +	}
> > +	rp1->clk_rate = clk_rate;
> > +
> > +	chip->ops = &rp1_pwm_ops;
> 
> Can we add the following please:
> 
> 	 chip->atomic = true; 
> 
> This means that the pwm can be controlled from atomic context (not process
> context) using pwm_apply_atomic(). This is very helpful for the pwm-ir-tx
> driver, which produces a much more faithful IR signal in atomic context.
> 
> Using pwm for infrared tx is much nicer than using gpio which bit bangs
> the IR signal and holds the CPU with interrupts disabled for upto one second.
> 
> As far as I can see there is no sleeping code in these code paths, so we
> should be fine.

Sure, added.

Many thanks,
Andrea

> 
> Thanks,
> 
> Sean
>

<...snip...>

