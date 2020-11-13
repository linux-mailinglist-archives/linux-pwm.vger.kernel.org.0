Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9437A2B1D7B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgKMO3y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 09:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMO3y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Nov 2020 09:29:54 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EB220715;
        Fri, 13 Nov 2020 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605277793;
        bh=e3QjDJePQNmrQAx9u96nNaIxxOGo5XiKT36hOiGvu+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdIPXjqeu0rWfbDhg94jLjPcBpmjZIBwHLLPLWv8P6x9WxP7WDJlLcmQsmpV8vRGt
         OMAvIEyxcmZ1NB/z1oI3hSi74zITJffw9hIAMOQqum4nnm6Zfcb2rB+ZZN/WE/Zl+v
         9Wu52UzARkZm/5A7M04ywnI3+F30eZJLDlreIMsY=
Date:   Fri, 13 Nov 2020 14:29:37 +0000
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
Message-ID: <20201113142937.GB4828@sirena.org.uk>
References: <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
 <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
X-Cookie: No solicitors.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 01:37:01AM +0300, Dmitry Osipenko wrote:
> 12.11.2020 23:01, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> But it's not allowed to change voltage of a dummy regulator, is it
> >> intentional?

> > Of course not, we can't know if the requested new voltage is valid - the
> > driver would have to have explict support for handling situations where
> > it's not possible to change the voltage (which it can detect through
> > enumerating the values it wants to set at startup).

> > [Requesting the same supply multiple times]

> But how driver is supposed to recognize that it's a dummy or buggy
> regulator if it rejects all voltages?

It's not clear if it matters - it's more a policy decision on the part
of the driver about what it thinks safe error handling is.  If it's not
possible to read voltages from the regulator the consumer driver has to
decide what it thinks it's safe for it to do, either way it has no idea
what the actual current voltage is.  It could assume that it's something
that supports all the use cases it wants to use and just carry on with
no configuration of voltages, it could decide that it might not support
everything and not make any changes to be safe, or do something like
try to figure out that if we're currently at a given OPP that's the top
OPP possible.  Historically when we've not had regulator control in
these drivers so they have effectively gone with the first option of
just assuming it's a generally safe value, this often aligns with what
the power on requirements for SoCs are so it's not unreasonable.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+umFAACgkQJNaLcl1U
h9DRnAf/TT8I9XDaCoZsP58r0YQKOYiW9tWOMx5iUwJFikxSUl6upudJ8HrbvhS/
O1evWVxr6jTg2q8A2Rq24+SXSF7KEAINXdggEQ+N4q8l5CzBXLA84C+z5IRIb6lL
dgWqTg93CtK+XCEAKGWhAXn/nNFv8p9nol6fYYw6k8h00DJ+v04vDE/U+oofX1nn
bOkrueTE3zsDh0U6tHC2dXK7hZX5s8j+g5aN4C5B27Xip+nGg6iiGHUQmsNP33Vc
SLN6fJ7s1iNF+YNZBQLPWAeVTz44INs/8yIA6KTemFKz2lNUCozTaACHiLZTlyM2
/pcp+qCaLayuAuXMCA2bNUT5gef9cg==
=G9Fp
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
