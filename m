Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202F4047CB
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhIIJcw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhIIJcv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 05:32:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CDC061575
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 02:31:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGPB-000750-Qg; Thu, 09 Sep 2021 11:31:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGPA-0007e6-JK; Thu, 09 Sep 2021 11:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGPA-0005bW-Hw; Thu, 09 Sep 2021 11:31:36 +0200
Date:   Thu, 9 Sep 2021 11:31:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2] pwm: pwm-samsung: Trigger manual update when
 disabling PWM
Message-ID: <20210909093136.cusr6sg2tdo47k3z@pengutronix.de>
References: <20210908155901.18944-1-marten.lindahl@axis.com>
 <20210909080517.rsrohvdqqcnnjv2x@pengutronix.de>
 <20210909092409.GA11367@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plhyax55yky4vev7"
Content-Disposition: inline
In-Reply-To: <20210909092409.GA11367@axis.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--plhyax55yky4vev7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marten,

On Thu, Sep 09, 2021 at 11:24:10AM +0200, Marten Lindahl wrote:
> If I only move up the definition of __pwm_samsung_manual_update, and
> leave pwm_samsung_manual_update at its place, the patch becomes quite
> straightforward and overviewable. Or do you prefer to group the definitio=
ns
> of those two functions together?

No strong preference. I found it natural to keep
__pwm_samsung_manual_update and pwm_samsung_manual_update together, but
I wouldn't object your suggestion either.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--plhyax55yky4vev7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE51HUACgkQwfwUeK3K
7AlAYwf/T4qI6cVigxh83q2bgLMSFJPFmdWwsczNJiDzv+2uxkoMLuMcAAZKd8Wj
37IAqinZ1lIAdV9pWTs2PQrtoRLiGZo+Yl0TtH3Z3AvVdJLQ32WDvoSX2FdxTGIu
hJIU3O3J4WsblpHphtY1jE1sTUBfZQA5nHwdoTdolYabj4zSaojrJ2UICMAKAUsK
6zuCqNgI0n202gItwfhquuBfC/eq0GBOm4dxADt1yK8cNKcZf+9OHYXQ5Wvh3Tuc
g8yXLkU4TiEoS1462QiSGNKbXsqjldsXYqU9ZimOXmEgU2MZTBcHeBW/UYSZr86c
bpfpuZPuUbufCAJT2xDZfxA+4jqw3A==
=o7ZY
-----END PGP SIGNATURE-----

--plhyax55yky4vev7--
