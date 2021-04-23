Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D9369758
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhDWQro (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWQro (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:47:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D08C061574;
        Fri, 23 Apr 2021 09:47:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g17so57476323edm.6;
        Fri, 23 Apr 2021 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jiu2CnPrgJlZKOacLkwJ8LJ+LZThWvCdLjqGPP9/CBQ=;
        b=I6GEuDgJNDT+Qs+mwBu0cU71fDssIorLBZ+1WPka/mh9dnoBGLeT7q/KdEOE2rZdmB
         GYrLgQj7tnit4o5Qw+rhee/H1vLmV5m1RgBufwd8rtvVGXWNO26QrJfvzj5drP8EQlY8
         m3iRLYayyxnn0S58d3zLrK83tSjBAO+UN6r/8ERJpAT0QLm3FQivr6dZq037/RlugCQL
         4CbD6wfzCnoLL5mQxtde1Sng+r30b3+p3JW5m9QEzMQ11E8oV43/YiTQuLNORSRCy2kh
         85Nc2QB2j8UfEZfQNawxVEofGTE1yupGLwuyEwplalE//d9aljwJh4Hd77f4ozTqhI3h
         JuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jiu2CnPrgJlZKOacLkwJ8LJ+LZThWvCdLjqGPP9/CBQ=;
        b=hw/QYTupAQdidKupJ4J4yjSx0jBVLvvBapA2XIQ87JnSPM42JeUqKj91lXi0AGeQQU
         PHgXlON3eyD1a0Rc8wiuhOFDfiVxS3tGe2vqZ3Lfau874GTogiGM+1pXcZDwgVMg/Pyt
         5XlJsQ71tzIw+6H8S5EYmZI58e/Y3wFZWRTsjBQvJr9mHPsygSfhBa63TXVUysI1A6Xi
         3Ib4Uf2hx8dmNzfSjUDbYhrxpA0RKY0n8fAuQ8RiH9AG3hykdIrLP7aZnrEIy4qKVBep
         lWLarTs1ki8xvSAQxROlOJkr8++jEGi5qoHowivnIp9u7e7QioMp2wk79+T6G/dLEeUw
         oa9w==
X-Gm-Message-State: AOAM533GLFTI6RCIQG2nZqlqgbvOVePfEop26hYnk5DiekjrmwLLdi91
        5JfW8jyJx5K+NxYcDe2Xqvs6nhMptYA=
X-Google-Smtp-Source: ABdhPJztzmxtzdsfzQYgnh3Csc0vESlubuEhwO8pHyjkXw6UK6ImN6Go/GxbiALYAyrZX1X72TORdQ==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr5556664edu.100.1619196426033;
        Fri, 23 Apr 2021 09:47:06 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id mm8sm4456113ejb.28.2021.04.23.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:47:04 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:47:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: remove unused function
Message-ID: <YIL6OoqF+CtGyi1p@orome.fritz.box>
References: <1618475753-102123-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UDuYcdOPnu8vXxWU"
Content-Disposition: inline
In-Reply-To: <1618475753-102123-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UDuYcdOPnu8vXxWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 04:35:53PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
>=20
> drivers/pwm/pwm-mediatek.c:110:19: warning: unused function
> 'pwm_mediatek_readl' [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks.

Thierry

--UDuYcdOPnu8vXxWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC+joACgkQ3SOs138+
s6GMFA/+Ov/ZsslM92MqD1LXtllAdQoyXgyArwL6x6OfuwJlg9S/tgH94R2efhpR
JuMMyW/E/zpvLI+22EgS/ASWtGE2R+Y6NnjHz65mRBiDgo1WLhHOn2b90YbIN7wG
C7usfcDOex1KKJxYPBboKkcqyKpU60eGkPI8Wu/H9tNgLz2KnzUSxy3vvI6nI70d
SP9341phubwxTsvV8hABZsmeKLg89UfsnvQ9IdEQBcvvDnHBlb3R4oTqkGdvy906
Z1EOrtD3BrCQjTm6H2FlSLdlpNiy4jAa5ptfsaAUhA88Wyawf0KWN7kpX1pT5BkI
mieOLbsEPWiCnIzktGt9TvAQ80pyAu/vWiaO1jnadYGwOLIUT8Eb/K1rJjnvfiO/
IjbjIkWz68LCA+qZ0lPQPRbL0ZmeaBL5RDdj7npFLutLHOCptRbHgg3BfI7SZHrY
N6B89MRIJlRhsqCGbyGCAVzqftQdaytGfx0AwHCsvTRHTxrPKNxuY7JYP/iaVJo9
mF+nPNhcTxdH/RJaI5qVnJhIYvb1yr6cpXSkjSsesHJBRqP++SEyeBeyzFFw6j2s
kECJtkMjw39eNAFcg5Pfol8pFp0PCdHkCr2THp24qNy8PGTuo7Fy+kwbEndP/I7l
RyeY8duMnJ+8uHw7PTwwU30hynY2nqk9hTo/XTB/jBNBeJ8u7uM=
=Z3fH
-----END PGP SIGNATURE-----

--UDuYcdOPnu8vXxWU--
