Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15DB1F4246
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgFIR37 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 13:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgFIR35 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 13:29:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C97A20774;
        Tue,  9 Jun 2020 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591723796;
        bh=Qmr3xU4Wr498BcrukotcukidPlKEgC2wLsO/I0prusU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=19nG0JhFpICXKRdbQSqtV0xLlrZOSFIZdBzGSyuzFEyQ2dbY5bUXfPdrnZ6jcWHUo
         5oFSLLb0j1GAaGWDSmFkt13oJIr1GWQVeODfQGNwbTo6AcQi4rffXKZCSqX3WSqM3s
         CO4pnstLd/HBdIWUPNfNZy1qr8OFn5U3V2Azny5c=
Date:   Tue, 9 Jun 2020 18:29:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200609172954.GM4583@sirena.org.uk>
References: <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
 <20200609171520.GC1019634@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pz/qqzCPDfGwIFOg"
Content-Disposition: inline
In-Reply-To: <20200609171520.GC1019634@bogus>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Pz/qqzCPDfGwIFOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 11:15:20AM -0600, Rob Herring wrote:

> Find another driver doing this already and rename it 'simple-mfd' (no=20
> relation to the DT binding) and add your compatible string to it.=20
> 'Generic' or 'simple' drivers don't require generic/simple DT bindings.

> Or extend the existing syscon driver to look up the bus_type and create=
=20
> the regmap based on the bus type?

You'd need a particular bus driver to instantiate for a given bus (or
I'm misunderstanding your proposal) so it wouldn't even need a lookup,
just per-bus ID tables (and ideally also data tables with the regmap
and child descriptions).

--Pz/qqzCPDfGwIFOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fxxEACgkQJNaLcl1U
h9DCLQf/bdNDdxW0Qpw6CjYiwGbdGhDPz2buR07hZ0HFwlLW/CCeJCk0naiEaRo1
P3qH84YQ2ka1vdYpGLWX6+vvXjU2ejaSPz9GmDxoUVkrxB8SjwVYWehydJkgE8Bs
/f9vdLsoac0TjNNro7gumcUGE6bIGFDUvuOJkjn+O4dOBz3cTqhYsY4Sz14cyTxW
maZmtiiVvFyP5Jrf0LTE2oQzqnTEKgoBY8Ku6f34K7EiNmIK/bgppdXsJvNGqZp9
tPbeGiW01Rg8XVNPYnjJf6TipJRvHLJh8hma6sFq5dqH0ZNDpFFW35xqWLPWL5Af
2Plbt+f89ibSJGeBNXMaaEPkfzTv7A==
=lKAA
-----END PGP SIGNATURE-----

--Pz/qqzCPDfGwIFOg--
