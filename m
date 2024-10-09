Return-Path: <linux-pwm+bounces-3576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2798799722F
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFD1C23FFB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CB0149DFD;
	Wed,  9 Oct 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ALPig8n/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391221D2785;
	Wed,  9 Oct 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492243; cv=fail; b=i8K58UZohkQpqaWxZ1qOWj4mPxy18EgRz2Yf2xuTnwZJIP5tXEma3gor21y4rLZlMS4PR523US1gN31bbTeeR2JVPuQIl1uJaILtFXIhLM1MbNJUrDKWX0ASTwqXB5Volnr4KaxRxZXtEHbxEx5Zq6ZhxqKYz4E2/ZS0RX+bLp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492243; c=relaxed/simple;
	bh=9IbBUMUz3fZ7ojh4KvhyZ2sNOicJHzHd/It8yQ8L8Aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NcOOA5IoeJy+Sls4J2cZLFK8aqN33sSN06asMa12pbG4AGrVxwaoWfpZXJ76Y9iIHY9VDvtY1tDhnfPPLzwUV8JkuSeTydhdc31kEAC+n+AJ7nWasG6++ypxG87LyeoGJysW1cevm/vICqmOJtACuBFWG3Jjh/vLKbpQY6hSvPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ALPig8n/; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG1QpzeQNhTUTC1lYM+EmyIAuIKV4gohlP9cnnJXAZv+5D8udLwIh9G6Ru1l365rXYdPCVh0g1CAngfiOMpn+/Z2wlDgvP3dPaFDG0fvSDQE4iufM+6zUfKaAQmKm1esmxPbkAbbsbN+kELForpdsEIE0uj6YReEnILJoq6Ebetl5f1JdnvXPj3X2beMPWQ1mZyiGQQkbEDRBc70EjzSJ7FgdbOzEPzZg16Je1v0Dhnmi5Efl/L0CYoWbKEKjTcJ4JcjFpsO21Cd7rQAJBs5AsCLr8mwDB+qM/eHGSszvovw7o44RR2YcaRvwm/zrQ+7EO9lK5Os73d++aYmNkHORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjd34wqIDKXIsS06pV6MFO6eJx+vr0T7199CnnGqFig=;
 b=l4zTtAfFC723hABocEcYL0aQghpcQz61KPHdkdCIxYGyx7DaG22W0uftHSc25WmfngoSrWW8RBcPl9exwRgzzb855nadKI7SLyTNF+SO7Pe/RDei4KD2WQF51B0Vqp5LEw/dwmzh9JrkrWwufEEy95PLk38Yv/j6aP+GGE0aQzyxpRvCVFTAtM+Gw4xeDgounIhNrwcz5D9V/HdYyfYzJi+2qmGNX/eJHarq1L/IZvENxikJI21qCSXjfER5/ISGXuxwSY9sRYeKTee/HN1/9XkRIdZ/vU0iWGy8DIbmdGxdro2iqFHCjZKLCVaVm6lbNn4SlELp2nM3WdXTeHCsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjd34wqIDKXIsS06pV6MFO6eJx+vr0T7199CnnGqFig=;
 b=ALPig8n/m4wQqVf/qn6zZrVCrALuecEXIavrMBZ5QgMUVdu96U4l8xjeAhxE9STG+g9xf2RQqMqxq15H6XdMB+esqJUBNXPvz4XwF3xx0Wn+V0XreoQ9v929LOedqRlDy+ziyeWSIJQvrGekC3qJGSpZl9CxSyPORVcfiIMdHMA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11412.jpnprd01.prod.outlook.com (2603:1096:400:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:43:54 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:43:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index:
 AQHa6ZU4yCrTG4vERkWCKtT81J70kbJo7ssAgA3CQuCAADLRAIAAAuRwgAFtp0CABqsfYA==
Date: Wed, 9 Oct 2024 16:43:53 +0000
Message-ID:
 <TY3PR01MB1134617481439AE1E6C7A21C0867F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
 <20240808131626.87748-4-biju.das.jz@bp.renesas.com>
 <slpywmbmamr4kw4jg2vyydheop44ioladvvm52aocnojgjkcsy@3eoztwsej5mn>
 <TYCPR01MB113320CDF49DB0564A958241A86722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <thfymed6o42wcascazgpvgq6zcqrjxloz3nt5h2pwypqgs4fra@zeyh36lcphia>
 <TYCPR01MB11332D536A0F4F2CA375924F086722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113463CD49C37B05B3D5D5E8286732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113463CD49C37B05B3D5D5E8286732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11412:EE_
x-ms-office365-filtering-correlation-id: 5badcea9-990e-41fa-78a1-08dce8818f9e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QGNmr74LDw8tI1WnlzIjWElR5aSffG4FPMbxeND9QwFG04AUoWPeYOoEXc?=
 =?iso-8859-1?Q?WOcy7DnUuEZH+iId5rBGOmiIAvC7nbd4xcHygmaMrfqwPdL0VTsJOqSNhi?=
 =?iso-8859-1?Q?63aZJqsZAwCD9KAYZ2gSBaJgn6pP6Lzu5sP8yzS0L9kObhCtu5ccJSKs0F?=
 =?iso-8859-1?Q?rtGg3evaLVzBGnS8mJHRNFqRblFyB1KLBDIhR5KFvCBhk5jDPRdpZSzKZl?=
 =?iso-8859-1?Q?m9K6RN7Fg220Ufxyvf4rs7FOtPxlMd9QGJHNe8NAQfSn6972eeq31GGsQU?=
 =?iso-8859-1?Q?Sgy9Y913yVE0jR53t2hfCeQvrJyNbiSaHdMWwv28WKD1/yc6GbRbn4oPev?=
 =?iso-8859-1?Q?4+h+6Su2wxUGelonbFOfPX2xo9PPTMoc7ju/NecoZUe9zGEnYaHzo7PR/Q?=
 =?iso-8859-1?Q?VuR8F7pQGF7da4GmF43EWstjIUJCVTPSc8/Wi+J1c47Por6+1RxBvASA8Y?=
 =?iso-8859-1?Q?YW+VhRoRQoQN+pesuspTUc9635cEf0I0ov+JTTdyUnTAGZAHVJUl1oFpS+?=
 =?iso-8859-1?Q?aoxs4ibBemufs7H/0JstIQeoOXR6cwesreguSqGSFyQ/ozP82F5i4evxd5?=
 =?iso-8859-1?Q?tFzrNQyKSTnwFJALH88rAcUcXtU9Ure7Bl87jRAzeuy8Re3KIB4tCarKTX?=
 =?iso-8859-1?Q?8QUOuTu4JWB5zMC+RQmWTMWODoKD9L3g2RIOVY6mtdjb6NJj3HSIaQCgOI?=
 =?iso-8859-1?Q?Gfe2LWJuxADF7F0ABSeX3hGGgHdq5i4/MakiieZn6BZXd1BpGHkbbJvgNc?=
 =?iso-8859-1?Q?VEwYqpi0UqNYLesB69jLClmh9ErtU3dC9VzTcAijW+6I6U7mlRV7fScCLQ?=
 =?iso-8859-1?Q?3eLJ3IaSOu5GmtDakrhyJ4OR10JhGGk88R2bYUlhka3iN8FkJRxPFbxza8?=
 =?iso-8859-1?Q?LaALOQXzVk1ZLICDSBre2v/ovWz7V9L7Nso/14Z+lUGkKmk8AISCThJfjM?=
 =?iso-8859-1?Q?df4TUxAiR/xXU9wSA/6IOqrGiAH/lIT87U1tMEJL24TAtcelBdCO/pRury?=
 =?iso-8859-1?Q?WLmrr7++4SVca/h6ATAzKekNF8KvZobusbxzHimTblK68x4u0SRKgQYEEa?=
 =?iso-8859-1?Q?R2Ow2V0i3/1nYtvBJUmTmRt9Syt3TYC5pwRA/FcuQHCyhFOEyttkPkZ8+g?=
 =?iso-8859-1?Q?W3Jzkb0YyspD3S2BxJS6mZkuKn9mmpxkrN1gNkNMCwcz9hqOr2Qzgp1J2Y?=
 =?iso-8859-1?Q?FjHcW0D+SritioVpPiZvDUWuuP0DxrXLp4iBRDNihvLdaX2k65beQSxuLD?=
 =?iso-8859-1?Q?hrDRmd6qGQoP0A/SvxNIYCEEZIC3C848z+I7ZeI3K940dTWym1RbTIxr4b?=
 =?iso-8859-1?Q?yUNURdjmTe5kmfvU5UpME2HrdHRPtB/wYRoQnOOf7dEv9x4Dr6WcTem5vC?=
 =?iso-8859-1?Q?2AZ0w1kQSfoELYclfntHlUVSCc8Z7uhg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Bq0JDeauEwegRiECNWE7xWVpPiIsLxMYxGL76HYwP2FRFGY+c9Ff9ZUIJr?=
 =?iso-8859-1?Q?J1cW3Rr+0PAL/Sg5Sej0S9FV71YxHttQpOjqaSn4+3jCtfqJOV5o7yYaXN?=
 =?iso-8859-1?Q?RPr8Z9UZai9j4HjYSoEOCP81IDhFHfUR0pd8XW3DK8P6z2mMJadgIq0qym?=
 =?iso-8859-1?Q?91G9kycf7ArPvQMw+C6pykoZFsg3G+XLPXlG+ZrI0zMCOdWpeMspIRYUEV?=
 =?iso-8859-1?Q?xpRJJm6d/UB8f8P7vXyKZAnsukk1DsUkZcCyD4yhOMeAfFTqKElD6RpzcK?=
 =?iso-8859-1?Q?WfAfse4SDe2pt3o7wQh9IWHKc7F/evjhBCY1TjpoTiQCk2aY2AvwxKn7IP?=
 =?iso-8859-1?Q?0EigEl4Wx1FjwL9K9BNHbJpJnzq/r7l/cCTJw4ueRZTFQaEP2RHPoZUmFc?=
 =?iso-8859-1?Q?lgUtlfvAPtMU4BA585swf47NRx110MLFcb0naPREAanXpulU6JOehShOoK?=
 =?iso-8859-1?Q?3HGBL7Y6opuMTItE6rTZgp9GDcVdJxDZ2jTRXp0CbHHihZYTaoix8WtBfT?=
 =?iso-8859-1?Q?YXgTCi8QrKfcx6lVwko7EkJtzl3zSS+1grjtLpGD9F2ISeX6YANfMys1V2?=
 =?iso-8859-1?Q?pViodggOkA2D3MAHCaxI3neB/4CzdMN7xtv6xWG3M31OkHFaJcULymmUcT?=
 =?iso-8859-1?Q?ojNi625J9wf72JKt+puz6AbaE41RXoVd7iBTED1CbzvT9HRtdZTqZyEbN+?=
 =?iso-8859-1?Q?MdBnKbKJZW7LWfNVuzwjKtyHBL00zFfDmjDhLyaL12Y0SQDI7AdGZ5/Vfr?=
 =?iso-8859-1?Q?wEyQ8DwJlquoIdOJ+1dByEw/lGs/zqD2TISDWHkHnju4zyycZmCWt12yZW?=
 =?iso-8859-1?Q?K/SbHDVZbOnEWKVLVqJ48EB9x/sEXIs0K9Gmot9DXekr8iT2cTOzAuoWza?=
 =?iso-8859-1?Q?3FfE+/ySWuQJ7r6ZoG6WWAsfvOCOeGULIlQycICCrUlU2boakyksGRZQAE?=
 =?iso-8859-1?Q?f+Gepvkrr5iG7Hm7SUk30kRwL3ah9ySrAycet1QYWd1CvaKlmgGJLFxu8g?=
 =?iso-8859-1?Q?Q7+IDrNaoD2N43IqP3HB/yG9XQ0WPVIle1yVePt8v9yO1wboLd2CJTaVn8?=
 =?iso-8859-1?Q?z0A/Ja2AtLoxkAr1A+56wlN1Q0X7bm/YwhHc9D2tAElNLQIgQn2zWVeL8g?=
 =?iso-8859-1?Q?vtkeWtm1lRRHNENw7TYFICYrSJCGXTe7LP+J8M70IODC58cUWdJQ7UDxR2?=
 =?iso-8859-1?Q?RTPsAXdBFBgWepA1fSqExNVmYKPcvNQeqeIQPGfV1ID0fFmJSfMvl7iEso?=
 =?iso-8859-1?Q?K1g+A5oPxvE6gGJrDbqVxfzrqqqy3XRIP6t3uXLTlgaMr+Ym9T4o5TvzN6?=
 =?iso-8859-1?Q?J9DnosNB2YAmlC83+VUS9eZZ5b7jSph4ocW2dIhLtr2AlpZBiy/nHy3Seb?=
 =?iso-8859-1?Q?e9Y2o+MxH2IOrBwwdjpaWkfDFUhQtwQUcFAuOQ9VAC9lzLdhCJg4fJLZw+?=
 =?iso-8859-1?Q?I66pYzvZ5m44oeNRd+HPfWGeDKVsrOwVrNlNnl8KowOlPkhlNMfXFmwdg0?=
 =?iso-8859-1?Q?t22z9j00C3IuE80lLc593UpmFvLY1VnpElbYr6EUK7/MdnAj8WGhvolNWo?=
 =?iso-8859-1?Q?jegQi5C0jgdi2gmQIVSPNOvMyfGgJr9MTERAZe1pOTT0MwvrUzPbodfsdn?=
 =?iso-8859-1?Q?MQ2k3/xKPTgsMPz39HXeKfpgIzm4r/gD2U2zZGmQkNoVj3sD15QegG8w?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5badcea9-990e-41fa-78a1-08dce8818f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 16:43:53.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeGt0JRmlAZK8sknd26cGn2hc2xhzveKiWZnXtHpaU5PX5FA3f3jBDBLMkHAJUm41URpvrZz1g0XySQrsQfEobu26FRN5HpsX/B7YlZWyDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11412

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: Saturday, October 5, 2024 11:51 AM
> Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Biju Das
> > Sent: Friday, October 4, 2024 2:48 PM
> > Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
> >
> > Hi Uwe,
> >
> > Thanks for the feedback.
> >
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > Sent: Friday, October 4, 2024 1:47 PM
> > > Subject: Re: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello Biju,
> > >
> > > On Fri, Oct 04, 2024 at 09:53:08AM +0000, Biju Das wrote:
> > > > On Wed, Sep 25, Uwe Kleine-K=F6nig wrote:
> > > > > On Thu, Aug 08, 2024 at 02:16:19PM +0100, Biju Das wrote:
> > > > > > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct
> > > > > > +pwm_device
> > > > > > +*pwm) {
> > > > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > > > +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > > > > +
> > > > > > +	mutex_lock(&rzg2l_gpt->lock);
> > > > > > +	rzg2l_gpt->user_count[ch]++;
> > > > > > +	mutex_unlock(&rzg2l_gpt->lock);
> > > > >
> > > > > Please consider using guard(mutex)(&rzg2l_gpt->lock);
> > > >
> > > > Agreed. expect rzg2l_gpt_apply() as it will cause deadlock as
> > > > rzg2l_gpt_enable acquires same lock.
> > >
> > > Note there is scoped_guard() if you don't want to hold the lock for
> > > the whole function but only for a block. Regarding rzg2l_gpt_apply()
> > > calling
> > > rzg2l_gpt_enable(): It might make sense to shift the semantic of
> > > rzg2l_gpt_enable() to expect the caller to hold the lock already.
> > > This way you won't release the lock just to allow a called function
> > > to retake it. This is usually also safer, consider someone manages to=
 grab the lock in between.
> >
> > OK, will remove the lock from rzg2l_gpt_enable().
> >
> > >
> > > > > > +	 * clearing the flag will avoid errors during unbind.
> > > > > > +	 */
> > > > > > +	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hw=
pwm])
> > > > > > +		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false=
;
> > > > >
> > > > > Hmm, not 100% sure, but I think if rzg2l_gpt_config() below fails=
, cleaning this flag is
> wrong.
> > > > >
> > > > > Does rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D=3D tr=
ue
> > > > > imply enabled =3D=3D true? If so, the if condition can be simplif=
ied
> > > > > to just the right hand side of the &&. Then even an
> > > > > unconditional assignment works, because
> > > > >
> > > > > 	rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
> > > > >
> > > > > is a nop if the flag is already false.
> > > >
> > > > I am planning to drop "bootloader_enabled_channels" based on your
> > > > comment in probe() which simplifies the driver.
> > >
> > > If by saying "drop" you mean that you remove
> > > bootloader_enabled_channels completely from the driver, that is the w=
rong conclusion.
> >
> > "bootloader_enabled_channels" is added mainly for avoiding PM
> > unbalance for bind() followed by Unbind(). By adding
> > devm_clock_enabled() to make clk_get_rate() well-defined, the clock wil=
l be always on and there is
> no need for PM run time calls.
> >
> > Am I miss anything here??
>=20
>=20
> Just to add,
>=20
> previously,
> a) For bootloader enabled channel case: Clock is ON till linux takes cont=
rol in .apply().
> b)For bootloader disabled case: Clock is OFF and turned on during enable(=
).
>=20
> Now, after introducing devm_clock_enabled():
> a) For bootloader enabled channel case: Clock is ON and will stay ON till=
 unbind/remove().
> b) For bootloader disabled case: Clock is on during probe and will stay O=
N till unbind/remove().

Do you think clock should be always on to make clk_get_rate() well-defined?=
?

In our system, we don't have OPP for peripherals, and no one can change the=
 clock rate of PWM IP.

Currently, I use PM_runtime calls to turn on the clk and get the clock rate=
 and turn the clk off again.

It is guaranteed in our system, there is no way clock rate can be changed f=
or PWM IP,
Next time when you turn the clock, still the rate is guaranteed to be same.

If you are OK, I can send next version with below changes. Please let me kn=
ow.

-	/*
-	 * Probe() sets bootloader_enabled_channels. In such case,
-	 * clearing the flag will avoid errors during unbind.
-	 */
-	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm])
-		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
-
 	if (!state->enabled) {
 		if (enabled) {
 			rzg2l_gpt_disable(rzg2l_gpt, pwm);
@@ -386,11 +372,18 @@ static int rzg2l_gpt_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 			return ret;
 	}
=20
-	mutex_lock(&rzg2l_gpt->lock);
+	guard(mutex)(&rzg2l_gpt->lock);
 	ret =3D rzg2l_gpt_config(chip, pwm, state);
-	mutex_unlock(&rzg2l_gpt->lock);
-	if (!ret && !enabled)
-		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
+	if (!ret) {
+		if (enabled)
+			/*
+			 * .probe() sets bootloader_enabled_channels. In such case,
+			 * clearing the flag will avoid errors during unbind.
+			 */
+			rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
+		else
+			rzg2l_gpt_enable(rzg2l_gpt, pwm);
+	}

Cheers,
Biju

