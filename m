Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49623396D0
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhCLSne (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 13:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233832AbhCLSnc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Mar 2021 13:43:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E3C164DEF;
        Fri, 12 Mar 2021 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615574611;
        bh=sKX2rrb6XkiYk5GQI8k4S0Xcn1WhEhpPzkJYF4w5HQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGa+OIImtBLT6B9fBhRu9whkob+oyS22VSvs/u9Hl+jTC06bBuhomU1HA92pU+7qP
         V44Py2/oLpwuvLVslyFSAmiQpPhUViqyPypv1+1luj2tmFp6mHHF1+LdrbbkgtX6MC
         A0Hkek/kJvJHWBF5rOosCmIDbpmLNmz+w078KgNWiZiDkTObqd+IneILAMFj5sg87o
         I+ynB0YhhFoPyTzO/naeUawbmx7KINbkX+4LnCvkg6dhZg6EwoQzzqFPGFwb0e4siB
         UK9w9UmnnxtwxGMPlC1fQhr478bXztBwBXb4VC+dO95r2mbwgU2zZge2x3LnKMak5n
         GcJTCFp0+Lwcg==
Date:   Fri, 12 Mar 2021 18:42:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [GIT PULL] Immutable branch between MFD, PWM and RTC due for the
 v5.13 merge window
Message-ID: <20210312184218.GL5348@sirena.org.uk>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210301102826.GK641347@dell>
 <20210309200520.GA4931@dell>
 <20210310113959.dnokjrt7dos43fx6@pengutronix.de>
 <YEizYHPnzyLad6Yi@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Content-Disposition: inline
In-Reply-To: <YEizYHPnzyLad6Yi@piout.net>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2021 at 12:54:08PM +0100, Alexandre Belloni wrote:
> On 10/03/2021 12:39:59+0100, Uwe Kleine-K=F6nig wrote:

> > IMHO there are two ways forward: Either someone (Lee again?) creates a
> > new pull request for this series rebased on -rc2; or we accept that
> > these few patches are based on -rc1. For the latter it would be
> > beneficial to merge the tag into a tree that is already based on -rc2.

> The solution is simply for the maintainers merging the immutable branch
> to do that in a branch based on -rc2. Eg. I've rebased rtc-next on -rc2
> (fast forward, I didn't have any patch). I can now merge this branch if
> necessary, problem solved. If you can't rebased, nothing prevents you
> from merging -rc2 in any branch.

That doesn't exactly address the issue - the goal was to reduce the
number of commits that a bisect could hit which have the swapfile bug
but lack the fix.  How serious a few extra commits on a shared branch
really are is of course an open question though.

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLtgkACgkQJNaLcl1U
h9CB+wf/ZO7mIUoi7YJ5RncEf1EitAjvU8hcKZiAZOlXiI1OS8PQOpWUQ5K+RbDD
NJIy7txxdvWxHDxl1pG7f/3iZ0j1S/3VWPDj8U6L04HcMCivzVFsfGME8coY6V8P
GnJDXv/7OCbnDvmUz8TYpcKRI+OSbOVadnQH2eUoGz1BZ9AAyJ1LL1qHKx7vOp2Z
rwoSkqkJwBVyuR+bjHFR4vHeBLfcxyBJ0DJG0Cb7INwK1D6t1qbnk90+mSFx3myS
3ji8G1NRtqfZH5cG76rCoWnXiaDRCPhnanQeI3p3qCEF5PDJQG7ODmWY95HJyZJh
RNgn4Del1wOcCkNVuV+u5M9+dLu73g==
=ckES
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--
