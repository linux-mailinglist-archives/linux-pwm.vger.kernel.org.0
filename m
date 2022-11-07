Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300B76200D0
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 22:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiKGVQG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 16:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiKGVPb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 16:15:31 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857E64DB;
        Mon,  7 Nov 2022 13:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKKSMOwRaIMcDU+S9W2lGnKEdcpC2S/2WOtl3ze/Egonlk8QcZZpcg7cW18xZK1Y00ymdcguJ8gP8VI/WZffanBEO04EPu3OYoGN3ksBWWRoORPUGfMAl3MHCFrK1dYQYewT5ECfGoNx7UkQf2gJk1u3Na4fwc8hO/HVYuOj2wZ1WEYfoOSMtmyTDq1ziL3uxi4fmyWv1Hqv6nF2eMZJbaYPQXU8OtRy4aXOJ1DEh7Wt6mIVhN4qg/q/vGgJPrasQYNi1RGJW+iPoXzelO4S9q1JL+F3ZH4GUmxEyIxahhw++X2XUY/2++KNQgLNq84OuCWfZW8gPbsFPcjrZPFkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/Bsp7euf5T+2MVYvnpca9oayMsU8FnI4D0kJypII00=;
 b=W3X6V+A7BlKtnHBJ66TNXLEv8Tkpjlskmczo32bgybQrbl4XUnX+ggDCKUPdzwvvi+4PyRwigr0r5Newp7+PSs9/bFmnMje/sqWRzc2GP4TWnGLy4kwp2KFGb74Jq0mA0wSk+rmOhitX4SQV35tc723vqwGpkudat975r/20YwneFUJD8x82BCbKmsyQXJfLW6xJGuOUJB06E/nbj0idm7FKYnNM8XDRt+oayyBpLwvFQ9J9dtW2DRWFLWBlZyU54jbvYV+v56LIkPk3yh2IYUU4Bsb10w5Fyt9zon+qJ8VRygs0YklBfVcXTS8FNxf58MpjlreWVaz3WEWsIbiF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Bsp7euf5T+2MVYvnpca9oayMsU8FnI4D0kJypII00=;
 b=c12B/ur9Fvl3XRBsNia8ibBvVlQkrCxA754qX9fg5xvlqyc1s5Q4Xy51gPVMY/erhcNsBJRYm94f4+EaxK2Gt/C2qgRMygTpbc85LICRKG/qAegGVidbtuU/MTKEkIERdCZr1/cBLkfM4mFxYBXq1IlC+Xq/PBegUgCZqXYlhus=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9809.jpnprd01.prod.outlook.com (2603:1096:400:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 21:12:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 21:12:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG
 binding
Thread-Topic: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG
 binding
Thread-Index: AQHY8GDgOqjpImU8mEOSDENTsbjw7a4z9f0AgAADVoA=
Date:   Mon, 7 Nov 2022 21:12:02 +0000
Message-ID: <OS0PR01MB59226061A80D8A8742FD7DA7863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
 <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
 <20221107205614.GA1610785-robh@kernel.org>
In-Reply-To: <20221107205614.GA1610785-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9809:EE_
x-ms-office365-filtering-correlation-id: 212cc024-731f-4131-7d88-08dac104b78e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbcjS8eC9rojj/MtiECKzUSBYw/OO1oBeEb1FxkLbcguNxBbzcnsauxDvMgtcoL5jalK9u0GSwa3KjR61h3+kGVP4o90EWkQjMDt2UXXcrRkJajgvbCRqgl/b5YMKnkQVJiFqBrzASTUY+RHz1nTn1xJVcIM5aUCOaWk8rAbhx48qVgeaPm2j3b2peC6v/uky5WFMEKGZ8iDRsIjvFnCdrDr48x/DgUOUBn3OX2nHTcNuI2S97T+oPYDk3v21wqBVkG+7PGR83RGJXQjuFVbbOoyEeTfZ48MJf3q2kU2fX9hchkoElWnMzlHSwY4XDSj3VArWIERWxG2xOO+bKRawJ6yGd4QM5IjPJxFH6az5QrfdSBuEFBS5uaX+6CIzoqUGRQks3ky785q+jSSHgZC5/OtcISddGc3/XcfcRwM8vvI/I5B+Rt2xwDV2TRe/uXGPNc2aEVu4t8LrUn/0W5EjV/e4OSQjWb+2biKCu+0DeT3P2uFOWrQMQDuqbLFbcOQVpj0jM9F7Y6zukXOFo//+lxO0PcbTP75bypqeh7RTACVSrlKu/JEEhFiDVNNFBSBS+3y+lkCqc664TsiNvzB3bPK3dDrLbTwcP+uObZN5oJ0F08WyEaC4/ftx1rPRGW3l3In13z2tFdWLtUKOAF9X+9N6c4Hpb9dmS4/MRbtFPLJhruYzuPRKYok4C9+yGgICRLlafdZi0QEXX06t7rOkkCdiyFVjmOxS7kW9MvYu+dxkkloeOBhM/T46xWtnb7RRUkVqEVuN8Wmj33LhoZHJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(186003)(38100700002)(122000001)(64756008)(83380400001)(52536014)(86362001)(41300700001)(5660300002)(2906002)(7416002)(4326008)(8936002)(8676002)(55016003)(33656002)(107886003)(9686003)(26005)(478600001)(316002)(54906003)(6916009)(71200400001)(7696005)(6506007)(38070700005)(66446008)(66476007)(76116006)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?314VEWD+K/QvgtVCOGQfy7EVhLtsG80iHv3n+P+m0drxEqNyxIGYGhRpMZ?=
 =?iso-8859-1?Q?XWovs2Vb77SOEbZKY3ORt7jG5xO8HiBoq6WftbhnwxBhh5gPB8h8rChbRU?=
 =?iso-8859-1?Q?3DswCxgYveUDuAUZW22iAOpFL3MNz7nKtWA5ucL4kgjQwlu+VJTPYmsAYn?=
 =?iso-8859-1?Q?5FFmKBbr34/AVvRcDuujgj7wt6hpeCiVHK8aagd1xtadKOBDc2eriIRXka?=
 =?iso-8859-1?Q?VlXvYd5tufRKrvBZFOCSxEdWbHbGooqHiRSdJr12dUrm1bxYZqD8AXgX8z?=
 =?iso-8859-1?Q?NkNBNsoEEfvNn7j2EStKXQ6uNMnNKvK4Z5A3UMm1VBjzloBMKtfGpO1X7r?=
 =?iso-8859-1?Q?XHkuVCRV73xhzZC3gphkq2qpxfOnTszKLCgcpPHjyIIhLECT7DKDUPuKzp?=
 =?iso-8859-1?Q?ffQgzGP0bbtn0r0rzyTD/9Um/YxOVL7soL+fPO+MKwI3X4YLQ07w8TYuJl?=
 =?iso-8859-1?Q?uyZOQ+q8uuwH/7Vo7Zb+iZa5gSHK+LQuNn4mPNP00WTLZ+UGapeO8pZJbl?=
 =?iso-8859-1?Q?Lp9rXoR1dd4r1QgXvnztmRLTkXFgW7VqTuBIaCEj8y7TfHxPGcLx85SOGQ?=
 =?iso-8859-1?Q?ZAPLJvkLsH6ZMmJS+/o+BoWjQeMZt+5g2COmWo8xsDCD3tjZXokereXkCT?=
 =?iso-8859-1?Q?H++3/r21K/m2Wmdssu0d0PhGViO5om4nbttOU24KQhJbF9zUq1ZbX9Fi0M?=
 =?iso-8859-1?Q?PraPVAwrHJ0yx0p1jdoKJqwWDVZlj9PVsj2VxPl3VMCz5VqdXxk9A1M3al?=
 =?iso-8859-1?Q?Wp+wAqcp//R0eM1vIlLBP06qvR+LuahmED9oQc6Wo8rD1MhdIXzLMWh5Zp?=
 =?iso-8859-1?Q?o+Dc5ulR42RfJ1oaYeuWXu+E+hag3G8ouulzg2oUfFau8PYz209wNBKta6?=
 =?iso-8859-1?Q?3blUtlg9k0J92WHig/IEmS1jY94IPZU2bmkJg1j1yUPHkWYjfY9OaUYepa?=
 =?iso-8859-1?Q?uKUjAuyKyNGkKp2xVLFoFltN7VAXqSjlfzGJonBVpkEEPauzekpOQ7/Gu2?=
 =?iso-8859-1?Q?7/NqS4s9abgzvdQkzbDBAr6mNXlkL7a9EERfF2qTpD9H38n/ke899dyGJK?=
 =?iso-8859-1?Q?zLMTaidzx8T6lN/qaNJD21xwVELEbqy/5JQ+4rMykr8zGrhlY+HxzPqGNc?=
 =?iso-8859-1?Q?qWhOA0hL8BFPW9hj2mkm+VaX3Rzq2lNkG9zYpEO0+uKcdncjmAsSUmYluu?=
 =?iso-8859-1?Q?TQSWSk2Hs/lb3mgcKqml3M+0x9Cbj0e6krXGDY+ii0Lozlk1viFrjOxMtY?=
 =?iso-8859-1?Q?drTVoNZ6F4+/ysY4VIROPYTXLwgyIYX1qb/WEjVWNj9ZjK5wweyxAg4ULq?=
 =?iso-8859-1?Q?r3O/eiTJAIxi8tS0m35JFT1H+hgO27jLi8boD5EdRV6Ktct0xsRmVToIMH?=
 =?iso-8859-1?Q?ELxNlv/INLsVwDb7b3eA8MpPlTz057HIoNNDy9nt0pNawzEjM1Bv5U2LqE?=
 =?iso-8859-1?Q?XAXxCJqJk+5eEzpMd0UZvMkQ/pyuGbJ5ZWYY1V3RX/ylGQpv9rlC5BNGdk?=
 =?iso-8859-1?Q?hFYqHtA5GiSbEfzSD6jTvpdg20xuoZyt6MEHDmvh9usb/4JI3oz/y9zMjC?=
 =?iso-8859-1?Q?M4E9ozXfQ6Ju7hvBuwU3Y+SRs1/Al3VvRlbjlTyI9Dk8WVsxM6ZrpaL3wy?=
 =?iso-8859-1?Q?jnPj4YWQxMDtSQyJc9mV2v7ipeB4l2IIDUva5hMvPl4b+HPH/4Ye80Og?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212cc024-731f-4131-7d88-08dac104b78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:12:02.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af+KOXscFARi9xdQ0Fd8Fy4UMulIwe2cgFbpUFyEKUUsrZI9PLSbIHa/oGp7y17j5yMZaEUVp+7wdLoMwV/2oY72bYFxGC/r3tKcom1rpDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9809
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POE=
G
> binding
>=20
> On Fri, Nov 04, 2022 at 03:19:34PM +0000, Biju Das wrote:
> > Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POE=
G).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v2->v3:
> >  * Removed Rb tag from Rob as there are some changes introduced.
> >  * Added companion property, so that poeg can link with gpt device
> >  * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
> >  * Updated the example.
> > v1->v2:
> >  * Updated the description.
> > REF->v1:
> >  * Modelled as pincontrol as most of its configuration is intended to b=
e
> >    static.
> >  * Updated reg size in example.
> > ---
> >  .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  | 86
> > +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> > b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> > new file mode 100644
> > index 000000000000..8adf01682de5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yam
> > +++ l
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +
> > +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  The output pins(GTIOCxA and GTIOCxB) of the general PWM timer (GPT)
> > +can be
> > +  disabled by using the port output enabling function for the GPT (POE=
G).
> > +  Specifically, either of the following ways can be used.
> > +  * Input level detection of the GTETRGA to GTETRGD pins.
> > +  * Output-disable request from the GPT.
> > +  * SSF bit setting(ie, by setting POEGGn.SSF to 1)
> > +
> > +  The state of the GTIOCxA and the GTIOCxB pins when the output is
> > + disabled,  are controlled by the GPT module.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-poeg  # RZ/V2L
> > +      - const: renesas,rzg2l-poeg
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  companion:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of a companion.
> > +
> > +  renesas,id:
>=20
> Perhaps 'poeg' in the name.

OK, will use 'renesas,poeg-id'

>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2, 3 ]
> > +    description: |
> > +      POEG group index. Valid values are:
> > +        <0> : POEG group A (default)
>=20
> default: 0
>=20
> Though a default for a required property doesn't make much sense...

OK will remove the default.

Cheers,
Biju

>=20
> > +        <1> : POEG group B
> > +        <2> : POEG group C
> > +        <3> : POEG group D
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - power-domains
> > +  - resets
> > +  - renesas,id
> > +  - companion
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    poeggd: poeg@10049400 {
> > +        compatible =3D "renesas,r9a07g044-poeg", "renesas,rzg2l-poeg";
> > +        reg =3D <0x10049400 0x400>;
> > +        interrupts =3D <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg R9A07G044_POEG_D_RST>;
> > +        renesas,id =3D <3>;
> > +        companion =3D <&gpt>;
> > +    };
> > --
> > 2.25.1
> >
> >
