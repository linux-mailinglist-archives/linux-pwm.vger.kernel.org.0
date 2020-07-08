Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E22184DC
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGHKWw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 06:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHKWw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Jul 2020 06:22:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ABA206F6;
        Wed,  8 Jul 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594203771;
        bh=wqmaKC3soWVBrlD0Udy60m7oemLeH3Uc93lnAOZzD64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYUJimONTlH3wLq1pKSc1jyXGvkW2lRwGivQTRbMogNQuQnSdwDRn+kL2E4zSJ1lr
         dt+DglW619hP+mHz7wZvNNOFaZS4z1CNFMdod/h3vMwzXOeBIuQdGyn5r1VucItt9+
         93Kk/xam0fZbQoT25njkkG2V8PcvfpNiw3dhKgow=
Date:   Wed, 8 Jul 2020 11:22:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 01/13] regmap-irq: use fwnode instead of device node
 in add_irq_chip()
Message-ID: <20200708102246.GC4655@sirena.org.uk>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-2-michael@walle.cc>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2020 at 07:53:41PM +0200, Michael Walle wrote:
> Convert the argument to the newer fwnode_handle instead a device tree
> node. Fortunately, there are no users for now. So this is an easy
> change.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-np-fwnode

for you to fetch changes up to 5cc2013bfeee756a1ee6da9bfbe42e52b4695035:

  regmap-irq: use fwnode instead of device node in add_irq_chip() (2020-07-08 11:15:12 +0100)

----------------------------------------------------------------
regmap: Change node pointer to fwnode in new IRQ API

----------------------------------------------------------------
Michael Walle (1):
      regmap-irq: use fwnode instead of device node in add_irq_chip()

 drivers/base/regmap/regmap-irq.c | 53 ++++++++++++++++++++++------------------
 include/linux/regmap.h           | 21 +++++++++-------
 2 files changed, 41 insertions(+), 33 deletions(-)

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FnnUACgkQJNaLcl1U
h9B0awf+K6uyKfcY+Cw0Q9cXWpxT1fJLMyrXuyyDLg9o9Qo5YPVU8XkiwRGhJJto
Asdm6vmCDIr0StMW2SEZxg4vVW6Xxw2UKMU2+ZBJxsGZEgpLxec+7NdiXOtqUQsL
JmKcTbR+nObPx+w74a1G7QHftWWVDX4peRYST0rLvo8tzaS1NoACmku5AYVhc9Z6
aUUQKrAghHkoinADk2p6YHBuo4C5EZg/qmB/iN2t5g3aNF9YhdDXNB4ZeE+UwQG+
F+RC9shXxL6/pSqCpua22fNq6tEHEpaWnGwnsxX3eaJ00iDuD0KAHAmtNuo6X75M
41RS28TqmDnMbDlLrCvgPxlHJ8Lpjw==
=nOcx
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
