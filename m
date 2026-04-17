Return-Path: <linux-pwm+bounces-8627-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJQdMAH44Wn50AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8627-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 11:06:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF741910A
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82EB13017BFF
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAB3AF67C;
	Fri, 17 Apr 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TUqEPnfw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AA3A3812
	for <linux-pwm@vger.kernel.org>; Fri, 17 Apr 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416565; cv=none; b=c6pVorJZiR7CGNQ4LbEZys+YCJgxntgbbGWVRMb7fJ3zvuKN5NJM/sMhQfkJjKMt999r3qbK7AmsBpIcJcuTQdJLhzKJps2irIMubhkL2iOY7Gixpv/A3UzU60tM5ue+WrkUCfQSeTGn2eiawQsvACqgz6a3N3WRmnzh/YSmUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416565; c=relaxed/simple;
	bh=rIXSNuZeX4Y8nYJFYgp9z/YxCtEEvTrENt792rlNWOI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1DIKGLDSVwPdqYY5PadnLnd9x6G6mbbXkZNGVguK+ZsTQzSzw3ycjtt5AbZ9LbopxsjVK630WMU7w8COI1HQ6e6YWrX0c1vQkk29V+DekFGS1ekx8No/bwXlNI9QKhS2qvOfXc2ktjiHa4iURIwrcGim+lvkobscDDu2+ZABj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TUqEPnfw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so5295105e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Apr 2026 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776416562; x=1777021362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yaq3oZZPP0zgJO7shSO8Tq5EbFEPwmFPXbYiMglTcK8=;
        b=TUqEPnfwiXNQYO4xo7t4DIdMWaN9uWb+vJFldL0AIzTx1gHhmcau+RtB7Dap+IBFRE
         XlktTPhd3sk7xAQX3bNcw9PXZ4/uoohy9TWGcqUdJbrKaciF7F2VlV9TI5DdxZJpBn74
         tncFhBrsZQiZ5zEelghYr8cSYoC8pU1xDvAsIAJMoxZqzywCClLDoTXoORvtTVzmUaMT
         4yCWVS8HaI0eqFBad1PsoFT2mJ/c2VgZlpuFoaYj2aUkYTk2uUdXshsEOXNllxZBH9+l
         U3A1RQtlWzQPWxau1nnwG2urbJX3hk2b4KeD9MgB7dErF9h17g/PSH9OCdOUlWlSmWbn
         +lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416562; x=1777021362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yaq3oZZPP0zgJO7shSO8Tq5EbFEPwmFPXbYiMglTcK8=;
        b=hndsd8BLwCm7upgF1a9neTWR4xz36LF6zmAuzDEV2ULf0RE1iBGutCCzoexlHzGbka
         y8pgRMJ0LANKIKLW5AQ13r393h6XUZzxyheHaD/MYlzvjEXdUV711Ohuc3Ezkt/fW11e
         tdCRounSaQZE5EpbIpe+GefzzVpAf2VvQ3GqM7K+aof92TBtcaprAq5EZklIcbL7Gu/i
         ror+Z3eiubv/XcQuo7+vKVHzXzRu7zxOpTALo9UA/bOxbex3WFb4WcUvh3V5+o4AQJyY
         2udCjmbKL39BjQSFCXh1BorKqq52Jnjtq1ZJZ/oH6s+MOzGLTBSSyRb6q32sACodFJnF
         YBDA==
X-Forwarded-Encrypted: i=1; AFNElJ9FhgW6F5Uzb++pKVRjD0p5rZZNvizwnlLPfaZ5WPGQIdQNN6DNk9nSTxMdTuX20Obuo6Yg92O76FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1C7OxVZOdm1P+vb6FquYAo9Lq/RS/1uMIn84Yv47HaLAkRHd
	j3pXxEMTLwYTC9aN8SVwdePA29Ac3ouZpiNa6UupGXy3+88PwVhOdhbvjJR49yj/Wr0=
X-Gm-Gg: AeBDietMIppoMBgzMwIoGxcPDCirJCfSSUnQ95zJ4tZABR5vcEFiAnLeSJl8GorYaqW
	d1ZodUS3onX8WEN0HobeK5k+8unx1aGljB3mcFxIDZMNm1wmuCkuHZO8U1+YMmJL6FcmUfaojRj
	+iYSqdwqCf6mmkZJ8z59L1AeMqgM7KhbDgnReJl1/q0bVjcMOMWt+QqClKT5wa/b/LStuV3c0GR
	DRsKWbsRR2OSEZrcYOdfzUZqoZIQGOSQDTzXIwOgYyb1WCP/OBleLfLOPiWbhTCKN8wLm9vRcbB
	aDokSo7T6KKgUVqrckjMeoAYRGbhTSN03JODU2wYleiLS67CQbozdu/jFQhal4OQzo9skBzyaap
	vCJ0brKuqIR2XCm8dQYJMb0z9JaNFdN70lzQ1efWgrI9hCjmWUQgf5sXPNl6RDecclD+Bw9jh/B
	IP+w8r6dPBGodqMF2MFjmia8pvF0xts9t0q0ycmriN9quLBe8PnqegnFzsmeA7yHyyw8l3py8t4
	By63v8=
X-Received: by 2002:a05:600c:a30a:b0:488:8d44:bf98 with SMTP id 5b1f17b1804b1-488fb74a5f3mr20968355e9.7.1776416562061;
        Fri, 17 Apr 2026 02:02:42 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1001bdsm49367405e9.6.2026.04.17.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:02:41 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 17 Apr 2026 11:05:51 +0200
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
Message-ID: <aeH373a_xmr6fnAy@apocalypse>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
 <aeC6U7D6TfWm8JPx@apocalypse>
 <aeDmk-t5Lc1zpkg9@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeDmk-t5Lc1zpkg9@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8627-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 67DF741910A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 15:48 Thu 16 Apr     , Uwe Kleine-König wrote:
> Hello Andrea,
> 
> one thing I forgot to ask: Is there a public reference manual covering
> the hardware. If yes, please add a link at the top of the driver.

Sort of, it's already reported in this driver top comment (Datasheet: tag).
The PWM controller is part of the RP1 chipset and you can find its description
under the PWM section. This is not a full-fledged datasheet but the registers
for the controller are somewhow documented.

> 
> On Thu, Apr 16, 2026 at 12:30:43PM +0200, Andrea della Porta wrote:
> > On 19:31 Fri 10 Apr     , Uwe Kleine-König wrote:
> > > I assume there is a glitch if I update two channels and the old
> > > configuration of the first channel ends while I'm in the middle of
> > > configuring the second?
> > 
> > The configuration registers are per-channel but the update flag is global.
> > I don't have details of the hw insights, my best guess is that anything that
> > you set in the registers before updating the flag will take effect, so there
> > should be no glitches.
> 
> Would be great if you could test that. (Something along the lines of:
> configure a very short period and wait a bit to be sure the short
> configuration is active. Configure something with a long period and wait
> shortly to be sure that the long period started, then change the duty,
> toggle the update bit and modify a 2nd channel without toggling update
> again. Then check the output of the 2nd channel after the first
> channel's period ended.

I stand corrected here: after some more investigation it seems that only the
enable/disable (plus osme other not currently used registers) depends on the
global update flag, while the period and duty per-channel registers are
independtly updatable while they are latched on the end of (specific channel)
period strobe.
I'd say that this should avoid any cross-channel glitches since they are managed
independently. Unfortunately I'm not able to test this with my current (and
rather old) equipment, this would require at least an external trigger channel.
Regarding the setup of a new value exactly during the strobe: I think this is
quite hard to achieve.

> 
> > > > +	if (ticks > U32_MAX)
> > > > +		ticks = U32_MAX;
> > > > +	wfhw->period_ticks = ticks;
> > > 
> > > What happens if wf->period_length_ns > 0 but ticks == 0?
> > 
> > I've added a check, returning 1 to signal teh round-up, and a minimum tick of 1
> > in this case.
> 
> Sounds good. Are you able to verify that there is no +1 missing in the
> calculation, e.g. using 1 as register value really gives you a period of
> 1 tick and not 2?

You are right. The scope reveals there's always one extra (low signal) tick at the
end of each period. Let's say that teh user want 10 tick period, we have to use
9 instead to account for the extra tick at the end, so that the complete period
contains that extra tick?
This also means that if we ask for 100% duty cycle, the output waveform will
have the high part of the signal lasting one tick less than expected.a I guess
this is the accepted compromise.

OTOH, the minimum tick period would be 2 tick, less than that will otherwise
degenerate in a disabled channel.

> 
> > > > +	if (wf->duty_offset_ns + wf->duty_length_ns >= wf->period_length_ns) {
> > > 
> > > The maybe surprising effect here is that in the two cases
> > > 
> > > 	wf->duty_offset_ns == wf->period_length_ns and wf->duty_length_ns == 0
> > > 
> > > and
> > > 	
> > > 	wf->duty_length_ns == wf->period_length_ns and wf->duty_offset_ns == 0
> > > 
> > > you're configuring inverted polarity. I doesn't matter technically
> > > because the result is the same, but for consumers still using pwm_state
> > > this is irritating. That's why pwm-stm32 uses inverted polarity only if
> > > also wf->duty_length_ns and wf->duty_offset_ns are non-zero.
> 
> Please align to the pwm-stm32 algorithm (as of
> https://patch.msgid.link/c5e7767cee821b5f6e00f95bd14a5e13015646fb.1776264104.git.u.kleine-koenig@baylibre.com)
> here to decide when to select inverted polarity.

Yep, I did already done when you sent that patch.

> 
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_disable_clk:
> > > > +	clk_disable_unprepare(rp1->clk);
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > On remove you miss to balance the call to clk_prepare_enable() (if no
> > > failed call to clk_prepare_enable() in rp1_pwm_resume() happend).
> > 
> > Since this driver now exports a syscon, it's only builtin (=Y) so
> > it cannot be unloaded.
> > I've also avoided the .remove callback via .suppress_bind_attrs.
> 
> Oh no, please work cleanly here and make the driver unbindable. This
> yields better code quality and also helps during development and
> debugging.

I wish to, but the issue here is that this driver exports a syscon via 
of_syscon_register_regmap() which I think doesn't have the unregister
counterpart. So the consumer will break in case we can unbind/unload
the module and the syscon will leak. 
If you have any alternative I'll be glad to discuss.

Many thanks,
Andrea

> 
> Best regards
> Uwe



