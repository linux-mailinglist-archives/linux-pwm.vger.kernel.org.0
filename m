Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0427EBBE
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgI3PDH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3PDH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 11:03:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF5C061755
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2020 08:03:06 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNddI-0007wM-E3; Wed, 30 Sep 2020 17:03:04 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNddH-0002HX-2B; Wed, 30 Sep 2020 17:03:03 +0200
Date:   Wed, 30 Sep 2020 17:03:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930150302.n3kcw3lzepug53za@pengutronix.de>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20200930095204.GA1585476@kroah.com>
 <20200930100126.rtjfnmbc54m7vrwd@pengutronix.de>
 <20200930105238.GA1592367@kroah.com>
 <20200930112720.xiff3xwmfu3gjypk@lem-wkst-02.lemonage>
 <20200930115106.GB1603625@kroah.com>
 <20200930141352.kt6bpudj2t57ogp3@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fn2q5sadp7dee75g"
Content-Disposition: inline
In-Reply-To: <20200930141352.kt6bpudj2t57ogp3@lem-wkst-02.lemonage>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fn2q5sadp7dee75g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 04:13:52PM +0200, Lars Poeschel wrote:
> On Wed, Sep 30, 2020 at 01:51:06PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 30, 2020 at 01:27:20PM +0200, Lars Poeschel wrote:
> > > On Wed, Sep 30, 2020 at 12:52:38PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 30, 2020 at 12:01:26PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > On Wed, Sep 30, 2020 at 11:52:04AM +0200, Greg Kroah-Hartman wrot=
e:
> > > > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=F6nig wr=
ote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I added Greg Kroah-Hartman who I discussed this with via irc =
a bit to
> > > > > > > Cc:.
> > > > > > >=20
> > > > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > > > > thank you for your review!
> > > > > > > >=20
> > > > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=F6ni=
g wrote:
> > > > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemona=
ge.de wrote:
> > > > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > > > >=20
> > > > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > > > Exporting a pwm through sysfs did not yield udev events=
=2E The
> > > > > > > > >=20
> > > > > > > > > I wonder what is your use-case here. This for sure also h=
as a place to
> > > > > > > > > be mentioned in the commit log. I suspect there is a bett=
er way to
> > > > > > > > > accomplish you way.
> > > > > > > >=20
> > > > > > > > Use-case is to be able to use a pwm from a non-root userspa=
ce process.
> > > > > > > > I use udev rules to adjust permissions.
> > > > > > >=20
> > > > > > > Hmm, how do you trigger the export? Without being aware of al=
l the
> > > > > > > details in the sysfs code I would expect that the exported st=
uff is
> > > > > > > available instantly once the write used to export the PWM is =
completed.
> > > > > > > So changing the permissions can be done directly after trigge=
ring the
> > > > > > > export in the same process.
> > > > > >=20
> > > > > > It looks like userspace wants to see when a pwmX device shows u=
p, right?
> > > > > >=20
> > > > > > And it's not because those devices do not belong to any class o=
r bus, so
> > > > > > they are just "floating" out there (they might show up under
> > > > > > /sys/bus/virtual, if you set things up right, which I don't thi=
nk is
> > > > > > happening here...)
> > > > > >=20
> > > > > > So yes, you need to create a class, or assign this to a bus, wh=
ich is
> > > > > > fine, but it looks like no one is doing that.  Don't create new=
 classes
> > > > > > dynamically, but rather, just assign this to the existing pwm c=
lass.
> > > > > > What's wrong with that?  I saw an older patch that did that, wh=
at did
> > > > > > that break?
> > > > >=20
> > > > > Are you refering to 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00? Did=
 you
> > > > > read the reverting commit's log message? (i.e.
> > > > > c289d6625237aa785b484b4e94c23b3b91ea7e60)
> > > > >=20
> > > > > I guess the breakage is that the resulting name then is:
> > > > >=20
> > > > > 	"pwm%d", pwm->id
> > > > >=20
> > > > > where pwm->id is a number unique to the pwmchip. So doing
> > > > >=20
> > > > > 	echo 0 > pwmchip1/export
> > > > > 	echo 0 > pwmchip2/export
> > > > >=20
> > > > > breaks because both want to create pwm0 in the class directory.
> > > >=20
> > > > Ah, that makes more sense why that didn't work.
> > > >=20
> > > > Ok, can the "name" of the new export chip be changed?  Is that
> > > > hard-coded somewhere in userspace tools already?  Depending on that=
, the
> > > > solution for this will change...
> > >=20
> > > I know that back then, when sysfs for pwm was created, Thierry didn't
> > > want to have one global namespace like gpio sysfs has. What you ask f=
or
> > > is something like:
> > > 	pwm-{chipnumber}-{pwmnumber}
> > > Right ? Can that be considered non-global ?
> >=20
> > Yes, and that's just "global" for the pwm class namespace.
> >=20
> > > Thierry's mail from back then is here:
> > > https://lore.kernel.org/lkml/20130408081745.GA21392@avionic-0098.mock=
up.avionic-design.de/
> > >=20
> > > A short search on github I found this:
> > > https://github.com/vsergeev/c-periphery/blob/d34077d7ee45fa7d1947cc01=
74919452fac31597/src/pwm.c#L74
> > >=20
> > > Seems to match your hardcoded criteria ?
> >=20
> > Yes, ugh :(
> >=20
> > Ok, now I see why the "lots of pwm classes!" patch was proposed.
> >=20
> > And maybe that's really the only way forward here, as the chip namespace
> > is the only unique thing.
> >=20
> > But wow, it feels wrong...
>=20
> Would the following feel better:
> * use the new naming scheme you proposed for pwm's :
>   pwm-{chipnumber}-{pwmnumber}
> * assign the normal pwm class to the exported pwm devices. That lets
>   them appear in the global /sys/class/pwm directory as e.g. pwm-0-0
> * maintain backward compatibility through symlinks e.g.:
>   pwmchip0/pwm0 -> ../pwm-0-0

My preferred way forward is: Create a proper device (i.e. something like
/dev/pwmchipX) and make that usable with atomic operations. Then we
don't need to go through sysfs and can modify more than one property at
a time.

But other than that your suggestion sounds better than one class per
chip.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fn2q5sadp7dee75g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl90niMACgkQwfwUeK3K
7AlSeQgAkCGYtDvTBYPjGGmdrPO6/TOkAYjIrZpmQiQgbg+fUHFDsoOzvSN5E4zL
XfqH1pEojWDZQlnuS7VGjuQBFQbU6BAnCcz4nIpqRncWc+A8R4h+Q6I0/IIH39BL
QHm6VhjXl/EL5J0ZuzhoZiX1Xs7XvOwyO0I3djZXp9xGHRSPjm69OSmj2BcFj9UA
jb0qGw6bgoCPZi6eueYvZJwBpiQPvTDATPItrw10aHv1rYmBW6K0ZKU/iVjK1J6V
2k3RvjXDbwn2D4KNFN0TgnFGiUIHsZhqlWO+qtm5OYCVfxjHsNf0PSbsQCnw/9f9
YCgo1vccisXIChgXpOd29AV2FyIS+g==
=fnwZ
-----END PGP SIGNATURE-----

--fn2q5sadp7dee75g--
