Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA867C8C46
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMR16 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjJMR15 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:27:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1BCF
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:27:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrLx3-00037R-Kb; Fri, 13 Oct 2023 19:27:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrLx1-001Rci-0T; Fri, 13 Oct 2023 19:27:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrLx0-00FiVh-NR; Fri, 13 Oct 2023 19:27:50 +0200
Date:   Fri, 13 Oct 2023 19:27:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct
 samsung_pwm_chip
Message-ID: <20231013172750.nxcw2ftihpemnymx@pengutronix.de>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
 <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aiysntojmlc5m3tt"
Content-Disposition: inline
In-Reply-To: <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aiysntojmlc5m3tt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 03:29:35PM +0200, Thierry Reding wrote:
> On Thu, 12 Oct 2023 23:02:29 +0200, Uwe Kleine-K=F6nig wrote:
> > Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver da=
ta")
>=20
> Applied, thanks!
>=20
> [1/1] pwm: samsung: Document new member .channel in struct samsung_pwm_ch=
ip
>       commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595

You might want to change 4c9548d24c0d to e3fe982b2e4e now that you
rewrote your for-next branch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aiysntojmlc5m3tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUpfhUACgkQj4D7WH0S
/k43Ogf9FP9SKehDlcdovaB/zlYentlI2IsKQ/VkXJruGE8qs0n0JJ/d8XtZZXaC
adrwFDdI71ZyH/Mt1aW6YDGQ8wTyf+3OpY29z+IZ+gxXApwboI+5gXivqwAJqyXL
Hytm5ehqZxb6PEB6HkPlinFUyPowv+LUZAmRWlvHegYBvYHc3uFAbW1V7yLM1fJu
6iyEv8bZ5y0yEGnRlRpI2mxMLy/23HQOwuPOb0xvIZ5UIymAP3QeCOk7vZBM8CTi
xFeF9rPDpXScnMMYBxBVGDTiP0iw5CKyqW1LXC8A7wj3tuGIHMGv/UIoqPr2zjxc
R7SqakxFwt2KO0f+S+KxrY8jb2tZig==
=MrFt
-----END PGP SIGNATURE-----

--aiysntojmlc5m3tt--
