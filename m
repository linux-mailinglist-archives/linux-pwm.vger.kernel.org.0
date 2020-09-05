Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1825E915
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIEQm5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIEQm4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Sep 2020 12:42:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5431DC061244
        for <linux-pwm@vger.kernel.org>; Sat,  5 Sep 2020 09:42:56 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEbHA-000352-Ow; Sat, 05 Sep 2020 18:42:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEbH7-00082T-8g; Sat, 05 Sep 2020 18:42:49 +0200
Date:   Sat, 5 Sep 2020 18:42:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, kernel@axis.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, oliver@schinagl.nl
Subject: Re: [PATCH v2 0/2] GPIO PWM driver
Message-ID: <20200905164249.5vy23gizpwstbs5c@pengutronix.de>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p74bra2ilrxvtnn5"
Content-Disposition: inline
In-Reply-To: <20200902121236.20514-1-vincent.whitchurch@axis.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p74bra2ilrxvtnn5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vincent,

On Wed, Sep 02, 2020 at 02:12:34PM +0200, Vincent Whitchurch wrote:
> v2:
>  - [..]
>  - Stop PWM before unregister

I didn't take the time yet to look at v2, but just spotted this which is
wrong. .remove() is not supposed to modify the output. (If the PWM is
still running in .remove() this is either because it was running at
bootup and was never modified or is a bug in the consumer code.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p74bra2ilrxvtnn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9TwAYACgkQwfwUeK3K
7AkSEAf/ZbYnLOLryZ7z7mnXU755+BxYQTl0h+xZqlEvQz9jALh+B5Ygb/zBKFuo
cFSmSLeWSZg+TiBlar4GbF3yCZNZUaOvJ46WIdvM/jBHb6yyFL/iVOTskaQstU1R
fhH4aC/pTr/d4uaD3hbDqHKhlW49Bl78bufQneeLdUqcpYRcTgRa2w4KylgY/MmX
c37IjX6LKJsY/hjD70qpAta9BS9AwzebPiAqyv9SLMlp5iO5fizIE1XJiaLjzxrx
4CCW1Du15+o39QkS7u0FbtLj9zlLq8K/CfEM0REy4pQePcT/OnxV4BW9zwaSmgGh
FQqZuOkT+WrS4pk0/pqwYFWwhqZ9VQ==
=sSDB
-----END PGP SIGNATURE-----

--p74bra2ilrxvtnn5--
