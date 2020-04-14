Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C831A8759
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407627AbgDNRVe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 13:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407622AbgDNRVd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Apr 2020 13:21:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE77120678;
        Tue, 14 Apr 2020 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586884892;
        bh=hqDprYjabFxBscfVEG0+5dvJzqZCcHd1opdmPnhd2Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+nY5DfVYhJx8o/ujjNNyx0kjonVY+DPsN2UhfHMYXXuk8Og3wt4jhCpynBMBQsd2
         p21D/wQE6MCWwIlH0ZmgjFqR0D+M4Je8cOa8cweBdHkm6ikP4EFafxr6YWy1ePAAbi
         0NzuUD49CAh9h2IhLW6bGuhkMptucBaXFvPmYvhk=
Date:   Tue, 14 Apr 2020 18:21:29 +0100
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
Message-ID: <20200414172129.GJ5412@sirena.org.uk>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2020 at 12:07:01PM +0200, Michael Walle wrote:
> Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:

> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
> > IS_ERR() returning true?

> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
> the type the regmap API has for its "reg" property). It could be a
> pointer of course but then the user would have to allocate additional
> memory.

You could define REGMAP_INVALID_ADDR to be (unsigned int)(-1) or some
other suitably implausible address and use that as a value.  It's
possible that there might be a collision with a real address on some
device but it should be sufficiently unlikely to be useful, especially
if it's not something regmap in general goes and evaluates.  For extra
safety we could have an API for allowing users to query the register
validity information regmap has (or can be given) and gpiolib could then
use that to figure out if the value was actually a dummy value but
that's probably overdoing it.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V8RkACgkQJNaLcl1U
h9AnZwf8CXCh0WrZ2WtwfdTJ1yX5W12AkMOk5xoWSFXC9PzRicdAquQGHN0U0Qan
v2iy9fXKFP9/vjkpNOP0q8hzXFoFbxcDvTTPUcPJV9Xd/bJ/X2OTXn7qKKLxIA0q
8i5t5KXA1+3upDL3nzJvH/dZULUUz7vP7m1SrwkowgS4asnOJVMfa8vGJLbnxhT5
m9MjUO206PwDS/sUpsK36S+4ccbV5Nzdq50Ce9sWr4szpQnKtAFb0Z8Q9eriTl15
hJxwRBCZJLqzXLYIGVC0eJPv9YrbG3YLM+x+Hb6oxzOuHRWU5B/Kv8n01YeHW5A1
Zk21Hdv+mJcVD0qTQ1dNFzb4QzAp5Q==
=mDDb
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
