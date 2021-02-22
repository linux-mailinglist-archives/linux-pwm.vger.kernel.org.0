Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED0321A66
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Feb 2021 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhBVOc2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Feb 2021 09:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhBVOaX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Feb 2021 09:30:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725BC06178C;
        Mon, 22 Feb 2021 06:29:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n10so14562647wmq.0;
        Mon, 22 Feb 2021 06:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=08zyHvZoEG/sqiEKTTXb/ZE6H1gD+YssvdQYgyBdOxY=;
        b=VwEdznWfVJlZSWsEWm6FOVFH3mbb4RZPXPPs3gygoYSeMB2leyT6iMvncQG3h4IAFV
         7BNlRnbv0/87MOWb7gpZbVZuXSyTY96MjC8LPhExk3GW8Gd35x3Tr6iy/XEQI6J92Twr
         fz5ENjfRlM4rT60e4ud/wIPA7c5LCj9tZouay2PPhOe5mPs+KjJIUBqIEBKLNjIlp4jc
         Ty722lQhcjcOW6JzhzsYDTzlnTi7OX8+Eua1Rwo8tlS1DG1EVHH2WLMFlCaP0jue5Ry2
         ppgGLImXxAcXkvFIvupOpAU72CWJShV/RfTD7kqfIDBGD3ybTHuEYPADhNmL+Xy0cYkB
         MYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08zyHvZoEG/sqiEKTTXb/ZE6H1gD+YssvdQYgyBdOxY=;
        b=CKQSp+CgDYitmsDxWKjE94drW/Lh0l4ywNT+SgzkN7Xc1n1N8qlCbdf954HvoqcPdV
         O8jNrivEGFgYEOXfBVsmsVR/WMQRK7kAptQZJp4PhGd6zoBPbNJSjM0A3C82wF5naLf6
         vLLE7otKAVF/zB5YQCP5NCbTLUjvB7tN+HMlj0pMmipNjrqIrGsjltg1SyoU2cdWvLLI
         IS6rxrAwgLPk95Z67K6N+w4RXrKT1xSfIB0hdXT7k9bOGTcMGYsFD8fCAtUJqmYuIFtZ
         RiiW9DT7FMSa2Ek5CGVY7QrUCNPG5sh2K4ALXU6kfqjNJrDYc+P/VaQkposs6FX0Sc3P
         k9kw==
X-Gm-Message-State: AOAM533zrvAIZpCxb2TUwwZJzzwxoVZbXz6zQK6f1/XsmCZ+vLrWq/x1
        jBxUa01WliPsh4q2P/yK6emRMzYfEks=
X-Google-Smtp-Source: ABdhPJwJnopNAx8z65vXkOX33mUFv/6rm7XYKYtPdM/rvug0lHGJoQrCoatVgjrReM448ObplsNzUg==
X-Received: by 2002:a1c:e446:: with SMTP id b67mr20642654wmh.65.1614004180402;
        Mon, 22 Feb 2021 06:29:40 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t16sm10830487wrq.53.2021.02.22.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:29:38 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:29:36 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com
Subject: Re: [PATCH v2 1/3] pwm: mtk_disp: clear the clock operations
Message-ID: <YDO/0Onf6a09YRsP@ulmo.localdomain>
References: <20210130141226.25357-1-jitao.shi@mediatek.com>
 <20210130141226.25357-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C/yvIL2pWg3hjnxv"
Content-Disposition: inline
In-Reply-To: <20210130141226.25357-2-jitao.shi@mediatek.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--C/yvIL2pWg3hjnxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 30, 2021 at 10:12:24PM +0800, Jitao Shi wrote:
> Remove the clk_prepare from mtk_disp_pwm_probe.
> Remove the clk_unprepare from mtk_disp_pwm_remove.
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)

It's not clear *why* you're doing this change. It's already obvious from
the changes in this patch that you're removing the calls to
clk_prepare() and clk_unprepare(), so instead of duplicating that
information in the commit message, take this opportunity to describe why
this change is needed. Without any further context, this would seem to
just break operation of this chip because now these clocks are never
enabled in the first place.

Thierry

--C/yvIL2pWg3hjnxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAzv8sACgkQ3SOs138+
s6GcPhAAmaYjEXbN1rSMvBmNnA5AzGixIFwjkZrW6KmtzXP0/GhhDKu/S4ExOHrX
kIwYifz2tmYQxR9aLwRc5ZPq2lbUDq/2XX3oeN641O1Vjc6pHCkE4mBZEIC9XuLw
XY1uKGkwEq7V2dK7j0L574RcMXEa0epWnGUROVVVMXWol6+lGzGsxHGWCi9dl7+D
1V5bDvR4BAGAXPnTCsXa56zM3ChJ2bz6EcetF3lK0/mW93aeCQ8ArkeEHcZTcZok
7RrbAN+gf19RTiVz3HPjyv5uHg89OM4No9Y6CNgzvKyP1lMYpf6p33rkcDMCX6OW
/OQslfs/M6Fyxh4iCo+nf1gQU+xtJBjZKhBTLALncioaCfks19F1mxMy8dqOadKD
Vdbz74tR99AY4J0txeoZVgsJSmVXt3+VNGUstn1dnzJZ0B6qKTFBV0p94rROjUAO
JO/e3cC2V953JB0K7OGcaOW2uJDwHvWptRli3pz+10EF1xSz92GqEwxSbz0JHoN5
Gc24Lotut5K9dAogZeGhbc8H2M4yyYaqH71c6BT+jaZxsNIWdP//QBOq7KqErn2s
WNOo0Mh8itD8RrBx8YQRsf34hJ1tn1tnjWOL7ps1BfCAMWwlG5nGiLpYlpCkZkVB
b+JcNRZrNchuGqZw7mR5qoLVBHiy2QQS4B7AmX8qTNnbwETqbow=
=qfDp
-----END PGP SIGNATURE-----

--C/yvIL2pWg3hjnxv--
