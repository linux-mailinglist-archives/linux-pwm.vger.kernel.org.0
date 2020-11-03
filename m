Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535C82A4D1A
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Nov 2020 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgKCRfT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Nov 2020 12:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgKCRfS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Nov 2020 12:35:18 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3496621D91;
        Tue,  3 Nov 2020 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604424917;
        bh=d7GVDYNRB1nkxf2PedrfHEfVA3XJxfH6uOxe6MdezuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsK91wUdoGUZK4AOAEjAfqPztcJvbwC8CyX0S+vLU47sPGM5gelbPSEU3bUmDvfbu
         Z1Fq3KEu7l+Fp0lM3rQJaPZW07CbsytQcFapNYcotHlya3IusuyrV4D5W8SdJOrluK
         aeDX6YUY3YvZlmni1IvawcsMbL/osVIJe5RKz2WQ=
Date:   Tue, 3 Nov 2020 17:35:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx drivers
 maintainer
Message-ID: <20201103173508.GE5545@sirena.org.uk>
References: <20201103162832.14085-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20201103162832.14085-1-krzk@kernel.org>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 05:28:32PM +0100, Krzysztof Kozlowski wrote:
> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and add Dan Murphy from TI to look after:
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hlMsACgkQJNaLcl1U
h9DMeQf/S8R2hQl3+LVLzMNkd1Q6yWjRyQrQjxMjOqrmU4Cu/kQMMM5rQtHOGVQP
uJmOlkrRnY6uOizYGLkrzxmhWHN8as6hkWahJvRB45G7UEco3DuZaRvUZpY9vK6+
1NKh1ISoMhfCL9bq5EZgOacORZVXZF9kGV10il0adlO6EEIcYekefZMks2ESlvp+
jmeq8iNlqj7u/BVm7X1SWFsHlUfB+Y/7ekebQxFYq+4DUfkc0r+Q+cREBgDYbX2B
iUNK8o8/itBiJ2Wl84FaPjOMfyWRIUrwgo8UUhzsrtCFejjk8zFWiebFeFHeyFnV
gSMg/Ymsj/xcLfaDYPbktl5KWprRdg==
=Dr7Z
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
