Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D45BFF1F
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIUNrC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUNrA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 09:47:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2124.outbound.protection.outlook.com [40.107.114.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C2865552;
        Wed, 21 Sep 2022 06:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+nqhhmsyjMweM3wNgBeMm4iVxHbqpkt+cuPKuub2S60Qm1hiEPIGDLyokx3jDVGBL9nn9iw6CuuqlyMxi0IO2Gb9vqzdP8J86MPp7vnxqquhpSQ1Y2xWssj9oJE7mZyPHGeLZM6Wy4U2CL4qjvLIA7FjCHqOPdsn7wCeLg0lP5gXIFDtO5mKp5P4BCcMUBJS6Znwe7eCie0i4wfT3ws5DEfACaPMCrvS3uqfL4rrliwxXA6Ja9e5/Fb7im2bS276KRH+FWfTd7EgMxXvZLDOEGvz3P1VOnV3dAt8rXn6vI/HD0dwD7iOpCDK3HhHlpllUCc/n85OR1kCnRDzR6Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTqRCOtKsmy8tp+4h4q6mOb1Nqw8vOaPCsagUbh6qNs=;
 b=HX8a0heLfZgGxTHHYU9pa/jZCOi3juhVKq4qYkW2Ew6hOStJA6bOB643+aUfWJuy/ZS8hKwDXpHqpfSsSbXW0KxD7BjVQXCyRbf4Yd/7ly6dfbzTYc4Fva18QSq7Ym64sd2T0cM5l64hUfCILXvuxVwf+YbKxQB23azmL08+667ZHzz/hg/Df0FmNmrNXyEmbyyigI/t+PVwIdsaoqz2imJYS8yGmmZjhWKG7XwiNXhWc5d+7sC9apBt6XDhbh62D6SLPGkfov1pMG+u//zmeiFXnMjxm5w5r/IqBmy4/ViEY1cc6u41qWQlDpusvB2MfcYxUjXufa+xFGnGl6NnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTqRCOtKsmy8tp+4h4q6mOb1Nqw8vOaPCsagUbh6qNs=;
 b=NYKBb9TbYmkzPwpltHHRVh/rwtjKsVZSPYYHflUN12SyFbQgcV1d/DkhUeF+/2sUQMfxVgH8/swE323fQzjTtF5mRU54wAK4bXXnzJZrwVo2eLQYKQ2HJ1xWe6zYdFM8TOiqwuyqLz6sbCy8ueLtUoPrHg6l9/BY9pfQQ1f7UTY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5658.jpnprd01.prod.outlook.com (2603:1096:404:8052::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 13:46:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 13:46:54 +0000
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
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3CAADBRAIAAALaQ
Date:   Wed, 21 Sep 2022 13:46:54 +0000
Message-ID: <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
In-Reply-To: <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5658:EE_
x-ms-office365-filtering-correlation-id: 398a3100-cf9a-4672-0fef-08da9bd7bec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qg9o1w2w9o+HGBm/AIJI8aQFyukKQBRdUG8YvaN4n30OozqO68EYrT2Hs4YOUYtrd/Ec4kClu+hKFbayNpV4hXOLH0cplPsl6yFLEYK08HtPsnj47Tl6apBjdvYxdSRift3G3hK6/PHZuCeAk1OGLfgKQc+l4rIUXoMXFVvRS70oxrDzBO8CTxqa3SmQAIaI7ZDFyJU/X43ZuFg7D5UNXq8nhy/0v3h34l2i1UtHO/DV223NSccrm1pyaOyeBFIwshXPlE2qNyvmlSoRIpovvR0qV9TutQIAM2hDc1NYZCV4lkkt/PgpbwwPTU6HDusVKr6AyC9V4c+nLUE37HIthYKtAMTFNUNEvlnLzrDPYtSYtd+2U1qIdMzMgyG0Ie9ecS3ukM0e+n6ZQxwmC0czp2rIxKA9joauDVEaBHtMKtm+jrJMA9JD+t40RgGTvPbXZPLvjbMhhRrogrO4X/xFs25t6W8Ms09JkiYzqvnvmfe/0Us05QkWzJFpqPB2wsgbnMvJwLzU8tycJRUXAPaW2MYpU3oDoTVY6V6cKl4Q6KUzA30zZ9q/FTRwdwuk3CLpsK6CJD+bkEY/FHW0RX02JOyx/qquTG7dgYzYrgZMcV3niEf0MdLGx884ug4nRd2adswe6lb6NwtsF7/vmDd1seVyL7bnth9FxsPAlOaZINsABd8XcA83PI09mWw6WI0LTytbxmbApHwt+cqvKjn0oitI/di8tV89IR9pdJyybBtY56lfF/EAhLJz2kr8d1pjmgfN69XwJQeZEXFLAzG5Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(33656002)(26005)(38100700002)(41300700001)(9686003)(7696005)(6506007)(53546011)(2906002)(55016003)(66574015)(38070700005)(86362001)(83380400001)(6916009)(54906003)(66446008)(64756008)(8676002)(4326008)(76116006)(66946007)(66476007)(186003)(66556008)(316002)(71200400001)(52536014)(8936002)(5660300002)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qp/mnAzgYm/izmrTf/suBPYzAFtlbodr80/6/X4NcNzdRAIiyJBSMnpq0U?=
 =?iso-8859-1?Q?OBRx09H94WYTh0QgY/z6/oGg7/xGFnF2nIninHzPok/NCLv1vbnuVR2FS0?=
 =?iso-8859-1?Q?53nENCpYIwBa0VDGTYPsj7WwG/zZ+UW82qLV3SNP8r84q4T+IvNTszq2r3?=
 =?iso-8859-1?Q?a26EZkykSl7E8EDYdDMmVMYNhPP0a/x8I1L6SGum06uAL1K65BoDMwUhXP?=
 =?iso-8859-1?Q?kWC6Dmek+tWpJqO7PoZxu2ki6uQiGW+TpFRGpT9ESQNap5gpI88NSOZs6i?=
 =?iso-8859-1?Q?yx3bd4akRmG6qY0XQHAX0bwde9ljUQbeMsEptAD19ZuDBECddVqPpBAAEV?=
 =?iso-8859-1?Q?nYkB7s34N33rAmb7hNVIpcXNXZL7I82kPhPD/0Zam0Jv+LkMyBMGgKtijo?=
 =?iso-8859-1?Q?tUSwCqBENUQTVmPE1S1KgzuziE1Buhlb8AMAq9WbZfS5TBztp6Nq2xUvyY?=
 =?iso-8859-1?Q?PBP5Kg6zRB3z7wnmrSW80Sh5B2l5u6U6fvqR40E7rbH56Akas87TU2dZzq?=
 =?iso-8859-1?Q?7uCnrqdT7hSCwvdlXh/9e2FzcNhMy1e6L4v0DIO3MNP7X1yfC40WAUTOXX?=
 =?iso-8859-1?Q?VcDrTK4GSy+HXpYwZLlM3qhBOJusGtFb301nP23rkwJiw+BxBtuDYr7qih?=
 =?iso-8859-1?Q?AbQGrc9rQTeys8XOQJ21Ogopsr5RvZRSxW/WuGOCXGHuR+3oAkLT/2mnJU?=
 =?iso-8859-1?Q?gZSDrKfzLJ4Ic79LfMu5319wq+PuqZXgiPuEDbgfyODPy9CYuXt7KnNZoH?=
 =?iso-8859-1?Q?0yOe4+gqSQQDYYjyfZVl9aFt9pMsAX7HcSv7PYhVmFzwQYsVZn49MOYOrE?=
 =?iso-8859-1?Q?/i7lJA6Umi9GrUF7QLrovL8SR5+6WQzPvFl0dN3UmK/NXwFVW/Tkt+1uGk?=
 =?iso-8859-1?Q?Pz3TR5XFcBLCVe67E5Cl3NJ3koU8zvovFahk8hGapTS4csOCBdDiWPzT2E?=
 =?iso-8859-1?Q?0QNCV4J5fUlTfX0C+EAhpNfomlhzxDYlxAO3QqB93kGEsKnZJLvkfISdZi?=
 =?iso-8859-1?Q?/k87JnygMZ5vvaexSMWdP/cJw8RbnYU39RNIm8soWa113MQbXYNdpyClqR?=
 =?iso-8859-1?Q?J8a+72pmEHZh+x0l35waHig8kyf4X5OhFE1SO+H7vnuX2YFTcCXs2Z0AYB?=
 =?iso-8859-1?Q?FG2w2dTZAeKpupQeMbGu0dpGC/5JYK6rgpzfaoVoHjUL7qU4cs20SfpNZo?=
 =?iso-8859-1?Q?J5U4qeI+YBUtxxQroYL3RrgHuE2xgirQA+UJayONGAFM2PeIaPOyxbDxBx?=
 =?iso-8859-1?Q?SMF9AGiNP8Lxy/hZmHKcbUQmK3CgmjWBR0qKtnXhk4wTH8tt0BZl9eLbkZ?=
 =?iso-8859-1?Q?bJi9549ceO6e06JaM18O686/KHkPfv6f/IfFsJiLahgfmfymxWvrn7yupW?=
 =?iso-8859-1?Q?ucBUrCNwJhluQGwPsLiasS9MADn/sKR3oCTccdcexkE7r29nYrqQNeiQX6?=
 =?iso-8859-1?Q?7dJlfZx0qn7iqPpVZApUL5sucL+UaN0zXBGunbVeJLUeOZjineDDLAxZi6?=
 =?iso-8859-1?Q?G5Tx8CiIuqQBOw6o2hQ6qRXlMtNcCrTa0dv8C37UyCO5PedhlovERyGzHS?=
 =?iso-8859-1?Q?DhU08H2zC5aztbuLsav8rIFWA9NXk9+RNh7i2zr4l2LLbejC48W6D9thnQ?=
 =?iso-8859-1?Q?dnKGj4uG3IrvwZH+JtXOw0VONtlV71jCPz1AL0lcwBRLinJ/yxGruD8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398a3100-cf9a-4672-0fef-08da9bd7bec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 13:46:54.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LA82D1m0kjXZxhxT4jL+AfHCjG4eSFUbfUqeYPD3KQfMvm/p5T1s7rZhHFmNCN+b/rdZCs3kQh7xf+fD7DzJne70AzBAZiqoJXpvwn/dlXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5658
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

> Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Wed, Sep 21, 2022 at 10:50:48AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Biju Das
> > > Sent: 20 September 2022 18:01
> > > To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>; Lee Jones
> > > <lee.jones@linaro.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> > > linux- pwm@vger.kernel.org; Geert Uytterhoeven
> > > <geert+renesas@glider.be>; Chris Paterson
> > > <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> > > Prabhakar Mahadev Lad <prabhakar.mahadev- lad.rj@bp.renesas.com>;
> > > linux-renesas-soc@vger.kernel.org
> > > Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > >
> > > Hi Uwe,
> > >
> > > > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hello,
> > > >
> > > > On Tue, Sep 20, 2022 at 03:31:16PM +0000, Biju Das wrote:
> > > > > > On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > > > > > > +	if (period_cycles >=3D (1024ULL << 32))
> > > > > > > +		pv =3D U32_MAX;
> > > > > > > +	else
> > > > > > > +		pv =3D period_cycles >> (2 * prescale);
> > > > > >
> > > > > > You're assuming that pv <=3D U32_MAX after this block, right?
> > > > > > Then maybe
> > > > > Yes, That is correct.
> > > > >
> > > > > >
> > > > > > 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> > > > > >
> > > > > > is the more intuitive check?
> > > > >
> > > > > Ok will add like below, so we support up to (U32_MAX * 1024);
> Is
> > > it
> > > > ok
> > > > > for you?
> > > > >
> > > > >   if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       pv =3D period_cycles >> (2 * prescale);
> > > >
> > > > Not -EINVAL, using pv =3D U32_MAX is correct.
> > >
> > > OK.
> > >
> > > >
> > > > > Same case for duty cycle.
> > > > > >
> > > > > > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle,
> > > > > > > +rzg2l_gpt->rate, NSEC_PER_SEC);
> > > > > > > +
> > > > > > > +	if (duty_cycles >=3D (1024ULL << 32))
> > > > > > > +		dc =3D U32_MAX;
> > > > > > > +	else
> > > > > > > +		dc =3D duty_cycles >> (2 * prescale);
> > > > > > > +
> > > > > > > +	/* Counter must be stopped before modifying Mode and
> > > > Prescaler */
> > > > > > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) &
> RZG2L_GTCR_CST)
> > > > > > > +		rzg2l_gpt_disable(rzg2l_gpt);
> > > > > >
> > > > > > For v5 I asked if this affects other channels, you said yes
> > > > > > and
> > > in
> > > > > > the follow up I failed to reply how to improve this.
> > > > > >
> > > > > > I wonder how this affects other channels. Does it restart a
> > > period
> > > > > > afterwards, or is the effect only that the currently running
> > > > period
> > > > > > is a bit stretched?
> > > > >
> > > > > If we stops the counter, it resets to starting count position.
> > > >
> > > > So if I update pwm#1, pwm#0 doesn't only freeze for a moment,
> but
> > > > starts a new period. Hui.
> > > >
> > > > > >At least point that this stops the global counter and  so
> > > > > >affects
> > > > the
> > > > > >other PWMs provided by this chip.
> > > > >
> > > > > We should not allow Counter to stop if it is running.
> > > > > We should allow changing mode and prescalar only for the first
> > > > enabled
> > > > > channel in Linux.
> > > > >
> > > > > Also as per the HW manual, we should not change RZG2L_GTCNT,
> > > > > RZG2L_GTBER while Counter is running.
> > > > >
> > > > > Will add bool is_counter_running to take care of this
> conditions.
> > > > >
> > > > > Is it ok with you?
> > > >
> > > > I'm torn here. Resetting the period for the other counter is
> quite
> > > > disturbing. If you cannot prevent that, please document that in
> > > > the Limitations section above.
> > >
> >
> > OK, I will document this in limitation section.
> >
> >  * - While using dual channels, both the channels should be enabled
> and
> >  *   disabled at the same time as it uses shared register for
> controlling
> >  *   counter start/stop.
>=20
> Actually it's worse:
>=20
> - When both channels are used, setting the duty-cycle on one aborts
> the
>   currently running period on the other and starts it anew.
>=20
> (Did I get this correctly?)

I think, I have fixed that issue with the below logic
Which allows to update duty cycle on the fly.

Now the only limitation is w.r.to disabling channels
as we need to disable together as stopping the counter
affects both.

      /*
	 * Counter must be stopped before modifying mode, prescaler, timer
	 * counter and buffer enable registers. These registers are shared
	 * between both channels. So allow updating these registers only for the
	 * first enabled channel.
	 */
	if (rzg2l_gpt->user_count <=3D 1)
		rzg2l_gpt_disable(rzg2l_gpt);

	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_=
CST;
	if (!is_counter_running)
		/* GPT set operating mode (saw-wave up-counting) */
		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_MD,
				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);

	/* Set count direction */
	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);

	if (!is_counter_running)
		/* Select count clock */
		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));

	/* Set period */
	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);

	/* Set duty cycle */
	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);

	if (!is_counter_running) {
		/* Set initial value for counter */
		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);

		/* Set no buffer operation */
		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
	}

Cheers,
Biju
