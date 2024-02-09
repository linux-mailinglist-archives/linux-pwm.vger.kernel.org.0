Return-Path: <linux-pwm+bounces-1257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E740984F580
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Feb 2024 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E1B2594E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Feb 2024 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7A381A1;
	Fri,  9 Feb 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EdQC3Owj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2079.outbound.protection.outlook.com [40.107.114.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F237710;
	Fri,  9 Feb 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483695; cv=fail; b=pZjrMk4D/YR6+5FJATkAWvLZ33rLTWyOuDk5zDBRBIoJCajcOyzNF9xw5VwO/wrNJGSPZ701pq8zrupviHyIcAnfEis2Lqhfpn254haYs59C1d5u0RcqdVoyjgrGrT+qonQFCbL1ODEBC/Y2Uw3vEamCpBDqTxPUVbplWSSVcew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483695; c=relaxed/simple;
	bh=AfeFwiU1QQAVOwO/Ufq4Ktyb2/h3YKqRCa3u94C9/AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KWLc79ku9q21iSEBnPV0YTgULQgIxhT7Uoa8S6wcKSddR2zllf4+w8jPzyYrb5Au81KrWV/XNd+6Xx43nCiOzHx4zFCdPcEUsxsaMLs+9bO3Y+8Mv4QtPwEq1LEiw3Ww3c5DW7d/DvYvMVxE6wQ/Y65+EkF52lDFY9+JhXaiGV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EdQC3Owj; arc=fail smtp.client-ip=40.107.114.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OukY0uK1L1kdk5WgW9lS68oF5dPOAP/Pw+8v5t/SJX0fXpSbDVL3alY1ihvvhu4SEhiawFzrHmksxY5uA9FWtyl2ERVOhTIGHFZGm91Mi/xhb3AlQs8LKQPlMDDULpLzFoKMu6yiiAa2s90CSKh8DadP0jJLyI27g46BEwpoCcrnR35FFaqTfP58CKnSsiwiWuqSmjpj585y9Hf7SokFku79YSyFECeDPKRIZNdIq0dhQRXxRP5hPBy31MylkSzi7VYsTzXcq/h9wsJUvqKGVM1sNmaSV80IzHZbw9SdNRfMODYNvMIs9rncvvVgYoz63MbhK3SevcYnB2fD5aGIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmVV+TMYTAqDf5Ho4yvm2VKu/6p4tYCNfeXcMKak7mA=;
 b=ku10CPSckGpDDirBY6GrvFyYAdFIoenWxK7pEW61FOyC9/P4GQMMioFJN9PEiMyiMCwPrU5gL4H0muKdHcWlSNCLD73S0YbfW0NzkbTeGi+9W/FYxgGWsmGkoYOzUyN96CCWGd+1zhw3+E7Tm7GpZdx3RaByZRC/uzKD6awZBq+A9jHQuppqPlOxqPqr8lGrUJ9SI5VLGVTuRBiprFIL8zxgGt8pHJxhxMmw5zjjJcE7mFFGOtCWuhKMClLQDC0u20jjN7yJPRHeiI7dSAeGwibbs9tuFVc1GBZ17XI3jC1zFNcb0yMKgrEBwD/TqUTa1qsTf0DCzdOaB6Sp/4tQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmVV+TMYTAqDf5Ho4yvm2VKu/6p4tYCNfeXcMKak7mA=;
 b=EdQC3Owjs117MJ45Y54YkLycUCcztZILMxSzsSjfRP1eQ8VuCNwWOOYTmpQZh0IAzZtFuTNuYCENL4r0QTzv4lWNskbbA81/Z6RVA4Vmuye1wfRWpVanhDvinozsWZdoKMhCBBkEmQH7wKnTWcCQkkcgZlIruC2oAkt0+WU1vgE=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by TYWPR01MB8329.jpnprd01.prod.outlook.com
 (2603:1096:400:165::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 13:01:27 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::30fc:68c0:95df:41e9]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::30fc:68c0:95df:41e9%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 13:01:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Thierry Reding <thierry.reding@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v17 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Topic: [PATCH v17 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Index: AQHaG6Vl7hzseDTNIEm0zYYEZnfrvbC6iUGAgEfqqDA=
Date: Fri, 9 Feb 2024 13:00:17 +0000
Message-ID:
 <TYVPR01MB112795CFC0E87360CB54DE26D864B2@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-5-biju.das.jz@bp.renesas.com>
 <iukf4j5bewacpg4k2ucczwjdcv2wvmokjqxasvgij6l6436chp@r242vjhfwaee>
In-Reply-To: <iukf4j5bewacpg4k2ucczwjdcv2wvmokjqxasvgij6l6436chp@r242vjhfwaee>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|TYWPR01MB8329:EE_
x-ms-office365-filtering-correlation-id: 1db54a2e-8ca6-4de5-372d-08dc296f1086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2ml2BefqWSXrjFpxLeBY7/MWoj9nykEyYBt5+dgfk/HOwdfh8hcp+Ujyvp+M0pncxNaR1tqnFMe+ACAuNHzvVD05Yj5f1vkfQd5CueUSH0HfNgQUZd100PRiuhwxMk6yaZjBSWLFVqiwHOVzQPLrcHvU4XvRq/nIR4qz8K96LeuqDuPx/zfIKKIkEqn/ay9Hskc1YcbKA8u09m2Z+E9XvGExaZcHh3G1Yv5+6qGNzneZbXCeSPRTPmaNiBSaQheulcdLhM/kzeC8l1dguKl7ktYlP8Z9DckoQmiVQXcn87BoFrTGU4VXWRWL3zZ5y/PcgOKiN7tpKqMSvIyMNdke3XC0OAbqQkTLgNAf9jrBIB5Ec1zns4VZ7Xi7/ueJIaoO+djaKkpgalchonoJYFwFWDrbnHQlPW9xR0+2aGF+9v/rjaenysPI9Cg6OLgIRDVb6ApGjlfWWLQvoRQsFyDdRrkieAMSiNk2jiGrJVlxubUjqc3E9IxXMWeW5ekcNwtESJB1H3TNAUY9DRclbRWNDXqOF+8a6G0lFHV0GSF43NQda36VMXmeGEvlGIl8H0PB+4Yrf6OvpKeifoOkI3oUiPQSwBRhQc+TLkY8KhWtif0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(8676002)(52536014)(5660300002)(66574015)(83380400001)(26005)(86362001)(107886003)(33656002)(38100700002)(122000001)(6666004)(38070700009)(76116006)(7696005)(66446008)(64756008)(66476007)(66946007)(54906003)(66556008)(316002)(6916009)(71200400001)(6506007)(53546011)(9686003)(966005)(478600001)(4326008)(8936002)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/IoaEe78pRNhyej/K7mJq4MA0dNz7i+fEI/Uy7vHvnFJ0ay2xXTFDBBoxL?=
 =?iso-8859-1?Q?rw1ro/9358cFdOJwaaXmgcEwe1ACJh99tJMLQv/NrXcbcSg3hzBj9QF5DK?=
 =?iso-8859-1?Q?S3z0PWsRYtsl539lonrofHbaynvGVxj/LW18sek77d+ax9tN5jqgPlF4CT?=
 =?iso-8859-1?Q?u8JaNEuVzXgjO/frcXk0lVsDuS9hbXhImKwF54UnhqakIzK1eiOKmjLH3z?=
 =?iso-8859-1?Q?hq1HSk6ogCdbLwjxYfHdhAV5K4DXtuvOocHddEfjaBWVhaycQG/jiV3omH?=
 =?iso-8859-1?Q?nzOoM15IPPB1E0mkxm46msJY8Cy3WrY7XNYZdi6+HZMiqg2QtImNwAS7A6?=
 =?iso-8859-1?Q?IYOvYush9C/u4KnRVvEFkr24QDVTJJaYcDAkdeaN0JWqcttyXZlveRWCtB?=
 =?iso-8859-1?Q?8GAivEmBUrVgeyX6jOnf+jEm9zitK29JbtmtPMDdnUja8guX787hmvoZSo?=
 =?iso-8859-1?Q?dod0b9Sz8VwfPjzt4xFZOyYkEe1nu8oEGag+9hnYc/1K07SPOFok27nwZy?=
 =?iso-8859-1?Q?tR5X1Z1mdnFJmQorr20AAqOMSeH31HyWo3pS+MSp/6vn9v9YndByx5DoVW?=
 =?iso-8859-1?Q?ILbPkuJFa7p4MSgUMptCxjsXXfZZUnUJsTL+m4TIQi0M+Gipfh1Ys21uFy?=
 =?iso-8859-1?Q?7GNB7P7xUsZbgqeHpM6xWXq/Q4dH1pnw6kEGC3CA4pdU4gqGbu8L4hhQgL?=
 =?iso-8859-1?Q?oNgg19sFeNOX3sFuDCpORC4ZOCUanshRE9/T2gHLiigXiPszwdVflgJ+6t?=
 =?iso-8859-1?Q?flk58d/j05igIWfdD1pa+0bybCTl5LKlsDO47TL02GYHXqAzS+XS2Uojv+?=
 =?iso-8859-1?Q?MB46u/k+yVhtFxApAOKgNdo/2G98sgmXaFoRk9RydB7RUYNlj2ryqmxtRK?=
 =?iso-8859-1?Q?63tq2NS7ErpTXFlX7dcJDS7HM/c4cbA+197MADdfmBKDIfCPTvZcKmFLBY?=
 =?iso-8859-1?Q?+by/MU4TrrJ8Ym8+3xS+r2OcByqkDnD1bGn0OWZAbjSyUJs0LsbxtReR0z?=
 =?iso-8859-1?Q?44oQQndAwc9APfWi5SMf/S1aPhkV/m9JFC7FSna/i4NFYIKEVz0+Qs6wkV?=
 =?iso-8859-1?Q?APuGCGjNSProFRcNvlUx1EaVWPH62RBLJcWx2dmzbF+eAJoC+rSNY7uSXM?=
 =?iso-8859-1?Q?SbfwJdMvgCnYJDcGkAhWTYaZXV9yjMnMqHqJohZU97w0YEblHTfVw5uo4O?=
 =?iso-8859-1?Q?ZC8pP0kFQZu0qv2WDmEZftJfWufOwfjoR85XudS160FhCoOyhaDMP1TKLy?=
 =?iso-8859-1?Q?x+6ZS+BbuhEennRkzrHQPnULQWkMbY7JgnkivynfYm00qCRuKYNmWzdL3V?=
 =?iso-8859-1?Q?5I11OD5AuZzJiIW+Zhe1ay2qXpl17tOIQZrAqfLWFhoLBM3lLJooop3dI2?=
 =?iso-8859-1?Q?TglCRweIL/fJ8vRVtIJ0Vem68TD4EMUHkieOEdzg8CHFI7WxMiDyALTYmX?=
 =?iso-8859-1?Q?K34sJRZ2VzIDlVoX34EuHqTEyqW2KmZ9ytdrR6RSgyuA9uzNdQaEFXWhTe?=
 =?iso-8859-1?Q?4RtIOyj12VeXKg/oEm70w8g0VVeVvAVBzxcjf6xJ9fszAJQ+JT2qntQIcv?=
 =?iso-8859-1?Q?2RRv3DmqdPBiKY4u7wY41iFSWIoFIvnB4fc+u44nsoaEXZ1d4TWcvneMEx?=
 =?iso-8859-1?Q?Q6JCXigVZz/+jQZA/8S8retQWPXMg2D7LIKhkjKzosfNFGThesLYzCJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db54a2e-8ca6-4de5-372d-08dc296f1086
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 13:00:17.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZcsoqW26ryE6HWbEVu1ZONLsVb0p2MWLDV46oCuZOtPfZOQ9xKoB5fNMmqR14GD4/8oZvn0lwoBdX+H2qw1gclSButj0YC/vAIV5LRwbbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8329

Hi Uwe,

Thanks for the feedback. Sorry for the delay as I was busy with improving
network performance on RZ/G2L platforms.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Monday, December 25, 2023 6:29 PM
> Subject: Re: [PATCH v17 4/4] pwm: rzg2l-gpt: Add support for gpt linking
> with poeg
>=20
> On Mon, Nov 20, 2023 at 11:33:07AM +0000, Biju Das wrote:
> > The General PWM Timer (GPT) is capable of detecting "dead time error
> > and short-circuits between output pins" and send Output disable
> > request to poeg(Port Output Enable for GPT).
> >
> > Add support for linking poeg group with gpt, so that gpt can control
> > the output disable function.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v16->v17:
> >  * No change
> > v15->v16:
> >  * No change.
> > v14->v15:
> >  * Updated commit description by replacing "This patch add"-> "Add".
> > v3->v14:
> >  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
> >  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it no=
t
> only parse
> >    the properties but also implements the needed register writes.
> >  * Added acomment here about the purpose of the function
> > rzg2l_gpt_poeg_init()
> >  * Removed magic numbers from rzg2l_gpt_poeg_init()
> >  * Fixed resource leak in rzg2l_gpt_poeg_init().
> >  * Moved the patch from series[1] to here  [1]
> > https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-bij
> > u.das.jz@bp.renesas.com/T/#t
> > v2->v3:
> >  * Updated commit header and description
> >  * Added check for poeg group in rzg2l_gpt_parse_properties().
> > v1->v2:
> >  * Replaced id->poeg-id as per poeg bindings.
> > This patch depend upon [1]
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 83
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 428e6e577db6..a309131db8ee 100644
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
> > @@ -64,6 +71,8 @@
> >  #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> >  	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> > | RZG2L_GTIOR_OBE)
> >
> > +#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
> > +
> >  #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> >
> >  #define RZG2L_MAX_HW_CHANNELS	8
> > @@ -76,6 +85,9 @@
> >
> >  #define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> >
> > +#define RZG2L_MAX_POEG_GROUPS	4
> > +#define RZG2L_LAST_POEG_GROUP	3
> > +
> >  struct rzg2l_gpt_chip {
> >  	struct pwm_chip chip;
> >  	void __iomem *mmio;
> > @@ -88,6 +100,7 @@ struct rzg2l_gpt_chip {
> >  	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> >  	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> >  	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
> > +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS *
> > +RZG2L_MAX_HW_CHANNELS);
> >  };
> >
> >  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > pwm_chip *chip) @@ -454,6 +467,75 @@ static void
> rzg2l_gpt_reset_assert_pm_disable(void *data)
> >  	reset_control_assert(rzg2l_gpt->rstc);
> >  }
> >
> > +/*
> > + * This function links a poeg group{A,B,C,D} with a gpt channel{0..7}
> > +and
> > + * configure the pin for output disable.
> > + */
> > +static void rzg2l_gpt_poeg_init(struct platform_device *pdev,
> > +				struct rzg2l_gpt_chip *rzg2l_gpt) {
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
>=20
> If you use of_for_each_phandle() here, you don't need to determine the
> length first.

of_for_each_phandle() will iterate 6 times for the below[1] list of=20
phandle and channel index pair tuples.

What I need is just loop 3 times and get the poeg_group and gpt_channel fro=
m it.
So, determining length is simpler than looping 6 times.

So, are you ok with existing logic?

[1]
renesas,poegs =3D <&poeggd 4>, <&poeggb 1>, <&poegga 2>;

>=20
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"Failed to parse 'renesas,poegs' property\n");
> > +			return;
> > +		}
> > +
> > +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> > +			dev_err(&pdev->dev, "Invalid channel %d >=3D %d\n",
> > +				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
> > +			of_node_put(of_args.np);
> > +			return;
> > +		}
> > +
> > +		bitpos =3D of_args.args[0];
>=20
> This can be moved further down, and so nearer to where it is actually
> used.

OK

Cheers,
Biju

