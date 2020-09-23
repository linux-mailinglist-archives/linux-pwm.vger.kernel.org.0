Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2D275791
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIWL4x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgIWL4x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 07:56:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD00C0613CE;
        Wed, 23 Sep 2020 04:56:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v12so4990274wmh.3;
        Wed, 23 Sep 2020 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tOBth0D09Q2ohz0j2wZZGcWNbpN/CnOM5eGjkWWAsLQ=;
        b=SE3i7wQW4V4/wRrHpTRwp84+3pPsubU6E/fbdEBGRPyuke24HhlsPiJyeeDbhgTxPw
         brervCVt/e7d22HemQeXw02nPPkwSDJelDjbMuMsLvRSbxToFZ+jT6h1xFyr4j9wdjCg
         Jci/YbyGG+o2EYBTK3s7//0lxwSpnpOrCSDi+6zyqZy3g+8m727odWctK5NbbqhNm/Mx
         yFvq01oL9gex+f2iiT+outzxzs1Fn99N4bRxr1t0Qhmg7by2YNF/vGn2iJFd+cMSefqF
         VDw9h6qI7nt5KLPxH/4+5z4hrg8x1SC8nK/FXDe3atKixfaJYT5cR6HG8csfJE4TUqa6
         S66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOBth0D09Q2ohz0j2wZZGcWNbpN/CnOM5eGjkWWAsLQ=;
        b=rjWba7LZNg667LcToZDBXNAu756rVth8+tvp86LLMGToF31kgVdLqpBjKfTnqpsCRF
         KIcns7yDdeAmo+r0jo+Co6vqg0VPXMmk7yfY+ZAPeTllSQtsOCTnvSfjZn8RXFyAE++v
         Yetc747cg0jqW6j3oGTLstcYBx7EXbr5SmzBmXw9dqIpAbr+negcFniFe1P4mhzFNN3C
         3g67Hi5SYC8keaBrlcX3af3BJG1D76bE6ottv7BFTxf2xBp0wZMTV9Y0eVIOSrNXOKkw
         rFOOsnmHvGO/3WqGXFnm3zuVQVRTMcsqr4zOXYLUiKaVC7mInte+sy+/B4czBQ6AzBg6
         BZkg==
X-Gm-Message-State: AOAM531kLKFeZtIGA0dowXnbNz0G0+MiglzIUxocHvl1ILGAl2GjCVtY
        y+8+P98pSMTITayJt23I7pc=
X-Google-Smtp-Source: ABdhPJwzQEEhuY5BhaMurNBo25j/Q6GtAS0fHVF1YvSa002dHdLEA7XSd0jDKiFDhCMVXUckv/5egg==
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr6318419wmj.6.1600862210715;
        Wed, 23 Sep 2020 04:56:50 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v128sm8066512wme.2.2020.09.23.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:56:49 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:56:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pwm: convert to use DEFINE_SEQ_ATTRIBUTE macro
Message-ID: <20200923115647.GE1846003@ulmo>
References: <20200916025028.3992887-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <20200916025028.3992887-1-liushixin2@huawei.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:50:28AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pwm/core.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Applied, thanks.

Thierry

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rN/8ACgkQ3SOs138+
s6FdMg/+PpxSMiUTcNeuag9gJv4t0Bjl/50J0WI4uX2d0/0pF3I+ol4azq/W0OOL
/T6qiWDL4o7caBPvG5td4wB7zPe0EZ+w+0JshyPOqIVGEAEe6fZC2X+oqR9ezE+0
VkP+U0i2Egw6Q8i8MmssGKQqLnQoe8vDD062fMZxq9Uq2zCX+tZSlBvXocMloHgE
UsGSg7GDyT7yoylvYI0aWxJ9IlbOHZn17dNWVkmqDVYnyZlqPsveaUDm+uTAJA3R
nrm9OzJxq2SarPyqvr8v1acKm+OXtvsogQFNob5Qxi0mdYcPB8VHEIxlfKyTLT+l
CjywKWhpkQdfucWx3erDy4TzSLuvmDVebCqTnvFMIt1HYzA8d8CnOeJYqVLgsMeF
WzTDmR1sbnJoHE1sqMGKsOGWnOJJf400Y1g0tmRwLP6MvDa0SKY3uVTxZgvFLf+6
/KBH/PqL1ct9tutDP3Bxa3HGNOjj8hGRIT/w+AdWDTV94aRTwQhelBnCQ4BlbYJ7
p2VhE4cxyyqC5Jm1MZTGnQ+GA4+yyD+7ybqHHPDIw3sCKOPCbZUrs5GtzLO7p3Zv
4uLJIC/yvh5VAM8bPb220i8CwiGMjcZ2h5Rwl3flvPx+YHWilErsnIbAH8YkY6vg
CYRC4xpoqbgOQjTmijD8mASvyNVd8B/TgI4bLs+Cdo4IoSdWwxY=
=habK
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
