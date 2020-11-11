Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E362AF952
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgKKTzZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKTzY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:55:24 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3BC0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:55:24 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so3335066wml.5
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gd70qSrKeFoeBcrYl2uQ8NaIJcBNWpGeTQU4+YhWMnQ=;
        b=ncV1b1nhrB7m9fQuk3wnUou7V9jrwXcdHT9iekc2MLX9gwJfynWjPrYXzpypEkMs+o
         T3PvPtQTH8dJZY6Lhq0Yi0Jokc29NXAqeutJioCxVhrtxBHbov4M5EwAB4kTYbRsLMKK
         a6TXTVcg0T+NLWnMQpeJlDaDXuiD9kBFyAIJO52dtGNHPQtFYs2P+RZCJ5aLzsvzfuQD
         TEfimxz5K05ZSplN7+kT+co5rL/SrazBUoadSJcp0aomZAcCBQQ5O7T7EV8Mx/pdnVw5
         nXhaJEMAOCyLPk8RCWjtW1V6FPT4O/lnG07Br3A5B4cLiDiztUyeTiMhAWT9F82C98/8
         KP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gd70qSrKeFoeBcrYl2uQ8NaIJcBNWpGeTQU4+YhWMnQ=;
        b=OBP5OoNB7QvW2n00s6JpoahyRjBOdReCQDNJsZ+tioPVD/f/ofGNkQ6gydJVEChoYJ
         6GMtSWxbXTrI47whCrC35e0HnAk5zmEUYTVZAyuRHe4P5mwlCflYTmMDY1ap7cSCZRKn
         VRVFH9WRHOf77RzaHAywUkNGo72q84vKvNxlVMpLK6Jemj3NUECWKzTqASDWjvi0ECIn
         mQtIR30CG7lSOVyuBMK59EDXAMSib2WSRx4q+HI3txR5sfwfxNu2V9JNadbAvB7Fv9Z5
         lKC+A92XddwtRKVySyhdTjTm7XBjWRs9HPlFx2y9Bek4nwZfKdYDLMO0Qwu1MKPghpib
         C16Q==
X-Gm-Message-State: AOAM531GizmUsikqKSV5VT84N4eFfV4t8+OIuQKeJAhZ17fKDod4cY10
        k2w4NUpCmVf8xIzslmAeDXY=
X-Google-Smtp-Source: ABdhPJwrY5eszrsaysmXZOmwUbW5gRb3i5b3zf9ayhtnh29vTeyh+BOzfhe7ssRZknvfnz0k0w0Arg==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr5955619wma.48.1605124523237;
        Wed, 11 Nov 2020 11:55:23 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n9sm3701946wmd.4.2020.11.11.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:55:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:55:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pwm: ab8500: Explicitly allocate pwm chip base
 dynamically
Message-ID: <20201111195520.GF6125@ulmo>
References: <20201106171547.50669-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <20201106171547.50669-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 06:15:47PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The ab8500 driver is the last one which doesn't (explicitly) use dynamic
> allocation of the pwm id. Looking through the kernel sources I didn't
> find a place that relies on this id. And with the device probed from
> device tree pdev->id is -1 anyhow; making this explicit looks
> beneficial, too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-ab8500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sQagACgkQ3SOs138+
s6Hleg//Sm7d/ffyFCVveUaB96wydslOJBwATUzgSbGYwq6/YjPXpMWePIsJTaRF
HTPn18dYbqu1vxfgmxI6bO06asm+CoQ3MlyQGZUqgdN6Iu5DMm0q72VRlCmnzen8
NB5jZO7PT/lKInpS205v/qu1rzRjfFpYk9qOFvxiI1CMi8F63cjc5wKNGINV9+Zn
eHG7qunY+TeEJwvsjkqqr/aDh0tS/Wqr2VWbzpSr7aAzIK0qKuwHdza4QmJ/2c1h
2rPyM06B/Xyc1sjI3iY1aEc+rjyGzIdCiYRtfzhRSrECCrX6ztSlVldTHfw2JKej
s6G7O61ZVcXpsV9o6A5/CAbm0BZhFfIRxnpwRKq0qroSqa9nMUP8fuYcXxQ3OINh
XDcbb0IShfqvJI7hkFm5EK9QcBugXfyEKDWNLXdF6W4chyaEaMLUoYjMZZseLpgs
10xBptEpvN/BoLdfRwEA4f4y3PSaatsojbtDtvJtKUqG2tqZnb9S0DkmrYwqag/s
bXYZGwjI3SgEHvrPuJQXgYKm6r8sX5PJK7wpBSGepp5cj+ud4ZfHTPOKxIYQDSuN
0oPqcgJGFbcp3VV5s6bgwprrvEXaAFzy33CmIzd/QgtCg0/w44Xyy/EjRRO4QxJF
j7kxhKiX64mLbKqAco4syTQlLTT0hhGYIEo0ke03j+S074y6lQo=
=VXS/
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
