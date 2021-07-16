Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57CF3CB5CE
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhGPKQO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jul 2021 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhGPKQM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Jul 2021 06:16:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199E7C06175F
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jul 2021 03:13:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4KqA-0001KF-3V; Fri, 16 Jul 2021 12:13:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4Kq5-0000E2-I2; Fri, 16 Jul 2021 12:13:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4Kq5-0000Wa-GI; Fri, 16 Jul 2021 12:13:01 +0200
Date:   Fri, 16 Jul 2021 12:13:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o6m277jeq5onsbp7"
Content-Disposition: inline
In-Reply-To: <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o6m277jeq5onsbp7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Fri, Jul 16, 2021 at 09:22:22AM +0000, Billy Tsai wrote:
> On 2021/7/16, 3:10 PM, "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.=
de> wrote:
>=20
>     On Fri, Jul 16, 2021 at 01:48:20AM +0000, Billy Tsai wrote:
>     >> On 2021/7/15, 11:06 PM, "Uwe Kleine-K=F6nig" <u.kleine-koenig@peng=
utronix.de>> wrote:
>     >>     > Another is: The PWM doesn't support duty_cycle 0, on such a =
request the
>     >>     > PWM is disabled which results in a constant inactive level.
>     >>=20
>     >>     > (This is correct, is it? Or does it yield a constant 0 level=
?)
>     >>=20
>     >> Our pwm can support duty_cycle 0 by unset CLK_ENABLE.
>=20
>     > This has a slightly different semantic though. Some consumer might
>     > expect that the following sequence:
>=20
>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle =3D 10000, .enabl=
ed =3D true })
>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle =3D 0, .enabled =
=3D true })
>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle =3D 10000, .enabl=
ed =3D true })
>=20
>     > results in the output being low for an integer multiple of 10 =B5s.=
 This
>     > isn't given with setting CLK_ENABLE to zero, is it? (I didn't reche=
ck,
>     > if the PWM doesn't complete periods on reconfiguration this doesn't
>     > matter much though.)
> Thanks for the explanation.
> Our hardware actually can only support duty from 1/256 to 256/256.
> For this situation I can do possible solution:
> We can though change polarity to meet this requirement. Inverse the pin a=
nd use
> duty_cycle 100.=20
> But I think this is not a good solution for this problem right?

If this doesn't result in more glitches that would be fine for me.
(Assuming it is documented good enough in the code to be
understandable.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o6m277jeq5onsbp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDxW6kACgkQwfwUeK3K
7AnuOQf/cdtxnx5ap7eAcXsCJxd1wMM4sHbrRR3Kx2nE9MwAuU44x7P3khR9XSzv
3S2xsnfWdrdxNQY/DOAfuSuCTgZ92BwzHt22OV8tPACYJOKgatgJtupBIBge0Bmh
16uJgAJa8UYl5xYgXwWumLgKR7btLaZRGTg63nyvXfYYyQPo4n5Hej7fE+o2cjBE
jpDMoOQCu4dYgaBZXqhhLZDMv7jtfeHeHn71lggEr5PB+xhNBMRKXIcQFqODAnIQ
U6u0zGwi696702Zh5iavfwOCTO+NfMUmNBKqNoYn9pDmcclvXh84PDCHHKIj9KII
ZlB10IqeSbWdPwhTSWbzqrtcafFLuQ==
=Nk6o
-----END PGP SIGNATURE-----

--o6m277jeq5onsbp7--
