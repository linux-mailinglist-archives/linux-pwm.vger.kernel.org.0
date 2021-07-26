Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E893D5998
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhGZLwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 07:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhGZLwe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 07:52:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F896044F;
        Mon, 26 Jul 2021 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627302782;
        bh=9ybwuRlPn1rSduQGUcjvmmV/5LFG8tIFb468xFHdIDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2ZAyCYR8V3kOK88nTio3CyW/06XL1WxI5vbjnBhhBATlHkIBjeitOp07Kbkl0hwU
         RB1hG0ovaLC1oKNnhPnmNpAAPMmCMcTjTWv4p0inJZULecxC85x1566mdVypNca0dS
         4gqzhL5vYnoLMEAsYsEbaCCu5u+mtKLPhPZfQ2uvgW76nEUYJhaWJCvQ4Wf3LPGMUe
         KBMRuIbZtc2N4WHM2x8DxH1T64yG6jgNRErEit/IVurxz1whAHyVHk8VK5X2Qg675n
         kUAtu87BQx+xa7MlU9xiLdRUaTWLxqmB809xlkcFNAJZMpxi7bPmQKpY/Rz5zOk7IR
         WC67S71TFKD0Q==
Date:   Mon, 26 Jul 2021 14:32:54 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Claudiu.Beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        sboyd@kernel.org, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, mturquette@baylibre.com,
        Nicolas.Ferre@microchip.com, linux-spi@vger.kernel.org,
        o.rempel@pengutronix.de, Ludovic.Desroches@microchip.com,
        broonie@kernel.org, thierry.reding@gmail.com,
        aardelean@deviqon.com, kernel@pengutronix.de,
        Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <YP6rdmi31FFrBMzE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Claudiu.Beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        sboyd@kernel.org, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, mturquette@baylibre.com,
        Nicolas.Ferre@microchip.com, linux-spi@vger.kernel.org,
        o.rempel@pengutronix.de, Ludovic.Desroches@microchip.com,
        broonie@kernel.org, thierry.reding@gmail.com, aardelean@deviqon.com,
        kernel@pengutronix.de, Jonathan.Cameron@huawei.com,
        akpm@linux-foundation.org, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <CAHp75VeFXJ-0ak7=a0QCtKNdFpu98W6iJ2YuR4MpNx+U4rHe2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/bp6B8CbZ5wGttYd"
Content-Disposition: inline
In-Reply-To: <CAHp75VeFXJ-0ak7=a0QCtKNdFpu98W6iJ2YuR4MpNx+U4rHe2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/bp6B8CbZ5wGttYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The idea is that you will send a PR to CCF maintainers instead of
> patches, although it's expected that patches appear in the mailing
> list beforehand anyway.

Depends a little. For me, a Rev-by from the driver maintainer is enough,
and I'll pick them. That lowers the burden on the drivers maintainer
side. May not work for high volumes of patches, but for I2C this works
enough.


--/bp6B8CbZ5wGttYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmD+q3IACgkQFA3kzBSg
Kbb/ZhAAiFi9EIRSinoG65uZhxKpv126w9aNu62btbmlWsIMvWGILnoEBHEH55Y2
WVY4s43F+YQFcjvi//5ycN7sOaPjG5hMHFhwKlNId6Z3dFnnTpzaVQbSkHOsqp8X
woXPKORhDvG5WKwBkvAeqMjvOk6wQKllAwEflk1XAE0S9f+CuxZMJOf+VD8nFg0G
VMOmds6KpGTCHKSXYd2uaTqgVUOPJlziSfcgpqKxzPpYn0iXhOC6APeRZesaS5G6
flGQ+qa6L8VInhxf8pYqiSyqrrs7ney5TA51Uz4q9byoRhJRV2+MaUQI3vsr4BSF
2OTbrGPvWhGyMgl6OttVe8Zcoyf0Z0GlFCP/8bHLs9Qg0kxGEvbDe+H3U6RcJRWZ
Yp3fpiRwkCwbrZBjr95xbeS0NLxvaKqqzrXY2JAtCopr52ruG1wtDmmnTLhjXsJY
LtUMvogfzaNXWGaL4khLFVggxB9tYvydxh5nrFyMpszfCL+gPiLL+/RW6EPQWYmB
O6/esDPfAJdgqp90sovnwTGOmKfKJgy7J83XVEmiD2UzHBftwsEtNDVqlTx4dnFv
7/V5Vvd78pJ7n/LxSUJNGYmmDfSgklfpNk1x5tYgvYLTzX/xffeTzyAJz0PKcAGz
KK8LeXGvUZ/uowpYEm+pnnzMAHhCzvFBZJU04xQ3gLhPOaTvtYU=
=4M9n
-----END PGP SIGNATURE-----

--/bp6B8CbZ5wGttYd--
