Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEA343E7B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 11:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCVKyS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhCVKyF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 06:54:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78FC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:54:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso9002566wmi.0
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7JPPKj3NIQL5KpKN2qlAtuJExLdJEt4Tc3D1nBNxAY4=;
        b=vHz8q67+Sdtv4qFN+F0ViFNn3j/+qSLDZ2meJVzvKwGi2lLCjgKaX1joeGonxiSSdO
         WG8AZPRMTQpTuVWr7IM/Go1cWGIc0NDyT6aRo/RdZqXIuOi+mG+teEQ7ezqoUqsO3Yf+
         ku4m6V8Uwj6MnsstkWpUbCFnXNphC7xt/9Uz0T3fSttsa8s98rfE27C6oNjabAznw2Qj
         HFffh4jTVb42UiPYHNj+1VQMv2yECgKiz3z05PuduPXmR2F7FSICgEPW3VtmhsieONyi
         2ee3YXKrADtRqbxbrzjUI8liqcekjFuWelVs6+oht+81vRznGbHdkJxUq0Hd/DQCcdcA
         jQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7JPPKj3NIQL5KpKN2qlAtuJExLdJEt4Tc3D1nBNxAY4=;
        b=snuzs+zr9w01AXFE5r9Z72ZfubV0gSwQe5RYmaLFMzsif6103d1ZMWWN8Z79s6FPsG
         PX1GCPxcscm41MErBC/+B4ZYI2PjmT3JaoJRlRfah18qj5EZ9zHIctc0ojjvsgCbgTNi
         MPlQNDVfFBnFiOXqkmg2T1veJye8m7EDZ0DYwveyuDqKs3mXRBehd5qvVqjqJRsgBCS4
         qQE/rvfsvILHY0C9ObwV01hBHxeCiVbsPOnDPK+VEs6dEWlS3sMVPS1DQ7j5AY26sBF/
         TU+zfsQZy3XIP13lYH9/zv8RhnE1PzeaCBe/LkYV1rjgl6kw1i6iRPTXKy8ackWhbwiH
         eakg==
X-Gm-Message-State: AOAM531vU9qDuXlcrMv+tuIH+AxjFSpHtNlYuBx+EzYRknFRH/gpQxPo
        jh0ZrrW7XjKowMuDo2ggXXA=
X-Google-Smtp-Source: ABdhPJxny0KgB8ICgCBLzV+Na/9KUd1PBwL6tBJnS7OrODqGIEDoXMz3dWuszCfAcGzkHH99glHKRQ==
X-Received: by 2002:a1c:1b96:: with SMTP id b144mr14711098wmb.131.1616410443008;
        Mon, 22 Mar 2021 03:54:03 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h20sm15963890wmm.19.2021.03.22.03.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:54:01 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:54:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Always allocate pwm id dynamically
Message-ID: <YFh3WySq+dxZPDHm@orome.fritz.box>
References: <20210301185719.1689526-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5pXe+6c6m4jBpwH"
Content-Disposition: inline
In-Reply-To: <20210301185719.1689526-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f5pXe+6c6m4jBpwH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 07:57:19PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Since commit 5e5da1e9fbee ("pwm: ab8500: Explicitly allocate pwm chip
> base dynamically") all drivers use dynamic id allocation explicitly. New
> drivers are supposed to do the same, so remove support for driver
> specified ids and drop all assignments in the low-level drivers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c             | 25 +++++++------------------
>  drivers/pwm/pwm-ab8500.c       |  1 -
>  drivers/pwm/pwm-atmel-hlcdc.c  |  1 -
>  drivers/pwm/pwm-atmel-tcb.c    |  1 -
>  drivers/pwm/pwm-atmel.c        |  1 -
>  drivers/pwm/pwm-bcm-iproc.c    |  1 -
>  drivers/pwm/pwm-bcm-kona.c     |  1 -
>  drivers/pwm/pwm-bcm2835.c      |  1 -
>  drivers/pwm/pwm-berlin.c       |  1 -
>  drivers/pwm/pwm-brcmstb.c      |  1 -
>  drivers/pwm/pwm-clps711x.c     |  1 -
>  drivers/pwm/pwm-crc.c          |  1 -
>  drivers/pwm/pwm-cros-ec.c      |  1 -
>  drivers/pwm/pwm-dwc.c          |  1 -
>  drivers/pwm/pwm-ep93xx.c       |  1 -
>  drivers/pwm/pwm-fsl-ftm.c      |  1 -
>  drivers/pwm/pwm-hibvt.c        |  1 -
>  drivers/pwm/pwm-img.c          |  1 -
>  drivers/pwm/pwm-imx-tpm.c      |  1 -
>  drivers/pwm/pwm-imx1.c         |  1 -
>  drivers/pwm/pwm-imx27.c        |  1 -
>  drivers/pwm/pwm-intel-lgm.c    |  1 -
>  drivers/pwm/pwm-iqs620a.c      |  1 -
>  drivers/pwm/pwm-jz4740.c       |  1 -
>  drivers/pwm/pwm-keembay.c      |  1 -
>  drivers/pwm/pwm-lp3943.c       |  1 -
>  drivers/pwm/pwm-lpc18xx-sct.c  |  1 -
>  drivers/pwm/pwm-lpc32xx.c      |  1 -
>  drivers/pwm/pwm-lpss.c         |  1 -
>  drivers/pwm/pwm-mediatek.c     |  1 -
>  drivers/pwm/pwm-meson.c        |  1 -
>  drivers/pwm/pwm-mtk-disp.c     |  1 -
>  drivers/pwm/pwm-mxs.c          |  1 -
>  drivers/pwm/pwm-omap-dmtimer.c |  1 -
>  drivers/pwm/pwm-pca9685.c      |  1 -
>  drivers/pwm/pwm-pxa.c          |  1 -
>  drivers/pwm/pwm-rcar.c         |  1 -
>  drivers/pwm/pwm-renesas-tpu.c  |  1 -
>  drivers/pwm/pwm-rockchip.c     |  1 -
>  drivers/pwm/pwm-samsung.c      |  1 -
>  drivers/pwm/pwm-sifive.c       |  1 -
>  drivers/pwm/pwm-sl28cpld.c     |  1 -
>  drivers/pwm/pwm-spear.c        |  1 -
>  drivers/pwm/pwm-sprd.c         |  1 -
>  drivers/pwm/pwm-sti.c          |  1 -
>  drivers/pwm/pwm-stm32-lp.c     |  1 -
>  drivers/pwm/pwm-stm32.c        |  1 -
>  drivers/pwm/pwm-stmpe.c        |  1 -
>  drivers/pwm/pwm-sun4i.c        |  1 -
>  drivers/pwm/pwm-tegra.c        |  1 -
>  drivers/pwm/pwm-tiecap.c       |  1 -
>  drivers/pwm/pwm-tiehrpwm.c     |  1 -
>  drivers/pwm/pwm-twl-led.c      |  1 -
>  drivers/pwm/pwm-twl.c          |  1 -
>  drivers/pwm/pwm-vt8500.c       |  1 -
>  55 files changed, 7 insertions(+), 72 deletions(-)

Applied, thanks.

Thierry

--f5pXe+6c6m4jBpwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYd1sACgkQ3SOs138+
s6Fhnw/5AaOtnbQfO0dFM5jE6rot72julFJ8sMTv8twzHKgQdt54YS/I1QICip3o
Afj4ZaMx4e7Tbc/oocbgKtJBhS23dBOCnJ/C6IgssvMity3wFdBONrucY+53biNI
jmbCvPouirK8EZfNuppqZBQcNmtAXytdTEe7qGges9deun6+jXa7cPp4BPt4pLnj
lQh/jOlpGLa7/mvWIuXhWtZ4ZZcOggO0Z1JDLmusi/iMg7vhfUNre3Uf0JY77M+5
fONJsPEcYAH7AI4E8lZs89YXM4aeT4bF1wal15kPWn3UVj5V+vXCCwNn7nYKBnWE
vUvZUPakidp7sniZAFCD/oLl8x6G7Z/Z6qzRW95BVXkLzvDiXYptT9NUCh6Dz4r3
gMcsSq6zWK85igPYsQxXKySCIOO3+wKHVFeWACu83Zj06gPPkjf/SKbgSPZb3kVO
MR822eA/umWktcspIAuF1rZUUYaIMM6QPZ1/zjI2/FwtDmCoQ6PNYJRYF4/s6YWd
76oJI8hRIUmr9q89mnsHQyMi3/k/tHijmKZPasdsHCmgMjETS1TZvLkwok1co1eU
5rDCuqZIMTqOMCDS0CjKwvCeYE9IDP++p0Pu6e3N5pPTB65MiJ64VQUfxU0YcoAf
Xy86eejWaSMynzY9torfF5nLFHt0T+OfcxH+ITjL+bnMhPhv97o=
=NsnG
-----END PGP SIGNATURE-----

--f5pXe+6c6m4jBpwH--
