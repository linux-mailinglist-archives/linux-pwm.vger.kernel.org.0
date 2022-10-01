Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1159C5F1E4A
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJARNC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJARNB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 13:13:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C9E094;
        Sat,  1 Oct 2022 10:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQT9bGxya8BXKPCrtzSfTJ/nzc89iCo2mI7FkU5VpbI7CYf7T6x3SBu4eJCAZ/af2FfwikasCs1KwMCLhrA+fJxyQC6K/U4w2xhfMHVxbbB5eMgP7UTVY1qeIVl9PIb6noJvW2Wn6MOAAnzWnYcWIeWtrPyzlJk0GzSChy622WbaCKaQRYkZRpZMm2W+fbBBXW4toX/bEE2Euk6f5ROibd2QPetOXRyr2zXBssu3WA4cpYKFhW6GY1qYdCBD05zSUS5bMRiXMLC7y4TWIj+jF4VX1ncZw5JH5L9IRRHt3PvRcqOjPfRsu5OOcKJ8IG1boPn5odLTZOfCiNJ6+vHIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY2YvAu5rkc5dMSzWKnXNmbly1flB6ePSHYq1i+f95E=;
 b=Qdh62UwFTxZhiUpzZjIp+qSYLU2PdxCI5VD4/z2MXGGMQ8PP7UXxX6UEpJ+Gi2VDu2JobzDkF0fJG1HU2iIHcu+aiH1714PDiMhydiUZSXp56Wc1X1SqVQ8x+/gMqsah5ZhFNFVkwmCRCzY3hO8ww7KN7OB7sJngsBOYWJmZKJFJ1p5ZPAHH9LDP4+DTpY6jKGvs9tvLjqD9uIXq04L0F+AeYZlH45wHO/aiSUuO+UUKQALqFhbkquCgX3496tEKFU1vzOpMfppnaE3hkf7C6lDauFkRRi99Owdq5egNxfa23sEvb4vdrbrs+4xonbJ8alXXbbbPGpQ4PGa2AANU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY2YvAu5rkc5dMSzWKnXNmbly1flB6ePSHYq1i+f95E=;
 b=ih0Wa/3wRv9WePk/Am8/r172nBAltb9vX5V2w/X5X/NywTnZmwLGeiGbRzEfIn4nduzKyrzQsPB6uk5nrwo84eYL1ODB8HPSLtwaAPxzrCFVV8qtVQfUJwgSNRBJryW55seDTjoLOA+1yJGCc0hHLePh3dfk/fBd6p0D4f2ls7o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8852.jpnprd01.prod.outlook.com (2603:1096:400:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 17:12:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 17:12:56 +0000
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
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoCABD8nAIABKKwQgAAHVwCAAAESkA==
Date:   Sat, 1 Oct 2022 17:12:56 +0000
Message-ID: <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
In-Reply-To: <YzhzZiZYEKuVX3eZ@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8852:EE_
x-ms-office365-filtering-correlation-id: dcb55dd7-e776-48ec-6d48-08daa3d02f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mf1KdL5ok+dJSTFYBlEjlKVPZuojGd5GGJpny8hn5hJAB4QGJ8Bx7zp28ninMA03eofjWrNADj+azgqvQgiyfBLxlXwOLAXA27MDUFzNpZ0gOxSd8rpASFQBqhR3INBmNIXbeY3oGddCudHVINADK2goarAuptTaOGCgjF70qRxZ/zjDbkx40x1ePA2kVDfsU0S7dYOqdYeHECGVoQ8N8segU6/Sp9i06AD7RtKxhooTm4YcL3zBI6x7s5TdKJ+XxUE8B+9YOxAWqpMiqGWYDBiZwtRUrsHojUbJqlRtdAI2Hgbm8BqjR3PCJe33VFJW0jJlPzXdvtLLgsWHYJ7lnaXAxFPJ7iH8eockW3Wton8dukb2atGOASYpEwXsGJg27KVB+scjWKfRUVH/xgIWXIlubXJ0BZV7CDj0BCGnRbD9mJias55Ur0ArjR2BOy5Hw5w80JSVDwMd0wkAAgqI6E5TqcUjVpHFMbDJyndvyGSQWb6rIHvvwds3t5wjzwzVacEknopBYR5InNqy/oTS9Tw8vLo3/dNJd4dsuK7ZZZurbXAA7XULm7e/qFEA3EFzIFde6JhMeAxMSiGQN1igTrMySZD03QberBY8adkGXW8P3QLSELT8X6/BjtCrLwDULpwxmoSXxJh4U7CIhneYy/lVxjAgpSxvckz/ci2dKg3tDcQv5jCN074FyylwOp0Oevbb4xnhipJwr1C/1NknCru/2OFeu8CTJpEzhkuzB5SK9BQ3ZmybPSGn8eu86pAhTG9Yg98oenU/3TBV5W4tcU1Gz/ePWQ/WCR5D7US0ZgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(9686003)(6506007)(26005)(7696005)(52536014)(8936002)(7416002)(38100700002)(5660300002)(186003)(71200400001)(41300700001)(83380400001)(478600001)(86362001)(54906003)(6916009)(316002)(66556008)(66946007)(122000001)(66476007)(66446008)(76116006)(4326008)(8676002)(64756008)(2906002)(33656002)(38070700005)(55016003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W2FXE6qy5REQUmr4sCt4bQSiwPA56m50xOI1ODcv4dSniKQ+1skNzABVYL?=
 =?iso-8859-1?Q?DxVkzjBB+h8k1f/uzvSBDXsdyF+Dvmx3M6bpyqd/MHN5xtUthAW4VlzzZB?=
 =?iso-8859-1?Q?C/4fvepg3gnGloNaVgEVTuku5d+AMqW3ej1jCx/JXuEau+7AE6aMV6lK50?=
 =?iso-8859-1?Q?2j+SGrquCEdE+XOYjjuQB2Dk6xPTop/wi0bnMl5QsonJeOMicY3NgJSHgR?=
 =?iso-8859-1?Q?knufLjJR5PZ3JaT722JzxCtwDgKMPLxwZSlZYJ8gGKOKjQrjg0uPA6EAPf?=
 =?iso-8859-1?Q?SKXIzLWaw+Kvx2rktZLFPpug6iimon5CFMO00nFdJDyq+NCXrLB0vSmXOr?=
 =?iso-8859-1?Q?oSg+/9vz7XCSXjhbTy0Dcor2sACw1gv1BznJvw8wRxaScVsuUH2sir3/4G?=
 =?iso-8859-1?Q?wv+dqqjV1/mJtP474KOpwcwUbZPL5/9siJFGxuzZP7W8hZs4p9Bk1OOEZl?=
 =?iso-8859-1?Q?XaVgiJnbwefg8A/o2/AOOTq/6dgJxMdO48rxDMAuaDH8TLFEilHusMPFnN?=
 =?iso-8859-1?Q?zCuNZK1tOt/7hKElb7Iw30PZycbeh/G5ITMLmoMKEsivXDJ81QUepInSoI?=
 =?iso-8859-1?Q?FS+Z1KwoQRFCbIyUL2UVWq635IsWIUZ3WS9k0T82+qvbAI9ouUXSvobfFn?=
 =?iso-8859-1?Q?YU31KAk2TM3GdTM18SHWeRF697eneZrhwimH+RdAw7HZ/fo8Hmqgg03coq?=
 =?iso-8859-1?Q?DdjQif6OHkkuWmIR0fI/3+pnwiW/aTJrwyX+O7W0mWWRAaxNh7ta2Dm6AI?=
 =?iso-8859-1?Q?AsNfW1N5GhafNupmMPFPAInm4G0M5m45b3yaGzx30Op6y9bbSIe3G+SQ5B?=
 =?iso-8859-1?Q?Kpd1XeU3p+frd3ZgCDKFrUqR7pk/A7DhJwbR2Y0bTwXf1r+RrPX/WPXxnT?=
 =?iso-8859-1?Q?oODrp/RVSFbnz5L00MImdnXttZrQc6NE0jMwLzI9SSkm2QfwSeXVPwLKtc?=
 =?iso-8859-1?Q?nflhsdIRfmEGgIXlyl6ZNQ3vVM+o0DydIuzEVYfDFeVNRuhVlbiGtCIEYS?=
 =?iso-8859-1?Q?bwfpN5Vpg7vQymyD5hajQfFzvYmzMFONHnR+EPhDtgkTH4pAMYq01gKvlW?=
 =?iso-8859-1?Q?07bCfJT0EIjTz+75lYwpEjfK9Vb/fPupAMFeX15RqPs01/Dg0giuVC0xOS?=
 =?iso-8859-1?Q?Avrj+WiZBMPU91w2phO/HCe2V5QstbxfetJHUYTMU6/XcXJhocNbXgjKZk?=
 =?iso-8859-1?Q?Yl8ieZAC/c7BrY1gnQIdDQixnIrh0BhTAo6FN/2/EViTb2AocmlUJuJubX?=
 =?iso-8859-1?Q?RXlD1ODth9supL6mZ6rUUrO7SDgHJOFJKB4ZRQr4UnVc86hpOG4Hhn28vU?=
 =?iso-8859-1?Q?G+7HgRebWgsGZpFz48p1W35MJwF0NAiX+naNbGegSADwAmaxfZBm1tLxId?=
 =?iso-8859-1?Q?rGR5ZIDCGa7xoYP2p2xcV3nmhxwbCeiZbtr+pioYUUnmdX36lfVDuZ9kap?=
 =?iso-8859-1?Q?QMkwnHYVRwbdhYbGg8DXSZTsNwiwUznLE+1HerX071NNLXsCYvMIw94ytK?=
 =?iso-8859-1?Q?R4Vb+G+aBMH1np9GQSCL2TMZMM++vDxDiGWRTdvt4/DPcFCFvTRDJFJDOO?=
 =?iso-8859-1?Q?NUYhKBob2yIXKwTjlcBl7BQ4m3bqzmH6wTQZyE+EIKLhGpqePWBXA/3fvL?=
 =?iso-8859-1?Q?Dj9hoLxjNS3wWdTGI4aTnEy8dZp5CpZCkz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb55dd7-e776-48ec-6d48-08daa3d02f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 17:12:56.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igl6FdfobZAscgERq7nZQ8wRY0Mw/LMDQZxOftOliAOKbkMnD2eTCHiT3dB0k1AIOcXHokqpTywY1MkRUo7EUKqaqi36Vo+Z360F2MkCIvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8852
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Sat, Oct 01, 2022 at 04:45:55PM +0000, Biju Das wrote:
> > Hi William Breathitt Gray,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter
> driver
> > >
> > > On Wed, Sep 28, 2022 at 06:14:57AM +0000, Biju Das wrote:
> > > > Hi William Breathitt Gray,
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter
> > > driver
> > > > >
> > > > > On Mon, Sep 26, 2022 at 02:21:06PM +0100, Biju Das wrote:
> > > > > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is
> > > > > > embedded in the Renesas RZ/G2L family SoC's. It consists of
> > > > > > eight 16-bit timer channels and one 32-bit timer channel. It
> > > > > > supports the following functions
> > > > > >  - Counter
> > > > > >  - Timer
> > > > > >  - PWM
> > > > > >
> > > > > > This patch series aim to add MFD and counter driver for
> MTU3a.
> > > > > > Subsequent patch seies will add TImer and PWM driver support
> > > also
> > > > > > enhancements to counter driver.
> > > > >
> > > > > Hello Biju,
> > > > >
> > > > > I see this device consists of several channels, but only one
> > > > > Count is defined in the counter patch ("Channel 1 Count"). Do
> > > > > all
> > > channels
> > > > > support counting, or is it limited to just one channel?
> > > >
> > > > It is like this
> > > > MTU1 channel :- 1 16-bit phase counter MTU2-Channel :- 1 16-bit
> > > phase
> > > > counter
> > > > MTU1 + MTU2 channel combined:- 1 32-bit phase counter Other
> > > > channels are not supporting phase counting.
> > > >
> > > > Each counter device will have 1 channel. Currently it supports
> 16-
> > > bit
> > > > phase counting.
> > > >
> > > > Please see my test program. Am I missing something here?
> > > >
> > > > My test program:-
> > > >
> > > > echo 1 > /sys/bus/counter/devices/counter0/count0/enable
> > > > echo 50 > /sys/bus/counter/devices/counter0/count0/ceiling
> > > > devmem2 0x10001391 b 0x00 # Enable phase clock selection A for
> MTU2.
> > > > echo 1 > /sys/bus/counter/devices/counter1/count0/enable
> > > > echo 50 > /sys/bus/counter/devices/counter1/count0/ceiling
> > > >
> > > > for i in {1..5};
> > > > do cat /sys/bus/counter/devices/counter0/count0/count ; cat
> > > > /sys/bus/counter/devices/counter0/count0/direction;
> > > > cat /sys/bus/counter/devices/counter1/count0/count;
> > > > cat /sys/bus/counter/devices/counter1/count0/direction;
> > > > done
> > > >
> > > > Cheers,
> > > > Biju
> > >
> > > I'm not familiar with this hardware, but it looks like MTU1 and
> MTU2
> > > are on the same device. I think a more natural way to expose this
> > > functionality in the Counter subsystem would be to define a Count
> > > for each count value you can support; so something like this (all
> > > under
> > > /sys/bus/counter/devices/counter0):
> > >
> > > * count0 :- MTU1
> > > * count1 :- MTU2
> > > * count3 :- MTU1 + MTU2
> >
> > OK, sounds good. so count3 :- 32 bit phase counting count 0 or
> count1
> > or both then 16 bit phase counting
>=20
> That "count3" should be "count2" (sorry for the typo), but yes all
> three Counts should be defined; if a particular Count can't be
> read/written due to the current phase counting mode selected, you can
> return -EBUSY or -EINVAL as appropriate.
>=20

OK.

> To clarify one more time, do you have two 16-bit registers holding
> count values (one for MTU1 and one for MTU2), and when configured for
> 32-bit phase counting mode you combine both registers to give you a
> 32-bit count value?

Yes, that is correct.

>=20
> > >
> > > You can then control the phase selection using a top-level Counter
> > > device extension (e.g. /sys/bus/counter/devices/counter0/phase)
> that
> > > configures whether you're in 16-bit phase or 32-phase counting
> mode.
> >
> > So I need to introduce a new sysfs called phase. Use that one for
> > Selecting the external clock pin for phase counting mode.
> > Please correct me if I am wrong??
> >
> > Hardware supports 4 pins for phase counting mode,
> >
> > MTCLKA Input External clock A input pin (MTU1/MTU2 phase counting
> mode
> > A phase input) MTCLKB Input External clock B input pin (MTU1/MTU2
> > phase counting mode B phase input) MTCLKC Input External clock C
> input
> > pin (MTU2 phase counting mode A phase input) MTCLKD Input External
> > clock D input pin (MTU2 phase counting mode B phase input)
> >
> > For MTU1, it is fixed MTCLKA and MTCLKB.
> > But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - { MTCLKC ,
> > MTCLKD} On reset it is set to { MTCLKC , MTCLKD}.
> >
> > Cheers,
> > Biju
>=20
> It doesn't need to be named "phase" specifically, but it seems like a
> new sysfs file will be necessary in order to select the proper phase
> counting mode.
>=20
> Are these MTCLK signals the quadrature A and B Signals you defined in
> the counter driver?

Yes, that is correct.

Cheers,
Biju
