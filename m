Return-Path: <linux-pwm+bounces-8669-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LjCEbyH6Gk6LgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8669-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 10:33:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4714437CD
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7416830154B5
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B0306D2A;
	Wed, 22 Apr 2026 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dYe/VE6O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBF3BF673
	for <linux-pwm@vger.kernel.org>; Wed, 22 Apr 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846776; cv=none; b=eInlGWlUYJ0gfbpObxhevlIUPLtFd1cKpMUp/rPCoI5YlH8hDw1JHs0PIci//GJzGoywHASR5I5CMzte4KXjMrb9Kftu6rzSYF8Rr4doOYn63iPgV9mgBuD5rDt0YwGGwl9ALHgj3+4zsFjAvJnb6IqYmqq+N9PNRsuETMeM4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846776; c=relaxed/simple;
	bh=/k/tVJdTvLjvL2XSx3QMTYtMpRbrIE1/jOVJ8MJxqz0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhQJdC7Z4qRmzpNuZUKD+vm4gra05ZI/rzi38FLI+48ym9yNO26yqBTmUlXg3IS3KTzoo6AsTVQa1HZjauJ8hS1d6dOSRE8QqWPQECtTuFobUYpEE+jpV3s0XiHTxBS0HHT4XYd8E/0ddzoc13hJBmJWUWLveT09xnxITpVHmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dYe/VE6O; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so18975845e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Apr 2026 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776846774; x=1777451574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EMnjefoZVtE6qyXWNiSeQYJ6N4rmREqzBA+4f1h/1g=;
        b=dYe/VE6OlF78FFO9tXRqPaBYeAsgNGUFcHmxz4qWWQEe/YDULylkjMvDBes8T1DPAw
         UM8cG9paDocEMFligJuZYq1F5TOqxM4lh3l1grGmj4sXqtmqt0Ynsrg1F88RSfXC2ZUn
         uMAwpPHUad/LE+JLShwYTDnnUvfsoZiCuk2nxVnLVoAiVRdoz3+/T0Wy2MR7VVCVbzrR
         W5Ab5BNVoO2wm2+eshbfdlsTR0FzxML6CMnN32kY64QloQ5GtV8D3CLzNYfXTE8kpFFa
         GilF94tUKJ1jsVPhVBP6E7lwNCgMg8vGGVP8M99dJdLRClROs2iMCD6+OczJDM0QWZ5X
         Cj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846774; x=1777451574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EMnjefoZVtE6qyXWNiSeQYJ6N4rmREqzBA+4f1h/1g=;
        b=XHjReFo3Rck780uxGdN+u+or0O49OgdY3PA2q7Fg6YfpuJTmQeMmd5ML8dx2pOWr2O
         gmZJDOShKKoZ7nMLLnvdtpP/omD70tnoOR65bkcaPOWCkl+3ASfQ6hQoj6R3vHqOBwhX
         r6dlGG+UbijOoZSFf2jlTPCHiWs1wf3heawn01Dpi1qMr+bvFIznG2gMEqzeoEC8Agho
         MsGW5uTg9Vs+wLQ7+RsN3+BVpupTfpyAK3LkWCICxmsF8xu4+UwuHCBWDY0psf4ZhOv3
         yfV8YrHoursJrm6tUlAwqsri6ew5B+UEGkTHOPDtJmSFOokKrqdD/XY6tDlA89Qu9/dX
         eO/A==
X-Forwarded-Encrypted: i=1; AFNElJ8P3RoiTINKafom2DBcQAph4WlpTPB2TMitFKRDADMldVa44Ufu2nM2J86Inp+Oj3hvK3uj2gKNDZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OymoXllTV8oDrZC1fMPSm2CA7CfNMUxpqe9b050bJ2Pm1XRu
	jx47MGh1r0V5WSXjg/p+rWeOfDCehToLDMFLHTQZyq3SkG77DQYM0uDWkQ7GiMDATR8=
X-Gm-Gg: AeBDieuTXYRSEhaCppgySmkj4HnJz58NrPTL051cl9OwEsEJ/xFZM5zcGprwHIYktR9
	jqW3I1a3QIwidIvnvxaBWFhyjj6m7wMIzc68zw3Wlk4ruRqhYgRSy6usucuAmHPy3YH9OxEUAif
	5QWeP4hHcxnbJodoZQPdaHqSBJDmMIjiam4wfkoCIDnj3cOxGxKgNeSHFyzyU8c+GkCdSqfbBwJ
	mFKLQUZ/scYMTWvxMurLLerT73P0nYMbAYcFT6hFbBpKUg0DiS+FSfxXxgW5wNDe81saMLrchsF
	q58tVrT9rkPckXTlyKZSmiPs4aOKdePT1v6dw9GrDpbmy3PL27CqPRpxUD2KFgJGmQWSr3HlOly
	PGN4eLxBH2agxMcS5q2aO3KH11fPhOcWlmXjAsPlWjrlDoGyed5M79VFJasj9774YXDitJGy4bL
	AcdyFvTggRwZB8tXTZEdUSj31Kmc98uGFvDrddtkQq3gNVglBuWPEytxq2oAYSBJF19yoEyZ5wI
	TE6fcQ=
X-Received: by 2002:a05:600c:3b2a:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-48a534af0ffmr110795305e9.1.1776846773750;
        Wed, 22 Apr 2026 01:32:53 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2634sm135796275e9.28.2026.04.22.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:32:53 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 22 Apr 2026 10:36:04 +0200
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
Message-ID: <aeiIdLL48Wn_svGZ@apocalypse>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
 <aeC6U7D6TfWm8JPx@apocalypse>
 <aeDmk-t5Lc1zpkg9@monoceros>
 <aeH373a_xmr6fnAy@apocalypse>
 <aeIGxfQ7AoIVR5n6@monoceros>
 <aeZUAaQkHGqBL8st@apocalypse>
 <aeeMp1XBDxSZ1qrl@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeeMp1XBDxSZ1qrl@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8669-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: AE4714437CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 16:50 Tue 21 Apr     , Uwe Kleine-König wrote:
> Hello Andrea,
> 
> On Mon, Apr 20, 2026 at 06:27:45PM +0200, Andrea della Porta wrote:
> > On 12:50 Fri 17 Apr     , Uwe Kleine-König wrote:
> > > What happens if sync is asserted while a disabled channel didn't
> > > complete the last period yet?
> > 
> > The output stops immediately without waiting for the current period to finish.
> 
> This is a good info for the Limitations block.

Yup, already added, plus a couple other edge cases.
 
> 
> > > Maybe it's worth to test the following procedure for updating duty and
> > > period:
> > > 
> > > 	disable channel
> > > 	configure duty
> > > 	configure period
> > > 	enable
> > > 	set update flag
> > > 
> > > Assumint disable is delayed until the end of the currently running
> > > period, the effect of this procedure might be that no glitch happens if
> > > the update flag is asserted before the currently running period ends and
> > > the anormality is reduced to a longer inactive state if the updates are
> > > not that lucky (in contrast to more severe glitches).
> > 
> > The disable isn't delayed as explained above. Setting just the new period/duty
> > (which do not depend on the sync bit) correctly waits for the end of the current
> > period without noticeable glitches (tested with a scope).
> 
> So if you happen to change both and one is done before the end of the
> current period and the other shortly afterwards (which might happen as
> those are configured in two different registers and the update trigger
> isn't used), you get a mixed output for one cycle, right? If yes, please
> also mention that in the Limitations paragraph.

Confirmed, tested with the scope and a very long period time.

> 
> > > > Let's say that teh user want 10 tick period, we have to use
> > > > 9 instead to account for the extra tick at the end, so that the complete period
> > > > contains that extra tick?
> > > 
> > > I would describe that a bit differently, but in general: yes.
> > > 
> > > The more straight forward description is that setting
> > > 
> > > 	RP1_PWM_RANGE(pwm->hwpwm) := x
> > > 
> > > results in a period of x + 1 ticks.
> > 
> > Exactly. So whatever the user request I have to subtract one from the value
> > to be written to the RANGE register.
> 
> Unless the calculation is already rounded to 0, in that case don't
> subtract 1 and let the tohw callback return 1.

Sure.

> 
> > > > This also means that if we ask for 100% duty cycle, the output waveform will
> > > > have the high part of the signal lasting one tick less than expected.a I guess
> > > > this is the accepted compromise.
> > > 
> > > I assume you considered something like:
> > > 
> > > 	RP1_PWM_RANGE(pwm->hwpwm) := 17
> > > 	RP1_PWM_DUTY(pwm->hwpwm) := 18
> > > 
> > > to get a 100% relative duty?
> > 
> > Ah right! It's working fine and I've got 100% duty. So at hw register level
> > the duty can be greater that the period.
> 
> In that case please make sure to not use the maximal value for
> RP1_PWM_RANGE(pwm->hwpwm) to ensure that for each (possible) period
> length a 100% relative duty cycle can be configured.

Ack.

> 
> > > My (not so well articulated) point is: Please be stringent about clock
> > > handling to not bank up technical dept more than necessary and such that
> > > the driver can be made unbindable if and when syscons grow
> > > that feature. Optionally wail at the syscon guys :-)
> > 
> > Hmmm not sure I've understood your point: is it a requirement that the driver
> > must be unbindable? In this case I should avoid registering the syscon. Or
> > should I just provide a .remove callback in case there will be a way to
> > unregister the syscon (even if this callback will not be called as of now)?
> 
> It's a requirement to properly manage the resources you allocate. If a
> driver isn't unbindable due to restrictions of other subsystems that's
> unfortunate and I don't like it, but I wouldn't block a patch because of
> that.

I totally agree, of course. From a practical perspective I take it as "even
if it's not ideal, you don't need to do further coding action on that side".

Many thanks,
Andrea
 

> 
> Best regards
> Uwe



