Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A827475B1F2
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjGTPDW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjGTPDV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 11:03:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D926B7
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 08:03:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so763730f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865391; x=1690470191;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9T6xDcaGdFqXpwnBEyH6XzquYN88GIZKDHbykcmRxA=;
        b=dSEvn9QPxO9EVVW5ZGjUhUJUE3+OUOg7VWh6lwkKx+3zaEg/BnEepLUNRdoNU0j7Cz
         wyhm0EPH/tozgy0H1KYAWbgzLNDLTv8CvmCaXaZcclLRcMskp29IBudDp7X/9DhmiKlm
         HL3p3EUj9WhCU9sm01p/KtbD9vEAw+f1on0TfS8ssJvHluib1iHupvByidVbsWqzvzXJ
         6plME6LqTd/dyZ2j8xrx60lVKVk/7Tgyw88nHVYl1y57WOuQHaBuNQ1Rm2bmDTG7ahlF
         +jtPpxoBXCsAOQGw9+0lC721Of0twvgTCR7lhDxfAEnAywVrrsQ0izAvo5qRXad0Ld+Y
         D+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865391; x=1690470191;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9T6xDcaGdFqXpwnBEyH6XzquYN88GIZKDHbykcmRxA=;
        b=imgZsPg28bIoxKStTYJtK8URqPDHKVDz7BIZsC+fI6ceFyEUotJdU6uKDOkot9bHK7
         F+6YEpMNF5+c/tIHP8RWQQPob8MEAqpO+HN8qedXYTTL3H0doqvIyyaAluIn6kKvp8jw
         V+XwxuC4XogNoxkP3eJqCucYaBErHiXn6R8EVTrf8OIVAom3UJQAymDSDU5iJ6O4aNov
         li6rnKvs+RgKkistsiBr42fbTT3aHfJRPL6f259vaEvJIqmPgbob9NbtYWIYw7QQFX3I
         FtD95yOhjRy7+f85Cp+MR+zYtyiFPjInRUuCBvd8XacUPZPGWGDkh7454MTHiPuDcdeG
         OaVQ==
X-Gm-Message-State: ABy/qLYkd1w6cinvnA2G2l9RxqlbSt/iXuVwlAdWQvwM/ZYEMsp4EBZY
        7pye+PDoqdutl0xZHkE2CSwU3WEzPNQ=
X-Google-Smtp-Source: APBJJlEr5CyHhhpLYp3q/AVdeWKExZ21rYH+UIIgwfGMQMwnqR91YpoT/wK/430U56C5ddPybLCc+g==
X-Received: by 2002:a5d:55ce:0:b0:313:e8bf:a77 with SMTP id i14-20020a5d55ce000000b00313e8bf0a77mr2183185wrw.5.1689865390637;
        Thu, 20 Jul 2023 08:03:10 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b00313e59cb371sm1599728wrt.12.2023.07.20.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:03:10 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:03:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-staging@lists.linux.dev, linux-rockchip@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, Johan Hovold <johan@kernel.org>,
        greybus-dev@lists.linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Alex Elder <elder@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
Message-ID: <ZLlMqwAnoPzI8ONt@orome>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <ZLjYqwGh178EHrVY@orome>
 <20230720071033.e72hjkpghf5ooe73@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CL52jB4nG8OB1M/q"
Content-Disposition: inline
In-Reply-To: <20230720071033.e72hjkpghf5ooe73@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CL52jB4nG8OB1M/q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 09:10:33AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Jul 20, 2023 at 08:48:11AM +0200, Thierry Reding wrote:
> > On Fri, Jul 14, 2023 at 10:56:13PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Uwe Kleine-K=C3=B6nig (10):
> > >   pwm: Use a consistent name for pwm_chip pointers in the core
> > >   pwm: atmel-hlcdc: Use consistent variable naming
> > >   pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
> > >   pwm: crc: Consistenly name pwm_chip variables "chip"
> > >   pwm: cros-ec: Consistenly name pwm_chip variables "chip"
> > >   pwm: lp3943: Consistenly name pwm_chip variables "chip"
> > >   pwm: rockchip: Consistenly name pwm_chip variables "chip"
> > >   pwm: sifive: Consistenly name pwm_chip variables "chip"
> > >   pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
> > >   staging: greybus: pwm: Consistenly name pwm_chip variables "chip"
> >=20
> > This would've been much easier if it had been a single patch. Now I have
> > to either make you redo the whole series because you've misspelled PWM
> > or I have to go and update it myself in most of the above patches. Hint:
> > I'll do the latter.
>=20
> I guess you want to do s/pwm driver/PWM driver/? Fine for me, thanks.
>=20
> > There is really no reason to split this up into this many patches for
> > such a trivial change.
>=20
> Well, that's a subjective view. There are reasons to prefer several
> small patches over one big one, too. A small patch can be indiviually
> reviewed, so the "Reviewed-by: Alex Elder ..." tag only goes to the one
> change that he actually looked at and if later a fix to the sifive
> driver is to be backported to stable, the stable maintainers just pick
> the sifive one instead of one big patch.

Backports becoming more complicated would actually be a good reason not
to do this in the first place, but we've already discussed that enough
elsewhere.

> Did you skip the sl28cpld patch, or squash the fixup I sent in the reply
> to Michael Walle?

I squashed the fixup.

Thierry

--CL52jB4nG8OB1M/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5TKsACgkQ3SOs138+
s6F+LQ//Zs8K61taGOGqAeIFgMkT8WRglsOSZQPOn2E1/c4RWwUspgRCfQs6nAN3
n1D2d2th0c0z2xfswoA6Q4TIzMyfejDbfKdslO705EbwQLXXLsOrrPJ0ART1RfsD
rfsvJ/xiJlVX9AEFK9BvNyICipw36JhttBLrai9rVpd6Qw9SrhTt635P5xY5+DhY
YK+dKHlwQYICb6dr4v14AbszZOAZsQLq2tro0AhcB7CwCUKvmZIAhGKfbj4jlsWd
Q6iS2UWxdBMV7rjl9v3OwU2+MqNQwSKQ/RAFWIN/w/jHH7gdj9H/z7I7yBVDJMyg
21uVm556sofBlWFwlVSfkng9YkM6fTBOt8Su7mV3AUZ4ufy03RMqXV29t6ks+8S+
CTztOmWniJT/lJdhkAA3H9Sv010rjRKZjvHiOCilbgDyZ8B7BNY2gl1zoBUC/WrJ
HzIwcpbVc6NQsnjFtnBMsczS9MHqIFXjHnUMSIYIhoUxRc5mnZWs+cgbzc9y16UD
N/WWzMSwkhtaXIGVo4PSkNxuTl0vHFRHdXiy7o34cANT+UwWhHrJgNFx9VTphYHY
VeP/0Qv+NWY4/6B113lh2Bq7cXY7RtyDXygdB3yraplPW3/vdU9d/kHeiHCTPRDK
/w3AlUr10ciCY/6VXaGVt3JsNpWKpK3qaI/B0lkLNJt0+ZOwHFE=
=Z1TB
-----END PGP SIGNATURE-----

--CL52jB4nG8OB1M/q--
