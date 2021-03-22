Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24987343E88
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCVKz4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhCVKzb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 06:55:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60632C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:55:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so3249261wrq.11
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=akMIlMrSaU0lVBKkAwfR6L1hL57xCcnRcM5zz/82tRA=;
        b=mRfbtK8UwQrMuR6ASSB4e/29SkYGoYB3JjaVtGjPxH+kIm1hBrCd0INFyT2RHJte4O
         zOF3y9taneRWYUcoef1M1+k+SOxpoD/pz65f2W5tTL/Hk2SWWfdGnY/WoHnvjw8bAu6g
         TQ/h/meFkD89UfHQqa+X1V66pVMr1CTxi9f/g+0TSAcGxN89Zds0FmQGpk8/1J88j1QL
         dAUMRBX0F+zsVEugV3Ti3EzoldgUrkQ5D9iTD1+2K1f8pqROlKrAFCrmObfGMLMA09Kc
         zyq7TnFjomk7YUH+bHfUZ6lwxG2iIwa8HF/+9JY4oSjzqcJMOTej/G+wWYjexV5h+QBE
         /oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=akMIlMrSaU0lVBKkAwfR6L1hL57xCcnRcM5zz/82tRA=;
        b=FBHQuQlIwUtDcxOjSySC9BEP0pFD4RQfhTl/JXufGFNWSu2xqhDjLSR2VlK+DVZUZB
         buGq9myxBuI6n0iErBt+68HXE3SBwlNqvt6PwmDM1hXTW1Ot3V7cqh9c9r1Xh+3anLNx
         uhE6bdVk0rnW9tY7Z0w2GnVxcBewG0532BQzopVIEP2+S83Frv6g/A37hHMmQehe/PVS
         ynMhBOJmTMQkwt6eFUtaWuMgFOWh3XI4F1/hp2t9BHGQAAopxhJnsWJ40J2LSiPdigDY
         TI7L7Avx0QJoMt9/UVhkmEFdOR6lcLsGtg1F9hxwGggxsyFDzgRT1dZ05QVcUjf9g5zj
         Alxg==
X-Gm-Message-State: AOAM530CoOmHuIC2EJMcndHpzGKycMU8slj4pN6SAKxw2UxJJ4Ev8eBQ
        TDObDYmslCDl0ljEX7jov6M=
X-Google-Smtp-Source: ABdhPJwdpfG7PzmeyWNVld9NCS6QjXP8HGTSQTlh1mhNuNy1Uztous0OeD10YS8mIkjjyPQWv1eL5A==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr17105477wrp.383.1616410529146;
        Mon, 22 Mar 2021 03:55:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id d8sm20825217wrr.35.2021.03.22.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:55:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:55:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Return -EINVAL for old-style drivers without
 .set_polarity callback
Message-ID: <YFh3sAzBjoaoRm9c@orome.fritz.box>
References: <20210301182307.1681548-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KnSfHU5QLUoBO/M0"
Content-Disposition: inline
In-Reply-To: <20210301182307.1681548-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--KnSfHU5QLUoBO/M0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 07:23:07PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Since commit 2b1c1a5d5148 ("pwm: Use -EINVAL for unsupported polarity")
> all drivers implementing the apply callback are unified to return
> -EINVAL if an unsupported polarity is requested. Do the same in the
> compat code for old-style drivers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--KnSfHU5QLUoBO/M0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYd7AACgkQ3SOs138+
s6GArxAAsogoU/mmzG+wTwvl8z1uiTkJY4hbs9Oa5LaKes7yE+EC7VrdCIEgq9TE
HIVyZwJY0Xh7iTJicUbXJ2LaAscGt4JmTFAnYrlomLRzvafCGtNqpSe23IDkwmGw
CfHQpJKa5ZWbh8YLKr9IdGX7zVVDXBdjGwfsprFosjD4blQYJB9RccZXBNClrDOc
xFiPshRbn0pNf5qhaneOFP9Zr8peP3RIIF+ELdKn2i/cLT66hmHnCp3IDgZxeFFe
wr+dx2fKLf8x0b4Wa4V6mMagCre5JPHccUbt/8jGu1PD9gy2S84NyMJPlNh81UzW
71VsJRwOHQc/TFSTt+PDXwxoOF7d7lk7jqWhWoNttPH1GweqQUI/dcGur24fjkSV
Nb7REwtj63A1SqP66th9bf8yWxghk/Y13l9erYk2nhUO+jpwLyweFnSFEAgIOoUX
ttX+r60hnRlM/iOgOsRzAX+cFcDrxi75eGEB1Bify1xYFDma/EKMrySN3bOqeSTo
ufZ+B9b73b/nEfQwjvhgrVd4mgmtRqAXIiYz4xUwrcwUA5j8BROrDQEyLCP27I9x
jVkW4DduaxtaelGfZM5LoVNko5qsYi0dDmZS7Oochxq+F+4HkC500qnq+kdXxsLo
PsOwMlt6vhmiwnFUveVQnhv6LWI5hCopwFHv+NmW15oxAciqx1c=
=tWhF
-----END PGP SIGNATURE-----

--KnSfHU5QLUoBO/M0--
