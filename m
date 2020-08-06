Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9B23E111
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHFSkJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgHFSkJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 14:40:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4BC061574
        for <linux-pwm@vger.kernel.org>; Thu,  6 Aug 2020 11:40:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3ko2-0004cr-1P; Thu, 06 Aug 2020 20:39:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3knz-0007gi-5v; Thu, 06 Aug 2020 20:39:55 +0200
Date:   Thu, 6 Aug 2020 20:39:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742
 support
Message-ID: <20200806183955.lmlwhsdrcpccwrkz@pengutronix.de>
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wi7zgoow7wajiuwc"
Content-Disposition: inline
In-Reply-To: <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wi7zgoow7wajiuwc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 06, 2020 at 07:31:49PM +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renes=
as.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml =
b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> index daadde9ff9c4..8b22cb110f3f 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,pwm-r8a7742   # RZ/G1H
>            - renesas,pwm-r8a7743   # RZ/G1M
>            - renesas,pwm-r8a7744   # RZ/G1N
>            - renesas,pwm-r8a7745   # RZ/G1E

The typical dts has:

	compatible =3D "renesas,pwm-r8a7742", "renesas,pwm-rcar";

so there is no need for a driver adaption.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wi7zgoow7wajiuwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8sTngACgkQwfwUeK3K
7Ang/gf/VQ5o3nYBkW7YrJzYGx7rsiH9B/HWrwbVgpjOwQfNc1yCEfg1liZYHDFm
feEMs3dkCO93YHZjdKGKeqIiXxdbHdEY94Cgmk8am1Ml9+koA79tHUD+UblJ9U28
T9zl88KmyjU5BImc1AJSAvVRoMO6BopXbbqCKAh+PYrpspxLSHyQeEZHssl4FxXK
ZRKfnjC3bJr0xas7F2EQ9lukFqr5wdQN+kJpkv1LIf1eDDKvimdOuCLW2710ES4O
brIMcPs5PyJha1hcV2qVk1/5LXWlSilL2QB3mUhThWX7KtlGIlQj4DJFll/nlqyi
SKrDlmoOl9sXyzrAAuj7K/VAz3pOZA==
=8duc
-----END PGP SIGNATURE-----

--wi7zgoow7wajiuwc--
