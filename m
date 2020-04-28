Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF01BC36A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgD1PZr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 11:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgD1PZr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Apr 2020 11:25:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4838206D8;
        Tue, 28 Apr 2020 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588087546;
        bh=th3tqv11ZgZgj8E96bFG6ckng9nKhzjnFA3FZBoCqDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlWrbndNBYw9f/3rJZ9vWhuiMI9bols+NUpDrkpb6nMDPcIB+exm9thHsajcNMv2s
         zF8ons1G+Tu9b/RtEzHyR4oERYHCJhNFS7iYENen9Yfm5zJskPzV8YzecKgzoPwIBB
         YihdZq8p8AkIueprECGqpetiJGVIrRNXwJ4Om4/8=
Date:   Tue, 28 Apr 2020 16:25:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
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
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
Message-ID: <20200428152543.GI5677@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
 <20200428124548.GS185537@smile.fi.intel.com>
 <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
 <20200428142938.GX185537@smile.fi.intel.com>
 <6ccad285-7b5f-3037-d4d5-ff4d9571b612@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <6ccad285-7b5f-3037-d4d5-ff4d9571b612@arm.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 03:49:49PM +0100, Robin Murphy wrote:

> For better or worse, the platform bus is the dumping ground for random crap,
> so we just have to deal with all the abstraction breakage that leaks out of
> that.

The reason we're using the platform bus for this is that historically
people were creating buses which were essentially carbon copies of the
platform bus with the name changed and it was felt that rather than
duplicate code it was better to just use platform devices with no MMIO
ranges defined.  If there's some assumptions about DMA for platform
devices floating about somewhere it might be reasonable to revisit this
and create a non-DMA variant of platform devices since there is a
meaningful difference.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oSvYACgkQJNaLcl1U
h9Bs4Qf/RCa5JW+qq8H0nchlRU4JeR7TBiAfPi1/fksL+W8k+qMkV0/KwPSMqloA
CaWErSXTzc1Mk3WKIT7UxNlcK1QsuUfNZnyA3JhFXAg39xjWpt2vSM7A/zY5mnOm
ZkujuFzw0NzNuBoxG+8OaBH1Ltitu/KpgCPJgrmwT09V5WuZ5uf8b3mjnEo0reaN
DYcUgV/u3XkUeSbMd1iljqd8bt+jHFHoFlVOVtcw+xh20cKvQ6kOzIPYlDbuz9rM
tGPZwlyojrQeFd8YYTh1hqSzqeB6E19JgdPEi9P34gi7rIctOcI6b9PwFO9er5fW
ov2hgkFJC60dI+z5f9j70bLBQfMw/w==
=hzNB
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
