Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F36CAC3B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC0Rue (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjC0Rud (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 13:50:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C51B0
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 10:50:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pgqzE-0004eo-Tc; Mon, 27 Mar 2023 19:50:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pgqzE-00784z-6k; Mon, 27 Mar 2023 19:50:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pgqzD-008U17-I6; Mon, 27 Mar 2023 19:50:27 +0200
Date:   Mon, 27 Mar 2023 19:50:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     neil.armstrong@linaro.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
Message-ID: <20230327175027.z7as4fybzgx7zhuq@pengutronix.de>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <3492657f-6cc2-5828-b153-30c609a92783@linaro.org>
 <45dbd1d4-a2b8-af33-beec-64906c0e98da@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huvgnjolgdavutr5"
Content-Disposition: inline
In-Reply-To: <45dbd1d4-a2b8-af33-beec-64906c0e98da@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--huvgnjolgdavutr5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 07:00:35PM +0200, Heiner Kallweit wrote:
> The best (for achieving best precision) input frequency is 0xffff / perio=
d.
> So we should do our best to come as close as possible to this frequency.
> By using set_rate() CCF will choose the optimal mux input and divider val=
ue.

Just for the record: Here might be a misconception. There is (AFAIK) no
reason to believe that set_rate would pick an optimal configuration. And
if it's only because there is no objective definition of "optimal". For
example if a driver for an SD card requests 400MHz, it might not want
anything faster and so probably prefers 202 MHz over 404 MHz. However a
driver for a UART would prefer the 404 MHz in this case. IMHO we'd need
something like

	clk_rounddown_rate();
	clk_roundnear_rate(); and maybe
	clk_roundup_rate()

to please all drivers. But that sounds like a bigger quest.

If your clk can provide (say) 1000000 Hz and 2000000 Hz (and nothing in
between) there is no rule in the CCF that tells you which of the two to
pick if you request 1000001 Hz or 1999999 Hz. (The only thing I would
not expect is that you get 1000000 Hz when requesting 1999999 Hz *and*
2000000 Hz when requesting 1000001 Hz.)

> Not sure why we should restrict ourselves to one mux parent only.
> E.g. for a very low duty cycle a higher input frequency than the xtal 24M=
Hz may be preferable.
>=20
> Not only the mux is outside the PWM block now, also the divider (8 bit wi=
de instead of 7 bit
> as of today). So we need a set_rate() anyway to set the divider value.
> What I can't say is whether the internal divider still exists (then exter=
nal and internal
> divider would be cascaded) or is removed or bypassed.
> It seems like when adding the external PWM clock feature Amlogic forgot t=
o update
> the PWM block documentation, as there's no reference at all to the now ex=
ternal input clock
> (except in the clocks section).

It would be great to test (or ask?) if the internal divider still exists
and do the right thing then.

Having said that, I wonder if it would make sense to rework the driver
for the variants with the internal mux to also abstract the divider as a
proper clk.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--huvgnjolgdavutr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQh12IACgkQj4D7WH0S
/k7dfQgAlnaiAkNwkPxwgjl/k4+yZxnZmqiyapOuZKo+ZYdcnuQXQlB1ATM+alHH
o6ARlXoCoPV5bNp3WANuHMiEV4fr5UKo7llV+xMnpMyOjsh0/pbq7ksb9K7939tH
qzVYX56DiZkEPthhx87oyJw8Kup3if3iyIGEc9ljx7Zvip53ltW0m2U340VQm1Fy
QuQl1oa6nO8JZcWi1VMA5GS+3eEoQpNwaXXhDRoOToVsrZYaiId33wKtq0tS+vFx
gaG6B+Fs9SpFJ2GG+NaV5zyRkJSFzvg+WFukb3l620G2jecDk+CZKta6db4UA9dJ
0466t/bitcphfNS9YXfTG+bRArWVaA==
=+kg4
-----END PGP SIGNATURE-----

--huvgnjolgdavutr5--
