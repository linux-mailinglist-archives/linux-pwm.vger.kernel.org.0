Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212E5F1E83
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJASDo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJASDn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 14:03:43 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB43EA5F;
        Sat,  1 Oct 2022 11:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcDKUpPBRtGnSXVkx6n3KOR76sEqH8mLLhoEgLaxFGlumh9uVXj4nmwudkCHh6y8zlalLmovZiF4jopU9OrUGg2RJ99x4AQ7iA9eIvXYcVgeAxaimLpPjRu8u7T7kAEN5yWdFtV6NHfJHV/mSiA9Ms6QMmIQdN+2SGMYExp35t6uSGFvh1PEX48Pbelo0ttDX0456t91Mv2ex4sXCtZlK7GicOlrPRNQZDhJJOPbn3tWAdLzK/MR9n0FfbJV0yGnMSqq/dfhQGzyrwguDwAatIxU/qjlWB8UYDDlw89zatkOFV6VdSljEx8SCsCw7T7Bay1mGWaus+TM1w4GLL8/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTDgbrqSMXh9KWOpNvBw/EEXMzONVvQQ8UvX/btcbqQ=;
 b=icmMT3czGw3u1Dcv+EzL5ZrdyEm7n/uJp30fQiYH/iUGEzL5yeQ0ojByc4TmsdlXvvz5/MZJjXBiROyUYmxGJ2kXNxalFMAgbFcgh6JrZ4P6xWB0bAZISw+/uXZsqiO0Q3YrEPrxww5kU6cZTnEKGXH81eKe5IrAKj7Y2ndIBHpICDqI+jx90nMgevdAlCX7qtp01lbGqlfA7zwToBzjXAJHiR4giwhqe5mYUeee/5bLLXl+GtdxdolgUGCZhfuwquXDQokII1X4v3ZIv+DBiznemp24B2WVkiPfnGm83AE/mTQ379aQ+Sk4EDCO1yxFl55Pw5StjmmrYAK4GZ7YFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTDgbrqSMXh9KWOpNvBw/EEXMzONVvQQ8UvX/btcbqQ=;
 b=Qpxo2vSXHYuWjW2Jl5xKbnnba6LqaThP+MNenCUpArRhuvPcZ8RoKDqsXZxkExgPzl/eYcfQLAj2GMZjatVxUPZDAbbp7YCo3bEYhaXEOxv40nvIAQh5tyKJP+BCnBW86rHLFrwDuCHUR0JOuScdVVTgGkpdimxrN1oqBNsQZjY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5943.jpnprd01.prod.outlook.com (2603:1096:604:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Sat, 1 Oct
 2022 18:03:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 18:03:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     William Breathitt Gray <wbg@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Topic: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoCABD8nAIABKKwQgAAHVwCAAAESkIAACY4AgAABz8A=
Date:   Sat, 1 Oct 2022 18:03:37 +0000
Message-ID: <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzh8ULruBgN1tf+L@fedora>
In-Reply-To: <Yzh8ULruBgN1tf+L@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5943:EE_
x-ms-office365-filtering-correlation-id: 3d06ac26-0552-414f-9ab3-08daa3d743ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: up1pOgk0FznNk9ZmnkdfWXYobnLkFbRrfmaUHMKWVT2n3KPfyIwxY3qifnwuI//UoitQPRP5lVkOFmBIIWabfOPGPdD9WmZoNA+o1XPSsScx+buPkMwEQbO6bTPHcj0LzyEGrhzK6xqsKcA3aQcGyI0nprHFjKBihFsd43UlMbocx+W0E0BS323nEu62z9bcXTImh7O3alzR+2DysiuA4/NfbhcBhweoUBL111xsZgwZ56KwbQZLo38qKgwKaryc6Uy4FxrZ35tLap4sUUBGVBENy1MDublM7Z6GChmpXftXXmVUtArDlGW88Fa1fpB+53CfciMhG4cMngbwvbfxNuMgaGt5isYi/4rBTHtRrRLAylQg6yS6/hhjOX1HvKA8DYhOqUq5E92/edkgo+D4JIMm5ouWpTMfSB5XWnfocq9e6/iss35q3DDHkyWtpxoWejSbA8d95O2xhgzWF8Ja4NCLrrHwmWurFE4jBl1owakbEHV1WFZh1m2XnK0THrQjVUeezG2NmurMFS+2PPtKnuJkpeyBDc5PRFw4DGrMqmKgn5rhJcD/jI6UJ9vwEr2mdxwb5u8oZHPzZqc5V7dU/6J6GkOLD3DHJ2hW5IrfPMthSB79joqS96RjcrPvFLHHO8TEeA6362BEFzijqTAE6EkX0obpCs0X4FfEmeau1ArwM3GYk2zgXt9hooSH0J8LMKl6ZeW9hjH7qZSd/A4ERiB0yBOlpjsxdvVi9sLrAlLUVihDjgoe4QEfWJX6xlrnkY70kUipzc2EPmycidxO5Sx2xKwdO+hmE1kmaNA+dA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(6506007)(38100700002)(7696005)(53546011)(122000001)(38070700005)(186003)(6916009)(26005)(478600001)(9686003)(71200400001)(66574015)(316002)(83380400001)(54906003)(66476007)(7416002)(5660300002)(33656002)(76116006)(64756008)(8936002)(4326008)(2906002)(41300700001)(66946007)(66446008)(52536014)(8676002)(55016003)(66556008)(86362001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vY6AXv7WXX0oXS7dBFcDn+YmueKe5PGIoXHRfYsYJXvgvv+9CJMYWMaD6C?=
 =?iso-8859-1?Q?LX3nbd53bYx41+ISJW5gVy5z40XPFQ+6pbkr+CeIgxIYRcK3vvDVe9PnDb?=
 =?iso-8859-1?Q?lG9TimL0563xVA+rIQB4SUbdSi8NLwP20oFSC4If6K5BGQRZ2PCjnpYmW6?=
 =?iso-8859-1?Q?V/gPlCku8+YCSIFfOl1Rdi9U3nvIfIfVhjnMLg1tdfDtOYzp3VamQJiLOA?=
 =?iso-8859-1?Q?lMtFvoy8/ih5mKNbrsxocNI/uFs3TPRFSRef3tcHZLpPWUn4pu6pNFZ4fZ?=
 =?iso-8859-1?Q?oP95nTyHAVfLkU1qc/UoCa9I3NIWhr/Qz7u3rIEnq0IepWaMT5PVEsW9Mx?=
 =?iso-8859-1?Q?9VR2o1lwcubzlVfp4zsE+taBwyMIM3MjDomRaHV5X8eKxIgcpqjHB9Llu8?=
 =?iso-8859-1?Q?I9PtTSnVJjJkoCNr1WZ5qZFQp61cGDTwrlcT2I3VycfL7+5VRDQ2zc6aSg?=
 =?iso-8859-1?Q?nwzGGD7So4nrV3moC03eSZiOLFFScUAXwQ6hpNPaaVtggHt/pCKntNnpc0?=
 =?iso-8859-1?Q?7pF1CPTPG85cMSAXFRBD1GkxM587CYOChzGWeeN7HRpG8DcaX7I1t371f3?=
 =?iso-8859-1?Q?AusqId0Hf3Q8wTpkjdykDr6yHHxnEtGgImsCPCfvQ0/igdKIF6c5uwAikD?=
 =?iso-8859-1?Q?01li5QClQzeS66kkZMLMRUi9Exs37ga/LzARENCpVxCu3+CI76llpyqBu4?=
 =?iso-8859-1?Q?lgmxYegryTj2Bderg/vRJSB087Q3WADJpALLV5J6BfaDK5+CzhLqtlXe4f?=
 =?iso-8859-1?Q?nvkF8S4BB8sGUTntQ5fI6NeTCmFDxFxgPrnK+CHO9YklYt9PmBE+jud5Li?=
 =?iso-8859-1?Q?dz+qC2r5Bz2g6jOgiY400WHHUPFwUWBg6I8uF5AptthtuB1oSbSubXGi6R?=
 =?iso-8859-1?Q?+QzaIyhsAJFpkWYPaStZ0ajJx2YQKZ8VloatE+Zt7iby8HdOss0S4fakbM?=
 =?iso-8859-1?Q?yHA7RTHnX2zYAcUmqoQE3ggYQpkpqdFptDWZxfSO8x/75EC/bg2iSpnQgM?=
 =?iso-8859-1?Q?/SM77y5LZWtswtD8GeLOx5G6sPbKL7JisuHSzYZetoO9iZD8xeC0YiUKww?=
 =?iso-8859-1?Q?1qla0qVYZx3nKpubIa0mJ2E/9NtGR6yaWfpcz3TQAopSzVw1C4W2UenJeM?=
 =?iso-8859-1?Q?Sm+xZiyclkLJJLkGGWMERle5mGWEvaUDlNgTRlWul4Kpo/uRAaphP3cpcT?=
 =?iso-8859-1?Q?eZ/w+Y6d6mYkDZ8eTqraI8NYi5igGKFWWittCvVsNavsR2LP4lLEcBbd5N?=
 =?iso-8859-1?Q?20h87S1vAHaS90hqenYyl5gqh9Fq724kJeyq/po3R0Yf492Wlq/uwm9O2F?=
 =?iso-8859-1?Q?3VSJgUV0LF5OnWj9xWub+dIHCbp/2osr5ahnSztlpZaRzChzgIYrc+vq+g?=
 =?iso-8859-1?Q?wK8H1gE2DYJhLkUIx0hmoDWrfbOa6l7T/dMKWlo2a5GSXeFbPtI5Y3HUhK?=
 =?iso-8859-1?Q?cSywXVPxGyVIP0VgfkyVg2Kl+VjEQzoVCfPtbpJLOwNB6qA2wnV7Raoeg7?=
 =?iso-8859-1?Q?EaeqHkS1F+qB5oahqhTCGG6W4JaSP0sNv6vjCv2jp0cXH2Kp0J7vtn6Z++?=
 =?iso-8859-1?Q?G7sdI+KBOedWbZTlWwNXd/EgT3/9G7AZrr0LBIo0ywbYhlQUog8UC8bb0i?=
 =?iso-8859-1?Q?05hh9930sA8tY8XqxUMfJGvsJ33ADXX8wY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d06ac26-0552-414f-9ab3-08daa3d743ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 18:03:37.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75tUEGj7tVVC0RVOh6/8BKS++o04onlIfDb7MedDuj4miuya0cVwgYCkRq+CGmFXN8osx0howrgwPWtY6+DlLC3004JgdcYFCV+2Fwe4dF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5943
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: William Breathitt Gray <william.gray@linaro.org>
> Sent: 01 October 2022 18:44
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: William Breathitt Gray <wbg@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Michael Turquette <mturquette@baylibre.com>;
> Stephen Boyd <sboyd@kernel.org>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Lee Jones <lee@kernel.org>; Uwe Kleine-
> K=F6nig <u.kleine-koenig@pengutronix.de>; linux-pwm@vger.kernel.org;
> linux-iio@vger.kernel.org; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Sat, Oct 01, 2022 at 05:12:56PM +0000, Biju Das wrote:
> > > > > You can then control the phase selection using a top-level
> > > > > Counter device extension (e.g.
> > > > > /sys/bus/counter/devices/counter0/phase)
> > > that
> > > > > configures whether you're in 16-bit phase or 32-phase counting
> > > mode.
> > > >
> > > > So I need to introduce a new sysfs called phase. Use that one
> for
> > > > Selecting the external clock pin for phase counting mode.
> > > > Please correct me if I am wrong??
> > > >
> > > > Hardware supports 4 pins for phase counting mode,
> > > >
> > > > MTCLKA Input External clock A input pin (MTU1/MTU2 phase
> counting
> > > mode
> > > > A phase input) MTCLKB Input External clock B input pin
> (MTU1/MTU2
> > > > phase counting mode B phase input) MTCLKC Input External clock C
> > > input
> > > > pin (MTU2 phase counting mode A phase input) MTCLKD Input
> External
> > > > clock D input pin (MTU2 phase counting mode B phase input)
> > > >
> > > > For MTU1, it is fixed MTCLKA and MTCLKB.
> > > > But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - {
> MTCLKC
> > > > , MTCLKD} On reset it is set to { MTCLKC , MTCLKD}.
> > > >
> > > > Cheers,
> > > > Biju
> > >
> > > It doesn't need to be named "phase" specifically, but it seems
> like
> > > a new sysfs file will be necessary in order to select the proper
> > > phase counting mode.
> > >
> > > Are these MTCLK signals the quadrature A and B Signals you defined
> > > in the counter driver?
> >
> > Yes, that is correct.
> >
> > Cheers,
> > Biju
>=20
> You should define a Signal then for each of the four MTCLK inputs.
> Create synapse arrays for each Count respectively; e.g. Count 0 will
> have Synapses for MTCLKA and MTCLKB, but Count 1 will probably need
> Synapses for all four Signals (the action mode for two of them will be
> COUNTER_SYNAPSE_ACTION_NONE depending on the configuration set).

OK.

>=20
> What is the configuration when 32-bit phase counting mode is selected?

LWA Bit (MTU1/MTU2 Combination Longword Access Control) needs to set for 32=
-bit phase counting mode.

b0 LWA 0 R/W MTU1/MTU2 Combination Longword Access Control
0: 16-bit access is enabled.
1: 32-bit access is enabled.

> Does MTCLKA and MTCLKB serve as the counting signals in this case,

For 16-bit and 32-bit counting signals same. We can set=20

1) MTU 1 and MTU2 signals as MTCLKA and MTCLKB

Or=20

2) MTU 1 signal as MTCLKA and MTCLKB and MTU2 signals as MTCLKC and MTCLKD


b1 PHCKSEL 1 R/W External Input Phase Clock Select
Selects the external clock pin for phase counting mode.
0: MTCLKA and MTCLKB are selected for the external phase clock.
1: MTCLKC and MTCLKD are selected for the external phase clock

> with overflows on the MTU1 register incrementing the MTU2 register?

No. that won't happen as we need to use different register for Long word ac=
cess

These are the regiters used
16-bit:- TCNT{MTU1,MTU2}, TGRA{MTU1,MTU2},  and TGRB{MTU1,MTU2},
32-bit:- MTU1.TCNT_1_LW, MTU1.TGRA_1_LW and MTU1.TGRB_1_LW

Counter in MTU1   MTU1.TCNT Word MTU1.TCNT_1_LW Longword
Counter in MTU2   MTU2.TCNT Word

General register A in MTU1 MTU1.TGRA Word MTU1.TGRA_1_LW Longword
General register A in MTU2 MTU2.TGRA Word

General register B in MTU1 MTU1.TGRB Word MTU1.TGRB_1_LW Longword
General register B in MTU2 MTU2.TGRB Word

Cheers,
Biju
