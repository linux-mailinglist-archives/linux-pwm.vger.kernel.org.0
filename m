Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836F621357
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Nov 2022 14:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiKHNt0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Nov 2022 08:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiKHNt0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Nov 2022 08:49:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688729E;
        Tue,  8 Nov 2022 05:49:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z18so22539416edb.9;
        Tue, 08 Nov 2022 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c95ZPEtISLCedyNk9u0ebKNS7FQi7eh5TIwJUEhU6Oc=;
        b=ClcXVYOQS1ir/Y+VkxmuB1/esNQOIkJwDDjukhhM/7weYeR0VMwWvmh6keVD4aPno3
         jW5193E30tj5iyUwZ4pcQJMW4NOon3AEg602qAoTpq0kfll+QE3vBRItTug8j5+EOm8X
         NqYv0z+cEzQ7ZpHZFWNG7SOOukAAw3FEibLt0Vgwnst1POuS63OWiIid8J1OmOmUG0fp
         c3+VEzdr6oe6gGXFbsSUbAR+iT0LvMIEnMQ4LTypPUvE/yJe0zGzO3ybXRedNQrai1mN
         fssOdYSwe+jxZxRPWv6wQE2sqh40soCZQOD5Gywqy7y4it+P/iXc2lMW8PGSWjqMEbLP
         O4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c95ZPEtISLCedyNk9u0ebKNS7FQi7eh5TIwJUEhU6Oc=;
        b=pThRhZLoEUP341Pwewoar+v9he4K4u2rucv77zbqkXYXsRONdv1W9CRm85z5Y7h2X2
         0I+dh635mU/XTqSPyww8/70nTiykFWWfSL6uitmFEJuuPPi7vGL5LToaMrUBZGg9Ochg
         Ip46ZWV/Q+2SU5IiSUoSgUo7nww14vi3oQVb128gIOj9QRKb2GbEF95fnfNeZTEkaA2L
         3ZupcoVhlN7pkK32PAtL0f17TGMlfv+V6xm/2xiahlgWt6DYWatdw599FKDr/Da/cBBO
         2JD6a4cWm0M1jO2D5jQFi9CKo9OspO3PWuWvZ1CihBKh0PG1xAc3WxfGDD2fOVWbl/SS
         S+SQ==
X-Gm-Message-State: ACrzQf1ijzOu2o8HSJcZyF1+FioB6SqDPQip0X9uQ9G/pZXQr/aV+HM1
        FJKs0G2TnarWqS1CNf9+jD8=
X-Google-Smtp-Source: AMsMyM7xRtoHI5OxCUlmZ+L84S+cfrmfoFpZKzusxHqZ37V3TWVSmO364vEKkcMsewA1OdUNCmbSuA==
X-Received: by 2002:a05:6402:35cb:b0:462:6545:5d99 with SMTP id z11-20020a05640235cb00b0046265455d99mr56353638edc.51.1667915363947;
        Tue, 08 Nov 2022 05:49:23 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b00771cb506149sm4769765ejc.59.2022.11.08.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:49:22 -0800 (PST)
Date:   Tue, 8 Nov 2022 14:49:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 2/2] pwm: tegra: Ensure the clock rate is not less
 than needed
Message-ID: <Y2peYWX5jGUu8ARH@orome>
References: <20221028123356.133796-1-jonathanh@nvidia.com>
 <20221028123356.133796-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jax0Wr6ZptALUy+0"
Content-Disposition: inline
In-Reply-To: <20221028123356.133796-2-jonathanh@nvidia.com>
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


--jax0Wr6ZptALUy+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 01:33:56PM +0100, Jon Hunter wrote:
> When dynamically scaling the PWM clock, the function
> dev_pm_opp_set_rate() may set the PWM clock to a rate that is lower than
> what is required. The clock rate requested when calling
> dev_pm_opp_set_rate() is the minimum clock rate that is needed to drive
> the PWM to achieve the required period. Hence, if the actual clock
> rate is less than the requested clock rate, then the required period
> cannot be achieved and configuring the PWM fails. Fix this by
> calling clk_round_rate() to check if the clock rate that will be provided
> is sufficient and if not, double the required clock rate to ensure the
> required period can be attained.
>=20
> Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Multiplied the required_clk_rate by 2 instead of adding 1 to the
>   PWM_DUTY_WIDTH and recalculating the rate. Overall rate should be
>   similar.
> - Updated comment based upon Uwe's feedback.
>=20
>  drivers/pwm/pwm-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

Thierry

--jax0Wr6ZptALUy+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqXl4ACgkQ3SOs138+
s6FrOxAAiiVAnUVLo3xwPSvAWZZ2hiLagafQESy4/z/+VyNbwdZdppycJzSIcvqV
u4EgqSB0Jg7Y8FF06Cuo5pooyxz2W9BRBpgpUV6wC5Qbh7TSguZHo6AWws9FLO1a
5ffFBcyaIU/fXoCcsUpiVV2eWoqdzO8q9CRGos2Bzx9wkOmRD25EfpKxxWhp5DYJ
VagQFvfKEh7QhR/wrU6Vjkii+dFLKPdCzakXYNOCjZ4Yr3eGCMHyeZ6mZZR4GxtF
PwdEdI3ivkSAzDZ0R3n6yqBLM3q4DmDQbog7I1sD40LB3NwhpmfDpqn6mSyT9aSB
fkHQ18VBdDezimUSgzVNtCb5wb/v4a3ApdLRl7jWnu36Uh0/YWGASvDcDysKgV5i
cK/HPINVSGQPXgsxCNUQLrK57JrlPIgY0qlcZQN4EZ9sgdZYEn2rP7RuThE31v0E
+YUHZLoI2qUFgxKjf5pNvfWvPAiEJf2Q7qtMEnW52AY4583oHAA/Mf81iBwmxBrB
bLGhM5kaln5gZIrEmXxJxZCK9Q9OJRzEenQx0dI4vNHaMbARO9JjRvBy4pGFZsmg
XXl/79IaOHo+Te0ccAieDj+j9hK4Qa98egoz5DZn+TtixnNj6+6SfJHe0MnuZ0Ec
/UPYGozxWwd443XJlJ2P/g4mrquFHGObPCcXlsTbcQ27xFXNv3s=
=7MxQ
-----END PGP SIGNATURE-----

--jax0Wr6ZptALUy+0--
