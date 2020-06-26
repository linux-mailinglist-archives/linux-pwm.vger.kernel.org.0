Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973F20B5D5
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2020 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgFZQXn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jun 2020 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFZQXn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jun 2020 12:23:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A669CC03E97A
        for <linux-pwm@vger.kernel.org>; Fri, 26 Jun 2020 09:23:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jor8a-0004qp-H9; Fri, 26 Jun 2020 18:23:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jor8Z-0005kS-Jq; Fri, 26 Jun 2020 18:23:35 +0200
Date:   Fri, 26 Jun 2020 18:23:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
Message-ID: <20200626162335.ddfc23czvknblmqx@pengutronix.de>
References: <20200611194738.1480393-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcokhkvcs44oti6s"
Content-Disposition: inline
In-Reply-To: <20200611194738.1480393-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gcokhkvcs44oti6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 01:47:38PM -0600, Rob Herring wrote:
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.

Sounds reasonable,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gcokhkvcs44oti6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl72IQQACgkQwfwUeK3K
7AkkTAf+P/Ix8I1Qk1/xQYx03skU0vfyzMw0MExu5t68JfypxlbIJ5xAmxuc6iUC
85scAvE5q44rK35snt5WmCMjWf5F/afqu/ZOAY4XTp/M3Eb2S0vt9eMJ77myyRrQ
re3PzISpIlToIUpR1370R5KoQoSDcmKrUHE7vo8Op72CilADbLlitOOp0DVNl+kU
3q32VL9eUCLbSHTv528iAbzVr/OYNn1Hmq6jHVZBN3Y/kSY2ayep1jguHHtjv7Mi
WcnKEkNgtQMJTcNQuhIqmfXLjjlN3kBy8taEKkuGsobWq1E2yFQUiBboD1poMXXe
WlcAYJ4803KbT1JSUf/h1JAXT8Qbmw==
=laHj
-----END PGP SIGNATURE-----

--gcokhkvcs44oti6s--
