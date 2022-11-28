Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0342763A9ED
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 14:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiK1Nqs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiK1Nqr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 08:46:47 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA37382;
        Mon, 28 Nov 2022 05:46:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7wWWxWRsebqIm4yOpRBBDhSefqwdxPPAwrFLMK2Huy2HCAKxUYGMoXmMBhRPEnHgK8juYoxp/r9WJYVT9rP9AQRmphhLoj58iBenUwpEMsAbiBgHByYbFLpMaDSGMiDBSD+MdfCT5Ke9IKriY4p3J2MMHPVKV9E8UPC733Nl+z6wtz99/7qBEVHm3/fU6JzV7ULT+yxjKpXtuYwRNvjshA0IAxCSjknLmxk2idZDomhgep7NXLutf8XzusJzp313UhYOBVjdm1gVlPGuX131DQ19opLkBBd9ACZoKa4FVIrS4RY8vybGGVWExew+G4dAatLyRNYGM60iCas47H3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqAx2iUuItbmQO8ai2vbRGIsTieo0YF8kaLM8qxk/ew=;
 b=lmnPAkbuQri7sIBZV8D9IygwMHEH7MSypOHjavRB5KLwmmNtlHgaiprHvJ0U1ku4WqLNtE0qzvmC5GmwpW7GSp70URO1ki/OhjJjZUgAIvbOwIL5atqYvUQzhc5k5lQQMipH+Xiw55rF4tpCJdHa06ECY2ycAnjajtE9FwdIsRwrU5GsqPaBJIJaBUyIk08oBpB+NDtYazO45p3W+oCSA89rt6Ev3EuzB2PmhnwWmkDszyLs4JH8TEfXg5w7n8K6oQndDWyjgi+pPjU/fbI3yCKktLE8CVCc6uQVWaw4I3xVUWSMOo04uyfD5VBQqci6OH1dN2WgPxQUcHO7xn3NnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqAx2iUuItbmQO8ai2vbRGIsTieo0YF8kaLM8qxk/ew=;
 b=iNV6j1DkQlf/iylnvREmdet7OOjSJDobziqrZ2JtKitsAz40duOgK1IM9kg1rD/ZZFRbo/WBgNTjEKxGgPoIOQ0AxuJpu9YlUlL5B4P756uZz9dsL61CHBI9jj+4fQUlDbl+Lm6hGlBk8M37Qhi6EQNupw0BJ9VEgXK1LZmpQcs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9798.jpnprd01.prod.outlook.com (2603:1096:400:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:46:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 13:46:42 +0000
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
Subject: RE: [PATCH v2 3/3] pwm: rzg2l-gpt: Add support for linking with poeg
Thread-Topic: [PATCH v2 3/3] pwm: rzg2l-gpt: Add support for linking with poeg
Thread-Index: AQHY9gP+ipRhubVZ6Uq3Owxo2pEeS65UZukAgAAEcmA=
Date:   Mon, 28 Nov 2022 13:46:42 +0000
Message-ID: <OS0PR01MB5922EA1F2421DE35FED7628386139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-4-biju.das.jz@bp.renesas.com>
 <20221128130104.tthhusejfv5qgnyy@pengutronix.de>
In-Reply-To: <20221128130104.tthhusejfv5qgnyy@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9798:EE_
x-ms-office365-filtering-correlation-id: 8125bada-f6a5-40ce-1cde-08dad146fbbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92hTOohWpW7XxA6S2rQbAiu832RIW8o6n4RzJ9GeGNjwuXVp0XNc4nbCvVOXhILtJ8Mn07BozEFVf5je8qdF4Pdxqi9OxgRsdZ2paRwPuQWMs0hDFWYP9oxEE1bA/Xdql4XWJC+7gBS9Dc/vnBDZz1KQ53XEjQ60NMJ8AG9aJGidDf0prwUUlbIoO/osufDj6aJa4mDATo9c3pWJmDstDmlvaKrF5dhDENN0pFpMUi0LZHwN7OyYcSSagi/JZX8LJFbyZZ4qaBXogysQuCE9ZGEDVzIUJMXVYV1QkawyclrF8LnYrHa5ThG3Bh3G09jV4sgR9PwYBvORkAAvGQnC4/UY+o/AdqEoHBxcG9TujsN8fuJXVsnihs8I1LUNxtqATR877JIhNuY013BlksqSAJFgz+TcUz0Bsi306OgeT6MrjEoReIs9wp2iXkzOPfqWzLb2nJWJbMXuZSusOHKy01LUUCcR0FIwOopXhk1CHpRv75YS2UrVLUyVjyd5XEN2FXuqDfcmTIu83nULGzcgGbp6ZlWcyHpOeiFRgZKfHF069+23Jr5zyfABWowWqrbhjXHkPTcN8PModcaG0RbqYvLvdD66b3MZYl6gJCFKJnv5q9zwennVMycizozxM690pubOvbsmBzMDdLQGgYHKc60gL8l+yEn2wJ943LJIMWRHZPnvh9XusMYxRXea0TVy8PEpmYdomocOlD7QVNUDm/kw1ofnLhTeB+ouZJ4RMmQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(2906002)(83380400001)(7696005)(966005)(38100700002)(6506007)(33656002)(76116006)(66946007)(8676002)(41300700001)(66476007)(66446008)(64756008)(66556008)(26005)(71200400001)(122000001)(478600001)(186003)(5660300002)(8936002)(9686003)(4326008)(86362001)(316002)(6916009)(54906003)(52536014)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5u+rgouxBruYrmdNUktnPTUBNPJb3ovO3hiWwYm9y4aUaW7wPjl3VL8wwa?=
 =?iso-8859-1?Q?glo10xRwos7rZdSTrPbZLclTqfNiBnsH62VlbwvU/FdVIwQBS2zFbTO6KO?=
 =?iso-8859-1?Q?MvmYZ/s5Dmkq9K0QHMVNbnvGdpMggfTg5wHCJr3hziVf2hKTM+wjLGLHYN?=
 =?iso-8859-1?Q?X9SopA4viESekYX1A28QfGTBP/n72gZ8u8DUudNZgALSoc3zXdiSxPUHYS?=
 =?iso-8859-1?Q?IX7M2TqvLfOPEFlG0q8RMSOsVNeWaUpG2Na8R2ezlPsMIaFm9MeDccQtrL?=
 =?iso-8859-1?Q?7Y7vD0boIMe239pFMISKe7WnFo2gToqCCqtpdHcwBiBL4lmH8JnjHuOKcF?=
 =?iso-8859-1?Q?HFBjAiu7RkI7AhgcZIbOBeBMn5WkPocAnnTo92X1m/WqVftDFy4ILNcdSE?=
 =?iso-8859-1?Q?hylQZVzbxS87vhHl1HTTTQFQlPrmri85zeerSKomeOUOSohP2b6vklNrH9?=
 =?iso-8859-1?Q?HbIED4nyLMToCKOP3+n1jCH2ev/F/TfhvM5CX7XrGYC3izP5636f4hvr9e?=
 =?iso-8859-1?Q?I1MUBIFzZM6ogQ59eopWK9Jy8Qmm+MK8cAfKWZwmJK09wabsGRtLAZiTr/?=
 =?iso-8859-1?Q?uxYrWezV/Skpc8tUxKAdMV2c1s3WDguekUXhpVyOShNMZ3/TQnYQtFMIw+?=
 =?iso-8859-1?Q?sLeD4OgktSwIpU4C/A7lRIDIU4kGZcPG8yp9WMkqLoRzrQGwZ1HZTVGMvA?=
 =?iso-8859-1?Q?nxQ5t6GG0+SQJAeE2P0UclgKw/XclRpcYkQc3qZv3ZVmY6okhaMjs9cSZB?=
 =?iso-8859-1?Q?NQhzRcAf6Hs9j6Cbg9Ff1u0TyWieLG/UcW3dE+5xX+3ZTrjIL87sJhu1FX?=
 =?iso-8859-1?Q?U+haGZAXhZz88v2co2PltmQWPYyFk4sy3bHU3N2+bZfTI1wxA3NOmcaftT?=
 =?iso-8859-1?Q?W4c7sz9Uj9CtHKC3e5ZpcSm2KDUOTqOntaUATMl5bTP5F2Pw9n7tBY5nuy?=
 =?iso-8859-1?Q?OR+2oEXKG+tQ7wbYv21MUKbSF40ifsiUyTZHOgPbcKhg+3erukqh1FKdl4?=
 =?iso-8859-1?Q?d9qBthBraOE3uDx18LnOYeyV1A1hVvALD9jaHqpNPZqzF63a1L66ny2RmV?=
 =?iso-8859-1?Q?8dgXxnNy/tAFEPIa/9ZAo1m8XvU0wQ3El37j5mazXY3RGFpRss1qui4fxj?=
 =?iso-8859-1?Q?BG9i7XnDw0YtQDNjeLb8fLeaw5siiiDqj4r1KR3KC8vt8S3itfB7cjhrWU?=
 =?iso-8859-1?Q?AC1w/OsSi1oEAYEU/+q4nSw4B1nlgKi1HVXYg2F55pGvlvjPhCv+v6ZywR?=
 =?iso-8859-1?Q?zqJQm97ZHDwZnQRbX4pAKiRVMgm686nW++EvCBOCjrfkn4QtKT4rrJRHtn?=
 =?iso-8859-1?Q?0b0HAxrl95y7W8+U03ldQ9rjBFJ1Vh5WTcpTAJbcIQ/zhrntxFJMgppdul?=
 =?iso-8859-1?Q?n6lqWvcDBJOGGSqGU9YBt7PVtL2bZiRNV+rov5zGvKrsVIPU2EvgfTQnv7?=
 =?iso-8859-1?Q?1fhaYBUfAiuSE3p/MBA2shPcojnsjEx72M3Xo2KJbxQ8y6zjMM/w0YMgRn?=
 =?iso-8859-1?Q?zrLpEFIi9uglI11J0mhKEUMZcIvS2WCUz9aV0vExcLd9jXRxeOfLQaJC7n?=
 =?iso-8859-1?Q?W8VBq/5VHKCtvb7zKrhFizas8l9KzOFSJnwpoXu+A7CouUeY9jtUbXix8r?=
 =?iso-8859-1?Q?aC4X1KE/Z6BuDRuYzAF2NZ1/2lr2Ixeyv5+mUG12KnkWbjCx1Ha3t4OA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8125bada-f6a5-40ce-1cde-08dad146fbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 13:46:42.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVPLeuniGFmgXDrwOGLcBdKPKctbjCEpWIYKS44Iuyv+vshIzAgpNDojAPz5nezisWealJ7JBTkh1oRzB8z0PWZu+XLd+Xcti32dC8DBrV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9798
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: Re: [PATCH v2 3/3] pwm: rzg2l-gpt: Add support for linking with
> poeg
>=20
> On Fri, Nov 11, 2022 at 07:29:42PM +0000, Biju Das wrote:
> > This patch add support for linking poeg group with gpt, so that gpt
> > can control the output disable function.
>=20
> Without knowing what a "gpt" and a "poeg" is, I don't understand the
> purpose of this patch. Why do I want the gpt to be able to control the
> output disable function and what is this?

gpt is General PWM Timer (GPT)

poeg is Port Output Enable for GPT (POEG)

gpt detects "dead time error and short-circuits between output pins"
and send Output disable request to poeg

poeg performs "Output-disable request from the GPT" and informs application=
.

There are 4 poeg groups shared to all the gpt hw channels.

gpt needs to configure a poeg group for the following poeg operations
1) Output-disable through Input level detection based on external pins
2) Output-disable request from the GPT
3) Output-disable through register setting.

For Output-disable request from the GPT, it needs to configure the type of =
protection
	a) Dead Time Error Output Disable Request Enable
	b) Same Time Output Level High Disable Request Enable
	c) Same Time Output Level Low Disable Request Enable

The code flow for Output-disable request from the GPT is something like bel=
ow
1) gpt detects a short circuit and send out-put disable request in the form
   of interrupt to poeg.

2) poeg gets this disable request interrupt, Output is disabled, and it sto=
ps the Output-Disable state internally
   to avoid IRQ storm and informs the application

3) Once Output-Disable request is raised, the interrupt processing in appli=
cation software should identify and
   solve the cause of request. After that, the status to be issued should b=
e cleared followed by the release of
   Output-Disable state.


>=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Replaced id->poeg-id as per poeg bindings.
> > This patch depend upon [1]
> > [1]
> > https://lore.kernel.org/linux-renesas-soc/20221111162325.471963-3-biju
> > .das.jz@bp.renesas.com/T/#u
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 69
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 3f9325e958b8..e16f976c3dcb 100644
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
> > +
> >  #define RZG2L_IS_IOB(a) ((a) & 0x1)
> >  #define RZG2L_GET_CH_INDEX(a) ((a) / 2)
> >
> > @@ -85,6 +96,7 @@ struct rzg2l_gpt_chip {
> >  	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> >  	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> >  	u8 prescale[RZG2L_MAX_HW_CHANNELS];
> > +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS *
> > +RZG2L_MAX_HW_CHANNELS);
> >  };
> >
> >  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > pwm_chip *chip) @@ -438,6 +450,62 @@ static void
> rzg2l_gpt_reset_assert_pm_disable(void *data)
> >  	reset_control_assert(rzg2l_gpt->rstc);
> >  }
> >
> > +static void rzg2l_gpt_parse_properties(struct platform_device *pdev,
> > +				       struct rzg2l_gpt_chip *rzg2l_gpt) {
> > +	struct of_phandle_args of_args;
> > +	unsigned int i;
> > +	u32 poeg_grp;
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
> > +			return;
> > +		}
> > +
> > +		if (!of_device_is_available(of_args.np)) {
> > +			/* It's fine to have a phandle to a non-enabled poeg.
> */
> > +			of_node_put(of_args.np);
> > +			continue;
> > +		}
> > +
> > +		if (!of_property_read_u32(of_args.np, "renesas,poeg-id",
> &poeg_grp)) {
> > +			offs =3D RZG2L_GET_CH_OFFS(of_args.args[0]);
> > +
> > +			set_bit(poeg_grp * RZG2L_MAX_HW_CHANNELS +
> of_args.args[0],
> > +				rzg2l_gpt->poeg_gpt_link);
>=20
> You might want to check if poeg_grp * RZG2L_MAX_HW_CHANNELS +
> of_args.args[0] is less than 32 (i.e. the length of the poeg_gpt_link
> bitmap). Also ensure that poeg_grp is withing bounds.

OK will handle this in next version.

Cheers,
Biju

>=20
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
> >  	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
>=20
> |
