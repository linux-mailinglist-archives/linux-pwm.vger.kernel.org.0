Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4262E359EF7
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhDIMnp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhDIMnj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:43:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143EC061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:43:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so8472060eju.1
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4hv7EigvVomRZ4Hz865t93ZKPKFvKydmgzge7Pert6E=;
        b=PmtKCaOaVyan38vp60xbGzqXDz8/dy2lZ81ciHDu7L+sNAz+Weq3rWfRVpywJo+SL/
         o+NkbueiXI6M9mkdjKSgJnGiBDKk6qi47jv4F7ANUJQmGsX75W4LsCWM7aKN0KD3JHOo
         8FH/eE8YEXdRs1FjL41kImQl4UuUzOkr4loxH0En2IMPhU9DfNA3X00vYX1uyGKT3bOU
         BuZn2lttK2em364H3DOE8KtSJPBUIp4iWXIpznUEZU2av9KMYsC1loMXn/m0bUBTZeWa
         TgP8FS5wpp6JdQSOQ5yBMECaJ/mowEcKH/81E6U5RwZdyqYe/igLu58L54RkWO0z4lWA
         LF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hv7EigvVomRZ4Hz865t93ZKPKFvKydmgzge7Pert6E=;
        b=VoPGxvDgGUUv55yZ1UDgDUSDJkqJp1s5YsMnbEzFnFJI7M8CvEpVEt3tmPgcLggB3v
         o/8PMRan3KuZ1OtZgdaNgcO3Rnjajglxcq9tmbwb1TMV6btYTojEQtKy8vcnKuccaA/S
         klqZNepXWS2QfjWRhgjVd/vZIQkR+O2kbUx91khCE3RWPK0IvBJ96VtWolLrqAUIHJ/b
         nQzUS5uFL+mnx31sBJ+nzX4ENx+5qpkiaMdxiGo1F/a8Z+R5Hi8jF8glSI8v2bQwChqK
         VSo9yrRuS4LCfQwXf66XcpQh4YWTBRCkVQTsgeLXHTuDbnwHmBKC4OIFV+Jl6fSYNXbg
         Mchg==
X-Gm-Message-State: AOAM533ZQ5XvCbf7uNR2QDgGW7+VyPUu+4HBBbwVk7RoLJ54Rv4sVJfp
        rPmZRAFgH/xYxmop3NNqhVo=
X-Google-Smtp-Source: ABdhPJwYsPKPGwyeNBuJWlYaOHotqpJ0B6BQNFaAcQlGvlaKGu44MtnQhbmueSdP74l1yDWKeGnrmw==
X-Received: by 2002:a17:906:ce32:: with SMTP id sd18mr15960478ejb.85.1617972205130;
        Fri, 09 Apr 2021 05:43:25 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id a11sm1158274ejx.94.2021.04.09.05.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:43:23 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:43:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm-kona: Don't modify HW state in .remove callback
Message-ID: <YHBMDx4ssK7LzEln@orome.fritz.box>
References: <20210326081804.117843-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KtELXXhn/L+ZQCZB"
Content-Disposition: inline
In-Reply-To: <20210326081804.117843-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--KtELXXhn/L+ZQCZB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 09:18:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing.) Also if disabling an enabled PWM was the right thing to do, this
> should better be done in the framework instead of in each low level drive=
r.
>=20
> So drop the hardware modification from the .remove() callback.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 5 -----
>  1 file changed, 5 deletions(-)

It'd be better to somehow WARN about this instead of silently leaking
the clock reference, but I can't think of a good way to do that, which
would also work in the case where the consumer intentionally left the
PWM enabled, so:

Applied, thanks.

Thierry

--KtELXXhn/L+ZQCZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwTA8ACgkQ3SOs138+
s6GsxA/+PBVF8vGi0+P6+pGe+Z52xUkuWQq2OryIw1SkTD40NwIga5Em9otplDum
/e5Ol+nICbxdcHgztgEXgpZ+5F2IAS5O8tTqbySN5ws86CQHX+CcLQMERO/RDLv1
XbHkCE52u+hrCykKRmuA3ejyusaqwxFG8AaVOqRmM4H8l40y4lJgCmshud6+fUYF
c4zGb7hmdTWgCjLN9dWrgfxqWJHlY5EDmjndlqzjCrIoa47TPv7i8JUXhA5TRtKR
Sflha2altTrqVzkPktYAUVMEyJJ+grzFCVGV0kTGN5PgBKYvSrz3PNo0gFlGyPk+
72xzvU04YSN/7JqHlZ/ysR3/Otu97L99gw9PTdqJ1aGATbSFhtf5OzO844zEpOKr
G6NBhuaed0OaBvJ9Ga//nhNghlpdTt2BHdzO4fwXP8CVw0cvg60Dq6IUFzM7n2b6
LnZeyy3Tm/vA7IL+AbKEWbb6kHjaq/V8ignEBc32/zeZt78jO+2+iYrZI+7b35IV
hYn3RJUCTw7tQzufq4+uB2gDvtAS4BM+dJH+aWyyRFaumvDsqWh6WNxt7wrcL4Zh
ASKG1FoC+hKTeoXpDvLdCofOXrQ/pIv3I3Ddt1hh+biHh00afXtKnvtVO1bBxnwr
eNmAtiGowkPwekWQfsEQx4/sb1IKAH03SOl5tmQLmHBobwUMxeA=
=iXBN
-----END PGP SIGNATURE-----

--KtELXXhn/L+ZQCZB--
