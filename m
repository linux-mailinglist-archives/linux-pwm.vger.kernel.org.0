Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1979026BC11
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 08:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIPGAZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Sep 2020 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPGAV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Sep 2020 02:00:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DCC06174A
        for <linux-pwm@vger.kernel.org>; Tue, 15 Sep 2020 23:00:20 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kIQUK-0007Vi-Rc; Wed, 16 Sep 2020 08:00:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kIQUH-0000w3-CK; Wed, 16 Sep 2020 08:00:13 +0200
Date:   Wed, 16 Sep 2020 08:00:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        thierry.reding@gmail.com
Cc:     lee.jones@linaro.org, kernel@axis.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, oliver@schinagl.nl
Subject: Re: [PATCH v2 0/2] GPIO PWM driver
Message-ID: <20200916060013.r6vctk3pda2ucq3g@pengutronix.de>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
 <20200905164249.5vy23gizpwstbs5c@pengutronix.de>
 <20200915135445.al75xmjxudj2rgcp@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rsw2j3kru5d6gthh"
Content-Disposition: inline
In-Reply-To: <20200915135445.al75xmjxudj2rgcp@axis.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rsw2j3kru5d6gthh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 03:54:45PM +0200, Vincent Whitchurch wrote:
> On Sat, Sep 05, 2020 at 06:42:49PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Sep 02, 2020 at 02:12:34PM +0200, Vincent Whitchurch wrote:
> > > v2:
> > >  - [..]
> > >  - Stop PWM before unregister
> >=20
> > I didn't take the time yet to look at v2, but just spotted this which is
> > wrong. .remove() is not supposed to modify the output. (If the PWM is
> > still running in .remove() this is either because it was running at
> > bootup and was never modified or is a bug in the consumer code.)
>=20
> If the PWM is not stopped while unregistering, the hrtimer will still
> be active and unloading the module will result in a crash when the next
> callback hits.  The consumer can be userspace via sysfs.

This definitely outweighs my argument. So please stop the timer and put
a comment above like:

	The PWM should be already off here. Even if it is not we have to
	remove the timer because the timer function is about to go away
	and failing to stop it most probably results in an oops.

> # insmod /pwm-gpio.ko
> # lsmod
> Module                  Size  Used by    Not tainted
> pwm_gpio               16384  0
> # cd /sys/class/pwm/
> # ls
> pwmchip0
> # cd pwmchip0/
> # ls
> device     export     npwm       power      subsystem  uevent     unexport
> # echo 0 > export
> # ls
> device     npwm       pwm0       uevent
> export     power      subsystem  unexport
> # cd pwm0/
> # ls
> capture     enable      polarity    uevent
> duty_cycle  period      power
> # echo 100000 > period
> # echo 10000 > duty_cycle
> # echo 1 > enable
> # lsmod
> Module                  Size  Used by    Not tainted
> pwm_gpio               16384  1
> # echo 0 > unexport

I'm a bit torn if I should claim that this is a bug in sysfs.

Thierry, do you have an opinion here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rsw2j3kru5d6gthh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9hqeoACgkQwfwUeK3K
7AnHHQgAj4JZsIbLvK579+gj9ug19ZQnOrL5yNuBed/vVkj7YBDT9hQr+lX4Yzsa
lmdgWzGweTuVg/9gxAIIuJ6Z8zC2VNXv7x2wW+emrtqI6UfBKlWTnBN7kISeEozO
k4mLq4bNoyJNTFqZb8IpAjQnQcVSpSUfo3xAt40xySpD1iHc4e2HOPACq01hTqv1
Zj4RBsbLlIt5Bo2Gs6gjAEAVjn6HYvn2PwsNV4WbQ0FYGdLeF684K7xI6RuD6cpP
SrBmL8nYkIKQcqp2BwLnEHmQLtKUjZ3bIlLP45hgYBZiE/8UsOEo0Jzr9gMCCZtN
s309L0mcQW12nYxwCEgx2ltQm3Mu/w==
=ecUA
-----END PGP SIGNATURE-----

--rsw2j3kru5d6gthh--
