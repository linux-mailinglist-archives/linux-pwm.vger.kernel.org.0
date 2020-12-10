Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161302D6367
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLJRW2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 12:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbgLJRWH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 12:22:07 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3572EC061793;
        Thu, 10 Dec 2020 09:21:26 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so8422567ejj.7;
        Thu, 10 Dec 2020 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wEtCAFFcUDfP/lT3kh1OSmiehfZiNdubLO/uU5Zi7s=;
        b=MQ48xzVb9wfd4d9OMKBK5X0xNrZ4bBpa06YKNvq6Vc+eoAdJm0DB97hFHb2h3CNFLD
         hE4XrQq5AErZUxyY4/XTO2in0rP0oAQ0ip1ckjFiwum23aaJ6On+iheOPD7UIWiprjKb
         uvSA0dIx0A+SokwYYZCNhJaKlj/clyKHie0Bb9KWHciFMt5UKB+0TpIi9MOvmo7rALbX
         /6AzgkHNqpMKoXRKn1IKg69BkYrHb+YPHtya2Zd2Ee8QG462yR9guSopB1QFpmvAClAh
         4ZKJX1fU2lJfXb3bA63e1zIJ/y3DzYqY4AzNIrjZbDUx6k429OP4FQz/jeo+rnXjfhVK
         YPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wEtCAFFcUDfP/lT3kh1OSmiehfZiNdubLO/uU5Zi7s=;
        b=GyH+5Ddr5NTpTR1eZI7l/8NimOE6Hp5oyIEgS8lE2z7udQXIFCoX/fct0E7CczdSvu
         xrTR8y9Va4gb4s9w9nDs8El45eUy7NeFOrAz4SF//QSX9AEE15oMzqesyth9LVFpBfyj
         gJyZSzcWayul/nOVS2LGSU0CXYnY449ceWwEidbsHSu9No3ytzFjmgRTQX1vlwQcLDls
         qkxM0m2wBs9pe/UGX4+KQ37xYrI6J9YiHLJ0gJjm/b4Ejg1q/Se7RmtWsMTvIfadNUY2
         1MCpjOWo9MWRCLI3dufkfurSWMkyz4SoP6OjgjJgyL167hOLbfhBmkQHrAcJzP4fzHtT
         35pA==
X-Gm-Message-State: AOAM530ED0oSekGr6GZZrmD+bEwXRO0GbzNdvStjyYOY/UKoLVebcA/r
        YUOwS+k511depSi6SEm+dlq7/gswEcg=
X-Google-Smtp-Source: ABdhPJxBHEG/8s47KqoI2VLJktb+XnnBReRLeh5dXYr7vZuoKO5QBLm/F12kj2Nd3Qt5dyKQH0Kz0w==
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr7191586ejc.313.1607620884942;
        Thu, 10 Dec 2020 09:21:24 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l14sm5457482edq.35.2020.12.10.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:21:23 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:21:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <X9JZEohJLGiT42lu@ulmo>
References: <1607546905-20549-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DbaDMJ+M2InmvP5d"
Content-Disposition: inline
In-Reply-To: <1607546905-20549-1-git-send-email-LinoSanfilippo@gmx.de>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--DbaDMJ+M2InmvP5d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 09:48:25PM +0100, Lino Sanfilippo wrote:
> Use the newer .apply function of pwm_ops instead of .config, .enable,
> .disable and .set_polarity. This guarantees atomic changes of the pwm
> controller configuration. It also reduces the size of the driver.
>=20
> Since now period is a 64 bit value, add an extra check to reject periods
> that exceed the possible max value for the 32 bit register.
>=20
> This has been tested on a Raspberry PI 4.
>=20
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>=20
> v4: Remove a superfluous blank line
>     Remove an unneeded cast (both requested by Uwe Kleine-K=C3=B6nig)
> v3: Check against period truncation (also based on a review by Uwe)
> v2: Fix compiler error for 64 bit builds
>=20
>  drivers/pwm/pwm-bcm2835.c | 69 +++++++++++++++++------------------------=
------
>  1 file changed, 24 insertions(+), 45 deletions(-) j

Applied, thanks.

Thierry

--DbaDMJ+M2InmvP5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SWRIACgkQ3SOs138+
s6EiyQ//TLfupe2MvYkloXLMOdWX3A1bTym9bn0wW3871vxwbseLyYFiBIe3Gxa6
X1zk8P1MiWh/oBI4JzXU8l8qw4fUx7I/1EyRrj4rLGFKBamNqB5tgUFZMGp2XIpm
Ffxg5nwPF+UxnMn5QxarCA1AmbR02Rx4KXeLDMu0C3w4tRLpwVasQkKa8xsxF5Ut
CUKPBR4lHo/Fz56+4pWRg1XJMFaJxLbmybkqUT1HxME4Yt2ZQ66FMQRU9HyhM5ea
GjV7+WgixuNrOQDg3v34ZM2W8Ed4iXhnjUYvfyLL2plRe7nBEP7z3ff4W3S/JqmZ
pfr4jvF1uVf9d0rVlszpoVv9yIog7gkXW6/0vA2JT6Wu+g+/0CNcW7wm2xoZwCWH
oRFtocxHyp53RX7jRzqaKFBZewMDaIpiqQUTxf2wuyxGuq1agIGcCmv2uuFNSkDU
rTmlu+1c+tYANS7cHBg6X0gfcFKffsArFcRhQK8VaKTIFS8hZwt/Mwu/RC5knyyT
00M7agVg97H3p2kvGFXI6INYaS93iC2+QBkCX0TY4/j01p5zSMLxp0x3WpKvdDS+
9qByW9lFhIjPsf0VlQ5G+fzZ9JmcZUlNsw9vmx0O6Ma5PQCbr/Cw9oNgLjw6odyx
1h+ILj6NuQETtzZhKobHjECm/67/K8Up2DlrITTuewyij+aw060=
=vqd+
-----END PGP SIGNATURE-----

--DbaDMJ+M2InmvP5d--
