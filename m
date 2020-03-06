Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227AB17BCD5
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFMfd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 07:35:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgCFMfd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 07:35:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9F931B;
        Fri,  6 Mar 2020 04:35:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D413F6C4;
        Fri,  6 Mar 2020 04:35:32 -0800 (PST)
Date:   Fri, 6 Mar 2020 12:35:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200306123530.GA4114@sirena.org.uk>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
 <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
 <20200226163905.GH4136@sirena.org.uk>
 <20200306075129.mzs22yjitkmgrthh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200306075129.mzs22yjitkmgrthh@pengutronix.de>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 08:51:29AM +0100, Uwe Kleine-K=F6nig wrote:

> I wonder if we should do something like:

> 	ret =3D some_call(some, args);
> 	if (ret) {
> 		if (emit_errmsg_for_err(ret))
> 			dev_err(dev, "some_call failed: %pE\n", ERR_PTR(ret));
> 		return ret;
> 	}

> and have emit_errmsg_for_err return true if ret !=3D -EPROBE_DEFER or some
> kernel parameter is given.

There was some effort in the past to have a dev_probe_err() or something
which could have a similar implementation but that didn't end up going
anywhere I think.  I do prefer the debug level log since it's much
easier to have the information there without having to ask for it, that
design would've supported that.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5iQ5IACgkQJNaLcl1U
h9BuHwf+PVNL4Sk9lvVXj3uZGPvOjvQ5AISnSi54O7gsRBhc+yGdANxc1ZpuIcxc
URs2Khp5haI6dPXVVexp1Y0l/fHAi2k93GMep+8uQhosrQUZ7q08qdzrN54g1THK
Y19+hSRF3KmBdoZPk3oqsTmX2j5Uq+Z6QU/U5WCO/j64WJJcAiR7zu35qEF7dDe2
0SDzkQUvzz/EOqcPdt460hMXXhVrcKT/iqDD09cJXUjdWteEGbJfHFt845qPbR6o
LEwoCZInR3P3q8bN2nwtkQa7BQESTjh4s/vNIq4QDYfbzdJ05WAqGZsETzb8/Vwr
bYfbQDO11C3REAo8rUIj+i5yXdl9bQ==
=uQ0f
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
