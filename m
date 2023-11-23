Return-Path: <linux-pwm+bounces-177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBA7F6564
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32BA1C20DE2
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5C1F176;
	Thu, 23 Nov 2023 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDD93
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 09:28:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DV3-0006fo-MD; Thu, 23 Nov 2023 18:28:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DV1-00B5Zc-Nb; Thu, 23 Nov 2023 18:28:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6DV1-006qI9-E4; Thu, 23 Nov 2023 18:28:23 +0100
Date: Thu, 23 Nov 2023 18:28:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <mwalle@kernel.org>, Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Xinlei Lee <xinlei.lee@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Message-ID: <20231123172823.4offrr7w4tsrhl4y@pengutronix.de>
References: <20231123134716.2033769-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2xwjnd6lnhuiwuu"
Content-Disposition: inline
In-Reply-To: <20231123134716.2033769-1-mwalle@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--f2xwjnd6lnhuiwuu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:47:16PM +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
>=20
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] sa=
id:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply=
 to
>     RCPT TO command)
>=20
> Remove it.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml=
 b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 153e146df7d4..afcdeed4e88a 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -8,7 +8,6 @@ title: MediaTek DISP_PWM Controller
> =20
>  maintainers:
>    - Jitao Shi <jitao.shi@mediatek.com>
> -  - Xinlei Lee <xinlei.lee@mediatek.com>

Xinlei is also listed as maintainer in
Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml.

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

because the address failed for me before, too.

A confirmation by Jitao Shi would be nice ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f2xwjnd6lnhuiwuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfi7YACgkQj4D7WH0S
/k5yMwf+IRIOP4q0ZLwdNez1e51AqVrao/6E0dqPhU7Cq9ka5Y8zr4Xx9wW3jz2d
QPab0hcPzDgVd64whCgXEbclBDZOKPaURAWxWxprmyt2g4cAtuT4BfSlJ6bgG0Fd
GJu9xpHiwJDPFaheBWM25hBmwYTie/j+ARN0OY+O9feJDUl3df06YJ1+s1M7euB2
IGpslcBOi1TRE83Ll9y6nyUMTHYEyq5ZnIgm7zT2SoAjvmsI5qcE3SmiNJJsig07
nl5nLTnjWfDYGfqKDixCOOokSSqW50Y42b5uX+iCxEMKmHtjKRhLrYbKkAvJVoYo
/Wl2zfP2UdZo4ZP6rHVTRel63p12lg==
=d7mx
-----END PGP SIGNATURE-----

--f2xwjnd6lnhuiwuu--

