Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8074C2C3E
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiBXM4v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 07:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBXM4u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 07:56:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B8214F87
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:56:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so4105574ejc.9
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rIkbF7DE32Bj3lkCNZFJmydyWRaz7WbfhuaBFnLQKMc=;
        b=g4mLZFt32GwuCWS9HlbMTTKwUjXXcS/ft1liZMmmFWUuzxo4/w+rXk6IfN0CaJ+gUf
         EX6LFI9dMYRvCj9AN2ixaYFo28FCSYh7K8cEkKGAb3G2RXQHceos98bbzqNtoge3aB8n
         0N2HBt3Maj7vw66RFtkTpO/ooMi2T8QvKV2iflHjFnbJ97ka5PbP0xMTU9e7tVwRJLyH
         SH2Q0GfzXW4noU+betEXm1Og43nhIx8UZRY0lwi2XcAR4/Aa6vSj/MwQs7L0z+WqhDlL
         6Jrj4lMOhKH+nYuHORqPydqtK+DmLcOe2me3OxbNjF+rwXm5cYWeWWup/ZohvKY080Oi
         3hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rIkbF7DE32Bj3lkCNZFJmydyWRaz7WbfhuaBFnLQKMc=;
        b=msguzYKPqVxUd0cxWanscvPRq7BtDDWsV6LNVBvZm23HEu3V4cHsvJPHYZ5vOI46Ma
         wvfDDZRSnTbtDxBvML48y93HWXnHVjrNcDNiUF19LfylDVYRQ7v9maen3hEtKCVWrCEl
         epGidTlCCpXBjJr7ON3zb+InMdhdq9re0v1oJf20YItN2dx5qVYgo2G7jlNDRnU32Iu8
         O0qA1TtIvTbj0tRbtE8u/dDlpLG6q6+LJojYLJOFpnNx4QwgaUnCIFSrjH/ts0mbn4UA
         08Q8cGs4fdTeISHCRJd8Ws4zhJoPaSufBcFSrXGRE+qbVpAGZDFvlQ/jomwoDR60nEbt
         13rA==
X-Gm-Message-State: AOAM532Cy7bXNIw41NmXoXh2fQK5N0Ir9Im/Zea77rdwlIrOUI4kddm9
        hl6dWV8DkErCkPvZKTruluc=
X-Google-Smtp-Source: ABdhPJzTsyPaGqHhPGVrJ4p9NFPdjOykTJbQvN92CdGv95rN4HdHWdBEw14dKRbrhiJ5e4Ndwfs1VA==
X-Received: by 2002:a17:907:766a:b0:6cf:bb20:70c with SMTP id kk10-20020a170907766a00b006cfbb20070cmr2160145ejc.94.1645707379267;
        Thu, 24 Feb 2022 04:56:19 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id g11sm1322954ejo.110.2022.02.24.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:56:18 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:56:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: tiehrpwm: Implement .apply() callback
Message-ID: <YheAbQy5zH+Cjt9N@orome>
References: <20211130201937.360254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V6O9Jw8ntOtspDNQ"
Content-Disposition: inline
In-Reply-To: <20211130201937.360254-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--V6O9Jw8ntOtspDNQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 09:19:37PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply(). This just pushes down a slightly
> optimized variant of how legacy drivers are handled in the core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 40 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--V6O9Jw8ntOtspDNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXgG0ACgkQ3SOs138+
s6EteQ/+KP3lAKe1MHPxcpfsGqNtO49VECkqBASk8WFPLmsWhYGK/j43sRnfkPLo
I3p6ltGzRKvYU45uSTqdENeR27zKGqDkkfXHjCr2IPGvaazGBBfa1+lxxV8Ua0ug
eeCqM9Hh4M87697qXpP8vlm5QIACDncSiDjDF06GL4gh8AwAxwfvR9Q83kbfj+H6
XF0TypSLsrXq286RtW+9Dng/ycbnPZorLYe1bGYXZQ7zN3cEhAtuSx1s7GTs/mTe
EIL9QFDZmAT8VrI2PruPpo8kpiRRDBsTr8RKyOQhqR3jBz7aIPjD5ss7gBY1gU02
hZpx1zBOr9TSRfer82EaftcowBDcwJXbRMagXYGmgH1jqsnOaelqkxpT4EUdhkv7
dwulot0RhQpeG3lTsTISA9SkqkLTvjnVl3YJu0AYywrLat7cwPIDw+FbdJ4ZCTFb
EuZKaOb1WU8U8YhrpfwEuEvdyTsh4GsrLGkdl/g8+AYv3x/olm5QH01bVpsolGU/
XBxAVMTq8nXBc0bbopBiu5cNZB4B6P46ZGTT2/u5brXqcLK3Ba+mlcBcD6RCnzvS
yNeNJwL0tKQZjp0nzHuUT4iyBqpIFi87FBemUEJKJzYri7IGDZvf+EAt7l+Wcnit
xyOdTusR8ZxZzG2dowJ2Ptxt3hrcFrC1eRZzOnOC9Xs6YYm3Hx0=
=ztuy
-----END PGP SIGNATURE-----

--V6O9Jw8ntOtspDNQ--
