Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407192B0EAF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 21:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKLUBl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 15:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgKLUBl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 15:01:41 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47BA206C0;
        Thu, 12 Nov 2020 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605211299;
        bh=MKJDXGpNlGKLCI9dNv7dDPKVeEJe0VJ/HK7E+grpTDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/ksYSCI1J9IPc6Tjsze3uiUdqAwqqI6fTydzuEQ/zllsZIZX9gf+6kkRQEr4VR1N
         sI/Sfb9exPJr5bz8iuS/yvboFP25H3+cmbL1VIsZcCdrlFbr/qs71AIKKx4mBv5LYo
         0Ok1y77dTkY2b68mM3G/uNiu47PwTZ0ITkWabBQM=
Date:   Thu, 12 Nov 2020 20:01:23 +0000
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
Message-ID: <20201112200123.GF4742@sirena.org.uk>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
 <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
X-Cookie: Danger: do not shake.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 10:16:14PM +0300, Dmitry Osipenko wrote:
> 12.11.2020 20:16, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Nov 12, 2020 at 07:59:36PM +0300, Dmitry Osipenko wrote:

> >> Also, some device-trees won't have that regulator anyways because board
> >> schematics isn't available, and thus, we can't fix them.

> > This is what dummy supplies are for?

> But it's not allowed to change voltage of a dummy regulator, is it
> intentional?

Of course not, we can't know if the requested new voltage is valid - the
driver would have to have explict support for handling situations where
it's not possible to change the voltage (which it can detect through
enumerating the values it wants to set at startup).

[Requesting the same supply multiple times]
> > So there's no known obstacle to putting enumeration of supported
> > voltages into the OPP core then?  I'm a bit confused here.

> It's an obstacle if both OPP and device driver need to get the same
> regulator. Like in the case of this DRM driver, which need to control
> the voltage instead of allowing OPP core to do it.

It wasn't entirely deliberate but the warnings have proven useful in
catching bugs (eg, leaked regulator requests).  The general thought is
that if two things both claim to control the same supply on a consumer
then they really ought to be coordinating with each other.

> Please notice that devm_tegra_dc_opp_table_init() of this patch doesn't
> use dev_pm_opp_set_regulators(), which would allow OPP core to filter
> out unsupported OPPs. But then OPP core will need need to get an already
> requested regulator and this doesn't work well.

There is nothing stopping us adding a variant of that call which passes
in the regulators that were acquired by the caller rather than having
the OPP core do the requesting, or equally the OPP core could provide a
mechanism for the caller to get the regulators that were requested.

> > Ah, so each board duplicates the OPP tables then, or there's an
> > expectation that if there's some limit then they'll copy and modify the
> > table?  If that's the case then it's a bit redundant to do filtering
> > indeed.

> I think this is not strictly defined. Either way will work, although
> perhaps it should be more preferred that unsupported OPPs aren't present
> in a device-tree.

OTOH that does mean that if there's an updated information on OPPs (new
ones added, old ones determined to be unstable) then you can't just
update a central place.  It depends if the OPPs are thought of as
describing the SoC or the system as a whole I guess.

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tlJMACgkQJNaLcl1U
h9COcgf9EH4d/GUFioibikErfQGZW508vh8gf7BzEhMbZ1U44T4UeBcZN5+Sxfi9
Y9qKnb/EnnOFXZXcSjcQUtGaS5eEjFxd+bak7yLpfFNKYEsMKnEOdVDtbxB5NQ1W
FJiZYR2ccixR9FdgWI9DsNRxScr3EnqfV+IvHV33Agn/Kyq2KkA7Q8Qu5SupHm5O
XJ3/b2MSiW1P1rpQzA+yp+qUWdm4HCqpf+fL6eGqdDY+WG5QDHAjBubPN4ReUNIe
Abev8erADzNJMrfGC86F0yJmPA/BwOIBqFSJHOKE4FIaxASi0ZDQAy+akWh4rbB4
kLMQ2gKElTmSDF8Gx2rTqPmKzhtW9w==
=Dp9/
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
