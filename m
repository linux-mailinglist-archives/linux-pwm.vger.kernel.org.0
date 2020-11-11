Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0972AF020
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 12:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKKLzv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 06:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKKLzu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 11 Nov 2020 06:55:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5A32075A;
        Wed, 11 Nov 2020 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605095749;
        bh=E+ly9ONWTiIZggNniJcApnyy3E6yqB0BJhEeVuwf6a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNDu7zw94N4bZLodrCeHyIJ7vJNyhJ86AqVVUXxbfWXwe3kmN8aHYbMyE79lDIAVJ
         U//1q2PZZNQKS7NWkJLc5cU3FdavNRU69OF11MYqFfm6gLE6mUcQFHwIDVTaIZQG1g
         rB6oruPIYVSGgedkrijP4GnWAAoahL9Jn5/5VUw8=
Date:   Wed, 11 Nov 2020 11:55:34 +0000
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
Message-ID: <20201111115534.GA4847@sirena.org.uk>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
 <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
X-Cookie: I'm not available for comment..
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 12:23:41AM +0300, Dmitry Osipenko wrote:
> 10.11.2020 23:32, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> >>> +	if (!device_property_present(dc->dev, "core-supply"))
> >>> +		return;

> >> This is a potentially heavy operation, so I think we should avoid that
> >> here. How about you use devm_regulator_get_optional() in ->probe()? Th=
at
> >> returns -ENODEV if no regulator was specified, in which case you can s=
et
> >> dc->core_reg =3D NULL and use that as the condition here.

> > Or enumerate the configurable voltages after getting the regulator and
> > handle that appropriately which would be more robust in case there's
> > missing or unusual constraints.

> I already changed that code to use regulator_get_optional() for v2.

That doesn't look entirely appropriate given that the core does most
likely require some kind of power to operate.

> Regarding the enumerating supported voltage.. I think this should be
> done by the OPP core, but regulator core doesn't work well if
> regulator_get() is invoked more than one time for the same device, at
> least there is a loud debugfs warning about an already existing

I don't understand why this would be an issue - if nothing else the core
could just offer an interface to trigger the check.

> directory for a regulator. It's easy to check whether the debug
> directory exists before creating it, like thermal framework does it for
> example, but then there were some other more difficult issues.. I don't
> recall what they were right now. Perhaps will be easier to simply get a
> error from regulator_set_voltage() for now because it shouldn't ever
> happen in practice, unless device-tree has wrong constraints.

The constraints might not be wrong, there might be some board which has
a constraint somewhere for=20

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+r0TUACgkQJNaLcl1U
h9DWcQf+JKUKAAmCRoCIJy9RMbwbcNzS1ehBtOpcozk+MMyJ3P+dgcBahHKBBMnb
2YhGKsKdqzaBELqpXe/hFWKxA6hYHTpyIwMRTywEojcGmDs9uiuCKocCerJTuVTF
c7JBE5R3F/wViCJVqkKUG3nJ+lD6uzzbhw7EcuFL6JVLHZOkHoaRaETw80+7VEIq
7vhNoSmt6p8IBr/zqV8bM+x5x0dsI4IArhh1ATC/NHeoZ4SHMbpLFYN5nGbiJwGA
sHHjt0L1+msYcrgr36dQPACoykphP2BAa+7Yp09e8YGXThSsIhDCBQi5ouFpQa4k
3/iI/vaOSikf2BEi1DqjIHKngrsjBQ==
=Ohk2
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
