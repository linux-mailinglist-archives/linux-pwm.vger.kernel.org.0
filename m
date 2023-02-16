Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6F6995BB
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Feb 2023 14:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBPN1T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Feb 2023 08:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPN1S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2023 08:27:18 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C7552A8;
        Thu, 16 Feb 2023 05:27:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdYdTiR9PP5byuKbelZpGy7aYLu4WTTfkfXfHI0ilFuPCF0nEfUdizcZMeDkIbqB5l/ejpLRodzY2r/Anoh/Kw05Q0UnZKm4H0tTET1Oj4sPjQFukLmgJO88Ms3+SPITpntWdcojk+M8or7v8Wp1sGK4hfvw6UskoBs4uXxPTg3FwGUO/rh1Ondcf+zE9xsBA5qT9XXOuaeVIglGl/0gsP/NwPzlBRpu/btoBAlgP+k9zWOaTfmfaQoFKXbu2nlJS2FSbU8KU1AHapMqjWQaVp/7VWhgXGJX1kDP1xTj0bJwOrRLiZFsLOxlT70X2N2yhQT/THI8DCgBmU3s+BH9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV3UHyjMxT6M/BUFdV7F1QegpDoIJoAXtUS//GQK7F0=;
 b=L6j7VjK2yztpd3eTzVWIsmo5yDYe27Kv7R7DY9V0/WlKn9bWdJSUsvwIaM79Ps9egqD6+a3W1u25gztixw8mmXgAZBolWYQZ/yM592SmSnPZQcgT838Ni5ZeRLsYrXXVcUm45JHkYf040TKirviRAdx1BflDebxkQR2gchyiWO5hSGDM2amapae7N8aAFcUCKcDxE0WhQd0XUDCRSsAq4ccmIgrC+p82uuWSaIxYjlnSeZBPpuM/rwAhA0FdqGU4v2SETe3Xr5Z0GnyCm9vU0P9bliDdL558DdbZ3bvQJwiI2v1r+m2kPZbT9ydeO22BGWkTzHFEHpqTMAdZK0ucRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV3UHyjMxT6M/BUFdV7F1QegpDoIJoAXtUS//GQK7F0=;
 b=XlXyi95vV+rZKbWYuHIi8D3809DxPtRSd3+bqYy2rOB3Bnawao8PhoR2ylHqXobJGsx7ALTZDV7aSDazRD6YugaSvP+xcMlwk+NXJ/l/YawRZYVACggJZaGaL4UW9+Zalsvr5cGVgFwtrB7jFQXadh9EaoLk60pFffWT1vQLgD0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS7PR01MB11792.jpnprd01.prod.outlook.com (2603:1096:604:23a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 13:27:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 13:27:02 +0000
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
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgACrzUCAANvjgIAAEdMggABIYICAAAG4cA==
Date:   Thu, 16 Feb 2023 13:27:02 +0000
Message-ID: <OS0PR01MB5922C6D68CF696765D49308B86A09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230216075231.xnmblxocmlsab5nv@pengutronix.de>
 <OS0PR01MB5922D010C619D3A35564CF6386A09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230216131521.ruc227dcdqcy4ulj@pengutronix.de>
In-Reply-To: <20230216131521.ruc227dcdqcy4ulj@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS7PR01MB11792:EE_
x-ms-office365-filtering-correlation-id: 09909372-8f74-4a19-a3b7-08db10217d0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oeQBhbPnmS/EUEYZ99DOrMgERsHvLNHRDOpGvRwiZkHzQcashgqzLybMw+1C8xaWNRWuAh9090+5H5/pViOuDFZFmfAGKIBJymesN4QJiTJKGplZTOV2SH4xzpHWhi6N5SnC5telxXwgEMaED4olpXxksrZd5NuG/4br4wkqKN6TlJngpAB7hza2j4BwZtCSEx2sHX61YCguFH0NwQ3LzhLIFePru11/82et/6cnoKyE6Aw6C3+bOlD2MI2g8a6hNtrfECdiA/PpiGNKr+jYX/u9eakqJvHUvCg8vVKs5LoPpg5tNM6gw1B14CgRZXgQY8IirHlhdOXyq2AOOFbyzqS2oXWcIWzkhWZkIF7dcIfYnmDwIl6ZLTbg9u+pF+a92z3n+qgmRMIdaKmeVWLk9avX7QCFrahvCnXmmZocf6RTLgewNF+ftbKqBR6Rfr3/YD4sTZ7fqN5D2Rlv5nHFfqvxCMCDuthNY9MOmb76hg8osWYYMa6DD9Rb2dGHhkVw/QWXG06xMov0cWfLflWCdhl25LjtwEBVVymkhk1KwjH++HtVPMpXqHvEUWU1QyA0XROLYIxkQ7xc74DNM+iXiGaPiQOhhM/meT+26sy0wzwnjwccKgp1GI4+74A1P2NEeb77PgM+wxYeb4K4PJsPL4S6FtVSmuGBmPL0Ah1J0jfRsGXDn9CEEufYjWj9ElvV305AzmXcWQYZyhIxNpiwaqnf3h3QQVIDlCx9PlsdYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199018)(66476007)(38070700005)(64756008)(83380400001)(76116006)(66446008)(66556008)(8676002)(6916009)(4326008)(41300700001)(38100700002)(316002)(8936002)(52536014)(66946007)(54906003)(7696005)(5660300002)(122000001)(71200400001)(86362001)(33656002)(2906002)(55016003)(186003)(26005)(478600001)(9686003)(6506007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BN+0kbsEDvtvWJ6uXh8bigW/VJXmemTTUVn5TaS5yCLVoLX0r2Ezp3zRHJ?=
 =?iso-8859-1?Q?PABxS9JoeCaRqjpulkWMigvk41jpV3DHh8z/6SJk/qLvTeKNskP5wgG/7s?=
 =?iso-8859-1?Q?oTssTBxPevhqM5TrXnlsckf0CZVHj05LQc+SCEXQz66GTe0wHFkeNuaSEw?=
 =?iso-8859-1?Q?qj2zunv2dF9jmOzYMsoqyB+HUNPW/0K+5eNitWk6syV0sauFiFpzUcAWdm?=
 =?iso-8859-1?Q?ePonuFzqdCfcvjovbvIwy8w8SlJquYj5TnhVZpWc32Yr/4vbfTDd1JszZl?=
 =?iso-8859-1?Q?1W6pbPrvnegxwVsEE5GjQgzNJbbX2UjZXu4cZszEUZfwQp0XehvriMMYfA?=
 =?iso-8859-1?Q?1lBF+68c3X8aaqGvOuVLloLrGpWdjhiJLlZUbOSIeUxVP1D3k+QQFPNcbM?=
 =?iso-8859-1?Q?EzEg/Btuz2L8P2SB9aNCFZZErjJzIhZ766ftIBk0LgFQnU8GdnSIeSqESb?=
 =?iso-8859-1?Q?KVOBDMsS+bVyTTssxBbJW1svHVAKRwuwNppI0ccCDPyREQQ+3CkOmuMo/I?=
 =?iso-8859-1?Q?4Bsqsa/W6NcmMIdSRC9VEOPw2AlUgzjZgW8HKvdNE++RC0wpFys3mvfGcp?=
 =?iso-8859-1?Q?3Kpo/1nBkHRtCW4WBFeT9SW7j6RsOU9GuvKWk0vInFS3Jq5Q4OOjKK6Wkp?=
 =?iso-8859-1?Q?/kkgjCueW3AlV9Y29DNS3eLGs2FvO0bBOTps0vZkhkg5cfT/D30BwCAP5M?=
 =?iso-8859-1?Q?GzWaVSKp6Iv2ZWNYIIzjVK0rQnNkL8LezpOgynjF02c8RrYxQl/20t1RvD?=
 =?iso-8859-1?Q?Y/Uc8g2FVLXuYLVCKn/L5PQuRFQtDbxSj8hljMaVRtwShBbv4Yb/anRtff?=
 =?iso-8859-1?Q?WkCm9zvaHC+SqKC+vczrvqaslE2G7+QGUY4YWajxnPKg1e5ODokAGhlDfq?=
 =?iso-8859-1?Q?N3GhC5U1dcTJMAYuRTJRx+DIcd8ISn59NNfiBuCBoMbXsIU+8FXnWVDiTS?=
 =?iso-8859-1?Q?TeiwMDmatIHq9MubJIa09YUM6pzT4hTjGqEUvvnU3G2vtmvH7QNZC/WYMs?=
 =?iso-8859-1?Q?zFEDuJpic5JbBGVLAtuF8tyIOWsBObX+87/wsTRCG0NZHhqxp8o85QRBTr?=
 =?iso-8859-1?Q?ygy3UE6To9GTG7Lf5qr9O2X2zN1p973kh/3TOX+dnVmMABACCPeYVKGbEH?=
 =?iso-8859-1?Q?kW0cgO/j7mrTmhj8OssuaCndnU+krOKXtdwShz+11LqPhEdDWFk4Vc8PP/?=
 =?iso-8859-1?Q?G07iUiu0JSiq8w63pjEdIYYb4hBNLRR1YwehC44YbFQYdL8rWzEEZzXf9X?=
 =?iso-8859-1?Q?fhFoZXXhp81duFZtXyJO36O+NNT8nl3FwaDGisixII4QLRT0Yq0ORWz24s?=
 =?iso-8859-1?Q?XNoCAAN70qvyfgRjfgQohlzZBdMrd1BNb2z3WLelqnNhKPdGOOTaR4t4g0?=
 =?iso-8859-1?Q?RqApkNGpvwbegBLFRnGFLVXU30VqZ5ev41qprB5R7odinE89Yc0pCWmnb0?=
 =?iso-8859-1?Q?dDjWhTR7U5hsrZQ6a/8f2NH7HGyK//xsfGn/rCgLwb/qjxqTDSxtYPI7nL?=
 =?iso-8859-1?Q?vqbjZFcCFA3Mcn1s0Yoe/i0ZCBxUaiiiLoOgDDxWbxdYk2yKI+I43Weais?=
 =?iso-8859-1?Q?8+nKnvF4ni41/cqqBrR17R0Cz73hqMt3K/lscx3V5KKKvvwtFboqNn94Xy?=
 =?iso-8859-1?Q?wtJgWFztTwN3lRmzBW3NIEEX/vKLUkWnKd6MeEbST6cEP3U5F4W+nYkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09909372-8f74-4a19-a3b7-08db10217d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 13:27:02.0402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pICIOluBuwZUu2KHfZjrMz7OmJAKRQg8jxp5BdhkIrojh7OQ78nMh07WWBtQLOcE436u7Ff7xWRQSiRUtS9fu59RA0zwE5/G+QmxPtPLnPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11792
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
> On Thu, Feb 16, 2023 at 10:06:42AM +0000, Biju Das wrote:
> > > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM
> > > driver On Wed, Feb 15, 2023 at 07:14:12PM +0000, Biju Das wrote:
> > > > > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM
> > > > > driver
> > > > >
> > > > > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > > > > Add support for RZ/G2L MTU3a PWM driver. The IP supports
> > > > > > following PWM modes
> > > > > >
> > > > > > 1) PWM mode{1,2}
> > > > > > 2) Reset-synchronized PWM mode
> > > > > > 3) Complementary PWM mode{1,2,3}
> > > > >
> > > > > It's unclear to me what "PWM mode1" and the other modes are. I
> > > > > suspect this is some chip specific naming that isn't
> > > > > understandable for outsiders? Would be great to explain that a bi=
t
> more.
> > > >
> > > > Ok I will add below to Limitation sections. Is it ok?
> > > >
> > > > PWM Mode 1: PWM waveforms are output from the MTIOCnA and MTIOCnC
> > > > pins by pairing TGRA with TGRB and TGRC with TGRD. The levels
> > > > specified by the TIOR.IOA[3:0] and IOC[3:0] bits are output from
> > > > the MTIOCnA and MTIOCnC pins at compare matches A and C, and the
> > > > level specified by the TIOR.IOB[3:0] and IOD[3:0] bits are output
> > > > at compare matches B and D
> > > (n =3D 0 to 4, 6, 7).
> > > >
> > > >
> > > > PWM Mode 2: PWM waveform output is generated using one TGR as the
> > > > cycle register and the others as duty registers.
> > > >
> > > > Reset-Synchronized PWM Mode: In the reset-synchronized PWM mode,
> > > > three phases of positive and negative PWM waveforms (six phases in
> > > > total) that share a common wave transition point can be output by
> > > > combining
> > > > MTU3 and MTU4 and
> > > > MTU6 and MTU7.
> > > >
> > > > Complementary PWM Mode: In complementary PWM mode, dead time can
> > > > be set for PWM waveforms to be output. The dead time is the period
> > > > during which the upper and lower arm transistors are set to the
> > > > inactive level in order to prevent short-circuiting of the
> > > > arms.Six positive-phase and six negative-phase PWM waveforms (12
> > > > phases in total)with dead time can be output by combining MTU3/ MTU=
4
> and MTU6/MTU7.
> > > >
> > > > In complementary PWM mode, nine registers (compare registers,
> > > > buffer registers, and temporary registers) are used to control the
> > > > duty ratio for
> > > the PWM output.
> > > > Complementary PWM mode 1 (transfer at crest) Complementary PWM
> > > > mode 2 (transfer at trough) Complementary PWM mode 3 (transfer at
> > > > crest and
> > > > trough)
> > >
> > > I read it five times now and still don't get it. The problem (maybe)
> > > is that there are many abbreviations I don't understand. Most critica=
l
> is:
> > > What is a TGR?
> >
> > Basically it is Timer General register(TGR) functions as either output
> > compare or input capture or buffer registers.
> >
> > For the PWMMode1, it is just output-compare
> >
> > TGRA is used for setting period and also the compare-match output is us=
ed
> as clearing the counter.
> > TGRB is used for setting duty cycle.
> >
> > This will produce PWM output on MTIOC0A pin.
> >
> > The output of wave form depends upon setting on TIOR Currently it is
> > set as, Initial output is low. High output at compare match.
>=20
> Then I suggest to not talk at all about mode 1 or mode 2. Just mention th=
at
> you use one counter and two match components to configure duty_cycle and
> period.

Agreed.

>=20
> > > > OK, will call get_rate() after enable. Runtime PM use
> > > > clockenable/disable Frequently, so unnecessary to use
> > > > clk_rate_exclusive_{get,put}. Is it ok?
> > >
> > > One doesn't have to do with the other. After calling
> > > clk_rate_exclusive_get() you can be sure that no other driver does
> > > anything to change the clk which would mess with the emitted signals.
> > >
> > > I don't know the exact semantics of clk_rate_exclusive_get(), but
> > > I'd assume that even if you disable the clock you should be able to
> > > rely on it running at the same rate after reenable.
> >
> > I believe usage of clk_rate_exclusive_get() is platform Dependent.
>=20
> Yeah, it depends on the platform if the clk will actually change behind y=
our
> back. But making it explicit that the clk must not change is a good idea =
in
> general. Your driver might be used later on a platform where it matters o=
r
> it might be used as a template for the next pwm driver.

OK, will use clk_rate_exclusive_get().

Cheers,
Biju
