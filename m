Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4D1F6FCD
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKWUm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 18:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWUm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jun 2020 18:20:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C879C03E96F
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jun 2020 15:20:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjVYm-0001X4-La; Fri, 12 Jun 2020 00:20:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjVYl-0007bu-V1; Fri, 12 Jun 2020 00:20:31 +0200
Date:   Fri, 12 Jun 2020 00:20:29 +0200
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
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
Message-ID: <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cab7bvsyn2ss63v7"
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-10-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cab7bvsyn2ss63v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
>=20
> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
> this commit makes crc_pwm_disable() clear it on disable and makes
> crc_pwm_enable() set it again on re-enable.
>=20
> This should disable the internal (divided) PWM clock and tri-state the
> PWM output pin when disabled, saving some power.

It would be great if you could also document that disabling the PWM
makes the output tri-state. There are a few drivers that have a
"Limitations" section at their top. Describing that there (in the same
format) would be the right place.

Also note that according to Thierry's conception getting a (driven)
inactive output is the right thing for a disabled PWM.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cab7bvsyn2ss63v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7irigACgkQwfwUeK3K
7Am/ugf/dDb23XNKHboy/tUBXfvicttKMcJeA2J2xQLa2smBZBSW6Rf227uTjwYi
LO+Kf0upcb1HCGqkE0t2BcTL6JwuMF6bIT8SONUYeHul6CyAYZTrberZhj/C6aoq
ea1xFjJr8WyAPUhXl4ZbTLfWyiNb2VeTdtF9FkB2FTarSuWTZR543f5Jk0mt6Xey
tMfjpCLepNvwDqYvfoqFgbhjzrSmIH8voI8IFGIOecEVpbc63L74FsNKQ3JNg8Ze
teRAOKKFK1VFYCrmBis286R9boQH2C5kkwC3raILdtXaJvPtFBJ9CKjITH/hTDzi
+YDSdup1pgUjtnMrUlmULfHAisd2sQ==
=JBUs
-----END PGP SIGNATURE-----

--cab7bvsyn2ss63v7--
