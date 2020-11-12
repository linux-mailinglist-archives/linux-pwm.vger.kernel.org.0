Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7CC2B0B1E
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgKLRQS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 12:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgKLRQS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 12:16:18 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 666A9216FD;
        Thu, 12 Nov 2020 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605201377;
        bh=lxI2SWRNu/vNMf3oMbzXFnq0SSD1w9QmvZ1Ujav1o8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xe2x5M1t18yJCKwVuL2NfQxj5Wr2gJMA2Gdc1O2AMfcZWsfxd8by8nRE2Mgl14ITQ
         YMJY1x709L8eGOFJ9b4e5+b+CEIDYbpiAtu37j1IxdZcUfsYJ+JNEDrtHsgeAnKobT
         hNNMtYZLOBGU52c9s3omM5ptGSNIrsuMJAWqI3q4=
Date:   Thu, 12 Nov 2020 17:16:00 +0000
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
Message-ID: <20201112171600.GD4742@sirena.org.uk>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
 <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
X-Cookie: Danger: do not shake.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 07:59:36PM +0300, Dmitry Osipenko wrote:
> 11.11.2020 14:55, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Nov 11, 2020 at 12:23:41AM +0300, Dmitry Osipenko wrote:

> >> I already changed that code to use regulator_get_optional() for v2.

> > That doesn't look entirely appropriate given that the core does most
> > likely require some kind of power to operate.

> We will need to do this because older DTBs won't have that regulator and
> we want to keep them working.

> Also, some device-trees won't have that regulator anyways because board
> schematics isn't available, and thus, we can't fix them.

This is what dummy supplies are for?

> >> Regarding the enumerating supported voltage.. I think this should be
> >> done by the OPP core, but regulator core doesn't work well if
> >> regulator_get() is invoked more than one time for the same device, at
> >> least there is a loud debugfs warning about an already existing

> > I don't understand why this would be an issue - if nothing else the core
> > could just offer an interface to trigger the check.

> It's not an issue, I just described what happens when device driver
> tries to get a regulator twice.

> There was an issue once that check is added to the regulator core code.
> But perhaps not worth to discuss it for now because I don't remember
> details.

So there's no known obstacle to putting enumeration of supported
voltages into the OPP core then?  I'm a bit confused here.

> >> directory for a regulator. It's easy to check whether the debug
> >> directory exists before creating it, like thermal framework does it for
> >> example, but then there were some other more difficult issues.. I don't
> >> recall what they were right now. Perhaps will be easier to simply get a
> >> error from regulator_set_voltage() for now because it shouldn't ever
> >> happen in practice, unless device-tree has wrong constraints.

> > The constraints might not be wrong, there might be some board which has
> > a constraint somewhere for=20

> In this case board's DT shouldn't specify unsupportable OPPs.

Ah, so each board duplicates the OPP tables then, or there's an
expectation that if there's some limit then they'll copy and modify the
table?  If that's the case then it's a bit redundant to do filtering
indeed.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tbc8ACgkQJNaLcl1U
h9DMCwgAg/TVHTXmevYwD5s1Ajz8QKM96GSjHTvRKagWLF+y+O7/6SvbHmWmiMqD
72lNxOyhMyrHsB/r2SJfYiZnTaxPvDwxTdU9CzTHTAPUdapJ6qyV0iuMkQHGTGKN
SYqZvJhMfwBpvhvMDaUiOMYQ9uTqipBCfhqgXNhQaGfnIco6awkwlY3AKGp+50pg
XKM7DBdL0naY0/Mog4jbOjAo3Np4dTsY/CPaIh/QPQe4p2lHaBmWLjobDZOlzEXI
kZlYkHPdsANUEzVh7uuTgqYPs+WfxLW89lNjqL2/if0+KF5dNmcHORIOsJ5GQlQb
J3JAZ0VQrlO7gydHgdEneannVwSdIg==
=CmJu
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
