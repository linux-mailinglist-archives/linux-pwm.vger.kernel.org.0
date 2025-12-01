Return-Path: <linux-pwm+bounces-7743-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67962C96D63
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77EAC4E227C
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53594307AD9;
	Mon,  1 Dec 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PvQp0iEJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010056.outbound.protection.outlook.com [52.101.229.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E33307ACE;
	Mon,  1 Dec 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587397; cv=fail; b=IBi12QzizjQ8CS9gN9Tz32NhL+dCT64RGc/8h2HQyjeXynS3m7Xrc51KS5nls9aJiZOQy9fhC3wASooR3VU7V+h4zFfE6QY6sEW2SmhbN+cyGSrV7ZEak+P8iCN6eZub0nxu4fEnwUufcPfyZO81PALsqNuKPXV2UbTRmX4ZnUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587397; c=relaxed/simple;
	bh=WH7yVKFEoazISgTWDZMHAoJnWX39rm0IIVHtnxEgrZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYNxzRG6SP4O+sxMPYPDPJIcQ1zoV2bJiFfF+j3EW5BMlTwvQXDBmzF3wqcSutxpeHRancLRDCPog8M16g2/7o4WKShipdmhUEtSazIouO9l/4wCGHNGxWhnYMWaY3qxnBrcmtXV4qmqoAYUSly3F5en5j+bJ5f9vMJ7VRQH5/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PvQp0iEJ; arc=fail smtp.client-ip=52.101.229.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8Sy8sVtilwToiWf3uKQ2WPN4PJn15n0LP61cQSbKxASwG2a6jAdpyCPqGWKSXFWeaC1+vAhbv5XWCOw99daNjIptPrIKLORcdJv3SJt8Gz03MD1cF/me+9DttByAELBQvV/tSsU6CK3yLhX6t3UwOrxYjDJQHujB1U3jpgu5OcUYK2kx4nB0HkODI5D+aQOUd5Ob70F5vGx60DQ17bfg485DBcG/PW7lfkWWjMEfIZIM89Qk9wSCdlYYQs4u59eIZN/9GKuK1qE5V9Jmkt5X+uFeOWgVLesKd99HjSvdbQivEU6Ij5P1emiaO3hGG9uc2ajjoflDbKDGLjhsNKX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF5kL/TLTUc8ZFpNhr4IMVcK4P7E9x5SEYhR4xO1c+8=;
 b=bskBFinJ78jQcl+RmfanWUhbw0CVoGqmusJPqSTKCQnlZBA7n6ZDKlOVugBlwcr424dn/FW8sFXiqBC/jQB4BEpCGqUyKuxGvtrg979CzmVU1fA3mmhRVn0SHI/zrbX7RlyiSZZmgChogSyEcRT8Y6j9mz/YyeqMXKDX24n3UdjUgJzr6gUc6hxPQ48gI7Z96SBy3bgMHIhyMOoS9VB+OzXHVn3itrCtoZ1cLWH997FnwFsTZO1TP7Td+UOpvFQZDj/wKKaVwgCe4+6+HZ0HPI2L/ULrnj7yGEprqdsIU6oVuz8ANZB3oyEaNyafX9kRQdnI0vUXKhMfqFsrTZbByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF5kL/TLTUc8ZFpNhr4IMVcK4P7E9x5SEYhR4xO1c+8=;
 b=PvQp0iEJH+OJ2HOLh7Wj7ZZZYL2Tg71+FwjcIVWBmKQijW5z2sxniHBLykZ5Mldo72quE4OP+ybu8JqdFmRp5Ew34Ye/7cHaQWwt7GN3xyV335kL6/cM4aEqIF5a3vIyC66fiIU15sT4W3qR5/rCEjYJSpa4tr405nimY51bt+E=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6897.jpnprd01.prod.outlook.com (2603:1096:400:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 11:09:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 11:09:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Topic: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Index: AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAG46lA=
Date: Mon, 1 Dec 2025 11:09:50 +0000
Message-ID:
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
In-Reply-To: <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6897:EE_
x-ms-office365-filtering-correlation-id: 12dd096f-d745-4b62-3378-08de30ca25dd
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jCQ4LXTzArmt+eR+TybbCmrVBgQoUlkVUJM9o9zCfpRw00KeIZgAQ+sISr?=
 =?iso-8859-1?Q?pyKY2VEPUgfpbJ3WTCViSd7/zP7S9J3tYmLUDCuxBUvwDy00C9BYLA1n0j?=
 =?iso-8859-1?Q?3ALSdW6SUZ1zEndrR99br6qAzY8H+fAhpsHbLEtLI4Zy0CddpRVky5d2Ve?=
 =?iso-8859-1?Q?77lYWu0n9VEfJWT2nN6IqEslLgiRroo72f4EmVPzqmo2lRWqd8RIk6b+9/?=
 =?iso-8859-1?Q?6B4Iu+bH38zw9CntZaXor+FV51ZNz+r6CnYvJtqXcv9SPiI3ptCJYKfUNd?=
 =?iso-8859-1?Q?Ofe7xQnHSOu2QTnJdpkDnRfnvukH5DRDKS40a9ID4KcHrpOl0fH3bmekwB?=
 =?iso-8859-1?Q?+PAHACtV33J0nQ6fkFszKWCAd8Tv3RTW85/ti5SsmVtBFE0jmgHHmUIXeQ?=
 =?iso-8859-1?Q?MyyqFtdA2NmfjaSzS3Bjp+AtJYdUJ6UEKkQca2dyVBQY18Uh59bT0i5YHu?=
 =?iso-8859-1?Q?Kv06H3Ss2YyXA5V+5Hxnstp9SgKSUofqt8ZEDkAQAV+DE4faRK7aDlCVe/?=
 =?iso-8859-1?Q?XHkiHiFiPudr3N4islH0epsizsRx3qbKiaUkfTUTkVcqmQYQtoR899VmMF?=
 =?iso-8859-1?Q?6Xd286tKwWWAxW7zdDLLMaDwQZxdD+AvkSO3G0ryuFvOh39zZEN73OCeV8?=
 =?iso-8859-1?Q?Qe2qOpGh/PA5/qruVC0eAgPz5t/+UuUzDEzqDybLFmUCxo2aJSSp52y68K?=
 =?iso-8859-1?Q?qLWWLOC1ojeKAsygZdKiCwHLiq/pESa+6q/Rz7oDacy2v69b+FKeDZrJ6x?=
 =?iso-8859-1?Q?5RLUvb6ayJKOssMdc3eeqJWzp3Bo+hn3TgdIvOsuHtcHb5DfwyITG39M0c?=
 =?iso-8859-1?Q?ZjHmnrznfurICks0/9/TbrlHllHY+km4j9cH02ENga1o6RP8JBzA8gHtF3?=
 =?iso-8859-1?Q?FaUFsgGzXLnpNfTjUWOJlKIo7z7aCs8727JsGimqOvy9sPpA7MsVQk5h6d?=
 =?iso-8859-1?Q?aVm8bikdet81VQa5DlrbenKZ0pecyopkYHmoUUJ9lznURHyTcZem6Z7fXE?=
 =?iso-8859-1?Q?xwHwkyTQh/vxxY3Xmt3zrCYyBSJhe5wXLHNRv+s3m9tESPWc8pT46NErr1?=
 =?iso-8859-1?Q?ASQlhpMQ8T1Q7ciECfxnnJ3k6R/hT9yPkTxHcUrI6HzCBVe5EhxPC/GrH4?=
 =?iso-8859-1?Q?Pe+a8YNSg5xNBHrNpeiiEbBMBUar7QmuUj1nJiYnbUJ7Takb90I0zbQh/W?=
 =?iso-8859-1?Q?2ZSUaQWKk0keWcIXa2c5uOO6nI6fa53eKloD9vTnb3ykgpOgYUUu90Ql/m?=
 =?iso-8859-1?Q?MDYgYfmpxUMuuY1UwkD3vzK+DsbDKsXjhtjD5s2DcwUfrb2AAaq2gC0mZh?=
 =?iso-8859-1?Q?ngwy05cENQv+EOeWFHX7EP5tC9OkAEcu/lY+jsR+ZOwFxk2yZtT4031Hre?=
 =?iso-8859-1?Q?hzEDY79u1cANwKD4xJ3M6yy51M8LTFGE2sgfMCczebJXVTItX09hOMbaZk?=
 =?iso-8859-1?Q?WGhimS4lKjfD2curyTKDUzaaQzd1jk8B3HbNSebgaR11lGnlc8hteyPX8J?=
 =?iso-8859-1?Q?YXWU18J5G6Gb7V+JTYvD6RxE4GY5SGfv1CPzaMqQsOR4/azSPIvTFqSwpb?=
 =?iso-8859-1?Q?STc3erzgioQG4TCmxRF+TJgpIlJ3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gkvSD9QbSgNWSEYIjV9xYa1F1DkbLg741txLGorz4WUN2g0JExU1m2DUTD?=
 =?iso-8859-1?Q?B4bLbo+F/zbkLKJ3HB3FNZIuMTFN477IKjwkoEosn8UC75bxLhKryleKaC?=
 =?iso-8859-1?Q?Ka5YSlPx+kDVkoWtWEIeVfum2fH2qiFMvT1nrElZDEoxoCxdLNXikMHvD3?=
 =?iso-8859-1?Q?pErE2OHMgqNoIKvKQTS9VnY5/BbodtHruaApTJ2Io0Rdkm+fn/e9o6pBV1?=
 =?iso-8859-1?Q?2nJ1U1JJBTiKXPYdNEF7oD5LVkzKGFTjLmM6rhnjB5XhBhLdaurh3PJV+K?=
 =?iso-8859-1?Q?aXTJqsg5H9FZJXAYYDsytE6Iw/Peab3vOluqpzabd/rVXE9fwtru+h2olN?=
 =?iso-8859-1?Q?oS8K3kbBYhg9aS8GTUXQoPA1kiaxe2qziOahhB8APY1h7ZWcdBA7WTdj9j?=
 =?iso-8859-1?Q?F/iWBw8GXcM02nvKOqb9m0F1fMz1pxuQEIIXTNHYKOCMC7ji8KBCLssRe/?=
 =?iso-8859-1?Q?9SKRhK3bYERalLPDSuCQbtz83oNKQbwd3jDCujzJTEkZCmpaVr94AkNVQr?=
 =?iso-8859-1?Q?5ilsEZfnZshfDL0XGtkCeB+NaKT4uBVDJpLQxiv6iggHU0Yt9GUBMdl9sG?=
 =?iso-8859-1?Q?m1HS6fwkerSOPJgb48Re9WtiQSD5J83y141s5bCvTCmEphjtT8IjynkTTN?=
 =?iso-8859-1?Q?e2V+kmPcII+qwxQCrVIDltsf7XrnAJPGObLKLPiM/1UBsenapd8+jWoDG2?=
 =?iso-8859-1?Q?9zfbNANM5ROim+5WbfSklnFXOgJXERU2GePwwAjNulDMMR1e29JGB9HqD/?=
 =?iso-8859-1?Q?IN1FNVm4PFZkTHxeVAcbJAKrXBtf+JtlgG8UcZ/XfKY7oNflQLZf3AiPI0?=
 =?iso-8859-1?Q?kg7eqOXmNcRa2hJ+80HfIYmXbjuVelgV0aVspYlsVD6e6A6Ba5fYM27g77?=
 =?iso-8859-1?Q?57wudI+ISqauDwGYR+1HR+RjY9s7osH1pNQfj+qnjgMULrjaSqQW2BSM23?=
 =?iso-8859-1?Q?j6e5+lTZMOd3mVbuUS9VsHYCIe6Y3X85fxQjI8ZE5yKDPTZra+NELG6Zvz?=
 =?iso-8859-1?Q?0O/bUO8s0fDmqhIlxBG4uRSxHtovPWJaeJ/Yx0O4LeyqzCebt9xZCXCAUr?=
 =?iso-8859-1?Q?SK8lty4aCbvu6IHKfFbLNISDbDRVuW7nJH6pl0ofenyI5GyvB7qlV6LP2e?=
 =?iso-8859-1?Q?/bUF7Tu0CEok3+kBzJ0S8pr3Wc8kYHuJ6r9vaK4X340BDmg1ZmeaKsQR57?=
 =?iso-8859-1?Q?noF2TokDmFn53J5RaBN74OFcq+jDAtiRMj/rdIm7HhA0D5SyWyQli2X4DS?=
 =?iso-8859-1?Q?lBE57XzG36w+1HAwALMWRkuKpb4JFpQcYGOGCljyd8HulLWoDwysjyT727?=
 =?iso-8859-1?Q?z0lMaEWe3FRbNUXnQAaXVcs2Qli4Bdbas3XAX0pee85ZfDg9Mnl5SAPz+E?=
 =?iso-8859-1?Q?wEcUqJ4vq1ThjUVK7KkRDzhMjUu66gdEVvS3WsLrjnySLnUTkmAY9v7chl?=
 =?iso-8859-1?Q?GHy+3kEA8jDhqwoFXO3Oc29phNIdBIxONwWZW4KXBL/GXmOTMq4hQmhu09?=
 =?iso-8859-1?Q?Fd/zOoh7GDcIfcAq2YJs5aB0WcdDkMxe5Qa7+P38/LPg+zT3JfV0h52APL?=
 =?iso-8859-1?Q?1BXyWBNCyarrgmW6KX2my+vjQ5NODNV8wuALxCKTJJJUFsDqRkYB7hR5+g?=
 =?iso-8859-1?Q?cg/xjxOK9bUaKDyOpoRrjfn+B6uibSDoxzhpZO2YVtpkxbMfiax8t4Ig?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd096f-d745-4b62-3378-08de30ca25dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:09:50.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA+E7dNM4RG4R+gxwA9XpFv1zbNfCeRBk57AUVCjM73k9l7+UZoUL9KZiwG7Zkh5mtbGOvb0bPArFQI97+AiaKGPLu0H1qn0TDjsy5rrkqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6897

Hi All,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 30 November 2025 08:39
> Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> > +static int rzg2l_gpt_suspend(struct device *dev) {
> > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > +		if (!rzg2l_gpt->channel_enable_count[i])
> > +			continue;
> > +
> > +		rzg2l_gpt->hw_cache[i].gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR=
(i));
> > +		rzg2l_gpt->hw_cache[i].gtccr[0] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTCCR(i, 0));
> > +		rzg2l_gpt->hw_cache[i].gtccr[1] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTCCR(i, 1));
> > +		rzg2l_gpt->hw_cache[i].gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR=
(i));
> > +		rzg2l_gpt->hw_cache[i].gtior =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTI=
OR(i));
> > +	}
> > +
> > +	clk_disable_unprepare(rzg2l_gpt->clk);
> > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > +	reset_control_assert(rzg2l_gpt->rst_s);
> > +	reset_control_assert(rzg2l_gpt->rst);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_resume(struct device *dev) {
> > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rst);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rst_s);
> > +	if (ret)
> > +		goto fail_reset;
> > +
> > +	ret =3D clk_prepare_enable(rzg2l_gpt->bus_clk);
> > +	if (ret)
> > +		goto fail_reset_all;
> > +
> > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > +	if (ret)
> > +		goto fail_bus_clk;
> > +
> > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > +		if (!rzg2l_gpt->channel_enable_count[i])
> > +			continue;
> > +
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i].gtp=
r);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cache[i]=
.gtccr[0]);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cache[i]=
.gtccr[1]);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i].gtc=
r);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i].gt=
ior);
> > +	}
> > +
> > +	return 0;
> > +fail_bus_clk:
> > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > +fail_reset_all:
> > +	reset_control_assert(rzg2l_gpt->rst_s);
> > +fail_reset:
> > +	reset_control_assert(rzg2l_gpt->rst);
> > +	return ret;
>=20
> I wonder what happens if these calls in the error path fail. I think the =
correct way would be to track
> the actual state to handle the state on the next invokation for .resume()=
 properly. But note that
> suspend/resume is a somewhat blind spot for me, so I'm unsure here. (And =
I'm aware that most resume
> callbacks don't cope cleanly here.)

In str case, there is no power on the system during suspend and exit is, So=
C reset followed by
restoring registers from DDR. So, it does not matter for the suspend path.

In the resume case, If the calls to error path fail, then device won't work=
.

>=20
> I added linux-pm to Cc:, maybe someone can speak up about the expectation=
s here?

Adding logs here to provide some input

root@smarc-rzg3e:/# /pwm-pm-test.sh

Suspend to Idle case: There is always power during suspend/resume

### Executing suspend to Idle ##[ 2234.873041] PM: suspend entry (s2idle)
#
[ 2234.880814] Filesystems sync: 0.002 seconds
[ 2234.886280] Freezing user space processes
[ 2234.890772] Freezing user space processes completed (elapsed 0.004 secon=
ds)
[ 2234.898042] OOM killer disabled.
[ 2234.901418] Freezing remaining freezable tasks
[ 2234.987346] Freezing remaining freezable tasks completed (elapsed 0.081 =
seconds)
[ 2234.994928] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[ 2235.063373] renesas-gbeth 15c30000.ethernet end0: Link is Down
[ 2241.003506] dwmac4: Master AXI performs any burst length
[ 2241.003589] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[ 2241.003686] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[ 2241.003837] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[ 2241.012644] dwmac4: Master AXI performs any burst length
[ 2241.012719] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[ 2241.012804] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[ 2241.012948] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[ 2241.060964] usb usb1: root hub lost power or was reset
[ 2241.061005] usb usb2: root hub lost power or was reset
[ 2241.245594] OOM killer enabled.
[ 2241.248732] Restarting tasks: Starting
[ 2241.253795] Restarting tasks: Done
[ 2241.261232] random: crng reseeded on system resumption
[ 2241.266589] PM: suspend exit
[ 2243.565376] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Ful=
l - flow control rx/tx


STR case: There is no power during suspend and during resume the PWM is act=
ive and enabled.

### Executing STR ###
[ 2249.336476] PM: suspend entry (deep)
[ 2249.341533] Filesystems sync: 0.000 seconds
[ 2249.346768] Freezing user space processes
[ 2249.350597] Freezing user space processes completed (elapsed 0.003 secon=
ds)
[ 2249.358292] OOM killer disabled.
[ 2249.361536] Freezing remaining freezable tasks
[ 2249.367334] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[ 2249.374754] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-329-gb288fa6dd
NOTICE:  BL2: Built : 12:27:28, Nov 28 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[ 2249.443353] renesas-gbeth 15c30000.ethernet end0: Link is Down
[ 2249.457488] Disabling non-boot CPUs ...
[ 2249.462415] psci: CPU3 killed (polled 0 ms)
[ 2249.469054] psci: CPU2 killed (polled 0 ms)
[ 2249.475079] psci: CPU1 killed (polled 0 ms)
[ 2249.476779] Enabling non-boot CPUs ...
[ 2249.476986] Detected VIPT I-cache on CPU1
[ 2249.477029] GICv3: CPU1: found redistributor 100 region 0:0x000000001496=
0000
[ 2249.477068] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[ 2249.477934] CPU1 is up
[ 2249.478033] Detected VIPT I-cache on CPU2
[ 2249.478054] GICv3: CPU2: found redistributor 200 region 0:0x000000001498=
0000
[ 2249.478075] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[ 2249.478603] CPU2 is up
[ 2249.478700] Detected VIPT I-cache on CPU3
[ 2249.478723] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a=
0000
[ 2249.478743] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[ 2249.479398] CPU3 is up
[ 2249.497101] dwmac4: Master AXI performs any burst length
[ 2249.497138] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[ 2249.497180] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[ 2249.497248] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[ 2249.514222] dwmac4: Master AXI performs any burst length
[ 2249.514248] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[ 2249.514278] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[ 2249.514339] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[ 2249.561172] usb usb1: root hub lost power or was reset
[ 2249.561180] usb usb2: root hub lost power or was reset
[ 2249.824165] OOM killer enabled.
[ 2249.827341] Restarting tasks: Starting
[ 2249.831552] Restarting tasks: Done
[ 2249.835021] random: crng reseeded on system resumption
[ 2249.840269] PM: suspend exit

[ 2252.066180] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Ful=
l - flow control rx/tx
root@smarc-rzg3e:/#


Cheers,
Biju

