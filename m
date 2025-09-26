Return-Path: <linux-pwm+bounces-7354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BEBA4BF1
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1976556328D
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AF30C101;
	Fri, 26 Sep 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx7ghhtQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0430C0EF;
	Fri, 26 Sep 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906784; cv=none; b=RwLQi99rk8pKX0X8YchNgT5W/Wzw7Sa6xqQt4Udnp3IIYnjwJ4o7xRoos5Cm7uYQSxRcKVl49pjIxkAe7mC6PDLrwsUJbdoUEmuL1ZMtoXedkp9qlTdqq6Iw76VlZxCBoGEsq2qn1dRPS2QX0rmBeShj0Dwzu0h0S2mx8NrFZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906784; c=relaxed/simple;
	bh=ATXxF8DySImgVagbX01KYc+Lj4D9MPsgcOMXyf6Qfw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrQpA6/bHdY+YYux8llpkxs81o12o1R/Vw36GFVZoIJOXtsBaWNWsGL1Gio7+LMT5v+WEqdm2S+CGxqUzR3nCuwQyl9yq7jWIeUxJ2UhfDpKDL0Bdhz5whXvyrG2cCmbSxklgdg8BTkTM7OaDkx2V6A1GaUUQ2OfpAofK8C6wbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx7ghhtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF4C4CEF4;
	Fri, 26 Sep 2025 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758906783;
	bh=ATXxF8DySImgVagbX01KYc+Lj4D9MPsgcOMXyf6Qfw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx7ghhtQ0VBB5J/76po9zzSVb1gf3nnNlwAdmMUy+hVVBq1xVxcdKX5HiLldHUfGP
	 uRb0uTVOAx0KKxn5NdQyj+8S4FPgPnl3oVjZJv+NAHZwS1w+Yu7JhHdmubMwi5mc36
	 HowRHWai0zGKEEwJMx2WIQhWajRzSTUNq/teJD7IUKa3izzqZq6Po4K5hNQUr8i/py
	 y0xjDZKjyC70jU5uR9RSpzVtS0/Z50Cl5UsanNOKJUShR9WN7+XvhrQremi2jQXkot
	 F6MeZt90M+LnEdxnPpOfPiUsSC543JCbV3XVP5UCeTo4xa8kN5/XS3xZi0dHPh5CBW
	 ReYvnefXpvbaw==
Date: Fri, 26 Sep 2025 19:13:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: use str_plural() to simplify the code
Message-ID: <e6nqcot2ju4teuencgy52tce6xapstocxu6jtxeu2qaua7d5hg@mxszv6lfqsxt>
References: <20250818083629.503250-1-zhao.xichao@vivo.com>
 <fol4hemfnbh7km5dfdkbrfxx3txc4wtv7jvdn4h2xlzxlcoyht@ax7ml3rq53zs>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fustokr6gra4dcbl"
Content-Disposition: inline
In-Reply-To: <fol4hemfnbh7km5dfdkbrfxx3txc4wtv7jvdn4h2xlzxlcoyht@ax7ml3rq53zs>


--fustokr6gra4dcbl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: use str_plural() to simplify the code
MIME-Version: 1.0

Hello,

On Mon, Sep 15, 2025 at 11:50:49AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Aug 18, 2025 at 04:36:29PM +0800, Xichao Zhao wrote:
> > Use the string choice helper function str_plural() to simplify the code.
> >=20
> > Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> > ---
> >  drivers/pwm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 0d66376a83ec..732d22dee035 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -2620,7 +2620,7 @@ static int pwm_seq_show(struct seq_file *s, void =
*v)
> >  		   (char *)s->private, chip->id,
> >  		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no=
-bus",
> >  		   dev_name(pwmchip_parent(chip)), chip->npwm,
> > -		   (chip->npwm !=3D 1) ? "s" : "");
> > +		   str_plural(chip->npwm));
> > =20
> >  	pwm_dbg_show(chip, s);
>=20
> I'm not sure this is an improvement. While the code is shorter and might
> compile to more efficient code, it's also less readable.
>=20
> I tend to do just
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ea2ccf42e814..5b75f4a08496 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -2696,11 +2696,10 @@ static int pwm_seq_show(struct seq_file *s, void =
*v)
>  {
>  	struct pwm_chip *chip =3D v;
> =20
> -	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
> +	seq_printf(s, "%s%d: %s/%s, npwm: %d\n",
>  		   (char *)s->private, chip->id,
>  		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-b=
us",
> -		   dev_name(pwmchip_parent(chip)), chip->npwm,
> -		   (chip->npwm !=3D 1) ? "s" : "");
> +		   dev_name(pwmchip_parent(chip)), chip->npwm);
> =20
>  	pwm_dbg_show(chip, s);
> =20
> instead, or drop the output of npwm completely given its value
> implicitly clear by the number of lines following this output.

FTR: I submitted a patch implementing this suggestion now and
accordingly will mark the converstion to str_plural (i.e. the original
patch of this thread) as superseded.

Best regards
Uwe

--fustokr6gra4dcbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjWyZoACgkQj4D7WH0S
/k600gf+PU+nFbjZfXAJyvbwX4XVwSis9XX1duh412jGr8zxMKxQgQszAIYLwmAI
eHrjJoHPL70yWfhRIL4hNI+k8+rncoKYNryLe7dDDLxOXk1HGcmqh2AyI83u7Xa7
38HCtDQjAENLOfyI+Zu7kNN6OfGipyuUrVEiVYMeoDS1Rvpz8WbEZoVD2LGqZXao
3XzmxfxMH3s969XFgWP8lTb9XOGb2MONFm6QD5mtfIb5gv0xf7QmKj+qqeARsPgC
w51gappW6KveFD+YSesOA3YGmk9O6p/pdvrSzdsx22PVmWqwRbd5Q3xbqQSzXGH9
dFF/syjMAn7CoJA78+QH0nwlb7lZEg==
=sDER
-----END PGP SIGNATURE-----

--fustokr6gra4dcbl--

