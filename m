Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447882AF7C5
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 19:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKKSNc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 13:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKKSNa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 13:13:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B8C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 10:13:30 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so3126864wmf.1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 10:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EX8J0XEPVuMNikPLZERfQYDmdq5Q2uKckJ8nmEwckvI=;
        b=mkOGXpzQ/nYzFLg2cYugFNAXcTFOOgepv1YJ96kGxqNr55jUWXsi+WuE9NXWoy03WJ
         J1Tvo+SHtcbuxG5lKiSyGb1WBpXRCNOuDNCAlel2B6pSV+9AP2Xy9vP9lLlLm/nGX5Bn
         HUaqVtDoSotNCcphnEds/52dZ3zeBFNAm6hctfIMKuxcNcGEtsR1Xxbf6nGJ43r2xmZC
         BbjVOZOY623vLwQ/ozggtbN2E+G7lfEptmcObWpmtySnQRRXMXQ67DT0fY91GHSKoaOH
         blGX/cjR2F9R/hN2EXmPlwq3gjM5cefSwtQcv/Pse5SMfcJSoh29sfx7J36cV8c8W4J7
         zGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EX8J0XEPVuMNikPLZERfQYDmdq5Q2uKckJ8nmEwckvI=;
        b=qPnaijgyWo7Bxa0X31q+4svXJFLi73fai8MQ1YId9WcCe8y6iH6ItCyznyjjxyYWwX
         HGgTbILpjmhfiwdYvFTcUod8RR+1u6KX52k8qbI7DISRJcfPjHLGTVt0f5JshYRwkBL2
         ics3bLqYhTCIJGFC0OWsseSqO+vymnE7T0mXnmH4w0PFxTmHUEKtTvLjih5pKEzAADSn
         uc1RM9Fbxbf5zNbZP/j5D6QjGOPhsV6c9aK4M89VRgwML9fJV88X27tUfV9AZ+qGWQDS
         5qoqoWkKYnVxu0OSaAQyG3XiZY8rSBZfhrb37wkqjzXmmSTgQkrlghqcu9c7JyswmjuI
         gHGQ==
X-Gm-Message-State: AOAM533Vy34w1F/7//vkDXVftvmI+bOCDtHUHIo//UCJvgpndCiPeJmq
        VAHnA7r8YVY0g2Si+fD+t6s=
X-Google-Smtp-Source: ABdhPJzrt9jLvg++GC+JvTazzFIfSFPQDn4rPxrXFrdTOf1Xsfk8v0PyYOd/H8Zb38iqZ8vGdy+TVw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr5376034wmi.2.1605118409086;
        Wed, 11 Nov 2020 10:13:29 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s9sm3894389wrf.90.2020.11.11.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:13:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:13:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: zx: Add missing cleanup in error path
Message-ID: <20201111181318.GC6125@ulmo>
References: <20201013081321.660884-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20201013081321.660884-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 10:13:21AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> zx_pwm_probe() called clk_prepare_enable() before; this must be undone
> in the error path.
>=20
> Fixes: 4836193c435c ("pwm: Add ZTE ZX PWM device driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-zx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sKb4ACgkQ3SOs138+
s6GC7Q/+PYfO1BN0U1Spkpx3wXK+2ypKOVG0r1Bmwmy6aef/rhfivLiQ6lzvJjtw
dOxIlyBCldKEZ0MbdNbd5tZDAsGKaENmHi0ODtESMZu73LrVV2fwCuragc4oNrEr
YgMIvdC8KmgY1QEVIh2QXT4xlSuKJO3S8e5QryZif2yYf4ex4ntATM/ToikCP9G3
i/at+mEeLUfJHlePYl/wfjQd4tm6UDMjnOYBmdLkU8MMRMaVrS7Unz5m1d/3tmMI
PlzxjDzNdsWKgHp65N8GZWwpzfmNTxZETjkeVIX0nZ4QDj24TjCMGDlb+0U3qez0
fNPZviPD0HcSe8zo9sJButQyQsihqF2jEOc9OBXLUn9v2e5W/fMCo7kQym734U1/
0I1hkgwXnCyUEztREWYY4JpKRazGbJanWhtHKKGm+EDH5YsBNvzb7EOCTdr4/9P+
Juyg0aZ5l5DM6d3doKTOPvn5XdcAo0JGeT1cwq52nfM2LEOHNYTCIwPlYV3rQs4R
UXxFbtBg9BEQ5deIpM0cR+Y5IFFT9KVnpiITX65nRJHELGxNB7AWm9ndx96w+3uV
VZt9cIYX3Yu7nT/uj8PTsNFybTmXyuW3MZicLZ8GwVgw6B15chuDBW8hQCvZhNsA
fUUGrDl2ILD7lPK6qm6h6wUH7GTT1tAOyz1FZNVv6WPc5Ulr+gE=
=r8+0
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
