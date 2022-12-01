Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740DE63F161
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLANQm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 08:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiLANQj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 08:16:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D69E47F
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 05:16:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jQF-0005k0-SY; Thu, 01 Dec 2022 14:16:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jQ4-001aku-EN; Thu, 01 Dec 2022 14:16:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jQ4-001nfp-Ga; Thu, 01 Dec 2022 14:16:04 +0100
Date:   Thu, 1 Dec 2022 14:16:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Guenter Roeck <groeck@chromium.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        linux-riscv@lists.infradead.org, linux-leds@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        chrome-platform@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Hammer Hsieh <hammerh0314@gmail.com>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an error
 code
Message-ID: <20221201131604.beq4l22d42tjy6dm@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
 <20221201102252.52ace284@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ohce74rjo6dhumlo"
Content-Disposition: inline
In-Reply-To: <20221201102252.52ace284@donnerap.cambridge.arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ohce74rjo6dhumlo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andre,

On Thu, Dec 01, 2022 at 10:22:52AM +0000, Andre Przywara wrote:
> Just one comment: I don't see a sunxi specific patch later in the series,
> though it seems we have at least one error error exit (see prescaler =3D=
=3D 0
> above). Plus potentially another exit if clk_get_rate() (at the very
> beginning) fails.
> Shall I send a patch for that?

That would we very welcome. I mentioned that shortly in the cover
letter, I wasn't entirely sure how to handle that prescaler =3D 0 case.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ohce74rjo6dhumlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIqREACgkQwfwUeK3K
7Anj8wf/RTNhxYSv59Ka1mlJPxXTgymtejOcjGY7Mbrq9aaYBt0Hmzz6T20Siom0
QSRZvBBJxLeC6sMsbo0Fz9qdDLt4Y9eWczlHASjdcke40fNWNcUpjo7GqJ8hMfD9
/aBk/LIrTHuSJDWkLiUxCXgg/mPhVdSfgltE3xCWRU/+rQxWvEnKjFCDDnQvwGlJ
XDzUeAMWwhWAOAeq69ypA0qbVXlCnpA7rRbuNpgviLuXPg8B8sCx+fEPtsGCAwh1
W/lWgOdahAH40o8lldqWf0S/1Bb95qmDKjx/yI1gsCQpycDwDEgQeueUPRTMz912
rL27K8cypWE75vkt7PMvSDMIkNan0w==
=aHcT
-----END PGP SIGNATURE-----

--ohce74rjo6dhumlo--
