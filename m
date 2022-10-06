Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9695F623A
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJFIEB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJFIEA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 04:04:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEA895D9;
        Thu,  6 Oct 2022 01:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ2wtzObMOOOIHYRwGAmrYhWFnEToElOL//NmcpGHxCefmhoj8OG7peUrhCURzTIIQn6W27UNFXSbEsWAfBotMORCwXtWUwx++TfsxZBRF6FxO2T8l+5+0rioTLijMyEJh9NkmDb8rhHYW6YsRrLHgfLcTI/hagHbP0Ve+tQbXgNUBBmsN/DeWnk5g33ysCPRP96GLk13SO7sa8OCeJ/PUhSNt2jyUADIQMAIo0+VeVfdup4CVfUxU4RCDpPxkx538HqFcY04tLwJuaf+n2qjCbGTTtrR9eWKBUbR5NralQ8yruP6bbegdT4QIN7w73N/S1Ok7F0czqmK4VhSCrSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1A1z5OjDQVp/J2ClqdT1LqBJqQzKT73io96Q6mYqiw=;
 b=hJPQS0N/M/+nPNMWYmHB7j9wr9WZ9eKBCvL/5Pov0vEjRcCz9EgGW30Phxkow8GKHc9lVldw+ATGp5d5Iobaaz3i4JBOb21gUkrlMZgkG9Zkjq74K9dv8a2LeadB2f908enq0+zt9I6QHIxBXRm31BDB9UiViIGOFAdf0m8kL5/KZNWT0254t1YzwUW9corUH9cQeEegs76tDUfSJ7OXIdzT3yPPALEE3kM30i63UumM9Y2z/EgtQHZ7MEsQgl0hlPnMceqIm94yTtGFmeEyoOafaJ9sKmYvrgjlQApRdpN6xifxfc76QJALKSjI7XYfh+90RIq2uB75tBb3p7vhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1A1z5OjDQVp/J2ClqdT1LqBJqQzKT73io96Q6mYqiw=;
 b=kELmNyJ09VYLdP7UTE2MRsmxaa+mDf/gpA/3dJSIsZm3l1OuKSlwpsJWMNBY8r5uQBYfvDLT4PALO7fRWvDw46a3oU4IwRxtbGLgpLZDsrsNmArab+vJKcRHE2OYZru8YVRFBuwVoFNN73NG71tLoWiw0tepQgua7qBFc1Q2vU4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10041.jpnprd01.prod.outlook.com (2603:1096:604:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 08:03:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5676.033; Thu, 6 Oct 2022
 08:03:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH 1/3] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY2MIiKyhG3eedU0iNFBjm9x79Rq3//omAgAECx3A=
Date:   Thu, 6 Oct 2022 08:03:52 +0000
Message-ID: <OS0PR01MB592267C7430A9BCC21AADBA1865C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221005135518.876913-1-biju.das.jz@bp.renesas.com>
 <20221005135518.876913-2-biju.das.jz@bp.renesas.com>
 <ea77fa9d-d579-b517-7b47-e6765d1a3492@linaro.org>
In-Reply-To: <ea77fa9d-d579-b517-7b47-e6765d1a3492@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10041:EE_
x-ms-office365-filtering-correlation-id: e690e4ba-280e-43f2-8a30-08daa7714f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTeTd57NRFhXIRgiKfbeOjltT2KiPXVMDcS219U2CMD9rA5kfBh874qz8v3WnAfqoE7Mt8fGerehxXarh4ZmI+yW/FZCAXo85TNcFo1BdWTGLLk0mPs8AH6sK/rk6408ChzxPSh/+eDSeM3GWjJHw6jFTwDkXSG9MPs1EguZAx18oLT4co4m3P9FvehiP1Q2DFq77FWcY52wnHLhyT/WdyLhNeWCPQCLA1VEzgTUryXzWVPBX+t7r7VFR5ArP+ziUGyc/g5yfsFn0jRi74efxzF8XGLClYdYWfDrjvXYRd6hUOsRrVduiZzcuIXCX/ogCqw4wcyUxpYOLPeI78QjBN7lCyihMrMUcEXtA/Dsi7lAehaHAbpYihCJNGuyVEwRUNhFJ1J0QF424L7vQKYV7056jCFpEQmyt1YRTM5GghI6KZu68qTVCe249rcw0ORcSKxBsF/oyCX40SVnw2pgpacTXvRDpbXHzN4sgTTN4A9ai2Ak2OU6WUJulF9GYOykksiGEIFKlT8uhdqy1yILmE5pOz8K2cCDnG597YSwPWiijtyvXEqyRsdF25AqrkOnOunyzEwQpVFgwahC7Wh5eIO4brFHGWs2OWEpfP/f++/TczAvRoFt7jlQ9yI84FTBERD7pvcsepa09XvDQ1bnngP6gSJ9WKEhRNAz2RLBq9vaHtd7Os0fl6HX3VPQPHhT8JrYqC4e1irvtq3JpbyPunzQOMwsVCE7iXhwXaSAw5AKI0fwT0eSsdWKvMHslu3pcbPe2+ihcTtudyBP6tRWrDjd48u37evuowMIfqpdAhA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(52536014)(33656002)(26005)(6506007)(64756008)(7416002)(7696005)(4326008)(9686003)(76116006)(66946007)(8676002)(66556008)(5660300002)(66446008)(66476007)(30864003)(8936002)(38070700005)(41300700001)(38100700002)(2906002)(55016003)(86362001)(186003)(122000001)(316002)(71200400001)(53546011)(83380400001)(478600001)(110136005)(54906003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8SeLUM2GTCyMg8voCeVSr0DmgzbHCR80d57G/X1mJVS4S6Axm/idxH6kkG?=
 =?iso-8859-1?Q?gaMU4SCN++xPoCyIhcIfO9+iYgBbZ024EG7ZSPy6SXIrRQu5YJa/7PH5eB?=
 =?iso-8859-1?Q?5d4OhV5eJ0KVJaWqcd+hCBtWmFlqw3PRU13xh8hvf901QzScJfo7ZM941p?=
 =?iso-8859-1?Q?10gnf/4oXwpeiqGEWDhEOAtKj1b7DqetXnpcQAX4MoIfXdDCDWsc95NaYD?=
 =?iso-8859-1?Q?q4Ffm0mEPI3hrhzEChksPwgi/LEMvTKHKWSYOhRzDIZpGnE9gxR8jfbjar?=
 =?iso-8859-1?Q?nJopaXD9cQgYE0yAH6cSSfAZ0WGBnxdzahNXdK9JlV2Tib7Dc0d5Nv6eoM?=
 =?iso-8859-1?Q?9uIhjXE3HctKSgzyefWa7IbJVRDftc8G/9umBOVd0rRglhCf3w1eVC9BqT?=
 =?iso-8859-1?Q?Cpi4yvms7b+vcVE9kjtdIUwXZW0+MJknCIcrAOHr6lLqoGD5YAfMhkpVmU?=
 =?iso-8859-1?Q?phh0uziY5aTNChBEj23IoAo4MHmqpvm3U04TMviu5NYk9G991/c9TLaRks?=
 =?iso-8859-1?Q?Ph0srygv3FGqkdVdUvI2vU6nSZo2bXktyudQ56oaE7HFVJSDh0fR0DsYxQ?=
 =?iso-8859-1?Q?RstqYMVt52kVRpxlCAAZyGM4OCxHx+xhkUxR910R9Zxhvvwq2yF+DmJGLQ?=
 =?iso-8859-1?Q?4F11ANGNj+GHJ17biF9virOakYFq4u7EAXkZeF6YMAZDVS6cSDte/ypPft?=
 =?iso-8859-1?Q?fj5+8yHyqpQWg1iTrBL0SjZglJCOjGfvaj9+hSRM5Tqk2BeBRd9420bucQ?=
 =?iso-8859-1?Q?dACpPvQ48PoA8z2fUOgOxfjjlo7tjSs8L7umm/7Fk0GXDkqZ7h4QmpKXJJ?=
 =?iso-8859-1?Q?OAn/uCrHKBPdbL0UbrjPFTpPaDZCeF2FEGWJstempHxA+VBvFHy9PGVZn4?=
 =?iso-8859-1?Q?Yhmemnx8lRCqd75FYN198Y5xxcOG7SAeeiDIY6hGgTh2K49LkBz4w+/HFM?=
 =?iso-8859-1?Q?yIO8D1u6x+6Gt525ula7JIyprzHpG7Ntr3LFf+YNuAhy7tyvKBD2jR7zzQ?=
 =?iso-8859-1?Q?eZEGmE1GlyN+0vrWt22lPiNKqNSIYnSvrmA8icl9P39CLqIVC8FVCRJO/w?=
 =?iso-8859-1?Q?dqu5+VmjoY9F0MrE6YH7eUqjdXDyYHJIyqnEnzRdPQMEu4SxnANps+EA6P?=
 =?iso-8859-1?Q?X3wvDgAKPersEdOpg8mKBVV3GAuDWpk3J70hJHyZO5HRTOMYBQPQD2ghtY?=
 =?iso-8859-1?Q?Zp03XUdYVcrN9jZXnur0NsX7aYM7qucuNqXhP12QPJcYxYR7lQDpEIf2bi?=
 =?iso-8859-1?Q?okGkaiiY9WjhP//QHAXgf1OgasAsKD7fApcDfJMkyOLzPNCc+aNJy6t7Tb?=
 =?iso-8859-1?Q?2tyzkH0oy7I64cxpxOPv6rzOCcFKgvGl6rYOE8gYhi8BhUftVxseEmfd9R?=
 =?iso-8859-1?Q?wkFvav0RLm0IoB52gsPBd4hGj+nZUeFkn9YNiGAXcC45PXBF9lVXD9Qq+3?=
 =?iso-8859-1?Q?7PiXwoBKfLkX7E761EUAH4YL66cEWCFEWfAETWh1ibWZ+s+jPer4BQSExe?=
 =?iso-8859-1?Q?y9TbgwfVjK7ikj9PboV8+PXQmOkyPtVD50px22b5v+b8kyZL4fRIQboS7/?=
 =?iso-8859-1?Q?7WriAz3H+40atFFVdyIXpX4R1juUAaAwsqplPrW+4RglM/yYu7vnJeUhuQ?=
 =?iso-8859-1?Q?mQd3fjF0FxHYi71oPSAiyhKUA0UYHfhVTH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e690e4ba-280e-43f2-8a30-08daa7714f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:03:53.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RV0uVL+CCNJ3dTt5zlyZKb7M+vjir99RdkqAup0v6u7X7feuN4Rz9q+nKy7MLSqDL7PSQqW4BbGdvmNfTFb4HNR+Tq6io29gPTYEx4QoZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Krzysztof Kozlowski,

Thanks for the feedback.

> Subject: Re: [PATCH 1/3] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> On 05/10/2022 15:55, Biju Das wrote:
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > RFC->v1:
> >  * Modelled counter and pwm as a single device that handles
> >    multiple channels.
> >  * Moved counter and pwm bindings to respective subsystems
> >  * Dropped 'bindings' from MFD binding title.
> >  * Updated the example
> >  * Changed the compatible names.
>=20
> RFC is a v1. This is a v2.

Ok. Will take care this in next version.

>=20
> > ---
> >  .../counter/renesas,rz-mtu3-counter.yaml      |  30 ++
> >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 290
> ++++++++++++++++++
> >  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
> >  3 files changed, 370 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/counter/renesas,rz-mtu3-
> counter.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-
> counter.ya
> > ml
> > b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-
> counter.ya
> > ml
> > new file mode 100644
> > index 000000000000..c8b86ef254b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-
> counte
> > +++ r.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> > +
> > +title: Renesas RZ/G2L MTU3a Counter Module
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  This module is part of the rz-mtu3 multi-function device. For
> more
> > +  details see ../mfd/renesas,rz-mtu3.yaml.
> > +
> > +  There are two phase counting modes: 16-bit phase counting mode in
> > + which MTU1  and MTU2 operate independently, and cascade connection
> > + 32-bit phase counting  mode in which MTU1 and MTU2 are cascaded.
> > +
> > +  In phase counting mode, the phase difference between two external
> > + input clocks  is detected and the corresponding TCNT is
> incremented or decremented.
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,rz-mtu3-counter
> > +
> > +required:
> > +  - compatible
>=20
> One property - compatible - does not deserve its own schema. Integrate
> with the other one.

Yep, I agree it make sense.

>=20
> > +
> > +additionalProperties: false
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > new file mode 100644
> > index 000000000000..0413d22704c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > @@ -0,0 +1,290 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> > +
> > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  This hardware block pconsisting of eight 16-bit timer channels
> and
> > +one
> > +  32- bit timer channel. It supports the following specifications:
> > +    - Pulse input/output: 28 lines max.
> > +    - Pulse input 3 lines
> > +    - Count clock 11 clocks for each channel (14 clocks for MTU0,
> 12 clocks
> > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2
> combination
> > +      (when LWA =3D 1))
> > +    - Operating frequency Up to 100 MHz
> > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > +        - Waveform output on compare match
> > +        - Input capture function (noise filter setting available)
> > +        - Counter-clearing operation
> > +        - Simultaneous writing to multiple timer counters (TCNT)
> > +          (excluding MTU8).
> > +        - Simultaneous clearing on compare match or input capture
> > +          (excluding MTU8).
> > +        - Simultaneous input and output to registers in
> synchronization with
> > +          counter operations           (excluding MTU8).
> > +        - Up to 12-phase PWM output in combination with synchronous
> operation
> > +          (excluding MTU8)
> > +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> > +        - Buffer operation specifiable
> > +    - [MTU1, MTU2]
> > +        - Phase counting mode can be specified independently
> > +        - 32-bit phase counting mode can be specified for
> interlocked operation
> > +          of MTU1 and MTU2 (when TMDR3.LWA =3D 1)
> > +        - Cascade connection operation available
> > +    - [MTU3, MTU4, MTU6, and MTU7]
> > +        - Through interlocked operation of MTU3/4 and MTU6/7, the
> positive and
> > +          negative signals in six phases (12 phases in total) can
> be output in
> > +          complementary PWM and reset-synchronized PWM operation.
> > +        - In complementary PWM mode, values can be transferred from
> buffer
> > +          registers to temporary registers at crests and troughs of
> the timer-
> > +          counter values or when the buffer registers (TGRD
> registers in MTU4
> > +          and MTU7) are written to.
> > +        - Double-buffering selectable in complementary PWM mode.
> > +    - [MTU3 and MTU4]
> > +        - Through interlocking with MTU0, a mode for driving AC
> synchronous
> > +          motors (brushless DC motors) by using complementary PWM
> output and
> > +          reset-synchronized PWM output is settable and allows the
> selection
> > +          of two types of waveform output (chopping or level).
> > +    - [MTU5]
> > +        - Capable of operation as a dead-time compensation counter.
> > +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> > +        - 32-bit phase counting mode specifiable by combining MTU1
> and MTU2 and
> > +          through interlocked operation with MTU0/MTU5 and MTU8.
> > +    - Interrupt-skipping function
> > +        - In complementary PWM mode, interrupts on crests and
> troughs of counter
> > +          values and triggers to start conversion by the A/D
> converter can be
> > +          skipped.
> > +    - Interrupt sources: 43 sources.
> > +    - Buffer operation:
> > +        - Automatic transfer of register data (transfer from the
> buffer
> > +          register to the timer register).
> > +    - Trigger generation
> > +        - A/D converter start triggers can be generated
> > +        - A/D converter start request delaying function enables A/D
> converter
> > +          to be started with any desired timing and to be
> synchronized with
> > +          PWM output.
> > +    - Low power consumption function
> > +        - The MTU3a can be placed in the module-stop state.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-mtu3  # RZ/V2L
> > +      - const: renesas,rz-mtu3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: MTU0.TGRA input capture/compare match
> > +      - description: MTU0.TGRB input capture/compare match
> > +      - description: MTU0.TGRC input capture/compare match
> > +      - description: MTU0.TGRD input capture/compare match
> > +      - description: MTU0.TCNT overflow
> > +      - description: MTU0.TGRE compare match
> > +      - description: MTU0.TGRF compare match
> > +      - description: MTU1.TGRA input capture/compare match
> > +      - description: MTU1.TGRB input capture/compare match
> > +      - description: MTU1.TCNT overflow
> > +      - description: MTU1.TCNT underflow
> > +      - description: MTU2.TGRA input capture/compare match
> > +      - description: MTU2.TGRB input capture/compare match
> > +      - description: MTU2.TCNT overflow
> > +      - description: MTU2.TCNT underflow
> > +      - description: MTU3.TGRA input capture/compare match
> > +      - description: MTU3.TGRB input capture/compare match
> > +      - description: MTU3.TGRC input capture/compare match
> > +      - description: MTU3.TGRD input capture/compare match
> > +      - description: MTU3.TCNT overflow
> > +      - description: MTU4.TGRA input capture/compare match
> > +      - description: MTU4.TGRB input capture/compare match
> > +      - description: MTU4.TGRC input capture/compare match
> > +      - description: MTU4.TGRD input capture/compare match
> > +      - description: MTU4.TCNT overflow/underflow
> > +      - description: MTU5.TGRU input capture/compare match
> > +      - description: MTU5.TGRV input capture/compare match
> > +      - description: MTU5.TGRW input capture/compare match
> > +      - description: MTU6.TGRA input capture/compare match
> > +      - description: MTU6.TGRB input capture/compare match
> > +      - description: MTU6.TGRC input capture/compare match
> > +      - description: MTU6.TGRD input capture/compare match
> > +      - description: MTU6.TCNT overflow
> > +      - description: MTU7.TGRA input capture/compare match
> > +      - description: MTU7.TGRB input capture/compare match
> > +      - description: MTU7.TGRC input capture/compare match
> > +      - description: MTU7.TGRD input capture/compare match
> > +      - description: MTU7.TCNT overflow/underflow
> > +      - description: MTU8.TGRA input capture/compare match
> > +      - description: MTU8.TGRB input capture/compare match
> > +      - description: MTU8.TGRC input capture/compare match
> > +      - description: MTU8.TGRD input capture/compare match
> > +      - description: MTU8.TCNT overflow
> > +      - description: MTU8.TCNT underflow
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: tgia0
> > +      - const: tgib0
> > +      - const: tgic0
> > +      - const: tgid0
> > +      - const: tgiv0
> > +      - const: tgie0
> > +      - const: tgif0
> > +      - const: tgia1
> > +      - const: tgib1
> > +      - const: tgiv1
> > +      - const: tgiu1
> > +      - const: tgia2
> > +      - const: tgib2
> > +      - const: tgiv2
> > +      - const: tgiu2
> > +      - const: tgia3
> > +      - const: tgib3
> > +      - const: tgic3
> > +      - const: tgid3
> > +      - const: tgiv3
> > +      - const: tgia4
> > +      - const: tgib4
> > +      - const: tgic4
> > +      - const: tgid4
> > +      - const: tgiv4
> > +      - const: tgiu5
> > +      - const: tgiv5
> > +      - const: tgiw5
> > +      - const: tgia6
> > +      - const: tgib6
> > +      - const: tgic6
> > +      - const: tgid6
> > +      - const: tgiv6
> > +      - const: tgia7
> > +      - const: tgib7
> > +      - const: tgic7
> > +      - const: tgid7
> > +      - const: tgiv7
> > +      - const: tgia8
> > +      - const: tgib8
> > +      - const: tgic8
> > +      - const: tgid8
> > +      - const: tgiv8
> > +      - const: tgiu8
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
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> You still do not have children with unit addresses, so these are
> weird.
> So again - why do you need this?

Oops, it is not required any more as both counter and pwm is
modelled as single device that handles all the channels based
on runtime.

>=20
> > +
> > +  "counter":
>=20
> No need for quotes.

OK.

>=20
> > +    $ref: ../counter/renesas,rz-mtu3-counter.yaml
>=20
> > +
> > +  "pwm":
>=20
> No need for quotes.

OK.
>=20
> > +    $ref: ../pwm/renesas,rz-mtu3-pwm.yaml
>=20
> Full path, so /schemas/pwm/...

OK.=20

Will send v3 with these changes.

Cheers,
Biju

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - power-domains
> > +  - resets
>=20
> Best regards,
> Krzysztof

