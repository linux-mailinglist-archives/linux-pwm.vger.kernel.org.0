Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFE6B6112
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Mar 2023 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCKVor (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Mar 2023 16:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCKVoq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Mar 2023 16:44:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DC6780F
        for <linux-pwm@vger.kernel.org>; Sat, 11 Mar 2023 13:44:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pb719-0003cW-2j; Sat, 11 Mar 2023 22:44:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pb717-003U6Q-Sq; Sat, 11 Mar 2023 22:44:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pb717-0048R8-8k; Sat, 11 Mar 2023 22:44:41 +0100
Date:   Sat, 11 Mar 2023 22:44:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
Message-ID: <20230311214437.tdv5wl5a6qgsewd4@pengutronix.de>
References: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
 <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4maj6yxo5akufdgw"
Content-Disposition: inline
In-Reply-To: <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4maj6yxo5akufdgw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 10:00:50PM +0100, Martin Blumenstingl wrote:
> Hi Uwe,
>=20
> On Fri, Mar 10, 2023 at 8:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
> > There is a complicating fact, that the .apply() callback fakes support
> > for inversed polarity. This is not (and cannot) be matched by
> > .get_state(). As fixing this isn't easy, only point it out in a comment
> > to prevent authors of other drivers from copying that approach.
> If you have any suggestions on how to fix this then please let us know.
> I don't recall any board needing support for inverted PWM - but they
> may be out there somewhere...

And that's the problem. As the hardware doesn't support inverted
polarity there is no way to implement it correctly. The only right way
would be to return -EINVAL in this case, but this might break some
consumers.

I have an idea how to evolve the PWM API. That's by introducing an
=2Eoffset parameter to struct pwm_state. This would describe the following
PWM signal:


   ___________/=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF\_____=
__________/=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF\____
   ^                         ^                         ^                   =
      ^                         ^
   <------ period ---------->
   <- offset->
              <--------> duty_cycle

This is more general than polarity: It can describe normal polarity
(.offset =3D 0) and inversed polarity (.offset =3D .period - .duty_cycle).

Then the policy to implement a pwm_state like that would probably be:

 - Pick the biggest period not bigger than requested
 - for that period pick the biggest duty cycle not bigger than requested
 - for that period and duty_cycle pick the biggest offset not bigger
   than requested.

With these rules in place it would be allowed to configure normal
polarity for a request with inverted polarity, but not the other way
around. Then the algorithm currently implemented in the meson driver
would be allowed.

A consumer that doesn't care about the offset (i.e. most drivers) could
just pass .offset =3D .period - 1.

To be practical for consumers who care about polarity, we first would
need a way to test the capabilities of a PWM though. I have an idea for
that, too, but today this is still vapourware.

> > Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson=
_pwm_get_state()")
> > Reported-by: Munehisa Kamata <kamatam@amazon.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4maj6yxo5akufdgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQM9kIACgkQwfwUeK3K
7AnKNwf5AVcvzbbovW0B1iiKTDldySSke8ms11GNKQux6cCmeUcLwXa7FJ2RfD4P
c6Wwxsk6/+myN0n0p4+0mwncIq60RIngX7MiB8Ym0oC07Ivlftg+IFfjAA7VSGNK
daGc0+d0DyHiZ4sCbSzRCLUDyZ+Y0r4i0QYOqTcftnQ0TzgcTs5YXxBKf9DLqHeM
rRWCmnL7xz88zrqO7gPYM6oFX8EjHm3a9P0aJA8gK6CFMopUaphkeTfkIp3rqeY2
l5gALAF2lvBPmorufiMPqyBUOe2vLwabnVMt7M1/PNFf5FL5A8Emws92RXhWhotX
+oYNgg3LYHPBJ5wZjhPTcbJQ0xoFOQ==
=9noi
-----END PGP SIGNATURE-----

--4maj6yxo5akufdgw--
