Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779B5844DE
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiG1RVs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiG1RVl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:21:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C30743F2
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:21:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so3127606wrc.2
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+etLTzNyLJaLhfnN2Y0kWOJM0j7ATJJ9jDPhPNxfgU=;
        b=WIcMjMSXA+1gvFlpvcTCCpGNtTHFOVEe/jAX23J2P7bmpQndiKIwrBAtBPCwxO6e2g
         P7GqyHEP66Ji3gXcm/sWL9VCvqLNe90c96sBH3gQU7obtDD/BkdinoUZV7X2BUJi1Tr/
         XPfje0dWFk1a+RJjh14/4SRGlXd9nTaUadE/I+0eCTxqvFGi8qENAySnslGHroB1M/Kl
         YRMcx+klWRJ4uKTG7vPpOJvlH6/y7cOyMFGTDzpAGSWxok6wCYwR3GGU6I9q0fIyP8rh
         waVJNvARADP2EY8kfXaLQlAHBvBWw85xTZpjyKk4pUEe31t47Z0/sYJVJIzMPfQRUl94
         2GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+etLTzNyLJaLhfnN2Y0kWOJM0j7ATJJ9jDPhPNxfgU=;
        b=dPqq1XH3vtFNjlTpiJZ3EfgibpjjE+tdKi1bCUFeCpurZStRuJu7JeM8hsn477ZqGZ
         y+KOt8F++XtgR29LkVR2q85742G5xhxC3ZGl2IY63WcTk+jfSOuyGlDf5xt0tVD9bmto
         j+ogWMRjYPmHjIfOniv1fVoyehR8074GeF/D8wGwKIa7JSBCKuEXvH5D+P2cOQAYst6h
         wOriJhkudpYLvRcnlWy+A+E0hpDzRZBTTvpnhStjZPeDwR1cry4KuRXTzEwqtole7nxU
         EkPVKu97bP0ALCpnlnHBOQAhsuT8ocT5VN7qaXk2kTnBeFsqnZ2wUmKwVmIY8dfeMY9y
         ZcHQ==
X-Gm-Message-State: AJIora8VrR6c/8hqSIiJo+FjrpkbJmuOf3aGQri84m57dZxb5llZ7m3W
        IfTd2H4D/zCe08F31kmH3xQ=
X-Google-Smtp-Source: AGRyM1s2utHVMrbvjAy9quP4F3Tm33jybmKLMDRCMayiwtfrw8kRDnNCOuA1v0+iauiVvy0DzNEONA==
X-Received: by 2002:a05:6000:1549:b0:21d:bdce:1d01 with SMTP id 9-20020a056000154900b0021dbdce1d01mr18795425wry.373.1659028874536;
        Thu, 28 Jul 2022 10:21:14 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f19-20020adfb613000000b0021e13efa17esm1458762wre.70.2022.07.28.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:21:13 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:21:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: twl-led: Document some limitations and link to the
 reference manual
Message-ID: <YuLFh0t4AiVx2y0K@orome>
References: <20220712084656.21043-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZkvPDctp6KLpbEzu"
Content-Disposition: inline
In-Reply-To: <20220712084656.21043-1-u.kleine-koenig@pengutronix.de>
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


--ZkvPDctp6KLpbEzu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 10:46:56AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> I found these just from reading the reference manual and the driver
> source. It's unclear to me if there are glitches when updating the ON
> and OFF registers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-twl-led.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.

Thierry

--ZkvPDctp6KLpbEzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLixYcACgkQ3SOs138+
s6Hoow/+PrQmxKTuHiIml4vKUQbOzTrz3EoxrgiYaHOQ5dOg6uMpu28dYTLBUi+Z
haWdPHJl43QOoKSgkkt2bKhbsA0LkXclL3a7v99cGFZkaJx3VcyDIFvhbwLDn6nF
tk8eYJtKrvqz5dYZElc4fSxdxfgsbQH5SyrhiKRJHM3vLL7AMkeauq9bZ/yZ8UMC
5N7QHX12Z2LbYPuuj8/6YAj5oqRgtrRQHTKihRTv2RQQTudvKadMgBqZKkQj4Wgm
7hJ8HQgx4F+Ipq6PjNmzkkyUzTet95SUOBAkfE5R5uDEAUEiSwDLVmLQG8dXXmmJ
/K0QAD2eCGPsbqzTHwlvULf9RhG5fbHV5DRShUSjsqH/4ZkW0c+r1SMWlG0u/BHu
F/hN0URL7pQpUIJaEs2Gjd893SQxADgcgACrb8Fc+KSaC3mmnusk/MCOWs6D7xnS
rW7y3J6cTZh1Rq7+c19/gtMhx/fRncTid2I5TNyLoR3xk0vUKaa8RuqHzlOn/pqd
ExMfJaSAaU2QRvQ7bOKF8+U6RKi74ZgcvCoIpNC9E9AUacoUEO7uDRrcbIxoAapo
6+SI8OdwaoiiGe4pV3MmVFi/FZ3Q/iaVGdSh8jWM0Dt6gUYRkmBd2if4QEgyp84k
79GyzMaiYoPy1nNvFhVrU475ceo7V9Z+cr2D1a6fjB1yHm25frM=
=x5P6
-----END PGP SIGNATURE-----

--ZkvPDctp6KLpbEzu--
