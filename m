Return-Path: <linux-pwm+bounces-8562-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHO7GESo3GkEUgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8562-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:24:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15183E912C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06123011871
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1133D3A6B67;
	Mon, 13 Apr 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QE9pOZBT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B539A046
	for <linux-pwm@vger.kernel.org>; Mon, 13 Apr 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068571; cv=none; b=LDFkhfJmFgd/+orCzWdMyABeqg01QbdpPXkAC/BhFwOOrKZWhCQT/kIxPzU6qsIkR8AqAJVJ5ixYWBmglMaV/DuvKaICKGL+6wxfb4vWYctnzk6wsHdwOGK+u+PIB3OmzNKrGjsKbV/0Fz8WcTJxyRSfM5s8CtOdzWGn/Igpbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068571; c=relaxed/simple;
	bh=CxfGIxKoQb2LcLO5FDe3RGWGfdLtQgw2PXuBhAjKw0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RiXMgclXOJwVerGZKozcCdyL9fNTVBzpKHk4QkJAKhDg35PegI2XruW2mwSfTm6asQ6Dc9vKfvHS0srMWnVOWYz25QSSLMcWX9gpWql+BRBKYHT+CRJ5oJmeCvgzfXFaCbUt3ltzmq3xwfIolvZftUaFFLRBZQY83dDkgOamOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=QE9pOZBT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d72875729so642243f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 13 Apr 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776068567; x=1776673367; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha6HWe28nHx3OUlsZpZCDg+cNxKWMrAU9vnqxw4BBsU=;
        b=QE9pOZBTFXZKxw4rUYuVWVGaY1uBcJT7qhtNsppMYzg+bEs1lHC+X1z/gH7EGL6I/z
         Wj1+9nAqQwidrnUKnnKwDrDAZ5OiElGY4Wk5m79AJH99R3xZSsykTMoHSA09gFZKJgo4
         cPOdga3eOEHmvmuW5/H6JsYbFp/P4Qi1ti32wCXnEuhLiG2gQ4l/D6Wb1Vy62e2jGmiU
         EytXKlV0WOnmX1H0yCk3vVrNLOm1i8I3vQYCWjv/6eC2ofbaEWLfdqYPhoTLgknRpucD
         6346Ad1U5kk8bZ73VammFgnSwGjZLoX0y6a8LHQrjm333EYVGDLXlyrgZIeKdr+Y2Fq+
         yDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068567; x=1776673367;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha6HWe28nHx3OUlsZpZCDg+cNxKWMrAU9vnqxw4BBsU=;
        b=Ftt4KUqaIv78PQgHBDMt/3agAYK/iW7gwBPxaAwJ0kOxivpRWDaYwQkOrebYt7a90J
         c/kNmJZQ5nQdLL3WMX/RP7DdSUtr4dohetZ6J+kWFI/VGJUTWMLoF7KM9WT8jSeiwNqb
         cH2+9QjFoEh+UPzZMNlU9JLx+P8Zf0EMl80f/nBJSAlajIWSRtUs0+YvmOI+Yu8q+8wg
         fIPsnMNpIB91i2RFP04u/roqVMIVDieOPFUQS+ayQ3zfy97MZHRx3Qx7KArPzxzN/Baa
         66/9+0fDQWQ6d7EkODpkf5yRizqO1K8aOPYMEI9NqS3NCSBoRacCmDVrWMWWip8jtCeo
         QErw==
X-Gm-Message-State: AOJu0YwvvhPCsItZZ98GHYNs57Cbn8b2Jan8+JJBdTfS4z4jMYQpaSoP
	vQ/r9/7m9VqP4ZQzQmKZwdInqlwZJWc2LcE/Le+ePlMKhd8hwZ2u01WEHs1eE0ktoa8=
X-Gm-Gg: AeBDiev157xiIjY5CUjYHntq5KRkIfl0+d+o85KAGEgzp9b/5ul5DhAjQuwvEuim/eG
	3lWP5A8fJ40REgAPD6ljUpbz755ssPQt6K4FIzUP1fqQSGTvAbfmYdC45zix+1PSFPOa07/rOj4
	0i0gDtqcNA7/nzpKyia1atvLSnbl/aSlzG5kPdUWycferhDohutO/qQU8i9b9WB+WYluC7P+bVK
	7QS1TAhmJ2XmJyz0MMmOzAzyt/KM0C/pbTBWwnJnI1jQfwYx8gJ6QkxMrGELxcGnz3bRLN6UPhd
	1u12Y3D6ztbbiCFKzH5bx3+qkte120PiOjsKDHlG0el8enG3HELhFnNgdZRIQjhrNj/nl+ntXu2
	ZUxmEIQa7mNW9BLcQGGNL1wdf/IRuswZqZvGhOPVZcSuEmWxbeGT+mvdvnhDYCqaDES0esn26zY
	oowGXimtIMseUv8/KS/g9alOn4z5HPQdf5bOZk5jAQpu8e53dzwmiNn3HtPxIKZKD0UnvjehinL
	cn+b8VKVDI0Edk=
X-Received: by 2002:a05:6000:2486:b0:43d:7518:b0fc with SMTP id ffacd0b85a97d-43d7518b2a1mr6161972f8f.43.1776068566860;
        Mon, 13 Apr 2026 01:22:46 -0700 (PDT)
Received: from localhost (p200300f65f20eb08ef18127bf64e7127.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:ef18:127b:f64e:7127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43d63de2a53sm30258417f8f.5.2026.04.13.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:22:46 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:22:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 7.1-rc1
Message-ID: <adymoAWvo5IOs3yv@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orjkqogqxkl27e2y"
Content-Disposition: inline
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8562-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C15183E912C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--orjkqogqxkl27e2y
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.1-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-7.1-rc1

for you to fetch changes up to aa8f35172ab66c57d4355a8c4e28d05b44c938e3:

  pwm: th1520: fix `CLIPPY=3D1` warning (2026-03-29 09:37:13 +0200)

Very few patches this time around. I think there are a few patches on
the pwm mailing list that might be ready, but I didn't come around to
review them in time for the merge window, so it's just these 5 commits.

All changes are in next since next-20260330, I don't expect any
complications.

Thanks for pulling these into v7.1-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v7.1-rc1

Just two minor fixes, a device tree binding addition to support a few
more SoCs (without the need for driver adaptions), a driver include
cleanup and the addition of the #linux-pwm irc channel to MAINTAINERS.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm: jz4740: Drop unused include

Miguel Ojeda (1):
      pwm: th1520: fix `CLIPPY=3D1` warning

Uwe Kleine-K=F6nig (1):
      MAINTAINERS: Add #linux-pwm irc channel to pwm entry

Viorel Suman (OSS) (1):
      pwm: imx-tpm: Count the number of enabled channels in probe

Xianwei Zhao (1):
      dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM

 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 3 +++
 MAINTAINERS                                            | 1 +
 drivers/pwm/pwm-imx-tpm.c                              | 9 ++++++++-
 drivers/pwm/pwm-jz4740.c                               | 1 -
 drivers/pwm/pwm_th1520.rs                              | 5 +----
 5 files changed, 13 insertions(+), 6 deletions(-)

--orjkqogqxkl27e2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncp9IACgkQj4D7WH0S
/k4b9ggAhSzlBIxU9MdnbKYR+UxlUwEWvIrGRiqdogCw4++DduedOieTI1lIjBMG
paIsLePkX1uobRFGHdFA12aMREkEdb3LPvQURZ+nKeqETYRxi6e/qMdccvA1BSuy
IMc0FRgsQbpWHCNbnSRiUyWLfDq6ekcShQxaJSLR7dQJhSXHhp3UX9CPAi4JqfpZ
gVk9jvTsuW+gvNjQzprw5eQS1ugS+V3Z9LFLXwUOD2VijMbAnQTmn+zkMl1IF49s
kBa0rr8oy3bpOMbYd+XKMCYMkZv0qEJBKPHluEGaCVKZa75xnBJxP4lBt/2B5nza
aag4HLTNycbarFfLAi5xRpQ58eTEgg==
=50fm
-----END PGP SIGNATURE-----

--orjkqogqxkl27e2y--

