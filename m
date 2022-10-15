Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE465FFA87
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Oct 2022 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOO3A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Oct 2022 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOO26 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Oct 2022 10:28:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB584BD32
        for <linux-pwm@vger.kernel.org>; Sat, 15 Oct 2022 07:28:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so3432298otu.7
        for <linux-pwm@vger.kernel.org>; Sat, 15 Oct 2022 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qcdc/RkU0O0HbC0puyR2nnMuiyvRGRAFhnef/JK/qI=;
        b=FSiaN47kDaF7oQH2XxDO3ksX+whBp1B+3AXnhFdsO/P/XKeNZ1eFr2Dcki+0mcYosb
         6jR2xhwmQ+Goi5deUMyJDq9GZHk562L7EyHJTjqvaS2j1jz+NWEPJNck3cHAT8XJehks
         +b54IQNQOjZJUBtI4Zguax5rVk6JX4HZ1Ijkc0LzjmmyZPJihBGT6n02nSE5VZNrwBFA
         d6+TxzVh4siIN3CLvMRQlK78RS96WGUgsgu/T4BLYqqbk1t6ENaDnghbe876kzD6DafA
         Pl3C/Sw9s4ArZI61om5XAPNbr2OGZ00KPNNLVl5TBWOiEd2Bp86uInIJE0vnyxQqE7FT
         pmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qcdc/RkU0O0HbC0puyR2nnMuiyvRGRAFhnef/JK/qI=;
        b=dxa3os+vNbmZnbsKpb8gjWtPsaprTrUK+lr4rQGnbT1HAM1VpJhHDVmTMqcjCn0cGX
         e6qYrW8bJ8Uct1cx00EtqeKx6W2MmoCxa8oq9uI6dMTpEKqtUzabOW/7zGTAtbZz6tJZ
         dTYUB3+UMHT0cmAv457GjGBKseGruUaJ8/VBdX/29uSyIZ4AVuZlNRO7MhDPxAYllgcP
         3mONv/xnUdZhlMx3RXRTnWZ/R6puu69WgqXLaoK20jTM9XGH5acfcmSV5gvyXkZtis99
         ovXv6iX8jJAEphg3ACX5I+cEQUY79YXrbGdzPdq6XnJM4+/FLgupZ+V3bRE2VIq0i4M9
         +frw==
X-Gm-Message-State: ACrzQf1wVhsrzzT1jzjb37zGfDgU3ECf0mcJUBXrgcZucCEomgxrQC/g
        Dp3a1xDB8QNEIYbtmq4R80jrpCQ3bt2u/Q==
X-Google-Smtp-Source: AMsMyM7irA69CMmCVPDognpb7cdJLnYmXyUjx9zZmnhPAKaagiQHpVW0aWOZSt2YvYsg73hWhiewqA==
X-Received: by 2002:a05:6830:1552:b0:661:8b22:84b6 with SMTP id l18-20020a056830155200b006618b2284b6mr1386038otp.12.1665844136951;
        Sat, 15 Oct 2022 07:28:56 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j31-20020a056870051f00b0012c21a64a76sm2686518oao.24.2022.10.15.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 07:28:56 -0700 (PDT)
Date:   Sat, 15 Oct 2022 10:28:53 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Message-ID: <Y0rDpaGosqox77SQ@fedora>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
 <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
 <OS0PR01MB5922152268684B5564AA170D86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OGnd6CUR9MeZqDcJ"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922152268684B5564AA170D86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--OGnd6CUR9MeZqDcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2022 at 08:31:48PM +0000, Biju Das wrote:
> > Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > bindings
> >=20
> > On 11/10/2022 15:23, Biju Das wrote:
> > >> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > >> bindings
> > >>
> > >> On 11/10/2022 10:55, Biju Das wrote:
> > >>>
> > >>>>>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
> > >>>> ++++++++++++++++++
> > >>>>>  1 file changed, 305 insertions(+)  create mode 100644
> > >>>>> Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > >>>>
> > >>>> This should not be in MFD. Just because some device has few
> > >> features,
> > >>>> does not mean it should go to MFD... Choose either timer or pwm.
> > >>>
> > >>> MFD is for multifunction device. This IP supports multiple
> > functions
> > >>> like timer, pwm, clock source/events. That is the reason I have
> > >> added
> > >>> here. MFD is core which provides register access for client
> > devices.
> > >>>
> > >>> For me moving it to pwm or counter is not a big problem.
> > >>> Why do you think it cannot be MFD?
> > >>
> > >>
> > >> Because it makes MFD a dump for everything where author did not
> > want
> > >> to think about real device aspects, but instead represented driver
> > >> design (MFD driver).
> > >
> > > Core driver is MFD, just provides resources to child devices and is
> > > not aware of any real device aspects.
> > >
> > >>
> > >> MFDs are pretty often combining unrelated features, e.g. PMICs
> > which
> > >> have wakeup and system power control, regulator, 32 kHz clocks, RTC
> > >> and some USB connector.
> > >
> > > Here also same right? pwm, counter and clock are 3 unrelated
> > features.
> > > That is the reason we have separate subsystems for these features.
> >=20
> > These are quite similar features of a similar piece of hardware.
> > Sometimes called timer.
> >=20
> > >
> > >>
> > >> Just because you will have clocksource driver, PWM driver and timer
> > >> driver does not make it a MFD.
> > >
> > > MFD is multi function device.
> >=20
> > No. MFD is a Linux subsystem name. Not a device type. The bindings are
> > located in respective type.
> >=20
> > > So are are you agreeing Clock source, PWM and timer are different
> > > functionalities or not? If not, why do we have 3 subsystems, if it
> > is
> > > same?
> >=20
> > Linux subsystems? We can have millions of them and it is not related
> > to bindings.
>=20
> OK.
>=20
> >=20
> >=20
> > > Where do keep these bindings as there is only single "rz_mtu"
> > bindings for these 3 different functionalities?
> >=20
> > Again, focus on hardware not on Linux drivers. Hardware is called MTU
> > - Multi-Function TIMER Unit. Timer.
>=20
> OK
> >=20
> > > pwm or counter or mfd?
> >=20
> > Not MFD. I already proposed where to put it. Other Timer/PWM/Counter
> > units are also in timer.
> >=20
>=20
> I guess for counter/pwm maintainers, it is ok to model MTU3 as a single=
=20
> binding "rz-mtu3" in timer that binds against counter and pwm=20
> functionalities as well??
>=20
> Cheers,
> Biju

I'm okay with putting the MTU3 binding under timer; we already have
Documentation/devicetree/bindings/timer/renesas,mtu2.yaml there so
adding a new renesas,mtu3.yaml next to it seems reasonable.

Just to reiterate Krzysztof's point, the subsystems in Linux serve as a
way to group drivers together that utilize the same ABIs, whereas the
devicetree is a structure for organizing physical hardware. The
structure of physical hardware types don't necessarily match the
organization of the ABIs we use to support them. This is why you may end
up with differing heirarchies between the devicetree and driver
subsystems.

To illustrate the point, take for example a hypothetical
digital-to-analog (DAC) device with a few GPIO lines. Those GPIO
input signals could be tied to buttons used to indicate to the system
that a user wants to reset or adjust the DAC output, while the GPIO
output signals could be status lights or triggers indicating that the
DAC is operating. The respective driver for this device may utilize the
IIO subsystem to support the DAC and the GPIO subsystem to support those
GPIO lines, but it would be incorrect to put this under MFD because the
purpose of the GPIO lines is to assist in the operation of the DAC; in
other words, this is primarily a DAC device with some auxiliary
convenience functionalities, not a MFD with distinct unrelated separate
components.

William Breathitt Gray

--OGnd6CUR9MeZqDcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0rDpQAKCRC1SFbKvhIj
K6mqAQDuzOKTBtslnggYS7G5BypPDLq+0QzPSh11RvBzX/twyAEAr8JLtpMgRKbQ
mualkhgXervhhLg/l1tagAvfPDBw6wM=
=dWxm
-----END PGP SIGNATURE-----

--OGnd6CUR9MeZqDcJ--
