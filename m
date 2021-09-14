Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6F40AFA3
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhINNyP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 09:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233319AbhINNyO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Sep 2021 09:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A3DB61107;
        Tue, 14 Sep 2021 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631627577;
        bh=BpjP19V1GArx35KplyxcS37xjhXHSaC39kHOiHZJM7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilOvo0fbU/Cd2di+m1iZcwJ9EuMRdLFoQa58d4eGEYAEX6TpEvHx9XIJfwkDw55Ff
         CSm6YzYsZiNo7GG3qze7OVv2xZF2MxNGSMtxTJ3xnSL0+QX+kgjwwT2T6FuUbYViFy
         Sot2TI1Uo1LEp1sQVvnWXnSwbF21ca4rEHC6KGFGUWMRkaZqQiWfJz1cmju8Fi+9YC
         dlox4kSn+dTRSasQtodrl97Unrii9wFoLSBYej20ILHU1c8M3yNEfj6wWfPlyKwK/f
         kCTWWVclQPzl9gWcM3maVJD6KdzBMZVcOFeQRKdqi5/mK7179vzlIb2ZxDK82sGjjQ
         cD9/Y+YKZ1a7w==
Date:   Tue, 14 Sep 2021 14:52:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        Ludovic.Desroches@microchip.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, wsa@kernel.org,
        thierry.reding@gmail.com, kernel@pengutronix.de,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210914135217.GD4434@sirena.org.uk>
References: <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de>
 <20210802163824.GK22278@shell.armlinux.org.uk>
 <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com>
 <20210803104012.wf2buscbukxufesl@pengutronix.de>
 <162820957661.19113.17221558053361108175@swboyd.mtv.corp.google.com>
 <20210914132256.5ucytcfmk3sjn2vi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <20210914132256.5ucytcfmk3sjn2vi@pengutronix.de>
X-Cookie: This space intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2021 at 03:22:56PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 05, 2021 at 05:26:16PM -0700, Stephen Boyd wrote:

> > This proves why this topic is always contentious. It's too easy to
> > blindly convert drivers to get the clk and leave it enabled forever and
> > then they never use power management. The janitors win and nobody else.

> If the janitors win and nobody else looses anything, this is fine for
> me. And if in the future someone turns up who cares enough to improve
> the converted drivers to a more efficient clock usage, they will
> probably not stop their efforts just because then the driver uses
> devm_clk_get_enabled.

The patterns that concern me are people either blindly converting to
devm without checking for other usage and causing problems as a result
(some of the janitorial stuff is done very mechanically) or thinking
it's important to keep devm_ used (or not thinking through the
interaction) and trying to do that while doing something more active.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFAqRAACgkQJNaLcl1U
h9AgDQf9FaB8NN9SPJzY87JQf0rdn7s4PizKVF0601355cdJqe1ogFgZalaw7hLc
hxn4RRKTRGv8Yxrjt3am15H5/DUZillCg/bkxDlq2/Vdi3VmRSjlqdKANc/+WMj6
nADV3B/yorQB1Mcy49EvaL4Y9vhYTeF+kwj7z8ijkCt/zregcfuuhZ8xiSveKGaa
sfsKJlJvSbjbKEp3CPtFj+dqRpKUb55+FKR1z/tH6XKZf1dtYP3ORTCbQxk3DEE4
ROe3jakuTEWrrbh8sPtplaviMX8fuLKs2qBP70r3/EGtpoAQDbBgj6fhUJud3vcy
b9UCVUtYXiOVzuAC6+7b4iuXNbjzvQ==
=zaar
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
