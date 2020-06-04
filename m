Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0C21EE939
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2020 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgFDRQZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Jun 2020 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgFDRQY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Jun 2020 13:16:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7BC08C5C0;
        Thu,  4 Jun 2020 10:16:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so6918892ejb.11;
        Thu, 04 Jun 2020 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRfOcMPoqX/KzXE7GxOg041+jurRUTvvkpUj9xJq8zg=;
        b=PICO2eizuNE5hjr+sP+gfZbBjtgfT6TtzqIr9e+TyG8ZJgsRYRn79twhZLNBltnFVh
         xi40v4Zi6ZWDfa0gVqIXH6DJ2QOxCXyjLLg+VU05S06aVohhxKRfPXTvZfu7nkw+/F7W
         +sGtI0yY5UxM/pic73mPd0M+iArKST3Dt3CoGjBG77MH61O2ixUnjQ0AqzkUH6hsbh/K
         laj4eKNzZ1FB62ugvBhZb/aJnzvO5znt7xtXZ0hbJzMGrZ8N162PhUNQSeIpyvTPQzYk
         5AIxtLv26b39YH7montDb4Inql8/1uRgqjnWneAD67kqeQYiTzqD+8vLr8QaTDkRrlKn
         DxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRfOcMPoqX/KzXE7GxOg041+jurRUTvvkpUj9xJq8zg=;
        b=kZZNI0bRqWYikcXaQTGgmXytcY9do/Ow7RpPYb3cm2CLHuKT7zFdicYnBuIbnU0TJf
         Jb5Je1PKUWpJ+qxlmYeGlfpwzspTUVixaD0Fooe8JHatMkwNb5LqojvSm/ScfqpBe/s/
         oWnoMrqKlQbdEkkCNSaDo/JLtzSFVR28N4Qjo8B3VHmurg6ZBK56s+gga27SKHuajqfr
         nD1cleVELcwokseqGojWV4gZ8zSoJj9KMSzNumafAcli8YXrBJ/KRQVJJiENI6Qjdc2w
         c6Gx//E9upBXFxvumZBBHwweKjvKA46WWYv9noAyvw2GyEK1AQrozFKFc57b4FrKMivh
         pB3A==
X-Gm-Message-State: AOAM531Riu9Jhh3n4J81xYy9PemfVOKQfnNt207W062Hm0cvQqffkud0
        0jmFa1+reOXtLJjoDvYeAmwlRHEF
X-Google-Smtp-Source: ABdhPJzunm2D8kpsHfEGd4Z/gRT3o9hShVDtznb4lQmelu3shmPowFVihA962h2nWJiE79OHs/xnZA==
X-Received: by 2002:a17:906:616:: with SMTP id s22mr4575528ejb.382.1591290983173;
        Thu, 04 Jun 2020 10:16:23 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id v29sm2904966edb.62.2020.06.04.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:16:21 -0700 (PDT)
Date:   Thu, 4 Jun 2020 19:16:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <20200604171620.GA1158773@ulmo>
References: <202006031539.4198EA6@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <202006031539.4198EA6@keescook>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2020 at 03:40:56PM -0700, Kees Cook wrote:
> The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> lead to skipping this code.
>=20
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7ZLGAACgkQ3SOs138+
s6FIpQ/9EdDHxyq+7OCwqubx0/mE/4j7lmsLu+HYUpekTsHkXckRQHO4QO7e7Ii3
MOksak4nU+QCCkG0xCDWHTvbI4BpaXITB+FjkiPO50m5Fai1YNL9paf19GMx/jvc
UrPWbYDxYyqK/hhrNyztmwqddeHDPIWgUcUeIFXHhTzAtCZoPNmLW7XX4PZwMazc
Wn85Uvm5Ydo3DON5YebxJhsbAoYzerh+iSMastl0vnTuBMFRwRSkgDU1HwnHFvaG
TaFmfWYdlAlq78zwr4YMbScJF98svgUlW9TsB6Bmzou+5U3AWfNR+hxQNhVqoBJ9
UoCFEZp7EeYlydLGrRP0/ygMoIQDbOIVtAgxlL9zttG6gMw75+IG4Y+fvY8wEYXL
GyiPzHuQ+sFODN/iSxMuQr4/oXrE1xeSi7vjppfZFIimEQw+sl/fLYxxplilJ2Q0
i3KZgxytiMySK11VUiF1i5deBF/C7JtnXiMjV5AYpsAMHqwG0dLczmWLFFJy+4i7
OxlV29miA0bt/Zuz8qYHY9LvbYQT0FGqo8hMA1CrIq5Jj47ZG3zptIjwilhL02kv
/A8/0pOmpfpZhKgCOcdEh7e19UGU9YwVkcCSe2pwFOT895xql2B2OVNAc3dfZtAf
11C47mMwG8wwSbVVbpFppgdKWonnul9tJUHh/noI4PYSzCrxTNs=
=+mI0
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
