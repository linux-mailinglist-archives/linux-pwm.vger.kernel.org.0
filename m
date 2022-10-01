Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343855F1E14
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJARFv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJARFu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 13:05:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8D49B4F
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 10:05:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c11so4380769qtw.8
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CVbzKbVXK9VXJ2ckw3mC4Ga5iU0ioYvXj4FII461hSE=;
        b=PQ+CdhYUNhGbN9yay9mqxOdw4HShV3faVqfljyjsieiuYCoS3/OqjJElHcJ3xba7Ew
         AzznLxoslB5kD5/KDBRKnFXU3k+grMyl6X+W9NLinoNthcczTcHWXULuWLesemZ9ibnv
         jHmLBLVStjnHNW5kK0XamdZNZTStx/6zh6UwUYcy9GnMUGCKgdwF+OedmsKpLOiv8x4W
         EOvyv3rpbLYPbAzcqmg4lIgf24VzdLHrCvrq9geFEKu1/JfQzVQEFkUcoXThuM3kLU1E
         B7lUZ7BMrb0IzETqkoUtDM4SyDNZw4BRHyKeD3jWWlKzZkBHzqbJ1eevSG/Cbme0EOX1
         pG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CVbzKbVXK9VXJ2ckw3mC4Ga5iU0ioYvXj4FII461hSE=;
        b=UdrlLQ9g6aDreTKodWLtYWOENQTpnnsIt9CPx1Lj2PbyAWo8vzz4GZoJZwwpe+du0g
         FArhbkjUIRwjWDTWqlpCfh+8D+LtKZ2PHG2YtR6NwJ/0dfozF/ESGODkXFRYTbA8d/4J
         ZwRk1s7MBGkIi5R859YKjU3VnxOYrm65bCoRs4QGszgexzeC1KZo7jpBABtrAFuqNFBu
         PWgKxIH9/ya8r9APMZ61dumtcPVtox2in27O7gPks+r0zgQbtkuHDBKZaT4xIw6NITpc
         O6nuDVsZcp9latoGFl+twFedaO4pJpbJ4SivbX9qV/cSDrVk4vY3ZvtmSmMjzc9p0c4G
         SPzg==
X-Gm-Message-State: ACrzQf026ngWkuF3ILmbdrkrU8W/AA4ELJ2sJx1oJ6CsJgGOVYKDIV/f
        umcXr3+zlLvvnyGnUPtxdJ6KKA==
X-Google-Smtp-Source: AMsMyM5tUDshO757Gcb55niVouYpSz68d8uhzhm2Fns9MzSqsupMrlmP/pKW4wvLo94q6SLZQpPr5w==
X-Received: by 2002:a05:622a:50a:b0:35d:5d18:c2a2 with SMTP id l10-20020a05622a050a00b0035d5d18c2a2mr11182480qtx.515.1664643944972;
        Sat, 01 Oct 2022 10:05:44 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j129-20020a375587000000b006b953a7929csm5887841qkb.73.2022.10.01.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:05:44 -0700 (PDT)
Date:   Sat, 1 Oct 2022 13:05:42 -0400
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
Message-ID: <YzhzZiZYEKuVX3eZ@fedora>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nLXdA+NArWKb+szU"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nLXdA+NArWKb+szU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 04:45:55PM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
> >=20
> > On Wed, Sep 28, 2022 at 06:14:57AM +0000, Biju Das wrote:
> > > Hi William Breathitt Gray,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter
> > driver
> > > >
> > > > On Mon, Sep 26, 2022 at 02:21:06PM +0100, Biju Das wrote:
> > > > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded
> > > > > in the Renesas RZ/G2L family SoC's. It consists of eight 16-bit
> > > > > timer channels and one 32-bit timer channel. It supports the
> > > > > following functions
> > > > >  - Counter
> > > > >  - Timer
> > > > >  - PWM
> > > > >
> > > > > This patch series aim to add MFD and counter driver for MTU3a.
> > > > > Subsequent patch seies will add TImer and PWM driver support
> > also
> > > > > enhancements to counter driver.
> > > >
> > > > Hello Biju,
> > > >
> > > > I see this device consists of several channels, but only one Count
> > > > is defined in the counter patch ("Channel 1 Count"). Do all
> > channels
> > > > support counting, or is it limited to just one channel?
> > >
> > > It is like this
> > > MTU1 channel :- 1 16-bit phase counter MTU2-Channel :- 1 16-bit
> > phase
> > > counter
> > > MTU1 + MTU2 channel combined:- 1 32-bit phase counter Other channels
> > > are not supporting phase counting.
> > >
> > > Each counter device will have 1 channel. Currently it supports 16-
> > bit
> > > phase counting.
> > >
> > > Please see my test program. Am I missing something here?
> > >
> > > My test program:-
> > >
> > > echo 1 > /sys/bus/counter/devices/counter0/count0/enable
> > > echo 50 > /sys/bus/counter/devices/counter0/count0/ceiling
> > > devmem2 0x10001391 b 0x00 # Enable phase clock selection A for MTU2.
> > > echo 1 > /sys/bus/counter/devices/counter1/count0/enable
> > > echo 50 > /sys/bus/counter/devices/counter1/count0/ceiling
> > >
> > > for i in {1..5};
> > > do cat /sys/bus/counter/devices/counter0/count0/count ; cat
> > > /sys/bus/counter/devices/counter0/count0/direction;
> > > cat /sys/bus/counter/devices/counter1/count0/count;
> > > cat /sys/bus/counter/devices/counter1/count0/direction;
> > > done
> > >
> > > Cheers,
> > > Biju
> >=20
> > I'm not familiar with this hardware, but it looks like MTU1 and MTU2
> > are on the same device. I think a more natural way to expose this
> > functionality in the Counter subsystem would be to define a Count for
> > each count value you can support; so something like this (all under
> > /sys/bus/counter/devices/counter0):
> >=20
> > * count0 :- MTU1
> > * count1 :- MTU2
> > * count3 :- MTU1 + MTU2
>=20
> OK, sounds good. so count3 :- 32 bit phase counting
> count 0 or count1 or both then 16 bit phase counting

That "count3" should be "count2" (sorry for the typo), but yes all three
Counts should be defined; if a particular Count can't be read/written
due to the current phase counting mode selected, you can return -EBUSY
or -EINVAL as appropriate.

To clarify one more time, do you have two 16-bit registers holding count
values (one for MTU1 and one for MTU2), and when configured for 32-bit
phase counting mode you combine both registers to give you a 32-bit
count value?

> >=20
> > You can then control the phase selection using a top-level Counter
> > device extension (e.g. /sys/bus/counter/devices/counter0/phase) that
> > configures whether you're in 16-bit phase or 32-phase counting mode.
>=20
> So I need to introduce a new sysfs called phase. Use that one for
> Selecting the external clock pin for phase counting mode.
> Please correct me if I am wrong??
>=20
> Hardware supports 4 pins for phase counting mode,
>=20
> MTCLKA Input External clock A input pin (MTU1/MTU2 phase counting mode A =
phase input)
> MTCLKB Input External clock B input pin (MTU1/MTU2 phase counting mode B =
phase input)
> MTCLKC Input External clock C input pin (MTU2 phase counting mode A phase=
 input)
> MTCLKD Input External clock D input pin (MTU2 phase counting mode B phase=
 input)
>=20
> For MTU1, it is fixed MTCLKA and MTCLKB.
> But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - { MTCLKC , MTCL=
KD}
> On reset it is set to { MTCLKC , MTCLKD}.
>=20
> Cheers,
> Biju

It doesn't need to be named "phase" specifically, but it seems like a
new sysfs file will be necessary in order to select the proper phase
counting mode.

Are these MTCLK signals the quadrature A and B Signals you defined in
the counter driver?

William Breathitt Gray

--nLXdA+NArWKb+szU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzhzZgAKCRC1SFbKvhIj
K/fVAP9AS/yjO5jckmr/UhVVqoJzJtxdfIOcRNIeXNs1T24AEAEA3B+4DPxh06qF
zkp8kb6z7WbrMzb8dx/Fdq5r9F3NWws=
=u2zu
-----END PGP SIGNATURE-----

--nLXdA+NArWKb+szU--
