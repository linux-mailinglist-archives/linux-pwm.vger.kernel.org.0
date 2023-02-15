Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25765697AEE
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjBOLih (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 06:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOLie (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 06:38:34 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE9CA3B;
        Wed, 15 Feb 2023 03:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAmHRatIkVvR7wREFFpLuaznh+T2mL9dqPe7zqSNtYLJ6Ta8zGLXbzrWWgXBiJ3XALzol808ieF1WcgXYb86x+xpK9q3D809sGYB2Syic62cZNTQUVKOUJe76KAfp+cLvvs/J9vp841eLnpXmOss542P9C+qqiHrwyZaqQE6MqVbjN/z+eVrtUbMK6HnatmcmkVy9Db70UERPel4cutFE3XFvUfrhW6AYwc3fVstjj1/osvZKn02KT6yvrffXHXLlxiyCgkNXprhtZxaIkcq/1Wv9ocZUZidculaHtywz8UPGF3qiguAz/M87MMvCi0N2/XH3QzK8WCukBjOqPgQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aumMstnOuRR6PoiteXSFqUTObo9mQOLvfwMwMsh90qo=;
 b=nI3uxLGpX4Yk8LLQflDdRTmL7sp4DLfgMIvWoWN/XfUXkixuunULgPrQGP7lqEfidcUuvLa0s89Yhu7+ODsoRHYBE76NUs7SEDKBnfbKV4yukUGVnZfxHrfpjXCXrcF+HEKILOwglEeg87Ck5hE3DHZqg7/PIqifRlzXJQl4WZkKb+wAtuSH59Rc9UZrSdsq8SURJmzaG36QbyhRb7T30CgI0XU5B/3aOuNWsuafgxg6LC2wOl6LNUDilNVjrLp/qKpQiBsUUlPhIGn1etRD0Acp9DU8V581gClVtuU/Eto7s2vF4jcVOw6f5yKGELcku9OUbOgU7MHcJspXnxsMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aumMstnOuRR6PoiteXSFqUTObo9mQOLvfwMwMsh90qo=;
 b=fK6AM2kTqNGTOaE2zw7iiULOTAJYPkkGhegGmrhPGpcRpzRQUutz1Px1Isk7h6EagvErHdMoDpcWXrdBWyxdMsD90WKYP8CmEWm2oKeqrHVOvd5eBO3WB2ALvhnXcESIyjyBacRj2Q2rai6r6p52LYxsOheACVtWw1hGokO403M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11941.jpnprd01.prod.outlook.com (2603:1096:400:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 11:38:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 11:38:28 +0000
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
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgAAWbpCAABKdgIAAB63Q
Date:   Wed, 15 Feb 2023 11:38:28 +0000
Message-ID: <OS0PR01MB5922CDACE9490271D222340386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB59227E0E659C292D775474BF86A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230215105731.4yhwgdbux7mogf4j@pengutronix.de>
In-Reply-To: <20230215105731.4yhwgdbux7mogf4j@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11941:EE_
x-ms-office365-filtering-correlation-id: 1e1b4120-2ed3-4b4e-09ee-08db0f492870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCLnt80VItz86pMRpJPqzUoP5tHZBggGCAbrLVx/b6tiLgCTkpyKpLV501fFL/Y71K9684S/eSB9PyKqr/gLG0jQnfiQ4bhqioW33ugtD3mtfoGtJp4bN9v/1ZZeGVgVqQwRV+RbSdLNn/4HPweVNJinLq0s0qJEI4l92FGXtBoCb+HvV+L1L9qKJCfUZEpma+uZ44HelGxlbTvdQh3O0y1JIEQOnUCQbivoBVy2SD4/jj4XywrZYX3dHYCijWDI52umqJUO5uRZoVUbtUdaozHVf8F4DNbHZP41u6j83BGebzE13S/D+vkEO/DUNsodAn85guD0bRNgEteKCW0/kBjFmlkekSqSFOMba3WElJ603bVQhnh23DWZgvxt7ih7DNz63vlmH2ll8Tg2kwXBEUs9Qkx/z2NJ9M8CxbPUjZIMoJt9RYuYWIf7B0oO2JVguL779fr24OubfhFVflbkdxWBns/SM46BmZ27I+iGdCaJ3rUepmtMJbfaHaXf50WSS5BaOw/P6/kHLfwiAWiunbtDe0G7Xpw5PVorKDq6Y9BnvJL335lQjAbCHABM80yqGT0995DQYsy0By+dCLejTeWOOokoclcXuMCrE+Vx4KhX2jfgaZubnVvabfnDbvbpPkFPESn/6ffsp/y+/+oKZOfQBWHoA93wyj24sfP+xkoaEKNHuN/0EVN+r2RLX3a8P3tVpRVcSAjtT2dR/vFLT+sKzt5UaPHMLsw9imCJcxpNAyLdcrA+iU8YIT0Mec1Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(33656002)(38070700005)(86362001)(122000001)(38100700002)(8676002)(316002)(6916009)(5660300002)(52536014)(8936002)(4326008)(66556008)(66946007)(76116006)(41300700001)(64756008)(66476007)(66446008)(2906002)(55016003)(54906003)(83380400001)(71200400001)(478600001)(966005)(7696005)(6506007)(186003)(26005)(9686003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/mPYDOiCRCtO5BAAncOp69VUMfleTI83RHeGrVc6nNrhzdslbBZ84NTiWQ?=
 =?iso-8859-1?Q?UHshwdDN1OuMFBYtKmGs+5W/Iigcu9KmLomItzlHbrArEIGnFFI1HsI5Nq?=
 =?iso-8859-1?Q?zeX/PLPlOWojH3VpqUxhFiPqEulIoyT1ByXayqwNhkkKCc00iLUUnsL6Re?=
 =?iso-8859-1?Q?IcH/oN2IZ75u4IlgTAVUADGzZw/1TVjFu5OGNBCh+hlXmM+A57JSLFfZOx?=
 =?iso-8859-1?Q?OiP9D/040fgH1btGBbMQKD7YVsJsdhxSPJAjzrIFQR73w6RnXRLHC/H0kX?=
 =?iso-8859-1?Q?knFbMVsrbiTIpmHmfRwUQcwMGbfjx10fLEHKzwP4YxKe79+3YWYJMDps/M?=
 =?iso-8859-1?Q?runmk2f7jFYOmBxRwRstt/Gswu4yBO5q17+ogVZHeXs5MKlOSgfgzUWfdv?=
 =?iso-8859-1?Q?OP/0nxfhN298sh1CFNVtDe0vnixfbYDIPG5fpHlCQf0eE77HCZb83BHdXB?=
 =?iso-8859-1?Q?zsyrxTb6YFsq5FrqZF5QGGVDzPedAcFK4xSh0VIkAE1VJIrOnGyODD2ilH?=
 =?iso-8859-1?Q?5EK6dof9qxdFdv/czIFM3JwqZM4TPgWGWTiZ20OHe40eOPAcbLilmUJt/U?=
 =?iso-8859-1?Q?CIAj98c8oO5ru7Q7gdZbxs6BBn+0ifoMqw741tgUfDLSnAxQJvBg8rQOu9?=
 =?iso-8859-1?Q?DTC4yRsi/7ivSsPVHxVw/u7ICFSwnHGvzDJjTm/vZuFbtDrs7cgUyEIKep?=
 =?iso-8859-1?Q?amSZsQbIN9vHTrFxlf3L5u+koncqK6oDQdoMauXEDeLFCJczwSyw7WGjRe?=
 =?iso-8859-1?Q?Mv1Nn5XhvfP3by5+shR2+zC3mXGnXptJIVSRYjjpD6PLP6EfVCJXqEAFsn?=
 =?iso-8859-1?Q?1pYWhu0QYoia6PNOzwR1awpJVzsnRfePLoPLrfwkaMb18attZEpSMvVjyK?=
 =?iso-8859-1?Q?GYV/z4kbJ7dc/xJIbE96oTglB4DdpalVmsNZxurFrlgwevTgFVlhd3mClv?=
 =?iso-8859-1?Q?ONbsV5BmScJvixUYEp5BTjM/VB2TC9oEz9YsE8Y+1OmSEkSKw1WF4omEoV?=
 =?iso-8859-1?Q?sWpen0NcTS9BHOinzV9Lu7kS1OmXRqY6AFuj95PCcpcuCFEf5GsqjtL7g7?=
 =?iso-8859-1?Q?eOECQDAfzPMXHkAgb2//TEMKCS54r7CwOkSFpq0WT6vJ7b97xYUpAagpRQ?=
 =?iso-8859-1?Q?ZRQnBaRHsWc13ATj7OyMYgTEC5OIo2hQGkh8OJhZQs78BqOpGXPrioY3u5?=
 =?iso-8859-1?Q?lk1SGQfZ2LjvSlmkorylg3GcOnWC1RuK6+3lYjLtgTUWqtHckbydVb2tFl?=
 =?iso-8859-1?Q?3VuIqmgVfx0ArEpIe6bYLCER+P8iPoq/yXD2MmJ75v5bj4ayVO1uuIfHYp?=
 =?iso-8859-1?Q?AgwULTAyu4kyhCGwPabC4TunM8MMOsc6r64DdJFeqJzR+4aeAfm+pwKVak?=
 =?iso-8859-1?Q?KTypC0njLhQL18QoEEzJyfrC07FdEYF6pJ3N3NZCYNpyeIQRo1wd/Uj9Ak?=
 =?iso-8859-1?Q?VkLHm0EX13BoOFfuU3M3xHdO34RSc1Ta1+ZiiBEze+7sZrW2mnD5TK8NOP?=
 =?iso-8859-1?Q?28BwPicIzH3VlbPhnSeg8UwQnDQCtBPEWtSRrF7aKGhqswEGNXDQ3G5Djl?=
 =?iso-8859-1?Q?S6wZ9eTJJqLgwTkW0yrR0ZqILseHhulMgnwg7RdODn9+0WWwgldFBNsQho?=
 =?iso-8859-1?Q?UKOxcXyzirxUSszQh2VFyjnm/X7WUmbgZyG/P2U0Fxj/GbCqofSC4/Ng?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1b4120-2ed3-4b4e-09ee-08db0f492870
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 11:38:28.8361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ru0NB563ubpso3npUpDHG9BpU0Y7pcdb9jLdg4TqkzfZudJWO4FTtaFaECC1WUM2phSYzZm7iz1s4jilL2VuNpz0XRoIumQTpUoe88nPy88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11941
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for feedback.

> Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello Biju,
>=20
> On Wed, Feb 15, 2023 at 10:31:20AM +0000, Biju Das wrote:
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
> > I will give some details about PWM modes mentioned in the HW manual her=
e.
> > I will respond to other comments later.
> >
> > PWM Mode 1
> > ------------
> > n =3D {0,1,2,3,4,6,7}
> > MTIOC0A:-MTU0 TGRA input capture input/output compare output/PWM
> > output pin
> > TGRA: Timer General Register A
> > TIOR: Timer I/O control register
> > In PWM mode 1, PWM waveforms in up to 12 phases can be output
> >
> > PWM waveforms are output from the MTIOCnA and MTIOCnC pins by pairing
> > TGRA with TGRB and TGRC with TGRD. The levels specified by the
> > TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and
> > MTIOCnC pins at compare matches A and C, and the level specified by
> > the TIOR.IOB[3:0] and IOD[3:0] bits are output at compare matches B
> > and D (n =3D 0 to 4, 6, 7). The initial output value is set in TGRA or
> > TGRC. If the values set in paired TGRs are identical, the output value
> does not change even when a compare match occurs.
> >
> > PWM Mode 2
> > ----------
> > n =3D {0,1,2}
> >
> > PWM waveform output is generated using one TGR as the cycle register
> > and the others as duty registers. The level specified in TIOR is output=
 at
> compare matches.
> > Upon counter clearing by a cycle register compare match, the initial
> > value set in TIOR is output from each pin. If the values set in the
> > cycle and duty registers are identical, the output value does not chang=
e
> even when a compare match occurs.
> >
> > In PWM mode 2, up to eight phases of PWM waveforms can be output when
> > synchronous clearing is used as synchronous operation in the channels
> > that cannot be placed in PWM mode 2.
>=20
> Why is PWM Mode 1 about two outputs? These could be abstracted as two
> individual PWMs, couldn't they? In this mode you could implement a phase
> shift, but the period is limited to the overflow time of the timers.

Please see the PWM Output Registers and Output Pins below [1]
[1] https://paste.pics/7086f969d99b3205b8287e3b328529b9

Here same MTUs have 4 TGR's, in that case it has 2 outputs.
Where as some MTU's have only 2 TGR's, in that case 1 ouput.

Out of 2 TGR's, 1 TGR used for setting cycle and other one for setting duty=
.
Please see the waveform for PWM mode1 [2]

[2] https://paste.pics/44d75192ca0a8926fdf37796e4fe2915

>=20
> In Mode 2 the period is more flexible, but no phase shift is possible (ap=
art
> from inversed polarity).
>=20
> Did I get this right?

Here there is 1 TGR is used for setting cycle and others used for setting d=
uty cycle.
Please see example[2] in pwm mode2 outputting 5-phase PWM waveforms.

[2] https://paste.pics/025f67e874d655d3eebff65ccc123970

>=20
> > Reset-Synchronized PWM Mode:
> > ---------------------------
> > In the reset-synchronized PWM mode, three phases of positive and
> > negative PWM waveforms (six phases in total) that share a common wave
> > transition point can be output by combining MTU3 and MTU4 and MTU6 and
> MTU7.
> >
> > When set for reset-synchronized PWM mode, the MTIOC3B, MTIOC3D,
> > MTIOC4A, MTIOC4C, MTIOC4B, MTIOC4D, MTIOC6B, MTIOC6D, MTIOC7A,
> > MTIOC7C, MTIOC7B, and MTIOC7D pins function as PWM output pins and
> > timer counters 6 and 12 (MTU3.TCNT and MTU6.TCNT) functions as an
> > up-counter
> >
> >
> > Complementary PWM Mode:
> > ----------------------
> >
> > In complementary PWM mode, dead time can be set for PWM waveforms to be
> output.
> > The dead time is the period during which the upper and lower arm
> > transistors are set to the inactive level in order to prevent short-
> circuiting of the arms.
> > Six positive-phase and six negative-phase PWM waveforms (12 phases in
> > total) with dead time can be output by combining MTU3/ MTU4 and
> > MTU6/MTU7. PWM waveforms without dead time can also be output.
> >
> > In complementary PWM mode, nine registers (compare registers, buffer
> > registers, and temporary registers) are used to control the duty ratio =
for
> the PWM output.
> >
> > Complementary PWM mode 1 (transfer at crest) Complementary PWM mode 2
> > (transfer at trough) Complementary PWM mode 3 (transfer at crest and
> > trough)
>=20
> These two modes are more general than the PWM framework supports. There w=
as
> a series some time ago to implement settings with two outputs, but we did=
n't
> agree on an abstraction and the effort died. So for now these are out of
> scope, right?

I haven't investigated much on complementary PWM, but our Verified Linux Pa=
ckage (VLP)
for RZ/G2L supports it.

I have a plan to add support for atleast complementary PWM mode with output=
 pin
protection(using POE3 module) later similar to GPT[3] with POEG [4].

[3] https://lore.kernel.org/linux-renesas-soc/20230113122343.769329-3-biju.=
das.jz@bp.renesas.com/
[4] https://lore.kernel.org/linux-renesas-soc/20221215213206.56666-1-biju.d=
as.jz@bp.renesas.com/

Cheers,
Biju
