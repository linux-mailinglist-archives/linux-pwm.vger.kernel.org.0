Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2181A872B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407567AbgDNRMr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 13:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407517AbgDNRMq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Apr 2020 13:12:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6937C20767;
        Tue, 14 Apr 2020 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586884366;
        bh=+qcyIZF6Y3PyicvWS4ejyY0zwsK0szUsXLI7l22j8W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbluDEd8klbe4xkNX9xFsE670ESHTTOhjhaQFVoprnCTaU4ZEjH5UTUWLd+mTSI+6
         DSQqhWkIQPD3yBIeAJU1asNH6AEgt5USvO7Kqa+X6ECZCi+OKRLsnOvTCTR+BmFAPw
         EQDmo85zc+VWDvUZDPnadGVNgStkGN6AM/MaH5iQ=
Date:   Tue, 14 Apr 2020 18:12:43 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 04/16] regmap-irq: make it possible to add irq_chip do
 a specific device node
Message-ID: <20200414171243.GI5412@sirena.org.uk>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline
In-Reply-To: <20200402203656.27047-5-michael@walle.cc>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2020 at 10:36:44PM +0200, Michael Walle wrote:
> Add a new function regmap_add_irq_chip_np() with its corresponding
> devm_regmap_add_irq_chip_np() variant. Sometimes one want to register
> the IRQ domain on a different device node that the one of the regmap

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-irq-np

for you to fetch changes up to 12479382877dcf6623af4676caa8d3c647469a1b:

  regmap-irq: make it possible to add irq_chip do a specific device node (2020-04-14 16:21:37 +0100)

----------------------------------------------------------------
regmap: Allow an irqchip to be created for a specific DT node

----------------------------------------------------------------
Michael Walle (1):
      regmap-irq: make it possible to add irq_chip do a specific device node

 drivers/base/regmap/regmap-irq.c | 84 ++++++++++++++++++++++++++++++++--------
 include/linux/regmap.h           | 10 +++++
 2 files changed, 78 insertions(+), 16 deletions(-)

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V7woACgkQJNaLcl1U
h9BuQQf/an0mQWAm5vrM5ORmT03qy9aVeFZm3VBOD6lyBwl1SqzPsYPgdbPBk75U
DQv+FyWG5Qq1BmPfR4oE8pimSb+pt0UE1LO6zLTHt8WvYmRh+xj6UwLfO0WVEJ06
+xdRzkrGLVScCsrlYGfx1RtjmpgvwRCKZVw39nPYTr57mRndNqlTCAtVtYoL8bX0
I1ryrYEBvOcjJKTpWRKkm5LzVB67bpyYHEdmA5X6Xn1EwxcNrsfbJ5Eou9rlYmPI
c1ehw1CrspXGb28+phVkDRaTYRzv4QhOZ/m7Rj1nTMemSL5++ew7GBtMQYqyh+T4
x9u6Aa5UCcrOyLUoWRLaA3drz6EgbA==
=lV/N
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
