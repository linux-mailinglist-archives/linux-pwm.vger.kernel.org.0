Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B67BBDDA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJFRfI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJFRfH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 13:35:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B7BF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 10:35:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooj9-0005I2-WE; Fri, 06 Oct 2023 19:35:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooj9-00BZM2-Dh; Fri, 06 Oct 2023 19:35:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooj9-00AOvl-3s; Fri, 06 Oct 2023 19:35:03 +0200
Date:   Fri, 6 Oct 2023 19:35:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20231006173502.n7kdbfqb7pwrudzs@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <ZR_RQ-PMqfrDPGwE@orome.fritz.box>
 <20231006104102.4k4ivgw7na2o2f2q@pengutronix.de>
 <ZR_0ob6D5XHbWgNG@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="braksevxbifuwkl4"
Content-Disposition: inline
In-Reply-To: <ZR_0ob6D5XHbWgNG@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--braksevxbifuwkl4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 01:50:57PM +0200, Thierry Reding wrote:
> On Fri, Oct 06, 2023 at 12:41:02PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 06, 2023 at 11:20:03AM +0200, Thierry Reding wrote:
> > > On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > this series addresses the issues I reported already earlier to this
> > > > list[1]. It is based on pwm/for-next and several patches I already =
sent
> > > > out, too. Maybe some of these have to be reworked (e.g. Thierry alr=
eady
> > > > signalled not to like the patches dropping runtime error messages) =
but
> > > > in the expectation that I will have to create a v2 for this series,=
 too
> > > > and it actually fixes a race condition, I sent the patches out for
> > > > review anyhow. For the same reason I didn't Cc: all the individual
> > > > maintainers.
> > > >=20
> > > > If you want to actually test I suggest you fetch my complete history
> > > > from
> > > >=20
> > > > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> > > >=20
> > > > .=20
> > > >=20
> > > > In the end drivers have to allocate their pwm_chip using
> > > > pwmchip_alloc(). This is important for the memory backing the pwm_c=
hip
> > > > being able to have a longer life than the driver.
> > >=20
> > > Couldn't we achieve the same thing by just making sure that drivers
> > > don't use any of the device-managed APIs to do this? That seems like a
> > > slightly less intrusive way of doing things.
> >=20
> > The device-managed APIs are not the problem here. If you allocate in
> > .probe and free in .remove there is a problem. (And that's exactly what
> > the device managed APIs do.)
>=20
> Heh... so you're saying that device-managed APIs are the problem here.

No, I'm just saying that replacing devm_kzalloc by kzalloc in .probe and
free in .remove (and .probe's error path) doesn't help, because that's
what devm_kzalloc does under the cover.

> Yes, without device-managed APIs you still need to make sure you don't
> free while the PWM devices are still in use, but at least you then have
> that option.

The big downside I see then is that each driver must cope to get the
free at the right place. Using devm_pwmchip_alloc() puts that complexity
into a single place in the core instead.

> My point was that with device-managed APIs, freeing memory at ->remove()
> comes built-in. Hence why it's confusing to see that this series keeps
> using device-managed APIs while claiming to address lifetime issues.

This is only part of the preparations. In the end there is no
devm_kzalloc() any more. (And the cleanup handler of
devm_pwmchip_alloc() calls put_device() which only triggers kfree() once
all references are gone.)
=20
> > So no, you cannot. The thing is the struct pwm_chip must stay around un=
til
> > the last reference is dropped. So you need some kind of reference
> > counting. The canonical way to do that is using a struct device.
> >=20
> > You can try to hide it from the low-level drivers (as gpio does) at the
> > cost that you have the driver allocated structure separate from the
> > reference counted memory under framework control. The cost is more
> > overhead because you have >1 memory chunk (memory fragmentation, less
> > cache locality) and more pointers. IMHO the cleaner way is to not hide
>=20
> Single-chunk allocations can also lead to less cache locality, depending
> on the size of your allocations. For instance if you primarily use small
> driver-specific data structures, those may fit into the cache while a
> combined data structure that consists of the core structure plus driver-
> private data may need to be split across multiple cache lines, and you
> may not end up using something like the core structure a lot of the
> time.

I think this is wrong. Two memory chunks of size A and B are never
better than a single memory chunk of size A+B for caching. Those small
driver-specific data structures all live in the B part. For cache
locality of this driver struct it doesn't matter if A is directly in
front of that or somewhere else. But with having these in a single chunk
you might benefit from better caching when accessing both A and B, and
simpler page handling and less memory management overhead.

> Anyway, I'm not sure PWM is the kind of subsystem where cache locality
> is something we need to be concerned about.

pwm-ir-tx is concerned about timing, and my customer controlling a motor
wants little overhead, too. I don't have hard numbers, but I tend to
invest that effort.

> > it and have the explicit handling needed in the drivers be not error
> > prone (as spi does).
> >=20
> > I agree the switch suggested here is intrusive, but the "new way" a
> > driver has to look like is fine, so I'd not hesitate here.
> >=20
> > > > The motivation for this series is to prepare the pwm framework to a=
dd a
> > > > character device for each pwm_chip for easier and faster access to =
PWMs
> > > > from userspace compared to the sysfs API. For such an extension pro=
per
> > > > lifetime tracking is important, too, as such a device can still be =
open
> > > > if a PWM disappears.
> > >=20
> > > As I mentioned before, I'd like to see at least a prototype of the
> > > character device patches before I merge this series. There's a whole =
lot
> > > of churn here and without the character device support it's hard to
> > > justify.
> >=20
> > The character device stuff is only one reason to get the lifetime
> > tracking right. See that oops I can trigger today that is fixed by this
> > series.
>=20
> My recollection is that you need to inject a 5 second sleep into an
> apply function in order to trigger this, which is not something you
> would usually do, or that someone could trigger by accident.
>=20
> Yes, it might be theoretically possible to run into this, but so far
> nobody has reported this to be an actual problem in practice.

It is theoretically possible, and in my book that's a good enough reason
to fix it. A use-after-free is relevant for the security of the whole
system, so nobody telling us to have hit that problem isn't an excuse.

> Also, as you have mentioned before, other mechanisms should already
> take care of tearing things down properly. If that's not happening for
> some reason, that's probably what we should investigate. It'd probably
> be less intrusive than 100 patches with churn in every driver.

Let's do some work sharing: I continue with the lifetime stuff (that we
need for the character device stuff anyway) and the character device
code and you check why device links don't work as expected? I cannot
cope for every potential bug I notice, at least not always on the front
of my todo list :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--braksevxbifuwkl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgRUYACgkQj4D7WH0S
/k4zaAgAjW49TaOXe2i8WCZ/7oMh+4Gy61um52mcxtYNJwyrQWWVgW1p8Sg7/e2w
XXmcKVCVsdqHsBM8ABPTVjIUWp1MuHGOmoFeR34FtTaQT/o8fm3c5IDleuB9/LL2
mnScIosbxfpQWt7Gw+9mVay61ajtcPIJ+kc26yi67GtOFKX+pCYOM5zdCSqOqNC3
SkrPHfPn/qikd2BlPuiJYg6/X/N9QMN2FR/y3kymb9dqwqqWdIJ/uL3X7L8TPM30
2VfHngwGFGvDWXE5zoii8Jda74AG1L+uKJHNALJxWpvM03nEyXqBLo/baXlQ3z3C
cXMynPdYO6GjK+A/0xoNM9ymBnAUSQ==
=izHP
-----END PGP SIGNATURE-----

--braksevxbifuwkl4--
