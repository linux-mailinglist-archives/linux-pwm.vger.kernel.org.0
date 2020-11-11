Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433672AF7AC
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgKKSFo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 13:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgKKSFo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 13:05:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42BC0613D1;
        Wed, 11 Nov 2020 10:05:43 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so3196912wmi.0;
        Wed, 11 Nov 2020 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuVJl4bZiFX7Nolk0H+UJ3kuuE8OxwQA0lCB70NPHZw=;
        b=bHK11M8WNGQcw+bJQ8fqyLO9MGOhzSrYXmJqO5+k38gQRv2TakO2CfEsWQeUARhq4G
         rEevPpFFx9IVe4ctDCuljJd6BYWoVWf2e2uZBJWXUlYg3fUHFduqay3RaCqWOmap3Nud
         SpCJa+yloPH7D/ELREBw2i6/bgKXfLUtkvYWbwcG2X6DeoDNe4jhmjisAZdrifyakUDx
         syR6fLlVkCOwRMRvHuK2PDQNuc1Y7b8CRsqhSMqaPdGcJdSXoXt9VMg9fTfp1F547Ijh
         VtC2HgVhC6CYtqgx1Yd7sTl+GDgvrahT7bxi4BEYCFvhbH0XeAzR3rd9oAHuBOn802cy
         Fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuVJl4bZiFX7Nolk0H+UJ3kuuE8OxwQA0lCB70NPHZw=;
        b=Ud9f3eF50baTOR1JTUPvy4jDmV5H0thwYOLguPbmu7RZ37miYPobLghcyRg1wTokoh
         7P0Rl4cwPm+rdyVv2abqpBhBUAEraQx3yuLLqbYTzgUuyOOYG31f4a66rulZ7HZipduK
         CgrjoZUdjwZRGiZayDG2XyhGmdc8A24T7CEaOSz49P/z9jYiwHKAlGbc87GO4tIqY+hP
         PT+VaRtNLeeHsRXBV/HzXUfUhS2lBT3sO9x2Q/eMsyfEeproixexMeZOSo3IBHBK/PUh
         lGMdBshUnuR3e6qCMWHQFrq7ZyncCupjT0mLSNeRP4rNrD9zSLks3phi081cVzWJgM1L
         D8Yg==
X-Gm-Message-State: AOAM532fl6vRxbToDCsmwbtNSmxX+1sGN40Yh0UnG33MQIeZ4wtTamON
        lWOGlqGZTVih9eSi421diZnSUPUD0aA=
X-Google-Smtp-Source: ABdhPJzdTZcitXpMl8CJmQD6Quq5kY7tPcTa9aRHAiRiCRMRr1Olb1vzxG8GDRmFWOkoCgOO6mBqLg==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr5823748wmh.54.1605117942572;
        Wed, 11 Nov 2020 10:05:42 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n11sm3340274wru.38.2020.11.11.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:05:40 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:05:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Message-ID: <20201111180538.GA6125@ulmo>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 02:24:30PM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record t=
he
> defer probe reason etc., use it to simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx-tpm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

All three patches applied, thanks.

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sJ/AACgkQ3SOs138+
s6FpCRAAknY3bT5bDpcO4yXyOi7Th+7KGXTT9QyZeC5FbxExhIzmd7xPqEERmiXo
9mEh0L4oQExH5W8b3zQ5ypDU7ezO+dLpvcf58QbIUNBWJXEv1GnSn0vMhhxxfi11
XjJGjtMWeS9IocmALpHLYPaV3++Wv/UP4WBJfj7op/UFglorUz49ALPDrfH8PDFS
1jcsR0tWRctJG/lmfJ/6dBoX9HEENnG6w3iLgyysYWWiZVIscriDdwuc5wgz5PYP
st5FDXLf64e6kZvNOOw0bccXgLLGT8ZgkQi43DTl9NB72VsTKbwTmtokYTAnhxj6
uouEqhfR93MTmnNWc7IRKg6soyLssdcHG+xEKtgOdcxu3L6AoND3DBl0b/rI7gvn
KJoTOZj2BJvkFKFgxY/a+aoKSKxlX5SOgzsc/DPyQDCudZGwXbt/YLpeMShY5mS7
6oseo+qQFP6eT5PNmee8C/jUWgDPowQ9wF+Fc3DCQFqjeZhHK8aOw/Wx73VYGFf2
CcWmjqwp7YPkiGh3oVtwX4nV/0c/h7xA0oehZ95GY7W+UionVayKvoqbBNbS3oRV
QtUgi3TdyHeh4uf0FIGXEYN7e92bfZdLy5fSpeDjbOW30euUbSrOvCvI+4cKjp3p
P/rLq4IxpwLHe7uS0WkL+UO1RjhsHl3c5UaencBelNxnoyYUStk=
=V7Fx
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
