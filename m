Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A33D65EF
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhGZRA0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 13:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhGZRA0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 13:00:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E71F660F6C;
        Mon, 26 Jul 2021 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627321254;
        bh=r4zehfT85ltEor5F3Dr98zoMp3ICL3Y2HydcZKQboLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTLvus1ceKZtOlE+govp/T6+S9F8lO7yoRwSpZ1JnxIJr/C5XxRvZa+Aa5a8vBEMY
         ALlTvi7y/pyGO7FGkTYEtcRtmcVHXXppkq5TPAW6GC93uSv17e0CVS2uKxICNv7/Pb
         ATQHy5O5MPtDfquDdje85rmcGU6bBJTq4t1NKeooNt6ooWynRK2FUMsPApSLRGMKMy
         0YaNQy0cCsWK+rcOazZHb3ndqLDrYO7L06puZML/pzuU+biNQf9T782/CQQHE44Pvr
         dtSdVscpabIPfUeh44Uz+lcQop+9/zb5+uqsqY6NAdp7+Ny8CNfN/n1a/EGLpcZ3zA
         Iff3vU4eI7iGA==
Date:   Mon, 26 Jul 2021 19:40:47 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <YP7zn8n8wpSW4Gek@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <CAHp75VeFXJ-0ak7=a0QCtKNdFpu98W6iJ2YuR4MpNx+U4rHe2A@mail.gmail.com>
 <YP6rdmi31FFrBMzE@ninjato>
 <CAHp75VeT-EX6U3+Y7dxoWWRZ7NqAEiNgPGW8YGVmWTuZKB4j+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Ub7HcA0kcaU5RAp"
Content-Disposition: inline
In-Reply-To: <CAHp75VeT-EX6U3+Y7dxoWWRZ7NqAEiNgPGW8YGVmWTuZKB4j+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/Ub7HcA0kcaU5RAp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> AFAICT in practice it's a mandatory requirement in I=C2=B2C subsys (in the
> past you hadn't accepted a patch from us without a tag from the
> maintainer) which makes it equal to sending PR by a maintainer. PR

Right. I require a tag from the driver maintainer.

> makes less burden since subsys maintainer don't need to run many tools
> or a tool many times to get the pile of patches.

I had driver maintainers who found it difficult to have a public tree to
pull from or forgot how to send properly prepared pull requests. They
were happy to send Rev-by, though. And I am happy with that, too. At
least in I2C, picking up patches is small work compared to the actual
review.


--/Ub7HcA0kcaU5RAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmD+85sACgkQFA3kzBSg
KbYMFRAAoWozaOVEHjIi+cCiXLD3YtgYnrrT8mNSlpf11k8gAkfEERXC9nIXKJyG
uAv36d98/mKGGJemeqDXKuPii7VOqx3FeIgsmpa41N++qUEvXrjKXwCnq85+x/B/
eZxsJv82F0sxidnvujOrMDhitRMZNKQzZCmPaqhmnGRIWvaAwePF2ioMCEi+QxbN
HqJTNL+7G48hoGZq9WG8EW73gMkn2SDqiJJdwGSQbPMJ0Jqt4oAclkWfeqLP4Rou
StO5Pe1OSowMkIZJEOZAQvJwpcI3qruOxp9P2QYsm/7pYJrqMqGZCv/UD7uFb0UO
G8M6t8RNXfDOqGCwkCHeskTDixT/74pcvzIPB5C17n4xAgt3P5XuwH0+Sg+D3fqW
4Z2ig1HHc7dlTUYkTnRwECAkv1r7o98hpk3U0OT3FHJjsDpOuo0HUnH93HHI6spU
KgwVO4EaGIhExfl25ryyzKnanlchfN1s5nzEIxSj1YwrWbgZqtUEeXuS17zQebQ/
WA7uyvtGMkatdsFsYNdXT/U6aNbSSwz8Rnj8Ipz+FwpAqrr8rrLPcHD8hwEDnvtv
/LpAc5ANbmxmlHZb/WAdjxf1LlJiamhr0lnnSfYVqnw2jWpxFy4hdaJP6/HG1N80
e+jQNCQdbUPYUU2q53ZBj5SjHjAgTetpC3znuCYAAS7lY1Kk6iM=
=42tk
-----END PGP SIGNATURE-----

--/Ub7HcA0kcaU5RAp--
