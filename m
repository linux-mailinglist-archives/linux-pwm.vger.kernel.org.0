Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A211BAB92
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD0Roa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 13:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgD0Roa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Apr 2020 13:44:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E43321556;
        Mon, 27 Apr 2020 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588009470;
        bh=ZaQ6rn/s8Kxlhe/QZALln6lZXSTb4k8n2GRkZCZBmgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMFO2+XnqLry1pIniBTURC2gvN/tKbjFoUkcjrP4kTyckpzL63R1QvPw+LlJzAsjM
         w9RmIa3QOhKcAnm8ydbtxKubMmPAJjc6+x8mIKbBK7Ys5H3bbIXR5BhxaixwpfZg0m
         RK1NeLYmU2ZSqu0FlSlslEJG3G0I0IOuMbScRvwg=
Date:   Mon, 27 Apr 2020 18:44:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
Message-ID: <20200427174427.GE4383@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
 <87f141bce0a4fda04b550647306be296@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <87f141bce0a4fda04b550647306be296@walle.cc>
X-Cookie: If your bread is stale, make toast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 07:40:11PM +0200, Michael Walle wrote:

> IRQF_ONESHOT, because its is a threaded interrupt with no primary
> handler. But I just noticed, that regmap-irq will also set the
> IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
> set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
> just there to be sure. So I don't know if it should also be set
> here.

Looking at the changelog there the "we can't be sure" bit is that
coccinelle couldn't follow the flags through from the caller to make
sure that IRQF_ONESHOT is set so we're just oring it in unconditionally.

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6nGfoACgkQJNaLcl1U
h9Bhuwf+MMHsfmI2RDYY6qZJmxPEgyN6UpeiPwIpozVnZsA0/TQuDxAvV7Iu9PfO
+h9DTbgF3GzRsw9kiWlFgxriyJsdUwvxpYGjS3Rdr2HEWv275fEurdRRXceeeSHZ
w5PoR+ALv2rs+6UVVekmkK3Ht9/eJlVGJyLEYOfddcXTjTs/eezYWZrFNKaLfETD
fP1XXLYorJDv1ovH/P6R6zK+3aunlvBdBHIoQCSh5GoHkAAyNNhayWdKZX1BsIqA
2bc5gQ2WCk83As3jtjwuDiPJRhETrcQT3y/1F7KDxn+SqRE5V51fQiwvbpLtGHsc
XKfax9UH35Ornk7702asjugdC5kd9g==
=+BYw
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
