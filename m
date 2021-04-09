Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE82A359FC9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDIN1r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhDIN1q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:27:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE40CC061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 06:27:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e14so8638294ejz.11
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WprpvOsPaYBmnPxmrvxLLMXt38sbIqBG1QyyvRjWKqA=;
        b=hMYzZuTpXrNN1i5sN5St90+e3eiC/s0b+DRqGsCUsznRR/UjDOuc9rw09OuUXqNLz/
         Bs7xxuptDvotrSLHxK8+8O9R5oV5Oot7bRufApwps+3MSZssRpLl4ZpsNY6nHH0bgJTx
         z5kBPhKTpfh1GQ4LI9nNbU2SNBo8EA2J0r9Y41MUg9y5yRR5RrH7cY0LxQlSjWX5iYOy
         GUWr1zSnOPN/+xeb+YNzC29cPl+ATU4TzSZYW9kFarAm6+Dbe3rDA0zXJzxJXfZZ1ryd
         SELnFdvZyIyabHU9WmUmGXUT/yjiGpMSrWyhZpBGczrSTcoEGjdPMgzaMh39j3dFbhaE
         k8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WprpvOsPaYBmnPxmrvxLLMXt38sbIqBG1QyyvRjWKqA=;
        b=Gfxiny8x4fRSS94UdXDsFmTjirAFZGbma5CUopfUhmH6MvZmobLtPZPQZalhAv6Gpx
         JeMkiDRiNUyUZRNq7h1O14AHj0BBUCMisJXQsamo0YINfUnXx/WCWcLH8qLtvMxoz0bD
         gawTUE4IlSVTx0kWNNjq/eMeDCpfwFMGDP4vOL2eUvLxcNTDKdWM9O0djMVn8mhUg7l7
         F6LZpeaePQ49bArRUHOjgdC8F2bLQhmCCqWdxEsqXZYXg3kN6nr7B0e3GYfW5kdMiDoE
         2zz9cLAbjdSk1B/gUpT/6DViyr+1AbDcNGjO7w3+37rF4PWonvRiLcDlTCTmIQ+5VTzS
         kQlg==
X-Gm-Message-State: AOAM531r3UKS4bJjCs7hP0bhnUIg+XqX5jVvchskqWxeMNX3P2PEmQhU
        FMgBLQYcj2VsaosFToWr8xOXqkdxwPY=
X-Google-Smtp-Source: ABdhPJwYyqZ4W5bVan3buK7f3PWlQbtliSsNhuJXZwbjnqWG/sudJmjgzGw8Vu8kGL/9QXebyXg+Gg==
X-Received: by 2002:a17:907:3d89:: with SMTP id he9mr15712708ejc.96.1617974852697;
        Fri, 09 Apr 2021 06:27:32 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id r25sm1446952edv.78.2021.04.09.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:27:31 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:28:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: lpss: Simplify using devm_pwmchip_add
Message-ID: <YHBWZw8haF0SU1Cc@orome.fritz.box>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
 <20210407080155.55004-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Vf496bxofiA/abj"
Content-Disposition: inline
In-Reply-To: <20210407080155.55004-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2Vf496bxofiA/abj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 10:01:55AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 4 ----
>  drivers/pwm/pwm-lpss-platform.c | 4 +---
>  drivers/pwm/pwm-lpss.c          | 8 +-------
>  drivers/pwm/pwm-lpss.h          | 1 -
>  4 files changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index cf749ea0de9f..c893ec3d2fb4 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -69,12 +69,8 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
> =20
>  static void pwm_lpss_remove_pci(struct pci_dev *pdev)
>  {
> -	struct pwm_lpss_chip *lpwm =3D pci_get_drvdata(pdev);
> -
>  	pm_runtime_forbid(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
> -
> -	pwm_lpss_remove(lpwm);
>  }

Isn't this going to defeat your quest to make all drivers release
resources only after pwmchip_remove() was called? Before this patch
you'd be able to fix that by moving pwm_lpss_remove() before the runtime
PM stuff, but after using devm_pwmchip_add() the pwmchip_remove() will
always get called after the driver's ->remove() returns.

Granted, in this case it's perhaps not the best example because this
driver is actually grabbing a runtime PM reference, so that should be
safe. However, I'm thinking in general device-managed PWM chip addition
and removal becomes less useful because of the ordering requirements.

Thierry

--2Vf496bxofiA/abj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwVmcACgkQ3SOs138+
s6HLsA/7BelY+m/10pJyMPFl6IiMlRnGR3CZw8awXp1RpqTrZbipWt7W287upWKl
jhUIjKjW5iDTnEz4nH/7L9Fv95CEO56iKrxX+vsju/lCKF8Qyw/su/PJEmzIDqpQ
lVLvscezmMiO0fvZh2uK0wJEPL33QE3mfJYwSYSBEWOz6yFCaFDjbMSkrvDhWwes
AXzT7hNQzhNsBNGzczXsM+cPYvbDyVxmePVexlz2UF7PXpZ0Moh7pHZG21Z/hkDK
1NWLHbjDIsLXo/U770oXUWgzvAblby5Z69b9qxxyv8zUVd+9CHNcI47fgZ1evslb
zVQsgL0STu92w26TgHBeNTRo20OUh/UGStc5OJ4NFEFuVFCSqYYsEmeS1AbyqpCO
ez7KjeIraHKEX0/PW0E8K2Rlu4B/FVqXnF+cecOAMKl+BmZF4PMEzQhNdwZZNdUh
uTL2wXVEZSGDoArW4IrcZJtAcFWn8KTBtwpk56PcHSMYyjl939ZYlFl6rTp/ep1I
rAhKEpKRFKwD4EAJvuOVYlJLC4dkNMuTXkCtvUMAQFPpVVd0Qu+xj1jZabifIww2
66+jYB75oZgHBtCfoSF6HwA4hENxA6PBZ3K932U4KzowAfoLbw7v1T0wPQSdA4rX
M6NVE+8MvF1AABVeYB+MTx9uoWbUWBF8tXWQyPnA6TFAESHOdao=
=U6bd
-----END PGP SIGNATURE-----

--2Vf496bxofiA/abj--
