Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBEF445115
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 10:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhKDJan (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhKDJam (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 05:30:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC3C061714
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 02:28:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ2G-0001z0-3I; Thu, 04 Nov 2021 10:27:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ2D-0004vs-Gv; Thu, 04 Nov 2021 10:27:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ2D-0006bU-Fh; Thu, 04 Nov 2021 10:27:49 +0100
Date:   Thu, 4 Nov 2021 10:27:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/4] dt-bindings: mfd: qcom,tcsr: document ipq6018
 compatible
Message-ID: <20211104092749.g5o77cyutustnnxq@pengutronix.de>
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="axfpnblzfqfbqyz7"
Content-Disposition: inline
In-Reply-To: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--axfpnblzfqfbqyz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 02:46:24PM +0300, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt b/Docume=
ntation/devicetree/bindings/mfd/qcom,tcsr.txt
> index e90519d566a3..c5f4f0ddfcc3 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
> @@ -6,6 +6,7 @@ registers via syscon.
> =20
>  Required properties:
>  - compatible:	Should contain:
> +		"qcom,tcsr-ipq6018", "syscon", "simple-mfd" for IPQ6018
>  		"qcom,tcsr-ipq8064", "syscon" for IPQ8064
>  		"qcom,tcsr-apq8064", "syscon" for APQ8064
>  		"qcom,tcsr-msm8660", "syscon" for MSM8660

I wonder about why qcom,tcsr-ipq6018 should use simple-mfd, but the
others don't. Assuming there is a deeper reason, mentioning that in the
commit log (or depending on the reason maybe even in the binding?)
sounds sensible.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--axfpnblzfqfbqyz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGDp5IACgkQwfwUeK3K
7AlRiwgAnht5hNJHsev9Rk8E8Qo0hnqepiYdg85X6ffdIPRc4nHYDXRsUZzk4Lh0
kDiboeyCEtTPF7M5ZxrcZTPc7ImsYdv/kxzcY9M/odxSHCYuGEI3UuTLqMcU53Mx
ivoxb1jzA38DrMPX/Ux3nXiTVFJGsvykArpye+GibOmZtD5VYncGRF6TKQYOcWe1
Ab2Fnb7CM9Ev1/sWnG7GUHomADQkUe9P9XKRN1HN34MDxB6mWRG668SZaFbUiNwM
kOV4rZ1QjXESzK14qNZmLzHSOoKWrzoI3sk3Jbo3tlwDDqje53U2s2WTaSIVlc19
R17Y3Xf0XPKnmD1sY+jdtlvUz7hRjQ==
=2T9n
-----END PGP SIGNATURE-----

--axfpnblzfqfbqyz7--
