Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCB5E8B98
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Sep 2022 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiIXKxh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Sep 2022 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIXKxg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Sep 2022 06:53:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72927FF1;
        Sat, 24 Sep 2022 03:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE25+Ca4CV10PUaXr6vZv6Zhdh4yXkYUyyMAMc9pjyYPXyZ4AG0jfzZ6U7MA5wjOCLi6bPDwYoZEIKRIrGDXN/Prc0MQogbN5uEYYrHFaPesTj8EXaEDRYX5VqwTKvy7Uz7CpVFA0dg4WPlj/KFPbzFVkiplvp9VTNhdWm0/zlPgk/RHLN+APjha+zTEnQqFOR8P4c6/XgZwtk7Z17cmCLE9g8ySCWdA5Ks6c4vUhFvuMu3/BWtHr/S5DyqY3x1V9SVW88P3wbMayftbg1ssFM16bYVxUwCR6XQm3RwdL7DMFHlyjjFf0BLLup7DXg5JTwNUnDbG5Y4ONnfkjNQysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCljDJm7Dhw2Ac4GNyHN6wkvAFS1mEzNAd+X3EUQCF0=;
 b=f5C4Rx27I7tOp4te5rxrx83opuWknW9L9p/z4XtPJnopNkjY8f8WDcb+JN7BoCsLJXpuB5FCD8mbRWajk5K0xI9ep1eYbd5OfKqdXYdQ6scpAhqBeEyyO2nA/Z9WO4Z2iawO0COgg68m6YMVUo02ZwUz09cDia3xtuQhhMWgFSBOLcbDyVVm7Y9pL/rf12zlHfiKny9En6tytKarE8z1JkO7Eyk8KKisgsyjgCoIAlj0T1XeChn6vH69sCUKW9TIAetNGQfVPf3a/ozu0N449IErTn/HoLN2mHRHkZyKO/qoz9oqBVpjYKLp8R5eSMuUsdWuSGV8eNHHr4t42oj3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCljDJm7Dhw2Ac4GNyHN6wkvAFS1mEzNAd+X3EUQCF0=;
 b=uJ4vwjiFKx6eEk1IsGTutxvnpBDvjJ1wyDuzRtfZTBXiRhq/uAIvn1vpv7SiMH1AIx9uUPCUJFtWGAqwzmGWQugHHmwN8yyuzyqKnQncMtOkiLb0aGKT8qxyynnAlUNrGXSp5wBE5dfRHCuYO5wakePJQwdf1ezm89Sbigt4LeI=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS3PR01MB8507.jpnprd01.prod.outlook.com (2603:1096:604:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sat, 24 Sep
 2022 10:53:32 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::7c12:d63c:a151:92bc]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::7c12:d63c:a151:92bc%9]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 10:53:30 +0000
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
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3CAADBRAIAAALaQgAELnoCAAAmiYIADcXiQ
Date:   Sat, 24 Sep 2022 10:53:30 +0000
Message-ID: <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de>
 <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS3PR01MB8507:EE_
x-ms-office365-filtering-correlation-id: f5fcda60-1590-45d1-99ab-08da9e1b049d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nR6Ypj4511CEYaHizZVu2KWEL91kZHaWPbVsOOQVKmw3BFzCVhM7TJeg3auqpQAVnvnAiPxsmIUMqcCVlg8JQ6Y4McugRWx2t8PdDp2TL6KWKyX7SiIth9ZNd8tAMpbR7q2gmTY1hzdyejYG9rTkL5vwS1zWYSUrnodM3i6JlF3nt2Zyrssn69vz5TyoAl2kdcvhVOThHllyGvPQTYmKUNrJaKaOQDLt6liGW3afurd5wv+yXRo/viPTk0m2Yb2QH9kyqxhzkzBC43JayHM//MIPlUigwCLKkkGKzuF3EHMkcX4k6rJdIE1jXMAATwviic47rSIoWGEzz8ws0XDhFh0tDX0FKtS1eqVFO0y+NxJwEdtUIFN4nxovf0+l/Xj5H1ucjOts9IjckMiTHsiIxa5T9yd/STLZcuLe2xFg9ce2lFc40z1aQzMtYpK9yxDkbAM+kECt7CMEZ8K4q6qfYLyvix68rv4sD5/TH1hRgujnpYZARay3bmV+TbnLdGjvbA7+K3na1bAUzIKvCiwsKrjcfRFd+8T3fwSBGPyv/Y+rAgOXrYOV/1b7LFbfO2jUZBIc8s9dgqWkOMRUFKnLPYB0coi1XD38iBSu11+EbMnR9Gx0cytgn6oDO/e9FnWi03hbq+n0+LZ9pLiKFE2EovOTD1hAWPsqeHyg2aK1XvjjYV9k+xtX1WC+775yGjejHpwRMZ/iiRnJgKXdp/RrulX8opyyDP9mMOAUrMCNjxHP5mrpRJkDkhVGg9Ow96j8C7SlKBYGV/fyPXCEWut+MnfqnH7Q6cFknaRoQIyEgu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(54906003)(76116006)(478600001)(966005)(122000001)(8936002)(7696005)(26005)(38100700002)(6506007)(52536014)(86362001)(55016003)(66476007)(33656002)(9686003)(5660300002)(66446008)(66556008)(8676002)(4326008)(64756008)(2906002)(41300700001)(38070700005)(66574015)(71200400001)(66946007)(186003)(6916009)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aE32RzmJ6Zsv/pm3EZbrGcelUM2Qb4+2LI3CaRW2Ph+p5GuLgZJlnruQCQ?=
 =?iso-8859-1?Q?OZqr/P1SDlFzmHCzkWR2KInj1jtaVFF1ndqVDBbPZV8Clkd/jnwnQVBwuN?=
 =?iso-8859-1?Q?F4C511VspBsWXkYlHX6RZgyavUj223Vr/mfO+uRMK9yGD3GLY88qesXxbG?=
 =?iso-8859-1?Q?xyVT2f+jBsrTwy0cRxBHeq8lT57xPFUG402KExDVjYSfyMvqz4EGPF+X+y?=
 =?iso-8859-1?Q?Po0o6vOPzcq/SpISfpkzQGzUEd+KIPHfdvHKrTleA4I11Y+oxHCY9vMM4c?=
 =?iso-8859-1?Q?k2RbX89gREeii1JAAJmjkAnKEE/EeWdHFMSsNMWoUeQPAZMJxPBal5/gJJ?=
 =?iso-8859-1?Q?TYke1LVoCpYspXN/FPIboSdTBS/1gxFM0ZnOa2tEnyFtEd8nJweizu9J0b?=
 =?iso-8859-1?Q?eg805FC9CU2neZ/w2JikOn/Lb+GDacfoGvxIIA/hkqeTofoU3MayanI5KV?=
 =?iso-8859-1?Q?bptnn/3FWl945nYf6H6RUxgWmEx67n4kTJLFQ7jx1JeB2WdUCvT4DdL9AK?=
 =?iso-8859-1?Q?w4MDx2CmiwStUcRkDRv9MDcC3SXCXGCjtPLhUOc5IMlNeVEVfYw74HvxIN?=
 =?iso-8859-1?Q?cOPaVYnG/xYtzU+6aIGq/2VwKZKD3S5YCmOqzMeq1xwepGHC2RD3QeXzjN?=
 =?iso-8859-1?Q?ngf7byYBKHM4SrG5VNWX04BPp0nArYLJGv8yWe43b+5dx0tgBUb/tT735Q?=
 =?iso-8859-1?Q?HGYlG12Cp2g2wTTl88FZRI/jG+WgflI0oqUQM4EtiNm86Wtq8CoZA4dV4D?=
 =?iso-8859-1?Q?7QdKwQePl80st8i/N2Awo/eOZBzWlGsKCnbQav3NeOgPdK0+LGbYMKJ3tt?=
 =?iso-8859-1?Q?Qbwk2S/WSVI8CtWGpVEYa4c99zLm3ZdJ/lspH/3F6YglfwyV8I/dIj879Q?=
 =?iso-8859-1?Q?hG6VXG39fmqhJz9rxriwe82WylwuIG3cChHRSNuhO+CvrTIlj1rr0wwUtD?=
 =?iso-8859-1?Q?zYSvNjpFCsKje1E5dCPHnWLWQA3qrVzFB9eoFo7OVxg+tc75OW59Te4VGY?=
 =?iso-8859-1?Q?WT+n0UNSkjnJaWQN6CcgG7Q50ALGNC1hjc/rQFAs1rtDicouTifampsJSf?=
 =?iso-8859-1?Q?nLiXJoOeXLGKapqqsoLKi/jXtuzGUEwjRLMGrFUfJQOg82AOiKVnQLh5hk?=
 =?iso-8859-1?Q?9Dc781/w0V2Ms5o08NOnzMnZGaT1aSMGU3nQZ6VMQe9zoJcgVzfsiTfrhq?=
 =?iso-8859-1?Q?U15amwDvUsYnZuuVdoy7HMPEVyBKfejptzfO9esBgAD07pASh5z4i9ckCy?=
 =?iso-8859-1?Q?t2Bjuw3xhTpuZ/37uj3PUSNsuzRbDxKXll9t1PbFe6YAdVs2EELUp1NzZ1?=
 =?iso-8859-1?Q?am/iC+gPiVhjCccyfsnobvVqBvQ3b1mE0h+u6KHanRDHw+eSHuwz1915F5?=
 =?iso-8859-1?Q?7QjkqHdaCcJYVewXaq8YWA1zqeetiY25qSJ/PER11DRQ7qZkTDQt0hSmD6?=
 =?iso-8859-1?Q?sixG5XWFXw3zzX2ZJIgrTIwWvCwEIEWHsVXytUaSDFG8wwpwPXKToDUJSh?=
 =?iso-8859-1?Q?0pbXbPh50OAfb46PK1LmtaNDX7WVO6ylKK630P74BTEelJ0IW5kbPl8ORg?=
 =?iso-8859-1?Q?OKsgLC8ipivK82XkiVt72RO8u2PhUa/jdfS7JbBfmt6SLnfXTLHrI+7z5o?=
 =?iso-8859-1?Q?SFv5pyQEwg2r8wTJSOGZXyoDa4lhwIHiH3LMp1Jsc7mrOX6GL+87mEdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fcda60-1590-45d1-99ab-08da9e1b049d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 10:53:30.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anXCmQ5qure9V6+iXzvfqtpjai+vW7F9pFrmKesr3IXbR/hOj8ihJpoqixmlL5QDug0gAaTwQZlFNvcMbc503SOLXBLkGIX2dIdRWgQaGnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8507
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> >
> > Hello,
> >
> > On Wed, Sep 21, 2022 at 01:46:54PM +0000, Biju Das wrote:
> > > > Actually it's worse:
> > > >
> > > > - When both channels are used, setting the duty-cycle on one
> > aborts the
> > > >   currently running period on the other and starts it anew.
> > > >
> > > > (Did I get this correctly?)
> > >
> > > I think, I have fixed that issue with the below logic Which allows
> > to
> > > update duty cycle on the fly.
> > >
> > > Now the only limitation is w.r.to disabling channels as we need to
> > > disable together as stopping the counter affects both.
> > >
> > >       /*
> > > 	 * Counter must be stopped before modifying mode, prescaler,
> > timer
> > > 	 * counter and buffer enable registers. These registers are
> > shared
> > > 	 * between both channels. So allow updating these registers only
> > for the
> > > 	 * first enabled channel.
> > > 	 */
> > > 	if (rzg2l_gpt->user_count <=3D 1)
> > > 		rzg2l_gpt_disable(rzg2l_gpt);
> > >
> > > 	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) &
> > RZG2L_GTCR_CST;
> > > 	if (!is_counter_running)
> > > 		/* GPT set operating mode (saw-wave up-counting) */
> > > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_MD,
> > > 				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> >
> > So if the PWM is already running (e.g. from the bootloader) and the
> > mode is wrong, this isn't fixed? Similar problems in the if blocks
> > below.

What is your thought on caching the registers that needs counter to be stop=
ped
for updating values. Basically, we don't stop the counter if the values are=
 same?

This allows updating period/duty cycle on the fly without stopping the coun=
ter
even for the single channel use case.

Please share your thoughts.

Cheers,
Biju


>=20
> This is taken care by the above code. It stops the counter for first
> enabled channel in Linux and then changes the mode as per Linux.
>=20
> <snippet>
> 	if (rzg2l_gpt->user_count <=3D 1)
> 		rzg2l_gpt_disable(rzg2l_gpt);
> </snippet>
>=20
> Cheers,
> Biju
>=20
> >
> > > 	/* Set count direction */
> > > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > >
> > > 	if (!is_counter_running)
> > > 		/* Select count clock */
> > > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > > 				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > >
> > > 	/* Set period */
> > > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> > >
> > > 	/* Set duty cycle */
> > > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);
> > >
> > > 	if (!is_counter_running) {
> > > 		/* Set initial value for counter */
> > > 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> > >
> > > 		/* Set no buffer operation */
> > > 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> > > 	}
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> > |
> > Industrial Linux Solutions                 |
> > https://www.pengutronix.de/ |
