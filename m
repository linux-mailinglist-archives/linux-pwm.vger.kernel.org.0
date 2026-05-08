Return-Path: <linux-pwm+bounces-8844-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIyOEvWa/WkJgQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8844-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 10:12:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E274F38D9
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0EF130146A5
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624238228C;
	Fri,  8 May 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IZwdxPBq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750737C915
	for <linux-pwm@vger.kernel.org>; Fri,  8 May 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227952; cv=none; b=kvE0ozVMS55+UUvibbuVYK/9aJAVUdBK5uQWgvPsEPq283Ri/8MofmUPRZKV4QPJ1kZWIw5SV8NDa1CMfHQ2pel4VsYAGWPlCIfvRPnNXxZ38S01Mnjgj+sTq3lYOTgupeOYsKZuNJryyQy6yG9I1meGIrFmaiWYAz50X0bs/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227952; c=relaxed/simple;
	bh=WVoh3zrIDDVVwO6/Qpr7kFi5is8aeakhIkv9KUqg1ew=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjYhwCNZf6qmHajfqAmjm8G3YvOIdXbv4YJfjRFT91iDFPzeE0xMbRVwW0cn930rUlXR1epd+A4cUhI+GXorIOBSyDa/chCxwCshZyqCHLOVQF51sG5aQdTa3e/HD2GSj5+mDfSFX9Wj9xphppDacJWraRoCCS1RPtsOxiccf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IZwdxPBq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so26628315e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 08 May 2026 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778227948; x=1778832748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCCOIzOkC3aMYU18+NM+L3w+mXvUjU56+VWPG5affHY=;
        b=IZwdxPBq6DNiwz/7VXhsRRa7ptDQp/OhtWd8hlbTiIPzJBnzflTkV9WfwdHmVbL2/4
         eNMPLXDED/E+6BP2jB2WA8lUqNzdzMelTYWFwIUG0Xalp8OEB3aeMpwxQai8Uh3KcYyr
         xkXjtO9regZRISoDpl6LXlVLwNDJMFobkvClaU/Di5505goLTvB8eezQP1sRXvg2aYFu
         NvpJCm+HTGQPyRFAwL/acgZo5Ce+EKrtYhB4Dz0PL9hgfy+lR0XI5pd054ER8Zjd9QvW
         YJim5UJ3CgN/IjVOI8gLmwCkvUvtxUf/avTCo5/8XGSzf5ak8hyT2TL19OBiwFYNpNJl
         chXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778227948; x=1778832748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCCOIzOkC3aMYU18+NM+L3w+mXvUjU56+VWPG5affHY=;
        b=dbe8+jgPBFIUJUU2qX/q/noWzwjghyAAyJhwWd+5XvGrGwUf60VozKKHhnMcV8fSDZ
         nIJr2yW++ATvA1G+PFW7a+2XNpzKzw3ULUQ9lIX9ylH5QaJgDba3DHDETAFBQtlSqFoT
         KoRBfD4ooeiuZbjdhA+0P744xNvATpzV65JD29yOafsK5TJpeN31RxB8ZoSlbUWehiuy
         Iid4GUmaRSCj5aD4zJd3QdlT/0t/1PVvf7iyV492tr/NWl0ylE4/tJ32WiGMd6cT3r1J
         /rqQbn+xr8eurVY6V+9DZ6BgOG05/zRH0XsEM3Gds+ZkwA9v/Q0uH2PJxa9U+O8gZx9E
         maCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AOCrpX+SteIE+HxgNwyTkoSeLCLlMhIJ+48Yfz6Y2ipZL+yGGLroj89bx3VxNT20eQNi8suOB6U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuVF5j1fcVphvAalgu8WpQaJbs+mN3f0OFRAigfgspVr3zGsP
	MqjXU47PoDqhyzixvU3LE4JHXmewDfg3bPrcRlK+9GdHSCQnwUZwDyQxlY5nolxUguI=
X-Gm-Gg: AeBDieuZd/p4x8IT6Rlt5YG51wJ9zqQ2kmwFvnEl7S/gzUfBTmwpjAGW/kevfCJNo5p
	1cyboecRcddJm0REptxvsa3oUtKLJVxQMZv61uKlqB6pxj1bLKOUOlAgSvDH5tz/8AR3JZg1VQf
	tXTk34jbTEKFv1diTZVlpK7oXstN5yJVs4E80CN97gYRXsVX1dXsRti84gJS4ynakCjRFgaF8HZ
	XSbO4tjLwbF+/IjEUAcpHeZEHhDNhJyZMHhgHF7cXv+hD8miV1iv6I0qsE7/P+2LxlhRLi4lHqk
	xOm8/VduMnAQVYJ28KQ01C4LWQZnwjUke7LCuEzIYRFke+aNnc8V9VooRXF9Xtaw21MXP+PQ88o
	XIZe6opuvru7eGlosJAV/XFed0HhkgjPdmXYmk4xdCMABktwpZfscOpgwq/DxEI4og8y4fWnB4q
	AGzPnUba3RTAGHZ4M/KCeG
X-Received: by 2002:a05:600d:849c:20b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-48e51f220e7mr136524945e9.12.1778227947995;
        Fri, 08 May 2026 01:12:27 -0700 (PDT)
Received: from localhost ([195.94.150.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eaf237sm26988245e9.6.2026.05.08.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:12:27 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 8 May 2026 10:15:44 +0200
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v3 0/3] Add RP1 PWM controller support
Message-ID: <af2bsEdAhYY9c4rb@apocalypse>
References: <cover.1776932336.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776932336.git.andrea.porta@suse.com>
X-Rspamd-Queue-Id: D6E274F38D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8844-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Uwe,

On 10:30 Thu 23 Apr     , Andrea della Porta wrote:
> This patchset adds support for the PWM controller found on the
> Raspberry Pi RP1 southbridge. This is necessary to operate the
> cooling fan connected to one of the PWM channels.
> 
> The tachometer pin for the fan speed is managed by the firmware 
> running on the RP1's M-core. It uses the PHASE2 register
> to report the RPM, which is then exported by this driver via
> syscon registers. A subsequent patch will add a new device
> and driver to read the RPM and export this value via hwmon.
>  
> Subsequent patches will also add the CPU thermal zone, which
> acts as a consumer of the PWM device.
> 
> Best regards,
> Andrea
> 
> CHANGES in V3:
> 
> - Refactored all the register macros. They now have RP1_PWM_ prefix
>   and follow the register name.
> - Dropped the tab alignment in front of struct declarations (use a space
>   instead).
> - Added a check in tohw() to test (and bail out quickly) in case that
>   period_length_ns is zero.
> - Probing now returns an error if clk_rate > 1 GHz.
> - Added a check on minimum period ticks. Return 1 to signal round-up.
> - Fixed inverted polarity detection on edge cases.
> - Fixed rounding errors (in both tohwi() and fromhw()) in inverted
>   polarity calculations.
> - Dropped a redundant check on period >= duty.
> - Replaced memset by inline struct init.
> - Disabling a channel now is faster, skipping the duty/period/polarity
>   setup.
> - Fixed an error string (s/Fail/Failed)
> - Used %pe to signal error string instead of an integer.
> - Added several new sections to the Limitations paragraph to better
>   explain what will happen on edge cases.
> - Maximum period is now U32_MAX-1 to allow 100% duty cycle on all
>   selectable periods.
> - The hw period register now takes into account for the extra tick at
>   the end of the period (subtracted one to wfhw->period_ticks in tohw
>   and added 1 in fromhw).
> - Added .remove() callback to free resources even if the driver is
>   not unbindable/unloadable, to avoid accumulating tech debt.
> 
> 
> Naushir Patuck (2):
>   dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
>   pwm: rp1: Add RP1 PWM controller driver
> 
> Stanimir Varbanov (1):
>   arm64: dts: broadcom: rpi-5: Add RP1 PWM node
> 
>  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  54 +++
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
>  arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |  10 +
>  drivers/pwm/Kconfig                           |   9 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rp1.c                         | 414 ++++++++++++++++++
>  6 files changed, 500 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-rp1.c
> 
> -- 
> 2.35.3
>

A gentle reminder about this patchset :)

Many thanks,
Andrea 

