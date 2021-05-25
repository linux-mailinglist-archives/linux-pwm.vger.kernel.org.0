Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21A73906D0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhEYQoP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhEYQoO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 12:44:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6791C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:42:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x7so13332666wrt.12
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KppPkaR3SguaKJQIGXV4Xu9+ehtyN7j/6ynR4oesTo=;
        b=Idew1xlNMWq6bOseDjcyoRqEqvOAH60UUZA124wbvdCWf+pLtdmKP6uzQxc+rVKjjN
         Pznr4SDSr2zEBd5hWDWiaDZ0IG+JExaxyNFcGmaFZfnJe4oBDbLWr6WAYmZlGPDQx3kC
         HIQ9NA0VXMwJE8URIR9h30NUQxJrgxDLfKRjKSW1p8G8MlbggQDeRQBKsi8Nz/0cWDBB
         63I7WSx/NsvyNA7M08CwiwP1M/iREYnUN63fXA95Eu8RaU/KE9OmwuUbm5Vd4paHrmnf
         EU6uJB7+vwVI4bRQ8sgpWnYJ2hYkpYm1A6jMSLNxQ2p5Cg+otrW6XkkdMGHwx8/mg5jR
         Kovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KppPkaR3SguaKJQIGXV4Xu9+ehtyN7j/6ynR4oesTo=;
        b=jmiQlBTqgrAS9bdLqB1a/SgTsYZ3a2WnMDP2ttinwZV+6JrISaqfZgqdnl3uBEy0aV
         xc78X/XSfwTCHg2SZgp9e3AwCi5KAh4g1mhHQEQQ3cZ2SCmYpI5EJQGd/7sVPVa0mpLa
         5h9hzasyvHOVORvSRP8zZHyju1+vAaPC6CKCgtAp2+BgNymD1PBXldj3VBCz/MUL8cSa
         RiV1Vtid8kQlJPTKW5Z9u1IDezyVYmWi+XxNrzvUUEF0AL25nbbvFolB+rCIAqqWCqpC
         S8aNORa60WZZS4qxIf+HGDxGvDUnA6O2IpIP4f/HKK/ZRbUamJ2cecYVE8aNUlOLbAkS
         LnDA==
X-Gm-Message-State: AOAM530KX7wLYTsnz7bKCIzHqvP0c3yg4tjH1+zAwQu436rBbuAafNuB
        e8Q6+XEXUkx4GR+VJgN30os=
X-Google-Smtp-Source: ABdhPJww/mTGhgIGx9YjGA45LnLd7kg4tlGO/MIdsdhO6f2WTLOTYL7Rm/0KXFQkz5/+bf251HAnsA==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr26205321wrs.213.1621960962341;
        Tue, 25 May 2021 09:42:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t14sm218196wra.60.2021.05.25.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:42:41 -0700 (PDT)
Date:   Tue, 25 May 2021 18:44:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 0/3] pwm: spear: some cleanups
Message-ID: <YK0pWpXM6Ugeb1gZ@orome.fritz.box>
References: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HvnsdVcWd82IB2JB"
Content-Disposition: inline
In-Reply-To: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--HvnsdVcWd82IB2JB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2021 at 11:05:23AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> while working on the third patch I noticed that the series I sent last
> week introduced a build failure because I dropped the return statement
> from spear_pwm_remove. So patch 1 is unmodified, patch 2 has the fix to
> make the patch compile and patch 3 is new.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   pwm: spear: Don't modify HW state in .remove callback
>   pwm: spear: Free resources only after pwmchip_remove()
>   pwm: spear: Implement .apply() callback
>=20
>  drivers/pwm/pwm-spear.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--HvnsdVcWd82IB2JB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCtKVkACgkQ3SOs138+
s6F+CQ/+N/R/lcoJeHz4hrClMtC/wihWvXqDJ+rgL6UuxtWc8ifC2zV/A36Zyr3A
EpJWi5NjHC2w9siCd4ETqwdiWIn65lrffCx60yDU4NVG3smvNW6Gvm28i2nLyRV+
mLtsTsEozwkfROaIAxno0zIM0TzRF/WdAyml6yoJjvkxHcwQTu8UGjm88TefFwLV
zIK3DWCfmykXR64CrsasbEkj3PyN8db4MiQSFNQzUV2BczpEUZIT+NzvMUWEw7k8
kJAG6L2z9WbZ08YCfklGeVsop2sVYdf+tJp54P/JU7rB08oh6AJtUMSfYXnJwHLI
dcDulcAdr+NmkJE8+9x98dow8hHLHoQ9RGJ/8fIrGmPLXQIFEy+Nfp2tmYMf/YCL
fiOqwuldq07qCOsAHh/iLlXcE2jjpjnNdbv4tpBdqLGxRQT7EUhhTv3WFkatOS5m
Ky/SOB/WPQ88o8b2eq/UR0l2JhwDQME15UIhegEElKxE2HtkdRWKn6sxLrdEsg4i
48MpibCgNg8Ph0+0aHZjKeJc4gEquQMEasR0YOCeE/EFV1dyXM6IUrabxbD3yWz9
wwXbzcEOSEiNH/McJSzqoODzyqUdGDO9SESxQuFKUvo6TMPkFfYzRqSXsmHJmOhA
wWoxilQAzwiEVakDuASc0c3W756At3GVGSsUPTJJ83RjhhjNlMA=
=OepS
-----END PGP SIGNATURE-----

--HvnsdVcWd82IB2JB--
