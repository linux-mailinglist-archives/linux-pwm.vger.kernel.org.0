Return-Path: <linux-pwm+bounces-3983-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC279B7913
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 11:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11971F21DB0
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16B13A25F;
	Thu, 31 Oct 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e2+lkE7b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8A198E86
	for <linux-pwm@vger.kernel.org>; Thu, 31 Oct 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371993; cv=none; b=ivcKXqDti7Qx3QZPYuDY0ywUuDiaR2V65VKQTNUioTtKQLWsn0Y0Q9i49ZJEjEN8oQhZ9F3aFx5sE9H1R8hCWqKiES0M3576iWEahHUG4Rlwd8d7OZmsTWcyp3rxJ1TNJnM7WOAipyKMaF5EvKr2joShQ4ASeM7n1QDp2UQH5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371993; c=relaxed/simple;
	bh=VoH550F/rVtXbdjnsH8N0Kb36JWps2TBibjKOZE7pfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzdObGnU7y4vnSGD6AW03Vj3/iY5XDn7rQFLRPlry7/OLBk/aIFiFqaPgMtZZxY5HmzZEBZVFn0i+zOptjdkpL0jslmDsNL2Tn5HsEBgChpIKas5KUptf3Zzenue68lJeSLMZlRG0JV9mobBwI6xldjzRoutCg9/bbR9ejDo3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e2+lkE7b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37f52925fc8so440847f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 31 Oct 2024 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730371989; x=1730976789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2/PPaAetYxmKzv3sgVnjzcQ59oLRc0dcwRBbTXacjU=;
        b=e2+lkE7bM/xRb95I0mlH9/THJb5QR6TIHHhZN22/tKMggJSbQ34YOxWLpqvDwgeHt0
         lbbnbbQ/mzGWjeDtFVPFkrwO91uWer3dsqTeCecdfkMUzEcS4Ym/l8CecHRKHz3ecI+W
         Jb4bGaOtWiy+lgSwqWqI+vD2x6TcJ5dfflLusj0DcOIyIP7XxUk8JmVyp1V3b945bOXk
         9cyUyCjD2Jq3zLsdPezxxiLTH2ZS4ECFfTBZlYxLvn/EMTBtud5BIwlvJX3Y8qKpM7B4
         kRXReLlbp76ykxf1drkIWKH1SVvZgkoak4yrKumLUjXL5UWs+YRnu7h6gX69A50aUY6t
         KI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371989; x=1730976789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2/PPaAetYxmKzv3sgVnjzcQ59oLRc0dcwRBbTXacjU=;
        b=QZsCwpy/9weNN+0MCR5uA5veEOe7LIj72OVNSLmc1i70hodIjPAss6up3fQE9j9pAN
         p4wzVoLxVIj9UT/+G+l79MR+slRrhZNGJiDqO2Gnhz41Z4WFHshxKBhJfsGPTDQ9/WNZ
         XoO0KjTVUDSGRQR/LuOCORsNjMtoc8Ql7JisnLQTu3z7aEUyTLKLiLo6/kVLQnVLaj+M
         Cs9hHcRDQpewcHa76Zl3F9XDmycWOrQi1ca70/sZOOW3w7mqBj5Nxh+DmWAHKtkLZwkw
         hL70pj+m2jjVjp6rQEL/r4ccD/DluiAmWUNyqeImpgWCMr5Z/s6VcVDCce5SEFx8paXq
         PddA==
X-Forwarded-Encrypted: i=1; AJvYcCWSK+ATxkuv0JlF9GrZlBpNYt3lAdk/3Ci/N0IoXG4MZY+qmLde/l4N+w23vfHn7V1w92rOmCxfvW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwnyw3ny2l+M5xjksGy+gypXpKxPsVI1LmyAaJeBqHX4+bgUI
	Qrggvp93iBXy843kQUVBN4WDIMYPaPaacnuKZ+B5F+EizV3znhjNX4aSkMciQlQ=
X-Google-Smtp-Source: AGHT+IEj2PmCrm+rjaPGqCqvTA61rjlM2smHZN2BDqZGjYKUG6p+9lHCct26bf+Hc89r3OBtcRNNrg==
X-Received: by 2002:a05:6000:ccd:b0:37d:2edd:b731 with SMTP id ffacd0b85a97d-380611639f9mr12661409f8f.30.1730371989006;
        Thu, 31 Oct 2024 03:53:09 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c1esm1764015f8f.12.2024.10.31.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 03:53:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:53:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
Message-ID: <ljpgey6oqeisnhnf3zojnmczxvpduabj6cgf3utef3oic2k27e@r5sbpdxwzghs>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>
 <bf5lpb3dwfywzgnbcel6de57ick7hfzxfaovyqrt7juif6tgp7@sdmugrua6t3c>
 <184f8707-0b4b-474a-b2d4-b54a3438f4a3@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wg4oaapc6iokbp6v"
Content-Disposition: inline
In-Reply-To: <184f8707-0b4b-474a-b2d4-b54a3438f4a3@genexis.eu>


--wg4oaapc6iokbp6v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Benjamin,

On Wed, Oct 30, 2024 at 11:14:41AM +0100, Benjamin Larsson wrote:
> On 2024-10-30 08:32, Uwe Kleine-K=F6nig wrote:
> > > +	/* Configure frequency divisor */
> > > +	mask =3D WAVE_GEN_CYCLE_MASK(index % 4);
> > > +	val =3D (period << __ffs(mask)) & mask;
> > FIELD_PREP please.
>=20
> Per my understanding FIELD_PREP only work on compile time constants.

Then please create an alternative macro with the same semantic that also
works when the mask isn't known at compile time instead of open coding
the same concept several times.

Best regards
Uwe

--wg4oaapc6iokbp6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcjYZAACgkQj4D7WH0S
/k5i+Qf/QUXWMBOT0BMZ7vYNOddtUYFZcRph+Cgv/55I6yp0wo0c8gGiYBTgjdls
BZkBjvIPurO3QEZd8dGjcYFSDkJFCfuikUofKD7RQ4wWxRsfmY88TBsztrkfqbg2
aIjBeZlp3n3SyIQ4lsQV9HdMzUGvITEGLBN3k8cbmaZyfZU08CN9n6hmZN1EwduZ
+yQtVPlDRq2k7jUiTTLbRcSqb6ngR8FajPEP+s+vYXawI8a43BIBVHZzt80AXfkG
NZTgD+fW8qmB4uUevfuVq8+yw5cTAGrTxkjh/fMNsIArbA5bNdVBUKLhTrUvMHTI
NK5mFlK9MFcl5mK6ETI1KgnKNHa75Q==
=lv66
-----END PGP SIGNATURE-----

--wg4oaapc6iokbp6v--

