Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0337C343EE9
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhCVLHM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCVLGq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:06:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF03C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:06:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k8so16197178wrc.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzAVQlVPXLJK3S+tKGaGpR8DOZOVK7lpsmwQXcBELlA=;
        b=YqE2sQbEKAPvtKFSN7Ws6f8tp4kUN5O7qsVcogYD0JQ0qzc3wsjqX/5ii6t7C7C8ZR
         1QnIiSNFwDXGNdnIDHUw+ur4IPf5tLkMRsmtdYUMAHertCzrENAXMwUwqfLWyzmIFM9f
         H0MrwXWt7kJWsxEVRUFwoc4LrNtUv5s+KzAqJR+w8LxWL4hSwOwS6MXvwo0sxqnb4MqW
         IOGtK2xWuKafjXWEn7e7BlLARhUSkVOeAitVS7vNk+LMQji5ynxrYnS142YnOX1yFUPX
         1RTN3K2Y/rsLH9Jx3IHbSU/V10oycc5I1XPTzcLLE/qHhbeJwnaQNlcUcTKWRLNxSl3s
         pWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzAVQlVPXLJK3S+tKGaGpR8DOZOVK7lpsmwQXcBELlA=;
        b=Mo0k8SuxAHeteAu2lZuAhEaPAQp4rSMvpDO6ymBEjYENGmJfXHvgfiA/9vEGKZVfsT
         RZqCdQNU/y2ahgZa/C56Iw9iqyUTy/Tnu7U/Ogp1UWefq7/jeikL4gFZ+2xD7tKh2kZq
         zr5jYlkz9BuHAVzfcmg8vKIBJKC1f0qF80wpxc2RoGmYKRwsMRAdtAf3LhNHVyp1PhRY
         9awORtSyoeSw1mqs1SUDaepNEqyirGyK1DvUee4kwHuyBJSc0lx+x4GpOjdVPVD4+qA2
         yC3sqf3qr0QxgDbVPrZVr02MJ7+PysK5PUhXklYfcAhpMzgxwNXIj7dKtZmc2MTPPMY2
         AGhA==
X-Gm-Message-State: AOAM5335cCE3Sf0PLnJKPKRy6zxyx2pY/Px2Xr09QFSDvKImab8bOjw5
        39+FxFRA2T37bRj5rjZT8qQ=
X-Google-Smtp-Source: ABdhPJywhBeFDvqBHhYqi6DRImRq+YEAILjeyhsjO8fXMqGwcVrCjtWQBet9OxbNTIYX4UazpM/aHA==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr17409403wrc.385.1616411204753;
        Mon, 22 Mar 2021 04:06:44 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c6sm18940475wri.32.2021.03.22.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:06:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:07:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel-tcb: Only free resources after
 pwm_chip_remove() returned
Message-ID: <YFh6Vfs0SuoYERxa@orome.fritz.box>
References: <20210308095150.26774-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfnzYC4GWXBylvCl"
Content-Disposition: inline
In-Reply-To: <20210308095150.26774-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cfnzYC4GWXBylvCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 10:51:50AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Otherwise the PWM stops working before the PWM core and its consumers
> are aware the device is going away.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--cfnzYC4GWXBylvCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYelUACgkQ3SOs138+
s6HAuA/8C9CdCkJLnToF6O/UrMgF1Rb4k/gXw98vgxm6nRW1+ETsCnh75crmD6HD
V64Q9mSh0amQb3BQfbZsc1F8xjAn+CQadMlzR5RckhvysqpjByH8ykYFm0JtR8lJ
5IY9x7cBmZLKxqsfTPx287ke4E3vfl+qiih3xxW4WS5lbvz6U/OzjfT3kiW6d9oo
LRp2K2iy54B7H5lID5PdD/aUms2GqF5MNyw/3SQkkKhYRokzzsjHJI5wBWZErHE6
hqjD++Do44pKvLQmxj4ydT9+kYb5f8QZBAmLGzvVj7Km1QM/EUQotb+ETWJuNpaB
VL5MflDwcgdPnIPxUXORowmuOO4sdqsHCxiVaED+Yshy9ZL1lfI/rFMu1u9O7EAq
vqfOL0XdAngrEkyuCISMeXrx/3VDLClWllKiN9AaBkBIXVYD/Oe+EcaMHOr3UalS
91C52YluvkJfFxleLXZKj4U1j/PKtjS8VPsBHipqgyQZJ+Mux0w9IBmA8qBFp5dG
MrbHlNSI8b7fYGu1h/Leonp1dnttOPDlZItXrGU3Z7d6smbAZZsWW9uQmEI5cYpx
VF6u565lq82jRGgxN7pC8WrO9Z+MSEpy/3TF9/4I13BVFgluHlSvmoWZCPqTRXHC
MP/AMWR/2tOoPVft9ujsqLFSNoYsvQ773VkxCCSC4Hmoh0V8sgM=
=QXLe
-----END PGP SIGNATURE-----

--cfnzYC4GWXBylvCl--
