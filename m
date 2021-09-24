Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B0416BAB
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Sep 2021 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbhIXGoh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Sep 2021 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbhIXGoh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Sep 2021 02:44:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B8C061574
        for <linux-pwm@vger.kernel.org>; Thu, 23 Sep 2021 23:43:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mTevD-0005eP-N3; Fri, 24 Sep 2021 08:42:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mTev9-000080-To; Fri, 24 Sep 2021 08:42:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mTev9-0007Ge-Sh; Fri, 24 Sep 2021 08:42:55 +0200
Date:   Fri, 24 Sep 2021 08:42:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>
Subject: Re: [PATCH v7 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210924064243.dmgqqqwnwvoq5iyc@pengutronix.de>
References: <20210916180544.2873770-1-sean.anderson@seco.com>
 <20210916180544.2873770-3-sean.anderson@seco.com>
 <8580895f-0503-17ca-c6e4-54d91dd8f26a@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="litrs7yfwkz3actg"
Content-Disposition: inline
In-Reply-To: <8580895f-0503-17ca-c6e4-54d91dd8f26a@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--litrs7yfwkz3actg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2021 at 07:36:32PM -0400, Sean Anderson wrote:
> I see that in patchwork this patch is marked as "Changes Requested" [1].
> However, I have not received any feedback regarding the changes I need
> to make. Please let me know if I have missed anything.

I agree, this must be an error. I marked it as new again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--litrs7yfwkz3actg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFNc18ACgkQwfwUeK3K
7AnqqAf/feP0bjX6ZGplI64kvz9SIq5DtZguwZ10jvT8yTxS2YyQRAYhzs68mmoV
OFO/lHq725pUsqfy/+SDi45fvJ6v4MeWlQ+l6QwNAl4EPVqk6F57MIky8rqADnqd
JR9iAu/k1yDjW9kO91GfN2k+qGT1AfBupdDNh//amVSmYMfJOYeEnWqvHewI7zR4
U/4eSE+2nfH2uRy/3dNkuZ9UliTA16yhlRpgLrDhqFj026oFV4yHt8l5Ti/rdMGc
MhRWouJyIlRPQk6AqM32wedbno0jBMXo0M52K1gAIfLeS8hFkuIR+Km3kCXVuGDd
VuoSdanNmUhQ8J7Hgn+pvtd+lXI+uA==
=AUmD
-----END PGP SIGNATURE-----

--litrs7yfwkz3actg--
