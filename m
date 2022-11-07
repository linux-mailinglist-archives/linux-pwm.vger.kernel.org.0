Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26E6200E0
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 22:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKGVSQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 16:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiKGVRx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 16:17:53 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2131.outbound.protection.outlook.com [40.107.113.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467812E9E0;
        Mon,  7 Nov 2022 13:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyICt64xNWB6DOlCllqoP6caiTtzYyD4lhHyli/ayHmdS3vul+3Oam4jDMKnncl7qiyg8Uwgu9TTvE2VsAxJFDtkd1TmRXOsxsak8oWHkAwjyopd9XmpDmM9yy6TYBkwxRn6N2yl2YauR/tiRWJG8o6pkyDEJokEDKr84F5fT/EGs3ERj7HIgcDxHqmujnx0s1GbzR8EZqTPC45a01TA+cTtwWr42AmnOlzsgiKmieWVOVSevMbLZda0DAh+7DDvbzBaK2U4VtJtZ4l4tBUCnusMPB6NbZ8RtBYjFuI5t9pCmzoOGxtQa1NFFgHP6LW1X86b48KwjaWPBDo0WJ7xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWmActJ8X4p2cuT9p0rK8Sqoh/FOkDgYeCd/PhPhD18=;
 b=UDhJEQp1RQ7YKpXoPKlIWentjNqFNvSFcOCa5gAkq3tQ5sbEULXnHvcPi+vN31LbUlYdBOW0jrrxB1Kb2grKvaYIFQr4fDAF6IOLEB0wFxk8mb/tgkGzh5jTOi5RpTT08fguYyz/sMhb4kf5kPFQuA0BfxtjWoZZbmP1Hl5FLfPdoi7Aq3CX3H9muDy/BnZSvBzytyA5K4eSNfyoH27iiwSQKJ7I4BAFGYI7cmDRBQ/8bu/CEWsmz2JuLm2m6nq9xqHxbDZ6sWYOZOYwaQdBXIc7xL++ux4y+05PvHQ7ikk7zNQwdKh1mKEJFoXbCw+zyMhjRwHLV3qJdA+t5zx2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWmActJ8X4p2cuT9p0rK8Sqoh/FOkDgYeCd/PhPhD18=;
 b=XOiPJQB91NlOWBJfePI3TOvMOCA4E3S0RlXiHew7ttsdUHS1E597PV0inXNxgeSGhvm3tvTmjz/o3/zGPSEGHSQr2M++OGqW92f1V4NYtIpunHakkSiaxVDKIScL7XaNsQdtaBx9IreIeB01ypjj2Bt/luH74w12PSeI+P2DBtU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9809.jpnprd01.prod.outlook.com (2603:1096:400:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 21:14:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 21:14:06 +0000
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
Thread-Index: AQHY8GDgOqjpImU8mEOSDENTsbjw7a4z9m6AgAAEDYA=
Date:   Mon, 7 Nov 2022 21:14:06 +0000
Message-ID: <OS0PR01MB5922720CB4C05C5CC8F6DE20863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
 <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
 <20221107205749.GB1610785-robh@kernel.org>
In-Reply-To: <20221107205749.GB1610785-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9809:EE_
x-ms-office365-filtering-correlation-id: 797fc311-f28b-4aa2-d10f-08dac10500fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzrZNfe1BqBpHXqk4JiLmXEClc4taW6ebmJpASYvtH3i1zO4YArS5qUWNKTEfDpUz+mu/ZPLG+E0AGWhPND+y4MXvAp7WtrUvfjKiczG34xjVVbMXBE8rnM4UlMeV0eyy+4ylJcx9ws++00cFhB4E7bR3utMh3qVr2O/msnsNe9RAz3caijBf//bKSVmGzE5iR7q+4re+lRPKMS7YKD1Aw30k9D5P0bO4PjxEz/FYGa+2KzzYoPNkgf6CmFjcdxhhiax2gtTpETAv3uev6sYm5LiKOBaeSrZktNWvpXb2BS/rozbI90ysikjNrRFxwn6qXoZaPBimj0IreTJYHXbLdelj6+VuONHSY19KVr1IGoViEvl8p/UrHJ8Q1E8AwRh1RqWQbDRCNhft7O41r/r3TsAcBkDX7QagZXONggpKn+PoPateNy1kIgEwiZXjaLow9FJ++69WSmjRMwg+vS4p/yNH7pvUMS1KJgOY4E293865AdY5TvRUsLuXIHacwecWREJLNj1seOp7RGGvck0MkWUmMuFb9Pizo1jvdfHeVtA+l9/3gbRNBG8RTZ4NSefiIH0M0ukMmmQKS9VRctyHUQuxYtzDMt3Ync3SDepoNYOv3KYct6mnmD24l89vTlNnGu0xkcT+9ky38vW5qbG/s9OQ833CkJ3kKW70iK53WEzj6T2ft5iA3hpFC1pIoNIK2fjd+uYkCp+Fa33Zqi7sXXN3k2TvZgZKrIU4CHiDSeiSCYvOP9Lp9GcevxnDr6z79rAOMKr9F0CKdW3VvA/Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(186003)(38100700002)(122000001)(64756008)(83380400001)(52536014)(86362001)(41300700001)(5660300002)(2906002)(7416002)(4326008)(8936002)(8676002)(55016003)(33656002)(107886003)(9686003)(26005)(478600001)(316002)(54906003)(6916009)(71200400001)(7696005)(6506007)(38070700005)(66446008)(66476007)(76116006)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T96euw2qo0iCgkGLS5YBgCosIW/BerJiw3q9sFiA8JQGMLatR4bTffT/k4?=
 =?iso-8859-1?Q?PzZr0YMk0c+++HJW34+oM7UGrte8kb8tLPqRyjJrBKQVpwnJ1OJxwZKzNN?=
 =?iso-8859-1?Q?yeMtYjQ6IizV5QDPMQlnSKQsJISUNRXj/c0GA8NOCJOdBl8TVW4Y9xF9G4?=
 =?iso-8859-1?Q?bMWyuODcyGpxkNK5yBCQQmqea+ayrobFT9iFV6gQ7Z8q1HkBiHy8oNqb7E?=
 =?iso-8859-1?Q?tn9tqtVFNRmpjnVWNu3AG3pH+f7Q1Qkag3zRdR6fC6aaFqsAtju6XH207I?=
 =?iso-8859-1?Q?ZTCaXaEGZ2m0xykMvQFaDWM/7iQCCr+Hk7syH9cto0kEJYPTgoLiUbecUD?=
 =?iso-8859-1?Q?04wD6MuRIMYIqU/J1h80zxtQV62pc4i7c07k0m3kljKwiNTPFdJmxb9sex?=
 =?iso-8859-1?Q?aNZ/dL25HikRYIKzkhXGtjHkBaQarbY2z0294mM7zVbUCpm4gbqqpgR/7+?=
 =?iso-8859-1?Q?xk3QMPywZq7kVnnagutxlCwHzdIgpICNxBZ1483Nlsy394PV3Rk2Mrfs9Z?=
 =?iso-8859-1?Q?MakfI7MQvRUXhBl+TWrVyB1mCwuqpDqqy9XH8UBc4kC8fde1tF82ipReFP?=
 =?iso-8859-1?Q?djRfZaIB9kwc1SpnHmkaa9Hwi8gzDCKEEKlG2qPN5FssB0YxJI30hze4Ky?=
 =?iso-8859-1?Q?QhjWbVxeo3qrDz7Qe5vzysJdmQKwlfJMwjhxWdx8f6dR4c/NK7KqtTB01h?=
 =?iso-8859-1?Q?8/3R2eX6Qw9nHvE0vgo1UEc3kcVCuYrSO0HXQfUPFQwVF0pIXfk1/F+MAf?=
 =?iso-8859-1?Q?sUh0uG+TSP3eg39FbUUn7IFF0YE2hOITpFztG6sw0zMVZ72ewOIgSWSw+m?=
 =?iso-8859-1?Q?0ppjUBUgh0GdZ81a1OfJ7ya5OxGJHvoKKfIxF5Od8a7Ub5FWkkrUuzW6ge?=
 =?iso-8859-1?Q?1nWDKr4oOmSzjxkLQ7YyO6yC8UZkTlvkyP6hNIz1IOFx5+5a3oV48oAufm?=
 =?iso-8859-1?Q?1XQevEcYfhM93sIEg8ntJm2wqYMrXPn9aMK+Ird3w6b+A/FeVBs0fR8rqS?=
 =?iso-8859-1?Q?ZjZVYrTZq7vf0GEqQv9mG/vf5cBbTVNWvq5CxMaSkHHz0pFMFKGiHYtv88?=
 =?iso-8859-1?Q?z3g9uxJBxEFoSxIvtHChNM9+Ewm+V7mYi4FLvPqTSwVP0MSTOJWDJOckJu?=
 =?iso-8859-1?Q?ms9qH0QmXa9d5Ifig55bcPfZ9n+v7V0/Vh8Rh8uGr3Mr0y5Ux2mDArbQZV?=
 =?iso-8859-1?Q?+xtHzsGDZI1OqrQ25p/MqX3J1Qhk7oE3moNrEM3tsZ8np+kwOK6MXQsgRi?=
 =?iso-8859-1?Q?9ILB9OMclTrdTOZX0kTcft56fUDPlbGGGfVNRv0Or0RrTO3ztnFlHklIcj?=
 =?iso-8859-1?Q?onRhR9sgYTOOM/rIyqLhmWTTbDNAQpsnDOZmYJ4qcLDE/n3g4R0aEnby9e?=
 =?iso-8859-1?Q?dfL9jF4A3qkJ3xCEaltikePDvMmVW0pYRRP6YZSGxq15TlzT6c2oT5z26q?=
 =?iso-8859-1?Q?q2CirE6HAIEsxpj0rJHJCXzo01TQDPLnWbPraEmUsC85qs6bi7P1wrJXdJ?=
 =?iso-8859-1?Q?i2MGnDd8vu1PnsgUV2iuiazIOcO0ITBmSy/PXWAMYHuav6u6VqCSn8KB2P?=
 =?iso-8859-1?Q?mDr38RkNUsMoMhgTlzkuX15NcYOCP/8600OTEG36fc2kdZIqj+oRcz7uSZ?=
 =?iso-8859-1?Q?FK/pSKY5ZtVNUhqcp9m6s0w46y2oZsrgsKY6YCWxN02OLh2LgcES/Kdw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797fc311-f28b-4aa2-d10f-08dac10500fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:14:06.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhvEER25lCJBK+Sd84Saqku6UZ/qUlE+1ZLoN67V+Nzj3SDHu2BsVyc7AC3klPgSd5+BIDpzsqJLXpzQ4s7kNHRU5LGG7TSOMbR3yrF08o4=
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
>=20
> Also, needs a vendor prefix. The companion is the GPT, right? Perhaps
> 'renesas,gpt' instead.


Yes, it is GPT. Will use 'renesas,gpt'.

Cheers,
Biju


>=20
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of a companion.
