Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049EB63BF96
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Nov 2022 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiK2MBN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Nov 2022 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiK2MA0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2022 07:00:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304B5802E;
        Tue, 29 Nov 2022 04:00:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so31920810ejc.8;
        Tue, 29 Nov 2022 04:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDOLMR594zYsAjsAazk0R55kE0LVNumA43X6Lp5DSGg=;
        b=ByaIz4tUL3KsPofAPCjX8NcfMaKy3Aq4Ae6F6KyucvT1VNBksXPr2atiopwyBD+qCi
         gchpbkIu8zC6Ur5Ux9SpCiFyLtRfQggVdCwcrrFrGD8xcvstu4faVt+XFhZDKIuvaZ77
         o6WyNSm8f40oAcA+hkL9v9RtmBS401xxWmO8e2wWb3Z90pytfDI9gM0K8/cT7/O4/LHg
         VyGUfSNNxjr/w3Z0ST29UJGDAt78XasW1X0YXI40Q9bHeN45KZjL4hACHfiE8N7uqN2u
         BRjJRYaSk3jGPzbNO/4O07DE+U7uo6Ucq07ljG3FYhuBZ5zFB7+BXB2/aV4WlaP0iqE1
         NDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDOLMR594zYsAjsAazk0R55kE0LVNumA43X6Lp5DSGg=;
        b=CzjxhrOMGa8aBADDeFPaIUB39q4lG9KHJWwhm4fNwimZbEHqyAviy/XATTuxDJjDAU
         zMMCtYc0wpLAbnbzsKM+O72SFxns2V74YLvK+ksiOsDkyVqFR0XjAQImL4WDf7W6CaoR
         XMTn4eHbevF0kMv+i8lZ8zHfF9J0YCcn/1bP9IZC4r+VgphzyIzGqy5pXmffZ7rc5oTF
         aDCgypw4RKC+EGUCcHf4Z1lHxG+yp/xLcX7w43H9XDK+21uYrCEYjve2xaMzD78tRryB
         09PGryTHKOG/H8PUKbwRU4InAxYvvq84CebQlL8F4sNQCOOz7Cd5yrNMqqLWgaLYscXz
         +Hrg==
X-Gm-Message-State: ANoB5pkmpM83jNJFGNusoMlhntSEs3HlOTqQwFiBY2V3OJv1UzaCEV49
        LovFPGttrt2EkRxHHfLfZFIsJa77uTQ=
X-Google-Smtp-Source: AA0mqf4M9RnunuLXglmUJQDQyVncWVjbbJcg+k1UGCWYHhr6c5iFOdGQk7L+cZ9aLRQLUgw2Dlp6rw==
X-Received: by 2002:a17:907:d412:b0:7bc:68cc:7913 with SMTP id vi18-20020a170907d41200b007bc68cc7913mr19240365ejc.589.1669723203599;
        Tue, 29 Nov 2022 04:00:03 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i10-20020a1709064eca00b0079800b81709sm6035488ejv.219.2022.11.29.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 04:00:03 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:00:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux pin control <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] intel-pinctrl for 6.2-2
Message-ID: <Y4X0QUVIIddOK2+I@orome>
References: <Y30YOvHpqvte9otX@black.fi.intel.com>
 <CACRpkdZa7hOuU5e-i+_=TqM_Ttec6tvzgXXPm8giy=NiFO2tEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/GD0Vpfu2v3TcEyX"
Content-Disposition: inline
In-Reply-To: <CACRpkdZa7hOuU5e-i+_=TqM_Ttec6tvzgXXPm8giy=NiFO2tEA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/GD0Vpfu2v3TcEyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 09:25:02PM +0100, Linus Walleij wrote:
> On Tue, Nov 22, 2022 at 7:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > This is an immutable tag with PWM feature enablement for Intel pin cont=
rol IPs.
> > It's targeting v6.2 and have been reviewed by all stakeholders.
> >
> > The idea is that PWM and pin control subsystem soak up it independently.
>=20
> I wanted to give Thierry the option to say if he's pulling this in,
> but it needs rotation in linux-next so I've pulled it into the pin
> control tree now.

My recollection is that Andy wanted to take this through the Intel pin
control tree, so there's no need for me to pick this up as well unless
perhaps for conflict resolution (which I'm not seeing right now).

Thierry

--/GD0Vpfu2v3TcEyX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOF9EEACgkQ3SOs138+
s6HW0A/+LyHVYZWbahmAwh3mKW4DXeOH7k7xg/DSGBsKF5Y1YB0HnA8Lf1t0szLQ
Dc35qy4zvcjMEQVFOTyo8349jcO6O9oj/UFZ26GOxLacjpU16IPNX2T6OMjnVa14
DjagdRoLhdjZfeh1LdDhifS5iAMfBJcx1bLRlLTHPT0ufMIkX9xBO0csB4Vs05jZ
oluimHRuCUHicHenVpcoQ1Dwa+yrfbT4TGcienPe+faLpc5JcX8sGSxcTUVUuVUz
fshMdr037NGBUQfrPqpL+4g1YVUcPvLM1S9DObhu2YTEJNkmFRAecm9dBjnpz2FH
fP8pE8PY8yMU4NRFe8fiNX73mlve8FXmcxkc4Z3VaSYBUynvkUj+frZtcIF9y1GF
Hj0qrb9VcUOZZjypI63+0vBK1Dl+ervbtsNhr0S3o+DfCwWrZjhSKJ2fH8GVZt+E
36Kb15ARwUdRtmGmRbnjNW9xhiGOangqk0UBuO3Tcs7F3xgVYN34ukPq5rOnnsu3
MH9WDHd/fmgmmvcWVdjW8koWJJzpvjgGkIpG9lj9yvMVLEAweOg0LAE87ZIF86FY
FRuECYBxRf/DgpNl4Au7w3adqhBYNqMQZ3iFi8acObqpnajFD5mPmhRwYQHfLcT0
Xzty1vDXhb8CRPGmCUBjKCRxJSToZwxdZLrS2YrW2jKypq6TDYo=
=c13C
-----END PGP SIGNATURE-----

--/GD0Vpfu2v3TcEyX--
