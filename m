Return-Path: <linux-pwm+bounces-9684-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3p22H3WpUGo63AIAu9opvQ
	(envelope-from <linux-pwm+bounces-9684-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 10:12:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D023373851B
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 10:12:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=RK3TxJLU;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9684-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9684-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555113038516
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD33B42C2;
	Fri, 10 Jul 2026 08:07:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0E3A05FC
	for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 08:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670848; cv=none; b=pahh+ceH3v+PaWaJy9TYkqoK+Xt81OwS3HAkTiqVkKLNyqzDOveYQxNDve0z8WaHtomhzyzxWf4KpsibzoKvS8RH4wRfODZhEkNReRhD4z5Vrk+T3C7uLfBuJHpBnbRqrvTW7NqzwhSR7gSsAGJ1LhkvLsVuyUVi6iuB0Bfy8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670848; c=relaxed/simple;
	bh=mSbZIZTtDLUKMqLM4SJXPxGgeFGM+l932pt1k5vRiOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCnaRLuIyPPVkHWAMZYbpzMlKxx+zE/0lS3iU/ox+78q2aXNMRJHdoJRlrUFItxKeZsscPvVvMPTZhqM/vhITU5ZNL2c8MVQ7umfPz6Zkw2Wa1ifq9tXFMiZT2exyQZ1/CC1NgY8DTwsa/QRkhHrJmrP68mSrZVs/eTaTR3+rLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RK3TxJLU; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470174001a0so429602f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783670845; x=1784275645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSbZIZTtDLUKMqLM4SJXPxGgeFGM+l932pt1k5vRiOM=;
        b=RK3TxJLUyvWvR0dDQNtkOrbGi1GTIQBMYd4ge6d9skaUk+p2VrobFIKfBlMfUhnQGv
         KVqM+qmErFd+JFVvQw0WNKAVHSQmk2QKXMAez5drWZkB+Cxk7XZbhHQ4EbOXcKcDYX4e
         z102DqiXrLEnRIDxKMP56DjgxhkZ3F7rtHDpLz7SMKOFodd+JohZ6CUfVEx6BqN7geM5
         fDnFDeHS7lZADVlbSRSlvKFOJJO4jZCbn2RS2TE+5Kz03onpgy0z5syI5aLh5I34F/sn
         y4w0dttM//NNL48B6ZGsusBcWxPAKKJTx6r/kiWc58c47lypCe3wVOhXnao7vysoXzQB
         3jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670845; x=1784275645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSbZIZTtDLUKMqLM4SJXPxGgeFGM+l932pt1k5vRiOM=;
        b=h9XNL3nPd18dLqpO0ZJzG6r08wl3Lzqb5Y1G90UPM4gvFSM87l4n00oMkOp8iJFd7H
         22pt83XtrGLuHjYQj8EBPoBzuSYuRrRCe3Yfwuru+aAq3YZ2idXxJPsjnjAF/x6iIc9T
         MxdJXQV4tklv0cNbX+1XwQpxgHXZcAYSWRxFpILycbCvaHWkgASzS7Lt+rqCBJyxBm1/
         nqdWnMLUX5XQkiAtk8rMuA5DSPrqrDute0LlJnRl8Fqy1wNMEdlsN3p8fIn0F5IPmHd8
         arXotA0R3GECJTm3NQCqPw2bv/WaJWd0wcAG7wXAiCCLokBkEhC0RjVBUSAsja3ac6cJ
         qQ1w==
X-Gm-Message-State: AOJu0Yx/HWinWamM3wvzP2+jYF1+opKFKok9dZpYES4++kmENaNHRrHS
	96XbuEw7XHhS4FVeOTcVB94jlyDO1+K4b7udj8Atcax72rRV9yIZBVUB4FPa5Fs4VfikX0adO0+
	ACav6wuY=
X-Gm-Gg: AfdE7cmKt7RYRuJX+dkaFPwIl+N/mPUavzf92yzS+KDIot5MoZd581Dt7fyv3muQHCz
	9Ck293F6bYUMDDswVo3GwmNINzFRrST+6cRbl4Vv0t5phieX9axXRlNMqtOiElAYcp0R30HLfCK
	ZwYYsbtWNGO4UOkiR2P/cc4GHFeQlWVCSZFrQau54HYzVtscq3OTXcfZHqgxX56EEcC3EQL+BCg
	1opXAHBaUjigv7kaWYXrmoWv4suPXcVcvyk/eCoQgRh15vZI+tpQgdlV1wlOjVKT/arrNO5I3Gs
	967D0d02/eBaz+TTZC274qsvSm4l1buucdDNTvqIztnV+bFkNnp0tCgZTTwrB8c53iMcxYsBPhr
	5EwQTsECcvCdJDXfVQqktmr90xLFvd/O03z7XiX6qiDM4TWDxfeZ3f4LNtTHS0RhQPz/vstpDtJ
	iHid3GLse9HsJBW5qkZ0Wp1FRC3yLE1Fz7umW3DkqouXvCMiY0Voo2pbkzNEg1D6/ObH6txxJpR
	8yP
X-Received: by 2002:a05:6000:2f81:b0:475:f0f0:9ed0 with SMTP id ffacd0b85a97d-47df081bb63mr11161402f8f.59.1783670845331;
        Fri, 10 Jul 2026 01:07:25 -0700 (PDT)
Received: from localhost (p200300f65f47db04fbea22a44ee9ba38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fbea:22a4:4ee9:ba38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa039bcdasm60375423f8f.21.2026.07.10.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:07:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:07:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lubomir Rintel <lkundrak@v3.sk>, linux-arm-kernel@lists.infradead.org, 
	Yixun Lan <dlan@kernel.org>, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] pwm: pxa: Depend on OF and simplify accordingly
Message-ID: <alCn7yq5ltsRAP5j@monoceros>
References: <20260705083910.3502207-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5tb4hvlljts43piz"
Content-Disposition: inline
In-Reply-To: <20260705083910.3502207-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9684-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@zonque.org,m:haojian.zhuang@gmail.com,m:robert.jarzmik@free.fr,m:lkundrak@v3.sk,m:linux-arm-kernel@lists.infradead.org,m:dlan@kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:haojianzhuang@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zonque.org,gmail.com,free.fr,v3.sk,lists.infradead.org,kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D023373851B


--5tb4hvlljts43piz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: pxa: Depend on OF and simplify accordingly
MIME-Version: 1.0

Hello,

On Sun, Jul 05, 2026 at 10:39:08AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The SoCs that this driver actually works on all imply OF already. (ARM
> selects USE_OF unless some archs are enabled that cannot be selected
> together with ARCH_PXA or ARCH_MMP, ARM64 and RISCV select OF.)
>=20
> With OF known to be enabled a few conditionals in the driver can be
> simplified.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
> Hello,
>=20
> while doing a treewide cleanup I wondered if these conditionals are
> relevant at all. A bit of research found they are not. We will get over
> losing compile coverage for COMPILE_TEST && !OF.

I applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

for the next merge window.

Best regards
Uwe

--5tb4hvlljts43piz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQqDkACgkQj4D7WH0S
/k7m5Af9EqKXVKajJznf7LCaNjAtLjnYKXogyd5DJe9y4h12iiQ4E0L16zTpUquA
+d8H4y6WBqv5Sw/V1kHyXR4nva8Hjse/yb9oVj9PzSCs/bfseheHbPyKGgJ635V+
N0YEJAYFE9cyv9h1EFpkpJ0lr7jgjTfv/j/XGZ/jaX1o637SKwlYRu/UCVghyU9U
ddbPgQuE1VdQeFwHn71waBzEf1Pa4xboL1VKpqAxVJYl5YWYmyLhyG24Jy45VSzI
1RfIyMrMfBpcjhp7W74SmhrlceCWG4ihxmgGOOb+eDtQ8k2YRo9eT6Z1vc9efPFq
Pi3mXdk0vITyiipLDathqGOmy46Yuw==
=5MWJ
-----END PGP SIGNATURE-----

--5tb4hvlljts43piz--

