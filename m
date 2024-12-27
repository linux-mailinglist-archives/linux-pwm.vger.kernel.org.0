Return-Path: <linux-pwm+bounces-4525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDC99FD20E
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 09:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AE17A1626
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B0153808;
	Fri, 27 Dec 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDio4RKo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6214B06E;
	Fri, 27 Dec 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288689; cv=none; b=AUYHztXK/e2xZM0P6CZfYy68IG6gSnX3wfbuwUb2OGiiZG92jJXjGWMfoYVKtmmDFm/6/uaf6wSjoioWezlB1Neg61WPmkR/pGWZyYU9+H2lCbwUj2AHP6EPmmQ/ljAX/9Sp9qShlhzUsXCHLpB0284A5Uu1JBbVHtwl0GdeI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288689; c=relaxed/simple;
	bh=v2L45xbl1l0HwaVItltX7rxIVJAxBVcQWLkKwvGdk70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epc0g4CiX79SUkp1bV23d5n9FkcuLgiXhdZvICWjjcBjlOZTAvrrGeSsNRYAGIjAZZeiXPjzDRLboYc3/KIJXz7FESUqVWiE6ZZ9kePN9ybC8RQaJGUO6rDVouR0RArLd27s5RGmSrsc/+WN1NCVy5NZ+WOPYheZ3qgw7iTCPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDio4RKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FB9C4CED0;
	Fri, 27 Dec 2024 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735288688;
	bh=v2L45xbl1l0HwaVItltX7rxIVJAxBVcQWLkKwvGdk70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDio4RKopOoTyp1inOvH/bUk3BZ92I/u6R93123otWK8MmOmIwv2hyTRRgKoDE+j4
	 RIZ7pvbZlMWWL+b19ZRgQqNFV8TtVNhGDer4pKATZAUAKVspdCImiX8IjjrmhwyzRY
	 ujk3+pXW/1R0t5Vggu94K10LigpnUGbW0DNPw8gBNVga02fst6M4l8+aS9+YqKt6Uh
	 y+nOehtB3xifDNjqm7XMdSuZ+o3MT1/EvBXrcTiuAudYSxH/nyGK54wv1XARmb85fL
	 TY8pbDV+zWExJKpuXZW7Aqgf7zyEDCApazkxewRlHsAePq00EQoNHGfAIYpYrYPv6Q
	 e8VmnLrrnbc8g==
Date: Fri, 27 Dec 2024 09:38:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
Message-ID: <qz2i2xxjwvsxhsdnlsvkj4mjylgzfnhnums4miu6d3t2lu3ff3@msfcx55gialu>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
 <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <52j6gtyzf4uwfkxxlfschygnvuwl2l4iaf7mzbi2nbzxtmlemf@dktywu73nldg>
 <ZQ0PR01MB12530DDB9AF830296773C7AF9F03A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xwxg4a22p53xxjru"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB12530DDB9AF830296773C7AF9F03A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>


--xwxg4a22p53xxjru
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

On Tue, Dec 24, 2024 at 01:53:03AM +0000, William Qiu wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> > Sent: 2024=E5=B9=B412=E6=9C=8824=E6=97=A5 1:12
> > To: William Qiu <william.qiu@starfivetech.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pwm@vger.kernel.org; Hal Feng
> > <hal.feng@starfivetech.com>; Philipp Zabel <p.zabel@pengutronix.de>
> > Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
> >=20
> > Hello William,
> >=20
> > On Mon, Dec 23, 2024 at 02:47:59AM +0000, William Qiu wrote:
> > > > > +	duty_data =3D mul_u64_u32_div(state->duty_cycle, ddata->clk_rat=
e,
> > > > NSEC_PER_SEC);
> > > > > +	if (!duty_data)
> > > > > +		return -EINVAL;
> > > >
> > > > I can understand that period_data =3D=3D 0 is an error, but duty_da=
ta =3D=3D
> > > > 0 could/should just work?!
> > >
> > > It means no need to check whether the duty is valid?
> >=20
> > No, it means that I expect that duty_data =3D=3D 0 is a valid setting a=
nd most
> > controllers support it.
> >=20
> > Best regards
> > Uwe
>=20
> So we just need to check duty < 0?

I'm not sure I understand this question. You can assume that
state->duty_cycle is >=3D 0 in the driver callback.

If the hardware doesn't support duty_cycle =3D=3D 0, add a comment and
proper error handling. (i.e. return with -EINVAL if the requested
duty_cycle is too low to be implemented.)

Best regards
Uwe

--xwxg4a22p53xxjru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduZ2sACgkQj4D7WH0S
/k4j8Af9FkajDG7FXKbJBMx+E4Sx2h+fXp25jQzd5Y4nx/MWXbqyoq11yrXb6mBA
xVsl+62jduKUBJLO0iOprfe5AzDL+eeFnAlJI3LdyN5dQOT89WLP/odVzaM9SAcn
0WLcI2ciC4qb/9lG2keiI3dxrrTWJBkYAJOZ8t1Nbs4Wp0n7TdCEVMXWI5fLl0dd
qM4FS+86+xALhSJ+iy8bDYRAy7aN/nUoOw26uBPp4MR8hIJSbLfG5UKbsfklo4nO
unPADzI+M77AZWt8u0b1+eKHDtIrlqsaxyvHm9sSx0L71w3V9f3ScSPrBDVUJCjw
rGzg9o01oYPVK5odBg0TwfikVw8PQg==
=Ko9X
-----END PGP SIGNATURE-----

--xwxg4a22p53xxjru--

