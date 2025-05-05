Return-Path: <linux-pwm+bounces-5823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D3AA9539
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5812C189B06C
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E674197A76;
	Mon,  5 May 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tIgMv3Cl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8317B50F
	for <linux-pwm@vger.kernel.org>; Mon,  5 May 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454531; cv=none; b=rTizenrS0druJKya8voqK3DKwD5BBQPTtt9Pku0UZxLoc4S8MVWCfewxY1dHLLV4/kKiYJxxuKuXIDJG6/zdORNKr1pbP4FzrjHj0tEzEhx35i43ZI2EsvFbvdt2HBKwyZC78YT6EL+ryY6AVCx+QI2OsRq/Ao6lWgy5GmHaDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454531; c=relaxed/simple;
	bh=VIzk7gtYB28WUcMxCaffHF6oUxC1cG6T2gJRk7Wdq4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuZqaExlaVul3aEz8b2OvVTO2OInFUJtg5RluXf37yQVNZ4TnPnZYzuyNneXkUjWz7/bUqpaXaGy5yARiIIsOwfCNnlw7sL4fqBJKmY5lwdSP4p4XMSd2ynJfOu4RZHA1Soe12iefevrihBtlDMFBMLJ9UictT4A9UxhZARamnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tIgMv3Cl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3474077f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 05 May 2025 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746454528; x=1747059328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIzk7gtYB28WUcMxCaffHF6oUxC1cG6T2gJRk7Wdq4M=;
        b=tIgMv3ClfrAnZ++DtwfdKSoGSipuc2PjOV0MM9Y6YwQReyCz/fsq9vJ84AOE1aeIVs
         Z9Nxjy87C1dgOg1EwokqrLp2mMXazXkZu1kWXASo+HWOsyeZfJ4xcteYvpGTxo5FEwdQ
         LjSNP+r3ncI38WjUW88xUGTi++9DqDUPowoduHjWAYR2FTsLcIi7jaHO7BQc8zBBILOA
         PlKP8kxdT7NjddF2F6BHYcTLfVCfzsadioxCswGwFp/6SFdP3rFB5nZ/R6z1iq2Fon2F
         bUPGyp+jpvGuc+jJh5h40Ui8zBtL5sgK2Cx83vVKOi63Ep9oBXh3ALXf+Qvbq41tkQLp
         sSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454528; x=1747059328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIzk7gtYB28WUcMxCaffHF6oUxC1cG6T2gJRk7Wdq4M=;
        b=B10m+w/t9lTAqP5U/Y47HFFNJBU6gQK7A+apYMl8J2BeV2CWyjMWKDVZNWt6OXeDQ/
         yo7AmThPMWk8YNvpnaRCMFoY6roieiKGMXAOEdXaFtFpjPPVT9COzPC3WxMaSFF9yfXq
         r7aaTU/FqqslhbNXfgvNK9FHTkTwmGvqef6zpvLhcx2nQdWo2ydTL4bvGiYwki0kCF6N
         RKopBgrWdJkzq3N6dy1mccl/d5g/4rV5fPIo/q/OiEh/B1Lvu51m2TgHW5ip0dBnS+WJ
         30NimLyhZJZA7TbyQQotN5sg+a11b0JzKTshTsw5Sd3yl/Z6pXh8pkiulLKXXeMkIjUz
         dFwA==
X-Forwarded-Encrypted: i=1; AJvYcCVyoVnvJwY0edSk2m7niydHtJrUbRdJV4Ipqv2uexT1+Tmt1Pr89MvHnz4Vm3gJaC9N96/PamZva2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATTDeBA6AP7sq6b/yISZMs/5vQi2RU0Hf4IxLGvIX+cuwIu/E
	Fe/5UYVKZEb+glxNCguDgsyzjDbuLW6WoVQIDblRcQlVvBkmMrf6sDVucytiwMo=
X-Gm-Gg: ASbGnct8UqxJIBDfxFAWJ3tow8zdTM56NisGhSKlZps2Jl1OaPgIOyOOPl83F3TT+JJ
	O5Fyj473kzRUVIvti9keByPkstWAZmanFck2ZfPjk7WmTuJ2ztknu3HzbtTP9fnJrTaq5J4cD2F
	THoENXJyS/CGFxs+BX3O92hGry91QcMkRaMtOGke4xDwAdDolCAVkzhTjZM8jG80uEqvunpbuen
	P6kRc18q6axHHbwqNAFS85n7cRjYiTIVp7cKFGnKNyf63nUbkRFcCcfs2Qrt66QHojLJYIgB1sf
	Ir7hwvbjXnYwKXDcxeMYeMELcoDq+Mawpd8iQGfwSnCcn/myxzGdggrU4XXUuM0uApng9ITGJDz
	Fh8w3KiM=
X-Google-Smtp-Source: AGHT+IG9eZwbQrU8o0UZPUEZ4V+8pzTpRVFyCpoHq2n5EZUfHNLzK8DAz3/XlK/eNalcb3vKmwDU8g==
X-Received: by 2002:a05:6000:1867:b0:3a0:8325:8090 with SMTP id ffacd0b85a97d-3a09fd7614bmr4959995f8f.18.1746454527674;
        Mon, 05 May 2025 07:15:27 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a099ae7cbbsm10727995f8f.53.2025.05.05.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:15:27 -0700 (PDT)
Date: Mon, 5 May 2025 16:15:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Uwe@legfed1.smtp.subspace.kernel.org,
	Kleine-K@legfed1.smtp.subspace.kernel.org,
	dimitri.fedrau@liebherr.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <w26ohdzfoci4nztulnzngqy54m73qkhy6k55mwfzdyeqjpqiqa@hmbshtcbhite>
References: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
 <cz5tzcmkpkoi7f6g64opcoq5mclahyom4aqafpjxmhisjidize@uw4uq3pmxou4>
 <20250505125749.GA12411@legfed1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpi3sdp44g7whwuv"
Content-Disposition: inline
In-Reply-To: <20250505125749.GA12411@legfed1>


--rpi3sdp44g7whwuv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Mon, May 05, 2025 at 02:57:49PM +0200, Dimitri Fedrau wrote:
> On Fri, May 02, 2025 at 06:47:49PM +0200, Uwe Kleine-K??nig wrote:
> > Hallo Dimitri,
> >=20
> > On Mon, Apr 07, 2025 at 01:21:50PM +0200, Dimitri Fedrau via B4 Relay w=
rote:
> > > The MC33XS2410 is a four channel high-side switch. Featuring advanced
> > > monitoring and control function, the device is operational from 3.0 V=
 to
> > > 60 V. The device is controlled by SPI port for configuration.
> >=20
> > Applied to
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> >=20
> > as v6.16-rc1 material. Thanks for your contribution!
> >=20
> > Best regards
> > Uwe
>=20
> thanks for reviewing and helping me. It took quite a long time but I
> think it was worth it. When comparing to the first series, the code
> quality improved a lot with your help, besides fixing some bugs.

I'm glad if that is your prevailing feeling about that driver submission
and not annoyance about my pickyness and the long time I need to
communicate it.

Best regards
Uwe

--rpi3sdp44g7whwuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgYx/sACgkQj4D7WH0S
/k7wXggAgxNVBDtDJ85dVmVVNJq6UQe54mXO7dCEDj/5BbnwqLiNi3UoKuLs3JPk
oM3MoAfrcgURIjT1oJeZsYjjQhbdKcGPogqNOEBF6i0tVPcRfqdACUlkeHHGtpKz
POChmt8g6ryuc6wMIOhJTuK5GX1IgOZDYekw5xD8w8Iz9HkiSbmbjzXTABitLqw7
hKYP5/qRn79MYL7klNpdJV+WTujiYlWUmkjvYgDKtXAuVY3LgmC3RcUqzvva3LH4
+T+/JH7S7RguKkGki2p0NT20vOFX6AeT8DuJp/w6Bs9I1xisjZjfg0cLgPkx8O4u
CpsW9tzeg9iuNJlomq71ywwJxKhczw==
=Q0Rn
-----END PGP SIGNATURE-----

--rpi3sdp44g7whwuv--

