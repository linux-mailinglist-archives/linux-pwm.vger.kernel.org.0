Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309F63A283
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiK1IMl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiK1IMi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:12:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E58B59
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 00:12:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZFi-0003tM-8d; Mon, 28 Nov 2022 09:12:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZFg-000mMj-S5; Mon, 28 Nov 2022 09:12:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZFg-000sL2-T6; Mon, 28 Nov 2022 09:12:32 +0100
Date:   Mon, 28 Nov 2022 09:12:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] pwm: pxa: Use abrupt shutdown mode
Message-ID: <20221128081232.wodipa4wyodlvomk@pengutronix.de>
References: <20221113233639.24244-1-doug@schmorgal.com>
 <20221113233639.24244-5-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lh5kow4hjsrsmag7"
Content-Disposition: inline
In-Reply-To: <20221113233639.24244-5-doug@schmorgal.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lh5kow4hjsrsmag7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 03:36:37PM -0800, Doug Brown wrote:
> Switch to abrupt shutdown mode in order to stop the clock as soon as
> possible when PWM is disabled. This minimizes the possibility of the
> clock being re-enabled while it is still in the process of turning off,
> which will result in the clock ending up erroneously disabled.
>=20
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lh5kow4hjsrsmag7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEbW0ACgkQwfwUeK3K
7AkFfgf+L2jfGM4JcrrvxsIXmoCyuGY+cF/mkkOtXGRxRckQHqNNP4mU3kjwbq8W
G2QJv1i4LnxTU2JniRNgGn2dtkG2gGHAWc3OptC+SUbUsae4iLyicLDnqPFQhhSc
ICxLnGkUfvDgwJjlVYbkvKGy0NhQRp2nnz4AlAFgdnm2g74Z8ldT50D3Rmd1FMZc
fLBgwodKG0w4RWdGydGKzNETxidPg4wbIllhBL7qWkn69vxlke4hJ8jKZFDHO7ob
w8s6pjeAIhrFmRp+jFpiiteybvCEd5LGK1aTtIR5PUcHnUhaZ2AqVb7FUAwFHJKl
0aGDRdSChmY2xVR5uYfif71ot/ks6Q==
=BsEt
-----END PGP SIGNATURE-----

--lh5kow4hjsrsmag7--
