Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11787590C1
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGSI6V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 04:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGSI6U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 04:58:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C96134
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 01:58:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM30U-0000x6-Vy; Wed, 19 Jul 2023 10:58:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM30O-000Yta-Kc; Wed, 19 Jul 2023 10:57:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM30N-0063rq-Qs; Wed, 19 Jul 2023 10:57:55 +0200
Date:   Wed, 19 Jul 2023 10:57:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20230719085755.qx2kv7wavgivxbu2@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nar6ftprr3sh5bnf"
Content-Disposition: inline
In-Reply-To: <ZLeX4UbFaY592HIa@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nar6ftprr3sh5bnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Jul 19, 2023 at 09:59:29AM +0200, Thierry Reding wrote:
> On Tue, Jul 18, 2023 at 08:18:32PM +0200, Uwe Kleine-K=F6nig wrote:
> > This function allocates a struct pwm_chip and driver data. Compared to
> > the status quo the split into pwm_chip and driver data is new, otherwise
> > it doesn't change anything relevant (yet).
> >=20
> > The intention is that after all drivers are switched to use this
> > allocation function, its possible to add a struct device to struct
> > pwm_chip to properly track the latter's lifetime without touching all
> > drivers again. Proper lifetime tracking is a necessary precondition to
> > introduce character device support for PWMs (that implements atomic
> > setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> > userspace support).
> >=20
> > The new function pwmchip_priv() (obviously?) only works for chips
> > allocated with devm_pwmchip_alloc().
>=20
> If this is supposed to be similar to the GPIO chardev, why doesn't GPIO
> require this way of allocating a struct gpio_chip?

For each gpio_chip there is an external struct gpio_device that is
allocated in gpiochip_add(). This works but has some downsides. E.g.=20
gpiochip_remove() has to grab a mutex that is also held while userspace
polls a gpioctrl device and so gpiochip_remove blocks. While this works
(as in: it doesn't crash) it's in the category "not as good as
possible".

I'm convinced that getting this right before adding the complexity of
chardev support is a good idea.

> I'm not a fan of doing all this upfront work without seeing where this
> is ultimately headed. Please hold off on reworking everything until
> you have a complete proposal that can be reviewed in full.

I see some benefit of the conversion started in this patch set stand
alone, too. But I agree it's for now a bit theoretic.

With the goal to pick the agreed good approach for pwm this is a bigger
pile of work. Completing it in private and only present the complete
proposal has the downside that I get feedback for the house's seating
only when the roof is assembled. While me spending much time isn't your
problem, I have a problem with it. Splitting the task in chunks that go
in one after another is surely the quicker and more effective approach.

So it would be great if you could understand the issue tackled here even
though there are subsystems that do it differently (and less optimal)
and the usecase isn't complete yet.=20

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nar6ftprr3sh5bnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS3pZIACgkQj4D7WH0S
/k5PpQf+NhSs8TKfF29c+NaIB9r7d8I2FndYYPr7JWNOez7Ab1FoI3NRx+EzedUa
doI9hzI1hf8GqZSwTa+blGo8z+8kcMqBXNJ7w7eDXIs6fAIZEBKdBcAW5R5HLN+D
Pg04sIiMP8i4F+QQyVXCNfa5dsjE8TUithEEiZd/TadHjxVksZqGPPm1Pz/KzxCW
dreG7pjj4ElbCF4y7aQn/+66OInSdWKGMo2J0p7y3ZrMm54at8lWWkvv0X1lF+lA
cB8ED6BChxP4WyvZ2OIkGo8HE5oD7zEUQTU5ogu3E0aiUhomDu56wo40wD4ZbbDQ
FG6mR2/62M6EuhjTGeFB3KOIkMP+4Q==
=5GJh
-----END PGP SIGNATURE-----

--nar6ftprr3sh5bnf--
