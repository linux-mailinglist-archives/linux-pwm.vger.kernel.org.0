Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873B3906A5
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEYQaE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhEYQaE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 12:30:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E0C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:28:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t206so17113525wmf.0
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptWyTTfuPTCdGNJu7tIG6u93uLJrky80wOvjfDjUMFc=;
        b=L8szNu57VXJDvv54DLBR34gPbfAeUnbZk/9vuAjZadxCg0/x1cj8VSOfW4lHL3BiHw
         zx1luGIZ//Ghyuw0UzabfnjoDy6Aagngo20Ys8hqmkmpDf4smY/EQwzyFh6dEAMWLi0q
         9ZBV60qSXVmzxa7dEaB9w8H/g6FfmQpKw+q4SG2oZwuhyayZvJaZ22vd7BuRIOVBdsiV
         fHtZm10dCKjiIYy+yjASo2LtEwE/q2uqfIgHXJn4u+4K/g6PiOfOatZFzsaW5pfJz4Hv
         AJt88+bS5J5BM/Qa8hvmB4br07yZZg2Ks4aXAmQwCGKs/DLeXqAAs/YJbuDaCKsKxrv7
         1y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptWyTTfuPTCdGNJu7tIG6u93uLJrky80wOvjfDjUMFc=;
        b=Q924J6d/+w4jIgURmgr0UexbwuuPbkuem8l+Dct1i/x5K2FcXj7jyZh+rJw2jy1jZj
         9gh4Sy/aoIxnWztp/WDsqbM6rp/rZvs3+DkQRfIgWPkzgrSQhFN98gEiI+zxlEK8lWPR
         /mLgJ9SrWnAnc78uDhB8yOK/qSRsa12/jN+NjHF3VWfKqB+HWk1nDpYxzv6y0B64Q0n6
         nFY1mycZ9LKcbW8hqBYSNKqUdeTLKu42gKMFRSO4R0Y//zfqEMMMBJBxxh7+mWx9vIpZ
         BaaS7Z4MSyPVmnOVHaOV9x5APN9YxkuYEoMKjtdQVc8N2Az8MrqXTrBjvBgXa3GkAlpf
         68oA==
X-Gm-Message-State: AOAM530ZxMB8iVtgAy2woQCXPC69114erl1J0zE74Vw3Mxgw7Tgt5m2Y
        BuPVkMLNjIK6umwDzQZVVXU=
X-Google-Smtp-Source: ABdhPJwXh0YHogXb+oVMuc1FLE14KKPkRP67kNHKpkzIG4gQHX21Nh1faT0ByrVbmXPWzinNJq4SSw==
X-Received: by 2002:a05:600c:209:: with SMTP id 9mr8148637wmi.92.1621960112604;
        Tue, 25 May 2021 09:28:32 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l16sm3544023wmj.47.2021.05.25.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:28:29 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: visconti: Fix and simplify period calculation
Message-ID: <YK0mBTy1dC6mi0PG@orome.fritz.box>
References: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o0sHJTbUVbmmSKIb"
Content-Disposition: inline
In-Reply-To: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o0sHJTbUVbmmSKIb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 26, 2021 at 05:03:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> With the original code a request for period =3D 65536000 ns and period =3D
> 32768000 ns yields the same register settings (which results in 32768000
> ns) because the value for pwmc0 was miscalculated.
>=20
> Also simplify using that fls(0) is 0.
>=20
> Fixes: 721b595744f1 ("pwm: visconti: Add Toshiba Visconti SoC PWM support=
")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-visconti.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--o0sHJTbUVbmmSKIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCtJgUACgkQ3SOs138+
s6G1Cw//RC4qpnVWrcM1FHGnNTp28KWXYRB0lV3CTMt/DIfK7OFRwHYXSfBDTgsf
/4Pkbzh4l1xjAUzaHY+e9SyWvlMHydFPZpz7khNTxQy0+MWi85XFHDig55CUUQ/Z
31avHSgB7qqmea2hYh3oMb8CskUKYuxG1jeT19FEUiU0oVJJBIKeMUwQx2IDukCL
CoeqJYO80fnpwFsQqDAfRKczNyoIcbe4W9208ddGUWOu5Hxlktype47bUZBH5Qbt
4ZIiHu+24KreWP3luOc5ryXs31fcgjFzmhzBomI8PcEf8T7S34KO5nv0INj9vcyK
EnEto1FfcYE5evKPx+8yEpbl4OOqo/PBrBgK0/mRhYYsrtpcjFbaskVJGJyEQl6C
IhhDiIq5ZOIfnCE5q0puQLQhQcQC3egg8TaSmrrDc3N7M+MbjT/+SS286ufeCrQa
NgIOA1imsXfQ5cwO4/ann5uZ9E692ZulO/HVZoc7jsWDO6OjojZ4nSC3yRC6ohGm
l2tKRvyubanPetWbMh3s8roGqsxUHPmGh6yiDeQfmSdHuImpFQEu3Ar6PdSFlnF5
Rd2NarMBq3n6RG3pxUe7sv/+slgI9FTX2zxDUNPCTA/AdUSvBg/R2dLZeU03BSwa
21/kYF4OXwgBf+b9QS2H3/NWRb1Mn2HoxkIIANPM34HYjNfSXJ8=
=BmIu
-----END PGP SIGNATURE-----

--o0sHJTbUVbmmSKIb--
