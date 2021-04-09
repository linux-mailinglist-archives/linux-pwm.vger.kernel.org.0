Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074ED359F0A
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDIMq7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhDIMq6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:46:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1BCC061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:46:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r9so8461550ejj.3
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dnqpx7c3+g2WsPdZyXWynL3h2XU6sAGwe6WIdPpXVfA=;
        b=IIpluOgLCxWVZ0fbfV2SwLnZo/f5PfUaqTKevJNrAJne6JYMrP7NappYG7Md88Xwc5
         wCgWdT7RdOFEkgawhnBks67eWZ30hP0EgLNMMXvb+m81DYWscYnboHUBvoaVaMt6/YkR
         A+UHhl6v/WjKWNuzDpSsF8/+QMLOIohoIBRtf3aSJFqhRtZ5eQAQyidSUPeEOkSd3Kcy
         dDo5DN4PJipB0pPmWUXMDa98c2krWyt3zIbyly6cvHrcAl76KHMYMNtGWF7BBuLzJE6Z
         5N7KoBOmAl0TKXAnf2TCfAZpUVGwhl+8YiLm73jAbhKH4ZzC109CUak/c6qhloMeDGPI
         vD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dnqpx7c3+g2WsPdZyXWynL3h2XU6sAGwe6WIdPpXVfA=;
        b=D93iS/P2xwO3AL9voTW9lapNyBK91f4qsLxPDGYFvClQo4RPvfVTvLchquwdQ4/ZzN
         jXvwaCDFFfKrtv72Zbj8J2X3NwGKqfU0OOpCkzikR4PmAWfHHWOzPuPRx61n+5ZrG8Mx
         NerPWi9K7Jt5Kb6yShmLBZeTsm3U1n211leJ3SOmo0N8CESteDun+oT9QXYY6q/v2Acy
         QbRpIbwm8hWmjOaL23q+G0UR2lEDM/r1zrKwBLNuJUbL+rQ1l47+eraJM5Sb0UDMsJDP
         Tf0HF6usTuLaON7QHLx2luUU8oD/fnVRa8dJpKBFvKiA8KVgXLOReuLZ0aWjMSutyHiC
         Dabw==
X-Gm-Message-State: AOAM533BQGfTTbg6qDKfD2MQYn3//cEjke/zwk40xWdD5XND2+wx0tc7
        5OXiaJRSjzVYlzvYX/NV8jmR9/qLYIg=
X-Google-Smtp-Source: ABdhPJzu5PfI2+KTp/ESDoiyTGeRtsrxbs9c3ptG2AihZpi9xVG7TiZ6Su0kC18nL/jAjZKbjphuKQ==
X-Received: by 2002:a17:906:9882:: with SMTP id zc2mr15871094ejb.441.1617972404110;
        Fri, 09 Apr 2021 05:46:44 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id o17sm1385066edt.10.2021.04.09.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:46:43 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:47:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: sti: Don't modify HW state in .remove callback
Message-ID: <YHBM14uHNylQd8Hz@orome.fritz.box>
References: <20210330123742.190540-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="97o6L8qnGMCAkvoh"
Content-Disposition: inline
In-Reply-To: <20210330123742.190540-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--97o6L8qnGMCAkvoh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 02:37:41PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing). Also if disabling an enabled PWM was the right thing to do,
> this should better be done in the framework instead of in each low level
> driver.
>=20
> So drop the hardware modification from the .remove() callback.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sti.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

Thierry

--97o6L8qnGMCAkvoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwTNcACgkQ3SOs138+
s6Gxdw/+JyezEGG6CDBHUK62GxyH3l7htXk4mbv+aH0v0gm35j0e/xr/MzJSA+vF
afK24uLrJg1Ivzf+PRi/0ahkPJMTJXpcGg8f1+PA96fIaRZCW9bJ31CSUWsr/h8e
eXuf14q+D3jIoDsMow8v48DPIDvuBLd0mW48qfp7tovIarM9HHef4DfnqnptkVtJ
QWpD/L87Hbcd40e6SvBcDZmHlXUUdNLL9QH+0ZUrDEDkStjr72U/1g8jcsnwqNjd
kN7CP5WnY3Ahx7uE+d8yG+vf3xj4mbj5LGeVyKZoWFYydl8nl3r8pN9ZToOiImuZ
lhgs4msNsXuO2pCIANsWq5eQS8GhPTX7plf862q5MNuggHAosYdokJoyemwx+BZf
cnTybiPwDYGhwOIXVMcoc43ntotX2cUZBWDFqsUVnTkBgBLUwUI6akkB2gPqkVhE
Hgk79OdJaXWSaghK6b9x8f20sOYtmp2OcHLgm8CoZW+e+YVxD2HqFmNeyd7PWVVv
VmxNkghNjmiWUDMKi1DQT1dw1OHof/b6k+WjD5htZrZqzmfK97RCcaCHTuz2fDEZ
Etbu7uOj1afBKlPhnBmNl7dSgixK+up0/bsHirdFcWlbIWIxERi7vuABTX54Jnx7
GZNJBFmBjKC7zUe3rr7xEhsfVhlvqMut8rfCim+QQpVijyJs7BQ=
=V0M+
-----END PGP SIGNATURE-----

--97o6L8qnGMCAkvoh--
