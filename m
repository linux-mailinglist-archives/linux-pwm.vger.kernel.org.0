Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733E51A7EFD
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgDNN6e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbgDNN6b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 09:58:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FAC061A0C;
        Tue, 14 Apr 2020 06:58:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so14095107wmh.0;
        Tue, 14 Apr 2020 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=shNjxK2XZi1SBgNMZlObJi0kerdnPGniLRexipno8Aw=;
        b=i3ptBY/ez3Oo/1/XjdW66FOjERVUY+KxiP/0oUYA3/TRzcFzt6p+vzYFmA3kr0stYu
         2HtKP6BexVXp6h6iZagIVX4IfEtcWFyjNYdOtfSgJy4M6Y/KtK0s2ppV+WVgeuTUY+6I
         cbOmZv+cQGy775YaEyYWVr51UJc9PHzuMDRGEygWNzPZkZNHIoJ+I/8w0/Af8g2Dow+7
         QSHVIYRdcw7ydzYMZPSb8Qc10WZB+8u63b0LjufKNjzWLWP/hQQtfDJgJzYHlKvcf54m
         hzxQ2WD9uOGJmzDxc7aIWc8rAb3JZjpP7rPpkJbqwt9FhrnWZQ0nTFS59+pD6MJp5kR5
         PiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shNjxK2XZi1SBgNMZlObJi0kerdnPGniLRexipno8Aw=;
        b=ZpwHYUgv3R0K/bx7E6kOy8Ob8RnWTimBL+NyL8eXSm5fx/nazQTxlJNGH2ONfNAdli
         D8pCJMXah7zapkBOMzjD889AeAcAH+BlAo5428Fr6aFfZP00qe6sm7zaNqW9vJX55eeL
         AOTRkPJskuJRO1kakY7WdWgnoEW2uVixO4nJUNycDTHJWmGRrLpz5+CfqzCOmt/gyMhR
         GPdyIxtFY4O9ms6HLnd+RUHqR+bnChJT7tCwEU/o/jKUlC2qbbLpfXwWTE85Xr8zTIzt
         jBdV2YyywvaTkDegO1RaX77YcGrAzSIhSiGqxta9/4Yu7QwfxlgAlUVcfYSYoN3b9xpu
         GF4A==
X-Gm-Message-State: AGi0PubkXuuEVdEIQISZEsp072AspBSKltEiMeZ902taeTYY8Hs6Y8nx
        J1Pge6g1Hl+TqO9QXzHLmj0=
X-Google-Smtp-Source: APiQypJnpCKxrTz2rJ7RiPyVd3Z7CdK6nXF5XVpomjZm7GVdu8lqiAw3ETD0/uxvcPenl+bWtJRhbw==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr45278wma.24.1586872709606;
        Tue, 14 Apr 2020 06:58:29 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id q18sm12282012wmj.11.2020.04.14.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:58:28 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:58:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Message-ID: <20200414135827.GB3593749@ulmo>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2020 at 05:35:28PM +0200, Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
>=20
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9973c442b455..bca04965bfe6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *=
pwm,
> =20
>  	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>  		dev_warn(chip->dev,
> -			 "requested disabled, but yielded enabled with duty > 0");
> +			 "requested disabled, but yielded enabled with duty > 0\n");
> =20
>  	/* reapply the state that the driver reported being configured. */
>  	err =3D chip->ops->apply(chip, pwm, &s1);

I don't think this is strictly necessary any longer since the logging
functions are supposed to add these themselves nowadays. But I like the
consistency of this, so I'll apply this anyway.

Thanks,
Thierry

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6VwYMACgkQ3SOs138+
s6Fzlg//b9ON8vAP4sRTnLHsUC0mCmY2XcrY0P5eCKvrjAivAAswf7qGNpzKcBN1
FUzY74P+qLClXRXFcciVxdGCaPzb+dynFkizSZC5wqBathkkFK3WMAjfFkjH2fe5
2pLX7gpMvlrlneBVM52ZrR2KK4fAonlQe7Xq07vKQ6K8stWmQblhGZNKXlCaK4fi
gkzWQKzHvWML6Bzu5Zrk21Z/BxPeT4gHl0jxo3ZnsHhv1ZveNkDHDLB1ybDjTaEj
p+faT8bCf4bSPp8OlpnJpP6d0yzAxcDO6gDRCEH/jaBUaZDkHEgjsSDxkL5H+lkp
s8N/kJ9q+0qSivxQyFLPTGyUoUm5C/xkT81UrwWEQMbouN7FVBelXVs9SLKfUSbA
noAYtOMxz8V4AxtUNniYyzo1ir8gqB4kZTUmr+cn0mP68WJHvmTHe/ElmC/bn8uK
N92cuJnV0s4A+5SrPi4mDpLA4FP8m2MBAsEDKd5j1tPfBY7HrHgdgZkNxSIiehNQ
+5rzl2LyBfx8rnz/Ljw02TpgJX/pNELNrM/Oa4jy3QoDiIlaUpoL5/d9QrIbt71d
UlGep4cyvSvRlsY0CZDJhABtsjb6zLix/Rc6x0jCL45rwGVLilLbKgoHedCEllvu
ueo5JO9bxbeHxPi+II1uGQ07LNd3TJyRZMVjSggpscDcfmfJCTc=
=cwju
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
