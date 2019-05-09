Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3385218CDA
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIPV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 11:21:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIPV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 11:21:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id g26so1859853wmh.2
        for <linux-pwm@vger.kernel.org>; Thu, 09 May 2019 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZySuPq5onaYQO2KgEfuAMvlMi+Yc164eWUpmYo2RZ9M=;
        b=HV3HpN1kgEr72jUO0U+9H3wiCX4IH9mjTYRdZyGwznT4UVPZWjtCQfY9EUE4HH3xj6
         n8Yggqa1MJ35Tf7RmpKzFTzkmXlp7BGiLV84amqjEbk6ZefovCKDv9QuwElgUV+6Q6DQ
         eI/ZSnJkFKJPpbqjftgC1Jkcu4AuAZaLXVRPUUqUXGOSCQaZf6oxqs0VmG97XMIWfjY3
         HV3Mw7mB9tEmbDOT2LbGPwHmcYPqleAAxT8UbavbuPUOc9KnmUiKGNG9VETWJ8Ew93MA
         HPpB3BFl55tgkV1/gLAEdnadDFOYAi1UJ1Eb9dhQNKriz/jbwdXfjTPpn38lju/IJhIM
         6Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZySuPq5onaYQO2KgEfuAMvlMi+Yc164eWUpmYo2RZ9M=;
        b=E1yeUC3U7t6WP42ZRcDxnJSVsU7WlgqX5Ddwsa0FtEAjUVLBNgbrjJljLJiGDfSnd0
         I4ADlUxXcWZ+EEVCEMUbisCsCs8yw+8k/kviperpiwRCbsOxrDYaH/DOBWTiX4DL8sLz
         HzBrY0Xr9wn2A1QwrS9jkTOGez3AnDDq0iUpkb1+emc5k07gf9aqTd7VtF8oZLJks9hK
         3hxewwpwg23cuRYjSghKeyeDsAjT/Zd0MWPE+hk/2OW1VryO7a8cZ510W0LiVU6SbTGo
         38Uz1+Fr1dEn8hbfBVFlhb6jueJd1im91BbTwrkbrIs3A79DDi2/LGHmvP+ybl4ZdFbT
         4CUA==
X-Gm-Message-State: APjAAAWNvopP0CSmZz4cVXH64OFuZI6fLVZMfwnpjW4ovDblckouRhI8
        igkwY9FFrR3s01rFzCvvxw8=
X-Google-Smtp-Source: APXvYqzoRiyuj3ZYv+/FYkCxceowcdV3EbRfF41kW5XPppf2h/w6xJpboSoUqDm/eROt2BjPppx37Q==
X-Received: by 2002:a05:600c:2506:: with SMTP id d6mr3540717wma.106.1557415284660;
        Thu, 09 May 2019 08:21:24 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i18sm3629422wro.36.2019.05.09.08.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:21:23 -0700 (PDT)
Date:   Thu, 9 May 2019 17:21:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: clear chip_data in pwm_put
Message-ID: <20190509152122.GE8907@ulmo>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="684cmtc/Pyvt2LSS"
Content-Disposition: inline
In-Reply-To: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--684cmtc/Pyvt2LSS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 10:49:33AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> After a PWM is disposed by its user the per chip data becomes invalid.
> Clear the data in common code instead of the device drivers to get
> consistent behaviour. Before this patch only three of nine drivers cleaned
> up here.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c        | 1 +
>  drivers/pwm/pwm-berlin.c  | 1 -
>  drivers/pwm/pwm-pca9685.c | 1 -
>  drivers/pwm/pwm-samsung.c | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--684cmtc/Pyvt2LSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzURXAACgkQ3SOs138+
s6FeXg//dKvz4PGcniJXYV9iyqHiu7X2qROj/XhXXbai1jZ9B0/z2RnJHThhTkxo
Uq+Lg6i1KuqwSeQrxpPXffncOVUtIrJ+48kOSIaPumlhL7gYcZOJ5mkrVGhBsNa4
LZ6RLSXK9MWOX+n/lPB4bYEW3vOe5kw/Vsr1c4gMtmj4XNUmNQ2539ohw/1iD0OM
JbuqzoQWogP3Op7Sy4dh0o5T3RvoOc5ZPo3vJ5D/sgzjwoaIU6CFRj2Xb6LVB0N0
dpvGsdjBLMqaNK2qfrs6aJ7qMnOuZokRPUM0yXchNr5eMSBNc2Wh5l6FAyPC12H8
J/SZgkVwVk+BUiWEg9Rlj/Ar8pSQPgcJ7g820WECzxlNQ+7gdjKQj/tp0WH8wKIJ
IFY9sZUNGnpvVtSLSFh8uC3EyedYki+NYrezeuyOiMJ3cp4fQ0x6LMKwa9xD+gcM
CeWTaH8imp9ZHlW2BTk2FpRH63mdg6J8mMT6U6D0fPpvrECo30hH2YRY07rqenjR
ydMxCZyrkU3pyN3qR+ShuQLk+67MtAooMFcwLVyxr7ROQTxUICrAvaHRZ1eB6VyW
JdmS9fZ8iGHoyY1fDLDVyKLBXq36UNwKX6Ksi7nWCIWZj4ZGN8oJypbL6KsRAl+5
BA/e6rnxc1E2t4Esx8RXsgBwnQEpvoC+ysm7ASivj4kJ6yfV2ME=
=g6Eo
-----END PGP SIGNATURE-----

--684cmtc/Pyvt2LSS--
