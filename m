Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE37343E50
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCVKsX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCVKsP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 06:48:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209AC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:48:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so16131170wrc.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GmJxNHFaY39dVIye6EG6NKmGClXvquEfYdu615kK6QM=;
        b=RJxZ1uRgek0n+/tcRm6YHxfkpu1yJl21EPPYlTvlvfERGEq6VZA3XZZp85tm3JoiC8
         GWQWL9ABEj/3kbO9AoRA6/R0xYX5f9/yHTkGgBXSGEtVUkKtmwrUVl18izq6aJMT7vr6
         BfhXafdAx6Heb4VtDRnEQg1vMuH2dr+XIoJDSmvqhG/a2EuWoLGVCmmUVehGSO5VA42x
         I2GE46uTaeEZ6io6/vE6XWKpunLLp/NH9myHVbAInIUlPvZRWNElO1vkiaVpMoyBHMZX
         dpRWdX0wpDToOHSW56huwyrejHy3DD4E3+1Gl02VGoAvxO2iotXdpjcvstz2KTe03AIW
         EyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GmJxNHFaY39dVIye6EG6NKmGClXvquEfYdu615kK6QM=;
        b=N8jbTdicxwLo2ZnCcv4CT9x1MSwY++vcQU17DO22zW/yNWoWDEJsnKXP7hGwNsdshz
         1Z7PLWF0/tO4zY1RiTO3K61OXTdj9zTlKZEUSqAbqRuHLsVIGRLCh86h8fB7NXa71l0K
         tezjiw9bp6o236JK8Wf5BdIGGbhPDh7WHNzObKG23KI3uAEaS0UnUt4YzqNsPHjWzdLr
         fQwCSV0EborO3UisMWIKwa001Hfzz9u7+nuqbuyYS80N+b5cO0FtfpjBMuoNPHYyFvyS
         xDthfDz5rmuqRcEqL4qITQcOqGjM3PHGZmP/L1IQZfBXK846X+ns09KZCTVfUafbbKd0
         lm1A==
X-Gm-Message-State: AOAM532Y5y4IPYqbVWRKpAg3evcVnpDWbfwakHXzUQjkduugPU9mwvjM
        D571yzqSWJDpA0kpbomRJZCieAu54Jc=
X-Google-Smtp-Source: ABdhPJzFulOcxIrFpshmEUF4BF/RD5c7qzRj7p5kTzfi6TJjE4T5I3AvULO3qog8BJSdVJXz+NMhUw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr17427883wre.386.1616410093732;
        Mon, 22 Mar 2021 03:48:13 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i8sm19186507wrx.43.2021.03.22.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:48:12 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:48:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] pwm: bcm2835: Improve period and duty cycle
 calculation
Message-ID: <YFh1/nKXYFf2yovm@orome.fritz.box>
References: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VQ8zwhowAqeKB/rU"
Content-Disposition: inline
In-Reply-To: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--VQ8zwhowAqeKB/rU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 09:48:04PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> With an input clk rate bigger than 2000000000, scaler would have been
> zero which then would have resulted in a division by zero.
>=20
> Also the originally implemented algorithm divided by the result of a
> division. This nearly always looses precision. Consider a requested period
> of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> was configured with an actual period of 983869.007 ns (PERIOD =3D 32258)
> while the hardware can provide 1000003.508 ns (PERIOD =3D 32787).
> And note if the input clock frequency was 32786886 Hz instead, the hardwa=
re
> was configured to 1016656.477 ns (PERIOD =3D 33333) while the optimal
> setting results in 1000003.477 ns (PERIOD =3D 32787).
>=20
> This patch implements proper range checking and only divides once for
> the calculation of period (and similar for duty_cycle).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> changes since v2 (Message-Id:
> 20201222221319.2101107-1-u.kleine-koenig@pengutronix.de):
>=20
>  - Add my calculation to the comment explaining the max_period formula
>    as discussed with Lino.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-bcm2835.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--VQ8zwhowAqeKB/rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYdfsACgkQ3SOs138+
s6E8+g//dI+RnNgbt+P8UWV/j6TJFN+SYRKxawvw1cEv18ujFskqVSCayvgVgA/1
pC1ooXZuj9Ds3YJvJhrohz2yNk4rRX2lpY5q2isBobtR48virl8dGERibHk5LF70
F/6CtQyfsDYSjy2N+lGLlL4vr+f/Zbqg3vQ4YLtXoGkCyHci+n6OjxUv84VJDBXl
C3V2aiGNMHpLkmcfDF7Ch3i3DfRuwGS0HwTDhRTyBT7A5HpJzqPeSPdP1L0Y84g6
KchE3qKb3ehGb8O7EbDcW0gWKXMVvPpJAi2JvFp34ElH2bgG+UhoSvSYEZ2t+LtW
8MCJ9TppIwPVWULb1a16tQmgVPy2enHJHepHfXms9vdb6VbBMubpMM7kJD6rbNml
XXyeOpKlOjexU8+EvFvToVqHkkG4r3ZBv4NxPqqI84QabPkyR+ubCmcYlIjdvb80
3lKwd+SBaFBd20aP5SEcz/vgTLprC8Inp1JsghMxn9DmxDr36zEnQTn+bEwmkiIB
XTtF6RbEBo25KZx/UZzMrhjaTilb+kiD1cwbT/3jEZet3ywGq0Gp6S4BXUxLASty
mMddDDl7RIGKrZKSEteXhJdnGMyl3L54330bZZyynRDGCl2PRbIbdAH6cggxOl6P
kA8TOnwHEIrSHUFEermoiEVndNNSZmCCe0hNlx1S8OozEk6+XXk=
=dfP1
-----END PGP SIGNATURE-----

--VQ8zwhowAqeKB/rU--
