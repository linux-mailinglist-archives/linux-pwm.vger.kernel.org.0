Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2F359ED8
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhDIMfF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhDIMfE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:35:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE203C061761
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:34:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g5so1705641ejx.0
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D5YJ9EEcITHMvte7GIbeD1In4DdpTeenwXUVP+qGUqM=;
        b=pK7opkE9q1/Hbu2FiwjDIT0IG+iIrMae8pj5r5/rz+GvfafyvVoXK0mAt2Y6JNkjLj
         qQDFh+tLxJ+2PeCde8SOuoH+Vd/tgZDzcMXVduXfQlETNrDGRR478KKxLErvlKZ/fMoC
         K89+iqQke0unLiGkfRwyvyJTCCYzYsLW39kOKeHWtAGL4g3NtOBQKRTEgdo7fqQPk0M3
         H/XuD+6IZM/RN8zwADg5wQrghnMg3pIsXWfpd0EanNR3T2K2D1Yrx6ibLsIn+gdGIuRl
         FHHIh78NG8yOoBr/etKVqTjKucl96tJZq9Jm5TAQf5NmGEAw3jkQ25USxBMkwx9icu5q
         L7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D5YJ9EEcITHMvte7GIbeD1In4DdpTeenwXUVP+qGUqM=;
        b=NIDpRurhOFLr1/sqMUohT75rdSMLJcbF7uhabPh2U2HF7akb0XeC96AgL77RVxcdtv
         vhR+lzryXskKgaFeYqHYVeBG+V2MpoOeSl/XVfrlCWCq/QaB5y1Kid8QlkRg1Depua1c
         iYQG6Gv6f66hGb7aCI+O+2Eod5QyZMICjpoHZGtCkhMDOR7/z0H06cr6UJdmMUV64Q6H
         7Y8BsjCTZD8YXcN1YWR2sXQXkU3g8MJ7glCUQjNaaTZ8aCuVRGRWiMn3ew6tbrQ1Z1ID
         yNftTT17HCEPudzdXBpanZ/ru7Nl1fCMiRUsgqZqYPOs3x4X1LIdUk6ZfqikippUwKCm
         x/zA==
X-Gm-Message-State: AOAM530h+bRvc7RVWiAA41d3iiQgCGyDqpLgAB+HCBUphJmhaSsby8ge
        A4g0vmh6nJpbweYasjhTVIk=
X-Google-Smtp-Source: ABdhPJwIRERzivcI8jV3bTJ8luEcNNLdaNtHRfwi/lfloAW36mgWgMGhy3sAd6nnBdkZvcjvNw4slA==
X-Received: by 2002:a17:907:9611:: with SMTP id gb17mr16405684ejc.325.1617971690034;
        Fri, 09 Apr 2021 05:34:50 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id um13sm1179966ejb.84.2021.04.09.05.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:34:48 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:35:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] pwm: bcm2835: Free resources only after pwmchip_remove()
Message-ID: <YHBKDH+WEYZOnoPs@orome.fritz.box>
References: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BNuZ53PJ/5e0Dz5P"
Content-Disposition: inline
In-Reply-To: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--BNuZ53PJ/5e0Dz5P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 09:29:31AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-bcm2835.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--BNuZ53PJ/5e0Dz5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSgwACgkQ3SOs138+
s6GdkA//QDwXajg8czv4f0J8tRPRQ4AYjYiSGAVNDA+zd9OfbnOa62hItdufWWY6
ROSRwPcgy5XWyEwFCqCP3V6cIpPSu8mLob3XmWqunUE8q/Tm5Oj9cGRXLUKISo3L
qAF7M5ljIWgGQMbXY1cC/a4BiSO1MvgkJZQAujW3pM7IjBYeUk8WsiAC4ViIXn2h
AKYIURBJJlx+r71YxahatlsF2XvzxeXYP/zJOFwU79qPLLnmCDNB5ucP1tlLuang
nHhRDuP5iipXHQrH1lbQlYle9jg7nvYSg9IExMMWmf9u3HxutV2OTJWYo7GWXjmG
2tVKZMLTmqI5KcZGsv2DS1suDJpf86Sklmy0H8PPAFbxDHctKpYSpDU0RbLP6YWT
XXyXRQI/uqc9yplBuFkkBuYmxikHt6HzS8/klbt92QdDnkvPasZgjBGT4rz6/r34
epRl/heCaYHzY92t9WHj/hPJnwgnji1cKb0shvEaOGoZ+md81F0QJUkMnShBetl3
LXctIh6kMSR9R0dAtUGpcLzoZYvnuc5RK7Qkyt7IJXoHEX2vcNI1LnpZwHZu79Iw
N4DQ8/KW/sQb1RTUDPw/KLhDDjeS1l1ivp9BQ/DVBWoPF2nBDzvZOFVL5svH2nAo
J3RE9rZiR+PcooaLGtVYskPM/JwCoIvVL/brG08EfxfJKaQW/RQ=
=Fizt
-----END PGP SIGNATURE-----

--BNuZ53PJ/5e0Dz5P--
