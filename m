Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF32B2265
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKMR3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 12:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKMR3R (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Nov 2020 12:29:17 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64CCC20A8B;
        Fri, 13 Nov 2020 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605288556;
        bh=v5CL9YF1QV2cVcfw5u5P+pUPiw3XLtfqrtP/g2fHPl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhAUCXa/XnhvWywTPu2JTwCXoBO0dT/lVWv0zWjipiIOHQcy2VP5spT5avs4Y+NYV
         VJdoF6E6PfVrW6o6/GCZ4GmuP6mF9FPqN38c7ujHTkwIuhOjXQvB7TkHgQMeoyZp3/
         /Ze4AR8M0fn2NV8jIB4clGQ4/dJ+Tm6qd7HN5Uw8=
Date:   Fri, 13 Nov 2020 17:28:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
Message-ID: <20201113172859.GF4828@sirena.org.uk>
References: <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
 <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
X-Cookie: No solicitors.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 08:13:49PM +0300, Dmitry Osipenko wrote:
> 13.11.2020 19:15, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > My point here is that the driver shouldn't be checking for a dummy
> > regulator, the driver should be checking the features that are provided
> > to it by the regulator and handling those.

> I understand yours point, but then we need dummy regulator to provide
> all the features, and currently it does the opposite.

As could any other regulator?

> > It doesn't matter if this is
> > a dummy regulator or an actual regulator with limited features, the
> > effect is the same and the handling should be the same.  If the driver
> > is doing anything to handle dummy regulators explicitly as dummy
> > regulators it is doing it wrong.

> It matters because dummy regulator errors out all checks and changes
> other than enable/disable, instead of accepting them. If we could add an
> option for dummy regulator to succeed all the checks and accept all the
> values, then it could become more usable.

I'm a bit confused here TBH - I'm not sure I see a substantial
difference between a consumer detecting that it can't set any voltages
at all and the handling for an optional regulator.  Either way if it's
going to carry on and assume that whatever voltage is there works for
everything it boils down to setting a flag saying to skip the set
voltage operation.  I think you are too focused on the specific
implementation you currently have here.

We obviously can't just accept voltage change operations when we've no
idea what the current voltage of the device is.

> > To repeat you should *only* be using regulator_get_optional() in the
> > case where the supply may be physically absent which is not the case
> > here.
>=20
> Alright, but then we either need to improve regulator core to make dummy
> regulator a bit more usable, or continue to work around it in drivers.
> What should we do?

As I keep saying the consumer driver should be enumerating the voltages
it can set, if it can't find any and wants to continue then it can just
skip setting voltages later on.  If only some are unavailable then it
probably wants to eliminate those specific OPPs instead.

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+uwlsACgkQJNaLcl1U
h9Byiwf8CBtP3NTEOCqhZz8SWiavS7x+8tT0LvX/L+qxquuOx5+DYmIK+LSJdejs
90EZt2CNSVAVSQ3nx6Mrs1CgvSd3ESm2sY3sIvPC/kdcs5UqphWfBQgG1f5ZeCPP
Ige8kX/gTdu91RadoCes4P1JtYVHnJ0GDCGPAKbpZNzYoS7QCgt4+HeMpN4MoTzG
HQUlRfTEYQjTTo3RH+7xw/prN1/wdLBaUc+Q63gwkGP5mWP1biAErIqUqh3Q8g4L
LoQcC4obIRGGk0bMmOnQVLeHLzxs7/EMYk5Yh+WGj1/CZNRF0X+AmuQueU1bKs5K
vavSKvCn1GhEVqCnZipJB33Ys/ys/w==
=Ytdz
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
