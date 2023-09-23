Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D37AC52A
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Sep 2023 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIWVF2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Sep 2023 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIWVF1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Sep 2023 17:05:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5511B
        for <linux-pwm@vger.kernel.org>; Sat, 23 Sep 2023 14:05:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qk9oU-0000JV-Q8; Sat, 23 Sep 2023 23:05:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qk9oT-008UTq-Od; Sat, 23 Sep 2023 23:05:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qk9oT-004F4d-FA; Sat, 23 Sep 2023 23:05:17 +0200
Date:   Sat, 23 Sep 2023 23:05:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 3/3] ARM: dts: mxs: Switch to #pwm-cells = <3>
Message-ID: <20230923210517.zbipvauk5jfmy3cc@pengutronix.de>
References: <20230922124229.359543-1-festevam@gmail.com>
 <20230922124229.359543-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zm6td2pbnnwho3ex"
Content-Disposition: inline
In-Reply-To: <20230922124229.359543-3-festevam@gmail.com>
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


--zm6td2pbnnwho3ex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabio,

On Fri, Sep 22, 2023 at 09:42:29AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> mxs-pwm.yaml documents that #pwm-cells should be 3.
>=20
> This is correct as the last cell may indicate the PWM polarity.
>=20
> Convert all mxs devicetree files to using #pwm-cells =3D <3> for
> consistency.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Very nice,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zm6td2pbnnwho3ex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUPUwwACgkQj4D7WH0S
/k70RQf+KK0J/5rruL7ki9dy+rFPYQ7jEf/niXOwLGktTba756QoOH/3FtFf+cma
zPOLHffLeHduug1DIIMrQonAz41qBlsYlQVZ20CK+ez4o6lH3fR2yp6PePdhOVW9
42Crp9xN0iD7vTsE3MWkpRa8UGFH54MfG3P/4g1iTxKpOl6QB6pBA3VBCbZm40JI
Jco5J61GTns88g3eKYTW8uzP1tsrmbHpKuqQ+woRbjZV2cFnHW6Dttti8ryo67U4
axd/FBTIlsllEAp1M1lCBOEiunEevmDXMVTnJNcCOe2ElQBbEH8TtFmxzmknf837
CWrFQ79d4SfFamyMCKIrdxWdCIthRw==
=55uq
-----END PGP SIGNATURE-----

--zm6td2pbnnwho3ex--
