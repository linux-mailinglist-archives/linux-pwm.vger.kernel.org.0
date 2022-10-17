Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8A6010A9
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Oct 2022 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJQOAj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Oct 2022 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJQOAh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Oct 2022 10:00:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9AF101CF;
        Mon, 17 Oct 2022 07:00:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so25064749ejb.13;
        Mon, 17 Oct 2022 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6Mxh+LUgjvM5Wy1z968oPB0TD46726WrRuhqmLLUF8=;
        b=cIB6/ZaMlhQLapkDhLKU88sKZVO8jSTXcbrwyM0v0J14Lyp9HI/NvT7Rg4R0iwiOw5
         Tr+goX1/+z3/6ZT89TN+wTQG30Anz6owonNBXvffGvwPcp0KC3igmjHt0vFIfiVEExYq
         OpyzcZ5/F76gd1iYG3D0VAs9Ext9SD81/T9/xgxccz2elVaIJyRS31RepA14jTGY6u4w
         JtFz+xvcOPmkOgWMi2XK7/H/MxAfFmlu2YaxFk17Uyrv1LsYWYMJZq2rq3DFuHkpcBr7
         3mGD+04tlPHdh2rX+INqGYQc0fJfc5/vMmujikmWC7xQSdr1PrJGnbza8355Nndrls9q
         x/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6Mxh+LUgjvM5Wy1z968oPB0TD46726WrRuhqmLLUF8=;
        b=e5X1YexuzuWAArWsl0VufqymJ6zUIfkwK2GVpn+vkXmi6U/fW+GkYIZDWZYofxmsJ7
         duKXkSW07duR8MEa+XF8iZYJd3dxVDqUt12d3F6eWN7XPIkOCjb9zXkgzDyCOvD78M+Z
         iawxQ6qBoWHDeW9XQImQQxuhDFMUlqZS4rnc2lKhXnCUgzDdpVX/QcvNm+QdhN2iKBJ+
         CrLvTdUafxtaC7ZDknDrOyIteWTehlrRdmNY6lxF/pAERnNrX78EYVXQgeWZK93nt8jQ
         Xz/fP1WQSEqtxrzKO9E1qd5oNqDVugMcRXbcLRLgY9Q4lulyQI6ky8A5UuvL5VQ0UtCj
         qFTw==
X-Gm-Message-State: ACrzQf39MrX+GjTsjvZc6AfvabCdL35+tqNl8xS/Hgh/kS5UyzsCFcug
        JatfcAeA5/E+svcZ+ZWomaI=
X-Google-Smtp-Source: AMsMyM7/2Qu+IN4+gZnrPRxaCKtT7vBBWfcsq/ollfS2FGqUS9hTmmS4SwjYJtUP+clglaCk3um8gg==
X-Received: by 2002:a17:907:3e0f:b0:791:9529:3674 with SMTP id hp15-20020a1709073e0f00b0079195293674mr2292715ejc.503.1666015234887;
        Mon, 17 Oct 2022 07:00:34 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s15-20020a05640217cf00b0045467008dd0sm7468590edy.35.2022.10.17.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:00:33 -0700 (PDT)
Date:   Mon, 17 Oct 2022 16:00:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Message-ID: <Y01f/5VtxgCDz+tx@orome>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
 <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
 <OS0PR01MB5922152268684B5564AA170D86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0rDpaGosqox77SQ@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nZ+UcSAkhSAEBb22"
Content-Disposition: inline
In-Reply-To: <Y0rDpaGosqox77SQ@fedora>
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


--nZ+UcSAkhSAEBb22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2022 at 10:28:53AM -0400, William Breathitt Gray wrote:
> On Tue, Oct 11, 2022 at 08:31:48PM +0000, Biju Das wrote:
> > > Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > > bindings
> > >=20
> > > On 11/10/2022 15:23, Biju Das wrote:
> > > >> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > > >> bindings
> > > >>
> > > >> On 11/10/2022 10:55, Biju Das wrote:
> > > >>>
> > > >>>>>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
> > > >>>> ++++++++++++++++++
> > > >>>>>  1 file changed, 305 insertions(+)  create mode 100644
> > > >>>>> Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > >>>>
> > > >>>> This should not be in MFD. Just because some device has few
> > > >> features,
> > > >>>> does not mean it should go to MFD... Choose either timer or pwm.
> > > >>>
> > > >>> MFD is for multifunction device. This IP supports multiple
> > > functions
> > > >>> like timer, pwm, clock source/events. That is the reason I have
> > > >> added
> > > >>> here. MFD is core which provides register access for client
> > > devices.
> > > >>>
> > > >>> For me moving it to pwm or counter is not a big problem.
> > > >>> Why do you think it cannot be MFD?
> > > >>
> > > >>
> > > >> Because it makes MFD a dump for everything where author did not
> > > want
> > > >> to think about real device aspects, but instead represented driver
> > > >> design (MFD driver).
> > > >
> > > > Core driver is MFD, just provides resources to child devices and is
> > > > not aware of any real device aspects.
> > > >
> > > >>
> > > >> MFDs are pretty often combining unrelated features, e.g. PMICs
> > > which
> > > >> have wakeup and system power control, regulator, 32 kHz clocks, RTC
> > > >> and some USB connector.
> > > >
> > > > Here also same right? pwm, counter and clock are 3 unrelated
> > > features.
> > > > That is the reason we have separate subsystems for these features.
> > >=20
> > > These are quite similar features of a similar piece of hardware.
> > > Sometimes called timer.
> > >=20
> > > >
> > > >>
> > > >> Just because you will have clocksource driver, PWM driver and timer
> > > >> driver does not make it a MFD.
> > > >
> > > > MFD is multi function device.
> > >=20
> > > No. MFD is a Linux subsystem name. Not a device type. The bindings are
> > > located in respective type.
> > >=20
> > > > So are are you agreeing Clock source, PWM and timer are different
> > > > functionalities or not? If not, why do we have 3 subsystems, if it
> > > is
> > > > same?
> > >=20
> > > Linux subsystems? We can have millions of them and it is not related
> > > to bindings.
> >=20
> > OK.
> >=20
> > >=20
> > >=20
> > > > Where do keep these bindings as there is only single "rz_mtu"
> > > bindings for these 3 different functionalities?
> > >=20
> > > Again, focus on hardware not on Linux drivers. Hardware is called MTU
> > > - Multi-Function TIMER Unit. Timer.
> >=20
> > OK
> > >=20
> > > > pwm or counter or mfd?
> > >=20
> > > Not MFD. I already proposed where to put it. Other Timer/PWM/Counter
> > > units are also in timer.
> > >=20
> >=20
> > I guess for counter/pwm maintainers, it is ok to model MTU3 as a single=
=20
> > binding "rz-mtu3" in timer that binds against counter and pwm=20
> > functionalities as well??
> >=20
> > Cheers,
> > Biju
>=20
> I'm okay with putting the MTU3 binding under timer; we already have
> Documentation/devicetree/bindings/timer/renesas,mtu2.yaml there so
> adding a new renesas,mtu3.yaml next to it seems reasonable.
>=20
> Just to reiterate Krzysztof's point, the subsystems in Linux serve as a
> way to group drivers together that utilize the same ABIs, whereas the
> devicetree is a structure for organizing physical hardware. The
> structure of physical hardware types don't necessarily match the
> organization of the ABIs we use to support them. This is why you may end
> up with differing heirarchies between the devicetree and driver
> subsystems.
>=20
> To illustrate the point, take for example a hypothetical
> digital-to-analog (DAC) device with a few GPIO lines. Those GPIO
> input signals could be tied to buttons used to indicate to the system
> that a user wants to reset or adjust the DAC output, while the GPIO
> output signals could be status lights or triggers indicating that the
> DAC is operating. The respective driver for this device may utilize the
> IIO subsystem to support the DAC and the GPIO subsystem to support those
> GPIO lines, but it would be incorrect to put this under MFD because the
> purpose of the GPIO lines is to assist in the operation of the DAC; in
> other words, this is primarily a DAC device with some auxiliary
> convenience functionalities, not a MFD with distinct unrelated separate
> components.

Exactly. In addition to the DT aspect, another misconception is that a
driver for a multi-function device needs to be somehow split up to match
the Linux subsystem structure. In most cases that's not true. Pick the
subsystem that most closely fits the main function of a device and
implement the driver. If you can expose further functions using other
subsystems, that's absolutely fine. Drivers can register with multiple
subsystems at the same time.

Yes, that's not quite as neat as having individual drivers for each
subsystem, but it's a much better approximation of the hardware and
therefore will lead to more compact and stable drivers. Trying to split
things up arbitrarily often makes for wonky constructs.

We've gained powerful tools over the years to easily deal with cross-
subsystem drivers, so there's seldom a reason to strictly split things
across subsystem boundaries anymore.

Thierry

--nZ+UcSAkhSAEBb22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNNX/0ACgkQ3SOs138+
s6Fd7w/7Bk/7GH1pccb3LSpYVwJqBPu6guiw4I1yjG2aNVsX3MBfwjXXg0LBJkRV
0YctZRdJTPgZcaXrTs5Kx8GovuxokrxgM9M9jqktB7tSmlQSVUEJC19uk01X5hwc
f+VtHHugkqde1PbC2aMSX4OBX0C7MeRHijIGK8oi2e9auN+LQm+w2lh5vKJtP/6C
MEDJtOOCo+eEZWKPx5wOwwV/8WLEmyBolMYQunCrwVE8VyXnerGzf0Pc9BBsEEFS
vaO8ad+VaUFnSMsMDTPOzW6oPsPmQafD8Jih3diuP1aZgcEE1iwfzBYTHAkX4kuw
us38EbVXOMNx6pVi9MzUTon/XuKdPHsXT4byq4nHXVqE0yv1O9H6zrGIQTocBKvK
8WJaHynZUW+fmL5Yi3wnBY72EY3+bFQxtpGNCBb5EWdO45e871pXnAebOCpsgw3Y
rIu74lOmAUeHuSvZZC8njsW8aFgXlBNtSb9Ja0c+ng7XxmrVNWgRgJ4E9MUV8Kf7
nESRrVTHyhPbOyKjAe4nTZF3hxZV52Rq74icpPGA6Mv4mKZpY6q999WvVzUPxUT6
2wTZc4nQoKyDn233bD/FwQqA5fguE4lx1fZ2UOItvPyK5abQvVVw5d/980Wr71IP
Xk3Q7svtVW1zRBaJoltW+D8v62H8pXk6BZvfgPnz3YSVr+1y3xA=
=yeGv
-----END PGP SIGNATURE-----

--nZ+UcSAkhSAEBb22--
