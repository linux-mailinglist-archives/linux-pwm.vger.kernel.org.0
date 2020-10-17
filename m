Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A612914AF
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Oct 2020 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439291AbgJQVRA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Oct 2020 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439244AbgJQVQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Oct 2020 17:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050BC061755
        for <linux-pwm@vger.kernel.org>; Sat, 17 Oct 2020 14:16:56 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTtZ5-0006Fj-TO; Sat, 17 Oct 2020 23:16:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTtZ4-0004pP-RR; Sat, 17 Oct 2020 23:16:34 +0200
Date:   Sat, 17 Oct 2020 23:16:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, lee.jones@linaro.org, thierry.reding@gmail.com
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add MT8167 SoC binding
Message-ID: <20201017211632.ufgcsmjhbdmcj7hr@pengutronix.de>
References: <20201016185015.3371433-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkesq5stxul6y32h"
Content-Disposition: inline
In-Reply-To: <20201016185015.3371433-1-fparent@baylibre.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dkesq5stxul6y32h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 08:50:15PM +0200, Fabien Parent wrote:
> Add binding for MT8167 SoC. The IP is compatible with MT8173.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> index 0521957c253f..902b271891ae 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible: should be "mediatek,<name>-disp-pwm":
>     - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
>     - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
> +   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt=
8167 SoC.
>     - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.yaml in this directory for a descripti=
on of

LGTM:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dkesq5stxul6y32h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+LXy0ACgkQwfwUeK3K
7AkGVQf/W23j54YXyBoJHOo0UT7KjtVUZs7RlAf41JjeatSLPQ2AFfeInknaMEkX
rGoUteV8Dj36mb5SWUJhGN4tmBUGX7e5u/XRhkHRjuJeA41MThhw16ubjIPBxXks
GiB0mtz69sFQp5T9w7Nyz4iI6qCEvP2GOuNisELgRJXAECob6gX33RYFhvJZK1Gg
v/hR0xjoblqnJ15jKKoUiuw75Qbtj7Bj9ei+6ypNRTu/zYRSSUsrXaYX6gcYr0Ar
ZAPLhiaOKv9utkDGnrvcV97qHRQxkoSBOLljtx3EikgkRkIC4uoT3T7oQuaV9fvG
kE00SKEPLcxAeOj8mGGn6mSkloQxGQ==
=DF3E
-----END PGP SIGNATURE-----

--dkesq5stxul6y32h--
