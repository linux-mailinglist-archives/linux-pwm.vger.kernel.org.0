Return-Path: <linux-pwm+bounces-5844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F00BAADC29
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8FC4C24A2
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552A202981;
	Wed,  7 May 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FBHGeRui"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E521018F
	for <linux-pwm@vger.kernel.org>; Wed,  7 May 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612251; cv=none; b=ZDDwXtAtQyAQnEKEziygZRzdLV4iag02iIPZ37smC2SbZy2vSidnfKDWA3R9QGi/vAtddbjanug3Ag+4xmLLSORk0edo13sJnDbKa+i07fu4IxgWhfkR/Hgdb5gK5Vqa+g2f+u8pqUGQ2Of/3O98JzeqJXL2rtWdLU+fCmXpL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612251; c=relaxed/simple;
	bh=+5OdA0oEnVokN1rpaxGvi2C+sVk9jnywPeQTetGSAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyTf/TUrFvZ3uKEmDVCi/lfRLTguawtxiSP1TiV57aNewFoor5FN4WCjUPLp4ajBHZkAcKqrSqpbTZd//7b6wDYVxoSbl0enYkRijsA3lwDwCIh7nzijmwALqIAFgw3jQa3wMyx4BtFj4LGa38TdCWO0Vtn2/JPqyN+WKLVGR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FBHGeRui; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39bf44be22fso4510122f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 May 2025 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746612247; x=1747217047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4drvJJUgYEZxCfccWRhpTUQplm3nJwkaeKuYVaNajo=;
        b=FBHGeRuiP/D5ULFDX4C8tJN50BJFtLetYxx3xI3Ym3Lq1O2sZSHPTyEDoo2uLNs2tJ
         x3phYgvnPlIniqPl4b132a33+qNykw9umaiz75PKaIqprOGaI2MkJRk7h0IUd4mco5aQ
         qECR3O7YxPTewhqrGPzYsBilX+zUy5MnEMG8rXjFe+hCk/2KloiSoPLKzZ54JLtW5ehW
         wzI08cZi4JxsBNLxz1w00rxRUrXsIP0lhNmZFrHb9GvUp7LCmmv03wTbtSZlb75hUISp
         wtypzjvPQFuBzFXWjJ9tGvflPtnraZcQJvPTA57GAEoLrGJ9zl5VL6EV1GebgbHgEzGS
         P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746612247; x=1747217047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4drvJJUgYEZxCfccWRhpTUQplm3nJwkaeKuYVaNajo=;
        b=jGmaH+0++oYOrJxFUEDPJVP4pRBRnXUMIYfkQvXeo1I633h9olwUm57KNKKZSiLD+O
         BUjBjgcq/5b7C8HBoJSdLFV7MCJkiAvV2pE7NFKkGh+96tcS7lhPjCuxcsvRb4vwAqOz
         GbUEO9rfu2wiM5/k7RliWuaAH+mbviCy3Hk89ZXRerFbXzg9gLZfrU/4TiPPgjk6mNg5
         84hRVe5WUAuKkJDOfOdgC4OarmxDO027g3nZEtRTx3WS6T3ZyHIi6tSj0zawVVGNRlhm
         w4W9GAjAYJIer5ZwMCvMaKRF54kf+HQ2SYBoh0pgkTlcVf/ZJQvh4jjfmaOHbg9QkqIx
         XraQ==
X-Gm-Message-State: AOJu0YyWMQcUQeH/tJS9hsyWaiKoRVAQs4zJChNbE6Ep12iIVWUVtsSK
	xsBd51m1/z9eKntTBey+YMGnyfR0Pj+SRbNlCbWXDIRnExyOyhzOpwL67ykOdjmJunf1Q3OHtoP
	j
X-Gm-Gg: ASbGncty0jUKN8Ng65bL2QNoP/waI0a0k17yzosyjkro+9yFP+MxsBfIdhlYxlT30Ap
	bqOeB7AFXo4z9jatZF95CNEwKnB37qkq8jkmfaPEhfdzRTSD/o8MayR+gRXZYHFnuvJ6/209iHD
	yp+YvxPe8/d8JUtu8LQFxn+3BI6bI8M4JZ8ufxitX47mgEVdG82XaC+zHzugINEoL3IYQTMXae6
	O4LU5H2gBIi4+CqQPELYPNmcIqCyfZWMbcS+yaqIQnRfGzGYLjiWIplNM8Dyir5AHyHM8peLXe6
	1CmZWR25Yb70PO4iVo9vGJZGtHHJ64fqwtYc4D8I2vEUrsQOL3SsPmD2bT6IS4Pm6e6wVT8+tjW
	KZ+bl7Dw=
X-Google-Smtp-Source: AGHT+IEaSN+8g1NFKyP/wiEuCt2qNtlAySEQ9Eluq9F9UG0pScqdYhwwvlQsl1TiQ3pW5g9bViorNA==
X-Received: by 2002:a5d:53ce:0:b0:3a0:b72a:b36 with SMTP id ffacd0b85a97d-3a0b72a0ce2mr649663f8f.36.1746612247148;
        Wed, 07 May 2025 03:04:07 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a099ae7cc6sm16743937f8f.55.2025.05.07.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 03:04:06 -0700 (PDT)
Date: Wed, 7 May 2025 12:04:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] pwm: userspace support
Message-ID: <yvpdeff577l72zxbtz2a2pwghzk3app4dfntjfgijdultauvea@dqkaek7tbbos>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rfq35pycrfzygjr"
Content-Disposition: inline
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>


--2rfq35pycrfzygjr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/4] pwm: userspace support
MIME-Version: 1.0

Hello,

On Wed, Apr 30, 2025 at 01:55:57PM +0200, Uwe Kleine-K=F6nig wrote:
> after the feedback I got from David on v7[1] and some internal
> discussion here comes a new version of the patch.
>=20
> Apart from rebasing to a newer base (current pwm/for-next) the only
> change in the relevant patch #4 about return values from the
> PWM_IOCTL_SETEXACTWF ioctl. Instead of returning 1 if the request failed
> to apply exactly, return -EDOM.
>=20
> The earlier patches in this series prepare that and implement a
> similar change in pwm_set_waveform_might_sleep() to simplify also other
> users of this function. Patch #3 is only a documentation update that is
> not strictly related to the userspace chardev, but reflects the changes
> in patches #1 and #2.
>=20
> Feedback welcome.

I hope that no feedback is good feedback and pushed that series. The
first three patches to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as v6.16-rc1 material. The last patch only to pwm/for-nexxt which I will
push to next after v6.16-rc1 to give that a long time in next before
going into a release.

Best regards
Uwe

--2rfq35pycrfzygjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgbMBEACgkQj4D7WH0S
/k43Kwf+MCeLEQtaqRQp3PKuwsCxXrVgqiIWBtSxhmcZpHfDOqHkAYPzfe5mHgaU
r4HpXdFemnQ5KcQFqbjSkhwO7pxWewfO4MOjXgL0TdKUKwsKE7yoB+Cd4wM219AD
cLeRtxR97DUCM8eH4mludOJ9ooD+HdnMXKskRlUik4yPmaqU3eNFVjHsndqOo43B
jqGkB1/MiDv+NupH1VWeRD4ruZ19yGXup1/JGaNmnG3Gz++jxGMZ5SpsPaHS5Ej/
/rnP5ihOWSpUUCx6VFibZwukq2TcI8nDjzm27IxdOZB/K182Kbqb5ZIaKzXZGVv7
ctJjAnZoDNrXZyA751C9WBE8kYlgQQ==
=FhI5
-----END PGP SIGNATURE-----

--2rfq35pycrfzygjr--

