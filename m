Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95BF4111B2
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Sep 2021 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhITJNX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 05:13:23 -0400
Received: from www.zeus03.de ([194.117.254.33]:55210 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236597AbhITJLT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Sep 2021 05:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=5mI78+BHgh6VFMMJG0mi9Ba98u2z
        ND/SaUOq/k4m3XM=; b=vDJtvlbSiFggG/CNrIvGnH48Tgl6J96K0ikk6pbNF38t
        ZKPnp1GQKEySwIsmwnkt/jH2TiUTZTfzUz187USxvTsunEX161iKtqONYXH1dRxR
        4RrQk+N3diiXPcv+1FTwQlrWDDN+KpOoXqIW8qd5lGzqp4UibQIQQpknBhXfEA0=
Received: (qmail 2413987 invoked from network); 20 Sep 2021 11:08:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2021 11:08:52 +0200
X-UD-Smtp-Session: l3s3148p1@JLM9oWnMGosgAwDPXwlxANIWpbLKE1Uh
Date:   Mon, 20 Sep 2021 11:08:52 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: renesas-tpu: better errno for impossible rates
Message-ID: <YUhPpJc3ZjM8IYH4@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
 <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
 <20210917082543.2f5wum23nkvmzbdi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EQCBVrWDu+yYdQK4"
Content-Disposition: inline
In-Reply-To: <20210917082543.2f5wum23nkvmzbdi@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--EQCBVrWDu+yYdQK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uwe,

thank you for your detailed review, much appreciated! I will look into
your suggestions. However, it will probably not be before October
because it seems some more work and internal discussion is needed
beforehand. I'll get back to you.

Thanks again and happy hacking,

   Wolfram


--EQCBVrWDu+yYdQK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFIT6AACgkQFA3kzBSg
Kbb1XQ//YCRJeljcXqNSSAbQp9iylk+Eua3xMivTzm13sde5a2A+oKzD/gQNqQF+
O6bmoV9sqDXwDr7ChbPGzcmj3sf9vdDq9yKoavIt6+7Kw+szape7xcAUmVS53o7H
iKEl2mt0J28Y11Sy0KM+mXHRQ1MpzX0yO0Ey1IU6Iubi1SVTj+NcgZxDQ2AK5UhU
tYuW1YSKNHHoNkx4/bjr//HSa/bLLk1W7U82Ly34i6wI9Dpxo2Qg2eJpNo/hrB40
3Rj6U9CcgG07UhkcqAiYvwTyQCeQvn8ldjPfAFaZOReia4ek5UGnsr3Rn2922xiP
IdB+2NR09w1Lx53Mc7ilDr94l1ejvpA+FKOBHsLCflmD1ls/ejo2vTCKiUhIk+F3
7aWIGXPrxacV1iAAqB2pTNrv++gxInAkUmMywJN3gpxmeRDZ1ANFh7YbtM3bPiw2
XgF51HB9ZlbjkzGpIMB9kcgqmSZT357pRYiWGuys4kfxuGyg9gmMvagWmrxjQecG
/IlsChY1AlAStE9xcl+6/EbICbgov3xfNJ4I5AkJ96te9ktPvfcRDxnEJmp29nA0
C3RTPU2KuYIbgwvy9LG146Ftrz6PqwOBb9MzyQhW+WKi1BZG4U255IuPjOs8utkT
9aXo3k3Nx6vzc6MWX3eWAMWWh3YBZQfaOvrYqzqBvIGdtnr6IS0=
=zT9M
-----END PGP SIGNATURE-----

--EQCBVrWDu+yYdQK4--
