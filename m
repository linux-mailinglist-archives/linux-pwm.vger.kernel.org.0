Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4035AFBB
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhDJSwy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhDJSwy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 14:52:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC2C06138B
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 11:52:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVIiX-0007yN-2k; Sat, 10 Apr 2021 20:52:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVIiU-0007JE-6g; Sat, 10 Apr 2021 20:52:22 +0200
Date:   Sat, 10 Apr 2021 20:52:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210410185222.4tfpgm2hcka26e6g@pengutronix.de>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fahlkkulnmz2naui"
Content-Disposition: inline
In-Reply-To: <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fahlkkulnmz2naui
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

one more comment:

On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_chip=
 *chip)

all functions but this one start have the common prefix "visconti_pwm_".
I like the concept of a common prefix and so you could rename this
function to visconti_pwm_from_chip or similar.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fahlkkulnmz2naui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBx8+IACgkQwfwUeK3K
7Ak7gQf9HBeqidP4ZBFq3cdE0CKBXmwUW4sbkRbVmfGiXkxxB2KLmLil0nuk+hiP
rUWJtqRO4E5nt7DUe+s0zLC9dDQAiUHwRkDmx8ZUrMSQAXjvdlwxtO/cT40MkG+N
CFxLPGM8XxvnA75X0PGiBK3ecYL1+jTX2bhwGICZfF1G6bxRC/24v7+DcjhEVjtC
Mdg/+aRCqh3zL8zel/2FYXOrt2S9pJJFnFVCZTFVZEqfbX7nmdhgWIwY1oL7IGB8
QYzkfsUsGgZ8SY9/GQpWzpL+VinIkOLb5QMX4ZNVtftbm5dUwJJjtuJcopg3iOIX
fGVmqJS8M1DufMeNBAhDkMeW2gLMDQ==
=+J1z
-----END PGP SIGNATURE-----

--fahlkkulnmz2naui--
