Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B546A58DE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Feb 2023 13:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1MKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Feb 2023 07:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjB1MKk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Feb 2023 07:10:40 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CC2387F;
        Tue, 28 Feb 2023 04:10:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqcAY+6/Wk5htyDRzLAFnISBlNw5QS0ilQFKT/RnHL/2kpt2H7HXlPPzdTXpbXxq2uT4JtUfw7HroKUT/9kX4C5VpMl8osRUilo5ELzBs4+K5BUCP8bIjeiy40ecGDczcsZaES1TFTDVuh+x4/7q3DQiQ/quHTF4dZRpvKfZiYvr7tO1wtPM0BCbHsJikRcpVB5+0DsXmkptPOfPlYqdyQ2YrPVwdwWgadcAg5xCL3L6mHLaLiwLFUbRT0p7dUZH/NtUuJzogKBQhGB9YDOa5nZigqjNMM24GFGoA4nrqU8UcJilGYJuBIlyHZbPGRAi4svSVhDkkFu4Q/oFkomojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOCnlat3rnsg8U0uteRDEuPySxZB0ROoxsS84IgV8g0=;
 b=oQ3OMkkVQF+NJuUfLezvmnOK0zOYsVroFqFW98ZcoRwMhbu6CYLYgDWDyiSJiugPV1GFeEragpHFw8V2tAVx+JFjXl35GYeGzB80Yf3pQRB95Xv1T7yb/CbJPCpg6D6rYTGWpU1cuCEBSt5JhbCFUV9A98BvDYLy4OrCiEx4zDCss/Ftzn+nYmYLrcOrzvnfhTQ9TemBy1qb17rCO8Iz4PBQHFplfIbm8s+U86Yj0IgIJy346h0O8idaV5cXjRiNukGXzmZ/pQJrdXN/ThTKjvN/M6ocGtaDj2k8bZego/BGV8NllNOulw242XhYZc0v7V+//fX2accEbuAdZKC0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOCnlat3rnsg8U0uteRDEuPySxZB0ROoxsS84IgV8g0=;
 b=fTay6a/EH/Kgn6phN7bsF9SaykGPyag/hMU+h/Os2Y9w0DuwWdN6i/B/1pARGJzRpS+Vnxrb2qio7rRF/Ep0Pb1w49dmSxXUZgThsJnSxYy9qu9OVno7E8c6SRY7RFAkfOHUNEflV4HIVV1yf/f4oBEuzRTf7u62JEhnjHgUUv4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5531.jpnprd01.prod.outlook.com (2603:1096:404:803a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 12:10:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 12:10:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Topic: [PATCH v3 3/3] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Index: AQHZEMgPwtaDdflbmUqLAQEB2KXkc666iSOAgCovWEA=
Date:   Tue, 28 Feb 2023 12:10:32 +0000
Message-ID: <OS0PR01MB59229501EDB0E9D12015B7FF86AC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
 <20221215205843.4074504-4-biju.das.jz@bp.renesas.com>
 <20230201155339.p523te2bk7y2mv3e@pengutronix.de>
In-Reply-To: <20230201155339.p523te2bk7y2mv3e@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5531:EE_
x-ms-office365-filtering-correlation-id: b9091730-c6aa-4b4f-c9b9-08db1984ca79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjcPXRby+Uv2IYwbPxFlU7OzFBb5fcyjrKY65xSjYvRh4j5pj5UK0pN72KTFbmC2qwTZHziu/FILhI6tAVuG5lSOVM2F6uOCLHw/oDLbtyfyqq3/kYPE0U93aC2RzxsyP7zCg2nC9Sj+Ayi88LhRq9nSodyfCcrp23BsRR5AMEvqfN9WyzRxk/p8gWQO81n8kwTIfs0O4O4H72s82maRZi9DkS5dTHYZ2KTW9LTDjlZykOolec1h0zganZnfvtGBOvEWOAzkKAvg/aun163nT6b1SN6pVs976RR49ORX89vWBKU4+G6CvvFPQ2sK3ODiS45uYcdM7MVBuSVD0ZyeVX5TFOwkQLQ3XQsgU8GDWWTLcy+X564/j/E3XTj96d+wPS5tVpF4c3xFYcBpgHbHlHwym7X1PDf1m4w+5rkTqioGuoP4XhkOabTlxwX0fxouHVM3Q8Czpw5/JQ3kqokTM2DfrT3mrLncL4F4mWvrhmMw6mUThz8RMNzL3LWntx8SLHQLiMfVfIzJD0sWozCmOwqQQ3EKG88HKnZb5o1s5fRx/WIe0FCya1aatETm6VtL6uE8hlwfwnK41HTldp7dwm7CIfYSif/YhHZEjw3WDriyVrSFRjAzeoM+AdRdmA0hGrMvVk0RFe97+N3/3z+r6LWWTLQZa11lx3RKRqLvdWyZFUY3GjNXTtXmusmXnbHV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199018)(86362001)(33656002)(55016003)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(8676002)(5660300002)(8936002)(6916009)(4326008)(2906002)(38070700005)(38100700002)(122000001)(52536014)(7696005)(71200400001)(966005)(478600001)(316002)(54906003)(76116006)(83380400001)(9686003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CnxQeuejJbDqulnnymVoY8CB9P/xdNnLS4rqiwRsyIOY7MUiJH+lnSTL4K?=
 =?iso-8859-1?Q?ymtZsazSCBNUeACyVrIBTNAIlVjLHPORVveKAGQHpGgE6PjsTqhXd249Q5?=
 =?iso-8859-1?Q?tZVcruF7qeeAQH1tU3HMa23uG1E+a1wkK0ssMlG91kAuw8hjR1Gv5YX7Cr?=
 =?iso-8859-1?Q?zbY/Dfau0Ruf/whKPH5tnX9We5hccjyFFkH+qxKIKc6stoXYv/70GNWOMS?=
 =?iso-8859-1?Q?sCZZFj1Q/rKJ8UOOvjmOLkJsfIDDMgJNRWOLX2iydAMErziOsi5ADLOQrs?=
 =?iso-8859-1?Q?TyinQxi6YsNKdLUKmattTlU+e7RmJV/XRBERaZre+d4AUohRPhnPwI5omq?=
 =?iso-8859-1?Q?Sgazmws4BT7FgUlqGYngsRC4DJC+hmVL3d2z1YFrtDZwDwT73OUxV+/n46?=
 =?iso-8859-1?Q?B7Y7frm9+JLUGD6BWZEdVn6af13kBazed7eccmol5nApb9cczoggUSpZ15?=
 =?iso-8859-1?Q?032pS7Y8ZppcHLSmoZKY4De4gvewisv2YmHdH7d8qsumfRjl1qTR4uo0d1?=
 =?iso-8859-1?Q?4kOntmCQ2IMWV3rMAhflxM8AHxe//DBO39jaxD1Ek6++ATohLXe2t3VZWi?=
 =?iso-8859-1?Q?ehLYnlvrXoMu2h8Wx8ju/Q4U7jVERnb6G9uwj+Y2pUarZtEQdlKFO6h2pZ?=
 =?iso-8859-1?Q?BNWsMVFZMkNai97yC5d5BFhq88XtwKVVNT1iv8EQwJO2rGR8QODpi60ad8?=
 =?iso-8859-1?Q?6cyshuf4yAx34hzmtEdlqT6eAvcjdGtVL68TOkmxlMIAEYZjn+Zldc6AT6?=
 =?iso-8859-1?Q?KyNpLlRwmVFlJG+c+BygOUSzsXTx+XAOGyTdgZz+j/jCs0qykv84t0W+WW?=
 =?iso-8859-1?Q?ebRRa3a4osF3i91JFTvno1wzJrZFPUD+XIUfo6O2W7lIBxHrtJgv4Q6Ipz?=
 =?iso-8859-1?Q?XFhQAYctv+pcLKgqagnHoNKFt+9RDtdfQ0VeD0hRFp4WDT7+ldYC61UA+9?=
 =?iso-8859-1?Q?XVUgcyAPrCWNKr95U38rBS7RyTgoZsHx0Z5lj4A3GmdMmtJPJnT/RdTJC/?=
 =?iso-8859-1?Q?JVKM7knXcNAd8YBG/JEORQSnWEYDJdJ72ByaxPDlHFiXsYkruJFATIuwB3?=
 =?iso-8859-1?Q?wErXaRIJCYe0lidhsl2FwAxVMMgVxzBDnavnvyItqZuMzM5AejrutxsbxY?=
 =?iso-8859-1?Q?n2E4tE2qNxwKwFQaocsiRGo2brt2NrCxwuP8Ul4Tsvp7SwkHA+M1qmQB/o?=
 =?iso-8859-1?Q?Mz+Itz21THFtuzRxn2fxwQ+hMcm5AjqnYMoTrHosv+JybSfnQKeUabMvTF?=
 =?iso-8859-1?Q?BxLY+w/iUKQhzmEYLj9x0ZOrcvI9IsgBXbZbOI2FHs/C0ltcToZV2HuOCl?=
 =?iso-8859-1?Q?eLjs2gTjn093w8HYQza+bpZzbkstlSjdYPwyybyPLSAfgxN4UBvENn/Vag?=
 =?iso-8859-1?Q?OLJOvojltrOYaTOz8cb3JNk3sexIDU/ld2klh4OVJeDts7RxI3XW3mWbWM?=
 =?iso-8859-1?Q?figClFujzzZHiwaKcijn/NYjQvZL8G52PjRIPbXXntqYu8darZxqihmRXs?=
 =?iso-8859-1?Q?lwq1zqSDYq4dERozACrukQmyL+m6/6wXU2PU5JYlcK3CjNeuGec7EodBUC?=
 =?iso-8859-1?Q?ZQDQrWD5K5ZefyRzEni2oaDMoVDTjkBKqOOXiXVi+J9tGIoDD8A7BubH9W?=
 =?iso-8859-1?Q?ZT4Qws/WafadErrEEbbhg8iB2s2PVQg6Z2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9091730-c6aa-4b4f-c9b9-08db1984ca79
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 12:10:32.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wgWOa84B8zFGpgZtAgH7/pBIKsHoDcsb+E9K+2ntLr43fxf8tu1rIzsdVEtQzWy/3CIelx2xsQA8Lf/sAcdFTAJzmzH2v6BCyO/hjg/dtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5531
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

> Subject: Re: [PATCH v3 3/3] pwm: rzg2l-gpt: Add support for gpt linking w=
ith
> poeg
>=20
> Hello,
>=20
> On Thu, Dec 15, 2022 at 08:58:43PM +0000, Biju Das wrote:
> > The General PWM Timer (GPT) is capable of detecting "dead time error
> > and short-circuits between output pins" and send Output disable
> > request to poeg(Port Output Enable for GPT).
> >
> > This patch add support for linking poeg group with gpt, so that gpt
> > can control the output disable function.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v2->v3:
> >  * Updated commit header and description
> >  * Added check for poeg group in rzg2l_gpt_parse_properties().
> > v1->v2:
> >  * Replaced id->poeg-id as per poeg bindings.
> > This patch depend upon [1]
> > [1]
> > https://patchwork.kernel.org/project/linux-renesas-soc/patch/202212141
> > 32232.2835828-3-biju.das.jz@bp.renesas.com/
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 76
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index fa916f020061..6bf407550326 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -31,6 +31,7 @@
> >  #define RZG2L_GTCR		0x2c
> >  #define RZG2L_GTUDDTYC		0x30
> >  #define RZG2L_GTIOR		0x34
> > +#define RZG2L_GTINTAD		0x38
> >  #define RZG2L_GTBER		0x40
> >  #define RZG2L_GTCNT		0x48
> >  #define RZG2L_GTCCRA		0x4c
> > @@ -48,9 +49,15 @@
> >  #define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> >
> >  #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> > +#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
> >  #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> > +#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
> >  #define RZG2L_GTIOR_OAE		BIT(8)
> >  #define RZG2L_GTIOR_OBE		BIT(24)
> > +#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
> > +#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
> > +#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
> > +	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE |
> > +RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
> >
> >  #define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> >  #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > @@ -64,12 +71,16 @@
> >  #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> >  	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> > | RZG2L_GTIOR_OBE)
> >
> > +#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
> > +
> >  #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> >
> >  #define RZG2L_MAX_HW_CHANNELS	(8)
> >  #define RZG2L_CHANNELS_PER_IO	(2)
> >  #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS *
> RZG2L_CHANNELS_PER_IO)
> >
> > +#define RZG2L_MAX_POEG_GROUPS	(4)
>=20
> The parenthesis are not needed (ditto for RZG2L_MAX_HW_CHANNELS and
> RZG2L_CHANNELS_PER_IO).

Agreed.

>=20
> > +
> >  #define RZG2L_IS_IOB(a) ((a) & 0x1)
> >  #define RZG2L_GET_CH_INDEX(a) ((a) / 2)
> >
> > @@ -91,6 +102,7 @@ struct rzg2l_gpt_chip {
> >  	 */
> >  	u8 prescale[RZG2L_MAX_HW_CHANNELS];
> >  	unsigned int duty_cycle[RZG2L_MAX_PWM_CHANNELS];
> > +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS *
> > +RZG2L_MAX_HW_CHANNELS);
> >  };
> >
> >  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > pwm_chip *chip) @@ -470,6 +482,69 @@ static void
> rzg2l_gpt_reset_assert_pm_disable(void *data)
> >  	reset_control_assert(rzg2l_gpt->rstc);
> >  }
> >
>=20
> A comment here about the purpose of the function would be nice. Just from
> reading the code it's totally unobvious what happens here.

OK, will add the below comment.

/*
 * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
 * configure the pin for output disable.
 */

>=20
> > +static void rzg2l_gpt_parse_properties(struct platform_device *pdev,
> > +				       struct rzg2l_gpt_chip *rzg2l_gpt) {
> > +	struct of_phandle_args of_args;
> > +	unsigned int i;
> > +	u32 poeg_grp;
> > +	u32 bitpos;
> > +	int cells;
> > +	u32 offs;
> > +	int ret;
> > +
> > +	cells =3D of_property_count_u32_elems(pdev->dev.of_node,
> "renesas,poegs");
> > +	if (cells =3D=3D -EINVAL)
> > +		return;
> > +
> > +	cells >>=3D 1;
> > +	for (i =3D 0; i < cells; i++) {
> > +		ret =3D of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> > +						       "renesas,poegs", 1, i,
> > +						       &of_args);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"Failed to parse 'renesas,poegs' property\n");
> > +			return;
> > +		}
> > +
> > +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> > +			dev_err(&pdev->dev,
> > +				"Invalid channel %d > 7\n", of_args.args[0]);
>=20
> this hardcoded 7 is a bit ugly. Something like
>=20
> +			dev_err(&pdev->dev,
> +				"Invalid channel %d >=3D %d\n", of_args.args[0],
> +RZG2L_MAX_HW_CHANNELS);

OK, will do.

>=20
> or
>=20
> +			dev_err(&pdev->dev,
> +				"Invalid channel %d >=3D "
> stringify(RZG2L_MAX_HW_CHANNELS)  "\n",
> +of_args.args[0]);
>=20
> is IMHO nicer.
>=20
> > +			return;
> > +		}
> > +
> > +		bitpos =3D of_args.args[0];
> > +		if (!of_device_is_available(of_args.np)) {
> > +			/* It's fine to have a phandle to a non-enabled poeg. */
> > +			of_node_put(of_args.np);
> > +			continue;
> > +		}
> > +
> > +		if (!of_property_read_u32(of_args.np, "renesas,poeg-id",
> &poeg_grp)) {
> > +			offs =3D RZG2L_GET_CH_OFFS(of_args.args[0]);
> > +			if (poeg_grp > 3) {
>=20
> Maybe a cpp define for this 3?

OK, will use the macro RZG2L_LAST_POEG_GROUP.

>=20
> > +				dev_err(&pdev->dev,
> > +					"Invalid poeg group %d > 3\n", poeg_grp);
>=20
> You're missing

OK, will add here and above as well for the HW channel check.
>=20
> +				of_node_put(of_args.np);
>=20
> here.
>=20
> > +				return;
> > +			}
> > +
> > +			bitpos +=3D poeg_grp * RZG2L_MAX_HW_CHANNELS;
> > +			set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
> > +
> > +			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTINTAD,
> > +					 RZG2L_GTINTAD_GRP_MASK,
> > +					 poeg_grp << 24);
> > +
> > +			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> > +					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
> > +					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
> > +		}
> > +
> > +		of_node_put(of_args.np);
> > +	}
> > +}
> > +
> >  static int rzg2l_gpt_probe(struct platform_device *pdev)  {
> >  	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS); @@ -512,6 +587,7
> > @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		goto clk_disable;
> >
> > +	rzg2l_gpt_parse_properties(pdev, rzg2l_gpt);
>=20
> I don't like the function name. THe function doesn't only parse the
> properties but also implements the needed register writes. Maybe
> rzg2l_gpt_poeg_init()?

OK will change the function to rzg2l_gpt_poeg_init()

Cheers,
Biju
