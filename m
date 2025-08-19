Return-Path: <linux-pwm+bounces-7094-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD983B2B947
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF24528578
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7902253FF;
	Tue, 19 Aug 2025 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBILDhUH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B21E5705;
	Tue, 19 Aug 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584155; cv=none; b=qzzWGN0eHXt0ABk7Iz5rKXFjR2kpVNY1AGVqJQMK0sHSEfXW6YJyIzBVE6497ktbjCj5YQuRM1D+8C0IIiqcQ5USsb7cRWDKeNnBTyEshMVkSuMrcSiSbLS1Fc6lcKOR0BYBUOEs8HKVaH2ueFsQQpHTHAsAcQCFSdbLrLDhIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584155; c=relaxed/simple;
	bh=Rj+br0uar17MtWKg9EC7mJGsfV0+cmEqiMrcKGXxyGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCr51yJVwnegpMl9KvJpMxULnvzwXAImqhSW/fdgGaHBIsQvAcsIQbYGzpfpFq/rLDUz06Wa7GVkRXPbxmQXKbLC+1rKl2TrH4tSJTNia7u/JGlqYwrHSQBjpHfN5kh0V1kBD/DnV/Xa9jDOMaRk8+wYmpspu1NU54kzoMbK5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBILDhUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E463C4CEF4;
	Tue, 19 Aug 2025 06:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584154;
	bh=Rj+br0uar17MtWKg9EC7mJGsfV0+cmEqiMrcKGXxyGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBILDhUHF58jh1VTpAEKL34ubrfyWWmptwP3gslRvCkPvkbQIJC4rQnnxjMgYfKul
	 R8ORuFQ7EM5rgW/JVBFToyoHXzxP136gTELZs3QAml/GKQftMiCIz64I7KaPceiJSa
	 0aGT2gAKfoTcdAggts7sOVuUvqec88acs4lSqQcKDR0bxpOsBKVQG8D/4iQ+ydw7Zs
	 b5w0tPBJri9yvtKm8Tm2QF5Nq6S90lC+SC32hYZ2HQ79tfgST+HJ18tmQokiV7NKiF
	 /UWH/f+xGl/v+esp7DrtN1wDn3nNObCxQKz97UdNIKitE4i5AT+8cnjhTD6KjKJNzu
	 dALvJknulsDAg==
Date: Tue, 19 Aug 2025 08:15:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
Message-ID: <jioslz4fxpjhmrbjpvihorkuc5w6uof64zhmoeogil4lkjpz2m@xdqn734ie57v>
References: <20250815031016.31000-1-jszhang@kernel.org>
 <rscqtwztqwtihcq7rwvyjvnkbo5bmve257i66e3it52cnft7pb@6gwbgx5o7lpt>
 <aKMX_c3gvYc6E3DT@xhacker>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4yry72k4mzj7gdud"
Content-Disposition: inline
In-Reply-To: <aKMX_c3gvYc6E3DT@xhacker>


--4yry72k4mzj7gdud
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
MIME-Version: 1.0

Hello,

On Mon, Aug 18, 2025 at 08:09:33PM +0800, Jisheng Zhang wrote:
> On Sun, Aug 17, 2025 at 12:52:01PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Aug 15, 2025 at 11:10:16AM +0800, Jisheng Zhang wrote:
> > > diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> > > index 831aed228caf..858d36991374 100644
> > > --- a/drivers/pwm/pwm-berlin.c
> > > +++ b/drivers/pwm/pwm-berlin.c
> > > @@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
> > >  	for (i =3D 0; i < chip->npwm; i++) {
> > >  		struct berlin_pwm_channel *channel =3D &bpc->channel[i];
> > > =20
> > > -		channel->enable =3D berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
> > > +		channel->enable =3D berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
> >=20
> > BERLIN_PWM_ENABLE is 1 and BERLIN_PWM_EN is 0. What is the effect? Is
> > the low bit just ignored and the right thing happens? Or does this
>=20
> operate the wrong address then kernel panic
>=20
> > result in a bus exception and the machine catches fire?
>=20
> Yep, cpu exception then kernel panic.

Can you please mention that in the commit log to make reader able to
judge the importance, please?

> > If it's more the latter than the former, I wonder how that didn't pop up
> > earlier.
>=20
> This bug has been fixed in vendor's repo for a long time, it's just
> because we didn't upstream the fix.

Wow.

Best regards
Uwe

--4yry72k4mzj7gdud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmikFpUACgkQj4D7WH0S
/k7TKQf7BqDvUJo2n8++PSOYcti10I+2dVj9WUNdh/lAAFmDqFn+0lBTVt+R/G4m
5DU7q07D01HRVYJeh3s256QtCPGtiFUb6nnUT/yfjz6hgzcfAHfPt3NRTAs0ALsL
Z4GC3pT83E5AC1eyX82+/nQxdnhGoqM2LtLzcLuNp35cQc9CWlTNlJug+KaUAKEC
5hCHa4eGo2wj5aymRhOGELvRL2e07BmQ0ysdoRihGsvX/A7Ng8VLPiXhLBAWwm52
Nkad/PPj2M22o3uiEeWS4HSl0qHbUnLHOsrNUY2Qxr4ynzDFsZa/+jDWcjByepKZ
hiy0AzCrTIm9YXwZ6T4/grAVSO8T4g==
=MUfj
-----END PGP SIGNATURE-----

--4yry72k4mzj7gdud--

