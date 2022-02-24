Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB584C2C41
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiBXM4N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 07:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBXM4L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 07:56:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656C214F86
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:55:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bg10so4149134ejb.4
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5u9vEnPzC1hQP2TmTxjVpE5/41AesSF6zhH/tsKSfdI=;
        b=PgL45wYPoLG+JdMtVmPVbbRqU9NQtocbYHSde6ki1JcWnTSEUFkJLbLqRmQOrtfW4t
         KUdl6GG869WiKe7PwlK8FXuWBCe88bN/cq82+HBkgoBcGdYJzY+HR5lBP497giWcCnpU
         RemHLVsw/MsYuiat9TEdPj5Y0HXM8+fD7KOukVZdEdw6fJGEOaTjseczZ8sMTV8g6sse
         B1ysxo/8ksa9miP+7cgqad05OJKRGbjMfsI4wXaZIkMlqaamDxbZB3/b7jDBbUjadN5p
         HmU1vegp1NPH/CwV8EisX7xN2b49Moi3NcsCV9RgwJRf1HynJpKdGns6r88o24HvPFUX
         bpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5u9vEnPzC1hQP2TmTxjVpE5/41AesSF6zhH/tsKSfdI=;
        b=4gjxXBNGU3pI76S8D1tHvTCjX7h3Yzzsme0gb7rGYdBks+uPT/gDIigw3qQwQSl93p
         lWDKSjILi9cazX/kAptp2pS+i3u7fQ5lm3ReIbSKihCmjTG84JYVyAqonp436G1kvD1U
         QjhP49NRiiqMVSarcrKAIXlvEjiORYpvw7twGygEfMXeTeYAk9LlKQ4EC+1SvdtIuhBZ
         MokldDhPqK0b4jhImi3p0grKbpn/RzQgM4OeDGX5jNR+c+hcrJb0ezam94OrkWpXUNLZ
         lEC1icxvyFeuJ/nAAy7Kth6BdXlj3kQLDMTVc2SLpUjmhF58Lg4DHTBPUDY7Do6gE0PY
         qbmA==
X-Gm-Message-State: AOAM532nbSkX/L3MNTcp+LJGLDPdrPKlNlQ78rHVAz/m0LqBFe53oQug
        jWAod/kELIkQowksKpnl/bY=
X-Google-Smtp-Source: ABdhPJy+LT63MMDkEEijv91Xk9qLXFWrAl+bx06TRx4/z2DJ9hkruaysv+uJzqpQW/TZeJXIMSJXsA==
X-Received: by 2002:a17:906:3e09:b0:6cf:cf2c:2c02 with SMTP id k9-20020a1709063e0900b006cfcf2c2c02mr2226042eji.291.1645707340834;
        Thu, 24 Feb 2022 04:55:40 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id g15sm1441110edb.11.2022.02.24.04.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:55:39 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:55:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm-kona: Implement .apply() callback
Message-ID: <YheARndQCqxnO7r+@orome>
References: <20211203225859.1148940-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vc2cS6K+PyWkGbL5"
Content-Disposition: inline
In-Reply-To: <20211203225859.1148940-1-u.kleine-koenig@pengutronix.de>
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


--vc2cS6K+PyWkGbL5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 03, 2021 at 11:58:59PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>=20
> The conversion wasn't quite straight forward because .config() and
> .enable() were special to effectively swap their usual order. This result=
ed
> in calculating the required values twice in some cases when
> pwm_apply_state() was called. This is optimized en passant, and the order
> of the callbacks is preserved without special jumping through hoops.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 90 ++++++++++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 32 deletions(-)

Applied, thanks.

Thierry

--vc2cS6K+PyWkGbL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXgEYACgkQ3SOs138+
s6GPJg//aUp5MhpdnhSX8S9CMwGsTrd6h39foFceCTd4UsC/e1gROgOUdXkoJzPQ
8PcyzgB5jlOtBp9BRNs32Xg2s56qaS4FyhQbcQ/FfL/96HXJPnkpozZVriTrVpcH
Z+d5bokCiK9ckklcY+bMB/nTek2wNUvd53Dn3+kNxGN7fFPGSq9eCtI8knERkpkV
3T6elgqQ71M0VPxkp5DsDy8ezA43Eq7UUHwi/fS2V/rM7jAbj8700/kpK4JtE5bB
EyTArVqjmLRPEhr+piczOYOnPAowS4vruZwE7BASMX9CANDVB3CGE+5Tvstqnjx2
rvyoWHRqbfhYuFbY5ym1t1j1wfpEo/CbGhUXD9y+9SHrImDW3uPsLbZvBS2nITo9
J6gxl4jPsyBVb9ARs9B4AftfCeL8+upm+BvhXQMv/dBudRGraX6kyg4DZYyuvr7C
iF79oBRFk2VSEx6GicNFU6magD44BV3uPwB70shoo7douOiAtyhwDR4I2e0jBMki
wX84vaKjEULOeNVaCk3GVwaoK/KXaahHoVraF3Lk2SSOhjZTrTYFG4piOgCh3lYH
Rlmv4xXCtT9uyHWWb6Akme0w82oQgJ1GATHdZT2J/RAglY6XMxoZMxtY/45yr4GJ
nzkmIfMNCYUDdcZKphk28dsVMhblICjx1YcPf0dNPFUSNotzETs=
=bvJZ
-----END PGP SIGNATURE-----

--vc2cS6K+PyWkGbL5--
