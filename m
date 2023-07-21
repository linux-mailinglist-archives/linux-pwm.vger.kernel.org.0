Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0975D163
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jul 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGUS0u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jul 2023 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGUS0r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2023 14:26:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809B3586
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jul 2023 11:26:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9926623e367so361520266b.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jul 2023 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689964004; x=1690568804;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReDX7FtUoz89fYnF79wF/8ApI2kgr62YHjg2yUEk548=;
        b=qzRmV89iIswg9LdfWFov3Um5aKQSmVHo4pA3oaLupStSODm1eATJF3UHNhVEzXdiTN
         ugc31pymGmBbbLyOXzbASiV/9l5nEA2NPLsLL/xyhbfczLG+FQcKKjTRTF6WP2Cx9g+7
         GfHzXojrujHndEXmE4+VgSv/cs028BGtmV+LyqowW7PsJnmzgtWPLwTTM3Ur8NJe+n30
         W4pmHyOHmwk2tB5DYlusZL2N2oqHOp8lmWshPLHIjIfxj3p1G70qgHsUFF9jz9ZqrXf4
         jfBRuXXnfEzKioU563UcpE7xGILhuWLDG3co9onplvu6Zcf3HVuK4XswkACGPwnC7AxJ
         AzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964004; x=1690568804;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReDX7FtUoz89fYnF79wF/8ApI2kgr62YHjg2yUEk548=;
        b=agqPpAt3eWpBslotdI2XPyaxR4kGNpaP2VbOBmfRZadIvG3RrBBWwmt5olSUvWZqgE
         3YumjjYkbV46Ci2GP4dfR8eCCe0xEArhVGXFJLTVDQdPUccJd4uyUIosx125tIbbPHqW
         ESy+anDoBEIPVjsOiECHVRbRoXobzzVkjhS8mWbJESJ8MYCiLuByTrCRSsMUIznKIb1B
         3sAFW/hMcAlNA79ekWDyBdpb2rEyRCJ0UN/L05caKU5iPEuhhjteRcNSiQLE4reJ2Y7r
         eZDQhVX+dSaoPnO6wEIOhe4zWqbv33p1ytoe5ZAQVj35gq+S6LhMoWjl4DWbiP5FwntJ
         /wCA==
X-Gm-Message-State: ABy/qLYDVucXHv68BHzSnHClUrEck/vnW/aMmYqWjIVECNqEUjIocoO4
        unkS2QcGmNpavKWn/6H9H97D7ggq3ZI=
X-Google-Smtp-Source: APBJJlE8+GozgbackK5gxeYh2aAqAl4u8zSGIxHnDyxaygrKWSWKkOcHrUg1ojHdtWDTnPvKzOIoLQ==
X-Received: by 2002:a17:907:a07a:b0:99b:4fff:6bb with SMTP id ia26-20020a170907a07a00b0099b4fff06bbmr2285676ejc.4.1689964003424;
        Fri, 21 Jul 2023 11:26:43 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906455700b00997c1d125fasm2501350ejq.170.2023.07.21.11.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:26:42 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:26:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] pwm: atmel-hlcdc: Use consistent variable naming
Message-ID: <ZLrN4TQfYsaaFSFC@orome>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
 <ZLjZ_lllJ1PT3O5H@orome>
 <20230720072958.r54d23cefbrytw7r@pengutronix.de>
 <20230721175804.ent7umly5jjdyy4t@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B512r75CW4UUl7w1"
Content-Disposition: inline
In-Reply-To: <20230721175804.ent7umly5jjdyy4t@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--B512r75CW4UUl7w1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 07:58:04PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Jul 20, 2023 at 09:29:58AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Jul 20, 2023 at 08:53:50AM +0200, Thierry Reding wrote:
> > > On Fri, Jul 14, 2023 at 10:56:15PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > [...]
> > > > -	struct atmel_hlcdc_pwm *chip =3D to_atmel_hlcdc_pwm(c);
> > > > -	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> > > > +	struct atmel_hlcdc_pwm *ddata =3D to_atmel_hlcdc_pwm(chip);
> > >=20
> > > Can we not just use something like "data", "priv" or "atmel"? "ddata"=
 is
> > > horrific and looks like a typo.
> >=20
> > I like "ddata" which isn't so uncommon (pwm-atmel-hlcdc and pwm-sifive
> > use it
>=20
> I have to correct this. pwm-atmel-hlcdc only used it after this patch of
> course. But there is pwm-sti which uses it and the two stm32 drivers use
> if for driver data of the pwm's parent device.
>=20
> > and git grep '\<ddata\>' suggests it's common in other parts of
> > the kernel, too.)
> > It's the same naming scheme as "pdata". If you feel strong here, do you
> > like "drvdata" better? Among your suggestions my favourite is "priv".
>=20
> I noticed you applied my patch and replaced "ddata" by "atmel" without
> mentioning that in the commit log or this thread.
>=20
> After my reply above, that's pretty steep.

I didn't think you'd care. I've added a note to the commit message now.

Thierry

--B512r75CW4UUl7w1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS6zeEACgkQ3SOs138+
s6GV1RAAnvts+a5kp9ZetD4IPptTmeltVQ9gz6QZq33ZL+KsZiAe3fGuLYB0oUoU
1fy1k8z3+WuMZnbT884KReEkM3J37p4bnZFTCNSEsUVgQ+KpYun7FLemefiUpUVM
eh0PFZLXHGeHMJTeB/5Oi4ZkoD5BXpb6K+XWViaw8B4hiYmEY4D4gu4Ugm5q/8SZ
NLnFLqXf3f7D0CF/08O/DhucZEJmQ2Qs62BX1ydDajtm8E8V503F0EXIUEvCwXkW
PVgUECzCu2BsivMWIVPe7aznha3ypQQ/ia+JS5VHmrhWf4/FtcK0PaimhZ1YKmf3
BuTkYVPrmgJhssn2uSqOhN7tEDcCadg7p4ktDHgayJFVKGDVj77l92WUuGFuvFtO
YeApNQZxNjEoBQu3oDgQ1whUYbf+HDDeCwRc82o+QqmzU/ivcoLpm6CcGIbs5U9S
2sUp7dF1wONvwFDND3f7MUe/VcHFtwUTSBeSA2xv4hBwAZ4axkxaYEvlpPQcT1BS
YLdZPdmZyfeQjpMvRz0a9uRzPTjI0okdUENpzLTBfeTc8u/c3xOUHgN7QYVeXdhq
EUKm+bHr2IfL6w8kisKKHUn0tcE/YokmKQ1ApqG/cFejCbxjbcmr+ABdUHfwhYki
TmFGudT3uZLcyE00pAt/o2ENBGxaSY4eQU6IkGHedzbZLbj7amc=
=IRDb
-----END PGP SIGNATURE-----

--B512r75CW4UUl7w1--
