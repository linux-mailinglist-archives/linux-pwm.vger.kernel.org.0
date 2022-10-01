Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816CE5F1ED3
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJATEQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 15:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJATEP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 15:04:15 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5D356CC
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 12:04:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so4388571oop.9
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DuWijJO0JuzrvbYPtdZH/yrljaNM1lXbpE9PJdFTtiA=;
        b=scUzrknZCaxfubfuK018NlAlE3z2G+dCD/5y1EE7RedKz1c9RQ+Til/I6zXSXfAqeg
         8muGrzgjR2saWIjzh54pua8S1Kc0eQxtSqmIMSIznP81k5FT0zMBcIFa6M5fEYcPQYeC
         J2kyS7uLgiFYHIpHCfwK75sb/n6oX/f45Z+0FfN75pYsticIjXTbtNg7auwcqGWCDo9k
         1Hz+oZK+PxXSYHrfcYR0ADGxD9ZXGKnAC4kpHSV7lPn3189DGZwbPQvRVhTWArlkjcqC
         lGU+FRdC6r/mN4fBlWuCWVUdF/jSTXuhpc2K/vmQ1YXYFuR+WOCNeFCH+iw76/yOhUrs
         Pt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DuWijJO0JuzrvbYPtdZH/yrljaNM1lXbpE9PJdFTtiA=;
        b=R49jQEqMnbmqxmpxOmu1U+rRY5N1Q4KLjOwtW2aRpF903m8imona+PBTXokmB2785Q
         WW7+W06zfauHIJl6jGIsbTf2avsvwmOr7KLbwCHwV4I0MMVMtT8qljcyqRrFCjVoj9zg
         h2VnT4/txfSIstz1Mt5MxxSQV+Noyf/HkqemF2JvpZvTJJPq+3ct6iEjEnj2oiATpiFT
         2dn1YfBiVkgj4txOnmpvSQiHGp72GPcjuKq8QqS//XGxA1gMn2PJ0uCKZbUd84GEx3ZY
         M2E4L1wsh3dNSJeuFtlRlnUbnVJiggOyBsIOD2ccGv5q9XWEXDWAO+MuMKWvP2lKhE1F
         8ofA==
X-Gm-Message-State: ACrzQf3ySg9UexisHm77rHlit6cy2YUvIW5QCj8w/luKpdnlUzvadj+8
        UsPe9CkSvLWIOoEWxdLHKH82Tw==
X-Google-Smtp-Source: AMsMyM56tKrIlA6EkjpLc12gtHRdZCE2r+SK1u3af7SmNOgvROZLFgdW9R9ldYtDj8FgxwD2NK2gZA==
X-Received: by 2002:a9d:4f07:0:b0:65c:257f:f1ee with SMTP id d7-20020a9d4f07000000b0065c257ff1eemr5535418otl.167.1664651053599;
        Sat, 01 Oct 2022 12:04:13 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r185-20020acadac2000000b0035173c2fddasm1336103oig.51.2022.10.01.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 12:04:13 -0700 (PDT)
Date:   Sat, 1 Oct 2022 15:04:10 -0400
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
Message-ID: <YziPKgPOx1/WUE5Z@fedora>
References: <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzh8ULruBgN1tf+L@fedora>
 <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YziIUV3tyPd0GrFf@fedora>
 <OS0PR01MB5922F041D9C6EB2EBB9F8C8C86599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DroVQK3V/OFL30Ej"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F041D9C6EB2EBB9F8C8C86599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--DroVQK3V/OFL30Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 06:51:48PM +0000, Biju Das wrote:
> > On Sat, Oct 01, 2022 at 06:03:37PM +0000, Biju Das wrote:
> > > > What is the configuration when 32-bit phase counting mode is
> > selected?
> > >
> > > LWA Bit (MTU1/MTU2 Combination Longword Access Control) needs to set
> > for 32-bit phase counting mode.
> > >
> > > b0 LWA 0 R/W MTU1/MTU2 Combination Longword Access Control
> > > 0: 16-bit access is enabled.
> > > 1: 32-bit access is enabled.
> > >
> > > > Does MTCLKA and MTCLKB serve as the counting signals in this case,
> > >
> > > For 16-bit and 32-bit counting signals same. We can set
> > >
> > > 1) MTU 1 and MTU2 signals as MTCLKA and MTCLKB
> > >
> > > Or
> > >
> > > 2) MTU 1 signal as MTCLKA and MTCLKB and MTU2 signals as MTCLKC and
> > > MTCLKD
> >=20
> > I'm having trouble understanding this case. If 32-bit access is
> > enabled by setting the LWA bit, and the MTU1 signals are configured as
> > MTCLKA and MTCLKB while at the same time the MTU2 signals are
> > configured as MTCLKC and MTCLKD, how is the 32-bit count value
> > determined -- wouldn't
> > MTU1 and MTU2 be counting independently if they each had separate
> > input clocks fed to them?
>=20
> It is taken care by the HW. We just configure the register as mentioned b=
elow
> and hardware provide counter values once feeding the signals to=20
> either
> {MTCLKA and MTCLKB} for both MTU1 and  MTU2=20
>=20
> or=20
>=20
> MTU1{MTCLKA and MTCLKB} and MTU2{MTCLKC and MTCLKD}
>=20
> The signal feeding is same for 16-bit and 32-bit phase modes.
>=20
> Note:- I haven't tested 32-bit mode yet.=20
>=20
> Cheers,
> Biju

I'm not quite grokking it yet, but I'll trust that you're right for now.
I suspect it'll make more sense to me once your next revision is
submitted and I've had time to evaluate the code more closely.

Thanks,

William Breathitt Gray

>=20
> >=20
> > >
> > >
> > > b1 PHCKSEL 1 R/W External Input Phase Clock Select Selects the
> > > external clock pin for phase counting mode.
> > > 0: MTCLKA and MTCLKB are selected for the external phase clock.
> > > 1: MTCLKC and MTCLKD are selected for the external phase clock
> > >
> > > > with overflows on the MTU1 register incrementing the MTU2
> > register?
> > >
> > > No. that won't happen as we need to use different register for Long
> > > word access
> > >
> > > These are the regiters used
> > > 16-bit:- TCNT{MTU1,MTU2}, TGRA{MTU1,MTU2},  and TGRB{MTU1,MTU2},
> > > 32-bit:- MTU1.TCNT_1_LW, MTU1.TGRA_1_LW and MTU1.TGRB_1_LW
> > >
> > > Counter in MTU1   MTU1.TCNT Word MTU1.TCNT_1_LW Longword
> > > Counter in MTU2   MTU2.TCNT Word
> > >
> > > General register A in MTU1 MTU1.TGRA Word MTU1.TGRA_1_LW Longword
> > > General register A in MTU2 MTU2.TGRA Word
> > >
> > > General register B in MTU1 MTU1.TGRB Word MTU1.TGRB_1_LW Longword
> > > General register B in MTU2 MTU2.TGRB Word
> > >
> > > Cheers,
> > > Biju

--DroVQK3V/OFL30Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYziPKgAKCRC1SFbKvhIj
K9GFAQCIBcdC2Bbyfuc26q9OuG3EqCblPlRsaeBItgi8YuulDAD+PIgKaHLii3LP
DnHvCEadS3bsWtKNqbVTpeVpXWDTlgM=
=QZVB
-----END PGP SIGNATURE-----

--DroVQK3V/OFL30Ej--
