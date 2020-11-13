Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05A2B1FE7
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKMQQI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 11:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMQQH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Nov 2020 11:16:07 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630DC2076E;
        Fri, 13 Nov 2020 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605284166;
        bh=A78YcjU5wXa8tlzrOpaXDNnSzLAvardtp8E9bjbkobU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMzBr7E+FDS6ZgWNYaYY3g8HwzJPjCCycp7a2gmh7cOvce7d+siQhoXfXognj2qzp
         pOGN3bp7VECK6K7YnDSdbMnw2aziHM6PtIwEwXTG+V8K8/U6wr3sW76YvNpadEF11r
         zy7FZ9Dl6HkgEn015hlL9KrIauCdzqRkLRZJSiqA=
Date:   Fri, 13 Nov 2020 16:15:50 +0000
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
Message-ID: <20201113161550.GC4828@sirena.org.uk>
References: <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
X-Cookie: No solicitors.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 06:55:27PM +0300, Dmitry Osipenko wrote:
> 13.11.2020 17:29, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > It's not clear if it matters - it's more a policy decision on the part
> > of the driver about what it thinks safe error handling is.  If it's not

> If regulator_get() returns a dummy regulator, then this means that
> regulator isn't specified in a device-tree. But then the only way for a
> consumer driver to check whether regulator is dummy, is to check
> presence of the supply property in a device-tree.

My point here is that the driver shouldn't be checking for a dummy
regulator, the driver should be checking the features that are provided
to it by the regulator and handling those.  It doesn't matter if this is
a dummy regulator or an actual regulator with limited features, the
effect is the same and the handling should be the same.  If the driver
is doing anything to handle dummy regulators explicitly as dummy
regulators it is doing it wrong.

> We want to emit error messages when something goes wrong, for example
> when regulator voltage fails to change. It's fine that voltage changes
> are failing for a dummy regulator, but then consumer driver shouldn't
> recognize it as a error condition.

If you're fine with that you should also be fine with any other
regulator for which you failed to enumerate any voltages which you can
set.

> The regulator_get_optional() provides a more consistent and
> straightforward way for consumer drivers to check presence of a physical
> voltage regulator in comparison to dealing with a regulator_get(). The
> dummy regulator is nice to use when there is no need to change
> regulator's voltage, which doesn't work for a dummy regulator.

To repeat you should *only* be using regulator_get_optional() in the
case where the supply may be physically absent which is not the case
here.

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+usTYACgkQJNaLcl1U
h9Cdtgf+KPTFZMOoWB6AmVx7uO9sDi9hMEVVCzp/m6ePr9MDeju+i5ix2FQINkxE
D3+IHQpy5uNaihmetU14FQqj46ci6B9LfYY2bJ83O4DQbLGFBp4IjfGHUZHSrG/H
uOlmTAln3D7hJvmlexfC3pr/DaCmS29p9Zr9/jI7m96gq+QpksXL8vK347+CUcZi
HB5BciEamTey+AESLGu13X9rEPhkyLuNpU3N53bp6rg+jZqEqXJz8NCfQ0DeGbRU
ssePVo1EThW95vi1G7cQCi9XO+MaNQFp7YRQ91nQMfeY6UMgF6TCUvBB31A9U0BF
N1T5iPikwB5hLC/LTyappOFpxG0AMw==
=4ogU
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
