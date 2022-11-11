Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04C62541A
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Nov 2022 07:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKKGv3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Nov 2022 01:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKKGv2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Nov 2022 01:51:28 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995D729BB;
        Thu, 10 Nov 2022 22:51:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPezRJWo61SGgXN4CmhiMjf2fIfkHvuVzvYp8mBTp7ibQQ9tI1sobDonPNJRbnnQShZYhKzY52+I3DL557anXqrY9ndCyX9n2n5HqNtNns8NqrDHqBpF5/GYOt4bT7U35kJ7YvYxxsfNhVZcTXWGGkCZ921Zxc4ZrQfe1DzZ6aCugNhfUk9+C+YTxmgF97U4Ds/YcDo21TCtOOBe9ZHFSzGdAHm45INnbXfvmCntliRMLn40zdQiEgPhz4rSHbJp3VzZNxGBmhKZersPmfFQS+QYKs8CxQ8KklEc/fevZNQA7ewxTfcrs+lGoPJoEmaLRcaC++wMqWyAJGLXvDlV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYEq6/jL05KDVBVZW/B8/aZnD0dWPoAgzCn1eW3IwFU=;
 b=Vyg9h9U0x5gMKN63ypbKrtl/42SAXOEkgGs8O1c0UK0qThxzOrikN1wzYpeJdOHsbQlz8uW4VKlN+4YArRNfqdU+iey6IM+LxBUA8tnxaXHOqjkTJzqRJH/q3aoM+X9E4xZf+JlQLnTh2T4R10e28yXAtqSrRkvyJxORqhDc63oSxproEXbLVzC93Vwn7bExFbrcbmdlQBsmPYNTcpjpAptgrlZ5m+NiKTFq0TYFTShMCSoEdSvNde3EtxJGi2JvTr9lE5qL+auzhqI/9oQmxf5GC1RyNsKxKAq/p0+TTNhsRfi4kW3vbSPjnkBxFK3/5iQaQAXDXYSiBwFK7uSWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYEq6/jL05KDVBVZW/B8/aZnD0dWPoAgzCn1eW3IwFU=;
 b=j+9uiT9NN/CK6K7FBkthH/fiTIzTXEX3r77BCVJPXbYuZsk1ShPAr2UqL0cFkMY5G2LADmrfZjh8zPQ2MzJQytR/r09FnKrcMZlWHIqeVLhguyzUu9eGdkdn4q4eMP8wTYAfai94ym1dfxmK1i8QOtx9shYsIsE+ZENTFbyyAzk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10600.jpnprd01.prod.outlook.com (2603:1096:400:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 06:51:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.014; Fri, 11 Nov 2022
 06:51:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
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
Thread-Index: AQHY8GDgOqjpImU8mEOSDENTsbjw7a4z9m6AgAAEDYCABVidAA==
Date:   Fri, 11 Nov 2022 06:51:24 +0000
Message-ID: <OS0PR01MB59228C8E7FB0F8DEBE25624B86009@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
 <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
 <20221107205749.GB1610785-robh@kernel.org>
 <OS0PR01MB5922720CB4C05C5CC8F6DE20863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922720CB4C05C5CC8F6DE20863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10600:EE_
x-ms-office365-filtering-correlation-id: 4d9b5b55-71d7-4344-df24-08dac3b1266d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpodwPqVBwqB3KXr4gNHRdXv2u8g/eHOAqIaAM/PgatwqnibRnUVdg9KTT4jnCvN4zALtoD68/kIYvaJ7oYYW5n3GNXqH7PEHcvf6nPMhzEf8NrJPzbrYuryWz39OK2NFdVSVEq8ysb8Zys/m5PFlRMzKkAV6Y8cQxfThhIU+UcNhlv/DbBg/MxkdyzVcch7GYfk1e5JKJwG5bOb9G8LtoG6IDUzN7pZliTBNJIXBq2P6QRe+3roe3FFYv9ckgXUi+6Dd+TO8GtQiiolvkonoO/qWyYp/1/T5y4EA1xTE238gLNjXy1RMtSRFULtHpZPhVjHgGR37otmwzauj1BcZQQLletVSTj08175g+T2P6WSU1BZh2IPDCqU+vPQz52QBtxLMaD8a42zXwWtr4cFE+E2/pfLLVF975os7ggVLYl+I3R4cdWQN2noYe3Fi9WawG1LR34z9ZzriNpHXRzmjCK/o0xkyzv+TxCyqEbuMqYKdyMtsBgry7TeAvB0vLKhU2kx/2OCgHMSMJAcXBWCkeseXnQZGBbOlwpi8mnmRYhLJIuuY5ZjTjdmuImvDlmXjkTU73AL5oSc8gzc8SbSlfV/pzVea41RXP6z3qilZKkE++DKnUmcxZMzE0UKb14XuXmhj/v4NQA0FFksA3HpZWnYyZqGjtKkJkndJpsOUosz6eQcLvm99vlLVg3SF8cqxi9iZ6cU6u3wLE2KdTNH67WPNdUPanG0YrNPM7PB54L5Y7kIk6q9Mv8BVo8ZUJ9q8Obip2U2A8eB3372bXb3wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(54906003)(316002)(9686003)(64756008)(66476007)(76116006)(4326008)(66946007)(38100700002)(122000001)(66556008)(110136005)(66446008)(41300700001)(8676002)(83380400001)(66574015)(478600001)(2906002)(52536014)(26005)(5660300002)(38070700005)(7416002)(6506007)(71200400001)(33656002)(53546011)(186003)(55016003)(107886003)(86362001)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dsskn/vG8zlSNWf2D3L5uz0bdNcVyiel8Od621qllHP7kDSSBCsPH4Of4P?=
 =?iso-8859-1?Q?Zsf/wx1Xf3MCoEGFvYH4kDBhgkSpvpKpPm/urMpyquEjP2qd/0V0i4XP/K?=
 =?iso-8859-1?Q?Zmr5V/VxIjwt2Maqmioy0dUG92CQyxl2hizUHodhWn/MO2rI84BnoLVkMk?=
 =?iso-8859-1?Q?DLlRbVlubz/6hP+sT6UIThH1PgZcpokxm3SOlJNA9We29XDuK0M8aX8Q0K?=
 =?iso-8859-1?Q?5T5rpwfXrT0cXf8AFYbor7FbLBJRcVlZnV6qGKYFkYzV1vw9XWcw1XRB/Y?=
 =?iso-8859-1?Q?Z6jwTQwxQwcvrDju52h4ts6qpSlktDnQWpr92SOV4v4WdolypM8nwxQbvp?=
 =?iso-8859-1?Q?BGSJvO1HbaZqMVerpM2lgwoAZaZNlFiqjxEoPsWPXioz5kapaauu0Ploig?=
 =?iso-8859-1?Q?QBfq5M3TPhKAO3ZXBMVXKFiHrGJpBL0qyaDnVHPCdNAYg7K48vBh2UvRsW?=
 =?iso-8859-1?Q?0yJPSgcOxWAGMXyR0MIb5toAVP6fyzB8P6SU9/4ktWn9O/6xKIVazyG6d8?=
 =?iso-8859-1?Q?dLgHGyZE5Kg0KWe4LfDf3pPOPxxVBp0kwjBX4iqKLJCvSEcnX0uGLTBFDP?=
 =?iso-8859-1?Q?V3xWrSVRyW8RyKqZNKAKIA21+0u98GFv9kgZ8xSgo8l6bUHqwvTVXLAUQs?=
 =?iso-8859-1?Q?eRMiAARdpIhSTHFwFe6ddLAiu+BZwzTSAUECdcaodcD5jhY15ag1iuBzHj?=
 =?iso-8859-1?Q?uyLkMJemOfklwn+2PiSZvmFJaLje9gN+XCP1Kyj38ICYPpPphXOrPMQnri?=
 =?iso-8859-1?Q?sBD32PwwkT7eXl0H97nxZFhm8oIqTBWV4RBpq/Tl13H30KPXlX9qqUl1QM?=
 =?iso-8859-1?Q?NdAedowlgayd9JrA7XbJiyMBfiBzOYRKCK6dDNzDGnKZvMgegRk94/XWMZ?=
 =?iso-8859-1?Q?IkR7rsFo8h2r7Jgme8xA3LfCCS7GX7VnArgBY6X8/QJ1sCbDfpa8lH2UKm?=
 =?iso-8859-1?Q?AE21Au9ciowravRI1bRnzWlk/axK4xapAB8fOey4N8idJI95oxQjiYrgm8?=
 =?iso-8859-1?Q?wPLELT3ATz2Yz+rpMMdOg4e6sYaXLM2GSP/AFfqNwk1ZiMZ4YoqWLqpIaC?=
 =?iso-8859-1?Q?oNAUit5JEavjbO+X2qGnakoxNARTV4lbZ+ebtZNqJUOGZUKG4OgBWz+YtB?=
 =?iso-8859-1?Q?7/xtn57nWMTpHiWze9WKqJDd8NCq9mkzCTZHo6EzorT/kNjlK/42ZFxTsr?=
 =?iso-8859-1?Q?vWuCaTpFb0aKrCCGCouCnABB2jI/UZ7guv6JmVyV/nMRj4VN1lmhoNopnI?=
 =?iso-8859-1?Q?5X40X1ihenQRaETNDE5achODUYdzUU5w7y4f2a4RI0JzlhAe0EVfLU8pn5?=
 =?iso-8859-1?Q?Rc2Uh9dgdjRuODdBmDsXOJBevRER+22OtX0uTUJqjd8/dHCfHE5ZMWLxb/?=
 =?iso-8859-1?Q?gXgvwkcT8ojWr5e/kqwsaYpHNFZIA4Tf95QKuwsehkJh+TP5gaMD1vWB01?=
 =?iso-8859-1?Q?wvb5HmJ7p5PZGNAZdEgS5dgeJu7aZCsC6wQMWTqApwgNj31aLYiRfgA7Ic?=
 =?iso-8859-1?Q?0sovIpyyuXBzMXcDmV5U/76ExWLYDcOMF4atmU+GjMMTJkYo+bZ9rYvjKc?=
 =?iso-8859-1?Q?VTKG+cO5lag0odEmm7fuPE6mQXClSfjPaV7UWvwkdyBb0W0E5WJAvsAjAl?=
 =?iso-8859-1?Q?QIsX2tHkrztHNSI9BYJpiTJQTwbDr6dpKQBOJ/JgWFcEf2XpidfMyaRg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9b5b55-71d7-4344-df24-08dac3b1266d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:51:24.7240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPbkU8dQr4PZcA9Y7QjiMhVwkvdH164AaWJ5hWgm8Q7nS5Mchdg4yRpb3H6nyKjoXrNCkWjUYv1/HLAQqIJvRLgOx3Pf8bwv97fpV8NutMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10600
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 07 November 2022 21:14
> To: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Thierry Reding <thierry.reding@gmail.com>; Uwe
> Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; linux-pwm@vger.kernel.or=
g;
> linux-renesas-soc@vger.kernel.org; linux-gpio@vger.kernel.org;
> devicetree@vger.kernel.org; Chris Paterson <Chris.Paterson2@renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POE=
G
> binding
>=20
> Hi Rob,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L
> > POEG binding
> >
> > On Fri, Nov 04, 2022 at 03:19:34PM +0000, Biju Das wrote:
> > > Add device tree bindings for the RZ/G2L Port Output Enable for GPT
> (POEG).
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v2->v3:
> > >  * Removed Rb tag from Rob as there are some changes introduced.
> > >  * Added companion property, so that poeg can link with gpt device
> > >  * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
> > >  * Updated the example.
> > > v1->v2:
> > >  * Updated the description.
> > > REF->v1:
> > >  * Modelled as pincontrol as most of its configuration is intended to=
 be
> > >    static.
> > >  * Updated reg size in example.
> > > ---
> > >  .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  | 86
> > > +++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> > > b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> > > new file mode 100644
> > > index 000000000000..8adf01682de5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.y
> > > +++ am
> > > +++ l
> > > @@ -0,0 +1,86 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +
> > > +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> > > +
> > > +maintainers:
> > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > +
> > > +description: |
> > > +  The output pins(GTIOCxA and GTIOCxB) of the general PWM timer
> > > +(GPT) can be
> > > +  disabled by using the port output enabling function for the GPT
> (POEG).
> > > +  Specifically, either of the following ways can be used.
> > > +  * Input level detection of the GTETRGA to GTETRGD pins.
> > > +  * Output-disable request from the GPT.
> > > +  * SSF bit setting(ie, by setting POEGGn.SSF to 1)
> > > +
> > > +  The state of the GTIOCxA and the GTIOCxB pins when the output is
> > > + disabled,  are controlled by the GPT module.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
> > > +          - renesas,r9a07g054-poeg  # RZ/V2L
> > > +      - const: renesas,rzg2l-poeg
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  companion:
> >
> > Also, needs a vendor prefix. The companion is the GPT, right? Perhaps
> > 'renesas,gpt' instead.
>=20
>=20
> Yes, it is GPT. Will use 'renesas,gpt'.
>=20

OK will send V4 with these changes.

Cheers,
Biju

>=20
>=20
> >
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: phandle of a companion.
