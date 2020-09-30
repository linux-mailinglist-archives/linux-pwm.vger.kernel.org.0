Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7A27E5E3
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3KBa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3KBa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 06:01:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336FAC061755
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2020 03:01:30 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNYvP-0005ZA-RS; Wed, 30 Sep 2020 12:01:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNYvO-0005Lj-Dz; Wed, 30 Sep 2020 12:01:26 +0200
Date:   Wed, 30 Sep 2020 12:01:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930100126.rtjfnmbc54m7vrwd@pengutronix.de>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20200930095204.GA1585476@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7xv3k4q6xheyahri"
Content-Disposition: inline
In-Reply-To: <20200930095204.GA1585476@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7xv3k4q6xheyahri
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 11:52:04AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> > Cc:.
> >=20
> > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > thank you for your review!
> > >=20
> > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrot=
e:
> > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > >=20
> > > > > This adds a class to exported pwm devices.
> > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > >=20
> > > > I wonder what is your use-case here. This for sure also has a place=
 to
> > > > be mentioned in the commit log. I suspect there is a better way to
> > > > accomplish you way.
> > >=20
> > > Use-case is to be able to use a pwm from a non-root userspace process.
> > > I use udev rules to adjust permissions.
> >=20
> > Hmm, how do you trigger the export? Without being aware of all the
> > details in the sysfs code I would expect that the exported stuff is
> > available instantly once the write used to export the PWM is completed.
> > So changing the permissions can be done directly after triggering the
> > export in the same process.
>=20
> It looks like userspace wants to see when a pwmX device shows up, right?
>=20
> And it's not because those devices do not belong to any class or bus, so
> they are just "floating" out there (they might show up under
> /sys/bus/virtual, if you set things up right, which I don't think is
> happening here...)
>=20
> So yes, you need to create a class, or assign this to a bus, which is
> fine, but it looks like no one is doing that.  Don't create new classes
> dynamically, but rather, just assign this to the existing pwm class.
> What's wrong with that?  I saw an older patch that did that, what did
> that break?

Are you refering to 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00? Did you
read the reverting commit's log message? (i.e.
c289d6625237aa785b484b4e94c23b3b91ea7e60)

I guess the breakage is that the resulting name then is:

	"pwm%d", pwm->id

where pwm->id is a number unique to the pwmchip. So doing

	echo 0 > pwmchip1/export
	echo 0 > pwmchip2/export

breaks because both want to create pwm0 in the class directory.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7xv3k4q6xheyahri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl90V3MACgkQwfwUeK3K
7AlntQf/R1R9cQ5tQpSeeAntycOo/UUJOVKzsVmeInnAqGh0Npj4pD+vQQIL/6OK
4y2yQirWYIWl439kqT0ADXeltyn7tbhx8D9ZqRAPMvV3N7KpxEUDD8Nuaklp2ubG
I1wwsKm3I4cbZVGxe2UyPmsbVokf3B87lw5/78sJuKa1stIWLevqhNH35UzGKTbi
0rwo17NfG1No0ZYcTwur4CrRkuWC/AUJMkzA6tOSm51acig7OeBW/EcMZ/aYouiW
thcCrzQ8kWhjuubjzo9WDP9TLRzeJEIa8Vygwj/5BiyfVyeK0z9q4XEybMMbHuIv
KiobhMbwcZcDUvaefT09A2Zp2Ghiog==
=at+8
-----END PGP SIGNATURE-----

--7xv3k4q6xheyahri--
