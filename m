Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8B6FA32E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEHJY6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEHJY5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 05:24:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67DD18DE6
        for <linux-pwm@vger.kernel.org>; Mon,  8 May 2023 02:24:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvx6x-0008En-MD; Mon, 08 May 2023 11:24:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvx6v-001xUH-66; Mon, 08 May 2023 11:24:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pvx6u-002NKQ-DI; Mon, 08 May 2023 11:24:48 +0200
Date:   Mon, 8 May 2023 11:24:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230508092448.6jzrh2lalh5v2ebi@pengutronix.de>
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922D142435F4755009E6F6D86719@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mzfwrudwncj43avy"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D142435F4755009E6F6D86719@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mzfwrudwncj43avy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 07:56:08AM +0000, Biju Das wrote:
> Hi Uwe,
>=20
> The dependency patch[1] hits on v6.4-rc1.
>=20
> So are you happy with this patch? or do you want me to rebase and resend =
the patch
> on Linux-pwm? Please let me know.
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?=
h=3Dv6.4-rc1

It's on my todo list, I intend to look into it during this week.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mzfwrudwncj43avy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRYv98ACgkQj4D7WH0S
/k49KQf/R3rIeAbC5LVjkJxl1kKes69uruHNdUXZNcCIhXOx50H7i2YFAPp2BY9Z
S7Dd1vfxlXZ1PHMCGBvnowcJs8NaGIz5jSS76raY7CXgKfuetWrF2nPNMvRQ/64X
w5aMXmnqspR9BQrg2lMJqmLb6qwmhJmXpo5DS/XEr6IOwE/QbjOvFGy22EDmTE97
hw65MbhX0QbjuMf7DWBNNRiIcRRRkX3y17PBwqVwS0grkRDIefcBnOHhXPztb1Qe
E6V5mhnN4wgOD1DLj3+rsCHlRXu/CuNeek6Itc0XUAiXmIVQBwr2VE5ZcaB6aU0S
4kbLQOjP7DzgKQJDUC+VkKbSrn+IQA==
=pzhf
-----END PGP SIGNATURE-----

--mzfwrudwncj43avy--
