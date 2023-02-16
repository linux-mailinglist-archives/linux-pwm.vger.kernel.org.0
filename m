Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA26990B2
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Feb 2023 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBPKGx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Feb 2023 05:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPKGw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2023 05:06:52 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3F3A84D;
        Thu, 16 Feb 2023 02:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq+p9olirUpsbQ0UG0zCf82f5JPaPDPYm4UkePZv/8XhwF13WdL6rg/+3VHq6/V0T9hDo6EwNCj+x+tBYvqiwJnIDBGi5+25/jXNlgeLmLq8PXXfOqgSQ/C3oepftzsCzVD5DtxUIqv1G2O590AvKAA3CElWAmCANECauaEOMISrueGPy3XcJ4C1e044C/NwoWel0gHEDr3eyTkENCSuqL8f9WWGGqF7lmvpfrwlMFhtELG4pBEY0msbVFPzcx2KoxWToiY2xvVhjZyjWYfldWxg4QApkqGqbzsSFKTgz5JdRuvObAEOVMkRh0JiP50Tzv3bFKcWYziiggIcuOr9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nBWquRdwesdfNu1/YPFRNMcqakguQfrtHpw+HNj0RM=;
 b=e32K+rB4/L/ARPyeaP02BcnclhkAcFTmMhA2HEslWw1AtbpbRC72Js044RmAiv9M8UaNRiojh570RlbhCbqvwZl2xxSjnvSSu+lIgocO2rxu17qFoTlq7vTqDpS7LD6TJDqC9RxUIceX6Oixr5B/nPTLAmJTcOzHxAFNVVeHAnx1llHb15fcL4nF6S5IMIA1n2LVXz6VNI+FzULgdNdXsKdd0JtFnVqBIJN9Z77OjSQ3GuOsGQouE8jbebrpbZNQrUtx2NvUrom2Qm1cNSCjrrekma3yZ3Emheb0dohjQvbl/BoEpkh7XCTAH3qTxJAe6786Y2FVKRdhLd9uY5byrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nBWquRdwesdfNu1/YPFRNMcqakguQfrtHpw+HNj0RM=;
 b=oAHGJ1MQvkEw9e0wHbfQEZ8/gTwOlWlSEThFw92eeB6MYXH5KztSTrsTmSHcgWBQPrvJ9vNbEA7ZJMgRueYS7WuBXo+mO1rVaN7u56VQJz346RIhUxKY31g0tx2Thm24JsPK6EewGMxJu0vIW6Y2Qk2eWAPk6teDCRTLFVjA1ww=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11986.jpnprd01.prod.outlook.com (2603:1096:400:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 10:06:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 10:06:42 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgACrzUCAANvjgIAAEdMg
Date:   Thu, 16 Feb 2023 10:06:42 +0000
Message-ID: <OS0PR01MB5922D010C619D3A35564CF6386A09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230216075231.xnmblxocmlsab5nv@pengutronix.de>
In-Reply-To: <20230216075231.xnmblxocmlsab5nv@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11986:EE_
x-ms-office365-filtering-correlation-id: 0292100a-ef45-452c-3072-08db100580b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xMxaY/wn1dazKofGjfcQ+WsDsF7wpUazcskZvFP1C3MJySHItgOoUoGMJg+FF0CGXf9rl7AFF+BoBz56YvmtD8pFx1LG1ECI55GlLEqk/xszAImcqhjdOiec6e9HJhJwIC+hh5a0BTzvX5/5r0xMS0ZZE5FAU8ghAYaPJSEXjZAbfVFaWXGVYs0gixyQZWdD0fu5yDAekCLnMNNKApPRTWwGWEaTKUIx7Hpbgwp+FAUizqy4ZoUxG7o+ehpeA9baelxNtY9wTHtmOGY/TRblTL1UfPdKQDWL3E0wsAd32Im7dlfOmRutjXKGblf0nBXTj4+PBhGiS+BUR5cWTf7VXNxsCjxJs9nO2Wie9Niw1X2BexVanTip1cvBrNRvzZ9kqQl7oRBiTDBiLG3WlZXHVJEE/cmOZIot5UnmpObzoPtE1bQLN5gHpgrLAXvXR625URNffvThHSOTctCb7fBA+E4gweFBoFahNVeqwKxOSxsZ19zL3tg/lhhUIz72mx8l6ZXgomB4es8bsYmfBbSN0pXZt14SJysqBZvroxeayL2iWbMzFYZKrxRj5xDRf5HHW/j6JoJIYlxjrztHosJqyfS5dEbY7gU42bo4hC3tDfAz+rg1w8viG4FkSG6ooaIt6ozsDIM+RgyIVKlcEz02bqBQNXgOfVFni3eElUGvPHm0Mrx+ifbZsBbP3ARgQ3e+eoma9+5mYSZZ98a5Oflsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(9686003)(55016003)(6506007)(38070700005)(186003)(478600001)(966005)(26005)(83380400001)(71200400001)(7696005)(66574015)(54906003)(86362001)(30864003)(5660300002)(316002)(64756008)(66446008)(6916009)(66476007)(8676002)(52536014)(66946007)(41300700001)(38100700002)(8936002)(76116006)(66556008)(4326008)(122000001)(33656002)(2906002)(32563001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EHlq4BwHWNeh8wy5o+vv/VbdIIgMOzz20mNpJbDbz3eU/XE3GAPTF1Ff8m?=
 =?iso-8859-1?Q?xPRb2Xza4ssMbJVptKbatwZSQNmRe6mEKjc8SDuQKegQsaxlAF+8aocX/x?=
 =?iso-8859-1?Q?b2WElZ7bVMZnBsZnG0eAKiqYhvA17dS3SwwlE8adNjR5VlBWIdaMA1wglu?=
 =?iso-8859-1?Q?w6M0naaUx9Rx1DPYDukRZ40ab5LSGbN9bj628f0kVgt/DceaAbWpXi7Ya1?=
 =?iso-8859-1?Q?WGWlbnhZsqOfNGHs8g/O/0BxlvJmLNkmmreKQRzFs6WhnqP6Lcl4Aodxcd?=
 =?iso-8859-1?Q?uY7iBCx24KALPiti6/yI20L4Qo9HJbB3qbFpTkN4Cfm17wR8GqugKoyom+?=
 =?iso-8859-1?Q?LsFtzkJcZEad6H4f6nnXDWJ2GQDJ4GQ4EblWo1rR9Aru9XnmgblGg3PBtp?=
 =?iso-8859-1?Q?+HB5vqqbAtocJiu0pv/omVVLWVIVM8FealDXkC7LuMNDQnXzWxveyccT3w?=
 =?iso-8859-1?Q?xHXj0HflkkPscBz2fACVsVAq1lJ0TrKmsjnofJk+Z3p6HzbrdtwoLG45vN?=
 =?iso-8859-1?Q?A6Ap29dSeB+9tf9Cw1FbEkV75L5PNHhht863Qxy62vvv3MXXlKPoO8A50s?=
 =?iso-8859-1?Q?1xLzLBLurByTqU5gTboEXnXgJH3Uj2ln4KUZP0fpmVi/YkYqjX0ECm98+2?=
 =?iso-8859-1?Q?sQDHapOUYlQexLboknbqzG4W3E8vn02g7NMB6eVnZID1nBgPllAiq4Qovs?=
 =?iso-8859-1?Q?+1wCkDQwyQDPP0nLAQO5Yb2BqRDrDE7uZ7uiMajw1lbOeCvoS5HMoj4uBQ?=
 =?iso-8859-1?Q?datmX3FFVWQHDtJLA9KgojmXjRU318vfAJbxtqH+XN+2DFImCiJRFDiFZ8?=
 =?iso-8859-1?Q?J1loXEKMdkMXdI+VdyseLslYx1PMjtJ12fFoBjL2AYFy+sfIDh3bfmp5R+?=
 =?iso-8859-1?Q?mxfQ2AQ2cCRIz3uDlY09BFcCi+0fTR/dAh3R2k+cgE665Vlp7sG5EN4oE4?=
 =?iso-8859-1?Q?VXSsqYyfFlylZzzrKM+NNiaA8acUfxEtgo8ote8XK6I8e63JRk/seZAEJE?=
 =?iso-8859-1?Q?um3Z4EHlvXyqSZCRDANRLAeHfc08xrdsrz5vXNTSc8+M3msX6VfCK7XoXr?=
 =?iso-8859-1?Q?0t7gkNipq18Z7rhJ7n5lt2dAzDskzufSnPZaBvQ+eNvDa4RkP5lNuQ7zx1?=
 =?iso-8859-1?Q?sWHs+UxsduGHNZ69nySQh8wDnivJWW+08ISEquvFOHqM/7NJ6JZyRfgXUF?=
 =?iso-8859-1?Q?8BmyDqinBczwxM4SHns8xtrm4x4kLswRDwpgqEZM4VSOUl02xIAoewjYyD?=
 =?iso-8859-1?Q?AJf54+4L7nQayExrZpeVonJpU0JsTTr88xpz+J/K3Kmg/GkOmGmieAeG3A?=
 =?iso-8859-1?Q?awdJv+3o+18Y96oV32ycsxqFUen7MwHvkNuds8gHRg+aZHCPxqnh5QMw9E?=
 =?iso-8859-1?Q?aNDuQghwas3ZQlE82h/fNq9l83rSV2MlRjibpReA8b7RKieltuvpaMnsAk?=
 =?iso-8859-1?Q?UUuuh17HKcifKSq3EX5XnmvMOvnHvDLBaRSmKkEQ+oOM6ywBT8ll9sR6tI?=
 =?iso-8859-1?Q?k7BOBbJt6OXHvY/pELcv4d03MIV8X7XUdfatMezL/cOEOv4F92a0GJCLq5?=
 =?iso-8859-1?Q?93F49hfNR9c1aB7pb2yqyUjwYkirV4jpCzdR0BpuOO6alfgTsjtclDDYWF?=
 =?iso-8859-1?Q?YMR5Xjc90qVFi9syfQeUlEgbHc8I140hVX17rQILKsoBoDkMboq2m2lw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0292100a-ef45-452c-3072-08db100580b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 10:06:42.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0ug1ftVvIA1tHrFoD55HVDSit2xIGHL7VnLxAdYc1YTclg8J/og4+28yJl2IWlP4Se7kbVZOe4X4B8Y16Ne1e7wN3/bths/4IlCsb+vKzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11986
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello Biju,
>=20
> On Wed, Feb 15, 2023 at 07:14:12PM +0000, Biju Das wrote:
> > > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM
> > > driver
> > >
> > > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > > Add support for RZ/G2L MTU3a PWM driver. The IP supports following
> > > > PWM modes
> > > >
> > > > 1) PWM mode{1,2}
> > > > 2) Reset-synchronized PWM mode
> > > > 3) Complementary PWM mode{1,2,3}
> > >
> > > It's unclear to me what "PWM mode1" and the other modes are. I
> > > suspect this is some chip specific naming that isn't understandable
> > > for outsiders? Would be great to explain that a bit more.
> >
> > Ok I will add below to Limitation sections. Is it ok?
> >
> > PWM Mode 1: PWM waveforms are output from the MTIOCnA and MTIOCnC pins
> > by pairing TGRA with TGRB and TGRC with TGRD. The levels specified by
> > the TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and
> > MTIOCnC pins at compare matches A and C, and the level specified by
> > the TIOR.IOB[3:0] and IOD[3:0] bits are output at compare matches B and=
 D
> (n =3D 0 to 4, 6, 7).
> >
> >
> > PWM Mode 2: PWM waveform output is generated using one TGR as the
> > cycle register and the others as duty registers.
> >
> > Reset-Synchronized PWM Mode: In the reset-synchronized PWM mode, three
> > phases of positive and negative PWM waveforms (six phases in total)
> > that share a common wave transition point can be output by combining
> > MTU3 and MTU4 and
> > MTU6 and MTU7.
> >
> > Complementary PWM Mode: In complementary PWM mode, dead time can be
> > set for PWM waveforms to be output. The dead time is the period during
> > which the upper and lower arm transistors are set to the inactive
> > level in order to prevent short-circuiting of the arms.Six
> > positive-phase and six negative-phase PWM waveforms (12 phases in
> > total)with dead time can be output by combining MTU3/ MTU4 and MTU6/MTU=
7.
> >
> > In complementary PWM mode, nine registers (compare registers, buffer
> > registers, and temporary registers) are used to control the duty ratio =
for
> the PWM output.
> > Complementary PWM mode 1 (transfer at crest) Complementary PWM mode 2
> > (transfer at trough) Complementary PWM mode 3 (transfer at crest and
> > trough)
>=20
> I read it five times now and still don't get it. The problem (maybe) is t=
hat
> there are many abbreviations I don't understand. Most critical is:
> What is a TGR?

Basically it is Timer General register(TGR) functions as either output comp=
are or=20
input capture or buffer registers.

For the PWMMode1, it is just output-compare

TGRA is used for setting period and also the compare-match output is used a=
s clearing the counter.
TGRB is used for setting duty cycle.

This will produce PWM output on MTIOC0A pin.

The output of wave form depends upon setting on TIOR
Currently it is set as, Initial output is low. High output at compare match=
.

>=20
> I think I understand the following: Your hardware has one(?) freerunning
> counter "TCNT". TGRs get set to a value where something happens when TCNT
> reaches that value.

If I understand correctly, that is called Compare-match.

 In figure 16.27, reaching TGRA resets TCNT to 0 and the
> output value to low. Reaching TGRB sets the output value to high. So far =
so
> easy. (Apart from your description of mode 1 talking about four TGRs and =
two
> pins which could just be two independent PWMs (in the sense of the pwm
> framework)?)

Exactly, in the sense of the PWM framework each IO is modelled as an indepe=
ndent PWM

>=20
> PWM mode 2 (figure 16.28) is the same just with more outputs. MTU1.TGRB
> defines the period (as did TGRB in the above example) and there are sever=
al
> other TGRx that define the duty cycle of one output each which all share =
the
> same period. So if I restrict mode 2 to just MTU1.TRGB and MTU1.TRGA I ha=
ve
> mode 1.
>=20
> So I don't get the difference between the two modes.

I haven't explored PWM mode 2 much. But from the description,

In PWM mode2, there is only one TGR for setting period.
and rest of the TGRs are used for setting duty cycle.
Here MTU0 can be combined with MTU1 and MTU2 as well.

So probably to differentiate PWM mode2 from PWM mode1,
we need to add a property in device tree to link
mtu channels for PWM mode 2 operation and
then we can use pwm frame work to achieve PWM mode2
as shown in Figure 16.28.


>=20
> Describing modes (Reset-Synchronized PWM Mode and Complementary PWM
> Mode) that are not relevant to the driver (yet?), doesn't help understand=
ing
> the hardware either.

OK, will drop now and will revisit later.

>=20
> > > > This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm
> > > > driver by creating separate logical channels for each IOs.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > > v11->v12:
> > > >  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is i=
n
> MFD.
> > > >  * Reordered get_state()
> > > > v10->v11:
> > > >  * No change.
> > > > v9->v10:
> > > >  * No change.
> > > > v8->v9:
> > > >  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip a=
nd
> > > >    cached this values in rz_mtu3_pwm_config and used this cached
> values
> > > >    in get_state(), if PWM is disabled.
> > > >  * Added return code for get_state()
> > > > v7->v8:
> > > >  * Simplified rz_mtu3_pwm_request by calling
> > > > rz_mtu3_request_channel()
> > > >  * Simplified rz_mtu3_pwm_free by calling
> > > > rz_mtu3_release_channel()
> > > > v6->v7:
> > > >  * Added channel specific mutex lock to avoid race between counter
> > > >    device and rz_mtu3_pwm_{request,free}
> > > >  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
> > > >  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
> > > >  * Updated rz_mtu3_pwm_config()
> > > >  * Updated rz_mtu3_pwm_apply()
> > > > v5->v6:
> > > >  * Updated commit and Kconfig description
> > > >  * Sorted the header
> > > >  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
> > > >  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and remov=
ed
> > > >    __maybe_unused from suspend/resume()
> > > > v4->v5:
> > > >  * pwm device is instantiated by mtu3a core driver.
> > > > v3->v4:
> > > >  * There is no resource associated with "rz-mtu3-pwm" compatible
> > > >    and moved the code to mfd subsystem as it binds against "rz-mtu"=
.
> > > >  * Removed struct platform_driver rz_mtu3_pwm_driver.
> > > > v2->v3:
> > > >  * No change.
> > > > v1->v2:
> > > >  * Modelled as a single PWM device handling multiple channles.
> > > >  * Used PM framework to manage the clocks.
> > > > ---
> > > >  drivers/pwm/Kconfig       |  11 +
> > > >  drivers/pwm/Makefile      |   1 +
> > > >  drivers/pwm/pwm-rz-mtu3.c | 485
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 497 insertions(+)  create mode 100644
> > > > drivers/pwm/pwm-rz-mtu3.c
> > > >
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > > 31cdc9dae3c5..c54cbeabe093 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -492,6 +492,17 @@ config PWM_ROCKCHIP
> > > >  	  Generic PWM framework driver for the PWM controller found on
> > > >  	  Rockchip SoCs.
> > > >
> > > > +config PWM_RZ_MTU3
> > > > +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > > +	depends on RZ_MTU3 || COMPILE_TEST
> > > > +	depends on HAS_IOMEM
> > > > +	help
> > > > +	  This driver exposes the MTU3a PWM Timer controller found in
> Renesas
> > > > +	  RZ/G2L like chips through the PWM API.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the module
> > > > +	  will be called pwm-rz-mtu3.
> > > > +
> > > >  config PWM_SAMSUNG
> > > >  	tristate "Samsung PWM support"
> > > >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > > > COMPILE_TEST diff --git a/drivers/pwm/Makefile
> > > > b/drivers/pwm/Makefile index a95aabae9115..6b75c0145336 100644
> > > > --- a/drivers/pwm/Makefile
> > > > +++ b/drivers/pwm/Makefile
> > > > @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > > >  obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> > > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > > +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > > >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > > > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> > > > new file mode 100644 index 000000000000..d94e3fc36dfb
> > > > --- /dev/null
> > > > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > > > @@ -0,0 +1,485 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Renesas RZ/G2L MTU3a PWM Timer driver
> > > > + *
> > > > + * Copyright (C) 2022 Renesas Electronics Corporation
> > > > + *
> > > > + * Hardware manual for this IP can be found here
> > > > + *
> > > > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-gro
> > > > +up-u sers-manual-hardware-0?language=3Den
> > > > + *
> > > > + * Limitations:
> > > > + * - When PWM is disabled, the output is driven to Hi-Z.
> > > > + * - While the hardware supports both polarities, the driver (for
> now)
> > > > + *   only handles normal polarity.
> > > > + * - While the hardware supports pwm mode{1,2},
> > > > +reset-synchronized pwm
> > > and
> > > > + *   complementary pwm modes, the driver (for now) only handles pw=
m
> > > mode1.
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/limits.h>
> > > > +#include <linux/mfd/rz-mtu3.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h> #include <linux/pm_runtime.h>
> > > > +#include <linux/pwm.h> #include <linux/time.h>
> > > > +
> > > > +#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
> > > > +#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
> > >
> > > IMHO it would make sense to put these definitions to where
> > > RZ_MTU3_TMDR1 is defined. And I'd do it like this:
> > >
> > > 	* Timer mode register 1 */
> > > 	#define RZ_MTU3_TMDR1			5
> > > 	#define RZ_MTU3_TMDR1_MD			GENMASK(3, 0)
> > > 	#define RZ_MTU3_TMDR1_MD_NORMAL
> > > 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 0)
> > > 	#define RZ_MTU3_TMDR1_MD_PWMMODE1
> > > 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 2)
> >
> > Agreed, will move to include/linux/mfd/rz-mtu3.h.
> >
> > >
> > > > +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> > > > +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> > > > +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> > > > +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> > > > +
> > > > +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> > > > +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> > > > +
> > > > +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> > > > +
> > > > +#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
> > > > +
> > > > +#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
> > > > +
> > > > +static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2=
,
> > > > +2 };
> > > > +
> > > > +/**
> > > > + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> > > > + *
> > > > + * @chip: MTU3 pwm chip data
> > > > + * @clk: MTU3 module clock
> > > > + * @lock: Lock to prevent concurrent access for usage count
> > > > + * @rate: MTU3 clock rate
> > > > + * @user_count: MTU3 usage count
> > > > + * @rz_mtu3_channel: HW channels for the PWM  */
> > > > +
> > > > +struct rz_mtu3_pwm_chip {
> > > > +	struct pwm_chip chip;
> > > > +	struct clk *clk;
> > > > +	struct mutex lock;
> > > > +	unsigned long rate;
> > > > +	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > > +
> > > > +	/*
> > > > +	 * The driver cannot read the current duty cycle/prescale from
> the
> > > > +	 * hardware if the hardware is disabled. Cache the last
> programmed
> > > > +	 * duty cycle/prescale value to return in that case.
> > >
> > > If the hardware is disabled, just doing .enabled =3D false in
> > > .get_state is fine and easier. So this can be dropped I think.
> >
> > Yes, it can be dropped, after adding below check in get_state()
> >
> > +       if (state->duty_cycle > state->period)
> > +               state->duty_cycle =3D state->period;
> > +
> >
> > >
> > > > +	 */
> > > > +	u8 prescale[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > > +	unsigned int duty_cycle[RZ_MTU3_MAX_PWM_MODE1_CHANNELS];
> > > > +};
> > > > +
> > > > +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> > > > +pwm_chip *chip) {
> > > > +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> > > > +
> > > > +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> > > *rz_mtu3,
> > > > +					 u64 period_cycles)
> > > > +{
> > > > +	u32 prescaled_period_cycles;
> > > > +	u8 prescale;
> > > > +
> > > > +	prescaled_period_cycles =3D period_cycles >> 16;
> > > > +	if (prescaled_period_cycles >=3D 16)
> > > > +		prescale =3D 3;
> > > > +	else
> > > > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > > > +
> > > > +	return prescale;
> > > > +}
> > > > +
> > > > +static struct rz_mtu3_channel *
> > > > +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> > > > +channel) {
> > > > +	unsigned int i, ch_index =3D 0;
> > > > +
> > > > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > > > +		ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > > > +
> > > > +		if (ch_index > channel)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	return rz_mtu3_pwm->ch[i];
> > > > +}
> > > > +
> > > > +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> > > *rz_mtu3_pwm,
> > > > +					struct rz_mtu3_channel *ch)
> > > > +{
> > > > +	u32 i;
> > > > +
> > > > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > > > +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	return i;
> > > > +}
> > > > +
> > > > +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm)=
 {
> > > > +	u32 i, pwm_ch_index =3D 0;
> > > > +
> > > > +	for (i =3D 0; i < ch_index; i++)
> > > > +		pwm_ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > > > +
> > > > +	return pwm_ch_index !=3D hwpwm;
> > > > +}
> > >
> > > I don't understand that channel allocation, maybe worth an
> > > explaining comment?!
> >
> > I will add below comment just above rz_mtu3_get_hw_channel(). Is it ok?
> >
> > +/*
> > + * PWM Mode1 has MTU{0..4}, MTU6 and MTU7, Probe function skips MTU5 a=
nd
> MTU8.
>=20
> What is MTU?

MTU is name of the IP, stands for Multi-Function Timer Pulse Unit

And index represents HW channels.

>=20
> > + * So struct rz_mtu3_channel *ch contains only PWM mode1 MTU channels.
> > + * MTU{1, 2} channels has a single IO each compared to 2 IOs for the
> > + rest of the
> > + * channels. A LUT rz_mtu3_pwm_mode1_num_ios introduced to get the
> > + PWM channel
> > + * and HW channel.
>=20
> What is LUT?

LUT is look up table

/*
 * PWMMode1 channels are MTU{0, 1, 2, 3, 4, 6, 7}. MTU{1, 2} channels has a
 * single IO each, whereas all other channels has 2 IOs. The below LUT repr=
esent
 * IOs on PWMMode1 channels.
 */
static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };

>=20
> These channels are about which TRG can influence which output?

Yes, For PWM mode 1 case

From the LUT,
MTU0 has 2 IO's MTIOC0A and MTIOC0C
MTU1 has 1 IO MTIOC1A
MTU2 has 1 IO MTIOC2A
MTU3 has 2 IO's MTIOC3A and MTIOC3C
MTU4 has 2 IO's MTIOC4A and MTIOC4C
MTU6 has 2 IO's MTIOC6A and MTIOC6C
MTU7 has 2 IO's MTIOC7A and MTIOC7C

TGRA(perioid) and TGRB(duty) can influence MTIOCA output
TGRC(perioid) and TGRD(duty) can influence MTIOCD output


>=20
> > + */
> >
> > >
> > > > +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> > > *rz_mtu3_pwm,
> > > > +				      u32 hwpwm)
> > > > +{
> > > > +	struct rz_mtu3_channel *ch;
> > > > +	bool is_channel_en;
> > > > +	u32 ch_index;
> > > > +	u8 val;
> > > > +
> > > > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> > > > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > > > +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> > > > +
> > > > +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> > > > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> > > > +	else
> > > > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> > > > +
> > > > +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA)); }
> > > > +
> > > > [...]
> > > > +	/*
> > > > +	 * If the PWM channel is disabled, make sure to turn on the
> clock
> > > > +	 * before writing the register.
> > > > +	 */
> > > > +	if (!pwm->state.enabled) {
> > > > +		err =3D pm_runtime_resume_and_get(chip->dev);
> > > > +		if (err)
> > > > +			return err;
> > > > +	}
> > >
> > > Maybe it's easier to call pm_runtime_resume_and_get() unconditionally=
?
> >
> > OK, will use below unconditional call instead. Is it ok?
> >
> > pm_runtime_get_sync(chip->dev);
>=20
> Try it and if it's simpler stick to it, if not, my suggestion was wrong.

OK, will do.

>=20
> > > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > > > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > > > +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> > > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> > > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> > > > +	} else {
> > > > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> > > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> > > > +	}
> > > > +
> > > > [...]
> > > > +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> > > > +				 rz_mtu3_pwm_pm_runtime_suspend,
> > > > +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> > > > +
> > > > +static void rz_mtu3_pwm_pm_disable(void *data) {
> > > > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> > > > +
> > > > +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> > > > +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> > > > +}
> > > > +
> > > > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> > > > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > > > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	int num_pwm_hw_ch =3D 0;
> > > > +	unsigned int i;
> > > > +	int ret;
> > > > +
> > > > +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> > > GFP_KERNEL);
> > > > +	if (!rz_mtu3_pwm)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	rz_mtu3_pwm->clk =3D ddata->clk;
> > > > +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> > >
> > > Note that clk_get_rate isn't reliable for disabled clocks, so please
> > > enable first and then call clk_get_rate(). Also consider calling
> > > clk_rate_exclusive_get().
> >
> >
> > OK, will call get_rate() after enable. Runtime PM use
> > clockenable/disable Frequently, so unnecessary to use
> clk_rate_exclusive_{get,put}. Is it ok?
>=20
> One doesn't have to do with the other. After calling
> clk_rate_exclusive_get() you can be sure that no other driver does anythi=
ng
> to change the clk which would mess with the emitted signals.
>=20
> I don't know the exact semantics of clk_rate_exclusive_get(), but I'd ass=
ume
> that even if you disable the clock you should be able to rely on it runni=
ng
> at the same rate after reenable.

I believe usage of clk_rate_exclusive_get() is platform
Dependent.

We don't support any frequency scaling other than cpufreq scaling.
Peripheral may have internal dividers, but the frequency of peripherals
are fixed.

If platforms having QoS, ie, based on the performance
change the OPP for the particular peripheral domain
it makes sense to use clk_rate_exclusive_get().

One such platform which support QoS in my knowledge is
ST U8500 platform.(+ linus Wallej)

If I remember correctly, Based on the demand peripherals
can request frequency and it sets the corresponding OPP
(eg: low power audio, USB etc).

Here it is not the case.

Please let me know still you prefer clk_rate_exclusive_get()?

Cheers,
Biju

>=20
> > > > +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> > > > +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> > > > +			continue;
> > > > +
> > > > +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> > > > +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> > > > +		num_pwm_hw_ch++;
> > > > +	}
> > > > +
> > > > +	mutex_init(&rz_mtu3_pwm->lock);
> > > > +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> > >
> > > This is unused.
> >
> > Nope. It used in runtime PM calls.
>=20
> Oh, indeed. Looking that up I saw that you didn't check the return values=
 of
> clk_disable_unprepare() and clk_prepare_enable() in them.
>=20
> > > > +	pm_runtime_set_active(&pdev->dev);
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > > > +				       rz_mtu3_pwm_pm_disable,
> > > > +				       rz_mtu3_pwm);
> > > > +	if (ret < 0)
> > > > +		goto disable_clock;
> > > > +
> > > > +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> > > > +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> > > > +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
> > > > +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> > > > +	if (ret) {
> > > > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> > > > +		goto disable_clock;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +
> > > > +disable_clock:
> > > > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > > > +	return ret;
> > > > +}
> > >
> > > On .remove the clk isn't disabled.
> >
> > It is not required. It is already disabled after probe.
> >
> > Clock_enable_prepare  enables the clk during probe, Then later PM
> > runtime suspend turns off the clock using clk_prepare_disable().
> >
> > On error case, in probe, PM suspend won't get called, So we need to
> > use clk_prepare_disable().
> >
> > After probe:
> > [   15.680492] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_m=
ck
> ON
> > [   15.725015] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_m=
ck
> OFF
> > devmem2 0x11010538 | grep Read
> >
> > Unbind and bind call reports, balanced clk usage.
> >
> > Please correct me, if I am wrong or need any clarification.
>=20
> As I missed the PM callbacks you are right I think. (I didn't recheck the
> logic now though.)
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
