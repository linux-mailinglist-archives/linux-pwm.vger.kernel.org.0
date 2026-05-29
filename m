Return-Path: <linux-pwm+bounces-9199-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJbkJo1IGWrHuAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9199-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 10:04:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103A5FEEC2
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 10:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13083020A7B
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855683AB28F;
	Fri, 29 May 2026 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPaWnZXB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D853A1CEA
	for <linux-pwm@vger.kernel.org>; Fri, 29 May 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041490; cv=pass; b=AsS9Gd+Afy+r/LiHiX2saF58SRq021/4BTfx9EAosJFJ/4/sU5LcQDLknA5mbIeOmJ5VfCqo2Y8GaQIFhY2Fu9Kq0WYUcMMd5TprDdRlGALPn30i7RUqFtlD2l+Rs2AnedFIdXt6IngbFsFul1hmf29GhcGkZxK6Z6shoqYq0TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041490; c=relaxed/simple;
	bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYDc5OYCBS39u22Zm5U3mUs1yoONRTyYY7zfzklfJirk5wrj27gPjNOOrVmrqXtgOej3pjfDUzUmMUGrh0LpI9xxEHl41N8yw9cRJPWylbau4l1zULFeB6ZTiZh3lWujVU+bh4Uet8vGOZ9KIsrlwOsFpxoBVhvgEGXtvUSGr9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPaWnZXB; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so9784774a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 29 May 2026 00:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780041489; cv=none;
        d=google.com; s=arc-20240605;
        b=SailYh7terOLCkY18BPv2SD08WDcYvsM5KuxZAeoZUONQou6ZiGOCHRlix4gvesFSF
         z28VwH/fPbkjtJ8Vmz5+0JdJrer4HUT0uPydjY1M656Eq+LVsA5aS/xu2QO4dkD17DvU
         /xvs3CVRQO1T3mSIoW/HDRASc00NvVQBhgP+4yXmIOWSlCCoLuBzPvJyBnLla+Wlq4x0
         N1FjCpTXcnF8Gb3YFYCbwFd32BR7TbRAQpYulk1l1PwRuvnl1cGhqBqnDL4IpVqQHrEx
         HcALTj2QJPtkgW2lv/6dujCyC4YEr+ulsxvfOJP8JqG7SG0e7A4k/9kXdF+QJAuPNIjl
         V3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        fh=kPNkhhZ6cYQmt64vuFT1zBvaK0CO8smKEmUFmK5w8Dc=;
        b=KNJdnVQwUTGITD1AmQmk/GWxWzroz5lznPDqMX+OTrh1WfMFqkcS5arFy2VDzSlry9
         DHJRMrwqoLxnNtqNrXhkYlF1N5bRb2T31V45qm7avn07J3JIGN0js9CRHq4T+pyB73Me
         2Ga2R8sXvyx3qr6R1WHBCD+qPocO3P3WbZC4epxZBU6rLnDNhZHzoXi9vYSvJgsFe3Yo
         xQ6o6JWqlctaKMJWpidlUW8fhZvitwCdKStoYcxOJrFNG7pT3Wf6nvmq9LX/xk2uu0GQ
         m46YvKUtXlRP16pxK5sEzpI13ffw2NHTe5FV34DDlaBAD/8mbpqqczwo9eCPa1jbE6yX
         bIhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041489; x=1780646289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        b=PPaWnZXB0K3VGnxiNC9w7SWFiMeR6BIFztop+8eTkqkHbXHlhHH+nnag0CH6ginHte
         n3xY+4Am3HSGAYVycyefoA+c6VANgtdmhPc67qqPkSGi4gkU73xnZBOeZQ+DeuzM+Foy
         P9KjQgPN8ah/Gkr0h58xM1HlR/THfteyfo9w4Kjg1IKndSY57ALNxrDb7n9sQPVEFKzZ
         O0SauuBMiBemVppr1gf8OHJIHv5NyDPtkkpwtkV53eFWgGLp4PseFhbPO9x0zmcSPICP
         gdQgzMPAtjY6C7S5XRC7FSwOy62yT4G5IWHW7qFA6NGlsnj+cMOOICsylqeVBHeWmbcT
         5/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041489; x=1780646289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        b=iYmeomkYZL1oF7suFNUvzjJsGkdFum5Z9M4reLVPcBiaDpvLpJsmZe694L1I3p+eg2
         3ZzU3B8Zda8CiMmkiLCTXUQa/MeUTc4+XpoMf5WsanbTKkOfXfpNisgZ1Ceum6XHPttb
         mZDHOVjOTIugsdh+VKVRtdpfMC9zDh9PmCW3gurGiAwhEpign5TGzcVgdPrFMDAYRMQ/
         RLXeSNfzudrwCfoGqDtcSjj/ZLOgv7YLnt7Dc1UJK9bZIDP2+ZnGDMtWUh13z7+65D7L
         +0eHVPC+lRW/KBCtecUC7IP2E4gNPgDyWkhvnnjRMzqJwuC0Hog5Ay+a4/+IeHOU1WYv
         pmwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wAFfmoA+103UItJW29bYPrl6+OpZ/kRdwsM3WtBeKOEYUusv8afWHVyqwRKWoqqlgmLNMzeHh5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwOpPBYoaq6DaBE+HcM2SNDCVZilaEH4k8pWkL7P79CU/Xz8P
	spcbRIc9KBA3aukzyDimYVGOExk1Q7RvDsqFt7FkQGss3LjRbnPXSLiFdr9gSxDwWnkPOKDeNGC
	cvRCFhB4WKJGD4jcCnMYAo+K1Rwfcb2M=
X-Gm-Gg: Acq92OE9PnpjLpyKnhfnEGhNaEJ3N9BjRcAU0x3KvAGqA9wx1bVgVr6NOOzFPcpadOV
	oWV+nFY8MgPFaDwZ10sq0Q3EFuWJAjTl9vy2REjU491c73BPGDd3gMDOQw0QaTp7zP12+4BMs90
	frQ/21l0rLbM6pX2Yz1aSqjFXhLnvHiJFHqMR4FpNNdgom3YNXeS5erykxbVJoe7xLtfXqaDnXb
	XdX8v3onqSJTpz5EcELc68dIfDxo2Zk3KoPy09EO06dglQuOhD3eG8LoVf8Z8VOjPeeY0NHk8mx
	oFgoYtTt8Z37Q/KLr/4=
X-Received: by 2002:a17:90b:3e82:b0:368:341a:a925 with SMTP id
 98e67ed59e1d1-36bbcfaecf2mr2292215a91.23.1780041488492; Fri, 29 May 2026
 00:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com> <b8f7581e9311d5579447304ac4f2d557b29e4f9d.1779893336.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <b8f7581e9311d5579447304ac4f2d557b29e4f9d.1779893336.git.u.kleine-koenig@baylibre.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Fri, 29 May 2026 10:57:57 +0300
X-Gm-Features: AVHnY4LQ-jWF2c7_aSBtntPbH41tJ-A1RaFPwn1TJSq1AkOwWmb4Y_coE3Xjxe0
Message-ID: <CANhJrGP7vSUUd0DSsyqgE+CyLp4mgsO0zkb0JexbER7W50nTDw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Use named initializers for
 platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9199-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,ideasonboard.com,gmail.com,linaro.org,free.fr,iki.fi,kemnade.info,baylibre.com,atomide.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4103A5FEEC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ke 27.5.2026 klo 17.57 Uwe Kleine-K=C3=B6nig (The Capable Hub)
(u.kleine-koenig@baylibre.com) kirjoitti:
>
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous unit.
>
> While touching these arrays unify spacing and usage of commas.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

