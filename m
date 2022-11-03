Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4A617ED4
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 15:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKCOEf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKCODr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 10:03:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED713E87;
        Thu,  3 Nov 2022 07:03:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so3241720edj.0;
        Thu, 03 Nov 2022 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XIFbDevpD8gzLG5B7dUBKmHkHKiezCntv0tZ9DsZGo=;
        b=J09nvBrIxiMvP6AuvIlOEnOdn87H7I4xnM1kPV/IJYgeCr5tH0qVxKYRpZSK/CGECe
         UpeDMOT/FsryJqV8h1wJUHDIzX0/Nu6Ln+oGXhZ0iis3Ywp/dx6E+ZZXedaFa0CTzKxX
         S1zY6NeZyIUzwrgrnT9/Mb9GwlLDGL7gwFYjB30R7TtxD7hXoQZ8jVl7IvKRT+/qp++I
         j7ycYnN8JWiBiYEGXQBirIJkmlM6/AF1mihq8JcVn8pWdynYLUT6OaM3L+yKV0fseX/3
         YaTUFBedXs5MmQDGlVm0ZhljReNjQUFIWc7XFMzARIszQybc92lsFdkmydQzjxkz4dB4
         tDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XIFbDevpD8gzLG5B7dUBKmHkHKiezCntv0tZ9DsZGo=;
        b=UraCBMvxaulujXF+NjiPnKdqp4KyYoZq/7xKRPf7YkMRc5zQZcXFR7VoxPQ4J86SLp
         7ac9AmguHOBPo6Vhu7YeBqgS+Z+s/tp+uwxndx69WZAbixAWEPpRd0YchnwweFzwc6Qy
         JcnZOSamHln+wKhb7jki6lEc7fakp3uqSU4o0xkoFf3XKJg5+eSIdofK6EGKhzx6G7we
         ZTlIEHNZp7OWvTPoUw4rV1Uxe7IcchpCCH9Q5Wut7/R2BTOw+wRxpxM/QAQEUdYXkhaC
         wTEC3sNqIpYW5ovbV84azmOFw8NToPQEhkzghv+kdwEjDz+EC9JrQGElq6g1KJWYT/Iw
         J3LA==
X-Gm-Message-State: ACrzQf3bWvQdStodEci6JF94XK9CdkBpqAb/TX2ki8kTvT/a7oAJ7l6d
        Kee9IIDAWgnJ3bpFY8VV0yg=
X-Google-Smtp-Source: AMsMyM5cY7KBVS/X2D/+rcSsmeBdZJm0XGF4XzYgW3jRr4BdqoJYonU0axDEcR+0Rpo1hXiOrJzwoQ==
X-Received: by 2002:a05:6402:3510:b0:461:f781:6dfe with SMTP id b16-20020a056402351000b00461f7816dfemr29417870edd.272.1667484224571;
        Thu, 03 Nov 2022 07:03:44 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f12-20020a170906c08c00b0078a543e9301sm501441ejz.200.2022.11.03.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:03:43 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:03:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Message-ID: <Y2PKPeEiliZNyg/a@orome>
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
 <166747792400.2122024.7504112765764946849.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IkOm4YS63giAiasM"
Content-Disposition: inline
In-Reply-To: <166747792400.2122024.7504112765764946849.robh@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--IkOm4YS63giAiasM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 07:35:43AM -0500, Rob Herring wrote:
>=20
> On Thu, 03 Nov 2022 13:01:37 +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Convert the Tegra PWFM bindings from the free-form text format to
> > json-schema.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
> >  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
> >  2 files changed, 144 insertions(+), 77 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra2=
0-pwm.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra2=
0-pwm.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.example.dtb:0:0:=
 /example-1/pinmux@700008d4: failed to match any schema with compatible: ['=
nvidia,tegra210-pinmux']

Still working on the conversion of that one.

Thierry

--IkOm4YS63giAiasM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjyj0ACgkQ3SOs138+
s6E4Uw//ZLj5wFdMT0iTQ01QFbqI2Q2g3ltTUp7asBkanJh3sZJNifLaHzcxSKFT
MxohEcGEXcyiIAkabLhX6ev8ejKe+PGFFZUhzxAKLmrcWh2Sah/d/vKGdkfLiHie
lnj2pmYopjemCfYgncD9RkTA9dFCudZbBGOvw7YYjHFdexkP1+n2wtdoX/7Xb9qa
Bq0VyKu3t8prQJm3oDOaKyag3ZXBDOyTee0fGJuQGU362vU1y5EOQVlnfQvlcG4B
9xxIF1r+tiFuUD8/asfcQfGkDPghFidWY7RwsU5U2L85dw+2WeheePQzF3WuMbbE
7Zi9YwWy2npsBhnVzKY6X/NQ9nuHxlyUM9e2/dCBPMytT5jonSGdWpH6B1Cs9b4p
po9ULx1g8a6JCsyoHPNpp9bkxq0E5gcvV72V5kJ0BvXHzgbrl/PPWUE46X3pNA0j
0f6Nz3HqPMIvn7McLemgLIcCwqTObbugHXh7yoUfQAYvZrEGkkNXPEET0Wc0MxSk
ZP/h6Gc0Fc3F8GJt4lG25pyetd0b0IwEeIMLCxPb2XIwVUD0C2A/eeDBDorFCTJc
FITnSKGmwgSwEH8oihqf8YbbO2AMPXqso2sz0Gf2hIwMoIwgKS4dfZj/KMukhLei
92H8+9SP6HELhmciv04YNYWkxPgVp/tbjZUUxiADY0z9iFlDqLk=
=slAF
-----END PGP SIGNATURE-----

--IkOm4YS63giAiasM--
