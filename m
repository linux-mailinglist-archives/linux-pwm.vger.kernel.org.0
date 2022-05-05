Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E506151BD60
	for <lists+linux-pwm@lfdr.de>; Thu,  5 May 2022 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352325AbiEEKqN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 May 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiEEKqK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 May 2022 06:46:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586F53717;
        Thu,  5 May 2022 03:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INfyz2QJHtQePaK/HU3fAocdO0yoWauGyVtclSm2vLAqtfeMMN9lkQwHs2EXW9P+1MY8xCqcQvka/ZZyA+s+Vqm5WE6f8wykBQRvj5mMKdqPK7Yzor099snSFwcGF+wX77O28T/xFacEaL/P8ci8uWgfRNhaZ/Unvv8jHUiDv97UfUZXQeRhAb2r5mu2eNvHe+V36UCK7UbKHaQmM8djanUTdq8zdIZ+Nc8ymiYb2HwuM1tmX5rL1FLQKlaOlbkCgpu625+azDra4WFIjW6NCGgiBt4pYu9GlI3K55uASgnSn59tv1gCWTVFhokvKk3/r3o6VzNzrVQ6GkALWHrgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGUtg0AwDAwfV4dLuaGC5apLGvV9qkZOWSyGvVEPesg=;
 b=TINqsB02BLtiXrQoPyhYrKEl4imJn6CfwLT/oEnDyB7/dF47pZNzmCw6yohirVteAUi6RysO9jq0IJlpFvx2/g4rajCJCQTxQ5avjc2SYwm56vm+d6eRvPzQDSs1JcUph3kQWy1JE9ludHU+D/EGQ1lNL9lYVSeA98uKYRxf4GIwWbpPu0sCzE4xPLqw4WfprARqcCkWxr4Eo8a15jXP4coEsxPDXzw5dIOAWrRvPzNApA7sRQK4Yu7Hlvi2yshBkaTFYt+TD3fjcbkF36c2iUML0yLOKbikWI84RgiCUE41NGhL56jupVQ5leOacJIDo4VROuwogirupSWX2tGp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGUtg0AwDAwfV4dLuaGC5apLGvV9qkZOWSyGvVEPesg=;
 b=o39ejOesdZVsllYWyCYZWcZvBRLa9ciop5rfzvZ4y7gdMk1vzYVvf+cFqwNPj0oP5KRBUkKdnuqV0SeSwtyvnl55GZ5b9sEjxHCjKfgG7wDHNmSelP8bv2U1u9dvj08ZbDshuyzHCZD8BP9S37WT9O5vKcSrI2bgpGIPtZRhuN8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8888.jpnprd01.prod.outlook.com (2603:1096:400:16f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 10:42:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 10:42:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: RE: [RFC 1/5] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Topic: [RFC 1/5] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Index: AQHYXGg4yi3MiWyDhEeiinQCYnluAq0PQ2WAgADc5dA=
Date:   Thu, 5 May 2022 10:42:28 +0000
Message-ID: <OS0PR01MB59228E3A00D83A4B629D343686C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
 <20220430075915.5036-2-biju.das.jz@bp.renesas.com>
 <YnLwV8cF+t2SLCWF@robh.at.kernel.org>
In-Reply-To: <YnLwV8cF+t2SLCWF@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b59581-3283-4b84-b50b-08da2e83f34f
x-ms-traffictypediagnostic: TYWPR01MB8888:EE_
x-microsoft-antispam-prvs: <TYWPR01MB8888F730594FDDCFB05107CA86C29@TYWPR01MB8888.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eD30lHranLBMswGp8SZbG5meMdZuwWy7GYK9P7TaQCGX7xPwMJ8h88wBurA/++eq1FQjMpqY5YmL9Kr2eXclwm7U/nb2YJ9YgpJ02G431ZJxLWAVSk+cYspeb6fwDIdEDMmtjoXg1soEGNPWnZCl+n17IMoa4Db1D1raHQbl91JC6UdjZGby0du7xO+IByyV2zevyzV7+IhdOxg7EUG77UtnJ8DeshTnFWGfEAXNUyOmn+PdOCSebgBUFBPCP2G6N0gd89q6kZF2DaVJOOzlUlaOWC+yGkGALy6eSJryoUAQ4h/GHYfYtOqcLGRq6Wkzm6ycv+sWieZ57XbdcCw6qwcTd3e7Z1XVxT3Y+dKq2YE1TIR4zSZkcoIRz3a/A1OOYOyYw+0vLbwYUHRkjUYAobdbLLUZmwpGPaQLpUkp0JVmyvkCP0l6t8tSZ/pPmMcr1qLtpi+8HJkdD8pL4Hp3NvDauUhFETo13Fhh0qt0XdgV3Ohb7jylNS6UAjp4j7sbB7Kum5yQNESdqrwNa/LxOy78WdG4b0QDk4bfEFOBf9ZztKZKg3VsKA6TWk1T+R1KBlOj1AmAcZ3sQ0nCZ7eVAe08/4oEIfN3wAHnE1HM/yKoXp+UguEItn9GJwAzhL90puFnmMsk2T9+js8zje7d/mfgysN7sRyK9IoDBIzMyIWval3y09OehzK+dYSze6iIpj/P+T8/yqa87Gd7b/oxFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(8936002)(186003)(33656002)(55016003)(5660300002)(7696005)(52536014)(2906002)(6916009)(76116006)(508600001)(66946007)(6506007)(8676002)(66476007)(9686003)(64756008)(66556008)(316002)(66446008)(4326008)(26005)(83380400001)(122000001)(71200400001)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+grYlohgwcLK5TSy67cKWK3RPpczMk0f1DbPncMXvaZoKGM8+dYbEQsmUl?=
 =?iso-8859-1?Q?E/TCMkxyzuAN4JGctB0y44ANuxS56Z5vK9pKh4R5QYjLb0OavykqK8np/y?=
 =?iso-8859-1?Q?YKnTVtfAZjB2FIXo+h6gHZe4hQxvIpwExA6ncLi9kCm+SSQYMlYeHUtfLj?=
 =?iso-8859-1?Q?IUxcnChJZhB0zkxaU1Vnd2T0imoVceezrNicZz5jJR5nnW50+rhRRl3mtE?=
 =?iso-8859-1?Q?bK3xoK4nJSpPW5kPrFrSMJQ8Vf6hlDNE5RBNmbj6eD0fAP7yuPAcJk9HK2?=
 =?iso-8859-1?Q?0AffPAfDc/g7azBG/jae7cCFzp2/+ZVt2iwCvb7fg3jujgUSN+MxImGff2?=
 =?iso-8859-1?Q?Ge5dMVp0NsKmYi/Iaerl84Gg0LPr1NnxB0M09nSQfzZXOCMgWORB+OHWSZ?=
 =?iso-8859-1?Q?mGmB9FpplP+TJlijIaopjZ7c1TTZQbfWd4/fhgbQ4Z3mSR/UHm2WuJuzVD?=
 =?iso-8859-1?Q?9lHQTcx6ZdDhoZbThzLW7+kayVpKxb5+Z+0fLWIHuVsP1+Qn4K1zESOEew?=
 =?iso-8859-1?Q?aD4gTYv5VCEsi8lGgawy8Pu6Vq4QlqcaQKQswSp3FC/S7xsbkPNi5gTijE?=
 =?iso-8859-1?Q?zEKlGvUhB26P5ScAFK6HGQ54nG4YAEW2tjzSaoBH7u7qEWpkNhbDzncO+/?=
 =?iso-8859-1?Q?KLou8PZsvZ7jlx84DLOBxF3YBNXPHkUf+3NnLAdIKtjxULGv6Lxpu53+8O?=
 =?iso-8859-1?Q?UofyN2JDXcMCpMAuBlYKy4aoXnvCcRF73sPTWO4sBegFb5R8+E34ewOZ5j?=
 =?iso-8859-1?Q?Cmzkfv+JmN4ZUU1o6d1APBjdj+bmPHd7cDdcixvW0JAS+NknJD4WI+QPAv?=
 =?iso-8859-1?Q?ZwzXlhe2IHqMIy453x+5ays2KpsMeCFguZoYJ9pbkhNw8v+Rq02x0PsFOS?=
 =?iso-8859-1?Q?FJwAVgfUxvTxzIxk8a1h4IZLtEJzieOKuhv7nJPdxkcTN67yxAEyiWhqhe?=
 =?iso-8859-1?Q?bt954ZjCR36KQBX6Mouo274IZxg3zya5mzzgZvhzNveT4vgZY+H4MbgkwK?=
 =?iso-8859-1?Q?R16IDu7D6v2a9/V07MK/HS3hiTyyUS5JVxdMeS8AMV7BqZs2AbsSkOB4XM?=
 =?iso-8859-1?Q?mrLg1f3fXa/awD891FXcbouB4OXV72GK6KypkP5CwTQHLzNgkWtmU7WGY4?=
 =?iso-8859-1?Q?3fwke5C7NXaeaq9B14kuTaz8fQe+XfmbBnVsbBC/q2ad6CQ7Sj3fxCoepI?=
 =?iso-8859-1?Q?5sh0emaH2X9pH3BOhKToGSZQSxblfbOsYQ4bheTfDh/gV6l9ZoB47dUCCo?=
 =?iso-8859-1?Q?19m9jI6dFGRDQqRe/11SuViyabD55wX9qA9EyyhKmrPXnw482PQCkEeO+Q?=
 =?iso-8859-1?Q?ujsbJCxuavTB9YLN4zLCU5zEgRZCL32XyCCSzoRI0t4hmyueRoY8mqc7Te?=
 =?iso-8859-1?Q?Q/5/5xkUCcw71ZvYVX96kRpP+SIzzxrE2HM4TjAmQOIZk+3aMiHUXUhjn+?=
 =?iso-8859-1?Q?VichMOefzxJ+vf/4PuEzOhffKLzsNv4gmHehKlwaYpWTVjODxdYNG/cBQT?=
 =?iso-8859-1?Q?IQMMIjEsKTKfNBtXsT4WTaPLH162hEFmamPr0InOXPC/uRPZiT/raLwARo?=
 =?iso-8859-1?Q?yh15GSNYkrBmglaaIuekNR6ucIbcXzHmy0BhXCCOLFlSG5nSkF7n0j6s77?=
 =?iso-8859-1?Q?s4hSILhES0158dRUqPzckSYMM5bV0Q5nq4wEzAb+EkKzjNSTapR0sWkznA?=
 =?iso-8859-1?Q?bzzD75/EXtpQzUT7GVU+uq9rd1wzB+IGKUjJ+stjwyvJVTpdCuUGW3MzXB?=
 =?iso-8859-1?Q?l02FP2AxIPdKbeuSLsL6lMsICgUBC/NG5eh5hwF0zh49sgg1gDctIczidb?=
 =?iso-8859-1?Q?tg2B74TxeswObxD/voYttCaZpmCmuLs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b59581-3283-4b84-b50b-08da2e83f34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 10:42:28.3558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVEHqQK2eu5bhocUwvFrjFD0QIW6DX72J4c9nCGIdNLvXIsV/BolL1wone7d+WLFd9QIXS0YmxKDrLO8dTtXsmCgptfd6eXsYEWH2saETEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8888
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [RFC 1/5] dt-bindings: pwm: Add RZ/G2L GPT binding
>=20
> On Sat, Apr 30, 2022 at 08:59:11AM +0100, Biju Das wrote:
> > Add device tree bindings for the RZ/G2L General PWM Timer (GPT).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > new file mode 100644
> > index 000000000000..0e44c0fbe04a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +
> > +title: Renesas RZ/G2L General PWM Timer (GPT)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-gpt  # RZ/V2L
> > +      - const: renesas,rzg2l-gpt
> > +
> > +  reg:
> > +    # base address and length of the registers block for the PWM.
>=20
> Yes, that's all 'reg', drop.

Agreed.

>=20
> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    # should be 2. See pwm.yaml in this directory for a description of
> > +    # the cells format.
>=20
> 2 cells the schema says already. The reference for the format is okay, bu=
t
> move it to a 'description' entry.

Ok will add description entry.

>=20
> > +    const: 2
> > +
> > +  interrupts:
> > +    items:
> > +      - description: GTCCRA input capture/compare match
> > +      - description: GTCCRB input capture/compare
> > +      - description: GTCCRC compare match
> > +      - description: GTCCRD compare match
> > +      - description: GTCCRE compare match
> > +      - description: GTCCRF compare match
> > +      - description: GTADTRA compare match
> > +      - description: GTADTRB compare match
> > +      - description: GTCNT overflow/GTPR compare match
> > +      - description: GTCNT underflow
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: ccmpa
> > +      - const: ccmpb
> > +      - const: cmpc
> > +      - const: cmpd
> > +      - const: cmpe
> > +      - const: cmpf
> > +      - const: adtrga
> > +      - const: adtrgb
> > +      - const: ovf
> > +      - const: unf
> > +
> > +  clocks:
> > +    # clock phandle and specifier pair.
>=20
> That's all 'clocks', drop.

OK will drop this.

Regards,
Biju

>=20
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - power-domains
> > +  - resets
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    gpt4: pwm@10048400 {
> > +        compatible =3D "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
> > +        reg =3D <0x10048400 0xa4>;
> > +        interrupts =3D <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 273 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 274 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 275 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 276 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 278 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>;
> > +        interrupt-names =3D "ccmpa", "ccmpb", "cmpc", "cmpd",
> > +                          "cmpe", "cmpf", "adtrga", "adtrgb",
> > +                          "ovf", "unf";
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_GPT_PCLK>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg 523 R9A07G044_GPT_RST_C>;
> > +        #pwm-cells =3D <2>;
> > +    };
> > --
> > 2.25.1
> >
> >
