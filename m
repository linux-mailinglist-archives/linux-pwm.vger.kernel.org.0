Return-Path: <linux-pwm+bounces-7294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E88B52D9C
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6B91C8672B
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C82580E4;
	Thu, 11 Sep 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lp1Hwr9U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2056.outbound.protection.outlook.com [40.107.113.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217ED2206A9;
	Thu, 11 Sep 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584006; cv=fail; b=ojm0BJcM8rE+fQNZ90wP0Mu+CK54oXGr5YmeNrAupQT3ar8OAT9CvFt1ZuhfYL9jUZD63bH26SZoZn6M926taOy/U/IjG/LUtiNgv3lP6bxNQvRvzuA+cGkSdSe1SIvvX0DionrVPWiIV2PFgtzFnn/mQ2oqvGTnadfWAF1a7w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584006; c=relaxed/simple;
	bh=JCKO/lgsDqH7GIawreS6f7G0X46ufgtIoIjnFu+SwPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEmiw3Sh+5kWXbsTFdX9yhkCDWYYV0cpTYmXpsfzvqOcmXxPdys/vCKk6UoOTmj3rfhDdwe0CVT3jOVnc2bo0AuxwdO1wCN/SUIcmcyOURGgXPrayy8XKgg0OjTZ0jiR5KCbvtZVYCh8vztOcLqIv0VLygdEXfD3e5qyvcUZlCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lp1Hwr9U; arc=fail smtp.client-ip=40.107.113.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqoPnOnZLUjzrwhTqndYgoNYeG+/yjKjbtgtafj7ZPbJqxqJ4e0PGEPlXlI6xtWs2TCpk1kKcq9awR5Ph57llt65aKQgOhvryx4QIpvzFndmuL//hAuv5nbcIv/U7qEnHcIOn/GXGGJTr1oYEH4t7UR+AOy0HeKWSd+lHhcAam3hfTB4GM202RxO3UJaDkUaL4/xRx7H86ElPUNHpgnuJy/5MA70Ohf0GnIplQGIhNYZHkjHosPHFvInTT5eKgPfcIkH+AXD6XmCPqNAMhcKQZm66ZvuGBZqH+2TRupHHHYngDHaqSfWPUG6GK4b2X4aCgfW6Vtceyp1vAthQgROUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsIlv9SVxmRAj8aweaSvTMJyZgWS6v9qcKNtT6we1l8=;
 b=oXaN4AWnOyOUyGcGM/MqakXdMx7HU4+bGTyGEI+xfhmt0d3nMLxdPRN628t7knZqv/cFdMl6Z5Bg/Yw4O9EVb+Y7jANvY2RPGaSWhSRdJo3Bu4X63SIMKni1Ipj7AusYume1eDX05+TQatUoflA25dcoBdxGiqOVq4Dhid5vBqpxZMht078nmSRGglRXKho1TXjF4pM32PO/nhznjZustPewslcy/b3MuvhEz8gRIfuNcwaZow+zuO6uBBJLh4RtLlHyKcbti/7N0pE2oYoLAmLzchbDeKy32wOVSWfCCTpnzeo99pOH0k1Gamb7rNRJkjxzCQkEjFB+w6HqjWddVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsIlv9SVxmRAj8aweaSvTMJyZgWS6v9qcKNtT6we1l8=;
 b=lp1Hwr9UhCN1B18POsxG679IFOGSLB4z9wifE8uCQq8el5YOdISKIg+ly3q9BhXk0dbmJmZKu0e1d4+WaOweJ8L9r7kJy+QFZEQJXly1Xyci13rVs7zoZes7jkTorMqwXjqMViLeYDlHueVEPMZmf6FzvaPhZCk+J/d/r/nZwDA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9627.jpnprd01.prod.outlook.com (2603:1096:400:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 09:46:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 09:46:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Topic: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Index: AQHcDRGiT0WyQNvV8UKYMNvCoc6mn7SLIBkAgALGPlA=
Date: Thu, 11 Sep 2025 09:46:38 +0000
Message-ID:
 <TY3PR01MB1134600B9DF5AA79AE121CD148609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250814115022.73732-1-biju.das.jz@bp.renesas.com>
 <jb6vcdv3553kbvuzuxdmx7tyxcpmnkaqszks3n4apmt43an6d2@mr4lyezd5a7s>
In-Reply-To: <jb6vcdv3553kbvuzuxdmx7tyxcpmnkaqszks3n4apmt43an6d2@mr4lyezd5a7s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9627:EE_
x-ms-office365-filtering-correlation-id: 769289d2-8b88-4c5b-34f2-08ddf1181a92
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CBVP3I9g19dtWj8CgQMOQoyecPyW5r5NE3AxRvDAvUKtQQChRiMYKPeEbL?=
 =?iso-8859-1?Q?3pw5c9T1SRmAEt/3SquHqKdH1ASsnPqLdm7/oFxeqrL0p8aMyCM1S7D2D1?=
 =?iso-8859-1?Q?4zsi24uAgrb+pg/tjbhT6+jKmGN1/WApTLH9IarmYnZtgZpYaUISB4xmpQ?=
 =?iso-8859-1?Q?5y/Nt27p615+cCh5Ut1t2yFwp56P61HmjW4Im6jNVZ9hDLRPJopfn5lFvR?=
 =?iso-8859-1?Q?PeFM/GWW/CBmRXeJwlJSeNzrpzh/lxzzYvtR04oedjv8e6nVlFc6o6YKSp?=
 =?iso-8859-1?Q?rR9qYgc7/lSR1EuORadsyhT6cpmS8cHIiROaRtU+HBjSnTK9AKcMulpzhE?=
 =?iso-8859-1?Q?IHUH1rHKtZeKjcI6I2HXYzzieUtRYCyX/Ykcf2AidVHV7OMPozKLz0BrWj?=
 =?iso-8859-1?Q?IbMWG52Bg9t3TwtfC5OD6I48NFyxZGpwYDS8T6w1nlFB+v1xLtzUljDo0R?=
 =?iso-8859-1?Q?qasPQkbIwne0jjaUrDXQO6jTQsNsEkg3sThq5n++PJolvmHvMldc2q2AI4?=
 =?iso-8859-1?Q?9j9HwJHoKKoUVToie3Q3Fbv1tG7DTXVOCvisDCxTiCPHpRM2bXSspGGwt/?=
 =?iso-8859-1?Q?SpY75htCPvTDbfZp0xyc4i12vIQElTX9u+8Edr4K+95tFtrNeWJl2z6E6J?=
 =?iso-8859-1?Q?RTtaw/aPIHyGiGa5KYrsPt74CLAVOU0JnG6TQEt0RdZ5Mf4CfeUlsE8vUV?=
 =?iso-8859-1?Q?1zRkeZR6mBuoBYaPyGSrRbhJ25hBnmd60rvpS8VwYSwmsz3KZeDkW0vBE1?=
 =?iso-8859-1?Q?UZwNOEUQxZ72VfwakPtt8TIyf6H+elqYcQ3y/AaaFniyA6slvZvb6l5B+7?=
 =?iso-8859-1?Q?XaQd5LnqJ5sKRCTnuqtcuG3O/Vl62cvQ1LB2lSO+Mf3YU01NC2FIDow5vn?=
 =?iso-8859-1?Q?Hno/TwjXfivKcilk+08luz47nanoVR4x+pQOGS+ACjGev78T6L0AEk0PFT?=
 =?iso-8859-1?Q?DrPpiaYJAt59Mmj7oExaRhqr1+69Qzkk9oBBVWRoHRXsGZmg8yeDtfu1+W?=
 =?iso-8859-1?Q?AaJY5lwZwwhm7K20h8HLQk4CwVJIQizqVAvT/puhdgVvLSsdwEBTrl889H?=
 =?iso-8859-1?Q?801oeDPoXFyTcxGXBhMCkYl4F/3O31cVUh/akAYsqQebf5w8r2QwzauG5V?=
 =?iso-8859-1?Q?Vmru6kl2E6t/iRJhRF0JgKFsQy+cAE46eMAC8sY5ppF87GUHmwzVus4FDH?=
 =?iso-8859-1?Q?isP4tfBszB4e54e2SlscdRqlAk2nEG810D2+DSyEjFABQKP6DUoCLmY48K?=
 =?iso-8859-1?Q?LyiAL1zggbBruqUXWsITGbszfxL+kPyxJHuo8+6VbWSw2epLYwHgTewmx2?=
 =?iso-8859-1?Q?oZCRv3lP6GeRQwcvrJLihC+g0bu8mZ2bjgCBrEFICb9rswnZ151ei0QMkK?=
 =?iso-8859-1?Q?IbS5e41iQ7CIFn5Ed5CKzlJMUiiO4iicGKSwZrCAf/tyPjanw+eJq4jogR?=
 =?iso-8859-1?Q?3nkC+Hu5g+heIG3Us63WmOlhU5agjDpTUFPIO59mUWyHv2moUqV2U7K98B?=
 =?iso-8859-1?Q?KR+i4paOfMpKqLZ5feJvs/hM2p+qOosME8FCIX+uSxHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ROqIIyjb4+h7Qsny7xnYImZpBCfAjYMzuCOAwdQvl0CR+S+sUcBoUavmTJ?=
 =?iso-8859-1?Q?Ak6lkQ5gekz3MRwzAzWLmciguC8zI8KDGrMEpRPVnA8AD5TBvBu2JkmHZe?=
 =?iso-8859-1?Q?s1+v7RluH1OTrasb50fm1PfsbFz78r2wiwrlzAq1NrjMCuiqA1aGAHGCOu?=
 =?iso-8859-1?Q?gwf9oVVEXgzkNN4B5L2dFH6EvV3IBTOwYj6rvkczDxRZINhZZ/W1R0TuXj?=
 =?iso-8859-1?Q?HBlInsZY3rKK03w5DtF6clwZtW9H+0C0WsSsjt/agmIfe4VKVm2+b9uw6b?=
 =?iso-8859-1?Q?Ao+gUP09sN0L1lAR5if5Ib4RO6f1nZbR7qNNy5pm1xEyNOt7eeUR5l9be7?=
 =?iso-8859-1?Q?c3cauA9UVYN/6a1suyWFEhYWa/aI1p3Puipw3xdhdg1R30S+a5PltdIB5I?=
 =?iso-8859-1?Q?4IDo/bZ0WVoJfFoNEj1d+EfDVtOf+nVUgm57mOOnYgu89djhZyY8qdxiJN?=
 =?iso-8859-1?Q?7d/9gd+sCgjY3a9B7RGCX2BufVPa/8bZlqz9AqZkjLx96KCHumGLgoZCNL?=
 =?iso-8859-1?Q?LmOC/cPrxKFRNXuBzFlHKP56b2co0I1J1VPbNg5LYXHHyVj1t0Ep7POG32?=
 =?iso-8859-1?Q?9L9FuI4vYgSKqSaa34HzaFtfLhlPM7QyC6GpeNURUjMVoaL+fzerRFhcfS?=
 =?iso-8859-1?Q?2aSCBwINC1CfA0+GoDl2egRJA1SMF2mQR+Kia1H/y8DIoJlceX0A8ysuL0?=
 =?iso-8859-1?Q?BUzmSHD3gDhhxUbd9hv6OiZJcVCm3m5rlLONw9V5wmzFYppiMulVfUAZNA?=
 =?iso-8859-1?Q?lrp+3eimAdgKUxOTzy7vCsbNO+nhLL/CPml6TDSIpPh1egBNOEYUKxdHBk?=
 =?iso-8859-1?Q?Hqh9ESw2rcYvRJjxJufYLIZbYWmOXqhksDBQDsjdYD+BXUz3bbExrILkph?=
 =?iso-8859-1?Q?H97+N2JqbSlIgOv648THRWPHxUqGf5vaU+729SO0LxBktO4zfkDlt8bIN1?=
 =?iso-8859-1?Q?La5w57AFd8VvgdsGrwY6Xc0tUyLdQQ7YAdAR2BAEjDi+npzevQS/ZhZjb8?=
 =?iso-8859-1?Q?qIuTkSrjfhFMANw0NoO3cHTh4a+69YHhhgVygTKoQPqyWd+KIo+K5QqaUy?=
 =?iso-8859-1?Q?nfc0wcafgpEOZ4DUaVPuVPBWF4TZOo8jCS2i9kCVBm2A/pLce1STR2nOuS?=
 =?iso-8859-1?Q?EMxMasV6Xx51/3YILWmR/sM5sCOT9eok+5/b0MWK5ZyuRAYKiVR6mmZBcl?=
 =?iso-8859-1?Q?YKh2dmagx0bHffYiT/uC6Grq2MN5dYTUEmgW7fXiWi9Tnd62sKs+IreR75?=
 =?iso-8859-1?Q?kvLbda+ZM3F4mVIhLvn+D24d7I+9m7Ey+yo5RsoTjKLxgNe1OO4yKynnQX?=
 =?iso-8859-1?Q?Kavi8hdyn2PntpjB2uapw8MGRcSs3lIG0OB1kuUFZxj/wdIp1I3zGSrLVv?=
 =?iso-8859-1?Q?f6AJKX6czCvXfELa4xRiuNNicaghswK7OmOfNZ9hu+GRKCA4O6uUR7F9VP?=
 =?iso-8859-1?Q?3RqpSGD8gqietPsxuCD/gDKvsu3Ha4rqu3zQdYTh64NEG/XzzEQXhTUqQE?=
 =?iso-8859-1?Q?YwybkqJpKdvLyEEAPZToV09KPYMWyZe8qbrIVdFIPVzRND1ir0iqrQbZeu?=
 =?iso-8859-1?Q?UwmeIJAk3S/d6VWbq8jGV7nGPPL7AD9GW8FieTBaGU2+QJwLweTqasExbP?=
 =?iso-8859-1?Q?IFEav7HLmxboQTcv7G2R/fdH3xIqvY6bu5NzB+LctC8FRDnwASvbiDIg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 769289d2-8b88-4c5b-34f2-08ddf1181a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 09:46:38.3643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHdOWhBDyI0p6SLUtpM+8alMps0Fxjp1iG8AjaMbVW1PRrngHzbtsxXsLE/7xwNqeU8bnPXcIIQUfZxwMBXmAgxx+va8JkPSyLTF0Yg9CSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9627

Hi Uwe Kleine-K=F6nig,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 09 September 2025 16:19
> Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform ca=
llbacks
>=20
> Hello Biju,
>=20
> On Thu, Aug 14, 2025 at 12:50:20PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Convert the rzg2l-gpt driver to use the new callbacks for hardware
> > programming.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Dropped modifing hardware from .round_waveform_tohw() callback.
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 175
> > +++++++++++++++++++++---------------
> >  1 file changed, 102 insertions(+), 73 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 360c8bf3b190..f0a8531457ca 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -86,6 +86,13 @@ struct rzg2l_gpt_chip {
> >  	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
> >  };
> >
> > +/* This represents a hardware configuration for one channel */ struct
> > +rzg2l_gpt_waveform {
> > +	u32 gtpr;
> > +	u32 gtccr;
> > +	u8 prescale;
> > +};
> > +
> >  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > pwm_chip *chip)  {
> >  	return pwmchip_get_drvdata(chip);
> > @@ -190,8 +197,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chi=
p *rzg2l_gpt,
> >  	/* Stop count, Output low on GTIOCx pin when counting stops */
> >  	rzg2l_gpt->channel_enable_count[ch]--;
> >
> > -	if (!rzg2l_gpt->channel_enable_count[ch])
> > +	if (!rzg2l_gpt->channel_enable_count[ch]) {
> >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +		rzg2l_gpt->period_ticks[ch] =3D 0;
> > +	}
>=20
> I wonder if this is a fix that is orthogonal to the waveform conversion.
> Shouldn't that be a separate commit?

OK, I will send this fix as a separate commit.

>=20
> >  	/* Disable pin output */
> >  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch),
> > RZG2L_GTIOR_OxE(sub_ch), 0); @@ -215,54 +224,37 @@ static u64
> rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> >  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);  }
> >
> > -static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > -			       struct pwm_state *state)
> > -{
> > -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > -
> > -	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> > -	if (state->enabled) {
> > -		u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > -		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > -		u8 prescale;
> > -		u32 val;
> > -
> > -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> > -		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > -
> > -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> > -		state->period =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val,=
 prescale);
> > -
> > -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> > -		state->duty_cycle =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, =
val, prescale);
> > -		if (state->duty_cycle > state->period)
> > -			state->duty_cycle =3D state->period;
> > -	}
> > -
> > -	state->polarity =3D PWM_POLARITY_NORMAL;
> > -
> > -	return 0;
> > -}
> > -
> >  static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > prescale)  {
> >  	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * =
prescale)),
> >  		     U32_MAX);
> >  }
> >
> > -/* Caller holds the lock while calling rzg2l_gpt_config() */ -static
> > int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > -			    const struct pwm_state *state)
> > +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const struct pwm_waveform *wf,
> > +					 void *_wfhw)
> > +
> >  {
> >  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> >  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> >  	u64 period_ticks, duty_ticks;
> >  	unsigned long pv, dc;
> > -	u8 prescale;
> > +
> > +	guard(mutex)(&rzg2l_gpt->lock);
> > +	if (wf->period_length_ns =3D=3D 0) {
> > +		*wfhw =3D (struct rzg2l_gpt_waveform){
> > +			.gtpr =3D 0,
> > +			.gtccr =3D 0,
> > +			.prescale =3D 0,
> > +		};
> > +
> > +		return 0;
> > +	}
> >
> >  	/* Limit period/duty cycle to max value supported by the HW */
> > -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> > +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns,
> > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> >  	if (period_ticks > RZG2L_MAX_TICKS)
> >  		period_ticks =3D RZG2L_MAX_TICKS;
> >  	/*
>=20
> The code that follows here needs adaption. Other than .apply(),
> .round_waveform_tohw() is supposed to not fail if the requested period is=
 too small but use the
> smallest possible value then (and return 1).


You mean something like below

        if (rzg2l_gpt->channel_request_count[ch] > 1) {
                if (period_ticks < rzg2l_gpt->period_ticks[ch])
-                       return -EBUSY;
+                       is_small_second_period =3D true;
                else
                        period_ticks =3D rzg2l_gpt->period_ticks[ch];
        }
@@ -272,6 +276,9 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chi=
p *chip,
        wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_t=
icks);
        pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
        wfhw->gtpr =3D pv;
+       if (is_small_second_period)
+               return 1;


>=20
> > @@ -277,13 +269,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >  	}
> >
> > -	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > -
> > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_tic=
ks);
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> > +	wfhw->gtpr =3D pv;
> > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns,
> > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> >  	if (duty_ticks > period_ticks)
> >  		duty_ticks =3D period_ticks;
> > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> > +	wfhw->gtccr =3D dc;
> >
> >  	/*
> >  	 * GPT counter is shared by multiple channels, we cache the period
> > ticks @@ -292,6 +285,58 @@ static int rzg2l_gpt_config(struct pwm_chip =
*chip, struct pwm_device *pwm,
> >  	 */
> >  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> >
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_round_waveform_fromhw(struct pwm_chip *chip,
> > +					   struct pwm_device *pwm,
> > +					   const void *_wfhw,
> > +					   struct pwm_waveform *wf)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > +
> > +	wf->period_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt=
, wfhw->gtpr,
> > +								  wfhw->prescale);
> > +	wf->duty_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, =
wfhw->gtccr,
> > +								wfhw->prescale);
> > +	wf->duty_offset_ns =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
> > +				   struct pwm_device *pwm,
> > +				   void *_wfhw)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > +	u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 gtcr;
> > +
>=20
> Why does rzg2l_gpt_write_waveform() grab the lock but
> rzg2l_gpt_read_waveform() doesn't?

OK will add lock here as well.

>=20
> > +	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
> > +		gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> > +		wfhw->prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
> > +		wfhw->gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> > +		wfhw->gtccr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> > +		if (wfhw->gtccr > wfhw->gtpr)
> > +			wfhw->gtccr =3D wfhw->gtpr;
> > +	}
>=20
> If rzg2l_gpt_is_ch_enabled() returns false wfhw must still be initialized=
, I guess using:
>=20
> 	*wfhw =3D (struct rzg2l_gpt_waveform) { };

OK.

>=20
> Minor optimization: rzg2l_gpt_is_ch_enabled() reads RZG2L_GTCR(ch) alread=
y, would be nice to only do it
> once.

OK will update function something like below

-static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 h=
wpwm)
+static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 h=
wpwm, u32 *gtcr)
 {
        u8 ch =3D RZG2L_GET_CH(hwpwm);
        u32 val;
@@ -164,6 +164,9 @@ static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_ch=
ip *rzg2l_gpt, u8 hwpwm)
        if (!(val & RZG2L_GTCR_CST))
                return false;
=20
+       if (gtcr)
+               *gtcr =3D val;



>=20
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm,
> > +				    const void *_wfhw)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +
> > +	guard(mutex)(&rzg2l_gpt->lock);
> >  	/*
> >  	 * Counter must be stopped before modifying mode, prescaler, timer
> >  	 * counter and buffer enable registers. These registers are shared
> > @@ -310,14 +355,14 @@ static int rzg2l_gpt_config(struct pwm_chip
> > *chip, struct pwm_device *pwm,
> >
> >  		/* Select count clock */
> >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> > -				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
> >
> >  		/* Set period */
> > -		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
> >  	}
> >
> >  	/* Set duty cycle */
> > -	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
> >
> >  	if (rzg2l_gpt->channel_enable_count[ch] <=3D 1) {
> >  		/* Set initial value for counter */ @@ -326,44 +371,28 @@ static
> > int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		/* Set no buffer operation */
> >  		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
> >
> > -		/* Restart the counter after updating the registers */
> > -		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> > -				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> > -	}
> > -
> > -	return 0;
> > -}
>=20
> .write_waveform() must make sure to not disturb the other channel. So thi=
s is the place where you need
> to check if the other channel relies on the current value of global perio=
d (and fail with an error if
> yes and the period value to write is different).

OK, will return error like below, for the second channel

+       } else {
+               if (wfhw->gtpr) {
+                       gptr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
+                       if  (wfhw->gtpr <  gptr)
+                               return -EBUSY;
+               }
        }


Cheers,
Biju

