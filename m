Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775D2216755
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGHZS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 03:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGGHZS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 03:25:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A2C061755
        for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2020 00:25:18 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jshyN-00071J-9e; Tue, 07 Jul 2020 09:24:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jshyM-0007cr-07; Tue, 07 Jul 2020 09:24:58 +0200
Date:   Tue, 7 Jul 2020 09:24:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 11/15] pwm: crc: Implement get_state() method
Message-ID: <20200707072457.6bb6vqif355fbs26@pengutronix.de>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-12-hdegoede@redhat.com>
 <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
 <59babd32-9421-0b31-187f-ceff7c003f54@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5o57lf2673xp25na"
Content-Disposition: inline
In-Reply-To: <59babd32-9421-0b31-187f-ceff7c003f54@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5o57lf2673xp25na
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Mon, Jul 06, 2020 at 11:05:20PM +0200, Hans de Goede wrote:
> Before I post a new version of this patch-set, you have only responded
> to some of the PWM patches in this set. Do you have any remarks on the
> other PWM patches ?

I stopped looking at them as I hoped someone would appear with a
datasheet. Given that this probably won't happen I can take a look at
the remaining patches.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5o57lf2673xp25na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8EI0YACgkQwfwUeK3K
7Al5ygf/Vo2MCrxebQA7I8RHxSI5JD/fpUazpfqXoJruzxMkaR87VXdj0S1+ayNc
mtVoPaEadgJc3Gwt7jEAqod7zUQA1lABJS47piDlaDE7v9Dq+ZBMp6KIqGTxKa4C
i4XFpjD5ktWpuWU6c34yYkDDmyYUyzWZe1SxYcjWpfK6TnGAuJe78RmTyNcEnE61
9cGSYyki+SQfIrQtbjQJIMi6Nhmt6c+yT7FgnbDAoJoGBsLY+UShQgSfWfxVre/r
VUArL2ALscRIielEbRjKYg3Kx83TkfzRUdaonnLlmSw15x7cTjXEXQNBZXf7WG3a
YXACfmrQaGmlrRETxX5y/PB1jbzrEQ==
=8rxl
-----END PGP SIGNATURE-----

--5o57lf2673xp25na--
