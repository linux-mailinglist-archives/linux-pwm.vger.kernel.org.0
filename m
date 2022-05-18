Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F052C26E
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiERSek (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbiERSej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 14:34:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886B1CEEED;
        Wed, 18 May 2022 11:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKtcT0u7DQazTrvUn6qNa7YhqdVoxOmcvVpgMct2u2bzYikFYwG9dhuOQ2hqwpELGqJ2hZk+Y4kxu/Mkf0nAOJRbrPliQFYfboRnyU6Fa7McR7bPPgik6H20hG46RIJabjCH15g0AXhSW7yaD6jm/tuaoYsEWxv5r2qRF01Mh2p1kVmUNv4EJmUq39FF8Ic/B/ksWkG5q3dbFOmK8bamK19LKVPK/zqQcQBlTAWGn4UKpw4FYG/WCCraqtEJh0xlsUz5IGETkmjvF6HErEWQWUOYVfspE29Ow0H9O68t8uPBs8OVqcDhMERoTWTBCuWC7BIw3Pz+BYLxzw9jqKMSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF5Cx5kAWpe+wREmSWg7js6PL1qWgqxpF4ipgSFg9j0=;
 b=T5vtpKtgj1BlRzC5y16cblHpeBVyuB2Ra51vYhOZLe6J2uS0d1JwNJse3qPxGK2gOK6gDVnw8WsKVKE7eHeJw5G166VoQWQI1lNkHvOxFc4QDN+CDgrM0ZX/Sdb67a1g0C12gr56HzvLDadtY7YD0M1LxbsBzmoP2J2zCjF8Bsrg630DOay/A47/x31X27/I4UY0LK9rjX89qF1c88gw2KKG3opPVDyL35qw04bFHggOYKbDwcIgHQRe8EueuXglRDrgqzY9Cdl7sp+J2Wpw0+JWrwEXXtGTaveSDxH/atU+M+6Qvjxufm37U41xrQfiV/kz9r8zKheDzQGq0ukyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF5Cx5kAWpe+wREmSWg7js6PL1qWgqxpF4ipgSFg9j0=;
 b=YY1lo1P6EPKHXxE9r07bgnKdBEdaqQD3gmB+t8SXtFRaAOArktS3s3elfMyMyjECUS5a3/zEaevbLike9jxKiya1lv0uqauH4PYmE85vL3Iag7Dj6sJTOsWhzBSYwjSQxPM+3ASzGEF/1Hyg2a2UpJ/YXZiJO5efO41549euZO0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB4848.jpnprd01.prod.outlook.com (2603:1096:404:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 18:34:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 18:34:32 +0000
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
Thread-Index: AQHYZIA3TRVrx9T/skGzEuiCwjtE0q0jmkqAgACR+bCAANHPAIAAA1bg
Date:   Wed, 18 May 2022 18:34:32 +0000
Message-ID: <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220518181730.GH3302100-robh@kernel.org>
In-Reply-To: <20220518181730.GH3302100-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d47987-197e-45b4-6506-08da38fd0d2d
x-ms-traffictypediagnostic: TYAPR01MB4848:EE_
x-microsoft-antispam-prvs: <TYAPR01MB484867B7C95D744533AF448786D19@TYAPR01MB4848.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7PouIOn0lESFRUBiKwbTO5/Qf+vrDZ2l1PgP/iGkosLJe7L/fffBuCSL9g3yxlbR+Cqc4gYdisonR5hgLkhhId1vHArruyNXfcwHkqMd2PdeAReIX4ybpBcPIZqM6BsRbADzLU7f+HZpN/UZ87IMEInvGfkA92w6sAE4r8VRVsyEoFb51xN/sQ9/KXabFwEjer9/iDLLpbkKGB6YW6t9faQiHke8EOs3x9sTan938G8YUi3jTRfy0dNyCi31Vkgl27DkTITjSxRGLJKckO4jYuDvJFD+046bGktlEJVmat4UTgcrBZX1WblvNaCoR8eGR/keMRmyhCzn8pmGKkDU2N6KaNYAUVMHGvmOqaJjDLYkpbMiK845hC0oqjnAPkbJ1ajP04IlFtLepHqobJEXvPvzPznu9bzZQ/9TF9idLV5sb5MWxCSLJ4Rj+/hMj5MkD1YgmHc07xo+gOm1ojHehcW+Zy+omPznBQ2e39SvANv/BZFRKnFfi6hyiQe8c5CzEhWmsKsiPrAk/jU2GPZ0FSVf5R5Nu/QbsYBuLm3xcpJmuDqjs8UNXFQrbkvVYzE1gC5tKJGm//uIOUWbeuRArsurOq1B8dUPdFBjB1XROqw2N/ujzh//tW+kyrwjlIk4tYKiO6XFQMTDRPJKXZCjwX7zjYtXmWkZGeMmyAfgHA2QXTePlXFJ7iWbrZdWw/+AKeApIHzhINvUYCmBOn4Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(7696005)(2906002)(86362001)(66446008)(55016003)(83380400001)(54906003)(6916009)(8676002)(64756008)(6506007)(71200400001)(8936002)(4326008)(33656002)(122000001)(38070700005)(38100700002)(52536014)(5660300002)(9686003)(66556008)(66476007)(76116006)(66946007)(186003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4z3zz5Sa9n7woRu+Y3dCWWF1ArvwEXjEvRlsj3YVeuT+7c8dXixBr7dC84?=
 =?iso-8859-1?Q?ssiUsC45fBB4HidaWAmZa4/E2VqHXAUcyY2qCwyPddsaIjsq5PdKST9qoD?=
 =?iso-8859-1?Q?3dTYjTCVk6N3QL+iM0G3mXi+hpqzVAJME++UgQImukXVMurCn53x1oQjKM?=
 =?iso-8859-1?Q?eSyReMN2+NEpUPe86WZST0iqTDEkLjWoEuKO1A4PHQwoV9PT1lcBZpqvip?=
 =?iso-8859-1?Q?nd4fWBZmqUa3DF9fhqSAgFr06v4rQo5v8Wdi5p9sQfcmxp9c3khYdl4Atk?=
 =?iso-8859-1?Q?K71I6m9K3g1uWY79Z9VP5zMNZzLuZcEiH9Szc+8NdOga4hpyZft2gf27hN?=
 =?iso-8859-1?Q?0s/4FpmabkQWbt8pZryvaJMx02f+qvW1K9YTxaoqUmDrYZoq3/v23QJvul?=
 =?iso-8859-1?Q?9Tr1i/cb98kS8xS0RiHqWCyzp+Lv52hdsfWCHlG0/cY20Z8ymtQWhNsaOK?=
 =?iso-8859-1?Q?+Y53RNA+KZNmb5nkZpO6tDvBZJN1tdzTTNRAen5Moo4nk3qmJasnTPY3ml?=
 =?iso-8859-1?Q?0GEhktXu0srqqhaXKCuRY2eDdjwuA2OSFpvgRKF0A6fAR1J7dDY6UMi6kX?=
 =?iso-8859-1?Q?BB4v2drHOujhgtKeKXOCtVlOmq9ZMPjE64jVMW8TtVNOx83JDoIVZ2B5Zx?=
 =?iso-8859-1?Q?/eTRXz0hACbjvZpb3gs60A5gsSPqFCk8k7lNIVASvoASDgONTlbjFznNU2?=
 =?iso-8859-1?Q?G3DOtNFvDE78Q7vy7/ophuc0/o4oPh2OmGRizmh7AullWUubIlXPILKuFz?=
 =?iso-8859-1?Q?JJTEoN08tAZC2PB4+SdLcVUv2U9nXYp/voGYffpu/5Pjfs4kXveuamGONJ?=
 =?iso-8859-1?Q?bM+Rc2CCKnx/VbjlL44jfMT0N5ZeTcbDYBn2sn/lLwJoV7/8bc1e3OkZAK?=
 =?iso-8859-1?Q?o0QSO8G7PzUa65S38w+g6ZQhjnyCKbvX29IbFI04sQGdfhjtKfBNzOyzXc?=
 =?iso-8859-1?Q?g5n9o0zBD5+/Gml/j6zLJ6G21DKaFBjbipm75vHW63z56NaPdB4ZEaNklM?=
 =?iso-8859-1?Q?DSpuOg8EQwFgrQTKWDpHmdl4dGq5xnffrklNS9qo1DF4DQS1Lx7Fn6Wubo?=
 =?iso-8859-1?Q?AtIwr1Vmi7TXlpl3tbywN/Ade29xDTSSwdgmB2bXovI69mRbBDC9Ij3m/T?=
 =?iso-8859-1?Q?AnHYaVoMCZnzU/4rXU1iYBerAm8ZkwJ/W4BB2/xfDfZM3eQHm6drE3qWuY?=
 =?iso-8859-1?Q?zSnS4rWCXdZAy2hUES/rtaEypkn0CpCmMFYurkVXnIRQ5YgNQJd+/BjjJU?=
 =?iso-8859-1?Q?fFh5fZgcpUcz6wXrfvIUHvmRMpL1p8BfNeipNyWlWgWzL/Zj/yqCCUsw/D?=
 =?iso-8859-1?Q?RBWBcd5OiDaw+BodMcLEypAgYO55tsG21uguhWZkS+NUMZhf3YV0YkGovG?=
 =?iso-8859-1?Q?tuY9rDVpTdj6BqisWb2OBjWs+Uv5YW5A6L8KtbGFd8rrQ3LkJoPxWm0mmS?=
 =?iso-8859-1?Q?RznGL8Fg/65z0D7SBTemTBTcnAZYRW3VF0Lfzcdx/iOtOQJLXoyXsp5Cqh?=
 =?iso-8859-1?Q?zEg6P5eYK/Bq3yoL8kcdsibU1yj3NDquRXBd4qKZ7Pq1yIzVtu92jV9hHG?=
 =?iso-8859-1?Q?vOGkHyQq7CErjG8akBdkcf+VGVyji6g0YcNIJysLKZInHOxuf5/yrR+6TH?=
 =?iso-8859-1?Q?LyjECA49nir2XycBlnjcPzYZTk791+jqQStvBWv9ZzGzSd6jCsouZjsbZ6?=
 =?iso-8859-1?Q?GqcPhp9X55uOlTsGjKsjwL67WNrCh7zwnj3WtquXGjAYFF27/ol6X7DxuT?=
 =?iso-8859-1?Q?ERHQerPLcSQkA1S7cRJoj8x6N3MmdQU/+oE8QND70GY10i0+FbKeprl9+i?=
 =?iso-8859-1?Q?ac5QxdS9BPQHe4Ln9mnGJCzOn2JiNoI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d47987-197e-45b4-6506-08da38fd0d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 18:34:32.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nfs4AoFKbJ62/exASa7hE1mGJKadeeDssrxfLVPkmrGMjafYLNesSQJZTJfS2r/M/gXbHWFMVPdPTjhu7XDcVobs/EBk+ZjS7EeHON/HKGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4848
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
> On Wed, May 18, 2022 at 05:58:00AM +0000, Biju Das wrote:
> > Hi Rob,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG
> > > binding
> > >
> > > On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > > > Add device tree bindings for the RZ/G2L Port Output Enable for GPT
> > > (POEG).
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > >  .../soc/renesas/renesas,rzg2l-poeg.yaml       | 65
> +++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.y
> > > > aml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg
> > > > .yam
> > > > l
> > > > b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg
> > > > .yam
> > > > l
> > > > new file mode 100644
> > > > index 000000000000..5737dbf3fa45
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-
> > > > +++ poeg
> > > > +++ .yaml
> > > > @@ -0,0 +1,65 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id:
> > "
> > > > +
> > > > +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> > > > +
> > > > +maintainers:
> > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > +
> > > > +description:
> > >
> > > '|' needed.
> >
> > OK.
> >
> > >
> > > > +  The output pins of the general PWM timer (GPT) can be disabled
> > > > + by using  the port output enabling function for the GPT (POEG).
> > > > + Specifically,  either of the following ways can be used.
> > > > +  * Input level detection of the GTETRGA to GTETRGD pins.
> > > > +  * Output-disable request from the GPT.
> > > > +  * Register settings.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
> > > > +          - renesas,r9a07g054-poeg  # RZ/V2L
> > > > +      - const: renesas,rzg2l-poeg
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - clocks
> > > > +  - power-domains
> > > > +  - resets
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    poeggd: poeg@10049400 {
> > > > +        compatible =3D "renesas,r9a07g044-poeg", "renesas,rzg2l-po=
eg";
> > > > +        reg =3D <0x10049400 0x4>;
> > >
> > > This looks like it is part of some larger block?
> >
> > There are 2 IP blocks GPT(PWM) and POEG with its own resources like
> > (register map, clk, reset and interrupts)
> >
> > Larger block is GPT, which has lot of functionalities. The output from
> > GPT block can be disabled by this IP either by external trigger,
> > request from GPT(Deadtime error, both output low/high) or explicit
> > software control). This IP has only a single register. Currently I am n=
ot
> sure which framework to be used for this IP?? Or should it be merged with
> larger block GPT by combining the resources?
>=20
> Usually, IP blocks would have some minimum address alignment (typ 4K or 6=
4K
> to be page aligned), but if there's no other IP in this address range as-=
is
> is fine. The question is what's before or after the above address?

As per the HW manual, before GPT IP block and after POE3 block(Port Output =
Enable 3 (POE3) for MTU).

Before=20
H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT

After
H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3

Please find the address map for the IP blocks near to it.


H'0_1004_A000 H'0_1004_A3FF 1 Kbyte SSIF ch1
H'0_1004_9C00 H'0_1004_9FFF 1 Kbyte SSIF ch0
H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
H'0_1004_9400 H'0_1004_97FF 1 Kbyte POEGD
H'0_1004_9000 H'0_1004_93FF 1 Kbyte POEGC
H'0_1004_8C00 H'0_1004_8FFF 1 Kbyte POEGB
H'0_1004_8800 H'0_1004_8BFF 1 Kbyte POEGA
H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
H'0_1004_7000 H'0_1004_7FFF 4 Kbytes SRC (Reg)
H'0_1004_0000 H'0_1004_6FFF 28 Kbytes SRC (Memory)

Cheers,
Biju
