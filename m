Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A965F1EA2
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJASfG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJASfF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 14:35:05 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628C2B254
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 11:35:02 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1322d768ba7so1770099fac.5
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OiI3E+6H4Yal0p8g4nCqWQy/bTqtjPHQ8IM4+cOeWtg=;
        b=avurqTBziyOOtMw9V4bkqb3avKdSb9EPhYXx0I2Nm/zQlzL12Zb2JcOMU+ZNHNUKyz
         X9Y+zYqpaZLhojWd0Y9LpGjgryS63N1Oo1VcrQUiufYCRDi4QEDvnK7gWrPdVOnnWb8j
         hXzz4FjvScOop/qiwqHZspWF5fVyYgsPftFJmNLrk6VZSHsjoH78LYLngpfex+C+slUs
         mCkxffri9FqCsNdKIcKZ41SSmaPsZdW1CowiLIuWsGR1u+xuWxvSnbqkcw1c0c99UTZQ
         wm3zF5P4FyqXgbvTlrkJnIunyDqw3j5hMBNE406TraH7K518bMW3O2K/+jjfQibBNy1m
         eBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OiI3E+6H4Yal0p8g4nCqWQy/bTqtjPHQ8IM4+cOeWtg=;
        b=QbBUEJdsIScLKnW+yomAarW1ErobVhIPGQ2dVwKHz5giiqXHd1m+fOwOYNhRQ+XHv1
         eGSyz9vk0ubTmZ0qDjxly7GYXYOadatChHp7DF8Q7xcrNqiDAHSp9ZJ5PDmEA2LdFjCI
         v4l1TzwWz0RPscPcKtq+9rXJ2DAqkjIqfEUViDyqonc0LFdNNO64Li/JTLNYWmpq+BV7
         0X+rUcXE9gn47O25Tej+PX6GN5JhL8EGjnYcaBUa9+Zqw7mKcrZcT0yo/958QubPMmRV
         p3ixpkIkqzvst6b57nB0y7A8b5hhJ5RxtFMybFKAWXdQTVKsFCnukj1kHMG4D8qFVwfs
         U0Ww==
X-Gm-Message-State: ACrzQf0U5xnSFm0UxaDss286YwN1YFsQYHbnarLbWPBbb3BXW1XRhVVY
        3YNRS208mPd1MYVrykZgPDntAg==
X-Google-Smtp-Source: AMsMyM7y1QrchuoDOGVQdxyhvMyeqosLwqBXuZrniS6hJMnsWahC5VYUvnw500q73cV0kyJKJw9F3Q==
X-Received: by 2002:a05:6870:89a3:b0:12b:45b6:80de with SMTP id f35-20020a05687089a300b0012b45b680demr1967595oaq.263.1664649301382;
        Sat, 01 Oct 2022 11:35:01 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id eq24-20020a056870a91800b0011d02a3fa63sm1604819oab.14.2022.10.01.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:35:00 -0700 (PDT)
Date:   Sat, 1 Oct 2022 14:34:57 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <wbg@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Message-ID: <YziIUV3tyPd0GrFf@fedora>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzh8ULruBgN1tf+L@fedora>
 <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jIsWhV+AUqJpBfeK"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jIsWhV+AUqJpBfeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 06:03:37PM +0000, Biju Das wrote:
> > What is the configuration when 32-bit phase counting mode is selected?
>=20
> LWA Bit (MTU1/MTU2 Combination Longword Access Control) needs to set for =
32-bit phase counting mode.
>=20
> b0 LWA 0 R/W MTU1/MTU2 Combination Longword Access Control
> 0: 16-bit access is enabled.
> 1: 32-bit access is enabled.
>=20
> > Does MTCLKA and MTCLKB serve as the counting signals in this case,
>=20
> For 16-bit and 32-bit counting signals same. We can set=20
>=20
> 1) MTU 1 and MTU2 signals as MTCLKA and MTCLKB
>=20
> Or=20
>=20
> 2) MTU 1 signal as MTCLKA and MTCLKB and MTU2 signals as MTCLKC and MTCLKD

I'm having trouble understanding this case. If 32-bit access is enabled
by setting the LWA bit, and the MTU1 signals are configured as MTCLKA
and MTCLKB while at the same time the MTU2 signals are configured as
MTCLKC and MTCLKD, how is the 32-bit count value determined -- wouldn't
MTU1 and MTU2 be counting independently if they each had separate input
clocks fed to them?

William Breathitt Gray

>=20
>=20
> b1 PHCKSEL 1 R/W External Input Phase Clock Select
> Selects the external clock pin for phase counting mode.
> 0: MTCLKA and MTCLKB are selected for the external phase clock.
> 1: MTCLKC and MTCLKD are selected for the external phase clock
>=20
> > with overflows on the MTU1 register incrementing the MTU2 register?
>=20
> No. that won't happen as we need to use different register for Long word =
access
>=20
> These are the regiters used
> 16-bit:- TCNT{MTU1,MTU2}, TGRA{MTU1,MTU2},  and TGRB{MTU1,MTU2},
> 32-bit:- MTU1.TCNT_1_LW, MTU1.TGRA_1_LW and MTU1.TGRB_1_LW
>=20
> Counter in MTU1   MTU1.TCNT Word MTU1.TCNT_1_LW Longword
> Counter in MTU2   MTU2.TCNT Word
>=20
> General register A in MTU1 MTU1.TGRA Word MTU1.TGRA_1_LW Longword
> General register A in MTU2 MTU2.TGRA Word
>=20
> General register B in MTU1 MTU1.TGRB Word MTU1.TGRB_1_LW Longword
> General register B in MTU2 MTU2.TGRB Word
>=20
> Cheers,
> Biju

--jIsWhV+AUqJpBfeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYziIUQAKCRC1SFbKvhIj
K13sAP42H60oOCvp2BKUOKE2xETOT8PYhzcrCTmDBS3AIhPiigEApFKjur1P+nb3
xzbq/3l8xB60GCtwhLhgAKnrQxNCqgQ=
=fYgv
-----END PGP SIGNATURE-----

--jIsWhV+AUqJpBfeK--
