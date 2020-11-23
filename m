Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0582C17BF
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 22:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgKWVew (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Nov 2020 16:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgKWVew (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Nov 2020 16:34:52 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169B8205F4;
        Mon, 23 Nov 2020 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606167291;
        bh=/r6Im3AOWb8lBQqG8Qe/vtDQC8Fs4J/lQXe8TEgMay0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aoGgBTSlPcBxyPxCXPgqnG0O/SVtYahkOTcqC2PWKQl1OYe4pu0q4zaq0s13YoAp
         UELKsnaKji/y+J7isp6kZmIFx/qLfW5qRiobHbtwcq9ICiQ0JOHh0/xnkwFEFVxunC
         a94y8T53SlvTt6ngkFvagcO/Hf1HjQPfNGTG6NhA=
Date:   Mon, 23 Nov 2020 21:34:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201123213427.GS6322@sirena.org.uk>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-6-j.neuschaefer@gmx.net>
 <20201122231054.GH348979@piout.net>
 <20201123213105.GC456020@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aJ74fq0Y6SrIeKCM"
Content-Disposition: inline
In-Reply-To: <20201123213105.GC456020@latitude>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aJ74fq0Y6SrIeKCM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 10:31:05PM +0100, Jonathan Neusch=E4fer wrote:
> On Mon, Nov 23, 2020 at 12:10:54AM +0100, Alexandre Belloni wrote:

> > Couldn't you do a regmap_block_write or a regmap_multi_reg_write which
> > would be more efficient as they would be locking the regmap only once.

> I can't find regmap_block_write anywhere, but regmap_multi_reg_write
> looks like a good approach to simplify the code here.

I suspect he's thinking of bulk rather than block there.

--aJ74fq0Y6SrIeKCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+8KuMACgkQJNaLcl1U
h9BoEQf/T9GCOGidKSkBAAwBmsKd09TfN0KhVHaDCtd8V2sMVb305rdFl6/1M2on
OlhUqiqdUlml9/DNxTuSQJbdjDVE/4m8HUduent6ArvV59AnX03FnQYnMYG5azLy
ve5SWBWlzm9vbKsfNJKHvGV4lz6ENn/868v7L9eZa+uNhwfMe4WEcVFqhmbUAIkY
rKmbapIrsYSLJ6COtX7KtyRwpVKxkdwLFrOkNcWbK4hE9DK3A+Rw4sLrHLGNVbA4
Kg9kR4WsNk800eVSenZ9JaDckNqN0NJabYZYhKes0dT2XyOppOOQjSdAbm33KdYo
lmBliJqPYtyjxA50nSavzQ7QaIxuGQ==
=AcMn
-----END PGP SIGNATURE-----

--aJ74fq0Y6SrIeKCM--
