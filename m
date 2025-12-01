Return-Path: <linux-pwm+bounces-7744-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5BC97CD2
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEDE34E1997
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CD30F944;
	Mon,  1 Dec 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc+YxzkS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E5246BC5;
	Mon,  1 Dec 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598538; cv=none; b=uaJM7ApnugNimZr/A55LA09xfVP94P7lAW7bk8JQgzA2yoXRFBFX06MOF0N16Kj9D1HK9veF8rUY1WiTqj558cyrzZQCWGCynMP+RwE6yRCtdIFAXr8lWOuvrvAYxYI+6//BfR1ifMMccrMeOXRgTZgeLwlhtrt0Z4soO5JFmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598538; c=relaxed/simple;
	bh=0QusJJfomKNOihe2z3HB4fHONQd+v4I5aXhw5Qbk+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi4/gajIvDvUukZrwjlxoADN3wCF9AhrpNeorb660QV1qthlcfFEg3RujjWvo4YvZao2aDDJu4Qz1ke+lriimBfrwXn79+D62JAp2IBEpAZZB3nMoZ2ZfxGQju6egOwv7FkiU5Rsws4MtMozaWM2CNXBxtL9p1eTW5c+9RKfXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc+YxzkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E7C4CEF1;
	Mon,  1 Dec 2025 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764598537;
	bh=0QusJJfomKNOihe2z3HB4fHONQd+v4I5aXhw5Qbk+N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc+YxzkSbC+YxLgIwByGCrcBPeTAG8IJ948dsZoLTRnIrQCE320IHw8U2yew/lk4s
	 +j9BSnNRfPsH65L22yI10ttzVc2nOaR9njiY3xV8rQjRqX7cfXi29nX4vtknoaK9GK
	 CudNzDKlYZ+6cI/rxNP0IWq90bAmyYgCqndMfPW1cKhdbqpI2cH9tBw+lwLdak0vtw
	 2mA89niTddwLtbdsHjfRqXHLH63NcE1U5sWNpu37p+8kDViAQ/iatFRC4q0PXW4tGA
	 QZ9UrcO88W738f1paul0c4r2cSs6ANERoOqIUbVjVW+2z8Nig3Za67WDQkWa4aEWUV
	 WsWSh9rLmSUHw==
Date: Mon, 1 Dec 2025 15:15:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Message-ID: <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvje3a3qxek72qep"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--kvje3a3qxek72qep
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
MIME-Version: 1.0

Hello Biju,

On Mon, Dec 01, 2025 at 11:09:50AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 30 November 2025 08:39
> > Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
> >=20
> > On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> > > +static int rzg2l_gpt_suspend(struct device *dev) {
> > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > +			continue;
> > > +
> > > +		rzg2l_gpt->hw_cache[i].gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GT=
PR(i));
> > > +		rzg2l_gpt->hw_cache[i].gtccr[0] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2=
L_GTCCR(i, 0));
> > > +		rzg2l_gpt->hw_cache[i].gtccr[1] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2=
L_GTCCR(i, 1));
> > > +		rzg2l_gpt->hw_cache[i].gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GT=
CR(i));
> > > +		rzg2l_gpt->hw_cache[i].gtior =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_G=
TIOR(i));
> > > +	}
> > > +
> > > +	clk_disable_unprepare(rzg2l_gpt->clk);
> > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > +	reset_control_assert(rzg2l_gpt->rst);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rzg2l_gpt_resume(struct device *dev) {
> > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst_s);
> > > +	if (ret)
> > > +		goto fail_reset;
> > > +
> > > +	ret =3D clk_prepare_enable(rzg2l_gpt->bus_clk);
> > > +	if (ret)
> > > +		goto fail_reset_all;
> > > +
> > > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > > +	if (ret)
> > > +		goto fail_bus_clk;
> > > +
> > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > +			continue;
> > > +
> > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i].g=
tpr);
> > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cache[=
i].gtccr[0]);
> > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cache[=
i].gtccr[1]);
> > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i].g=
tcr);
> > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i].=
gtior);
> > > +	}
> > > +
> > > +	return 0;
> > > +fail_bus_clk:
> > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > +fail_reset_all:
> > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > +fail_reset:
> > > +	reset_control_assert(rzg2l_gpt->rst);
> > > +	return ret;
> >=20
> > I wonder what happens if these calls in the error path fail. I think th=
e correct way would be to track
> > the actual state to handle the state on the next invokation for .resume=
() properly. But note that
> > suspend/resume is a somewhat blind spot for me, so I'm unsure here. (An=
d I'm aware that most resume
> > callbacks don't cope cleanly here.)
>=20
> In str case, there is no power on the system during suspend and exit is, =
SoC reset followed by
> restoring registers from DDR. So, it does not matter for the suspend path.
>=20
> In the resume case, If the calls to error path fail, then device won't wo=
rk.

I'm not sure you understand my concern. IFAIUI a device that fails to
resume stays suspended from the POV of the kernel. When in this state
the resume is tried again at a later point in time you get
inconsistencies if the first reset was already deasserted from the
previous resume run (because reset_control_assert() failed in the resume
callback's error path).

Best regards
Uwe

--kvje3a3qxek72qep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmktowQACgkQj4D7WH0S
/k40IAf/RoxYrccRGL0zB9nn9LJ/Hi+YjpJXuMkmUzRePDnfVa+bNxoI52qC2M2+
cdanc7aHyFV/xMQHV2DF+dXlwou3S4dn/2lMRDyPAqdgKdWGJFUmlCZaMzXwKWLa
cVKJu1O5uke9kfq7Ns2FkgcdJ6uewQwiyRvnQ/XbhH7NB3YkejH3nOwoA1KMc5o8
bNlowrVAPAPoMDuL8ZdS827mkoNzM8T9BC1sAAGW5D+MnI5pS1Ql5N8G2WKXB7sh
DOnH2n279SwCL41M1LK7WihhicpduK3K2yFBknoUkgMwi1kp5nDQAB54ysfi2bFS
inxU4+ptY0TtQsUq669REsr6/akWRw==
=kpqX
-----END PGP SIGNATURE-----

--kvje3a3qxek72qep--

