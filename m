Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0842D63C7
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 18:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbgLJRjF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392851AbgLJRgc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 12:36:32 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9888C0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:35:51 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cm17so6419792edb.4
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YidQ8Bn2clvRgJiOV3GZKfSuahtQ7sFBrZFX8v838U4=;
        b=ARkBhNvPp6yMq9o2wAh7pWOyrKR/ftO8AsUo/8t5IW8E+KuzOZMhJe9CdxM6pkktw9
         oprZb3BQFlq6cLfHpZPUhCF6UAnBKSYl7kFCS+6uAVJZPC96I4njxKMHXr90AQe9k04D
         AItOMznnfYH3wvFKQGu0lXXTIFVeO+e4G3uJgQS7rn1POM5/2qdXasmI/UJPwudXenkL
         IA0X95eUtmWLqAfa6tl1VS9uo6QtNzS3HpcBhuxNWi7gkcuMXM/FPv0B+5PZF0T6+vLq
         7aUSRvMYGWvzRYYEzu8yl47PLEi6/uwa4ArezLYr7XdzkdemUtK0jAS+z0qT75d/Z2hC
         Eucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YidQ8Bn2clvRgJiOV3GZKfSuahtQ7sFBrZFX8v838U4=;
        b=fo3dsvv3UxhLr1y2UVMBSR8CUUIkxN2hvPI/oSX1JCXpSz+5t9Wl4SkwhBje9ZgK31
         /xX68UFDlMx9uNYYUrp2xhJpxpSg9D55AQ3Jz1y/QGUCtvEgOSU9ZaFjDvRDjZZMt0Ek
         7KqwcTX3Q/ZiUasKt/huF0tMmp+QrNsxBNXH+QP7ef3Yuq4MVEx5sZnXDtrQn+tt52eM
         Q/G3F4C7TemMtyDgkTMYCEym60w4TMHuVO5xQ+bFxnFh/FfwTYjcvOc+mVU3QzxskAYW
         nX0rEfu5bKk53L9PmBQBFigDMHUaUqkbCP1ngG9S22SaxCiBsuFIz8C154xRjWOeLqoa
         XX3A==
X-Gm-Message-State: AOAM533b9QIwvtsQVehKphR9vkYp6+MEdMlza/yvyOdPL3I6oNJDeo6y
        OiNSPaEXUgGwKM26y5hadYh/wOk2pRQ=
X-Google-Smtp-Source: ABdhPJyGtbGi5lEOLNNsAX21SIMxed9sK20ESJJc9bAyG/Sk+pHxC8pmJfGhWAUHJZNl7Y2RtxH/Gg==
X-Received: by 2002:a05:6402:48d:: with SMTP id k13mr7807901edv.92.1607621750021;
        Thu, 10 Dec 2020 09:35:50 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id qh23sm4684825ejb.71.2020.12.10.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:35:48 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:35:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Remove unused function pwmchip_add_inversed()
Message-ID: <X9JcdNkS3s1cuTBU@ulmo>
References: <20201205161924.3864915-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R5ja9NEbZhtujAM5"
Content-Disposition: inline
In-Reply-To: <20201205161924.3864915-1-uwe@kleine-koenig.org>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--R5ja9NEbZhtujAM5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 05, 2020 at 05:19:24PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is only defined with CONFIG_PWM unset and was introduced together
> with pwmchip_add_with_polarity() (which is only defined with CONFIG_PWM
> enabled). I guess the series that introduced pwmchip_add_with_polarity()
> had a different concept in earlier revisions and the !CONFIG_PWM part
> was just not updated accordingly.
>=20
> Given that there is no implementation for pwmchip_add_with_polarity()
> without CONFIG_PWM, just drop pwmchip_add_inversed() instead of renaming
> it to pwmchip_add_with_polarity().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  include/linux/pwm.h | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks.

Thierry

--R5ja9NEbZhtujAM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SXHQACgkQ3SOs138+
s6ESiA/9HebpaO7j3EnOli1IUp7U8qGxLuwFEAD58sA8UptWgwuSK7ckPvG4MiOo
PK1s3e2cplMRKqjl0+uw+qD/1MRj8b5/I9dvzHBEargJ3A8poHexBUqxENSJH2ci
BItu/ZsqM+GTqIDaNme47hJAaa/fKa6CyuxOAFD9JN2Cm0VZTV5Ncxcc3shurOHN
VN/3pLLUiusXyNFRIAS8aaA5WzHywFNJ0GUHZzC6KuSkUHgdqKU/ZMgFjC/b8wCn
DB77PZ9PsZlzi9cTZ2Bdwq5V+wjTRiorAKDCYbumLMn9NEm4O03VcoQ5GjgZWeMl
s9i/DXw1LHr25K2FFAaU6+41UkSkqZ21ztwBu7HedJyFcN6eWlTNYRrxwB6FhMCt
dUwg8U9k5PYA4ZbaGwy/MipF4/tD9ay6cNGy8uZhLao1bVxSXzUpzEjucCXqyplf
TYam6mTl0PU+q/AX/qkeiQOqx5nLbIZJhdRS4mF8fmpYA9lNfc8tlw98pWpw9NSY
BzLmuTOxbpzACuzV0RmN/yVDp0bMUclGCh0DxG2kepYsd8QDMsekAv9Oa/vwnTOW
7yfPvtCZyrKfrHeIqUvq75mydZWbJjKYTvMbPJfGOjhoRbcGNnzi7Ugz9m84b3po
Q4r1M6Wu3Xc6trCehTmxbTt24TujYwb1CnjbRF8rcKGkWyqWxaE=
=znbd
-----END PGP SIGNATURE-----

--R5ja9NEbZhtujAM5--
