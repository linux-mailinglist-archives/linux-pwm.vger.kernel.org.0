Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4395F8417
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Oct 2022 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJHHmq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Oct 2022 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJHHmp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2022 03:42:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B075755C;
        Sat,  8 Oct 2022 00:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfYQ9hbR+uSVpI033LHrhBOjAajPy57DuPct64zlzjdYgf4y3GtKUCXO9SJfuFLirbbcqNHyFQcipO0s/P/1+ODbyZXTHRbb0ZbL6kKRaOMwwSKErofFOXmEfGI5asSjZx5HUyXAeKG0/rtekp8loR8uIUPTfQIu5IjqFqdkfMbh1SDhJNuHdF+jOsy+aw35ijh9uy5shkBPlBhvI8ZEi6uO/9K6BGKpNu4OQXbCesq3gvSt84gQnh0XaiSzoSv6eldQnKGzn1dgOn5bMVxPlT8nYIdPp7CQvwDdMSczMFxRBDD+wyNf01zsyh/v0Cc1c0yOMj7AJ9pP6dhSE/PLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQbwBYNjVjZ2DxFAZSjTs69gzgM9q3RbozgggQPrcs4=;
 b=mZK0/R+ISwpQZ2zWPJuarcnRjxXU5hO4t6sCunPV4cay7CJG48y1a+K/89AlbDWmN/NJYYRtaP5CVkUY60Qv8HWdPsZX0i+Aq2Pi8gAPiNXUULZiaweCq1pHbJla6dd4wzOleZ/lzOS+RFK8/wgdlL8Cix4jdJeyX/RGo0E27jtr63IlBBpmfkFMXOWLTLBRiKN3YkpuNyS8p2gF31Zm+akjWCmBMl1daWYxmCCIONP7gTPLr3uzVEl0+gD6AxJ+2FeEfVYpMmbAtOeo+HhEq+rQxVG7rSZna+is9vr45gKgblT10N9uw/W14yGR3Y8oTjxFBDYnQjn6xmZTZWfjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQbwBYNjVjZ2DxFAZSjTs69gzgM9q3RbozgggQPrcs4=;
 b=GN9/d7yO720654SNjoizXm8ynF3A2+CJ8l5zhdBVlZ1di93J34LnYNIHVyYM0vd6Un0HsthZRMxJKOLXzIWx4PbG6YYqfw56p1XXWxpwl9skrlUkBWOrNTJBBePRw+2p0yLF5K6zVV7ejDDw5da661sXBjg2L/H8WzdltJfKGSs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9628.jpnprd01.prod.outlook.com (2603:1096:400:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 07:42:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 07:42:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY2YuXPmW6g+v5akyG0CoeRXz0kq4Bzk0AgAEPNNCAAT9J8A==
Date:   Sat, 8 Oct 2022 07:42:38 +0000
Message-ID: <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9628:EE_
x-ms-office365-filtering-correlation-id: e25dbeeb-c372-4542-c9ef-08daa900ac5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT/3p7X9Xcb1aXHKIthMLiA53CGe7lj1X5AXZfh61+ZMofD4nCRxPX2MnDGYnWuPLj/qsYpmX/rYTw3C2OkFr8ECLHNDce/qMl/OGarY/GMU6qLeyLUmjenAoZKI1nK5OWIwpWBH9nkB2elQ1u2REqR2pJdctFdsF+TSM8SbpyG9CL2wzvVsbLnYvBqRUOQ/UVN8w8jYwgSfCWDjkSrPdxX1M8wKvdyDds/CDS3VfUGQdMykpeBN7VSw8KTf/xGQ6Q7E7n55cpTZ/sEAhSN0LIOHcAmH8NJ9XmkFAZR/paXAHdtvnUIAvqlEC9MEcXGCMCkkaiVjkD3zTP5G27sUdc+ZJoSH69RktS7jp9wgAyOXXWm5g7r2G3v0UaN3cgDxcjXb7OxtWJ8A0ygVXLA7BsGBTJ30fk13toRSE8pZvSZU0ad3oVwV3v22n4hDzhshdfArL32ugZ3K5PQK7dwpuHHv8K0QDV5VsIBgrgfifjA2ycQYkPtN+1//sTxWMv3QIPgesc8Cf/3wbPj+W4U2nK7ozz0NXD3kYJKWkMAQYF9YGS/P+SJdtTF6jCcRbhxA+jmF7Lyx856uCk826VuvLo+WS2XmSVgTBvdsgy+54lKggsWuqgsnGqPYVuLwt8+xlPqTH3lnAqWs1yAf3qRgZaCzhZWqUPPtaF5clvoX2/asqIZ+RznWD6u8FgbwFAAxlcKDmtAauDAYy6U4FltNQc1nJiuoMDEnNkKX3wZiONUwjn34FOIxfzx+lKKRbeaLrYetHOzATdDSKRI8o3swQkD4p+wEFgcUXdt1b9m++Kw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(9686003)(26005)(478600001)(7696005)(6506007)(186003)(83380400001)(30864003)(7416002)(2906002)(55016003)(5660300002)(316002)(110136005)(54906003)(8676002)(71200400001)(8936002)(41300700001)(52536014)(66946007)(66476007)(76116006)(4326008)(66556008)(64756008)(66446008)(38070700005)(86362001)(33656002)(122000001)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/V3X03xx5dHT4MlulOoLkc0DqPOBD2U+y8YO6J6BKXdVVTnmmetV5bRWdy?=
 =?iso-8859-1?Q?QYD7bX06q+5pbtOfdQ0AWZ4bhL/KxKYo1sTYMtdH/KTOAG9MRNYPRClOsE?=
 =?iso-8859-1?Q?mPVMUNf0oJjKjnI6Q1vrxSdg2hlHSWHEA3cC1V2+UVSLA+v1aVDVG4sOC5?=
 =?iso-8859-1?Q?6oRyOU6g6eUrxL4YewAWsye+f+QA1wwViUf2YwriV2qlc0A2VCkwO2Qbcn?=
 =?iso-8859-1?Q?syQ7QNyk9lVQ8EQ6BfFR/wlR65GV2Wb5c5SvbuV3XgRNNKZFPbnb3GUhBO?=
 =?iso-8859-1?Q?8Xrwc0Qc6kjwqdrRR0HocsI0X9kpeCsXapgIniFIJ754eeoxavkXBuQTxc?=
 =?iso-8859-1?Q?k61V/Up1vz1fvrGalMIXQJDYV9lwrELgfZHBSySa9Zqqt2rVUIBx6hZsSJ?=
 =?iso-8859-1?Q?t5ElWSTZ8krQzWmTHmw2K8IES9ZjomD4ThlzV3pLqOGvw8c3K27ckQncjJ?=
 =?iso-8859-1?Q?IkW4s3UPGW6sIntkDa5dV5YNiUZUJbnv8kziaQcCcvaVNhKPBE64RAplgo?=
 =?iso-8859-1?Q?zmfsCB+yLDm9ATevlH6uPem5p+ssCkeJpw1jiNkKRSq3qEyYIr2kIdwEp6?=
 =?iso-8859-1?Q?/++Ucqc2+blTx861w3VoWt4LsvB5yohuM+xYGmUPmWpVvxzZydfHAnPyvT?=
 =?iso-8859-1?Q?zo2qUtCTT9QJbwj9DviSHMMgfSq8U/yAHMz/Qh5MRRQUg6RlssFuUGHVr2?=
 =?iso-8859-1?Q?lIOTKtE/Ba0BC1pV1gFfBAbTVCILPW1v68b0DZX7hRxT7D0qjWInlZpKlC?=
 =?iso-8859-1?Q?IaTeqWqMGZNm/qdZGdGBKuxdSqbG/PwIQw9prSayZ7/tenTOJIAu+Ohtvk?=
 =?iso-8859-1?Q?/zBJV7ECLwX8rFKehwiCmQUdGkf9XO5nzpVKZUWXQ4yTo00V+5toFmAMMl?=
 =?iso-8859-1?Q?haSgn20KE/vLujCg8XDDUCvu/WvqDXHmkIGsw+IQoUu169D45Grl/SXLwh?=
 =?iso-8859-1?Q?lgNGHXyP1k7qzO6n7WKKZ1M9svQ7WLUL5zcXvvHwlGdTkmAmOXq/vdiF8o?=
 =?iso-8859-1?Q?Mh9xqGrQCT+jvTEjKcgdNwderetOe75CluXfd7pWpTMXXHlr1xVykyJwUH?=
 =?iso-8859-1?Q?vHp6D9q6IlLEQF51OomWReRRWByM4uigu9Sp7x8rELYPRC8H/FjneWgFsH?=
 =?iso-8859-1?Q?jElALtBboaeP3sU7sm5JBQF4I6KbKFuKVsgWWMCo+mVyRV+IDBkyE6hgkf?=
 =?iso-8859-1?Q?oIGKQvb/P8WpQCXRGuZM+ikUCkzVUgtdN7O/a2aqrYSAihtJc4/ZLgjRJe?=
 =?iso-8859-1?Q?J4Z0lqO6wzIBKzrbC1lm4WuEyGO8Nci7eHsJADDcFsp5P0l2UuznIJSX6A?=
 =?iso-8859-1?Q?1NO3Syu2SQg7e83eu+dZk23ts+Pz6tHFq/RE4g+3W41gP3xosPFabymwFI?=
 =?iso-8859-1?Q?xPiRXzYvxCPma2Wiq6VT6Fvh+UD0UMd/PCMr7f/1jRFJSfquZkMGkA3Ggx?=
 =?iso-8859-1?Q?bDIgUqw27daaB30cmlxVkH+WPkdMcE+u4LGeDRqVpdsWmNNQGHpZsGpJ84?=
 =?iso-8859-1?Q?94Yi1U5AX6PdirU7cfz4t3OYxHULH5ICsqCv6S4PRK6MzTg5ISSLg0CH4B?=
 =?iso-8859-1?Q?PiV8+WjTuxrRFJi+ViYnVi12VfU0ekvKrfjg80L9JypL9dCuaB1I+bDmCr?=
 =?iso-8859-1?Q?kY0L7PGocf5YCAN+8UwvvhyIKyKHC0S0LEks4T4qp2beGoQMh1VdNfCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25dbeeb-c372-4542-c9ef-08daa900ac5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 07:42:38.2825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5hWmPmwmo7uHX0ELKDJNMP7iyOweu8X0Tan9jyaGKZd/L4fuMYfu3oCB1pF810v3OqmfBrzvH+MtVE8EovpGqUodwy1fPciywGXWetqM+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9628
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob and all,

> Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> Hi Rob,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > bindings
> >
> > On Thu, Oct 06, 2022 at 02:57:14PM +0100, Biju Das wrote:
> > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded
> in
> > > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > > channels and one 32-bit timer channel. It supports the following
> > > functions
> > >  - Counter
> > >  - Timer
> > >  - PWM
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v2->v3:
> > >  * Dropped counter bindings and integrated with mfd as it has only
> > one property.
> > >  * Removed "#address-cells" and "#size-cells" as it do not have
> > children with
> > >    unit addresses.
> > >  * Removed quotes from counter and pwm.
> > >  * Provided full path for pwm bindings.
> > >  * Updated the example.
> > > v1->v2:
> > >  * Modelled counter and pwm as a single device that handles
> > >    multiple channels.
> > >  * Moved counter and pwm bindings to respective subsystems
> > >  * Dropped 'bindings' from MFD binding title.
> > >  * Updated the example
> > >  * Changed the compatible names.
> > > ---
> > >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 304
> > ++++++++++++++++++
> > >  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
> > >  2 files changed, 354 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > new file mode 100644
> > > index 000000000000..44c952ad8d35
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > @@ -0,0 +1,304 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> 1.2
> > > +---
> > > +$id:
> > >
> > > +
> > > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > > +
> > > +maintainers:
> > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > +
> > > +description: |
> > > +  This hardware block pconsisting of eight 16-bit timer channels
> > and
> > > +one
> > > +  32- bit timer channel. It supports the following
> specifications:
> > > +    - Pulse input/output: 28 lines max.
> > > +    - Pulse input 3 lines
> > > +    - Count clock 11 clocks for each channel (14 clocks for MTU0,
> > 12 clocks
> > > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2
> > combination
> > > +      (when LWA =3D 1))
> > > +    - Operating frequency Up to 100 MHz
> > > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > > +        - Waveform output on compare match
> > > +        - Input capture function (noise filter setting available)
> > > +        - Counter-clearing operation
> > > +        - Simultaneous writing to multiple timer counters (TCNT)
> > > +          (excluding MTU8).
> > > +        - Simultaneous clearing on compare match or input capture
> > > +          (excluding MTU8).
> > > +        - Simultaneous input and output to registers in
> > synchronization with
> > > +          counter operations           (excluding MTU8).
> > > +        - Up to 12-phase PWM output in combination with
> synchronous
> > operation
> > > +          (excluding MTU8)
> > > +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> > > +        - Buffer operation specifiable
> > > +    - [MTU1, MTU2]
> > > +        - Phase counting mode can be specified independently
> > > +        - 32-bit phase counting mode can be specified for
> > interlocked operation
> > > +          of MTU1 and MTU2 (when TMDR3.LWA =3D 1)
> > > +        - Cascade connection operation available
> > > +    - [MTU3, MTU4, MTU6, and MTU7]
> > > +        - Through interlocked operation of MTU3/4 and MTU6/7, the
> > positive and
> > > +          negative signals in six phases (12 phases in total) can
> > be output in
> > > +          complementary PWM and reset-synchronized PWM operation.
> > > +        - In complementary PWM mode, values can be transferred
> from
> > buffer
> > > +          registers to temporary registers at crests and troughs
> of
> > the timer-
> > > +          counter values or when the buffer registers (TGRD
> > registers in MTU4
> > > +          and MTU7) are written to.
> > > +        - Double-buffering selectable in complementary PWM mode.
> > > +    - [MTU3 and MTU4]
> > > +        - Through interlocking with MTU0, a mode for driving AC
> > synchronous
> > > +          motors (brushless DC motors) by using complementary PWM
> > output and
> > > +          reset-synchronized PWM output is settable and allows
> the
> > selection
> > > +          of two types of waveform output (chopping or level).
> > > +    - [MTU5]
> > > +        - Capable of operation as a dead-time compensation
> counter.
> > > +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> > > +        - 32-bit phase counting mode specifiable by combining
> MTU1
> > and MTU2 and
> > > +          through interlocked operation with MTU0/MTU5 and MTU8.
> > > +    - Interrupt-skipping function
> > > +        - In complementary PWM mode, interrupts on crests and
> > troughs of counter
> > > +          values and triggers to start conversion by the A/D
> > converter can be
> > > +          skipped.
> > > +    - Interrupt sources: 43 sources.
> > > +    - Buffer operation:
> > > +        - Automatic transfer of register data (transfer from the
> > buffer
> > > +          register to the timer register).
> > > +    - Trigger generation
> > > +        - A/D converter start triggers can be generated
> > > +        - A/D converter start request delaying function enables
> A/D
> > converter
> > > +          to be started with any desired timing and to be
> > synchronized with
> > > +          PWM output.
> > > +    - Low power consumption function
> > > +        - The MTU3a can be placed in the module-stop state.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> > > +          - renesas,r9a07g054-mtu3  # RZ/V2L
> > > +      - const: renesas,rz-mtu3
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: MTU0.TGRA input capture/compare match
> > > +      - description: MTU0.TGRB input capture/compare match
> > > +      - description: MTU0.TGRC input capture/compare match
> > > +      - description: MTU0.TGRD input capture/compare match
> > > +      - description: MTU0.TCNT overflow
> > > +      - description: MTU0.TGRE compare match
> > > +      - description: MTU0.TGRF compare match
> > > +      - description: MTU1.TGRA input capture/compare match
> > > +      - description: MTU1.TGRB input capture/compare match
> > > +      - description: MTU1.TCNT overflow
> > > +      - description: MTU1.TCNT underflow
> > > +      - description: MTU2.TGRA input capture/compare match
> > > +      - description: MTU2.TGRB input capture/compare match
> > > +      - description: MTU2.TCNT overflow
> > > +      - description: MTU2.TCNT underflow
> > > +      - description: MTU3.TGRA input capture/compare match
> > > +      - description: MTU3.TGRB input capture/compare match
> > > +      - description: MTU3.TGRC input capture/compare match
> > > +      - description: MTU3.TGRD input capture/compare match
> > > +      - description: MTU3.TCNT overflow
> > > +      - description: MTU4.TGRA input capture/compare match
> > > +      - description: MTU4.TGRB input capture/compare match
> > > +      - description: MTU4.TGRC input capture/compare match
> > > +      - description: MTU4.TGRD input capture/compare match
> > > +      - description: MTU4.TCNT overflow/underflow
> > > +      - description: MTU5.TGRU input capture/compare match
> > > +      - description: MTU5.TGRV input capture/compare match
> > > +      - description: MTU5.TGRW input capture/compare match
> > > +      - description: MTU6.TGRA input capture/compare match
> > > +      - description: MTU6.TGRB input capture/compare match
> > > +      - description: MTU6.TGRC input capture/compare match
> > > +      - description: MTU6.TGRD input capture/compare match
> > > +      - description: MTU6.TCNT overflow
> > > +      - description: MTU7.TGRA input capture/compare match
> > > +      - description: MTU7.TGRB input capture/compare match
> > > +      - description: MTU7.TGRC input capture/compare match
> > > +      - description: MTU7.TGRD input capture/compare match
> > > +      - description: MTU7.TCNT overflow/underflow
> > > +      - description: MTU8.TGRA input capture/compare match
> > > +      - description: MTU8.TGRB input capture/compare match
> > > +      - description: MTU8.TGRC input capture/compare match
> > > +      - description: MTU8.TGRD input capture/compare match
> > > +      - description: MTU8.TCNT overflow
> > > +      - description: MTU8.TCNT underflow
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: tgia0
> > > +      - const: tgib0
> > > +      - const: tgic0
> > > +      - const: tgid0
> > > +      - const: tgiv0
> > > +      - const: tgie0
> > > +      - const: tgif0
> > > +      - const: tgia1
> > > +      - const: tgib1
> > > +      - const: tgiv1
> > > +      - const: tgiu1
> > > +      - const: tgia2
> > > +      - const: tgib2
> > > +      - const: tgiv2
> > > +      - const: tgiu2
> > > +      - const: tgia3
> > > +      - const: tgib3
> > > +      - const: tgic3
> > > +      - const: tgid3
> > > +      - const: tgiv3
> > > +      - const: tgia4
> > > +      - const: tgib4
> > > +      - const: tgic4
> > > +      - const: tgid4
> > > +      - const: tgiv4
> > > +      - const: tgiu5
> > > +      - const: tgiv5
> > > +      - const: tgiw5
> > > +      - const: tgia6
> > > +      - const: tgib6
> > > +      - const: tgic6
> > > +      - const: tgid6
> > > +      - const: tgiv6
> > > +      - const: tgia7
> > > +      - const: tgib7
> > > +      - const: tgic7
> > > +      - const: tgid7
> > > +      - const: tgiv7
> > > +      - const: tgia8
> > > +      - const: tgib8
> > > +      - const: tgic8
> > > +      - const: tgid8
> > > +      - const: tgiv8
> > > +      - const: tgiu8
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
> > > +  counter:
> > > +    description:
> > > +      There are two phase counting modes. 16-bit phase counting
> > mode in which
> > > +      MTU1 and MTU2 operate independently, and cascade connection
> > 32-bit phase
> > > +      counting mode in which MTU1 and MTU2 are cascaded.
> > > +
> > > +      In phase counting mode, the phase difference between two
> > external input
> > > +      clocks is detected and the corresponding TCNT is
> incremented
> > or
> > > +      decremented.
> > > +      The below counters are supported
> > > +        count0 - MTU1 16-bit phase counting
> > > +        count1 - MTU2 16-bit phase counting
> > > +        count2 - MTU1+ MTU2 32-bit phase counting
> > > +
> > > +    type: object
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: renesas,rz-mtu3-counter
> > > +
> > > +    required:
> > > +      - compatible
> > > +
> > > +    additionalProperties: false
> > > +
> > > +  pwm:
> > > +    $ref: /schemas/pwm/renesas,rz-mtu3-pwm.yaml
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - clocks
> > > +  - power-domains
> > > +  - resets
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    mtu3: timer@10001200 {
> > > +      compatible =3D "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
> > > +      reg =3D <0x10001200 0xb00>;
> > > +      interrupts =3D <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
> > > +                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
> > > +      interrupt-names =3D "tgia0", "tgib0", "tgic0", "tgid0",
> > "tgiv0", "tgie0",
> > > +                        "tgif0",
> > > +                        "tgia1", "tgib1", "tgiv1", "tgiu1",
> > > +                        "tgia2", "tgib2", "tgiv2", "tgiu2",
> > > +                        "tgia3", "tgib3", "tgic3", "tgid3",
> > "tgiv3",
> > > +                        "tgia4", "tgib4", "tgic4", "tgid4",
> > "tgiv4",
> > > +                        "tgiu5", "tgiv5", "tgiw5",
> > > +                        "tgia6", "tgib6", "tgic6", "tgid6",
> > "tgiv6",
> > > +                        "tgia7", "tgib7", "tgic7", "tgid7",
> > "tgiv7",
> > > +                        "tgia8", "tgib8", "tgic8", "tgid8",
> > "tgiv8", "tgiu8";
> > > +      clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
> > > +      power-domains =3D <&cpg>;
> > > +      resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
> > > +
> > > +      counter {
> > > +        compatible =3D "renesas,rz-mtu3-counter";
> >
> > You don't have any resources for the counter in DT, so you don't
> even
> > need a node here. Just have the parent driver instaniate the counter
> > driver.
>=20

If I remove "renesas,rz-mtu3-counter" and "renesas,rz-mtu3-pwm" then instan=
tiating=20
the counter and pwm driver from parent driver by directly calling probe fun=
ction is
giving cyclic dependency error[1].

So looks like either we need to use compatible "renesas,rz-mtu3-counter" an=
d=20
"renesas,rz-mtu3-pwm" if these functionalities to be in respective subsyste=
m tree

or=20

squash counter and pwm functionalities to MFD subsystem.

Please share your views on this. Is there any better way to handle this?

[1]
depmod: ../tools/depmod.c:1792: depmod_report_cycles_from_root: Assertion `=
is < stack_size' failed.
depmod: ERROR: Cycle detected: rz_mtu3 -> rz_mtu3_cnt -> rz_mtu3
depmod: ERROR: Cycle detected: rz_mtu3 -> rz_mtu3_pwm -> rz_mtu3
depmod: ERROR: Found 3 modules in dependency cycles!
make: *** [Makefile:1781: modules_install] Error 1

Cheers,
Biju

>=20
> >
> > > +      };
> > > +
> > > +      pwm {
> > > +        compatible =3D "renesas,rz-mtu3-pwm";
> > > +        #pwm-cells =3D <2>;
> >
> > Here too, just declaring a PWM provider. Just move this to the
> parent
> > node.
>=20
> OK, will remove node and compatible. Will add support for parent
> driver instaniate the PWM driver and also declaring as a PWM provider.
>=20
> Cheers,
> Biju
