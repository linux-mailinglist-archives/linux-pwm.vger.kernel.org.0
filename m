Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4050063F170
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiLANTh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiLANTf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 08:19:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5569A1C2E
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 05:19:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jT6-0005zw-Lz; Thu, 01 Dec 2022 14:19:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jT1-001alJ-Sp; Thu, 01 Dec 2022 14:19:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0jT1-001ng9-TI; Thu, 01 Dec 2022 14:19:07 +0100
Date:   Thu, 1 Dec 2022 14:19:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Guenter Roeck <groeck@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
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
        Douglas Anderson <dianders@chromium.org>,
        Michael Walle <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 00/11] pwm: Allow .get_state to fail
Message-ID: <20221201131907.bmrenldnua7uaeab@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <Y4iL9xf5bJM5pyeR@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twdnam2bj5te67tc"
Content-Disposition: inline
In-Reply-To: <Y4iL9xf5bJM5pyeR@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--twdnam2bj5te67tc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Thu, Dec 01, 2022 at 11:11:51AM +0000, Conor Dooley wrote:
> TL;DR, I quite like the ability to return an error and not mislead the
> caller.

Is this an Ack?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--twdnam2bj5te67tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIqcgACgkQwfwUeK3K
7Am3+gf9HQlrVI1DS5daIvtH5ajPj10gQCf7wUVcwdDqDzHuJW7mEQVvG1vEEaVC
1sZxg13cFekIRhMzVMDj6JMG7MCuBqT0KWFDrstMLC2g7ot2+xZ6iJXXJL/3AQSm
pf/UiOQYYN7VXn0Wpf8L2FkfFuTglAuZE6bLdE2t1/+pQnp9oR81aoPWJgZ8vhax
WOkQYiH16UpgLNbhu7dV4133nkA6dfsSG+DrZjPy9vDdjCyDXUpxPnldpcHu+KCh
zRNQ9gX0bYT60vQejp9169VriwhcHhts0uT6AnSYVw/MzYrwx/pJu9bdq+iq86Uc
bMsdCWzzY9XerANJF7JdTMcJrfah8w==
=luMq
-----END PGP SIGNATURE-----

--twdnam2bj5te67tc--
