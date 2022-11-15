Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741FA6295BE
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 11:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiKOKZv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 05:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKOKZu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 05:25:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3558C1834D;
        Tue, 15 Nov 2022 02:25:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s5so4993114edc.12;
        Tue, 15 Nov 2022 02:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcxZYjpbn2eV6/WvnT+obXOgeZnC8xXioG+ui237ndk=;
        b=p+/waMWp/YPPi2zuK0xUepgwXrm990oLJPYLIhWqDU+l2nOLAoRnuIS3P8HwK0RXiV
         fMymPcAywmAmAoRTfpjcnppNg41vlLIi38a93XqruoL2QCvc8o15oE0mBJ0dB3MKgm30
         dMecDRCsysliS6C6fwF6EYKAWYsbrW2swntlHvA5T418CT9nELoTdhAOTc3SMWOSigmT
         JMS4OHO7xRZEpja63p2HRAHk3omR9CXV2U2WVXq1ZnZz/0/IYcdaAsm3MOOiW1W8g1w4
         J+nBDxBK3ONDt+NlU3I6v1PV31cJYmbV5jKRty6rpPC4ygF3agdyNtSEPc85eM5XT1J/
         mH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcxZYjpbn2eV6/WvnT+obXOgeZnC8xXioG+ui237ndk=;
        b=DXw2NLcW9s3jfdjJjuQ7T4a8qZxKJNMC5qIB3qTbO0rDt4dd9nKOnpdK3pKUkN9TZy
         5GvtiONIHMQYfppBJosGbHHCPS2v0nNNPWxkCAa+h8Rcl8i4TF9GGv4g66JYO6fkQug7
         CRcRmWyiHS32ai4vYC/CzkX1wb31ieM8NdrB8Co8qQXpOrRpgRBe6oA4IJLi5uIuGbD4
         e+4qSF9ZF0SQRtVktwe8YVEyjef3LN/G0a9EguCVJSJEDpy0luxx71CLxgzqE63OFvju
         jQMZA2Z1HXeG4nI6IoP3HMpS7hrMuA3jCYOwSo6nSerluQiIZ4Y6ixRZMMp0GlRp+VOf
         g18A==
X-Gm-Message-State: ANoB5pkBecnKWCr9KW7uK67dOkhH9nh+fh/sKbbTavyBjW/M4uTEpRA9
        qoZm+zmhiFfOb4ZhMLGNv5w=
X-Google-Smtp-Source: AA0mqf7KkYh41Ir0U/sn8JTfGNGkKtnVVNEBNZS3zDMGBmAUvKmOYAFxqecNiyVa+UPZKyGge1y8kw==
X-Received: by 2002:a05:6402:321f:b0:461:bd12:52ce with SMTP id g31-20020a056402321f00b00461bd1252cemr14419903eda.197.1668507948539;
        Tue, 15 Nov 2022 02:25:48 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00782ee6b34f2sm5282111ejh.183.2022.11.15.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:25:47 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:25:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: pwm: allwinner,sun4i-a10: Add
 F1C100s compatible
Message-ID: <Y3NpKbWlMvcDNeeG@orome>
References: <20221107005433.11079-1-andre.przywara@arm.com>
 <20221107005433.11079-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2xes7JCuwPLY+zC"
Content-Disposition: inline
In-Reply-To: <20221107005433.11079-2-andre.przywara@arm.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v2xes7JCuwPLY+zC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 12:54:24AM +0000, Andre Przywara wrote:
> The PWM controller in the Allwinner F1C100s series of SoCs is the same
> as in the A20 SoCs, so allow using that as the fallback name.
>=20
> Join the V3s compatible string in an enum on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--v2xes7JCuwPLY+zC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNzaSkACgkQ3SOs138+
s6H3+w/+MJpdt1BjQ9TSWGx9/Uf957PYJG4R3EI0PElk7GwAu9B2EI8UksZcHXaY
Yv8i0KrSJYVCwS3XVVrZMe+Q0phNkiu5Fhr0MR3kAWcHF0gAQrWRudeaYsF1o2b4
M8ZNdyIi9P54fT8PjE+VobpvcrlNvlcpSvt7K67oU0pI323mive0O57k2RSLqfvX
WxFv7VPio7UYmMdkYX0mar3ijYRYsUkePZDy+s96qc+0aM+i+2uFF4RHU7WmO06r
KUrQFP5sobG6G1o+cvx40hULuczJz6v0nVE/ImKWRybFO7YpF3/HuCYPMhSvNTMQ
yROAUT/cCIz9+lwpvILUkhfQ8uP/+87gbLeL/BEobXjT6rcKURQ/dLtmLB1JJsOh
SL3OjgByqHrKzB4EXxQYHgVnO2Q8Cq9uSUAufW7aBETKlUvt/lofTBEfTBjyhGNv
QXN+F2Q1Aj61bKmNSMpmE2pT5GrmLcTATD+FDzCzwNm/Ls6FVjsUpwiYI+ezS+xJ
RcQjmv62OKiUjfSlslfqZ+Lt3NopKmoPan57tlDN83o0PZodC5UiYQtln/cd/4F6
GhG6FHz6ojHPekH/bISrALAsbjl2JOKPtAEf8UtDJQ7W++BH03AIKpGZnchRW+Cj
Xs/E9gKPsYefTBtUwrFRDvEePST89LB4HbjVzEgvaI/UEWtmEC8=
=QuZ9
-----END PGP SIGNATURE-----

--v2xes7JCuwPLY+zC--
