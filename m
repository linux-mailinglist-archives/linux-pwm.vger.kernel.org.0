Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C725C2CA5C6
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgLAOfb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 09:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLAOfa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Dec 2020 09:35:30 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDAA20757;
        Tue,  1 Dec 2020 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833289;
        bh=MyXMx5yXcwhyHoSDPi4JqwtH6IbreqZ2dffpm2rMrnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dk2mKbi0tMydQDEKwILrugaQ4+lDOei99EiGyEzw8miGGC/enajtGKrNxNAgOh19d
         bUolBQkpIVH3Hui3nBJELnqmmCNUkGvsVFhpqQ5K0vNjOLXzgTLtjz0BPDjBiyCFTO
         H6YlxqFYzbMW5dFfkwv/1U0YroBSdxaecQ6rhs4U=
Date:   Tue, 1 Dec 2020 14:34:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201201143420.GD5239@sirena.org.uk>
References: <20201104234427.26477-1-digetx@gmail.com>
 <160683107675.35139.13466076210885462180.b4-ty@kernel.org>
 <858e4183-5064-084f-9b80-870e118c3edc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <858e4183-5064-084f-9b80-870e118c3edc@gmail.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2020 at 05:17:20PM +0300, Dmitry Osipenko wrote:
> 01.12.2020 16:57, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > [1/1] regulator: Allow skipping disabled regulators in regulator_check_=
consumers()
> >       (no commit info)

> Could you please hold on this patch? It won't be needed in a v2, which
> will use power domains.

> Also, I'm not sure whether the "sound" tree is suitable for any of the
> patches in this series.

It didn't actually get applied (note the "no commit info") - it looks
like b4's matching code got confused and decided to generate mails for
anything that I've ever downloaded and not posted.

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GVGsACgkQJNaLcl1U
h9BikAf/buTRpKtsLDzFSoQBjj73gw+9m/quyO+03JWRrvv3U6Me8tZmCZHGcAhJ
5+PFS79ESOLZrypMM4IE6HEK1cq0AFNjUDMqVKtWFP4GgZ8LBjcLvSF8OYkdHwo7
TiUsxAOnhequj3OhP46T/AuusHAX53D4Fg4rLsJMCrJygo0e6kAaOB7F9ZlJqNQt
A3pk4g+mC153uBGhCsZRWQmj93R9SxH6vUd3g6ePE0jIZAqa3LSJHdYX3xRSfQWd
Iojrsh3QYMFNdrajfbhAcn9hyXU1O2Zy0NadudYbqOIYWBQ5TEbW8z55BJLr1a2O
09Ob2CqfLC5c6oPrJJtjRMGm4w8iaw==
=1gdB
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
