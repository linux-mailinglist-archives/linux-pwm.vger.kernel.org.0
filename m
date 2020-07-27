Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8F22E6EB
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0Hup (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0Hup (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:50:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA88C0619D2;
        Mon, 27 Jul 2020 00:50:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g11so4283371ejr.0;
        Mon, 27 Jul 2020 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+C+aRIzZChly/+LMFF0Tq4yjhH/K1QkKiEm2WmPAqY=;
        b=ZjS7ZIgbBgpF0BCvSDDWXTDY4QJNfpLnL3sxY6sH1OcJBbXPf5GcSvcTtsHCBCHKff
         poyr2wwc8lrls009nnXy+ttm+yrrFB60ow0sw0LRBOBGeoywHL5AgRH+5SoLM9i0MHCf
         VTeZc5VMOt8nWJnGoJsn0I9DnonmAgpvPE+DOKwUdZGxyhxQTsS6wMS6ywF27TwDPnPu
         4+TSNl6z33Q8piFEa5Y/0esuW3BCes1FB1fBrNgFjq0ByoiOBbAic992HVDFkZpK+T5M
         cb34UZpoHjA8uuXLA5TkB0QT5FvlHV9hdx+Xm3zdyxX22SQKXNQY/Qd7xdl/h/ckoB1n
         EX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+C+aRIzZChly/+LMFF0Tq4yjhH/K1QkKiEm2WmPAqY=;
        b=QTuVtKEbJv1BCn9yw2XNUFa8WH7fU+W8g4yR5BQA7aWmqSHs9ww2gJbdKNSsmM9SiC
         ngNr37KRvvliiQiqvih8TN6izDtROO1d20AW/5K5EARzWJOb1KG9BeZtjcorFRPRZnI1
         ge0P8MiLSKzKcy03VGOqgqMP8PBm5MTKKtE2FNruGq/pyk8TukAx225yTwTkqtyESred
         Y1IbI/VRUFFlH8I2dT3+RvUE5YopeIYI55jQuOkqQzUDA0qUKCrKRS8LAxayZ1wPODd3
         uTPgcahI9eb1XGMW4jzs9/usW0aSoiluiQRKFw1zq5XdcJQILJo7Gt2QTZQiSO726p5c
         GbrQ==
X-Gm-Message-State: AOAM5325juV6lyiRaE8JtZ1Kbr9rvisM6LWWZJlrmIwzXNwhDAW0Y2+B
        G2P/QBl9t//aB2SDwY/UJiY=
X-Google-Smtp-Source: ABdhPJx8ifaJYFn4DV6d0HZchBwdWU1orYgPlMqTeqHGuzS0V9eW7FKWnUH5f7CVB0wUBXhSRFCzqA==
X-Received: by 2002:a17:906:248d:: with SMTP id e13mr1559098ejb.169.1595836243458;
        Mon, 27 Jul 2020 00:50:43 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m20sm6526256ejk.90.2020.07.27.00.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:50:42 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:50:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix a bunch of W=1 warnings in PWM
Message-ID: <20200727075041.GC2781612@ulmo>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 01:47:48PM +0100, Lee Jones wrote:
> Attempting to clean-up W=3D1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
>=20
> Lee Jones (4):
>   pwm: bcm-iproc: Remove impossible comparison when validating duty
>     cycle
>   pwm: bcm-kona: Remove impossible comparison when validating duty cycle
>   pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
>   pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc
>     header
>=20
>  drivers/pwm/pwm-bcm-iproc.c    | 3 +--
>  drivers/pwm/pwm-bcm-kona.c     | 2 +-
>  drivers/pwm/pwm-mediatek.c     | 1 +
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8eh1EACgkQ3SOs138+
s6EE0BAAtJ8jgzHwsPcXNK+EPH9rUmVFDOOHkL11CCJUc+k7H6oJtANYVNlCuwey
8XYLAu9/hthSJddVGKF5lieUj4vDEoI+z0ZAzs2FV4q6gTKqbubYideTCk87PPZk
tBpthZF9UjCRBzKeCD9shr9QXUH1VgCe2GbM9rwurVYBfl8O3Wl5zj7JBs/VirRy
2S0AVyIjya6pqsSb6f0EFSehv2plffKe9Le0BEYfNd1kt06OOtWZ9vmQgY2gNBa5
tqLmO7ZgBgVHq/IJ+figo+1Qlry51M//WgLiF6YbnBjgQJnynmSVUZfU7rOjhO6r
eACFJZyeGlpsUoooUQ5MwYW6yP5wGhKUNpQQ/+rccZ36KNMEEybSBJ18/GszXDBW
2DQLpkqQl+6csDb2WZmkvz7AbFVleSQnb6JDcAcyiDHhuaP4OxlWYnnhfs/Q3iuk
vBIvqZUOSw3mNCoIkfpmpibKbVI2IwqXX/yAg5MWeR9xk2yWLXCaQi9MeXWuoUbF
MRaRSJfppmvxzETu7qeGN/WpbO7limVWjwCyNk0URFSWWKSM8GOPLpjS/IQYmC6x
bId2ypU+o6QB+F2QbD4DnvNivPiuyvOpwXNZH9Y4UV1zVvLq36Wg2K0Jn4NLtPu/
rHrSGxjTq9L6n71N11mxrV7fPM9uS9jKNVGGgrCc3vZQMT4lJrs=
=kRNd
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
