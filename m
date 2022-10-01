Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3625F1D9A
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJAQaL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJAQaJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 12:30:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBA13DE6;
        Sat,  1 Oct 2022 09:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuAuVnorlaxAf3aVEXOn6ZPFSeLmxfIXJEM+u/i2/KuQIXwW7aMpkJre48CTG3aTCWr020M+C+sSrxdh2wspBrzHzLk1EAmZTN43eLVNtYHOxW1odB/08AQV41UrM+8Dg/M+Rj9MCv6mUQgj59mF8d9gwp5v38Gyj16EAzx9/X95kUrYkAssq780JUSdsGxKKnvWqCktKScAgTX5a1ZNBkpwDUPEwqSvVJ3fw46XdvH4JkR34dbf1A+2eYn/jNS987/5TEQC/Azt2JlicQQILtzVY0xcpBFVnTZ+rccjlTXCcHq9P7R/Dd8Fm0DJDE2HawrnqycNrYJmBQ7WBxRcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2lw15gdMAV9N9xSXxmnqQajYxBhPe31vigReP6kZQ4=;
 b=kGX14lyvvib2vqWegCBf2u5Iki6bDi+5n7yg0A9iBeKoyUZPYEfmt/+W5vaFHsr0eSN9XwBR4553756Zo0zfTxLGrf/Y8S+SmGT5yMzcfMc1v5HDrI7/2KG1GuWf6dJLrHm5RPQyxooVRAgbtvyBnzHsowUby3tTxjKcMnqsfHPpb5tuB7ePrxmgczBTlUM9KyFGbdkaxc2ETbJkqx4eqq6jUHD4kHDyKu8biyi54dMMx5IYImxH3I5XCetDbtjICFOrdBG9IwJSA3xBPaI2gnVwCI7LMiqqF6QltHPVRyf2jYQ8xMit8V/wx14cVcVIyGijBGxpcmyWiiASk56rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2lw15gdMAV9N9xSXxmnqQajYxBhPe31vigReP6kZQ4=;
 b=DtBY7Nz4dTruYAmGmF58TnWOgK09U3VaPOCAmQifd7sKoHXxou1GXAvJVeQ7fgLQiVLmC4ArYg+csqaU0+eqvikppsgwpDbrNMRSCJ9iOKrrNpSE0D135+pVPtoSAKVkTTe45Bg3li1i9HCLvegtvLLm6G74k09+IF2QC9AQF7g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10343.jpnprd01.prod.outlook.com (2603:1096:604:1fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 16:30:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 16:30:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Topic: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq34TwCAgAFpgFA=
Date:   Sat, 1 Oct 2022 16:30:02 +0000
Message-ID: <OS0PR01MB59222221E499199D316F51EB86599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <20220930183537.GB567190-robh@kernel.org>
In-Reply-To: <20220930183537.GB567190-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10343:EE_
x-ms-office365-filtering-correlation-id: 3dfb813d-72cf-4425-cfca-08daa3ca30e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lHnWUfE73CCg8HSg4+ztLRgOUz9qSDRsIzORSeJfqHTVyAe6+UGxkOA80tjsnFky793CYlCIB1Wv8drcUg+Jhf6eG0RYsWWP6lBYNswKfO2ttpOKcFfGLvC4pScQOxifJSTq6BvxNlREXPxEziWJRvE14uHiHQ2twQaZ4dE4CAnPnHkSfC/UCmvh0U+3al1v5u6mhRLr8o1j60fbX1+flMS9cn/WxUJqnBGp0AtDHyyXMyDeKOZdbb/XEux2oyH45tJI+4ZlOb5J/nniE0OUDdydduLDztfso7wE3F9MD5+Llgv75J9do7eQy3C6XZZMjPDhQRVAW/7pNJmVKKry7Lb/jv8Iiol+1O3W9A8pclfsAJjlxzaK+h7MwT9a5pChZtVJJ1Hy9+ZuGSec/o/1pGEzIO1s9KOQSPwila6TTfeCJY4hAbKYa8pMiNa6fOqmvNeK8R7WxnSW/skWnGUlK4xXE9qA1mtTLwvCiv0tiOgSN3eZgBifH/69Fiv9d8/LaUvqB0LtJWp9zeSkzMHKC/gAiLehO5Iiyy4GyJlwwZkf+OK99nKE7aMBPYOfO4CLEQKk8gMUJceMeY+12vjEsdIn9vpAsUjXvvOi9oFgiZ6/xqvpmPJaODIOHE8lFRBHDNckflFbuFc+YyMGVQ0sCoL1kHazhJ4CQIuvcSbOWZ29AK6vJuF2WmoMge3nvfUXjFEKPUn+H6sTc9lKvjw10Je4sLNrJ11qroASYOgYOpw9Tc4EDAQID1+SLmcjgGg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(5660300002)(26005)(55016003)(52536014)(6506007)(8936002)(7696005)(9686003)(186003)(2906002)(83380400001)(122000001)(316002)(54906003)(6916009)(38070700005)(478600001)(71200400001)(66946007)(41300700001)(33656002)(86362001)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4SkHYOou8nzxI7yxwGuNJFVYW9sgm9qX+H5XEAACGtDUff5HyCN/bHhKQl?=
 =?iso-8859-1?Q?oZykbDoRUFuXIZ4navIn3lb5aEtdRvSfhlEzLqAtY2X4KN7iGwcZ2zXAp4?=
 =?iso-8859-1?Q?Qh0bP0KIrP8wY5Qgd4WFs/qZCbeaWhILGOIWAb9vSxu/Pc/Jqn/Chty46c?=
 =?iso-8859-1?Q?hKSpwCkalyWZsnt4q5hwLbVAFnagSytoN4qIVoERdHUvPMOTnp+6rANpxQ?=
 =?iso-8859-1?Q?egGw8N0GW4f0ymRKzLZFlxZrWBiZHC2GMCfiSCww4va1wUmB/PDpLY1BW5?=
 =?iso-8859-1?Q?g/mVUK683R6yVhsFSK6YJAa+95IYS7zDi+o5FKC9ObPV1CmBOoCoU3ufSt?=
 =?iso-8859-1?Q?k/WWnUixRJ0sx1DKn00S1smZmsUaY6idv59Bvg4uF5IzJQBggbRuBDYoRD?=
 =?iso-8859-1?Q?E2fgjyTSor61uhTwedXzRVFvKrZCJK7wn8qwaYk7ehtXisIggf64NQ4L9Y?=
 =?iso-8859-1?Q?pFEt8zvV+tVAf83JNPcNb+o02nJ2ghY5743VoxleO4JDNaqMfAsuzwZ8Qx?=
 =?iso-8859-1?Q?/WInTqb/T3kF+5Qcf9aEaTB0r0iE32s7ffqR76aJODGbxPZCkVzkrEbLZH?=
 =?iso-8859-1?Q?fKUW4VXeHPXEO4137ZQOMPfbd1t0Rp6nZAclzmz3DFlrzJLg47I+nQ+9nb?=
 =?iso-8859-1?Q?60lEK+Ixh4/5O0CV6P+vjv00GuUfP+7SwlpFMq399UaZoHnCt5nAsp6kHX?=
 =?iso-8859-1?Q?MsybNiTlQcK0lO2KirAbfrD9IQgMuIzmCMD2MIkSCTdaE5Vp0hxrhY5Jb8?=
 =?iso-8859-1?Q?K2VlIsIxG+kZNp1fJxmdDAzpuybHD8cNcYLYt6CiHVqmY78YrBfL2t10KS?=
 =?iso-8859-1?Q?YhjEGQFrwrW+7o+GlRKo6EaxINLseIksvx1PaP7NJ5VgTOAB50cUtMoXOW?=
 =?iso-8859-1?Q?Lcz8e6Y+QGJPliKP0U3q3y/qMj7D87o3B1INBZ+45f6+JH8OiZ8JVdQ8jv?=
 =?iso-8859-1?Q?tEra8lcEOG/BFSvBCod3xzR5wY2Ybc7vDFHGAuM992fT1rwmEyOKpq54RK?=
 =?iso-8859-1?Q?VcuwVUlEbj/ZMy8OmVT4e3ReJ/uhDvwkp6CsYfWYDf2/mmyGgTY6GyTRsV?=
 =?iso-8859-1?Q?d9Pt4dJTpGuugsFq8uNBi5zAwcKPNG682YvBylrbCtZzYatc9ySSMjN9Lw?=
 =?iso-8859-1?Q?s05jRZoLfSnvPfgJv6lfBOAuhsTuFSrGNoQjmQZyCFyM5DlQIVVB3waPrt?=
 =?iso-8859-1?Q?lBoS2wV+RE046Cim1QvoyhzgV5noeVqtGVtLB+uR/TaJPqX69As37sKo7t?=
 =?iso-8859-1?Q?yrVJdUfWwSOUFfLc3z+uVNc+s6ZZRzeYapYlARat6dPkjiKf/2Ng0G6vwo?=
 =?iso-8859-1?Q?g3slTubMOa/T0Uqa8BmdTIvRMvCxTKaaRF1McKLNupW/D1c+2/g6njczh8?=
 =?iso-8859-1?Q?Ix1tvZov82MmFUV48ZsS8a1fwnNBXaN2vP7vhp18RUlTtZJqC5J0BUpeyO?=
 =?iso-8859-1?Q?845GCUOE5xKBA86qWHXfmfH1krZq1aot3ZYC6ReVjxqBeROJoV1CZ/Z7di?=
 =?iso-8859-1?Q?HY68H3L8v7FbAAffh7Hxpbt8FNtLS7A20VsJ3uspcdkgIkfw11JTIdX7a+?=
 =?iso-8859-1?Q?5QWczRxh7Uy7vudpQMOH1diBk8BXs6pwaX9JSKEATNH43LPu5jQHm/xXiE?=
 =?iso-8859-1?Q?TJt4LhmDHLFGLCTucf7u8yY0QG3yc/o1iv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfb813d-72cf-4425-cfca-08daa3ca30e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 16:30:02.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ew0x/Od8q1Nmnwy1INC6z6L/k85b8iMAZ81wDhmU08jusmAnAhb9vg0DjwSt5qkP6B4ogxKJ+4H7dW+QY+UK7L0tIShEWEnC6X3qL+toJk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10343
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

> Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> RZ/G2L MTU3 PWM
>=20
> On Thu, Sep 29, 2022 at 11:30:39AM +0100, Biju Das wrote:
> > Document RZ/G2L MTU3 PWM support. It supports following pwm modes.
> > 	1) PWM mode 1
> > 	2) PWM mode 2
> > 	3) Reset-synchronized PWM mode
> > 	4) Complementary PWM mode 1 (transfer at crest)
> > 	5) Complementary PWM mode 2 (transfer at trough)
> > 	6) Complementary PWM mode 3 (transfer at crest and trough)
>=20
> What does 'complementary' mean here?

Through interlocked operation of MTU3/4 and MTU6/7, the positive and negati=
ve signals in six
phases (12 phases in total) can be output in complementary PWM

>=20
> Mode 1, 2, 3 isn't very meaningful. Do other PWMs have similar modes?

In complementary PWM mode, buffer registers are used to update the data in =
five compare registers for PWM duty
and PWM cycle. The update data can be written to the buffer registers at an=
y time.

There is a temporary register between each of these registers and its buffe=
r register.=20

The temporary register value is transferred to the compare register at the =
data update timing set with
Mode bits(MTU3.TMDR1.MD[3:0] (MTU6.TMDR1.MD[3:0]). Mode 1, 2, 3 correspondi=
ng to these modes.

> No way to tell without better descriptions.

OK will update description.

>=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 50
> +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > index c4bcf28623d6..362fedf5bedb 100644
> > --- a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > @@ -223,6 +223,50 @@ patternProperties:
> >        - compatible
> >        - reg
> >
> > +  "^pwm@([0-4]|[6-7])+$":
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: renesas,rz-mtu3-pwm
> > +
> > +      reg:
> > +        description: Identify pwm channels.
> > +        items:
> > +          enum: [ 0, 1, 2, 3, 4, 6, 7 ]
>=20
> At any given level in DT, there is only 1 address space. You've
> created
> 2 with pwms and counters.

pwm and counters are mutually exclusive on the same channel which is taken =
care
at higher level(eg: board level, we enable either pwm or counter, not both)=
.

Is it wrong to specify same channel for counter or pwm with same address?

If needed, I could add logical addresses for these channels and
on implementation side, will map these logical channels with actual hardwar=
e channels.
Please let me know.


>=20
> > +
> > +      "#pwm-cells":
> > +        const: 2
> > +
> > +      renesas,pwm-mode1:
> > +        type: boolean
> > +        description: Enable PWM mode 1.
> > +
> > +      renesas,pwm-mode2:
> > +        type: boolean
> > +        description: Enable PWM mode 2.
> > +
> > +      renesas,reset-synchronized-pwm-mode:
> > +        type: boolean
> > +        description: Enable Reset-synchronized PWM mode.
> > +
> > +      renesas,complementary-pwm-mode1:
> > +        type: boolean
> > +        description: Complementary PWM mode 1 (transfer at crest).
> > +
> > +      renesas,complementary-pwm-mode2:
> > +        type: boolean
> > +        description: Complementary PWM mode 2 (transfer at trough).
> > +
> > +      renesas,complementary-pwm-mode3:
> > +        type: boolean
> > +        description: Complementary PWM mode 3 (transfer at crest
> and trough).
>=20
> These all look like client configuration and should be either runtime
> config or part of pwm cells args.

HW supports 6 modes, as mentioned above. How do we switch between modes??
Could it be a sysfs option?? If sysfs, do we need to document here?

Cheers,
Biju

>=20
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - "#pwm-cells"
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -305,6 +349,12 @@ examples:
> >          compatible =3D "renesas,rzg2l-mtu3-counter";
> >          reg =3D <1>;
> >        };
> > +      pwm@3 {
> > +        compatible =3D "renesas,rz-mtu3-pwm";
> > +        reg =3D <3>;
> > +        #pwm-cells =3D <2>;
> > +        renesas,pwm-mode1;
> > +      };
> >      };
> >
> >  ...
> > --
> > 2.25.1
> >
> >
