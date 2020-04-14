Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306351A89CB
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504117AbgDNSjZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 14:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504116AbgDNSjY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Apr 2020 14:39:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030CD2076C;
        Tue, 14 Apr 2020 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889563;
        bh=P4rgnvp+ubvr6gQQwx96f5n8r83/w0mRlcAt7NxMf1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ww0nYJB4QPCYiyCRxxrz3MhjaV8MiazOYKP+JMlOoHG2mbl+ChLoBBcrOipv2bynr
         B20L1Mj7Hi2EyxZG0mfBSrEA+lwtlYNctnTC7UWNAjwpWou1DgNqwMLKtwb2+q7N60
         usjUjbY8yBBBG0upAxAMQXtDr65r+D74Qk8q/NYI=
Date:   Tue, 14 Apr 2020 19:39:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Message-ID: <20200414183921.GN5412@sirena.org.uk>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <20200414172129.GJ5412@sirena.org.uk>
 <fa605af3aee48f0bc62133f398ed7c5d@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Content-Disposition: inline
In-Reply-To: <fa605af3aee48f0bc62133f398ed7c5d@walle.cc>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2020 at 08:36:23PM +0200, Michael Walle wrote:
> Am 2020-04-14 19:21, schrieb Mark Brown:

> > You could define REGMAP_INVALID_ADDR to be (unsigned int)(-1) or some
> > other suitably implausible address and use that as a value.  It's
> > possible that there might be a collision with a real address on some
> > device but it should be sufficiently unlikely to be useful, especially
> > if it's not something regmap in general goes and evaluates.  For extra
> > safety we could have an API for allowing users to query the register
> > validity information regmap has (or can be given) and gpiolib could then
> > use that to figure out if the value was actually a dummy value but
> > that's probably overdoing it.

> If possible, I'd like to have the opposite logic. That is, if it is not
> set it should be invalid. If we have a magic macro like
> REGMAP_INVALID_ADDR, we must assign it to all the unused addresses. Thus
> every driver would have to assign all addresses and if in the future
> there will be some added, we'd have to touch all the drivers which use
> gpio_regmap.

Sure, for that you'd need a separate flag since zero is such a commonly
valid address.

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6WA1gACgkQJNaLcl1U
h9BAjwf/bIsieXPSNQdoyPsGYQ4OjkmRX200mVnxW9V8WW1aT87hmD5XwdcUz27T
0oXCpdsy7VDE5l4T7iDCXzXW1++aQW/mOE7MW7fgfDLWe212XUBcKluVTQ77+1wo
z8FEPPjTRReUzy4LyvEtOuPv8S/wEeHOaPxuyOhhNacw5Sa/Wrmoj3UJRsUzB/MG
Cm0W3nRmAIw1VeyMwP89BNeTXYdbqUojlBRj5DZRhXziF7L6YyLe8nMH3ZN+JOq7
Od3cD4VROPQ3xfDaeCEG8QsoHSwZXYG+2kF7DjgWvC7zliuISkElPje0uK2KEHHJ
aaGR4e5qeBL5Nha6oy2QwhRMN1Fezw==
=I4w+
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--
