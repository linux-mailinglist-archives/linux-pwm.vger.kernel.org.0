Return-Path: <linux-pwm+bounces-3186-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D284E972B66
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BACB23507
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050C185E53;
	Tue, 10 Sep 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="diDFjKNx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A533985
	for <linux-pwm@vger.kernel.org>; Tue, 10 Sep 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955306; cv=none; b=OeCBYlPpO27zE90SkuNczOcATKZavyZ0t/AcnRWAIzT/SRkvlQPQa/XW7fEXe0A3nM1AmtjcauIO24g3VJ86NXqphnRNlC8q3wHmn5YMLfWap9rLhMHS9J5NrrQJpzRR06mo7OrjMRJ2UlXfkhixG/ii6Nk4OAzCxbxjkO7OO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955306; c=relaxed/simple;
	bh=/r6IUis8EJbLyFM6C8Q7kCm8hDOlngYXSkv1zgZDfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LusKylMSWRktv+oWdRAODyxEj067rslsvC/Jq3MB6y2lrYqlRLN/rB3v/cac89NFG9TPoDNgxC8GVScyLkgR2rKmO0vCBsZmLAM37mYl7WklGterP9SFZOvJNYP8DZfG37NNK/ECxEvosEzlB1TMedyjf0Ac4RPrE1oEMkcXtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=diDFjKNx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so12168325e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 10 Sep 2024 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725955302; x=1726560102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/r6IUis8EJbLyFM6C8Q7kCm8hDOlngYXSkv1zgZDfBE=;
        b=diDFjKNxJvXr3vwucBiQ2W6AOgcl0oH81aS2Tr+4EavFAhGlEBMLeDIZwgJiGh4tWt
         ay6HdIEuNrU1RFZ8N6qDkRf/k24XlIQAs6Drr/hEv2TO/DRrZQVK7cYHiqpNltmXDytL
         SGy27YEVnh4WjRUUpmdfsqt8AjHJm0k6JxegYOPEeOufNZn7107K7b6Z01Kj9EuLIlTw
         4qY66jiSWYdmDkFPkX+OqgTxdrOxY0DbFwSK3LfFZRF/wJzmuM7rn5Nyc/9kGfg9qcl8
         0pxxAK3Oik1gXAdoj32ke1an57iYLiogoo3mLZpPuqvZCYceiydPuRmSKMmidR1h3p8P
         IYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955302; x=1726560102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r6IUis8EJbLyFM6C8Q7kCm8hDOlngYXSkv1zgZDfBE=;
        b=nS/UDnwijE/NzKIYlECdsVES2jhDhbw7YrueqmCGvi54XHAWqlskVpQ00WSjIb0zEJ
         qnFZxvRRkaLIMGVeFx6pIEO5k+YaF5IP2pPwxhOm6o2A4i/cNjkMe0YGE6DP8q1KnMU2
         R/iJii2Xg6+wYyaTmQphO6/Qgd5vSuTSPgM+Yem7jagBEUvO+XbgLRmKwVqsJgOxRtsJ
         MsjaGrpPQejKTsb+QYO7ajgjk2rCLaawhj4MwCGR3fQahL0COsuAe2pCfkCD+QveafCB
         o9BAh+/sm0NaW0wm0dzVTrDfAKW/U5n/ojKkByZZGGX5gWRfys33GLIxBgKS2Ni0HQsN
         F++g==
X-Forwarded-Encrypted: i=1; AJvYcCXt83CL7Me9VoPMO0mr8IciQ6kFI5GEy50wmyT93x43NQxqhLW2c9ve1QYaKWoWhTKX2xd/rdn06Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgmqrP3Mk/93OIWxd8575F/3Ks8VkBaXAQz6A01m4gdbmm6a+
	hHt7t36H6OWFIsIxUJEdM94BCF+f4cXVibRhvrMvMEUKwuVt4+TzRhLIhY4Q4Tw=
X-Google-Smtp-Source: AGHT+IG+nXjNuOi1bG5OAXxiKvCxpS9SGnHKIVE3xSF72Xioz3RZFybD57LPt1sAtAgTE84B8jAhPg==
X-Received: by 2002:a05:600c:17d4:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-42cb16e7addmr53122225e9.12.1725955301542;
        Tue, 10 Sep 2024 01:01:41 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b2f4sm102922055e9.45.2024.09.10.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:01:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:01:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Conor Dooley <conor@kernel.org>
Cc: George Stark <gnstark@salutedevices.com>, 
	Rob Herring <robh@kernel.org>, conor+dt@kernel.org, krzk+dt@kernel.org, 
	neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, hkallweit1@gmail.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
Message-ID: <ak53ha3kltm24s45n5pczvibtltzocg33inpnro4bjeolu25re@33lae7y7qzvw>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-3-gnstark@salutedevices.com>
 <20240712125219.GA472311-robh@kernel.org>
 <55f73e79-2d21-48ba-8486-26ee168c7bc3@salutedevices.com>
 <20240725-excursion-waving-0e0ad54006d4@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rkd4jonklnzz2ghs"
Content-Disposition: inline
In-Reply-To: <20240725-excursion-waving-0e0ad54006d4@spud>


--rkd4jonklnzz2ghs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 03:08:53PM +0100, Conor Dooley wrote:
> On Fri, Jul 12, 2024 at 06:12:26PM +0300, George Stark wrote:
> > Hello Rob, Conor
> >=20
> > On 7/12/24 15:52, Rob Herring wrote:
> > > On Thu, Jul 11, 2024 at 02:41:15AM +0300, George Stark wrote:
> > > > The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
> > > >=20
> > > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > >=20
> > > Missing ack from Conor. When you submit new versions, it is your
> > > responsibility to add tags.
> >=20
> > I had Conor's ack in my mind but his response was related to the
> > squashed patch (a1 compatible + power domains) and the current patch was
> > a bit different that's why I didn't dare to add the ack.
> >=20
> > Conor, do you mind if I resend this patch (and may be [PATCH v4 1/3])
> > with your ack?
>=20
> Ye, both are fine :+1:

I interpreted that as an ack for patches 1 and 2 and applied these to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E I guess that interpretation is fine, please tell me if not.

Best regards
Uwe

--rkd4jonklnzz2ghs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbf/OAACgkQj4D7WH0S
/k7u8wgAh+MoDvk6VmcbZhv3CNsVOKqhoT+xIzvJgiBbhHlANMT/TSxuBhwe7un+
YHK3prRMH8wJsJoD0CqAVKt7O34BIAQiG7uQxbJ8LLVIGTgCjIZGiOibvb9jc0q4
yzLjuXJGP3hkonekvncYTNgLM+U8FNP5t6ZjXR9BrB6a556c6Zx5go4JC0EE+wG7
BE2uNduWzkSzmvpUE78R+PftaDr9iCuPjIereXhlVXYXLxL6wrDZLxFRtyOD/bP4
AKX4Wuf2rq6TPy+5XfGFjSQtMVp0W/5hSTZYRS9v9af1dAPe213qY1DDCOL0rZp1
lwGevELL5nVRIgso7w0Dr9q5kj9/YA==
=kVzG
-----END PGP SIGNATURE-----

--rkd4jonklnzz2ghs--

