Return-Path: <linux-pwm+bounces-8659-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCTbNN9m5mmJvwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8659-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 19:48:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F54321D2
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 704E73185ECE
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1134CFAC;
	Mon, 20 Apr 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Av08dbq1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82622D978C
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702279; cv=none; b=AoOrnR3TTOoa6A9ilTxg1jXku9YJuu8J1tAFEOKqsQiMV5UObTZQNk8jyULmu0bLmiBbzXphqZ1sDmCdLmPWUhXnX0rGdlUG55ub518l+yLiGom401Lno7255ngPpb69XBk7EraYPbi3CWVA4WXNVN+G1ygAgY5DMGdgwge2E1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702279; c=relaxed/simple;
	bh=pYqGDDi8Bj5ek3+j+awfSvAOBnDA3Nxz541WcUvN7N8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke+P4/vKna79vvNTbnHKygKmSz5QZt0Dr+BV7omkcanbfErJpMyEtfIGpna00JqR1xEVUF6jt1fdStw7kvxQtbLERwXMBOWMuErBPZje1IE/7zn4uFU0SiLfWGLvBtsVxAhvtBDdz+tYgwfdvf+tX04iOY2WytHA2hRiSFTd/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Av08dbq1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso1536213f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776702276; x=1777307076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtHJitgOXiKvhtJ9W9j2071qDpvbTTZCmk6P6HSe3v0=;
        b=Av08dbq1w8bt1+CXz/eLYB6Gek3g7WcPg6W0bX7Hg2pQPWGYC9u+fzqCB402VIFHgE
         hACE9tlpCZnHErLvaY0yliiNzr2vnPIhdbI+ZUyumtuuRToVfPjoxXK1OKp0jy6MepBX
         9OTz1Ck4unhKsyWjAQCHyQfsb/SVS4mtaks21FuTmmGvlj4r93fOplfAaHx/94b5twcb
         7RqRaV3drryhhBFqLC3pMRoVKadEMwsD6rtFHcLK3eD67ovoLQizgL3e5BAkQndZURya
         OoKxH5Mk1iHgaTNqXKpdaYkvwbFnaIkmV1QySGHxwYPJ+ePxJ0VU+db/WYNA6aAym0+0
         Z/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702276; x=1777307076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtHJitgOXiKvhtJ9W9j2071qDpvbTTZCmk6P6HSe3v0=;
        b=Wtu5QVXAwVbqOBlKIjE9jtjzV/JVZr/Hqtr3YKN6yVHn24G6/INALTyWV2I8xWJgnj
         N/hKAJsdY0MVyf2k3dNeZVarE6kms/rxiq145UAPXOCJx/C8XO8g81uR8Gd53IjnH3cc
         Ey/ScVfvBN54c29YuL6zs7QrQ+prxjAhq49laxOVvEoogAX+sReu/CqYKA/X6kTWSVZ5
         R9Jh7eAv9jAyrJorKQ9yR9OUBb/fofSmOXDPCTi70qaOOI9cvd2mFzhJKfHu5FOeoycG
         ChynA5lFsF1KcQEtc26wcVCcgJ+FqahpObszUdTOG78FYNFzDxqK3UqCHZO5ZjWtGSOn
         R6NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/igdve4R8iDNcwMYqVVGs+rGUYvsKxXLbNpa0q+1VlPCLMZYwZinJ/uhNJs6F9kA4cywOHmkPoJS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLyEVD+4nj1FMdlJWEvvm8eit7eocn8McApDNk7inXtKhtucu
	dvmEIt2J1pGOg77qeVtO6wPRpaCPpztACx3V0oeMKr80sTDhgiSp+39kCRap50+jtJIktOzCJjv
	VlceMCoI=
X-Gm-Gg: AeBDievkwUfO/u8KpzyGWRihbSLoyjweW1KgGuGR8J1MyzjXlvgKxUWNW8B2gj29gSE
	1cQ/3L+dBAVbDbVeExhagxtHadAOaLRLdC9Nst9tMEW3GXizXXJngMmwBlVW0YIVNOPQuheUQID
	jG7S4GCvdXiiZdbrOqc1bgxEv368a3hpZUsfRsV4LAMxwBnP37yZz5fZlynIJyiU/fg4t9EIrlx
	kmEygyrBqEk0/QiI3vrHopBg3M/oXiRIaTWMip74eSbIgkbPYPZW/V1dnBUH4RrAomPU+ay2v9v
	h/k7RcrwbN2DlPC9xOr8UtZVZbCtu/74KYy2w37kZl3DWcFEERzu0TMU0YIlK8Z0Xwetbb6Rkfy
	CAGePSVodnvk7zMqqlhG4mQ1PmUKMLbjszgdLnofOGm/b7u6qMWtbDjL8qS4N9T/SJYkhFywP29
	Gald9uagYz0P07bobabqWkR288/OIKL+nyVHlfxkl3NzO9pKFciFo/KK8C3T6F18IbxtnzO5p2Z
	YA5414=
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr68819025e9.5.1776702275866;
        Mon, 20 Apr 2026 09:24:35 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm16749795e9.10.2026.04.20.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:24:35 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 20 Apr 2026 18:27:45 +0200
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
Message-ID: <aeZUAaQkHGqBL8st@apocalypse>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
 <aeC6U7D6TfWm8JPx@apocalypse>
 <aeDmk-t5Lc1zpkg9@monoceros>
 <aeH373a_xmr6fnAy@apocalypse>
 <aeIGxfQ7AoIVR5n6@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeIGxfQ7AoIVR5n6@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8659-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 001F54321D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 12:50 Fri 17 Apr     , Uwe Kleine-König wrote:
> Hello Andrea,
>
 
<...snip...>
 
> > I stand corrected here: after some more investigation it seems that only the
> > enable/disable (plus osme other not currently used registers) depends on the
> > global update flag, while the period and duty per-channel registers are
> > independtly updatable while they are latched on the end of (specific channel)
> > period strobe.
> > I'd say that this should avoid any cross-channel glitches since they are managed
> > independently. Unfortunately I'm not able to test this with my current (and
> > rather old) equipment, this would require at least an external trigger channel.
> > Regarding the setup of a new value exactly during the strobe: I think this is
> > quite hard to achieve.
> 
> To sum up: period and duty_cycle changes might result in glitches unless
> the channel is disabled. This is ok, please just document it.

Maybe the glitch can occur if we're changing period and duty exactly during
the strobe, unless the register writing is somehow in sync with the PWM clock.
Disabling the channel immediately stops any execution and the line goes suddenly
low (if polarity is normal, otherwise stays high). See also next.

> 
> The purpose of the update flag then is only to start several channels in
> sync?

Citing the datasheet:

"To prevent mis-sampling of multi-bit bus signals in the PWM clock domain,
this bit (SET_UPDATE) should be used to trigger a settings update. This
ensures that all PWM channel settings update on the same PWM clock cycle."

From my testing though, channels can be started in sync only if they have the
same period. I'll add a comment for all this, and other edge cases.

> What happens if sync is asserted while a disabled channel didn't
> complete the last period yet?

The output stops immediately without waiting for the current period to finish.

> 
> Maybe it's worth to test the following procedure for updating duty and
> period:
> 
> 	disable channel
> 	configure duty
> 	configure period
> 	enable
> 	set update flag
> 
> Assumint disable is delayed until the end of the currently running
> period, the effect of this procedure might be that no glitch happens if
> the update flag is asserted before the currently running period ends and
> the anormality is reduced to a longer inactive state if the updates are
> not that lucky (in contrast to more severe glitches).

The disable isn't delayed as explained above. Setting just the new period/duty
(which do not depend on the sync bit) correctly waits for the end of the current
period without noticeable glitches (tested with a scope).

> 
> If you can configure a short and a long period that is distinguishable
> "manually" with an LED I think this should be testable even without
> further equipment.
> 
> > > > > > +	if (ticks > U32_MAX)
> > > > > > +		ticks = U32_MAX;
> > > > > > +	wfhw->period_ticks = ticks;
> > > > > 
> > > > > What happens if wf->period_length_ns > 0 but ticks == 0?
> > > > 
> > > > I've added a check, returning 1 to signal teh round-up, and a minimum tick of 1
> > > > in this case.
> > > 
> > > Sounds good. Are you able to verify that there is no +1 missing in the
> > > calculation, e.g. using 1 as register value really gives you a period of
> > > 1 tick and not 2?
> > 
> > You are right. The scope reveals there's always one extra (low signal) tick at the
> > end of each period.
> 
> So the hardware cannot do 100% relative duty, right? Please document
> that.
> 
> > Let's say that teh user want 10 tick period, we have to use
> > 9 instead to account for the extra tick at the end, so that the complete period
> > contains that extra tick?
> 
> I would describe that a bit differently, but in general: yes.
> 
> The more straight forward description is that setting
> 
> 	RP1_PWM_RANGE(pwm->hwpwm) := x
> 
> results in a period of x + 1 ticks.

Exactly. So whatever the user request I have to subtract one from the value
to be written to the RANGE register.

> 
> > This also means that if we ask for 100% duty cycle, the output waveform will
> > have the high part of the signal lasting one tick less than expected.a I guess
> > this is the accepted compromise.
> 
> I assume you considered something like:
> 
> 	RP1_PWM_RANGE(pwm->hwpwm) := 17
> 	RP1_PWM_DUTY(pwm->hwpwm) := 18
> 
> to get a 100% relative duty?

Ah right! It's working fine and I've got 100% duty. So at hw register level
the duty can be greater that the period.

> 
> If this doesn't work that means that this has to be formalized in the
> callbacks. That is the fromhw function has to always report
> duty_length_ns less than period_length_ns.

No need, it's working indeed.

> 
> > OTOH, the minimum tick period would be 2 tick, less than that will otherwise
> > degenerate in a disabled channel.
> 
> It's expected that in general for a period_length of 1 tick you can only
> have 0% and 100% relative duty. IIUC for this hardware you cannot do the
> 100% case so there is only a single valid duty_length for period_length
> = 1 tick.

Minimum tick confirmed to be 1.

> 
> I think it would be more complicated to consistently filter out
> period_length = 1 tick in the driver than to just accept the conceptual
> limitations. (Otherwise: What would you report in the fromhw callback if
> period_length = 1 tick is configured in wfhw? Would you refuse to commit
> that wfhw to hardware in .write_waveform()? The pwm core handles that
> just fine and consumers have all the means to detect and prevent that if
> they care enough.)
> 
> > > > > On remove you miss to balance the call to clk_prepare_enable() (if no
> > > > > failed call to clk_prepare_enable() in rp1_pwm_resume() happend).
> > > > 
> > > > Since this driver now exports a syscon, it's only builtin (=Y) so
> > > > it cannot be unloaded.
> > > > I've also avoided the .remove callback via .suppress_bind_attrs.
> > > 
> > > Oh no, please work cleanly here and make the driver unbindable. This
> > > yields better code quality and also helps during development and
> > > debugging.
> > 
> > I wish to, but the issue here is that this driver exports a syscon via 
> > of_syscon_register_regmap() which I think doesn't have the unregister
> > counterpart. So the consumer will break in case we can unbind/unload
> > the module and the syscon will leak. 
> > If you have any alternative I'll be glad to discuss.
> 
> My (not so well articulated) point is: Please be stringent about clock
> handling to not bank up technical dept more than necessary and such that
> the driver can be made unbindable if and when syscons grow
> that feature. Optionally wail at the syscon guys :-)

Hmmm not sure I've understood your point: is it a requirement that the driver
must be unbindable? In this case I should avoid registering the syscon. Or
should I just provide a .remove callback in case there will be a way to
unregister the syscon (even if this callback will not be called as of now)?

Many thanks,
Andrea

> 
> Best regards
> Uwe



