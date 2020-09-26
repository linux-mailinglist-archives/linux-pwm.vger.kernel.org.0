Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58022796FE
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 06:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgIZEvQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Sep 2020 00:51:16 -0400
Received: from mail-bn8nam08on2082.outbound.protection.outlook.com ([40.107.100.82]:39648
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbgIZEvP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 26 Sep 2020 00:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssk9CjTjntKF2mx15PX1Y2z002r2+bcfmmRegNCEqcFnMtOXMFQZ9g6P2r45jVgit+xCC/Bum5ePkxFicjeYb6pes8JXEf5m2L6coGc/bIfrSVDGKShnpG68Y5egbgBsPEIE6GDfEV/Xz1mrN1s2pB/m8V4zkUF7aISzvkjP9/Bp/HjTvpvK58gL8nsqb7yQp2DlKlpRwbiu6q1u+gOo6p/gxCLKS6hTQZT3U37yUnkWgmCCa/XEg3YMHvHMxdyWWXBfHCae6lh87Tezz+Bm1ozgjPlO8tmp0Tuw2773N8OR2azNE8P19H5sU7p0AwDMNXG27GjJkzlnTIGY+uOKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/tAcgnSqSHtVwCgWm6wNOruR9r7HfGLL9aZ+CqMCB8=;
 b=jM7xb5IN5NZ9lnUH11B+i0+io2ii4y7udjzY2pDSBcOv3xs7GJ9DkvQ2uDyd2D+5hfcwWpakLX+cduw258ZP0iY/vCZgmh38uuupwaOZ7Xg7BAfEEhYEccGThHT8mjtcw6UdEgcxS7SZAJ9WUfYN42ckadMSkJ0CoLVhs+2zHE/ZXrqNSI/Hz0RxCzMUtEvkh2m1x22Dpn5zgXquonnLhXzNnD8pe5sIMOpl79JV9nyQGSNN2C7IE4572dSBRVQCIh0Yo87Y52QgyTq+UzVRFl6DqG+JB9nGuauPIumOctdS4iST6mUDZ5p5EjM2GnIhHqHrQgdrcwIl2vNy0FiTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/tAcgnSqSHtVwCgWm6wNOruR9r7HfGLL9aZ+CqMCB8=;
 b=II/1ZLrSuRL81AjtbdDDtZk/EqrfMtthZxV1ik1Lw963CJWV0zBhsVJbTk81RhRwQlk0k6ZvE4W93OKlx/wvdiA5kFYnTMsINYpK8ZjdeEc6AwxO8rcecJHOZMnqG5OQoMm/Q4apRmkCcUSenuON570uJzc7U9voYN9WFFVtDGc=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4284.namprd13.prod.outlook.com (2603:10b6:5:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.13; Sat, 26 Sep
 2020 04:51:10 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.013; Sat, 26 Sep 2020
 04:51:10 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Subject: RE: [PATCH v1 3/3] dt-bindings: riscv: convert pwm bindings to
 json-schema
Thread-Topic: [PATCH v1 3/3] dt-bindings: riscv: convert pwm bindings to
 json-schema
Thread-Index: AQHWh19mPLif9BYIJ02zgijqLyV6M6l1MZAAgARda5A=
Date:   Sat, 26 Sep 2020 04:51:09 +0000
Message-ID: <DM6PR13MB3451F3BECC0B04765B68ED4997370@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-4-git-send-email-sagar.kadam@sifive.com>
 <20200922203714.GA3195489@bogus>
In-Reply-To: <20200922203714.GA3195489@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.145.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14f411b0-0615-4a49-67f0-08d861d7c9a2
x-ms-traffictypediagnostic: DM6PR13MB4284:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR13MB42844FD5FC1B37CE7F251AC997370@DM6PR13MB4284.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sq93CtvmUjIBJqdA7p2x6L/kY9rfJVZFoKnFyHoo4R2yr1QIanrXnT26k4DfxkuXzsr+rnTdDUL35HfH11Fqd8qTIEwKXojB6FaZUcDjVblOLARZpfyQZ5IX72lyi/g0alKD3zDkxa5LwjkCvpD6O5XTSclPjJnBOOI+UgYLjCG4tDXdLDwMI8c7G3lEUkCBlxUuv0O8lQGEr+WqMcKeTru39v1hxXxQtVmTrzCMKyyTtVDtfoK/vkhpyeFct4kdmP5yDYm9Ok9XRQiCEOityix7I08sZwSSZCbR9u9YwoiACShQwOkRVZjmaIp3xohzMyXcqPn+EiVqeGalCXx9ip490trXz+QbirYyy2qTBMuSNMBGFmm+uGsmTZJ6dZvn9NsqTSJrRfaPL2AGiZTCkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39840400004)(376002)(346002)(136003)(4326008)(186003)(44832011)(26005)(7416002)(86362001)(7696005)(8936002)(966005)(83080400001)(6506007)(53546011)(83380400001)(55236004)(107886003)(8676002)(33656002)(478600001)(66556008)(66446008)(66476007)(64756008)(52536014)(5660300002)(54906003)(316002)(55016002)(9686003)(2906002)(71200400001)(66946007)(76116006)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZmSQuDScKBGe7S1DnxTqWxhLc6xhnunAUOfILYaqPQML1GXnQ283zYDWySwGAZPN0Q3Fyea8+WJ6M+MzbTix1BSA+9VCsggcM+7y91mmVFSTY63BgyWVdgdGu8TbggCVyfmpQfZjY8jU8P/NYz68C8qR70EpXP10rs/rqKh0985LMSovwxouWCLuiBxefDVq5010H9emA0hQddBdiOCXBbu2zz0DmoSPXqVcXGIAIrYdfYOeK4tJXztWCSe6iUHLpNj/x7f9/O5mE7YJeFDMjlbuZ/gZ1lh0FWBTm0x88O7ssNuZF7FQabUpYDNQ0NuhszVZ0HvJys7aapShKG0iv1yQmoE4itwhdnqw+tfhcPP4BnL5Nf91cJ6v64lnoLAtWRTpvwqr1yWxN3hO3VE0/PVLL/VYMVAPk90BMQS4R5q1E3z9Q+FeAKId9Upho3NDvkL2VwmTIDxQ3qHRvVdXWgNDCgkXA6byA5+SeP5vJP30F7f3KT50/sL+2By44/heweqdNsfhheItwosV58QJbkVpN0nLTIRbknJDx4ts6mL6/FoESoBo3MkYsE7hFqnVOc+TDFwdXVivsO3WL+T+0jziQaFYw5j4wzJgGgE1X1grQ6OKOsalwT/hIRKoYrYelE1OoxKHyVABMgbXyxzQRw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f411b0-0615-4a49-67f0-08d861d7c9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 04:51:09.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOuvvn3k2XQ2289LA1xbG8ANrZ5vRnAb2xjKcZag5zZH/5nLQYp1f80zEXC1YXRPjxvW6M/Y1MrlmX8HT+EkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4284
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, September 23, 2020 2:07 AM
> To: Sagar Kadam <sagar.kadam@openfive.com>
> Cc: linux-pwm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; mturquette@baylibre.com; sboyd@kernel.org; Paul
> Walmsley ( Sifive) <paul.walmsley@sifive.com>; palmer@dabbelt.com;
> tglx@linutronix.de; jason@lakedaemon.net; maz@kernel.org;
> thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de;
> lee.jones@linaro.org; aou@eecs.berkeley.edu; Yash Shah
> <yash.shah@openfive.com>
> Subject: Re: [PATCH v1 3/3] dt-bindings: riscv: convert pwm bindings to j=
son-
> schema
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Thu, Sep 10, 2020 at 04:14:04PM +0530, Sagar Kadam wrote:
> > Convert device tree bindings for SiFive's PWM controller to YAML
> > format.
> >
> > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ----------
> >  .../devicetree/bindings/pwm/pwm-sifive.yaml        | 72
> ++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 33 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > deleted file mode 100644
> > index 3d1dd7b0..0000000
> > --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -SiFive PWM controller
> > -
> > -Unlike most other PWM controllers, the SiFive PWM controller
> > currently only -supports one period for all channels in the PWM. All
> > PWMs need to run at -the same period. The period also has significant
> > restrictions on the values -it can achieve, which the driver rounds to =
the
> nearest achievable period.
> > -PWM RTL that corresponds to the IP block version numbers can be found
> > -here:
> > -
> > -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/de
> > vices/pwm
> > -
> > -Required properties:
> > -- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
> > -  Supported compatible strings are: "sifive,fu540-c000-pwm" for the
> > SiFive
> > -  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0"
> > for the
> > -  SiFive PWM v0 IP block with no chip integration tweaks.
> > -  Please refer to sifive-blocks-ip-versioning.txt for details.
> > -- reg: physical base address and length of the controller's registers
> > -- clocks: Should contain a clock identifier for the PWM's parent clock=
.
> > -- #pwm-cells: Should be 3. See pwm.yaml in this directory
> > -  for a description of the cell format.
> > -- interrupts: one interrupt per PWM channel
> > -
> > -Examples:
> > -
> > -pwm:  pwm@10020000 {
> > -     compatible =3D "sifive,fu540-c000-pwm", "sifive,pwm0";
> > -     reg =3D <0x0 0x10020000 0x0 0x1000>;
> > -     clocks =3D <&tlclk>;
> > -     interrupt-parent =3D <&plic>;
> > -     interrupts =3D <42 43 44 45>;
> > -     #pwm-cells =3D <3>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> > b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> > new file mode 100644
> > index 0000000..415d053
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
> > +(C) 2020 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-sifive.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive PWM controller
> > +
> > +maintainers:
> > +  - Yash Shah <yash.shah@sifive.com>
> > +  - Sagar Kadam <sagar.kadam@sifive.com>
> > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > +
> > +description:
> > +  Unlike most other PWM controllers, the SiFive PWM controller
> > +currently
> > +  only supports one period for all channels in the PWM. All PWMs need
> > +to
> > +  run at the same period. The period also has significant
> > +restrictions on
> > +  the values it can achieve, which the driver rounds to the nearest
> > +  achievable period. PWM RTL that corresponds to the IP block version
> > +  numbers can be found here -
> > +
> > +
> > + https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/d
> > + evices/pwm
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,fu540-c000-pwm
> > +      - const: sifive,pwm0
> > +    description:
> > +      Should be "sifive,<chip>-pwm" and "sifive,pwm<version>". Support=
ed
> > +      compatible strings are "sifive,fu540-c000-pwm" for the SiFive PW=
M v0
> > +      as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for =
the
> > +      SiFive PWM v0 IP block with no chip integration tweaks.
> > +      Please refer to sifive-blocks-ip-versioning.txt for details.
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Physical base address and length of the controller's
> > + registers
>=20
> Drop description.
Okay.
>=20
> > +
> > +  clocks:
> > +    description: Should contain a clock identifier for the PWM's paren=
t
> clock.
>=20
> How many clocks?
>=20
PWM IP block instance is clocked with single clock (tlclk).
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +    description:
> > +      Should be 3. See pwm.yaml in this directory for a description of=
 the
> > +      cell format.
>=20
> Drop.
Okay, I will drop this description.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
>=20
> Is it 1 or...
>=20
> > +    description: One interrupt per PWM channel.
>=20
> one per channel?
>=20
Each PWM instance in FU540-C000 has 4 independent comparator's=20
each capable of generating interrupts.  So maxItems need to be 4 and I can=
=20
include it in description something like:
 " description:=20
        Each PWM instance in FU540-C000 has 4 comparators. One interrupt pe=
r comparator"=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - "#pwm-cells"
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm:  pwm@10020000 {
> > +      compatible =3D "sifive,fu540-c000-pwm", "sifive,pwm0";
> > +      reg =3D <0x10020000 0x1000>;
> > +      clocks =3D <&tlclk>;
> > +      interrupt-parent =3D <&plic>;
> > +      interrupts =3D <42 43 44 45>;
>=20
> Split entries:
>=20
> interrupts =3D <42>, <43>, <44>, <45>;
>=20
Yes, I will split entries as suggested.

Thanks & BR,
Sagar
> > +      #pwm-cells =3D <3>;
> > +    };
> > --
> > 2.7.4
> >
