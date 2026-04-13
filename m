Return-Path: <linux-pwm+bounces-8568-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC4sIwLk3GnBXwkAu9opvQ
	(envelope-from <linux-pwm+bounces-8568-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 14:39:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D473EC105
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF01530094DE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535303C456E;
	Mon, 13 Apr 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE2huxmg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1033C344F
	for <linux-pwm@vger.kernel.org>; Mon, 13 Apr 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083966; cv=none; b=G9aDoaBJ8bvDU2CMc1yp5fKa+8oKsRUvGt0JNLl9YPMVeLJOTE3PIfoiIXbv1qd6WGHXylnksbe7BVSRgDp/+P44ddJkYxLg+E12Zmf/zV75i3TpLaNTzh8ZOTLuDdMn7JlaqOSA9Pj6LBP8l3T/6QitVUR45CE8x1mImESg4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083966; c=relaxed/simple;
	bh=Eltpam/vgsJqWDDmBNuLJKAQCg+4CI1hVv/dIvLONqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYvlUf5myuCb7hl6NSFUpwGGKEip+MnPoJOuhZIxNMmUEBPR/KjH6jfrXYUiDNmzsjqtjCrp7HxG4KsST42rKOFteoSf00YJEQUhUk1C69aRNW8K46H4xWdXgdwolEBo+JXqKDYndeSd8MSHCxFPMVwCwCvOlePso63fatKmJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE2huxmg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38df1889fb9so45992151fa.1
        for <linux-pwm@vger.kernel.org>; Mon, 13 Apr 2026 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083963; x=1776688763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqFxz1QFpJJAZz46pmSBmZ9ZWT6FZnXdjLeoytZTkRQ=;
        b=dE2huxmgsrvgeQjSjbFocoh53G8iOpb9tXjIh2gY7JQ0RG0Frm83BxuPJp5yN29h0Z
         oyqRsBOeFrBhgncksJeeBQmksTuHmJLrMc7xKck6iSQajEldHsrgXGjnAra0ajck62sg
         V1KnbdVsUgq7iv1A50dRhJEVabUmZbJ6ZyUHzmJNXBGFjXInr8gY4XbYFttuDmONGd7S
         Mq+B3eB+UMlHGC5A7T3W5XPzXA4YFoTMbtVauSvqBAgT3i1czHTj3Ipo0TrqPhbw2ldM
         ePFKEoqNA/MGfdJOsXehiAZbclL0sFsS23R2Sn8GnUgCpNoCTFPNiB2JJyV1/1VRo9wG
         DJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083963; x=1776688763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqFxz1QFpJJAZz46pmSBmZ9ZWT6FZnXdjLeoytZTkRQ=;
        b=ZCnJIETF+iaMYoncraozB4Hij5m2eXagA8NF1b2CSRjIIzA8GpgtB7J/3mDzZsAvZb
         eCY6HsSpXodYj83WfmRLgAQbdY07KX7NC6mpPPrL0lsMwXCpz/0LNjQ/cR0Nx5KktTco
         22zjFI9FKt5IBPNm5R+z+SDvy/iF2IBRPJNMZPaMmaXqEphN7ntPJprL1HwwF+rXT4Dq
         +RwY/hWgGRSSJOo5j+/yrz3eoMVW8EB68eWL8NcfnSm44/afiMiCSTRv7Ab6up5Zk7T8
         93VPeSHLTwwIZQwGZjZtenKfnEOGT2yqAvizMTOA4txnkH492NeHx5c8mBUG/ctJrLMZ
         KDUA==
X-Forwarded-Encrypted: i=1; AFNElJ9U5tmLAOpkm2BIrmOd4t542yopQlfKglH+ue6bgCW241qxEuO5D2lI3fM49mml50bSeV0BNn3tF5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DyGy4brkckSRyjcEGuX5QJwtIxbgHX19HyjYbI/Vq+ZzAoCK
	TVgdi3sw//B8uVzUwimf4Qb9JVcxDGYOjjX3DQG1MHbRMbNdhzjtevxA
X-Gm-Gg: AeBDieumVZ+WEGcn0PfQdsd38R0M6HcvyzkAzbrpfx1bHEKLqGqto+1zbs6Ppjw87Ug
	I+XH1CsqUNqtFvl9XNrwkwEI3ThLFPsamM+jFryb+rUQz5OegmiIc/tOz9o+xl1w5W4fN53aVhg
	pG5l9IWRJmPIXNdbN0QeI/zjmaWs7ZEUVGg1mxXdAGkboUeW6PHzZytQWKpKTlldRdTtyj/makB
	aCxqS3PiR8UmVRMutE8v7KcAEa1Y6SLp3kIw2YS23LzUpjkd4nJ63cgxu4xSyMto0UrdVvMwRJi
	303kUB9z3zvUFqx8zJqM9jQn5OJPqEdkIw3lrxfMYcRSRCnB0MPNlhU9gPZzbPVWQyQZlvK/nPk
	2v2DOuXZo91XtqLejHXYrjBCKYspRkSrgmA5U0DQc8OIXaU9oZfHDRqKnWXATB823ZrGdifj3SA
	c/jTGeCAhDAFRm1ogmWe5f0sWnDsakeR1l6OTAyxIlqyUSww==
X-Received: by 2002:a05:6512:3503:b0:5a1:1496:922 with SMTP id 2adb3069b0e04-5a3efd8b5c4mr4514818e87.33.1776083962516;
        Mon, 13 Apr 2026 05:39:22 -0700 (PDT)
Received: from wpc (host-95-152-45-178.dsl.sura.ru. [95.152.45.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eef00327sm2532549e87.73.2026.04.13.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:39:22 -0700 (PDT)
From: bigunclemax@gmail.com
To: richard.genoud@bootlin.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jernej.skrabec@gmail.com,
	joao@schimsalabim.eu,
	jstultz@google.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	p.zabel@pengutronix.de,
	paulk@sys-base.io,
	robh@kernel.org,
	samuel@sholland.org,
	thomas.petazzoni@bootlin.com,
	u.kleine-koenig@baylibre.com,
	wens@csie.org
Subject: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
Date: Mon, 13 Apr 2026 15:39:20 +0300
Message-ID: <20260413123920.2459916-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305091959.2530374-3-richard.genoud@bootlin.com>
References: <20260305091959.2530374-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,schimsalabim.eu,google.com,lists.infradead.org,lists.linux.dev,pengutronix.de,sys-base.io,sholland.org,bootlin.com,baylibre.com,csie.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8568-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigunclemax@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03D473EC105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Richard,

> +
> +/* PWM Capture Fall Lock Register */
> +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
> +
> +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
> +

It looks like there's a typo or a mistake in the PAIR_IDX calculation.
It should be like ((chan) >> 1).
For example, for the 5th channel the result will be 1, but it should be 2.

Best regards
Maksim

