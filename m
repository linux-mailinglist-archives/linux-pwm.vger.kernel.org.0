Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83069359ED3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDIMek (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhDIMej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:34:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D0C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:34:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so8389944ejy.7
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JeYflsjmuGxJ2QYm8Iv2tJsN2dLfBVqFSYip4gx2oZs=;
        b=Cjq9ndiOkCN5Z6LX4GjKDAIw+VFrW+Rj+DByuYb/YlH55pEZ2eJZCb/0xbVYmXrcXF
         68VKP4MjMVRG1+VMveseAWsxTvFAIPnyO8VHzn+5l5axekmcX5f02fZr8eYOz/vMfC5S
         DnmJ+lG6S36ocNl2lb4d2PiQgivd78UTlTORaatWazFB5xZ8r10a4kpycSG38EF4Gjpr
         4GEwjRjBxPXKYtv5Mm1suwPyLaDublMGyiQpxyC++G87yz0nnupSDpQc7KnZ9SwZfSNg
         IamzcPIWMJ+6NNTVCDAqsopcVHX2ZtDCVzPtEjL3SqK02CenQkhyy9KdzF+F2WQzSRs7
         HAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JeYflsjmuGxJ2QYm8Iv2tJsN2dLfBVqFSYip4gx2oZs=;
        b=nOzSHzjmQGclwH/o72gx/YKGWaccB+ay7sJ/jdohOdjrLhFuv2aGCDSjjfJTB8EUZY
         K6K5ssgKRkMFfZt4TswnJllGjSo36F5VC5o3BHkZUpJ+vOTFE9VEdfX5kOIdqV8FLQAd
         0L8mP6Yx61pFm4dD2rnn+m10DhyyBOcUJZirSmRqzX6Q7cR4ib4aAKD88FHgOvjdGzLM
         E4cUqgewIipUdwhqOmnEKGYiXanTxp2BWrOsA2ZI36JZ63WWluQJsxB1czDwSLj1lkln
         fDbc32WG6PPz1vo2iPvYmim3iHQQe+mFJi7V4rJK6OKf1K3hWw2pIfJaqb4QeeT9rvv7
         OEbw==
X-Gm-Message-State: AOAM531xzbQ2M6lOauOc5/lVDVKBh8Deohss8U6coZXk7domu+J5QYsD
        BXgcco5maw/lKnFFT3nWOWE=
X-Google-Smtp-Source: ABdhPJwPqapSy1C65h1yHycYm/CGTO3x0wllZ3eHFZ+9hGDnqSMEE5MjNudk9RT0rME9kUReOV3+Lw==
X-Received: by 2002:a17:907:2cec:: with SMTP id hz12mr8425750ejc.372.1617971664309;
        Fri, 09 Apr 2021 05:34:24 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id ld19sm1175779ejb.102.2021.04.09.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:34:23 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:34:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm-iproc: Free resources only after
 pwmchip_remove()
Message-ID: <YHBJ88dpMOYJsbgT@orome.fritz.box>
References: <20210324200134.75513-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mLfrBIZ1gb1IQ6b/"
Content-Disposition: inline
In-Reply-To: <20210324200134.75513-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mLfrBIZ1gb1IQ6b/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 09:01:34PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--mLfrBIZ1gb1IQ6b/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSfMACgkQ3SOs138+
s6EsuRAAtlBW96kHHqtDpLoRYYeFsucCi+WL/LtaLk/WXeO5G8bIfDWeJLftKplX
B3pDkBC/Nl7b/ga2U3eWt3eI2W2oya7i0PUL1QraRzKuQO9+q76EdZJTE0se2cuP
YFIaX+wiyXCU+TgLHVx/6zK7YdSuHjVeas//C3lbvbhHBOl4mTN1Nh6WfbiLOjvp
dr6SnEt8B6kcZMajXjwNvFPxtJ6NMIAQC/+q0KBu3qNGGBoiHnA7vftXvijD7wLm
ZxUD+2tYMXyM+HNIGuVUzaKMzNpnZhQqpHjdJkVe1kaBlBggZ9NhJoyDH5/B6o/D
gWshTKHD65AD93awgkl/TxNZfFkpOT8ss6a5VVFmkLoK+e8XKZ1Q+KJvszr2N1gw
8Voxd79vxF90+t3n1JT/GIwKtszwILvXsOdSLGIQyihxZUS4wBVtzOk7M2QGGFoG
SZop4j1vn0JwSAZQK4XNuUdYy3sw/6tw33ZBrr1VJt21aWOaydG6gdAUmEOWlkX7
RdHDfHnlnXftxbHtZmhujvDvkA1Wvb6gWjm/imaS5OixYaZpSZNKcgf7FVC4RWYI
ES/IyBDNE6bRLGWxAFI+qAUpAaVBblgA1anN5zgH6CRKaJlTTD42z6UP4Zu+fb7B
qTiioPMmHdqpS2oIXSXyUQrozRrFFogQHghQZGLDURRt+ikk83o=
=5fdb
-----END PGP SIGNATURE-----

--mLfrBIZ1gb1IQ6b/--
