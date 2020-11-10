Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6240B2AE0B3
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 21:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKJUdN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 15:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJUdM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 10 Nov 2020 15:33:12 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8452065E;
        Tue, 10 Nov 2020 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040391;
        bh=yJTYZmAXuxpcGEJyYxHhM5frnzHMmu2d66zn6Bja/hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0+9M3MIhvG1jKl+29RdqvQt51vR+oaGK/8GCDfVOFt7DeuVYh3d1crHlNZUC8WDds
         g9vkQkcCbbEoXNQpyaSLrzdPjoLqf+ydgGGXiFyaUf3ctGyVRw0DSvUJ1vfluiCeqN
         k/eioYuKDJ0bQsdAJATDhkiDO1uTXHoc1BDNDaN4=
Date:   Tue, 10 Nov 2020 20:32:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
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
Message-ID: <20201110203257.GC5957@sirena.org.uk>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20201110202945.GF2375022@ulmo>
X-Cookie: Disk crisis, please clean up!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2020 at 09:29:45PM +0100, Thierry Reding wrote:
> On Thu, Nov 05, 2020 at 02:44:08AM +0300, Dmitry Osipenko wrote:

> > +	/*
> > +	 * Voltage scaling is optional and trying to set voltage for a dummy
> > +	 * regulator will error out.
> > +	 */
> > +	if (!device_property_present(dc->dev, "core-supply"))
> > +		return;

> This is a potentially heavy operation, so I think we should avoid that
> here. How about you use devm_regulator_get_optional() in ->probe()? That
> returns -ENODEV if no regulator was specified, in which case you can set
> dc->core_reg = NULL and use that as the condition here.

Or enumerate the configurable voltages after getting the regulator and
handle that appropriately which would be more robust in case there's
missing or unusual constraints.

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+q+PkACgkQJNaLcl1U
h9Di3Af+KvYDy9j9hzr4giaqciyG6ZuO/j4tEwL8vjsyaMREZ12mZ3xOOgu04UTQ
KYUtOH+AIWAUWOBwJNWEgKiRd04eMyhD6IHeCT1lip3XWBxXOEr9/YGXba3fVI/J
vvHATycSemWFAYfZ1yjhz2fAxz4zxgwujwivC1/YKWjHZi8vFTy16R9yY5Eex5l/
eplxyfun7IvJxFiVf5XDK4K2lGmn783N6VYofq6lAUknQ+TxScbl9QNyKNihB7Ys
tOgGgxJpK6+xFKP8RWC34O3W++wjUL2sUZUhvVKP059roKdB0gej+D9DnV+RCYHf
AloxftWStaHBnOpYPmbGoUoaK8isGQ==
=oCrN
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
