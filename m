Return-Path: <linux-pwm+bounces-7641-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DEC6BDB9
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 23:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2423A4E5DAF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1C319864;
	Tue, 18 Nov 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmIowFeR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606003161A5;
	Tue, 18 Nov 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504675; cv=none; b=m7Y5CU2sQkrf5xQeVi709XgGJOTKSlUSuVM5szZaPWa0rt9kk7b2eXI/EeZAYqzx09P6QJ0ybqUzggNVSZa1rWMID4TEI9B31ETu5S1Ec70mh1TS82OvbobbbFTCvun1j05TEJQosbD50k72VhRj6WPLHMnDiFIjmcrTbi7du8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504675; c=relaxed/simple;
	bh=UI0qW0QTVsPa0WcSzC957PMkoVMadpxOQeZqRYXUvOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPZFXVmEQRm2oD0zbJR9Ef+u0+OpC4HY+m7Fs5IB1c8Q8gq8lyJxSET7mxpnpn6tfMqv/H7JUvGCaVRvcQyyx3LGK5FwQ2C49jZrG3XJETe11t82LOVzy+S0NkcfOxMQ85s+S/pqGcLyfj4MXQv6ldMKt+dYX6XLC8oQWmyL5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmIowFeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC603C2BCAF;
	Tue, 18 Nov 2025 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763504674;
	bh=UI0qW0QTVsPa0WcSzC957PMkoVMadpxOQeZqRYXUvOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmIowFeRWb8Gqona0IRcewhhdts0G4i34kQ+SAZ3mXSci7+QqYJyeIGk0bjdoONb1
	 1bnRVuXfnSUnufaSzyrN6k0qfReex8cE6CZ5P7WlzY/MBOl1LZmb72wyxCRYOsYJOi
	 A2GpYzVHVUXH0dvrTx9rm8UM7IrtyKf6bC9K2HBHyTyJLjJQNhlDVtYDYhpA5Z2Gg0
	 IIf07fHHtigGROrf7VAX1wen46CnOxLoEEJL6rw3nmQPScDmNGjQKTRx1jz6xTKNxG
	 TBOSW8jIZmR2zkdqAHi4NEvVRn6Ec3D8o8Opi9IidXOxTfCB5lt6cZqkUGbCWIiQ6c
	 zREegV8fphxpg==
Date: Tue, 18 Nov 2025 23:24:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Message-ID: <4xwhsp76tb6dn64n7nvyok5j4x5a3jbuovyqdrfvky5iz7rrih@ll4gpo67vn2i>
References: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>
 <ppqewbxcvsqcpp7met6vupmvxaftfjwiefej2c25jw4hoe3c23@lyh7saabrhkd>
 <TY3PR01MB1134679D611D611AC2CED72F886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="re7q6mbmcl7zwywz"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134679D611D611AC2CED72F886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--re7q6mbmcl7zwywz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
MIME-Version: 1.0

Hello Biju,

On Tue, Nov 18, 2025 at 05:03:34PM +0000, Biju Das wrote:
> > On Fri, Nov 14, 2025 at 02:56:01PM +0000, Biju wrote:
> > > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > > index 360c8bf3b190..ab91bfd7da48 100644
> > > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > @@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_c=
hip *rzg2l_gpt,
> > >  	/* Stop count, Output low on GTIOCx pin when counting stops */
> > >  	rzg2l_gpt->channel_enable_count[ch]--;
> > >
> > > -	if (!rzg2l_gpt->channel_enable_count[ch])
> > > +	if (!rzg2l_gpt->channel_enable_count[ch]) {
> > >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > > +		/*
> > > +		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
> > > +		 * variable. This check is not valid, if enabling of a channel
> > > +		 * happens after disabling all the channels as it test against
> > > +		 * the cached value. Therefore, reinitialize the variable
> > > +		 * rzg2l_gpt->period_tick to 0.
> > > +		 */
> > > +		rzg2l_gpt->period_ticks[ch] =3D 0;
> > > +	}
> >=20
> > I think this is wrong. rzg2l_gpt_config() has:
> >=20
> >         if (rzg2l_gpt->channel_request_count[ch] > 1) {
> >                 if (period_ticks < rzg2l_gpt->period_ticks[ch])
> >                         return -EBUSY;
> >                 else
> >                         period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >         }
> >=20
> > So if both PWMs of channel `ch` are requested but disabled, rzg2l_gpt->=
period_ticks[ch] is 0 so you
> > assign
> >=20
> > 	period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >=20
> > . In that case however you don't want to change period_ticks, right?
>=20
>=20
> Yes, what about adding the check that won't allow to set 0 period in this=
 case.
>=20
> if ((rzg2l_gpt->channel_request_count[ch] > 1) && rzg2l_gpt->period_ticks=
[ch])

I think the easy to understand and obviously correct=E2=84=A2 check would b=
e:=20

	if (rzg2l_gpt->enabled[ch][othersubchannel]) {
		if (period_ticks < rzg2l_gpt->period_ticks[ch])
			return -EBUSY;
		else
			period_ticks =3D rzg2l_gpt->period_ticks[ch];
	}

(Instead of tracking enabled[ch][subchannel], reading the respective
register is another option.)

Best regards
Uwe

--re7q6mbmcl7zwywz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkc8hkACgkQj4D7WH0S
/k7fXgf+LEwsrkKbRYnwBuUiLwRaUgnYlj0xKjUU9BmjTjX4Y09x8fM2+Icu4kC5
KAX/hTgUU9Lbr0Jd4eYqCoxRBmbl8WI5ztlwAJ0iMQWMGDiUt5FK0KrLSr0QexcV
dtaa1fz5t1ky8kmwbIjsMIbaZohdeiwAPDjMOyI9l+LMSg2/RK35MBAlOP0Bzaha
aH/MGuf9aeFuS6do2ybgQwP5PpmzwVMcEu3JRdTvEYRYobwAudNcJ8Obh2rirk6K
xUD0Hfv6FSRZ7MMSvkac/30VHAO9vv+5OKHG9iuJK/NoKtUyUpvV5MMopuE96zu8
aEhUMffwly1M6bSR9vW/jlH7iw1pOQ==
=9bIy
-----END PGP SIGNATURE-----

--re7q6mbmcl7zwywz--

