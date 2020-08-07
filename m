Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06023EC9E
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgHGLfx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 07:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLfx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 7 Aug 2020 07:35:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE2522C9F;
        Fri,  7 Aug 2020 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596800152;
        bh=tB44LrcAJ3NxEYYWCxVL/xdN1g4mPUOLKmrBE/LmCZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adPdvx7BNkN3vzleYgFgdh5QTP1V3DG3dm6nNmuWVM8gkbIiTTFCE48YedudEmH4P
         X6lzhSZuMMswEMloGb/39wFETPqu1rkcW6m5xnQg/jknYdA3B25xVAZg4N6Mc5/AfX
         fSwa0ZcfFidwfuu3qxrr1xB0vJ7CvrA1LEk8tSfo=
Date:   Fri, 7 Aug 2020 12:35:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 18/41] ARM: s5pv210: don't imply CONFIG_PLAT_SAMSUNG
Message-ID: <20200807113528.GE5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-18-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-18-krzk@kernel.org>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:20:35PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The plat-samsung directory and mach-s5pv210 can be build
> completely independently, so split the two Kconfig symbols
> CONFIG_PLAT_SAMSUNG and CONFIG_ARCH_S5PV210.

Acked-by: Mark Brown <broonie@kernel.org>

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tPH8ACgkQJNaLcl1U
h9AKhQf/R7RK8Hp7GiOARjjdjgAtgRwwe6zGtME1BaY4sl5QjQX3lbKLy27zSN8g
oIS4rQz7hiHTbEPAYejiOFvzEWdxiiJCwsb4LoUYmS7z5ZHh1hkymZNMNxkh03k5
OtD206PpuFlkRBy5mQmvNSpCLcAZ933xTyhdUDH00eAg5/09+FEqq4z84afijimH
EDgvn6dXYA8Zqd+w7Kx0fiERDK0Ygo1jl85OEsLKFbPZefjx9wUKqqNlm9Oz+s+k
C6yb2uPrkc2t8FqW0jBc/nR+ky0+VBkW3duO0CCP1Sag3U2HLi5GZ2wdtQrXLXu+
ZDfJfLruyTaIkzFFcfZgPsjk6niMXQ==
=qNw4
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
