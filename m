Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B367BB5F8
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJFLJ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJFLJ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:09:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16D83
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:09:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiiO-0007Ug-Ur; Fri, 06 Oct 2023 13:09:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiiO-00BV97-8B; Fri, 06 Oct 2023 13:09:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiiN-00AAZr-V6; Fri, 06 Oct 2023 13:09:51 +0200
Date:   Fri, 6 Oct 2023 13:09:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 071/101] pwm: ab8500: Store parent device in driver
 data
Message-ID: <20231006110951.wkmjvokvnenuypdh@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
 <ZR_WXxqhmRgtpA0n@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rpntxhfjssij74as"
Content-Disposition: inline
In-Reply-To: <ZR_WXxqhmRgtpA0n@orome.fritz.box>
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


--rpntxhfjssij74as
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 06, 2023 at 11:41:51AM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:19:01PM +0200, Uwe Kleine-K=F6nig wrote:
> > struct pwm_chip::dev is about to change. To not have to touch this
> > driver in the same commit as struct pwm_chip::dev, store a pointer to
> > the parent device in driver data.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-ab8500.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> You're basically adding a parent device to all driver-private data
> structures in this and the following patches, so why not keep in in
> struct pwm_chip and simply rename chip->dev to chip->parent?
>=20
> As Andy has commented, this would eventually allow the PWM core to
> take care of certain things like runtime PM, or even only for stuff
> like using the parent device name in info/debug/error messages.
>=20
> Also, you could then just make this a single large patch that renames
> dev to parent in one go rather than making this large set even larger
> with this kind of trivial changes.

The idea here is (again) that I don't have to touch all drivers in the
commit that changes struct pwm_chip.

In the end there is such a parent pointer (pwmchip.dev.parent). Would
you prefer a macro (say) pwmchip_parentdev that can be defined as

	#define pwmchip_parentdev(chip) (chip)->dev

at the beginning and then be changed to

	#define pwmchip_parentdev(chip) (chip)->dev.parent

in the right moment? That's the best idea I have here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rpntxhfjssij74as
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf6v8ACgkQj4D7WH0S
/k6hjAf/c/NXCI+C8qUFEpHZSuyUzZ1x+1X3GDFprmIlOJa8khFIk/p4ghuDUS3S
PPf5SmRPqfUt2J39iR1mb7Wd9wVfy3gAiIIXJyisp25WSnhunPV+2WU9bt39bDZ2
NiT2j4szbDsl7qs3YCGc5HxUGPzSz73eQmpdae+9JBMFyJMrSdMHeMacRnBRV4X5
7za6M7Gc82MemmBG34M8Us1Cjyu9QvF81FsleUndaIpViJGALJjDOdIqycsIxgN8
67hBwR3qhvoSj1Zb3NLLylA1wgqROV+475DIPq65lEGYJQCirBLrR5+w5dcJZ5Vd
Eh/VtkNyFD2zZjK35ktpbZoF0QkE6g==
=b/kL
-----END PGP SIGNATURE-----

--rpntxhfjssij74as--
