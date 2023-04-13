Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71F6E1629
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDMUzz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMUzy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 16:55:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA01393CF
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 13:55:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn3yq-00027a-Bi; Thu, 13 Apr 2023 22:55:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn3yp-00B304-CK; Thu, 13 Apr 2023 22:55:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn3yo-00CyiP-FK; Thu, 13 Apr 2023 22:55:42 +0200
Date:   Thu, 13 Apr 2023 22:55:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Remove unused radix tree
Message-ID: <20230413205541.bqmtdfq7jbqtsm46@pengutronix.de>
References: <20230413122947.428134-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtqsw47zuksrsacs"
Content-Disposition: inline
In-Reply-To: <20230413122947.428134-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vtqsw47zuksrsacs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 02:29:47PM +0200, Thierry Reding wrote:
> The radix tree's only use was to map PWM channels to the global number
> space. With that number space gone, the radix tree is now unused, so it
> can simply be removed.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Assuming you put that on top of my patch removing pwm_request() and
pwm_free() (+ the fixes you mentioned in reply to it):

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vtqsw47zuksrsacs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ4bE0ACgkQj4D7WH0S
/k6m9Af/dbevFw5H5nq+CjKvJzDggFtwpE0rFqaYSR9GtSB+HLHhL/Uw9NA9fpNQ
ONEyl+Y8MPJUrH8+YDPImY7dogXwRfSaCh9ZivKRs8WxwTvGBKkDzefGemIHLtJy
5M4PYe2z3u59kH1PpmBtLjMAnHBpTI8+cO0G0AsEgu6RVZPzdeTCrZKGPiSo7v+o
tDs4eB7DzJKFBj15VgmHVMQsPQwAT5O9uvjLyj/5bAlJ55TKaBdPLYhnAYrB7LWj
BpMvSLi3Y3QN88Q45otYoZfh8j9coO//CQ+UfXUXHXysbxB9tuAJOv3MCM20E7km
ybSEKfy+G/wkLSjhiry3gwCM5ERVxw==
=Thbi
-----END PGP SIGNATURE-----

--vtqsw47zuksrsacs--
