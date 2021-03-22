Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402AF343E5D
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCVKt1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCVKs5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 06:48:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722AC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:48:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8968461wmj.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spT6mdXA3W15MpSJI6dDAtWotiB/ADAAPujZoIVO1jo=;
        b=hQSYQHsnh/0CTuLz9iMv9VXObU9Xg8JgZMr+TUn5PqSSUNj/CbobnDotnQIZJYogfA
         4V1lKXZwSO0w6AZGpHUB4/kW1Ae2CoHqLII5H+KsHgv06kRQ+yjCAvgweADtuW5jW2tX
         pxY528rxIykMPsLL+SM5Ym0Au33TryYLwkUClQcYn4qc0t2cNwlSWYnm452qDGOiNMUd
         1UL1Ci6UVyRYxdGAy0Xk9kOh1wLENwFFTOMoKiIpSDKB9hDUDADPLyPlzyqHxLWATGF8
         f4PO326fBfOzgv6zBHJ+ChKkVf7i2yYmWlNKQvfeSkBf0tYmbloGrlRz0a8QbdVQpkUU
         quEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spT6mdXA3W15MpSJI6dDAtWotiB/ADAAPujZoIVO1jo=;
        b=CU4TgOppK+7SZttTl4fi+r/VrDozvUTMtZTVsM1Dl35FUPVA9Bohe/vOlUm4rPqnrk
         Syw9ESiNeL7G3nG6c8M9lUuxmo6yznESzDWbaTaAHEQj4z5GpKjAEsoqm+GZ5a9rxzRT
         EwQFOAI+aVuLN0kquEFdW3Z4Tjud8sEyxsWioo+fb8SU077pMD8f15luHi53N2dsHZRd
         bq9lR4X84DOcuqE/wFfRoUddE4lJvlh58YIFUlqKvVtzL3I9IBaRHyRp3Ou1LZYRnvpC
         fB3ai54KXixz0938/aTAtVvbpeD9BnYEPP1wx5TSw4J3NJUpb338O9i15NBuiKJWBkbM
         0eHw==
X-Gm-Message-State: AOAM531hRY9CD6+6H7YI3XUu1DycMXOiNHD7bLFjQFxqxIU5dKoi6jWw
        5ibySHVEiYd9PF3OR3K1wIA=
X-Google-Smtp-Source: ABdhPJzXsmh2Qp9r3S46eV/hlgZGycHrvRXFdTvvW5btAq6Y+RzZg3qe6mSMGFTc7m4TBZdODJBmXQ==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr2309172wmb.0.1616410135652;
        Mon, 22 Mar 2021 03:48:55 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s83sm16433612wmf.26.2021.03.22.03.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:48:54 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:49:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ab8500: Implement .apply instead of .config,
 .enable and .disable
Message-ID: <YFh2KCS5E0XiaP9A@orome.fritz.box>
References: <20210301184537.1687926-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u0wXW0dhLkb9EY5Z"
Content-Disposition: inline
In-Reply-To: <20210301184537.1687926-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u0wXW0dhLkb9EY5Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 07:45:37PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-ab8500.c | 53 +++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)

Applied, thanks.

Thierry

--u0wXW0dhLkb9EY5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYdigACgkQ3SOs138+
s6E6QxAArGYJP4zjtAWSRh8uJpYZ9XrcXtVP4/FzTuMdHI5HP3OnZ3/5kWrsC5+q
v8a+OwDtYt62TTPDo+8HwTnrBqX2cmKN7RtS5Enj3RJHkd9yCq6BaqgrZb+ln+T7
BxXfahQ7i2aWW7tDNm/pvNnRWfwdu8JZ1OjwW8LaF6tA+xtOg9ezEeM9HaR/5lQg
/uVz5J6WzwZzn8IIHIDqjx96ikfxn99p/Ct7lj1kc2besUwFUCqzH+Y+LCxPH+fA
VmK9V4n1VDkowRWO224Okqo8iKIojjYy4iZkmUBQkBVZexrFlbXvVxonVE9/IKLz
KeIy1A8Gmepb7Rp0Lh3SSEaY6k9mxpSfhx420bo8bdVMSoiCB6Mekaw5euTb5sgg
YC+aZR0H7tM2oIRuuOAjodyImznOzcniFGQ3GGT2En7aWzLv+RF8yJRYJOBxhRi8
PCnO9k8TESZvH0tGFSM//JDYr+rHHvERy5TpfpW5bIavT07OKVOBpROIPs3fw5YE
1mKRHMH1vrONvJMUMX42pd0h1n3jxOYHGqItiorLN8Qayeuet1uZww/+9ocJ2H7C
otQXj0itwFvhxyEg6TPEGdEPeJ0v9avNHu9XGrArb+hGwibzcDpaUARLct0Xa8DY
u4mj271+3tE88IkkwW/8XQSG7d3PYCGszKKd2mKLU7aPpLAbY7w=
=Oism
-----END PGP SIGNATURE-----

--u0wXW0dhLkb9EY5Z--
