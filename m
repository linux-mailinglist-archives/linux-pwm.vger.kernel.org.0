Return-Path: <linux-pwm+bounces-8742-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGABNzXr8GmBbAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8742-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 19:15:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2B489BE2
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95477306E674
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41A3033F5;
	Tue, 28 Apr 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CBv8WA4W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5162765FF
	for <linux-pwm@vger.kernel.org>; Tue, 28 Apr 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395289; cv=none; b=c86hYly+FTP+utoCW5PDZYv+VjmMMDlChxdnbm/2VDP4HrnnSqp7uyWbaNgHPAHWmvGC2uQy+VoZuKvyPew03YuqrE6Eoj6qmtxy3gqwBn0XtYpL7SYHgyTI+0nT1VkTa79eC1IhVZ0nZ6ZrcKRkBOiHPDK05keZG8dFJYeQ1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395289; c=relaxed/simple;
	bh=aLH/j//797kbdOCWdbEnzxU5UBEuCBrkRl9gjK5aGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG6eRCV5PnqQ8dA40vB5dTwo+U5nA5oxczLM8TydiFq9UPRvcbrNfcA0qFujGxTnLn7DsKf8oGngFx+q4RXn8ifHGCJwQ1TNnGmXGmwnNo1MbvGgNHgryWArGdEc+qDAk1VCAy9pIv8TojJ72fjlOgyfq9DGehc1twpINNZVfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=CBv8WA4W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so113342915e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Apr 2026 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777395286; x=1778000086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLH/j//797kbdOCWdbEnzxU5UBEuCBrkRl9gjK5aGb8=;
        b=CBv8WA4W7uWWI8+GsBLSOnlO6xuTzNcE4xR7NlWyd5TwqhLiSv15B7IosCqHpUOJvW
         2V6BT6Ew12WVvPDYSgRuBwU+NI73xxZdvhOUSMgDPr5WtgFnj2x3jziFYKbgxStLQNVT
         gJHb9407qbE893YwzYdTIUjfuOzK5uEO6YTbT0dG1JZhi891Cy1Hp88T3OlLj4nudneu
         sEGvbzT5NDNkwGpkF9noVg43FhJvI5V4TvXuqciUkCDTTcXRmT+iY5nXgVxo8opfH6+0
         cE0yu3qDiWmznfTPG7Pc9/jwYPy8SzBIFtMPksbfDFU3cKlXgQEylJGMWGfV6qNKkoQd
         EJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395286; x=1778000086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLH/j//797kbdOCWdbEnzxU5UBEuCBrkRl9gjK5aGb8=;
        b=Pv2AvU8z6QvqtiUOR6Q0RJLUEenQaT2Vs91+WLxnPjModWY4gKBjpzPWty+i+lEMVg
         8NrBgxrRNmTGrk/dghoidP0fmKqN7JpkiVyeN/F/qnTXG24trW2FnbBGuxdqNGzac3JK
         vns3HeTMaDlwN6A7VlEzHVmcdfgzhqXRuTZaYNWWjJ3UNsOYRIjo2i7BytQO2OgvTVFA
         NME1feXqDZtDVKWS6QYWPIZP5jkYafji1ddGc5cR7GMai7//FF+gcXXjiKCYqFqsVjgl
         YuhCMo7NVPG2WLmm+on3r4+41LPh+WDcn7yM+C5PP2tVhVQoyCwiGLYPTiFbzMYamIs+
         cBLA==
X-Gm-Message-State: AOJu0Yy3QCK3EBs/KvNpWJSBFBAX1muAgvZugLA84WB0Sle19+ycOiWg
	gWai+gphIyXKeGj/YrIOUY0+2TwmTqVGaDriPDUUK1ayk+nHTKC0wP0Q8eMmDKfRxuuHPgEdZSL
	vQOTr
X-Gm-Gg: AeBDiev+6p1wMg8yaytNM+4FgG9NF8XiXYqpRUqJheXbDKIP1TduMq3RR+toqVWc00b
	WtV0t3y5AkBonRe77SS3r3LWxzTtBCst1iPD5vbKlB81p/61do6DCp1DVE+xWJsnpUFhcH0ed7n
	ftlZpFFPf/DqQO4u18ERDBq/QiJl6Lz8fXAdBmWP4MSNDs1ZQILixe5M/AqY1IzP4vjD7tVY5eH
	WGh5bh7ahe/QIxFZ81jWG3VfN11sNMie4JzTwJgfLbKuEi4MV2Eb5xtutwg097ZQKNnyYYbq84n
	bSfiBR52AYs5gmAlO/mtHkdmSm08ODtiZ9T66uF5oBEG/1RoA5v/3/ecsIbr9HMT7JIVzyNc/zd
	wohkgojbE4ZyhyKClnII9EcYbukt4US04T5BYHev5jL5eKJo9LEbzQWjXwx1vapmzTjyrAxrGw7
	aNX6ROhePrz9lRo7ogblyMkNE8oUUG6mJRVpvNqmvPf2a1tMHCtSkP4aXwUYwcUN+6OpZIT1IXI
	LUwPjli12k7iSTRDCBdQvnGTw==
X-Received: by 2002:a05:600c:4fcd:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-48a77af0507mr60375855e9.10.1777395285573;
        Tue, 28 Apr 2026 09:54:45 -0700 (PDT)
Received: from localhost (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7b570105sm4922955e9.5.2026.04.28.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:54:45 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:54:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: Re: [PATCH libpwm] pwmtestperf: Implement -I for inversed polarity
 requests
Message-ID: <afDmL3fcPCDxfci0@monoceros>
References: <20260415143724.447340-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnn5f3aeav3tc5ky"
Content-Disposition: inline
In-Reply-To: <20260415143724.447340-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 4FB2B489BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-8742-lists,linux-pwm=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--tnn5f3aeav3tc5ky
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm] pwmtestperf: Implement -I for inversed polarity
 requests
MIME-Version: 1.0

Hello,

On Wed, Apr 15, 2026 at 04:37:25PM +0200, Uwe Kleine-K=F6nig wrote:
> The driver handling for .duty_offset_ns > 0 isn't always trivial to get
> right. So make pwmtestperf capable to do some tests with a non-zero duty
> offset.
>=20
> Fix a typo in the manpage en passant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I applied this patch to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main

Best regards
Uwe

--tnn5f3aeav3tc5ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnw5lIACgkQj4D7WH0S
/k6kxwgAqifLsD+KxrCQiMPNUX5ky7+7GOp7Q0LdVkFsDlU3sG0OgF7ary1sjb15
N5BpQHpDeuJUg+1nVyXBGrbNyD6gGZ8tsOv5SVSLg5HNimooUhtK9sl9mvDmCiGP
oKjcYUBo3p2BZKcd57nW+p6MMZzvGayvkkxLYOCmUqrnkCkZCQBem8ptRdQM4QGu
nWmWZpVy7GYv/2MWkmWhRXD00mu2g/7Fi8FgN+ydePo47kx/JLfGlLPwNybDI5gP
Xck/F+KQbv4PcUiMXC+xHAx2zBFUdCEd8lE2pXzV8+Ir5f/X19ZoAFZgRnzUce5F
LYMphC8mjkV0RcvHzmtMW38dVEPWRw==
=zLNy
-----END PGP SIGNATURE-----

--tnn5f3aeav3tc5ky--

