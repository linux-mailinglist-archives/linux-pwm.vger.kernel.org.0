Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F28359EFE
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIMpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDIMpW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:45:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2542C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:45:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u17so8471734ejk.2
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uFrAmvVhXtk2ChPDjs6oCrhCmaVkU9DLEYlRJhasW5k=;
        b=q+NB5wTYmtXM1q+FJzHAqkTjKNWoGjFjsEsTdIFn3HDcTbDPV+sgp5wNkIsRXxu1tj
         ENssDBSy8vPpiSOlj4yYv+0sZSniolLKnkAPrnAs2zTcOeKUlmlwLwAtAFMiV31tM+cJ
         lFeDWICLu4Eo7PUnYKLj44c6XDtwgZLpqW5CUuOYf8WYLj1d9rr2wrtQmSzMR3vvRuYl
         XetULjfE1NQ94AaceQEkOQlESF3ffSe54IyyjId42msBVw9M2QATz7cKH2SbQuhqb+jk
         4wlHUS1vIkBb5ZMBgQvmdvs85mgtMI7UJVnGzQZG4WXa6Ggn5sfVkcUxsICCQjZ6Pt3x
         0idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFrAmvVhXtk2ChPDjs6oCrhCmaVkU9DLEYlRJhasW5k=;
        b=UuoUEw+FOEEMJmnLwu+koSTBCMt20OHRjpKjoiFm9e3mrjOlZysjObNatoROnTdPUY
         FL0G1rP2Rw5foNz6BPjmEy6p7TgL3y0H7TO8xmBUqdWIKiJ0oDVO1lUxvksTP43AAIql
         +mkaai6uEtswu8RHbzJWzoP1uOJuObtilkXFdKxmO532ymDKpwr+d+vCGFREV19JlJH8
         kpOrmJSNSeHk63exATdSyMYIjFRvx0+CdIe+xhFe6VyB7XHyYwi1nqvhdXSPCBdx/yFi
         PBNu7FU1/uryOCT970LAjBsEJ3Eky64kDLJ3b0vSQFHq9c/5IJe0NaJH97S/3AY/HH5L
         2Y6g==
X-Gm-Message-State: AOAM531UGaDooEuY86ipa1AmUq6/PuPckTQu0Gs5HnmU+xZa/AcdX2h4
        Q/t6fRSHWyk1TO9oG8Rej4I=
X-Google-Smtp-Source: ABdhPJw0oSFhxDYX4OiN5YpFbLMHFU4Z3htscqOFyipYHsqtBuhic0+ZDTkJKjYxR5virUoMeyTqhQ==
X-Received: by 2002:a17:907:75cc:: with SMTP id jl12mr6233609ejc.52.1617972308619;
        Fri, 09 Apr 2021 05:45:08 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id lk12sm1211483ejb.14.2021.04.09.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:45:06 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:45:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: lpc18xx-sct: Free resources only after
 pwmchip_remove()
Message-ID: <YHBMd3+HTvxwTmtd@orome.fritz.box>
References: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bg0Dq08RZigFrxNw"
Content-Disposition: inline
In-Reply-To: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Bg0Dq08RZigFrxNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2021 at 10:24:28PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--Bg0Dq08RZigFrxNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwTHcACgkQ3SOs138+
s6Ezyw//Qwc55TsZ8UJXJnRGwXNd1qScZ0wwmF3zYY8QrRd0WOWrUCCABZEoxlRt
xeU1Kwd3SM5OotMQFLGlh6/9uHuu/ceUNcfNWenbsDJwHyfC/CeasMu3Iim+i6Na
F/tXFAFY971xB0uLGU6mia/jLSNhIjFXwhk6IMtakc2Wba9aFFGbo/e6d7fYeUNu
MoGQhWD6BNULP3aysRiC4XynX5iyfkTnumKYZxugxeK3z5sUbTJEYDJ+f/IOIheh
qEXApylM/i+7/a9BYI/X9q1JJWbtlkGIrISNpwwT8u1M5lUSKOrSmD9NgeKAc7CS
qhFRZwaSR8tDVcJHidUBrRU0laV5vJhAarZ+SDQr7PwKnWwJ8ts8CzAEuDEVT3uA
FgPsSBV+A7P1+U3lsHBY4jvZAr6+fHYgFieKIikPPfcdjvkbqKYndL4+8qcNRShV
sgxd5zN8qd7ge6QdZzkwL30LjgivU6czzFr4SojpGkSI8U5/I7Ytj8oYeBAzWwjR
YltjrHRkJlI3A6OajlTAUOTSkquUqTCPOan83L6oynrywLXttItRn2eSuQR64wpW
ZiYngNuI99818ehl05XiZ55jeM6P1BVUotMQArHRak847mKx2JWHQu0lzbqGquIe
qopLt4b2zppHcbMZruvN68ESMY8HsSaxTyiD1X9XhwXLjLyp0nM=
=eyuA
-----END PGP SIGNATURE-----

--Bg0Dq08RZigFrxNw--
