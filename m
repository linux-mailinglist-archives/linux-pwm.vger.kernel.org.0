Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E733775A770
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGTHMJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGTHLo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 03:11:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCE2701
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 00:10:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMNo5-0006Kw-7e; Thu, 20 Jul 2023 09:10:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMNo2-000mWW-K5; Thu, 20 Jul 2023 09:10:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMNo1-006IQo-Re; Thu, 20 Jul 2023 09:10:33 +0200
Date:   Thu, 20 Jul 2023 09:10:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-staging@lists.linux.dev, linux-rockchip@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, Johan Hovold <johan@kernel.org>,
        greybus-dev@lists.linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Alex Elder <elder@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
Message-ID: <20230720071033.e72hjkpghf5ooe73@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <ZLjYqwGh178EHrVY@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icirkconcmfpuvh7"
Content-Disposition: inline
In-Reply-To: <ZLjYqwGh178EHrVY@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--icirkconcmfpuvh7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 20, 2023 at 08:48:11AM +0200, Thierry Reding wrote:
> On Fri, Jul 14, 2023 at 10:56:13PM +0200, Uwe Kleine-K=F6nig wrote:
> > Uwe Kleine-K=F6nig (10):
> >   pwm: Use a consistent name for pwm_chip pointers in the core
> >   pwm: atmel-hlcdc: Use consistent variable naming
> >   pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
> >   pwm: crc: Consistenly name pwm_chip variables "chip"
> >   pwm: cros-ec: Consistenly name pwm_chip variables "chip"
> >   pwm: lp3943: Consistenly name pwm_chip variables "chip"
> >   pwm: rockchip: Consistenly name pwm_chip variables "chip"
> >   pwm: sifive: Consistenly name pwm_chip variables "chip"
> >   pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
> >   staging: greybus: pwm: Consistenly name pwm_chip variables "chip"
>=20
> This would've been much easier if it had been a single patch. Now I have
> to either make you redo the whole series because you've misspelled PWM
> or I have to go and update it myself in most of the above patches. Hint:
> I'll do the latter.

I guess you want to do s/pwm driver/PWM driver/? Fine for me, thanks.

> There is really no reason to split this up into this many patches for
> such a trivial change.

Well, that's a subjective view. There are reasons to prefer several
small patches over one big one, too. A small patch can be indiviually
reviewed, so the "Reviewed-by: Alex Elder ..." tag only goes to the one
change that he actually looked at and if later a fix to the sifive
driver is to be backported to stable, the stable maintainers just pick
the sifive one instead of one big patch.

Did you skip the sl28cpld patch, or squash the fixup I sent in the reply
to Michael Walle?

Best regards and thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--icirkconcmfpuvh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS43egACgkQj4D7WH0S
/k4yxggAmA419LnNhUxGLLqAb6cq3dncldtmQs44Y7SOPuVmDMivbYjrghQCbQDx
cwIq9JAASH/o55NbwiCBI6HBa7YDerPZyLNvpCcQ6r2QmX2uw18V/orXxcwCRohr
yMtPxmgVImRc76bjnqpML3G0QIpJf0IbUKmZvkPIOBwj5c+rZQqsvjPcT4UQNWXf
sWT3KXf2sJopeeWGHpThCgHnJuTEB/NdZkXhr2MwM8rJyafJBj91f+d8JQgVl5Pb
MC250+Md3rZwtyDIO6yG1Ay2ViuXwSqvy7u57oGccS6zcU6ZjG63maJ3aUXSXe7i
hClf7akfWvZhZdqYQwJ5WgqC9c3vEw==
=PJgI
-----END PGP SIGNATURE-----

--icirkconcmfpuvh7--
