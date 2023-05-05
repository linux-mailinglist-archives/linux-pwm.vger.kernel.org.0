Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C56F7FC9
	for <lists+linux-pwm@lfdr.de>; Fri,  5 May 2023 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjEEJV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 May 2023 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEEJV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 May 2023 05:21:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB9359B
        for <linux-pwm@vger.kernel.org>; Fri,  5 May 2023 02:21:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1purcn-0007Gn-MY; Fri, 05 May 2023 11:21:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1purcm-001GLc-41; Fri, 05 May 2023 11:21:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1purcl-001SnQ-5N; Fri, 05 May 2023 11:21:11 +0200
Date:   Fri, 5 May 2023 11:21:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
Message-ID: <20230505092111.qknupa2vooi7mqwl@pengutronix.de>
References: <20230430165807.472798-1-hdegoede@redhat.com>
 <20230430165807.472798-19-hdegoede@redhat.com>
 <20230504165307.tydqlk6sml7sp5qe@pengutronix.de>
 <CAHp75VdgFFk=q-=ZDiKwV02Tin19ZSmSS=fhwgRrE6v48s-u0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spijxghgooufnm6x"
Content-Disposition: inline
In-Reply-To: <CAHp75VdgFFk=q-=ZDiKwV02Tin19ZSmSS=fhwgRrE6v48s-u0w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--spijxghgooufnm6x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 12:07:02PM +0300, Andy Shevchenko wrote:
> On Thu, May 4, 2023 at 7:53=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sun, Apr 30, 2023 at 06:58:06PM +0200, Hans de Goede wrote:
>=20
> ...
>=20
> > I don't know much about x86, but I think the table belongs to where this
> > "80862289:00" device is created.
>=20
> Just for your information, it's in drivers/acpi/acpi_lpss.c.

Compared to drivers/platform/x86/lenovo-yogabook-wmi.c this file is
never compiled as a module and so patch #1 would become unnecessary.

That file also already has a pwm_lookup table.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--spijxghgooufnm6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRUyoYACgkQj4D7WH0S
/k4B9QgAumrRuKqACcnzUHZDrsspWmghhef931B24IJmzU1FvfQDsIS//i28ujmS
VVTxjlf4hkD20e8fjDa6NccXXNdz+0FuvAxp4B6td0nuqiUbIUxIolzlPyQ+Rq5R
VGlgv/MKW0Zf8EetiLn4F3TOU61dBXSx938YvJF4eRtoOnKq+2CA2reFlwB7Eon/
eVozvQKJYs4XAyIucIn0LX71jc3cOW/EGu1MbIWjLTMfvh5/0NOmUTtxhy0n3TxK
73CFAeB9hP/27YBV3cx5qT5/982DarTap0Bqg4tqW4MFzAryqMSnuHpLSrfCHxV8
H1ziaDJwCuUDkGg0N4w3YxprBuYOJQ==
=nvF9
-----END PGP SIGNATURE-----

--spijxghgooufnm6x--
