Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C8343F00
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCVLHn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCVLH2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:07:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AECC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:07:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e9so16210620wrw.10
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2C8t1hRNWiNocIpD1w8J6o49MQ1K4Ttnne3l0UJppw=;
        b=QyU3osf3fbacONHW/otruIQDPegJM9tmumM/Hp7HU1zR4uEtr+xWiZ1aaBZ/DVtVF7
         DGEgGAgVsKl93A7GhucxThoaWoOZYzweZGLk3ETyFzmCfP+4porbDuUd3sWiKip6T+Zz
         6oS8ozNYfSaM10ABYHJRSUrlWahNiqd0KV007i3j+L8psxgA4X/X5G7eG1F4I2rOpP3p
         /4nUHzCLtbXk8aPctIGCI8xjlpBNqmUwlyw2ZMTXjJIDJYw8RUd+PQSH0WCcwiTnJv6t
         8o75mF9uwUHyP26BQRdBI7cDbT1llYU+qhxZ364MihfSHAPdQ0ZwgMEGg6sTfP0N6v2x
         G/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2C8t1hRNWiNocIpD1w8J6o49MQ1K4Ttnne3l0UJppw=;
        b=eZFKPy1/quDZs5jud9pjkncL1zmnIJbUjRT5w1p7aT57qmmRX9XfxwHiTKziCfiTLM
         z+dQAiwtFMLqssbneiTw5Yo84LhNEDI8KcuZgX83No6X60XwhwEELVwd5qLgVuQ5rZRe
         z4EV2aKBZpXReAI/lHYrwsL85C+kHL4LYHTL4RFZcOyiLflzIlx9q1/MUMyn0e37Uo6m
         OD1yCN12aXjsBOME4AcxDH2E4iEbmBl9rfwBs1ad3gWtV48Z0axiwgfetrxXWXTdH63e
         BF0JbeOHPMs7/MCqHyBbj1FDGrG9+ridQgdV5Cg+h3qyeaZjxipQCfLmardtS9y4sTjT
         8z0w==
X-Gm-Message-State: AOAM530xoIfvxY3I8XLCLiPQ2p3U6FbLdV4W+77mep+kiCn4MCjKlssd
        2vOsBtAk/NmwM0C8HvA+Kyg=
X-Google-Smtp-Source: ABdhPJxvDrZsJoome+q68VvJAlJ0BQpVlERupr2Q5+Yqh/uCoacKed3BNKCryq7ci1hJDDkCNYCT7A==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr17020199wru.327.1616411246836;
        Mon, 22 Mar 2021 04:07:26 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z1sm19383445wru.95.2021.03.22.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:07:24 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:07:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sprd: Refuse requests with unsupported polarity
Message-ID: <YFh6f9jzRLIZ3qSy@orome.fritz.box>
References: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dx8Y0LwFonm9CbAf"
Content-Disposition: inline
In-Reply-To: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Dx8Y0LwFonm9CbAf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 09:59:16AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver only supports normal polarity and so should refuse requests
> for inversed polarity.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sprd.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Thierry

--Dx8Y0LwFonm9CbAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYen4ACgkQ3SOs138+
s6HMbhAAwsSMCp8sC+GPpuesgRQfsZQhwymPqGWLWxBWLi2iHUNJLR/kOZweJeK0
43SnRQWcae52IZbKcHkEYK9PwwkYcMEEBb1E++ct97L6ThgzQNAJ+YcBi6GztqWm
fzmRZx6o2TOeORbFLqtVd9UbeInKcbfOV+Bw4mtNU/XqdHc5zZK8I7htHyUeRw2H
NpI4LDhFYL4fJ2BJPSiMu04NGbGe0bNVfBtWO7AUKBK92KXHUqx8kEMiHVAFiSCo
76AsDXI7SBnrum/E6RGOdicM37LCnQzrOIl+Rqge+1YehDYyiNlwQh/XWJJEHCZ9
JQqqzwaqe67K0vYKqGn5/NleAp2EaiEEEJODrBinQk8y8ROdmfC98syZqgZ9uOJt
aUBUy/SKQys/FMCTBQGaP1/UzL7DnXP4pRs4G+YEqRI1GEnnSHHcK9aghEYXFYZx
EHRzRzCn8XBu9uJXPUWo3TajpyXz31LMuxl1usOUqxUqjE51fq57ByIz8EHNpNzI
Fw5bZFdur7R95UBYRIC6e2+qroBCvPLf6pwtbes8KM1NweWS7cg4HbHYHKATKyEg
KA8ZonS35LQW3xldPFLBtyVowiXemiwh5PBcotwlmsjK4PeMcspiNdwdwW+HbFNI
sM/sTpBBiFoyikaSJUw2nPfYCN0qChUabydlaO3Y5ioa9Zp1JQU=
=26pj
-----END PGP SIGNATURE-----

--Dx8Y0LwFonm9CbAf--
