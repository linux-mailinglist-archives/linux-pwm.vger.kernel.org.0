Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3D363A289
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiK1INq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiK1INp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:13:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A510B59
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 00:13:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZGp-0003xp-1a; Mon, 28 Nov 2022 09:13:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZGn-000mN3-Kl; Mon, 28 Nov 2022 09:13:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZGn-000sLA-Gd; Mon, 28 Nov 2022 09:13:41 +0100
Date:   Mon, 28 Nov 2022 09:13:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] pwm: pxa: Add reference manual link and
 limitations
Message-ID: <20221128081341.jicinkwifnsvydta@pengutronix.de>
References: <20221113233639.24244-1-doug@schmorgal.com>
 <20221113233639.24244-6-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfi4qqsxewwjdydi"
Content-Disposition: inline
In-Reply-To: <20221113233639.24244-6-doug@schmorgal.com>
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


--sfi4qqsxewwjdydi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 03:36:38PM -0800, Doug Brown wrote:
> Add a pointer to the location of reference manuals for some of the
> supported chips, and add a limitations section explaining the hardware's
> PWM disable behavior.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sfi4qqsxewwjdydi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEbbIACgkQwfwUeK3K
7An1zgf/QDs82eO4GGZ54mdvTH2b9BBMu6MvFKoCr1uAbYJeMj5GBLjJTQ5gE3YC
3Waj2hFhgXOXeyw0tVPUTbF4BzXfYB4UwK8ropkWjsGcMqwffhtWB/dyRuUAWfKq
FPMjeavIaVyFG+VY+K8aSXOc4Sa5YO5I8HVmd9Ux13q0vfnY4q7GopepSkvOgjfn
LuNk8zIVZ6SnG2Ky4Y2LfRicGZwCeVfGc+Lu+sYAM4MNbVDqKIGdY+Eof+COK8xo
/Cbq65jW5m4Ztp1gHCQYTf/ibMJpaip9pq5vUVw5eIfq9R3TXwSouvG2CI8WoMxL
xy7K7lRTGCNsrOESe6EiQyDYacZT7Q==
=6t0a
-----END PGP SIGNATURE-----

--sfi4qqsxewwjdydi--
