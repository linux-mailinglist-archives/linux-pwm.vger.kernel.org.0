Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB28584509
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiG1RW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiG1RW6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:22:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B6B2A27D
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:22:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z16so3037500wrh.12
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6k6QkqDkse1x32oXsAijKW6QnP7UXhgBKYNU3k8d1U=;
        b=DpVQ8EFcsAtzm5pp72aQ9rDbIAWEkRwfQHhK87pbZ1QupffGrrRr4P39O/Yc3SlsQG
         nPMBYlYOb8LJLp48xh/EP4ZCZ/u42T9azqX1LFv1CctUZJvegZ1mCPT1nvW+H2LXqVAw
         HYU+rAWXMnmqNZ2cFgCF+1JC2fggbawpIsW4yIPSNp52Ru0alSB6MgAvkeVkw3aEBINj
         oaS2InZF/pTylxrek6cVrRkD6rZTS7ojywOp0VPNKvhu6Jmecu/A2o1Zrew7EUArAFfm
         7WzJL/Ls/1oM05VXvOlGUJn6LrmX1WxWliTNia7+fuWJNyRR2DdqrPm2v3lQljCRUoYW
         xRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6k6QkqDkse1x32oXsAijKW6QnP7UXhgBKYNU3k8d1U=;
        b=ANxSuOAOal0AscRwWA40syGZBijNvKssUsj8yipSeHFFZVn1w2KV4M3nRD25TLWZ0a
         fP/I+L7VqA13bOos8vZKwb/NSjms+P2dXIVN3z6kdYgsiH/1Kr8B7OmzaQY/m4M/myjd
         xvuY9j6rByU3vjSeD7sjRPLpw44s8v/uMhbMNZJ+ZI0iAAexDsFsxr2hlgGmbLZUiHFA
         /+G2ydiIIo5TUi88EIxPKZ5XCrapjtDGpAydOHOsExmReCx4ANnFonnN8dsTVwxfHunq
         oZqV51Ul5kM360RZwkrXdWfL4MNF7xlBz5ynLBSzCCENvhpGVr8SdT4w3OtdxiV0ApqA
         kbbg==
X-Gm-Message-State: AJIora9caA39NIo6BITKFGzx1xuW3hek4o/dn0CV37K8nOJSmHUmG2b8
        LqTLfq3+q7W7u//oQCfDEK4=
X-Google-Smtp-Source: AGRyM1sSq/6UrSiVZk1bGEW7bXpXopeBtz2Xgx95iQ65fcLcTnKVnftopqzq3SldKNO+1P8sN3c0Ag==
X-Received: by 2002:a5d:5989:0:b0:21d:b2bd:d712 with SMTP id n9-20020a5d5989000000b0021db2bdd712mr18368880wri.698.1659028975940;
        Thu, 28 Jul 2022 10:22:55 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a3170a7af9sm2103526wmq.4.2022.07.28.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:22:54 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:22:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: lpc18xx: Convert to use dev_err_probe()
Message-ID: <YuLF7KbgiwZDnRjU@orome>
References: <20220712161519.44010-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rWjrSJkZBRdMMFte"
Content-Disposition: inline
In-Reply-To: <20220712161519.44010-1-u.kleine-koenig@pengutronix.de>
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


--rWjrSJkZBRdMMFte
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 06:15:18PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This has various upsides:
>  - It emits the symbolic name of the error code
>  - It is silent in the EPROBE_DEFER case and properly sets the defer reas=
on
>  - It reduces the number of code lines slightly
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Both patches applied, thanks.

Thierry

--rWjrSJkZBRdMMFte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLixewACgkQ3SOs138+
s6FkiA/6AsDNj0DkikyspgvLICNs7Gf5JFpSHoMN8FsgMse2cjZrTWCX0CNOkxW+
eJrW/6f6gZg8U8a/8cdT+Ti0swG6F0e0pZBF+z3EuwnYC8eHc6g4nxBcpRKtxUCP
dD3tsHptaImk2s+WHR7ozkFPiIb+zoUCGd+ASZ4qMZFF09ht8Eqcv600OycTAvhe
e6Ab06j02AbCixWrnvvyc1omQXnAMEAPs8//dfXgzR8ZRf5HBc1wafaI5iqoo86d
+RqGUENqj2na0wwVBqdIITlI8FrhwHkhANvyaMPYsMXUfB5vGy1PfOSh/iEnZCDG
s2Kd5nDp+RaHwVdOeCzHo7NcDVXAwURUYLwPqaGCkez2q9dZRPNTvAw6ad9LN1Xo
0HYl/skC6I1T46kN2pN8S3lOXWoYLDSECEs5EFE2wweCz1XhRufUxaR2ibHDG3rv
E/ld4JaS6OtZpc/Vt7tuX1GeDJNJ/vvTMVj6u4xWD2dZ0i8HMweppas4WQgfBuqt
jfwhto+6G5OECymCjKjDi7iOarBvIbN/DbYquTJglRaYXE1RBsp9vrdDpqGg/CFh
DtwV32vzqiQEZHDveDpCN63wZ9+xu5w3KHa2e0OqGRpAiLYzYx53/vUW0LjoItjq
6bJq80tZ7fQxenf+Dvf7Rwcl3drPUhIu8Z1Gp+HO7XlNKAze0DY=
=I60Y
-----END PGP SIGNATURE-----

--rWjrSJkZBRdMMFte--
