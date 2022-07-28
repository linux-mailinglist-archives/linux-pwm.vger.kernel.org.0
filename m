Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6725844A2
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiG1RKR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiG1RKP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:10:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FD19035
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:10:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oy13so4243362ejb.1
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DPaVj85L+sFty8ivscMdof++1UUYZn+/8d+eAz7Grl0=;
        b=VqyqIdmAKxgyhkqVDUCGvpI7gkWce9ODf+kcWQB4tas1LZa7+C866nLGbT9pPI06qZ
         tPCXfANhNrFhEB7x6tBfZJc/R8k4sE7aVtNCA5+6rHL87pknnzqvpS4UTbWbFdazB8il
         JHqUNn3UdhQ2F6rctuUyNVfmp0a/AJrRSBTk0ct9h6Oeb2kilS3v+z/KhRAVchOWxFo3
         TubYpqA3z5MGchpDMTBWiOP8vzC870GCdlUYJy++mRle/JGf7HrQ07cZwwGtutVsksFG
         hhwaIdFdc7J7HBI9Z2+1kYftfr/1Nl4+aFaXamYORWllvQ3dmYaAEcJioNwlSI0jLHMx
         ZgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPaVj85L+sFty8ivscMdof++1UUYZn+/8d+eAz7Grl0=;
        b=cj5s/honYrTc8pgvWSy4EzHOcY4UncULMSLtbHSrKDy7aYIkG+xOrcm2EhWpcNZasS
         hBNLr9OB4XIrbM4HgdeDzMItQVUkDxSH2zKqulkgXOwFXEfpLiECgCReE0U90qKaOnPl
         82GhVJC3ZAFwULxx8hLTpmExEA1RtO//6hD1nWpeD6/RQk++Qc8kWMxPHi3ifuvr0CLp
         KoKVs0wou0Zjv22nQPPWhqOVKxGb8IvmkseNHg5u+tkva6ZDFAdk+uo9y2/7sSIAxo8j
         +6NvCFI0GIt7SHMBe80J8FXNA92yoGDWr+bbGjbevw7cMp6UAFXtdCIKaNGWK5Xf7X9l
         dc0g==
X-Gm-Message-State: AJIora9bOvyLOH5Ezwwcnre7PPhnmb+06SKUv1caFukyiw/9xiEFea5S
        Cq/6mQ4e8hazNM7jfm+XhwypQOy69LM=
X-Google-Smtp-Source: AGRyM1tWCQzKBev5EHcvexeC1ISwWJ62VxldbLWNtSJxUvXMXoVr/1Y9j9PFsnlbZV9n2knPP1szPw==
X-Received: by 2002:a17:906:84e8:b0:72e:2f3c:6784 with SMTP id zp8-20020a17090684e800b0072e2f3c6784mr21954954ejb.390.1659028211397;
        Thu, 28 Jul 2022 10:10:11 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e15-20020a50fb8f000000b0043a6df72c11sm949787edq.63.2022.07.28.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:10:10 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:10:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Wan Jiabing <wanjiabing@vivo.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 6/7] pwm: sifive: Ensure the clk is enabled exactly one
 per running PWM
Message-ID: <YuLC8IFNLQKY+IrO@orome>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
 <20220721103129.304697-6-u.kleine-koenig@pengutronix.de>
 <20220721204522.rxmah6k66e5qe2kb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cYboAQbv0PYEbGws"
Content-Disposition: inline
In-Reply-To: <20220721204522.rxmah6k66e5qe2kb@pengutronix.de>
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


--cYboAQbv0PYEbGws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 10:45:22PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> [dropped Yash Shah from Cc, their email address bounces]
>=20
> While browsing the list of open patches in patchwork, I noticed a typo:
>=20
> $Subject ~=3D s/one/once/
>=20
> @Thierry: Assuming you are otherwise happy with this patch, should I
> resend for this typo, or do you fixup while applying it?

I've fixed this up while applying, thanks.

Thierry

--cYboAQbv0PYEbGws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLiwu0ACgkQ3SOs138+
s6G7og/9FF9+VMbdRZoBPBnZnC2p5DKIYkq9L1h94GS08zisJw27ewLKy47H7ZRf
m/KUuT5v92QdfQG4DZ5/96F5wA+zcojVfF/Kj5OKFRP8NsoxB5pbJn4G6qjTcQ6J
MXdA8qX2GEE/wP7MoiL7nmGdfuJSmw9ov+z54uAr6uYMprGEdL8bby0cu1eEswhf
P2aMDopKwsoc0Iuegzqc8Mg4P6ESWi42ITBuQahtrw4sKAiwWSL/9OJoB9fQpfDv
nZpPdDceNy/jNq7lGNvUC0yO/fgLaWhWWBeX2t9cKROyaq3r5Oyw3dwCKdkShVUy
i+6btJLu7vXfQ34HdYDw8xbp+cM+Zlq4F9b791HdQ7ArXdBhy8WIw7N77qsWnbWn
kIU1dMKL4SJ/RopTBcof5NnTEQiPcmZIVirN5j/45c7lNJZ9VBvWkz00IlNM8sLc
iRIIMABacmjlBDIc7zThyQP96Zh/s6IV5Re0auZwdEy7ShylZumT+hmJcfNpAzsE
W7WeaRyZ2BzDak2Mi96V2Da9Q3nOpKEV1FiFUaCDSEL1RD7ld6zjmzJNDL6oJWlP
Od9Z+sQfDcnGqlLGBEFuAdwpUg3c0eCEASwc4iw/5Urac9qg1jP97LuOYiX1aIhd
P5VfNBgJXU90rcK5wCkVs9K3Eshpc5bibBQ81TJ8BeRPqxRJXGs=
=74I6
-----END PGP SIGNATURE-----

--cYboAQbv0PYEbGws--
