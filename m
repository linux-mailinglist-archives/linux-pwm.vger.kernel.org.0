Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F7618209
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 16:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKCPRJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiKCPRH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 11:17:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B13165B6;
        Thu,  3 Nov 2022 08:17:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d26so6087704eje.10;
        Thu, 03 Nov 2022 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fngsUcfn8EGw1QstVkue02BHGL22BCuMmJ9dyGPsQRI=;
        b=RWeg92kfev0QQdln8+PFRXW8MDBJEuoKBOJfSpq9RyLjuhfonK1g+5F33yK2kzv9dP
         95FhhmbinrHa1UEgVr7yWZe3P2KaIcQUsFKtHQRe3uthmQk3qiUT8G3EYpz2HC77rlJQ
         1i4Zb99QsvubJ5rraTBO8p4NhnWbcb1G2r5pwRkswJq3701JfKsZNqLKI1mDyd8HT371
         aiF2W0XaIXjj/knSRLJIzroYgafh2VOWXFJ+l2rIgRJD9/pGWByQRXDHqOnbtNsv6XNR
         xKfFmj0jq7JgzOn44ZEL1fz0nkGCG8hbPqnBlymUWEbitj7puAzrxdEt1YJWv2Efl6/+
         zhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fngsUcfn8EGw1QstVkue02BHGL22BCuMmJ9dyGPsQRI=;
        b=5lxy10qzdcnOewIh8OvAg+JnnWPWrgtsbaDgqLG8qQqbVwftUWQTxoHlnhoz/WI1pa
         58UFqJcsS3VdVdWKPUPNUm3ydJ5mhyYMoiZY00LnlVgBe9aP1whrxIkZlyPjoAckUEGh
         /qnia+bOPWaPJbLmJiubaNqiB6Geg7sMzYM412Xcd0UsS4pUHu2rs/ZqB10WxkQE9OYP
         R9xSEdYYWYB1Am+gx7CvVXhcJCWhCbUdrpADeAPXL7mb4gg1dN2sUJnsY3PToQ5/zvQO
         bffRz1ypPjsgQ6xugCN49knxFIakCpUXXDi3Fv6JdACukN1ke/GDJx5nUOFRsksgcj8d
         DTag==
X-Gm-Message-State: ACrzQf16ArI7m2gIl3jtfsXrDBrrsfM9/uhfHKngA12YShM3Xsd6/XMl
        m8ub7xsdz1M7WvolbuDyu/o=
X-Google-Smtp-Source: AMsMyM75g429z2C8EG+9cRnd3hXk3b3bRUwufmxXw6QJ3Jq1Utvw7PlDg1hbvLecH8bgIwbntx6oDg==
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr30796866ejb.100.1667488623821;
        Thu, 03 Nov 2022 08:17:03 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b007ad94422cf6sm581528ejb.198.2022.11.03.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:17:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 16:17:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 2/2] pwm: tegra: Ensure the clock rate is not less
 than needed
Message-ID: <Y2PbbF4FRmXztlbm@orome>
References: <20221028123356.133796-1-jonathanh@nvidia.com>
 <20221028123356.133796-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ox3zOybLO4kFkK+L"
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


--ox3zOybLO4kFkK+L
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

Uwe, any objections to this? I'm assuming not, since you proposed this
variant yourself, but would be good to get your Acked-by nevertheless.

Thanks,
Thierry

--ox3zOybLO4kFkK+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNj22wACgkQ3SOs138+
s6HQcw/9GVycOVYyFAkZwdoTAdOnYU27ZUexaK/0Mm5dHcT9rW6fxQP0D6iEGF3r
PdmzrrwCN3m0S7EhXr/A3qs+5XIa4qkeYbtTew4BlJFbDBC4qVz5ZOU52NKckrO0
nJwvxWcTaZrzDvfEZ4H/UFkBD2kKoVEq3hFBeqXnXUZs+I7JM/b5WQJ+IxW7zQRX
vkf86ht0hI3D8STGN/CgRQc3re1xk48SdKBkaC3i/vRXYIoKMQq0sCk0Dh6Ydlxq
sqxqlPOElcYTsJRYwfPf+PhgE4NbptbMShsoxo6TstXM9EXs7es84lpjVDIASu+k
QAIZoawmKwu8MTkP0EEzSCu55NKc8PRU+Fqme3zSTodgKNodB0y7kNGghgGzj9ak
8WiZi3dQ4MyyU3OiZoPKXNUmYNiNCy6fe/4kgU/QLQQOXGJyL/uahBRAkPiqGagw
VB8vVA7ZWtseyQUoTC+Mgqdxu0uCzap9gx3CUbbyYf7zzn30xjSZ/j8v8IlQ3+rH
F7ztyfg3J+aDz6PcB2ZSl4Rbokt+OQfTWUBb2va/21HrQ8ZPBT05a0dGxcPQVgS+
XMNnGvraE76ByuGdTho+GEU4Cuvy2NM8F4cXRgQsb0rscEBdlbUUqhWdQWdTNfcI
qjcVkOE/YW/hG8WC9QMQX8WZwKc+6s2/8kYqvTo2UEC1SsMsymo=
=83dR
-----END PGP SIGNATURE-----

--ox3zOybLO4kFkK+L--
