Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D73D1F20
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhGVG7f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 02:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhGVG7e (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 02:59:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7796461285;
        Thu, 22 Jul 2021 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626939610;
        bh=o6+shJ52XMYNQNL2m3wHwNbYWTR597KJl90PUNArBLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKXULSP4oq5JT3+CeONyQO6qhyXtHxTMRKgwhsb5+7eo/oYTJ3tnGmYMqezCpwLQt
         pv1iFUKyb8eXEDJq24A1GHK+OtX5ejT5oK10O1zzQ62ClMRTJCufD7tBKdfXvoP/zh
         CfiNi9losz69I0yhh4OHuxnGko2niR/dUI5ioD7n/DPKNyCSemLx+oD5InIsAifDUH
         9DKub1k9Q3g0utH/8y2nnz54r/b30yI0pV5Htzjs5ZwPH/Ihl7rHt1h/Hvd3+6dI/7
         FyWWrmZhOx7yTS6iuLaGaoxO4xEp0FX0Czgv9nci3vI9rb4A+9qH7mPXYlXYHTipXM
         2J8sjktuLHafQ==
Date:   Thu, 22 Jul 2021 09:40:03 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <YPkg0wtYIoHKpTUW@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XxsZNqK/fNX7gchR"
Content-Disposition: inline
In-Reply-To: <20210722060654.nudpdtemosi64nlb@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--XxsZNqK/fNX7gchR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The next merge window is over now. The pull request still merges fine
> into v5.14-rc2. I'm still convinced it adds some benefit and I want to
> use it to simplify a bunch of drivers. But I cannot without this being
> merged.
>=20
> Do I have to consider creating these functions in the pwm namespace to
> continue here? This cannot be the right thing to do?!

What about adding gkh to the list explaining the situation to him?


--XxsZNqK/fNX7gchR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmD5IM4ACgkQFA3kzBSg
KbbQlQ/+OItE/h5w5Gl6Ds3163rOIE8E80gug6P3SeEFgsN7dJQ0sC6A4N3OMkqg
CyZdF147YyFObHApfRwLd8doZnrDU6KMdUWZ0u8krD/RIIX6iw5rj7wf2CkXM75v
JFpqcXRq5kVkRSphukdvuLs8AWUFO98WfaAsGNos9zyIdoS+Uap+g4eYhZg0/+dl
O81wZGNh0JHlezXUzbrOx1boEwW2IQP5F1pQQYheBYD6IEBqF44LCEAd0DqE1pXN
E8V08ljGrHrPcwJ9GwIyHE3LkxYytW8FkR7LaTxuCz+Gi5tplw6wbAhJSG68fxOM
Ihm+JnB5V/2jgzk9nFdF7QmzR1OorTndmUUQAvk7bqne8wcom/RQm76oSsglRL4M
0YQniC2usKNRW7xTqhfFkQrodTaNF2B+MjImErHG7Vy5Gxw7QtH71QqYq0BHb/TV
rUIMrmfFl37BeXUFV6Tnzjw5iw5GhELEaIhVz8aiXv5GIhWxBrhdp6y8VR9nx+ob
QTA8UpUWrxOKtPAYY/ImiLTTyUYaluSweaIHnp+wA1cIf0VqO2AqO8lo+7g/9jYl
ikmMXLSxqhleG4dmDbd075ozy84rt8pcaEQdpahst5eyic0f37oRKfca7RVX9Gn6
4ojKHGnunYZPdY5hSfdHDMSCzRd77EhYBYLLJNyhfpja6HSXwzI=
=ltgz
-----END PGP SIGNATURE-----

--XxsZNqK/fNX7gchR--
