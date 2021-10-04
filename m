Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D688420671
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJDHKk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Oct 2021 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJDHKj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Oct 2021 03:10:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA0AC061745
        for <linux-pwm@vger.kernel.org>; Mon,  4 Oct 2021 00:08:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXI5P-00049J-Ll; Mon, 04 Oct 2021 09:08:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXI5K-0007tv-Nw; Mon, 04 Oct 2021 09:08:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXI5K-0007Hj-Mf; Mon, 04 Oct 2021 09:08:26 +0200
Date:   Mon, 4 Oct 2021 09:08:26 +0200
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
Subject: Re: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20211004070826.on5tg42dvjh7bayt@pengutronix.de>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
 <012AEBBE-9FFC-48B5-8794-00A577C3C87A@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5t4m3yzkgi5tqy6e"
Content-Disposition: inline
In-Reply-To: <012AEBBE-9FFC-48B5-8794-00A577C3C87A@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5t4m3yzkgi5tqy6e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Mon, Oct 04, 2021 at 02:54:00AM +0000, Billy Tsai wrote:
> Does anyone have any comments about this patch?

It's on my list of todos, the problem is there are so many thing on that
list. I'll try to review your patch set this week.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5t4m3yzkgi5tqy6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFaqGcACgkQwfwUeK3K
7AnGAgf9G336UWwO/gwlaZ/cj2wpcF8RfEe28nz+ZdOLKOTExHGoTFA/i4jisAN3
QCtLRrKdUQb+133ZMFwKdfUH+MVgtDC2TyScXhsHH9x8/8flyZTkP1fxeQp4u3Qw
MJIF2oiz18CGU01qck3evudKGeWKiD9yHl2TbvCT+dlcSIIGpleviEyynnOB7OKi
sMNE7wJcz8i+EYiB7N0NxdTIWhix17lE3QSYyy9yBRrfUpmT8QEj15mUxuAzsI+x
EZHk9bv43TRShMy6QFNfwcqdC5L6mSKFKgwSSJmYGQSunmzcRxpZLM9upJy3Jj/Z
Y6+cqlD/ohXtKbi9Znc4XYXPg0ug3A==
=lJ1t
-----END PGP SIGNATURE-----

--5t4m3yzkgi5tqy6e--
