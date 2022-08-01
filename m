Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A96587362
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Aug 2022 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHAVbN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Aug 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiHAVaf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Aug 2022 17:30:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2129CBB
        for <linux-pwm@vger.kernel.org>; Mon,  1 Aug 2022 14:29:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIcyW-0001FQ-SF; Mon, 01 Aug 2022 23:29:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIcyU-001BuT-UV; Mon, 01 Aug 2022 23:29:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIcyU-008zuW-6X; Mon, 01 Aug 2022 23:29:18 +0200
Date:   Mon, 1 Aug 2022 23:29:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220801212916.kzs47wj3idvnaggz@pengutronix.de>
References: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
 <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
 <20220731145107.iepktigt4g63ranr@pengutronix.de>
 <OS0PR01MB59228AB5226BD45C6E8C5B70869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zywnslsdlpypitel"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59228AB5226BD45C6E8C5B70869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--zywnslsdlpypitel
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 01, 2022 at 07:24:06PM +0000, Biju Das wrote:
> > On Thu, Jul 28, 2022 at 05:25:26PM +0100, Biju Das wrote:
> > > +
> > > +	if (pc->pwm_enabled_by_bootloader)
> > > +		clk_disable(pc->clk);
> >=20
> > When this function is called as part of remove, not disabling the clk is
> > wrong, isn't it?
>=20
> I will remove pwm_enabled_by_bootloader variable and=20
> use the below changes, so it is taken care for the bootloader case.
>=20
> +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader enabled PWM and
> +	 *  is running during probe().
> +	 */
> +	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);

devm_clk_put looks wrong here. You only want to disable, not put?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zywnslsdlpypitel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLoRaoACgkQwfwUeK3K
7Am/zAf/Tuqirnrd++1udp/mkEgTAqCoZ8NL/NWKOuU0ogBB7r7X73ZdpZ99MVFZ
BVYpXr+4RDjwwtlGA00eCbfRdTyH5FG69lOpv60Auo5lEqr4Y5VykxZRrgw4X5pj
Y7NoXMePLIGoyIEJyMN80HVnULsEMkaUAoocga68scka29q339g2sxtUtPAUn8Vr
Kik4ydNKAdKr16lmW6eOUs2VuLonbWon9cYLIlLN5xWIkmXWFS5Syj+BEd046Ysq
hAiy7narkrj5SXIuzQzFNCcs+FO2bAjzXm/qnzCyUEk1RdDkAC32oJhMAcJyeaa2
bLkfm1mpdzxDyB/8bogYw4WuaOALww==
=l9pg
-----END PGP SIGNATURE-----

--zywnslsdlpypitel--
