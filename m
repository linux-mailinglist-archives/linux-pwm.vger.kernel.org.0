Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86B38E515
	for <lists+linux-pwm@lfdr.de>; Mon, 24 May 2021 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhEXLLr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 May 2021 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhEXLLm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 May 2021 07:11:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0250C061756
        for <linux-pwm@vger.kernel.org>; Mon, 24 May 2021 04:10:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ll8TF-00051P-01; Mon, 24 May 2021 13:10:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ll8TB-0003A0-Qt; Mon, 24 May 2021 13:10:01 +0200
Date:   Mon, 24 May 2021 13:09:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-clk@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/6] clk: provide new devm helpers for prepared and
 enabled clocks
Message-ID: <20210524110958.ytcqzdgkqw6jeah5@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7put5ziwze3atjbn"
Content-Disposition: inline
In-Reply-To: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7put5ziwze3atjbn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 07:41:36PM +0200, Uwe Kleine-K=F6nig wrote:
> compared to v6 I rebased to v5.13-rc1 (which resulted in a conflict in
> the pwm-atmel patch), reformated the doc comments in patch 2 (as
> suggested by Jonathan Cameron) and added the two Reviewed-by tags for
> Jonathan Cameron.

Another two weeks without maintainer feedback. I didn't find a single
mail by either Michael Turquette nor by Stephen Boyd on the linux-clk
list on lore dating from this month. This patch set didn't get a reply
since more than half a year.

Is the clk tree still maintained?  Would a pull request help? There are
several people who expressed interest in this series and the cleanup it
allows.

@Andrew: Would you be willing to take the first two patches if Michael
and Stephen don't react in the near future?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7put5ziwze3atjbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCriYMACgkQwfwUeK3K
7Amfngf9Ga4caGfJs9XN3dun54N+DsOf8YkklfYBiAAjCixalrvdei8QJA3djFos
TTUqAA5pZSaT5RZBoXVn7bwDkIOTJHIKgD05+7uZL01XZ6LaO0b6euqhSnpUSWV5
yB8DteZUg4+FPgxa8a0DPgfBq5dRr1ADn3U2YBAvZXUnpIk49chH5viOQ7CockL/
28GJcNA94L87QFKtUMiw5myBy+ThHJiA5G8WKSXbSJB4JpI24B113XZH9lmCpxEg
1H9Z23S68CuV+9uvzIZAEhDPgwrSon7ILGeszXEYgBmGE2O/mL9WPptcCkRS0H35
DfScTBSMeU7Cw4q6705OV82DdPyFmQ==
=0Iaw
-----END PGP SIGNATURE-----

--7put5ziwze3atjbn--
