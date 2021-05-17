Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99793823EF
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 08:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhEQGHs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 02:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhEQGHs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 May 2021 02:07:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97261C061573
        for <linux-pwm@vger.kernel.org>; Sun, 16 May 2021 23:06:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1liWOV-0003CW-Qv; Mon, 17 May 2021 08:06:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1liWOS-0007UL-CQ; Mon, 17 May 2021 08:06:20 +0200
Date:   Mon, 17 May 2021 08:06:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210517060615.3hyifoebyrddsrta@pengutronix.de>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jitc6yys25vbjviz"
Content-Disposition: inline
In-Reply-To: <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jitc6yys25vbjviz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Mon, May 17, 2021 at 02:53:44AM +0000, Billy Tsai wrote:
> =EF=BB=BFOn 2021/5/15, 11:57 PM,Uwe Kleine-K=C3=B6nigwrote:
>=20
> 	>	> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h,
> 	>	> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
> 	>	> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
>=20
> 	> As a division is an expensive operation you can better first multiply
> 	> NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 and divide by
> 	> the result.
>=20
> When I multiply NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1=
 the result will overflow
> for 32-bits and the divisor type of do_div is 32-bits so I need to do div=
 twice to avoid the issue.
> Can you give me some suggests?

Hmm, you're right. There doesn't seem to be a div64_64, I thought there
was one. Anyhow, while looking at the various divide functions I saw
that dividing by a constant shouldn't be that expensive, so I think the
sane way is to keep the two divisions and add a comment describing the
problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jitc6yys25vbjviz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCiB9UACgkQwfwUeK3K
7AkFCggAhYDJgJhK9vMuvxKsmyBpdGvk7Cxj1jfumQXEFfVFWnhAqzh6sTS0AaOO
1gCpneq8ySB1xnuFkOcwZtpc8i2n2Lc6jy6N+OVpWKHFepLkcmg3G3zXcFTTaxiG
mEYL7jm4TNEDGTmIG/6h2hLk/QVvB/PGTfUJLhaoINZctO0jWGZkTKy0iUxWOq5u
Zklk3UmeDm8TVp+/y5xQl4gz3LaY4PKugHY1CHSVt7aZR1eaVYEYyZDjEWCsI7Ri
PRx3BBp92Zt35aq9eQ6izuT6Bxaq+Mh2ole8uaiC1aeyVCN8xi5eZTFs4RuGDwSL
s9Xfz8SqBeNWtheP8Ft0bBVQPuj/Lg==
=kyG1
-----END PGP SIGNATURE-----

--jitc6yys25vbjviz--
