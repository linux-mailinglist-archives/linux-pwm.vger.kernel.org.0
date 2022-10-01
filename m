Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFB5F1E71
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJARnz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJARnu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 13:43:50 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0C657C
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 10:43:48 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id df9so1017068qvb.9
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BVwqJJ+mZiKSxFSeUZO+7zrH1+FHwwhD3golEmbbd2A=;
        b=ygnxlUP+fQ/bixWMa+pWc2qSlRAGNPHg12Oih67c6Rd84wONBTzO5CiiBFg0CHWXBP
         NEwATWHYsCX/P7rOTLkL8mNCJiVYiEFGV+IZqTkAdUIIhi8qKLaugLtQXG2iNbmBFE8W
         XJ8Z5TJu/erIhenaWFbXdNO21au7RZ9iv/nDNwCFstYCuq9R3PgER1t4drKMABhCEShq
         MMWhsKxgj7WBgU2cZrrQjw9CaGZKrBA2yyHRq7hGIUXXljSL4EF50VPRTAV/AsoiaRci
         ae80CXk+3ofmzdIVWp889mT+etaBws9stIUq8VtZqD2/jcWXTLqiSe25z+VFkVwOxuWz
         plaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BVwqJJ+mZiKSxFSeUZO+7zrH1+FHwwhD3golEmbbd2A=;
        b=iLgz55x8r3qHHTHif6zXKXj2dIW6l2iVDetkrlH4mP6H/AV6eoTeSeeQoKv3XlCwYv
         JDYfZyRc04kzonxOOZ5zJSwIM1UqtXmkb+VDz49JXZeNP18hiuVzZjtkv6jwepDu+o0Y
         XzN8NfxCVSYG24cNH1Ovm5dBarnGfaB6N7tQb9AMIM9UFYYhsngiwUIeT3tcnosk/lm3
         c0ghAM4P0AO+DuCYW5EAs3p6jzHdxQoJSsntqWIKbeYB8sTATBKiMDp12TP4oXldrDe0
         +KWNQymVt78Xvdrcase80lqLj+FUAP/58HWkwPB66RDy+D+8duQkFJmmjvSP4Nmog+8S
         hOqA==
X-Gm-Message-State: ACrzQf2L1T8AsEJU/A0vURTH3ovqhLesSbE+fmzQd/B6mfCEiinBJ8ll
        Zl+/lo1fDld/LdfBsk/fyCRqbw==
X-Google-Smtp-Source: AMsMyM7VndfNVTNEe93pBgRrgyxKkYAomOcS1tqtDi0eS3dKmWvBkKLypUNNnf7T9Nu4ca8bD4tCIQ==
X-Received: by 2002:ad4:4ee6:0:b0:4b1:80a5:49e3 with SMTP id dv6-20020ad44ee6000000b004b180a549e3mr1940183qvb.67.1664646227167;
        Sat, 01 Oct 2022 10:43:47 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006ce60f5d8e4sm6387517qko.130.2022.10.01.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:43:46 -0700 (PDT)
Date:   Sat, 1 Oct 2022 13:43:44 -0400
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
Message-ID: <Yzh8ULruBgN1tf+L@fedora>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+5J+JJlLnn4OQztr"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+5J+JJlLnn4OQztr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 05:12:56PM +0000, Biju Das wrote:
> > > > You can then control the phase selection using a top-level Counter
> > > > device extension (e.g. /sys/bus/counter/devices/counter0/phase)
> > that
> > > > configures whether you're in 16-bit phase or 32-phase counting
> > mode.
> > >
> > > So I need to introduce a new sysfs called phase. Use that one for
> > > Selecting the external clock pin for phase counting mode.
> > > Please correct me if I am wrong??
> > >
> > > Hardware supports 4 pins for phase counting mode,
> > >
> > > MTCLKA Input External clock A input pin (MTU1/MTU2 phase counting
> > mode
> > > A phase input) MTCLKB Input External clock B input pin (MTU1/MTU2
> > > phase counting mode B phase input) MTCLKC Input External clock C
> > input
> > > pin (MTU2 phase counting mode A phase input) MTCLKD Input External
> > > clock D input pin (MTU2 phase counting mode B phase input)
> > >
> > > For MTU1, it is fixed MTCLKA and MTCLKB.
> > > But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - { MTCLKC ,
> > > MTCLKD} On reset it is set to { MTCLKC , MTCLKD}.
> > >
> > > Cheers,
> > > Biju
> >=20
> > It doesn't need to be named "phase" specifically, but it seems like a
> > new sysfs file will be necessary in order to select the proper phase
> > counting mode.
> >=20
> > Are these MTCLK signals the quadrature A and B Signals you defined in
> > the counter driver?
>=20
> Yes, that is correct.
>=20
> Cheers,
> Biju

You should define a Signal then for each of the four MTCLK inputs.
Create synapse arrays for each Count respectively; e.g. Count 0 will
have Synapses for MTCLKA and MTCLKB, but Count 1 will probably need
Synapses for all four Signals (the action mode for two of them will be
COUNTER_SYNAPSE_ACTION_NONE depending on the configuration set).

What is the configuration when 32-bit phase counting mode is selected?
Does MTCLKA and MTCLKB serve as the counting signals in this case, with
overflows on the MTU1 register incrementing the MTU2 register?

William Breathitt Gray

--+5J+JJlLnn4OQztr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzh8UAAKCRC1SFbKvhIj
K384AQCg+5i2BlAc5aBMMoVp8hL28Jm/7uJBvvfEONCCbqWzVwEA6IxGEGQNXreD
TEIlRDmRIAlLZ2Z8YxGRpwloSCrHxQI=
=0pjL
-----END PGP SIGNATURE-----

--+5J+JJlLnn4OQztr--
