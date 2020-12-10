Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682532D640B
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgLJRtS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392667AbgLJRtO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 12:49:14 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0FBC0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:48:34 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cw27so6462488edb.5
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MIPWP2OM1cbNjuKo30WB/tkf0M599p/rN0R+uQzvwuE=;
        b=XM/qN9JfODk94JDmh98OhsbR4f5+0jSlpfPrAM/AW26vqxsevXOdBA1inFj5pG6EkO
         Z9UpFyo6C/nJZdMjwQcqxeByiaWeNFTKodkmjV1Ek7vI4s07baK9C1U28iB20kxWVBlD
         3jedpEt+UJqIGGzUUI/lwavC2ssPz373KjTFWj0C04OxnbuoTH/AB+BTLbDJygGqtUf+
         65miDmrBT5aTAmRmJe36Xxx6UVCFm0cylddJO2FE1ij/24YDe/zDjR05V1mh6Ra2Nfc2
         YBntgHQEeZ7UavKT4I92fqPabbwepBzDpmMXAMuBL56HtO1ovrjwczLRndDxKCxbOvca
         yX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MIPWP2OM1cbNjuKo30WB/tkf0M599p/rN0R+uQzvwuE=;
        b=c/Y705EIiDlffCqvz7hkOASM1vmvqK9mmye6vV2tnaBk8CyXQ1/9R4pu+eexQ6pOB0
         Nhc8Cxm2FAo5ZTRikYM8udWCfqImiwH8SWzbtSRvsuJnbEB06h01xwGFWfMnqM0deQ1F
         Q3eaFi4MCepPBVgdXZpupmxGtkA+y/igP1yD2xrcNvZL9QXzZI0PRJ31Ma4LJPp4BlFd
         tAh4AvgD9B9tmEBett8IZ6H6+Vrl29mcedN6gvPyFD8X/dmFz1bWv3iAmfHOReZ97ZsA
         0OMaeJIpw1ozJEgXL0Q/Nm2fotes3iKzhERjtc1hAGtRwTWl6EVDqB3Y75GgZ5yXJL52
         NH5w==
X-Gm-Message-State: AOAM530ma+Ybtf/D266vcsFGnvOKrHB/Ru9egrctrV865Qjcssubp/CQ
        O5s6bMcHj9Mid90jOQ8HAck=
X-Google-Smtp-Source: ABdhPJwrC59HdIGVlua9Wwgr/XoPybTTNivOnXAaeGf6JlkpPnUvp21I5kj2NFTQLgHFYS/KyaqM1w==
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr8012070edw.241.1607622512806;
        Thu, 10 Dec 2020 09:48:32 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f24sm4750394ejf.117.2020.12.10.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:48:31 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:48:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] pwm: rockchip: Eliminate potential race condition when
 probing
Message-ID: <X9JfbpTnfqUVk6iN@ulmo>
References: <875z5nof46.fsf@simonsouth.net>
 <20201130004419.1714-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gaMZ9YjfFCQG1Hdo"
Content-Disposition: inline
In-Reply-To: <20201130004419.1714-1-simon@simonsouth.net>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gaMZ9YjfFCQG1Hdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 29, 2020 at 07:44:19PM -0500, Simon South wrote:
> Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
> PWMs") introduced a potential race condition in rockchip_pwm_probe() by
> having it disable the clock of a PWM already registered through a call to
> pwmchip_add().
>=20
> Eliminate this possibility by calling clk_enable() for a probed PWM's clo=
ck
> only when it appears the PWM itself has already been enabled (by a
> bootloader, presumably), instead of always enabling the clock and then
> disabling it after registration for non-enabled PWMs.
>=20
> Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PW=
Ms")
> Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while prob=
ing")
> Reported-by: Trent Piepho <tpiepho@gmail.com>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 45 ++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 77c23a2c6d71..7efba1d0adb4 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -289,6 +289,7 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
>  	struct rockchip_pwm_chip *pc;
>  	struct resource *r;
>  	u32 enable_conf, ctrl;
> +	bool enabled;
>  	int ret, count;
> =20
>  	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> @@ -299,6 +300,8 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
>  	if (!pc)
>  		return -ENOMEM;
> =20
> +	pc->data =3D id->data;
> +
>  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(pc->base))
> @@ -326,21 +329,38 @@ static int rockchip_pwm_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D clk_prepare_enable(pc->clk);
> +	ret =3D clk_prepare(pc->clk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
> +		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
>  		return ret;
>  	}
> =20
> +	/*
> +	 * If it appears the PWM has already been enabled, perhaps by a
> +	 * bootloader, re-enable its clock to increment the clock's enable
> +	 * counter and ensure it is kept running (particularly in the case
> +	 * where there is no separate APB clock).
> +	 */
> +	enable_conf =3D pc->data->enable_conf;
> +	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	enabled =3D (ctrl & enable_conf) =3D=3D enable_conf;

Given that we don't enable the bus clock before this, is it even safe to
access registers on the bus if the clock is disabled? I've seen a lot of
cases where accesses to an unclocked bus either lead to silent hangs or
very noisy crashes, and I would expect something like that (or something
in between) to happen on Rockchip SoCs.

Have you tested this for cases where the bus clock is initially
disabled?

Thierry

--gaMZ9YjfFCQG1Hdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SX2sACgkQ3SOs138+
s6HrOQ//dVpAbZnq8fWIuaU83TUbuUj/vtYcX/nMDI++3suUf/tvrcvmoYdvQXk2
Sq4B8FsiHiGCjOvpiNub1Frwx1GFsnhBbORC9xUah32F9Liu37STXOGP7pDK9ZGG
mZ9A2QPSNDGwOii5OfvubSUbPCJdPBzW00Nn0D3VUvxyvsle6HZfWPnoWIwW1oXP
yH/Lsh9fM5j01AznCmz3DvSVv7UH7e+1BpPL06Z6EIa669BiNLeMjTJYz4AREcWp
nvgOxpbSd6i2QPUnCsW/I9ghFrRN6oHniDcrwHgZ1BF3z+BfR06Iul8jI8Ucge0S
KxAeZ5IeAjEHo1itjl2OqgtRjKWFgBYUM3/waDyLHm8y4E7oGuH6BsBIMm5Y+XtM
EchvYZ6oNXURWObnw63ZL4pBEYuAMGutrug6VuhUWsMD68CaGLhm1lfW5ANDDp+e
Fhs33uwTJou43k4+bysezc9ejuyevdZ/crg30ttYiT/x+W5jMhcDNI/xn85gcPOx
bVKzo6QyYnEm0eUVB1PMRFDFFuJY9ShN0df0oe8h0heMPMbZP3qKoOS6OU+CDCcl
ljLVfJ+MMFdrNVDd+v5SIXkQiY27xfQufKNUIB1hJsjKzPM6XbxscHH/y1bUTv5g
mbXTDQZvPWx7rt+b5mJvoh0AuwS1uYw4IGofWhsXK50pLwTWTJ8=
=NKWq
-----END PGP SIGNATURE-----

--gaMZ9YjfFCQG1Hdo--
