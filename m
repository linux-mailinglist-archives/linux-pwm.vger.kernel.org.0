Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0170361DB2
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbhDPJpK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhDPJpJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 05:45:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45DC061574
        for <linux-pwm@vger.kernel.org>; Fri, 16 Apr 2021 02:44:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXL1c-0004Kv-Br; Fri, 16 Apr 2021 11:44:32 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXL1Y-0003fo-Dj; Fri, 16 Apr 2021 11:44:28 +0200
Date:   Fri, 16 Apr 2021 11:44:26 +0200
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
Message-ID: <20210416094426.x4gyw3drp2fcwczs@pengutronix.de>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
 <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
 <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t42vctr7z7mwa3qh"
Content-Disposition: inline
In-Reply-To: <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--t42vctr7z7mwa3qh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nobuhiro,

On Fri, Apr 16, 2021 at 05:07:21PM +0900, Nobuhiro Iwamatsu wrote:
> On Mon, Apr 12, 2021 at 09:02:32AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 12, 2021 at 11:55:36AM +0900, Nobuhiro Iwamatsu wrote:
> > > On Sat, Apr 10, 2021 at 03:53:21PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > Can you please put a paragraph analogous to the one in pwm-sifive i=
n the
> > > > same format. This simplified keeping an overview about the oddities=
 of
> > > > the various supported chips.
> > >=20
> > > OK, I will check pwm-sifive's, and add.
>=20
> I will add the following :
>=20
>  * Limitations:
>  * - PIPGM_PWMC is a 2-bit divider (00: 1, 01: 2, 10: 4, 11: 8) for the i=
nput
>  *   clock running at 1 MHz.

I would strip that to:

 - Fixed input clock running at 1 MHz

>  * - When the settings of the PWM are modified, the new values are shadow=
ed
>  *   in hardware until the PIPGM_PCSR register is written and the current=
ly
>  *   running period is completed. This way the hardware switches atomical=
ly
>  *   from the old setting to the new.
>  * - Disabling the hardware completes the currently running period and ke=
eps
>  *   the output at low level at all times.

This looks fine.
=20
> > For me the critical (and only) difference between "off" and
> > "duty cycle =3D 0" is that when a new configuration is to be applied. In
> > the "off" state a new period can (and should) start immediately, while
> > with "duty_cycle =3D 0" the rising edge should be delayed until the
> > currently running period is over.[1]
> >=20
> > So the thing to do here (IMHO) is:
> >=20
> > Iff with PIPGM_PCSR =3D 0 configuring a new setting (that is finalized
> > with writing a non-zero value to PIPGM_PCSR) completes the currently
> > running period, then always assume the PWM as enabled.
>=20
> Yes, this device works that way.

OK, then please use

	state->enabled =3D true

unconditionally in visconti_pwm_get_state().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t42vctr7z7mwa3qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB5XHYACgkQwfwUeK3K
7AnT3Qf/UxtGaRC2PkiqZqydmy5iwe/ufofn1G4HLEcTektGyzPwAuCYp21GNVm3
aBTM7yjUKzm9tI3oxD3wWuSdEAyBp9rwPmyk/376GB7ZHcd2noXSH0DM8d0cYjMg
l/vekoyFUOAPUMirdO4kdeukZeOU+Caskxd5y/UaZ+Gc9LI70ARXi6QnJbiL/4C2
ej53UHhf2JZqKYpdPRdkSLuULpJ8mrbQQG1RSP/6YylyGB5aA1X84cw3kwyg7R0o
LjccDhLne0qkSEi80EMCr3aW29sJjKMiMybOJkwyY62RdXHp1Cdd7c5BS1/+Bhnd
CeTfOmimMouYVue4qyJstkswR/gHbg==
=gYIm
-----END PGP SIGNATURE-----

--t42vctr7z7mwa3qh--
