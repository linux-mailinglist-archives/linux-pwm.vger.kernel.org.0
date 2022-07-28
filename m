Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4E5844B3
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiG1RMt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiG1RMs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:12:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E379606B8
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:12:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l23so4239062ejr.5
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRXv/o/tEPc/IFMBLppVaug4hhzQG4OpT+eZXaXDDjo=;
        b=fXlNxiGl3upCTYc6STpmxDgPrvrCdEttpME2z7ZynOVXgzeSLQtKIxjtWFzJpxieOw
         ynYk824QHW8A9rp5QnXhc03aEGFbNPqVRriXSnJRaQpNWxji7EUJyFwUKEV+xJdgaumL
         1J/n24HyUS8Rg836OchMpjTxZXFCJv2xbTR3wCCdG9MSMMYBijdGZA7oRi5VE8pf7ESi
         k4C9lrk6oOhBZAd6Fz+y7reV+4F4JvsrGmdAWAM8AUlbqGFqPnLoumcTNYFHXN8j2nUZ
         gVLxA6b5TnRkZ8M/kf/JkLA1FxnuX6ytR4dGdXNBfWdSm+GkrdPDnJZwoDQPfJYQymSg
         iVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRXv/o/tEPc/IFMBLppVaug4hhzQG4OpT+eZXaXDDjo=;
        b=5UMhgDwUEt0szxrF7NV3Q9kzBnywUFMQowg8snyLThK6gPN5lYDLibUs5zrDBZq8hZ
         /PoFubUCblqWPPQs+L6jEJnKnFtHqfANQXKciRkZ8QJkczhHpGw5xGjnROgb5pmbZDOb
         8j5eQM7PtPCMe1Od8ybbPQDXRjh3QZLMbrTLTumd87dMY57niOKWBKghyZbIu6UmE+FY
         Efu/uxtP9v3eiEE3sd+8LnSl4II3H5qXPjFX5Z42a4dnRzipIgDM7fXneR1imd6wI596
         auZF+b0OHwN5IblFO3bG+lFFakcWJlA2sYKsmUZo0iPFjmLp8hoqRQUahu8dN9c7nvLp
         DRmg==
X-Gm-Message-State: AJIora/DctDiW1fB5FPzcdK2tWmHrTjPhJlR6142Yts8FMwyxSFUqXrg
        3g8Yx+JwyNhJzurZSIhqmDRfLCxBWAo=
X-Google-Smtp-Source: AGRyM1uxwYQnEZgrPBa3FzLFacTixssnnEi9sYVPYwtud0EOJPBGxj70Dg95PjeSz33OgkilGAIHFg==
X-Received: by 2002:a17:907:2d12:b0:72b:67fb:89a5 with SMTP id gs18-20020a1709072d1200b0072b67fb89a5mr21629960ejc.507.1659028366598;
        Thu, 28 Jul 2022 10:12:46 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0072b85a735afsm621356ejc.113.2022.07.28.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:12:45 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:12:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: Re: [PATCH 1/7] pwm: sifive: Simplify offset calculation for PWMCMP
 registers
Message-ID: <YuLDjCnlvJLSGX8r@orome>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jhe09fxtqgsxfC6D"
Content-Disposition: inline
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jhe09fxtqgsxfC6D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 12:31:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Instead of explicitly using PWM_SIFIVE_PWMCMP0 + pwm->hwpwm *
> PWM_SIFIVE_SIZE_PWMCMP for each access to one of the PWMCMP registers,
> introduce a macro that takes the hwpwm id as parameter.
>=20
> For the register definition using a plain 4 instead of the cpp constant
> PWM_SIFIVE_SIZE_PWMCMP is easier to read, so define the offset macro
> without the constant. The latter can then be dropped as there are no
> users left.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sifive.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

I've applied the whole series now, thanks.

Thierry

--jhe09fxtqgsxfC6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLiw4sACgkQ3SOs138+
s6GA0xAAj1hoJBcLORZIyy5jWZLSI47UtRYXkGoMFLCiA++GKaTxcS+77LNucWzt
2/WzCuvvNYvPb9kDz6uPZg5G1GSJU3VKdXkog6UFUVjhXOgw2pK6j7CClda6tBqB
VUeE10D2kXAr1WVTnlmBdTgBfQcnrwN3GkZEguQ4wCxIYJBSOqN80HJVRHgG2bNS
lfeF0sVa2ib3AdRoAnViJLwP3nFXBOa/VVdMpjwptL5L3BN4g0UIDhD5DGb2c1BC
IGIpqMUzxmTFPBBCj1eqkyIMyzph0K0B7ZUoxI3/YFgww7fbR4H016r5UUturs0W
JpEVPAaRUotVsbL6H2mGGvOcK6W9XSpDEhaHZnNE610fM8G7fn+7WqqGyND77HR9
KQ50FsuuFhbEXexhKpvN9ZA+UEHiCXv3COEVShKhsf3SSIGvErzkExP1i0ADjoxj
6jSy81KVO28axaMK6kWwILEKSISVn781M6TUMNCRTl36Yi0cwEDih5SZn3q1yUGD
r9WnLrVgABpLVSKyfrll2KuxWWvcIXOZ/1di2BiLFhsVNoUu7y6EZd8OLQW9SKze
DGdEMVo5QIPikrOEKXQxD31SipdCoXO6inTPGNk4/tmlCL0SEHIaUhzPoaf95fRs
HbJmtrT9Kpidbkv/bxSY5rTmJ67eIR99vEnvMlPKn77UvIW0BcE=
=sERE
-----END PGP SIGNATURE-----

--jhe09fxtqgsxfC6D--
