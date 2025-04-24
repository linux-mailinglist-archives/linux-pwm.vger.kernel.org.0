Return-Path: <linux-pwm+bounces-5689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E4A9AD83
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837049A04F9
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D727B508;
	Thu, 24 Apr 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2gTDhWO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04027B4F8;
	Thu, 24 Apr 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497956; cv=none; b=Zsnw9ajH0+56SeOz4Cc+r/jOr7Fp9x2mlbj7ANLKKVSG9SOnXha2++8qu8e8SQq5fKZBvn1PRn93Wz7enhbM2Z+jvVpLrqww+DFwCByMs2qrFuoOcieepXs0ppY9r5995dh18zDU+pvIR32zfX1/i7yjWinIs7EV2C/pApAPbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497956; c=relaxed/simple;
	bh=bAj2Cd6zSpAtHOLS56DF0jN59+JpDSzxAkHJE1Atm/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgibCXImK9u5WSJUL0iL8gAsSNRHpqLQ57A6XjyNx9il1tEQ+JarLDYWN3wyfJVHO28lVfRdpWhL05XukrgShw/pwXD8Qn6QyfIzVZwvHLUa2LMUAkQ8VbzY5Vu0r+1/r1xVIiYbvmEedKvdnnj5zK/4pSGtRHjiFLzH8dIgCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2gTDhWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD242C4CEE3;
	Thu, 24 Apr 2025 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497956;
	bh=bAj2Cd6zSpAtHOLS56DF0jN59+JpDSzxAkHJE1Atm/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2gTDhWO1lj7SAOlBxu3URZgjwWr76VzZrsEug0xRBdbsleFBAoKC7OSDwJs7GiSU
	 MUmg+ycYCjWuZFh1qem2stq0lu8i0AK+T+jdbVkimV7X9dqYIofSebXhN3RitOUZbH
	 duGERiWF3n5P/e5eXZhNXSqYLldidEf5AXKXoeooHLNkm7Q7z/6qctZsprSiPgMmHP
	 QhP8H38dZreTelphhSYUSBEqG1pLDCQlraLlv3631B6wixr173CRgpQlAOt8RLm/XN
	 IIxKQeSTGU88XvFNSWKW5xGAoJzQi9sMHqaHe4rSZbVW2q6mG2Qmu9x1KdejqAuNCu
	 n/jnOVbYlT0vA==
Date: Thu, 24 Apr 2025 14:32:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
Message-ID: <eydewrcn4tviu6fbqmmvhoc2zao3uzrxwwlc55tuxuhfrexk5k@7xg5fdeu7wun>
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
 <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
 <CABjd4YxK+4kEeS_tKBi9zhj85y6U1Dgi3nJNuQ8hfkeoY+iK1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zgtjqow4ustrybx"
Content-Disposition: inline
In-Reply-To: <CABjd4YxK+4kEeS_tKBi9zhj85y6U1Dgi3nJNuQ8hfkeoY+iK1w@mail.gmail.com>


--3zgtjqow4ustrybx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
MIME-Version: 1.0

Hello Alexey,

On Thu, Apr 24, 2025 at 12:07:03PM +0400, Alexey Charkov wrote:
> On Thu, Apr 24, 2025 at 10:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > I saw you signed your patch using PGP, which is great. However I didn't
> > find your key. I recommend to make it available on keys.openpgp.org like
> > this:
> >
> >         gpg --export alchark@gmail.com | curl -T - https://keys.openpgp=
=2Eorg
> >
> > and then verify your identities using the link in the output of this
> > command. Still better, (additionally) add your key to the kernel keyring
> > (which however requires you to be in Linus Torvalds WoT, see
> > https://korg.docs.kernel.org/pgpkeys.html for the details).
>=20
> Hmm, I used b4's built-in patatt functionality with a dedicated
> ed25519 key, not a gpg managed one. Looks like keys.openpgp.org
> doesn't understand those directly, or am I missing something?

No, I wasn't aware that patatt also uses signature algos other than PGP.
Without your key known, using ed25519 is kind of useless because it
cannot be verified. I would recommend switching to PGP because for that
the key distribution is a (somewhat) solved problem.

Nevertheless I'll play a bit with patatt and your key.

Best regards
Uwe

--3zgtjqow4ustrybx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgKL14ACgkQj4D7WH0S
/k7x4gf+KZW663SLHY9am5ym6AsnEOLVcgLLWvHMtblGN1bWaspUumkIB6cu+0hL
LFL/526WNp0l6FVL1VlQvE6paqhwVOFQT5+H0y2WvngSFE9iiaFQV7DNYAQmV+mz
T+kVdkfEZuB6+hs+bsDeoYPjS1eQ5gxJWXOW3GBPmQaPC2QpalRv8+OfXLoXxXTL
b73qrkO6WxzioMZIzRTt/kJF5KDBCi8nZTmG0PTctVHYj79KxtvAe8rFQy/Pw8j0
egilgOCIZtsftsYTiMZ8GojlxsTM3ZL/k2qo7SVnOyo0YfX8h2CzydcEKhxPSQWS
gyyVg34D3Fpkjfozq2a/CXZhmSM2Bg==
=TfcH
-----END PGP SIGNATURE-----

--3zgtjqow4ustrybx--

