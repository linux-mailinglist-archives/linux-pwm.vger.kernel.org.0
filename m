Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C834C7E97D7
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Nov 2023 09:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKMIfr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Nov 2023 03:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjKMIfq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Nov 2023 03:35:46 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3DA10F4
        for <linux-pwm@vger.kernel.org>; Mon, 13 Nov 2023 00:35:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2SQ1-0001TF-9F; Mon, 13 Nov 2023 09:35:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2SQ0-008gv4-Hx; Mon, 13 Nov 2023 09:35:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2SQ0-000a6L-8s; Mon, 13 Nov 2023 09:35:40 +0100
Date:   Mon, 13 Nov 2023 09:35:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] pwm: bcm-iproc: Simplify using devm functions
Message-ID: <20231113083540.lubs6foek2dabbpd@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
 <20230929161918.2410424-2-u.kleine-koenig@pengutronix.de>
 <29b654c4-010a-406f-bf47-8fbdb6a65d18@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x433e5fqog2ri4hz"
Content-Disposition: inline
In-Reply-To: <29b654c4-010a-406f-bf47-8fbdb6a65d18@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--x433e5fqog2ri4hz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Florian,

On Sun, Nov 12, 2023 at 08:11:15PM -0800, Florian Fainelli wrote:
> On 9/29/2023 9:19 AM, Uwe Kleine-K=F6nig wrote:
> > With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
> > dropped from the error path and the remove callback. With
> > devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
> > callback is empty and can go away, too.
> >=20
> > Also use dev_err_probe() for simplified (and improved) error reporting.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Unfortunately you're too late with your review, this patch is already in
v6.7-rc1 (as b498c14efd4241d79999b9bb943e963eb982450c). Ditto for the
other patches in this thread (with different commit ids obviously :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x433e5fqog2ri4hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVR39sACgkQj4D7WH0S
/k78wAf9HpR24DwmfLYxyysDB9HFUO4wWPTK4Flr5opq+vn3ky6GrXFJ/XTkhWX2
8SuQD6cjbf6hosUR8CejnWgVqzIzVfQsiB9CWHv3m0oSIM58sqYvjCk3M8jbFcZ1
1YPsIskO5MsN2I1WH7YPM8/06hqkw87jxwWVJpXEzSnu8QB3DvhWKbzNFQ0fD0RT
o7L/aYPJA1n2/0e+qyqiqei0UdSr+yYVLRDJMfOdW5QB/uUTu5E0o51+7PrvoZb8
zR0KQoBR19KHE37z9YQ/l1I6PyWeR57wBLXEMGBcyQ+71zH9lREjN0UF1wbzKtz4
B9FBUkD3EMbcjKPudRWvGcDxz2PWuw==
=g6iM
-----END PGP SIGNATURE-----

--x433e5fqog2ri4hz--
