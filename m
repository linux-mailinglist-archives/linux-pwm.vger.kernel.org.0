Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460247BB589
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjJFKmH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJFKlt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 06:41:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928E101
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 03:41:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiGV-0004In-DF; Fri, 06 Oct 2023 12:41:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiGU-00BUeX-O3; Fri, 06 Oct 2023 12:41:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiGU-00A9Yq-EM; Fri, 06 Oct 2023 12:41:02 +0200
Date:   Fri, 6 Oct 2023 12:41:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20231006104102.4k4ivgw7na2o2f2q@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <ZR_RQ-PMqfrDPGwE@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bleddb6y4igyk3gu"
Content-Disposition: inline
In-Reply-To: <ZR_RQ-PMqfrDPGwE@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bleddb6y4igyk3gu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 11:20:03AM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > this series addresses the issues I reported already earlier to this
> > list[1]. It is based on pwm/for-next and several patches I already sent
> > out, too. Maybe some of these have to be reworked (e.g. Thierry already
> > signalled not to like the patches dropping runtime error messages) but
> > in the expectation that I will have to create a v2 for this series, too
> > and it actually fixes a race condition, I sent the patches out for
> > review anyhow. For the same reason I didn't Cc: all the individual
> > maintainers.
> >=20
> > If you want to actually test I suggest you fetch my complete history
> > from
> >=20
> > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> >=20
> > .=20
> >=20
> > In the end drivers have to allocate their pwm_chip using
> > pwmchip_alloc(). This is important for the memory backing the pwm_chip
> > being able to have a longer life than the driver.
>=20
> Couldn't we achieve the same thing by just making sure that drivers
> don't use any of the device-managed APIs to do this? That seems like a
> slightly less intrusive way of doing things.

The device-managed APIs are not the problem here. If you allocate in
=2Eprobe and free in .remove there is a problem. (And that's exactly what
the device managed APIs do.)

So no, you cannot. The thing is the struct pwm_chip must stay around until
the last reference is dropped. So you need some kind of reference
counting. The canonical way to do that is using a struct device.

You can try to hide it from the low-level drivers (as gpio does) at the
cost that you have the driver allocated structure separate from the
reference counted memory under framework control. The cost is more
overhead because you have >1 memory chunk (memory fragmentation, less
cache locality) and more pointers. IMHO the cleaner way is to not hide
it and have the explicit handling needed in the drivers be not error
prone (as spi does).

I agree the switch suggested here is intrusive, but the "new way" a
driver has to look like is fine, so I'd not hesitate here.

> > The motivation for this series is to prepare the pwm framework to add a
> > character device for each pwm_chip for easier and faster access to PWMs
> > from userspace compared to the sysfs API. For such an extension proper
> > lifetime tracking is important, too, as such a device can still be open
> > if a PWM disappears.
>=20
> As I mentioned before, I'd like to see at least a prototype of the
> character device patches before I merge this series. There's a whole lot
> of churn here and without the character device support it's hard to
> justify.

The character device stuff is only one reason to get the lifetime
tracking right. See that oops I can trigger today that is fixed by this
series.

> I have a couple more detailed comments, but I'll leave those in response
> to some of the other patches for better context.

Earlier today I managed to get this character support working enough to
be able to trigger pwm_apply_state calls. My test case looks
(simplified) like this:

	state.period =3D 50000;
	for (state.duty_cycle =3D 0; state.duty_cycle <=3D state.period; ++state.d=
uty_cycle)
		pwm_apply_state(pwm, &state);

With a naive sysfs backend that takes approx. a minute. With an
optimized version (that only writes the duty_cycle file in the above
case) it goes down to 20s. With the character device it takes 4.7s.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bleddb6y4igyk3gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf5D0ACgkQj4D7WH0S
/k7VvQgArXVGSsp5yAt4v53Watz7PGwe0sgLQMyqnO9qIOOY8aCi+XYZhaP61XyC
29gZzMBwUks+vuDLYDgzYZ113khyW39xRMMO0ZxYnVMmUjl5V30M74OiwN7/iZ7J
paDRJMx/E/ZinR9W0dvkLMPFSTzComOwy7Zq2QQKTeZHyjNeuvc6W5WNM/6NWGbZ
+JGT0UsOChpIhjV79ksG43M9Aoobcs568Gby6SDEzFNXsbUqvnwopUm2zFtpbNSF
RV4JMJyjTY7uIRJZvF2sNT9EUNvODmhLDLX7klFmSjP/hVK/BeOhmbT+3ewdymT8
U6UPCXUdJYHqAb7osYIypmgX6ZLyOw==
=OQhC
-----END PGP SIGNATURE-----

--bleddb6y4igyk3gu--
