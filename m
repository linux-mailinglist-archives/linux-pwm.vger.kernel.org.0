Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1895E8E5F
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Sep 2022 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiIXQKp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Sep 2022 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiIXQKh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Sep 2022 12:10:37 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36F27FD1;
        Sat, 24 Sep 2022 09:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArXTaZAG6m5OUG11qgFLKlaO3KkTqmSCLH5Kej0uyb8l310H+sNeMsInIC5fBhl1eOIm/kc250pzfkdXnMJfgAl2ii3M3mSeLlp5enJT66eV+Kwn4Z7ZTV9IlZ+sPxjoQcJjrOsf1KL7SBW/laeh7LCM5OGsiaFIX57UYshZBkR+CkYGTcin2oXoxv5w7zM2HJNdNASksNex5g1qb5AlOVLMtnA7UpRWzZuGnnd12CzFBkWSXLig43FChspdMJhRupqSPcvSyMkv0JKPmNMb0x7gTQhHEVQMYWbDx8FQ6JOQjQcJ446COIqcSRbFtjHIw61+D3LbGtg8PSaNkHHniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/K3oW4GtYXsu8ArAU4EHlRNXyoEdxqwHRyx8WQLhq0=;
 b=CbMuKiKiqadqDsp1ycSewNjS6oBKjl1W7JjfW/t1MZwhnAlztdfLwMnJBz/sRUR+zBJIqeSNpKyEfoSNMwsZJ1PKcl3Q0BstzWPfmWuHaxKqVxFCH77eKm/orHwmwueH3/7Po46qvqIw5hXdwWUraf1DxT/3Ukk3PuIOMVwS7pvr50IwGp+w1rAYii7KNswHqPEQShEkds055u+VUh0t8F7OjD1LUQKTiqGCI6TgE8IWTafDNBvzq7Ftlrhi9ObX/hFxN+gEGXgRCL7dzVSTY13ldju2626uGL1/1lwy3oiych92Pq49/X80jlRyfLiSgvCoyQpHVVcbcV7PwwwC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/K3oW4GtYXsu8ArAU4EHlRNXyoEdxqwHRyx8WQLhq0=;
 b=qZHfZcnwBnTNE6r+L4PU9Td8CubMpbZjCxMDraKo00X2I7jEM7xrbPVDQqpkA5NEHVM3s4/34jn1RSvyXpNeiEHUsaiGByI5Pf1SRbHwwqs1c/9B8t/lCh4ZLpJEh/v99EqZ8YQmVF6zHBpqxeGq1Tv7GRiOtIZyA/0Tq7cVwVI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9418.jpnprd01.prod.outlook.com (2603:1096:400:197::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sat, 24 Sep
 2022 16:10:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.023; Sat, 24 Sep 2022
 16:10:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3CAADBRAIAAALaQgAELnoCAAAmiYIADcXiQgAAxe4CAACM10A==
Date:   Sat, 24 Sep 2022 16:10:30 +0000
Message-ID: <OS0PR01MB5922B479EE78E840DA9B8F0E86509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de>
 <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de>
In-Reply-To: <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9418:EE_
x-ms-office365-filtering-correlation-id: f23be800-5c71-4b7b-dd8b-08da9e474d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/+I0yaUxFWH8WsYdbvvAIxRi0a78nIREhrKvo9yY8WJHX2MTLbAZ1VtjYI3Qa/3BzpnSd3jsjeYFORr/dNoLEXxttGvvyMFlDIysJaKoR7iGq91pTEHamgTiNhzD15cJRfiZMXFd3+XEAKxpT8zXsSUFZdJJjOZNOdsYCDlYVkKX5Vd7sf3/IfsFzVr44rsHP8L797YddjvwGCgPzoXQM26xt/ViAxhGLYoc220pDgIiJhuyQAoZdDBLiteTmysyMM/pQjQmJtoMTO0Q/WI3289qwE6PU6MLDCGJBmwC2MJl4sFC8qE2MFiSHscSZdCKu4Xl4bvh/aSDI43echBHQCAqFs5BRdoR2cegqoTwojnhuGNeX/9JYIVJJIrjsr0g6/mhywLT+XfUPhwjDE/PEG4B0+voIGgTU/qydbnDcdiXHxIaQBCCiffTnjHYQEKJoD+cQcLgKskdDBwrhODzDdVQ0uSScG9Iimk5gnWbxW5dDDliLnRn+j8EMEp1r7vHpm1nkzs0qTsuDB95FO2TLYpjKCQMn1+W67bm0Pi24rxU+CkhQ/aDYXcgN7E7+w4gwg/t/TC+z2jrw/utVkWxRzMJx0UQmrSZuBF8avNOKswg5V/xCEsabUwAjScvp7qwb1oB89230GsJftd6IYjG7+f8IcSDyLnjOdXbXm80yctGDVbD35k0+AfqIe94mM1EEI7gddjRF5qbRzHJG2XC5xIxXTff+8y3+swAHpcF56TN9/indXkAA4CEFRU75IkfRP8Y9/DdM/5vHCVI9JD87WSIK+IGYPUqA3MAEFTxG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(71200400001)(38070700005)(2906002)(186003)(966005)(33656002)(316002)(66446008)(38100700002)(41300700001)(86362001)(7696005)(9686003)(54906003)(6506007)(478600001)(8676002)(76116006)(64756008)(66556008)(66946007)(4326008)(66476007)(6916009)(5660300002)(52536014)(26005)(8936002)(83380400001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6SF3iy+Mi16i+LYhrI/K/l7yQxgIPGUYF41tE+p4ipiDDOr4dZVOfmr8/K?=
 =?iso-8859-1?Q?v+6SxM4wqfsnMuBtlKJbsLTHjB1cGamPkFuiStkw3yjGqzSAtpzpY0D3a+?=
 =?iso-8859-1?Q?jC/sEoW4yMcGdyyHwLM0Scxre8rv0LQXofVpeQ/3j0NGJIDyQvLzHqMhbT?=
 =?iso-8859-1?Q?/0+VJ/Q4R5UOazV7ac5k/j4gmmtSsbjthQiAY22gjtt6TECC60dmkp6oTt?=
 =?iso-8859-1?Q?k/7I5MG3wHhDXag7AKsVQ+BlcMQf+O9CUh732NKd1w6KkEa0p7HVQo+q4V?=
 =?iso-8859-1?Q?vkyPryH0QWs18yLGIDPDlO/wtN+Uj09+y4mz5H0fpVMQCF56EyV8li5J0o?=
 =?iso-8859-1?Q?iMrBZhqMPULivNtuTozRQk/nlljPsN4AL0I8Plr6FVQdooENBYbn0HITGX?=
 =?iso-8859-1?Q?AJ9NDThkC3vmWVBGZgPZnkjgV3fwujCjh9zsapfmOkXdjyJt4iK5ze76v5?=
 =?iso-8859-1?Q?h9pJfb6tvCCZJnCnNhOn+jwvrmirzujWrSnJCfclEF6p2WFHa+dBdr6IE4?=
 =?iso-8859-1?Q?WEuLAvOu7yfIOj69ooLulNGja+WUBM1muuvaycNa8U0nGDkpbxMX9YDFdv?=
 =?iso-8859-1?Q?Any6jHXEIaKS+DfVyWdc6ufMo+QH418ZICS4zqrjo3rwMxXJEFkRC7EWO4?=
 =?iso-8859-1?Q?7TCKvXXRV0FIBgEjUUqVXufUo+pkLOku24hKBI0sA/wylA4F0YHkm7Cg/I?=
 =?iso-8859-1?Q?Vt3qDdeeBMpqlRXLh5UwYmHp7IYIp+TuIXVml0HIj2c2CLp2snvdy412g2?=
 =?iso-8859-1?Q?i0wjLGJGYtjrgU95n/BHSDMOdo63HDNWqS56Vb2K89if1sc+zX8QsvLWHf?=
 =?iso-8859-1?Q?Yf2WTYYHWMzHonm3z6kN1aBY4eCsa1OQHrV4A6bkugWrteyBvNdfwbP+VL?=
 =?iso-8859-1?Q?myPvO5VuE3c8clYU2mcxnXAk0m8bSXH6RasvifUjbX/gefcASTeen9SRcY?=
 =?iso-8859-1?Q?UE0f4WfBm116JR/2vYo+lPiMbbhr2R0ZEmtnFFaBcQFhYScjVr9W0DEsQC?=
 =?iso-8859-1?Q?ZNdfqG265aZrSVv3d9Fzi71jr/PgdGpyg++PeRtkHacwJ5mBUE04OElUZi?=
 =?iso-8859-1?Q?jQjqJksvhK6JsIre2qdtriAB3Tb86k+nHda/u3qvLjqYUmtFhL8ZYdxXtg?=
 =?iso-8859-1?Q?66bt0zdpk8cKEdNVNfw+eNrSfGcj99Bd6eZA9dyErdzMSeioaWcMCbb/kt?=
 =?iso-8859-1?Q?4yfLR6D/aczDiEos4ZCZquDdl5zavK8y4VxJRDkmpa5ORpNNbDUzkmDRZb?=
 =?iso-8859-1?Q?KugOhPd6t5YEnAOg341p8nfmu+dgWEEvD8rnMWexGrMZ9ZEBVba+7zxzlu?=
 =?iso-8859-1?Q?a/LcG2txXBtrXVop6UzezmxGmLxvohRVxz+P7julTTlZRlpFwj+4z90Xb/?=
 =?iso-8859-1?Q?nZOylWe3hYlH1lZgrgBaUjvGroTbS6ozH5OvuPfDqrXofEgV1ok8jnZtp0?=
 =?iso-8859-1?Q?M+bt8T5k7O7BL3fD7b6UkNmfEirOjypex7R+Y1+1aimPGfDBVUOs/NqSaa?=
 =?iso-8859-1?Q?SycOuDDka0QDS2KK80GDBVjbsHrqziLcDu/qzCczGBz1SeMsde+NYBZqXy?=
 =?iso-8859-1?Q?Pa1y7SfEFoA4ONYlQciN/6yxu9rD9Rod9ReuKNgPonjAKVNQI8fueBH9YA?=
 =?iso-8859-1?Q?xZFrqpV4bT2XNqFelJTMpMMPtNJ78pFjYDkzjfaEjNA1VIBvOhuFfF4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23be800-5c71-4b7b-dd8b-08da9e474d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 16:10:30.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAvBRbCtADNJg6L1InWSWwgSj5oIXqLbxuiU9+CcEz48Kobg6vy3jsMCwQ1nje/LXZAa3vwL3gQ8mzQT1oNROCUOvDbTgyVdeKLobmhxles=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9418
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Sat, Sep 24, 2022 at 10:53:30AM +0000, Biju Das wrote:
> > > Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hello,
> > > >
> > > > On Wed, Sep 21, 2022 at 01:46:54PM +0000, Biju Das wrote:
> > > > > > Actually it's worse:
> > > > > >
> > > > > > - When both channels are used, setting the duty-cycle on one
> > > > aborts the
> > > > > >   currently running period on the other and starts it anew.
> > > > > >
> > > > > > (Did I get this correctly?)
> > > > >
> > > > > I think, I have fixed that issue with the below logic Which
> > > > > allows
> > > > to
> > > > > update duty cycle on the fly.
> > > > >
> > > > > Now the only limitation is w.r.to disabling channels as we
> need
> > > > > to disable together as stopping the counter affects both.
> > > > >
> > > > >       /*
> > > > > 	 * Counter must be stopped before modifying mode,
> prescaler,
> > > > timer
> > > > > 	 * counter and buffer enable registers. These registers are
> > > > shared
> > > > > 	 * between both channels. So allow updating these registers
> > > > > only
> > > > for the
> > > > > 	 * first enabled channel.
> > > > > 	 */
> > > > > 	if (rzg2l_gpt->user_count <=3D 1)
> > > > > 		rzg2l_gpt_disable(rzg2l_gpt);
> > > > >
> > > > > 	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR)
> &
> > > > RZG2L_GTCR_CST;
> > > > > 	if (!is_counter_running)
> > > > > 		/* GPT set operating mode (saw-wave up-counting) */
> > > > > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> RZG2L_GTCR_MD,
> > > > > 				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > > >
> > > > So if the PWM is already running (e.g. from the bootloader) and
> > > > the mode is wrong, this isn't fixed? Similar problems in the if
> > > > blocks below.
> >
> > What is your thought on caching the registers that needs counter to
> be
> > stopped for updating values. Basically, we don't stop the counter if
> the values are same?
>=20
> I don't see a very relevant difference between caching and reading the
> registers. Whatever is fine for you.

Ok.

>=20
> > This allows updating period/duty cycle on the fly without stopping
> the
> > counter even for the single channel use case.
>=20
> I didn't get the relevant difference, but the result sounds good.

OK. Will send v8, along with any feedback for v7 series [1]

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022092114=
5741.901784-3-biju.das.jz@bp.renesas.com/

Note:
I have a plan to develop another PWM driver using MTU IP on the same SoC.
The work is not started yet.

For this IP, I planned to use MFD framework for the MTU driver and=20
Will add counter driver, timer driver(clock source, clock event)
and pwm driver as child devices.

Currently the MFD driver and 16-Bit Phase Counting using counter framework
is almost done.

Changes,
Biju


