Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636A35ADE5
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhDJOCF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJOCE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 10:02:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B432C06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 07:01:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVEBH-0000GW-Ez; Sat, 10 Apr 2021 16:01:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVEBH-0008Cl-00; Sat, 10 Apr 2021 16:01:47 +0200
Date:   Sat, 10 Apr 2021 16:01:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 4/8] dt-bindings: pwm: Support new
 PWM_STAGGERING_ALLOWED flag
Message-ID: <20210410140146.5nlp5eczltezbyq2@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-4-clemens.gruber@pqgruber.com>
 <20210407053357.ok62rqpgyqou53m3@pengutronix.de>
 <YHBINhLa3pCZjoxO@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dndaw2zk5osfq3kr"
Content-Disposition: inline
In-Reply-To: <YHBINhLa3pCZjoxO@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dndaw2zk5osfq3kr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Apr 09, 2021 at 02:27:34PM +0200, Thierry Reding wrote:
> On Wed, Apr 07, 2021 at 07:33:57AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 06, 2021 at 06:41:36PM +0200, Clemens Gruber wrote:
> > > Add the flag and corresponding documentation for the new PWM staggeri=
ng
> > > mode feature.
> > >=20
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> >=20
> > For the record, I don't like this and still prefer to make this
> > staggering explicit for the consumer by expanding struct pwm_state with
> > an .offset member to shift the active phase in the period.
>=20
> How are consumers supposed to know which offset to choose? And worse:
> how should consumers even know that the driver supports phase shifts?

I'm aware that we're a long way from being able to use this. The clean
approach would be to get the offset from the device tree in the same way
as the period. And in the meantime I agree that introducing a flag that
allows to shift the active part in the period is a sane idea. So I
suggest we concentrate on getting the details in the corresponding
discussion straight.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dndaw2zk5osfq3kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBxr8cACgkQwfwUeK3K
7AkjVQgAjo/Bp/amP5OhhbHAxsZaKUXnsIuqDl25vhizVzvUI1359jMQ4GUWhrjS
vW2pyfjftqYGuFf7y6ePoJSGxFMuRKm6Xw82MNmATDKseTDsILkFuZX/5AKaHg7D
RlRQtxvLwYE+FVyCy/LHTuqR9w8cRzmuVFXIpFXYE4SeAFEgMUfA4YcuBiIqbqEs
pOqC38xat2HpMmpqTrUNZfoJYZy48aB1D/u/o1HmYPJ+VUEo03XZazuFzxuV/iyx
BSLTZuIxhMpO0jJjPgv7tnR7GDqZnWlzDVzI6dWgiT5iAh9S4gLYDlyzzdu2wmsA
rmZCk7YDVwaVRJygGA5dmqLQVMkZwg==
=nMwu
-----END PGP SIGNATURE-----

--dndaw2zk5osfq3kr--
