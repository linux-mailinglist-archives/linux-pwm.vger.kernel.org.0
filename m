Return-Path: <linux-pwm+bounces-7884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D9D0566D
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8663016EFB
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FEC28A3FA;
	Thu,  8 Jan 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coepQlIp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80B23D7CE;
	Thu,  8 Jan 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895851; cv=none; b=TwAdAE5NyfbW31eVuijh0QR8e/YEipTYML9SDKTWjntHA2c9RbWWYbhMBUBwk/ywO2w1tPs/aA7oWkXMbj3cSBNghKFhuvzMklaKVhVpiDwk/qz6AVYMNX+CcY0XfL8D4+OTgT8IhGzdmD6AUR2Rt/VXk3yhrPdhp+S9yNiZ7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895851; c=relaxed/simple;
	bh=HxrD984TY/8J5dcdrZYsYtVaWcDPKwjLZSO/VQMQhjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMmCEQpVttGHQb0OYUKDR74rpElsYLebqn5QK5tp23s+PxOaSRg6EJQrjvHorIvGhAc3g4LSo5Wnv+JjoBUt7NU9KthSvHXyIXdXBEjp/SgyMenjHZMq7d0XwxoHdZNrod3Vlt16Sz2T3vIlcdPB67N7SV2ZXIU1CdvKkAEsppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coepQlIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28D1C116C6;
	Thu,  8 Jan 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767895851;
	bh=HxrD984TY/8J5dcdrZYsYtVaWcDPKwjLZSO/VQMQhjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coepQlIpJF23fusUNrnURWlGDRI59wplNqsgpWXDKkj4EhQTqAidrq7ij6Q8QGaEP
	 SW3BNi8xTbTdKXUCWw8BTN8oq8OB5lLI0NK5BCOitMnIQsir+qpLgj9UB1JsxrC4Ri
	 AdjcVNevsdFigp70B+9maX1Fhd9J18z9Amoq/kS3/xw02EgsQqomi1l09avjpYnPyk
	 OClw/6f8xh3Uy89CPYGautdw0SeHzQVOwchRqDOGjky8ixlAEcz0vB3/d+u3fMDk8j
	 p0JPMv8l3g4TRyirj669e5TnZj7+Ov5CGTaa45aGsVifdKG8qpjd1dsiofzXEBl2pn
	 a4bbYanKIg74Q==
Date: Thu, 8 Jan 2026 19:10:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, n-francis@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csmpaggoqzdotc7w"
Content-Disposition: inline
In-Reply-To: <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>


--csmpaggoqzdotc7w
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello Gokul,

On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
> On 08/01/26 01:17, Rafael V. Volkmer wrote:
> > Thanks for CC'ing me on this thread.
> >=20
> > On 07/01/26 15:21, Uwe Kleine-K=F6nig wrote:
> > > adding Rafael to Cc: who sent a patch series for this driver that I
> > > didn't come around to review yet. Given that neither he nor me noticed
> > > the problem addressed in this patch I wonder if it applies to all
> > > hardware variants.
> > >=20
> >=20
> > I also didn't observe the issue described here in my testing: duty cycl=
e and
> > period changes always appeared to take effect as expected.
> >=20
> > My tests were done on an AM623 EVM.
> >=20
> > One possible explanation is that my test flow mostly exercised configur=
ation
> > while the PWM was already enabled/active, which could mask the effect o=
f a
> > put_sync/reset happening after configuration.
> >=20
>=20
> Yes, this is the reason why the configuration was taking effect for you ,
> Rafael, as the PWM was already enabled when setting the configuration hen=
ce
> masking the effect of a put_sync/reset happening after configuration.

Can you provide a list of commands that show the failure? That would
result in less guessing for me. My plan is to reproduce the failure
tomorrow to better understand it on my boneblack.

Best regards
Uwe

--csmpaggoqzdotc7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlf8yUACgkQj4D7WH0S
/k7d3Af9FDCnaBlzNSjLFLPyDWj1PZRHRu9n11MJ0i828AKjeiis9wR6FO8OPEYK
ia11Kis26cgk0RsGABb1Shy3wyqE3UjD1Ms0xOlR0hHbkqU8BZPUpUpRqNBCtjfC
LQijgsuLcMoY6BoakyTi/Ud91SXhMlcvq2hjKHHiMvtBHWr3seMppzlq3Bq/kj8e
Ug0SKzMBPdJuKC/Kd7hQBNshretniSzUb6kwhwZPyyQaeDKFUxsruet2CWuymrNk
UcLZCKmfKOaiQCd2lQsmSSilO08wffg+3QMMy6/5NBpUcT+smdkuBuSbepLdzm7i
2BMo/P1oJK3aej4NqthMkUi+COoYvw==
=KO+v
-----END PGP SIGNATURE-----

--csmpaggoqzdotc7w--

