Return-Path: <linux-pwm+bounces-6876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECAB101C6
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 09:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC61F1CC6A88
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154A325A2AE;
	Thu, 24 Jul 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBF3EF7E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62222580CB;
	Thu, 24 Jul 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342221; cv=none; b=eZuWt2cjbFCi04HCR65wXjvUr4WM1BQu/dIhO9Hz7mCp+8zOTrrqum8YZQp15T06n50C5KhnmnNr7+xM9bRwL4Bbwr6fqNeEn6nlVG5CeFJx/lBlZFIkY3hybW3JcWxkbTOlwR7jp7NuWUUjCiFpp0zllh9a1CLr4s/KbfATF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342221; c=relaxed/simple;
	bh=tmnXMDHJx/99hkHb3MwTeUa8K/p+mLiagTzuITcb9zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoCruqD1os1ZsV/NlNTPJUbitKcVVsTRhxOFU+QqvXPEU1WadDL/ZtrUEeJN77lJqLIg6iZgHMdXNeqERDjn+vrrwJILQ9l34oaIae1cxVCesEgolur6R1Caf/W2X56BjeaPBrIzJCN95PAUGGYTxY/QIPOsR8U7VG8rsQ6R968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBF3EF7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06408C4CEED;
	Thu, 24 Jul 2025 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753342219;
	bh=tmnXMDHJx/99hkHb3MwTeUa8K/p+mLiagTzuITcb9zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBF3EF7EocOh+SjTFd6bvXybnpQogIGqj5/9zY/yOovidzXAObOU96sGA1FB3D0Fd
	 wGSpAnik1aaSvmpSCdPuunLZg4ze5TnIhdkh7jifObhTwMl3UcGTS+aC7yqa6TNWOV
	 PXCsvCi2WfLiLUIRrGTSEw/58sNjcESfrFxfskf28QLE9+o06PlugI12jo2UU59het
	 Kb15zPHn9dc9bC4ClvKVv75zXmAmswUIsAeK1COfz0fH7dbIzLLWitHdcsEMPI0ZLf
	 8ORTE2H9Bn/TAGv+u0S6324VwudGvuEFRV30EZapeKqhrMdJMCz8zxRRD+3qMK6yxN
	 ykDa3sWtElZ3A==
Date: Thu, 24 Jul 2025 09:30:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dimitri.fedrau@liebherr.com, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v5 1/2] pwm: mc33xs2410: add hwmon support
Message-ID: <5fblcb3bbwclh4w4dm3s5ue6eplahka5idqz6z4g6ttmhqb24p@jaqznheusac5>
References: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
 <20250723-mc33xs2410-hwmon-v5-1-f62aab71cd59@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltkty334uks52aqs"
Content-Disposition: inline
In-Reply-To: <20250723-mc33xs2410-hwmon-v5-1-f62aab71cd59@liebherr.com>


--ltkty334uks52aqs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/2] pwm: mc33xs2410: add hwmon support
MIME-Version: 1.0

Hello Dimitri,

On Wed, Jul 23, 2025 at 07:34:56PM +0200, Dimitri Fedrau via B4 Relay wrote:
> @@ -361,6 +373,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> =20
> +	adev =3D devm_auxiliary_device_create(dev, "hwmon", NULL);
> +	if (!adev)
> +		return dev_err_probe(dev, -ENODEV, "Failed to register hwmon device\n"=
);

Not so nice that you have to make up an error code here. But that's not
your fault but devm_auxiliary_device_create()'s which returns NULL on
error instead of an error pointer.

> +
>  	return 0;
>  }

I applied the patch for the upcoming merge window to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E Expecting the merge window to open on Sunday that's a bit tight
because I like drivers to be in next for a bit before they enter the
mainline. The major code change is in drivers/hwmon and I assume Guenter
is ok with me taking it for 6.17-rc1. If not, please object, then I'll
not send it to Linus and wait for the 6.18-rc1 PR.

Best regards
Uwe

--ltkty334uks52aqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiB4QUACgkQj4D7WH0S
/k74oQgAqOmDUlgET+KF+bAbcRInPenXCNIa+ras9CAuOvWfwDvk7GGrhkWyxPBR
RrviW1kudBEMVlRFE16cEMJGulcHOcZU2Y4idLvG7IYwUBJZIOlFv0neX5HaZ2Wt
6dz8sqxNFnvp+qfHkIpwQoqJ3eUuyoFkMawO2WNs7ZgRit0psaw6AVdCbv11c+U9
R9QQAWcdtCSbxNq83bdj9l7AaWZ+YKeMsRXIOhxrA0OG+3CfBnWgbgi3O9K4y+iJ
zrMqbR0tXyHV53RZ+rm9AZlzIgExGg489uoI7cH8W6w92J9M2n15WtLARKVl9sxc
+LV4eyF+bAlGvCdxJstZJThBVKJ/eQ==
=2+RC
-----END PGP SIGNATURE-----

--ltkty334uks52aqs--

