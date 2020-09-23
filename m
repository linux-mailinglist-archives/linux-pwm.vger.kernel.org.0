Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDE2757B2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWMKY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIWMKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 08:10:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A337C0613CE
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:10:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so5036882wmh.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hXHK8DYTWr4N6tWLZblmvgiOPUgo6HEuvbuJGMuIIfU=;
        b=Eit159zWg9PG8wR5d1aX9d6iVPwq2bCvYcFHV9rp9M+5k8qfpr6I1xQ1LAHd3MRcpT
         +6MgOKzq7qAh6Hf9cpY1udL1VbG7w69y1QVl62IjH+0Q3GgY8Rpib95X+jch+1YQ3UUF
         H6h9G/ib+NKWYK7BRcpxBf/VslHmPD0l3bLCbWuHBETkdl/PbAYsVhwYbR2uC+L9I11N
         gbzMFbgl6N6n3Ecet7Zy5Id0pnUnFoeMJ7GxpeHBnWhv7ew+darE9ei7EcbTryCJgwC+
         LeUwoRqTCEw41tMERDGenSLIKF1vH++oYmX/Knp/IIV09rjvs5Wxa+FBTAXaABcZOPIE
         A2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hXHK8DYTWr4N6tWLZblmvgiOPUgo6HEuvbuJGMuIIfU=;
        b=BDuidxmZiTC/9Yr+sD/a9Lt+5qbLNwGnOlzx3FVJ0pJyiWsetDEWa0Yc8sUjxzpiG7
         rGtfY8XZMJfHJVovgYRXTIGS+7HnoOwBS8UlR36JSlPKwBYzJtIpJ5PFZWULE+a3klqr
         AEI5+xvuR+WOEkKSTrgKyEd3WxdEjISMTe5gTkkUck8UQcCMWTuqnTWHLoL89L+rol/W
         McJ2wbjTL0O5GJhTQP+8qq0Gagx3CyvqLdSSoIbAkUFrvg2I8r91WIFWVOsenGyE9SHZ
         NuRD/odWwB+H1J6xGT9OqmZwybdPosGRWuzgGD/cqZzQxmZ44ZXQn0DoU2RziwxYcT1D
         Cf8w==
X-Gm-Message-State: AOAM531lfLOSmQ7QrSSpMz2XdfNADVKu3iDTOHyh3Il8W9xo8aTXsMRS
        TlH7bBBkzcrGlWaKJxd5Qgs=
X-Google-Smtp-Source: ABdhPJwqGsN28iw2TfERNRAinFVX8momm0/pPax6aZkTv5HkKAySt6xW5cxPCE+DcjnOdcni2vya5Q==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr5964279wma.132.1600863022976;
        Wed, 23 Sep 2020 05:10:22 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 97sm32112021wrm.15.2020.09.23.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:10:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:10:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        ed.blake@sondrel.com, linux-pwm@vger.kernel.org, wigyori@uid0.hu
Subject: Re: [PATCH v2] pwm: img: Fix null pointer access in probe
Message-ID: <20200923121020.GB1848911@ulmo>
References: <20200820171425.7106-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20200820171425.7106-1-hauke@hauke-m.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 07:14:25PM +0200, Hauke Mehrtens wrote:
> dev_get_drvdata() is called in img_pwm_runtime_resume() before the
> driver data is set.
> When pm_runtime_enabled() returns false in img_pwm_probe() it calls
> img_pwm_runtime_resume() which results in a null pointer access.
>=20
> This patch fixes the problem by setting the driver data earlier in the
> img_pwm_probe() function.
>=20
> This crash was seen when booting the Imagination Technologies Creator
> Ci40 (Marduk) with kernel 5.4 in OpenWrt.
>=20
> Fixes: e690ae526216 ("pwm: img: Add runtime PM")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-img.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rOywACgkQ3SOs138+
s6F5ohAAv3pwVRRgh3oLujBcoGKO/C56jLlTEuTTRcaD2J1VnIvtg1RFVlb2w5xp
movMV1TaDnRmK0IZuVpNI3ZvG0amfr3o11JfOitzS5yUyMEHTag26LZuPTOEX3LV
rA9BL2aDJNHqNMvq/XfjVN3rqb3h0t0IHcYnjiqfNBml4cgAsLbczKgu3DSGNXgT
lr4tPeS0AAfl5w15AWsKK9mOPTG0faFjserY9wAuMaVDdpXdAcG6smxWOIPYpJZd
vBRcuesPLcYf5kGaV6nJgpg6pzIb4D713/enN5KVNKpTNKbfpCxBb3RKII44hCFY
D/2LwWTnh7s9fo/yUuGavtjcyuZSUetichx8z/df6u/8Nv9YkY8vKznQAI8cPrtg
ePgAaPO3wMO05Tac4D7YDRt3Lw+9mjrCtq4CpYk/gID2ydloHZDM/QMtTYnsvlLD
4yfLfQp2ixwB34NClsV1dfGGO16ldie2CQJ3p2EN9W2Iy1uxYLJIMvlYhBYrWdWZ
aEPS6Buu5L0ua6AetdZhgjLUw9Hf5SJLrW1KaAKQ/2z+taC/GKMxq3aWGt04RSVL
/3JmBQ2WatMplI9Obj6xL968WKXvs2mkszTD/L9QLO1QwZkR5BRC+miwwBjVYUxC
OAqdrowL+e+IRrrYroIFX5L1OhO30Vao6FuHYI/CQMaS60T5gYk=
=lvXb
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
