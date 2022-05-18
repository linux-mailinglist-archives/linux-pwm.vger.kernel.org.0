Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEA52B20F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiERF6F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiERF6E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 01:58:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5885EDDC;
        Tue, 17 May 2022 22:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPDg0CS1Vrtyf7WugFMm0JTlbUj5wLLP+K+9wnB/X2bYVSOLqIzMR14UbXZdCYhbc0P5ZFLZo1XxRAj+xGk8N5UlENOt1RqQLWrNEpoqVZLDSTWiRjXPWy1pnncei9hTtehUdUVezYEAWXaK34ladX5hpCwU4zmFrlP2e2klc9x2y8R/XeeFLv8NVfmI+wT5hrPHWbulL5c5UYix/dpRvY80n/kSjEvIH5UeUIErs6RpnvitWVjzW5IMEj3TyXnU+WiCkATeARgAk0IgljOdHsjT0ZT2MVLghjUmqsEMk4jKlN73lI4lAePqq40V25KOh76HOHsizozu+55yQ+xEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e83+c4TCcgKXz/4XZLwsqy2i3ivyA7FUezUrCzA4Pg=;
 b=MJM5tCKjdVuBu+iEBSIf8hvWF3POj0/eHroM71oYdhZkKRXdYrIyrnfQtLT4+IPzu7wyM72qvuA0YfSYJIXJoIgcwKrBJepyxS8dJVFmuVfsT131W1DFGqQYaG/y46gKOabvmDa+P9EV2u6Vv5IrFoxi5Zs/hDXq53PVr1dB5xN7Qbju3U6fvrO7xzzRmpplGuRK+TrhboNQfT1Wgzd/me2yuK+uRls7zgvjhsHzoi/9FCk6lt8jZmjVG/qRkP2Mjq5MeYBGE7VjOmrjDoloRC+j8ah1qMG8Vr8kX8jmWR1uC7QMIReF65zUslVJblOpJAmUA0GGEL84J+/Jgz/1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e83+c4TCcgKXz/4XZLwsqy2i3ivyA7FUezUrCzA4Pg=;
 b=fZ6SoytoiSMq4VwlX75ROTde/rzsfXngxlHyOjuXu0wrdBzHijS3WB4TOEboItczdwgStGVkefCK5pNbLYEPUjzbumazk6e+3IXoCYMVerkSqMqn2ZJ8099hCj41p9IJpycD5CmSngGVxIH62bYoUmFZj01lwxfP7R387+4++VY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5806.jpnprd01.prod.outlook.com (2603:1096:400:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 05:58:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 05:58:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Topic: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Index: AQHYZIA3TRVrx9T/skGzEuiCwjtE0q0jmkqAgACR+bA=
Date:   Wed, 18 May 2022 05:58:00 +0000
Message-ID: <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
In-Reply-To: <20220517210407.GA1635524-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5096ac-6f7f-457e-c270-08da38935d6c
x-ms-traffictypediagnostic: TYCPR01MB5806:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5806D6875DB8A731A59255D786D19@TYCPR01MB5806.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eU0Ucz+LdE1D6+LQcbWT6Odbaq8N4KhHGStaFAYjkNEwMX0qXyfk/cXVdoC6S0GyM7hZ8S3EbChA3vG3Ow+DPsASgK7lR4SRLcV3iXhX1vkUcZg0YPJ4kJtKE1sq5p27O/Onb5ZkyNAmsj/U49/5DM6brvhXkCScQYhOII2X0mubAKAWSfgsYZXv0HsFxq0xeHcVr4u6EBZgur1waZQQRipInf5slGN57lvpWn4/GEzDerzF2vPGWMJRW2k2vcq3vagxm2RJgv9kCIashzGIbG0wxi6LodlZCR082K+u0LP4svsn8x0nyz9R4e3WA1dDpp0it9NcMn4hnQP3z1CsmmcoJlgqxLsQHXocs/TqtoqDBDYX4V4+EJBUgND9/MlBdpZnGAspJoAOpSdM40xnisKDyE+H+HRsZXP82cajP+/AvFtbD8nVd+26TOfZS0HWol7fo9XHfeTEpcFkKoHGjCXIrcXTmpxQwV8k1tDbNSajLkIP6Qz3QNgtBBBvHr3Eq1cRdTBo5LAW24cx/mz7dBnWka0YzT8xgFxPtsMGhMl/JhvNmWbfq/6VwUwNjR48lSKulvYFARtY7ZrwqOS5t3aI/SPvZCgM+0R2nJ5975fNgOTW6G2dDOeodI3rEhJxuAS/iV82AE6UuQDCFPUrykWlzOnlkCgr2zrZl+Q2WOwGjp59aE3AU3ZdNSAPRui4zQ8YAiO7qRrG411GUxnvEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(76116006)(66446008)(66556008)(2906002)(66476007)(8676002)(71200400001)(64756008)(508600001)(52536014)(8936002)(38100700002)(83380400001)(5660300002)(7696005)(38070700005)(55016003)(316002)(26005)(33656002)(9686003)(122000001)(6916009)(4326008)(66946007)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZQA3h3AzWlXlhgDFYhF0/P1YLxMxAoN70XfK60nxFe9BzLELoU0C5mWSg/?=
 =?iso-8859-1?Q?jLsPMhb8t24Wy/d05zoMe7C+lKKJy36q0FbLktBcAH35V1fGtl1nwKJVWv?=
 =?iso-8859-1?Q?PqNiptWdoTI9NL7d/aW2rNIUeOE9zxHHcuPdSWHY7mJyNA4OOcd4wyZKok?=
 =?iso-8859-1?Q?opng/bQe37L1nH+mu8ivBkZ4BBgDxJycn2SCKEU3mdq2D02A6WmIUhvJpb?=
 =?iso-8859-1?Q?5w9mxWGMY8rnTxcRD9od6Fzw7LHF9azt3Tx5AMmTMcIZd9BL9nZDxULv47?=
 =?iso-8859-1?Q?XX0OcjA8PMcPt01WpAI/M4tcaGbTHP7XYfctLWX/YJmuzV2n+BGsoGSjEH?=
 =?iso-8859-1?Q?5JklpRtpYiB6QfLKgCEv4AJzvB+C1d/ypJICL+jgpvcQ8zFo6Z6wl0BF6Q?=
 =?iso-8859-1?Q?2gi5hI0fmz0H2YaDWv9HBm0HuBHSW1P2GqXHCEfVh4XfDRE2sUs7wgZNdK?=
 =?iso-8859-1?Q?M8r1cugq6wBhw7PN0B5Q55LpxiBjivYRZxXlF9ibANaD03GdfJFgjit/ye?=
 =?iso-8859-1?Q?+LUmVQNxG4pBmvWTE2rwsEpZoTNMKHuAteYY6Kyiz+3ZX2HxcloJARxaAe?=
 =?iso-8859-1?Q?KkMv8+V+cCsqdrgQ847J2stI2rHsZNHX5uPGNso6r553/WtB3A0oxXR/bb?=
 =?iso-8859-1?Q?YfrjA9SXkbpaEMTFMNlRiW0PdTb5QYLF7KKHkA5qcFba92XHhhWVU4DK16?=
 =?iso-8859-1?Q?K5LnLqUltLKBF3y1VkisdT982jid/T/cHq8pfDnm0VwDXdqCI9sUaI3XHE?=
 =?iso-8859-1?Q?nUEFoworS9updn1Rtme1c/TJVstGKs3jIGX1CVFvpWoeqtIE60WZVOZVDA?=
 =?iso-8859-1?Q?KL+gsbyviUAHlBmCjX1HyL3U/h8GyyEwTBpwyn9/QcBSmsy9B9UZbHe5jt?=
 =?iso-8859-1?Q?iLZZbbgNi2XtcYvO3+DQ7ZIaHp/MSSYRkxiZFXNgmokVi70EQLZif085SJ?=
 =?iso-8859-1?Q?AdttbNL7xmW0Z4eUjdsxhBRJz/6SdNNq33Fm+LztzZUnklp8NZN328itQW?=
 =?iso-8859-1?Q?JV9zVNyn086bBMwNyeiJQnHScVtR+Ler0ySGLLnJsUKCwk8e6km6cT5eYA?=
 =?iso-8859-1?Q?0boka3r5DJRtZn8xSrrCV93NmtzQuv3KwUjHaqK6yeUvGd0eiERH6fZQqx?=
 =?iso-8859-1?Q?cZSLAo1lWrYaLldayOxs0WFJhvDh9LHg2iwG87hYjUHTimQQwzBVUDK5iz?=
 =?iso-8859-1?Q?XJiWP8fjuyt8oK7IcFoesY5dI/sGAlozH4RVfP2NPmlG+xgX9lGExhUlw1?=
 =?iso-8859-1?Q?cyt0bsuDOCeXWwUzpv5ruxGW3Jfvs7SFgvqi7WPfQ/ESr1pdFpdQ/VhzsP?=
 =?iso-8859-1?Q?fd8uNn/UqdG3nYD6Y0HTwXmMrCtiT1/jjAaGUym/E7JDViQan5WDxduNVD?=
 =?iso-8859-1?Q?t7sIH4k5MWp5ayNyazd++B0r/Du6gFwero3TCYc/C4+lhLPKVVGMmpQb+e?=
 =?iso-8859-1?Q?VEvYKo/ZREnzLDPwPSza4Ru7WDmNHCSuSUwJfbETHurAh0OtKuH3dv0YyH?=
 =?iso-8859-1?Q?2f9n3ZGS6kSJ2Vz7CCpA3Bb51VAb22FVYTOrnnC5Cs+hCpImTU6sobeA0j?=
 =?iso-8859-1?Q?TVnAstlz8og7DFwrG+UZT28u9kIvTT/lt7wFeKt1HLnU4mXSHTRdhnM4Ah?=
 =?iso-8859-1?Q?DjeWWx4gNFe9lH2Uudu5HWlHOyeI52id0Nyf47ZDaUeZ+i4FDlGfZYT+7M?=
 =?iso-8859-1?Q?ycXprdT4EayjqmXPg9yQNMTI/gZTp0Rv5qpUmvc5sqC+6ypYvvzVGR2TYo?=
 =?iso-8859-1?Q?VnhuH3ZxKAOT1LPpOmOwdgCGmZHWNavvBc/8wdA8pXi5iRszTACPa00E8L?=
 =?iso-8859-1?Q?4tUFHmYapwuTO4QZDqeUlsXrDGjIvf0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5096ac-6f7f-457e-c270-08da38935d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 05:58:00.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQUNyOPmPcRFgZd1lmothNc6qacS1f2Rgd21MmD5CRF1jkmbDv/7Jqs6cv/3Xe09KfpAJLS7yqdTZin9zvv5zD20mxLTC2pub5eBH2vGQkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5806
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

> Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
>=20
> On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > Add device tree bindings for the RZ/G2L Port Output Enable for GPT
> (POEG).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../soc/renesas/renesas,rzg2l-poeg.yaml       | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yam
> > l
> > b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yam
> > l
> > new file mode 100644
> > index 000000000000..5737dbf3fa45
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg
> > +++ .yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
"
> > +
> > +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description:
>=20
> '|' needed.

OK.

>=20
> > +  The output pins of the general PWM timer (GPT) can be disabled by
> > + using  the port output enabling function for the GPT (POEG).
> > + Specifically,  either of the following ways can be used.
> > +  * Input level detection of the GTETRGA to GTETRGD pins.
> > +  * Output-disable request from the GPT.
> > +  * Register settings.
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
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - power-domains
> > +  - resets
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
> > +        reg =3D <0x10049400 0x4>;
>=20
> This looks like it is part of some larger block?

There are 2 IP blocks GPT(PWM) and POEG with its own resources like (regist=
er map, clk, reset and interrupts)

Larger block is GPT, which has lot of functionalities. The output from GPT =
block can be disabled
by this IP either by external trigger, request from GPT(Deadtime error, bot=
h output low/high)
or explicit software control). This IP has only a single register. Currentl=
y I am not sure which framework
to be used for this IP?? Or should it be merged with larger block GPT by co=
mbining the resources?

Cheers,
Biju


>=20
> > +        interrupts =3D <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg R9A07G044_POEG_D_RST>;
> > +    };
> > --
> > 2.25.1
> >
> >
