Return-Path: <linux-pwm+bounces-2650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1191E8D8
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 21:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4B41C21189
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1C16F8F3;
	Mon,  1 Jul 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o03VvVZX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0B16CD15
	for <linux-pwm@vger.kernel.org>; Mon,  1 Jul 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863325; cv=fail; b=lalgPLSw4/EtoQBxo62qBq8tQ7sDUCPX4c7dZ/Ct8sY2SHKg3JeXrS274u3/wYDMzkH69hkjiQ1sgzznGuai8V9QmfjdXQDT85I6jYn1J6VwlyiM3Te+gtJFHQyb/MAo7fw8bXcywft99f9TpMrn4XKo1r8i/nNZ/XG0SrUZEWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863325; c=relaxed/simple;
	bh=939I7Uxv/jL+ZHWjXpu9R4rFeMAalEafWJMjBUeauL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E8OQtGelSvA8qQ3T73M7SjSDJT/jUKysw04T/WhcUqeaDkQfLXSEebXy0WYd5oCCc66F70neA6K8KANkV9HWJ3HCTUXHKNwoU4bLhUjemUcrSi/e33MpUTjqN21uyRgD4nC4jL/TngkRA11h5ZKmedpncHtfAI26Zsyohnvcnvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o03VvVZX; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfiTjFLsudVsoaJiNTlPIo7vjQ53x22SQdfdNHJxc/uVXkuVf5GopdH3QWbfsgwrjLBwDtJoyqCgoVD028a6MyaPh6v3nFvHFy8jeUa6n0ODDg+gZm7vfRhYMdTmjOWMIT8vBqk8g7UPcLGKUH2HOpDdV9c+Xy8U5SpyFWavhTOonI/CFEXwOZxv5lNCvFVXI3UQoCWnh9HyhQbUm5tleNXcdHtHb649VFXAaNmqGuRLWwCKt7j591mmig5AkY4yxru/V97nAgbdH9lQqjO2tGLxsdFYKROwxDoyNLKWk+j9zy7ZjlHul+xVL05P824WyFQK37xLSM2w5twPmACs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/97DadMTQfM1bW9HungpZ0/l6OlEAThfsvHLKinSVDM=;
 b=RkOjR7rx2pTeEEkv6sGNnRPR71CJ7NlFSws7ioNSo/6J/qe5Ui0yHXM3zk8jLwDIlqqgTBsRSWWtW/FhFMjS1p1VAQfZQ9Q8GtIDdhQtOf4jthUQ+I+pgoztuyA5EQL7pAiz3KwaRGU+nn/malxtzRJI29jhqDOE6dsyE4xjc1SwRwU4PbU1YvYbn4dEXq60Hp5eUHKOCnM6nXAN31H7lTWqqTHfPTONwYeMf9axJTfkknz+K0xEluk3cgZzYA9iRGhy6JHeK11ZJIkkVQBkx01PvVZH2aaxZnmjuyt2XYZZmbux1Z6/crq+bn1nFXf4rWW1aEh+M3+smKOVUPui2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/97DadMTQfM1bW9HungpZ0/l6OlEAThfsvHLKinSVDM=;
 b=o03VvVZXVcTRK/GQrEpPGGVZFnKo/Wmyg9T7F9FNm2HhDdTBGSyFf3fYYtU671l72vp8gj4QgIDVsvKomOISU2VXWyXLoUWPt35zExrR0bJvxOaeK2g0Lr3TflrL2a6fMWsu/9Dl9UNyxpkiKYp9Aj6uoFhcSPn5+UiRmG5OPFQ=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 19:48:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 19:48:40 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Thread-Topic: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Thread-Index: AQHapjoZMQpjrTjUq0W2pX8yHVRnNbHHxyhwgBrK69A=
Date: Mon, 1 Jul 2024 19:48:40 +0000
Message-ID:
 <PAXPR04MB918542DE08381AB7C84FE87C89D32@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240514200534.73847-1-shenwei.wang@nxp.com>
 <PAXPR04MB9185BC1C3E3FABA2BC3C0B1F89C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185BC1C3E3FABA2BC3C0B1F89C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8729:EE_
x-ms-office365-filtering-correlation-id: 8ed61f30-0039-4882-3217-08dc9a06ce6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?k1Y5tIFDgbZyA9ad3wByOXpGCEg77vYSclXjFd6EIuNCnwmMpvLFtQxY1P?=
 =?iso-8859-1?Q?ffBgDTHf9jTZQEEpcBrxP4CcUCqZTorAWE11eP/upz5S0QQ9IfysvUk2c+?=
 =?iso-8859-1?Q?9hcyCy+yoSv6KZswv32JECk+ctA/nXxu2VUkX2Ky08BF/CBNYNdkN0Pwtf?=
 =?iso-8859-1?Q?cO24cKdm7FS6mA7JnTRbEfevieDppUJUBG87/11VumH/HFVfDVDHcbElT2?=
 =?iso-8859-1?Q?4QmiJyNRPBD18WXdGp1+braO1zjAfuQKQOkNn7huXKvmq6wqUmgmuomBUz?=
 =?iso-8859-1?Q?PbE+RhXAwlVZYHpmhPxobeJXgW3cEFt5Gg/sb4MieqBzIJE5jYByDSfi2u?=
 =?iso-8859-1?Q?Py+ZyNSXVXlL9P9RIPcoM9/0Yk3ntqP5r2Y/0A5mxL2CRM605CXRh+4JGC?=
 =?iso-8859-1?Q?dLhIqYxZQpIfvRcnoTs+COHX6SI3MqhjrTU/NSlD1GlJMBGfYuqdIQoh+R?=
 =?iso-8859-1?Q?DeQBA1yLl9r8a6TVyvuF+2oxEjxqKDK2VZob2NS+N7Qrg8RaBsYpQM0qQV?=
 =?iso-8859-1?Q?/o1lkJBYifmOoNfZUxxh6irZ794Mhg9TlGpFBgr8tgD41VMQiWARO9IGkz?=
 =?iso-8859-1?Q?xmeWsgDGDxEI95lb4pfcjgTiJr7Rpk4ionecyDDF1zJOq0BeO+fpuqufRA?=
 =?iso-8859-1?Q?xjgpiqRGtB4t0rmkgVMOeourWEs95fYdfNMlhr+fWh/tHoW0HL4WOv2ERY?=
 =?iso-8859-1?Q?L2EBxsNhdmo2FLCiZAT7HnS12+JFewUr4HEd36RwTkKuOHH1eCLB7RnJ/f?=
 =?iso-8859-1?Q?IUZvA7Wh6ZoORzYm/FJBYHb5406kHMP2QFclNuEDHU2KkxPXXFcyysYhGU?=
 =?iso-8859-1?Q?0+mopZ1mJV8MDF11jifZxIhGKjxOfS5gLTdKa+VsvIfJBMpJGgb3I+EYWC?=
 =?iso-8859-1?Q?xaU6JKG5MooLdrJJBfH14if72riVyboTJ4AvOXzyvE4ujMPYbmCZWdquBY?=
 =?iso-8859-1?Q?aJnq/3SIQ6Jd4S/LVqGiwpKbaxqFvzVx0xYVLqdg6WYWrq2OOh/VOv3lXR?=
 =?iso-8859-1?Q?JBhQHH1R2crwBvUI4RX7wCN2ydA2kiYW1sDqPqjzoAui/KY3eOffSD7l/j?=
 =?iso-8859-1?Q?Ptp7lN+kvdnYDmF1c6ugj8rPminxQNFneiXSM3oVYRJGCrfO8XwFtHXMAq?=
 =?iso-8859-1?Q?5jjYUzaE2ve4/tbWPskBMXNC5M909dS5PmI67qQDUzYXDhCpWzd8/lmsJg?=
 =?iso-8859-1?Q?tENBb7F7NyUQOCsptLa9unTKeFNGUUAtuG6jwPuC3jR+dlaIkduku5p25x?=
 =?iso-8859-1?Q?2Rr6oG1dboA4iH2/qpLwnDFo+3Vf1NiHd/Bnh/hZa+L3Qsz+u9BZxwp9zi?=
 =?iso-8859-1?Q?ypGdf2+l9O8e6vIu6WIfrqrQXpAjMmft6PwLmiy9RXE8XFrRIJQMGPvpSu?=
 =?iso-8859-1?Q?kFdupjmu7N6trrfJvE7Wi7m9MwJbfankcTI+vzpq0bn4tYaDnbvFIGNb34?=
 =?iso-8859-1?Q?MOGQn+kBYRLTresID0OsZAdHvVTYoYLgqo3rOw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lpCyxiTnZESJbNRecR5p+ov5bU1UHaJPZse8mn9z+pGpWmd5tZqCKxUo68?=
 =?iso-8859-1?Q?2v+hbZtYUxSnQpCTgkDrtROi3thR5O0TBGoIGtmBLFvqauIfyFsazUC7sC?=
 =?iso-8859-1?Q?0ZYru1XXXvenl5r9nPRkW8sfrZtq/hKO6WAqUUTBXSgvoO9qy+9D/IgGXS?=
 =?iso-8859-1?Q?qn/OSnZTY1hkzSGWeuI+P5l/0t2ovCVpc3NYX1TojrwhFLKSRP0D5b0f+t?=
 =?iso-8859-1?Q?69yZgkMFZah1zuQ8qfdW1tXuWClPeRqKhJ+TB7MjUdsP8GHP+1CrrrQ5SB?=
 =?iso-8859-1?Q?KiZ5jtOsalpzet2YTsuH4oJlBiaDC6dKpmr4lRZ26rKPCMa6JwHky7SKyJ?=
 =?iso-8859-1?Q?sJzFzbc5mH8qdFDHKdQ8vDikaPwKHTpwlzP+pKd3664WzBhHQpPmk6M49I?=
 =?iso-8859-1?Q?qBRUh1Arxyf/A2PCxgrWISCkqhGPZyry1wMITwsoqg8oe+VfGWo3ObhFos?=
 =?iso-8859-1?Q?ZhVieyC36fNXpXNZVZuQuu83vLsWxXZMDdVGIRDq2HrlDLWkMUWFk6xcb4?=
 =?iso-8859-1?Q?6OX8yRGv5w3no17khatwlwVz6l0eCub++/lV7nOoW+A7fGV7oScZHLmfsr?=
 =?iso-8859-1?Q?gt5EcG6hzchNJ3nA6eFtaA6yEA7hVAEeq06McNgVyyYeQ3ynNpp6vB0pmL?=
 =?iso-8859-1?Q?SFN6S+j1grEwIP405oYKuhUo4OW6ZdnZUQ9UKyUATzyEtunZkdGB1YVtzJ?=
 =?iso-8859-1?Q?DiZDHxrs/kdtempis0q7WKEkArBY64nYtXj4f7+nXSV6FKbovJpGnUH2p1?=
 =?iso-8859-1?Q?X/oYM/6J8Lgi0BJypsvUy6Ao++KjDES3vRPI54HvIr2StGQV874e9i2b5M?=
 =?iso-8859-1?Q?qrIMztkJTEw48mvWwuyhuHNMoDQyxoKAPq9NY/BpIKFxLD0ZnPHON0jIh+?=
 =?iso-8859-1?Q?fexdWBWYZ7uaqHx6HzjGAIjeaMZBigYtU9qotsdndfh5X5aXI5DS/ZsEPf?=
 =?iso-8859-1?Q?qJ8boSsMDj7Jkn9GThKPv/PxhpEcGz/4w3qQSKqhw9cDb/6w4wlKASB3S+?=
 =?iso-8859-1?Q?gRFqeJY99lkZwniXYICMESnaj4itl6GQYtG8ou3Ov/pA0AdP9uZbvNonO6?=
 =?iso-8859-1?Q?cW4VPuy5bqsJHYS+ZAI8gaMoyIHWf78FrjKieHk16dHu4G2hBumuqqz8i4?=
 =?iso-8859-1?Q?u8lwJBVvjefS98VXVKKN+WywaUDQ0JP6C5lkpqDtDoNvFdu9/16n08D6B6?=
 =?iso-8859-1?Q?XInZd0sqPbonAZrrefNLFWnOs+joZkfGi98w7qJrgIjCEcy5ZaygWme+/3?=
 =?iso-8859-1?Q?4niIyU4Z7GMHi3UwBHdanEeowl+f7im57Q9E0Eh/6uK54H60zg4xIsM3x4?=
 =?iso-8859-1?Q?KpRLiChM76L7V2CQjfVNCw6D0uA9tAixmAm+106tfTk86iD+hEcKbjyxPR?=
 =?iso-8859-1?Q?8nfaY4pf+DB2pGRQrRh43WU4BDTl1RWHTkNp9EC1q4WBNru70GCE3TSULd?=
 =?iso-8859-1?Q?OCn9FNLCc9TbVZTNkMZ80MOSlKHacrroW2GaM57EAkoyNVVUcDZ/TgsEPK?=
 =?iso-8859-1?Q?l0ElhW2THKoepmdG68ZUlSAYQkUhTOQJV3i6qMhdhEnsgZagTHSOoj3nhc?=
 =?iso-8859-1?Q?xkMTAi8kl/gs63b6HtgidNfQtwjjxKuVIcNnw03IYnl8u23tB6Y9u7GqMh?=
 =?iso-8859-1?Q?0pLYyR/a5VuMS+w0AKCp2GZQGxYieTl6+5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed61f30-0039-4882-3217-08dc9a06ce6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 19:48:40.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UisfTQqHzI1l8qMxDB2UOt8OOYJyjMBJ3xzD6NaGCjJnvD9HW2mTtdQ/LGvOJpOO4D9IAs+fvaoV2QJL834hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729



> -----Original Message-----
> From: Shenwei Wang
> Sent: Friday, June 14, 2024 1:43 PM
> To: Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>
> > -----Original Message-----
> > From: Shenwei Wang <shenwei.wang@nxp.com>
> > Sent: Tuesday, May 14, 2024 3:06 PM
> > To: Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Shawn Guo
> > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; linux-pwm@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; dl-linux-imx
> > <linux-imx@nxp.com>; Shenwei Wang <shenwei.wang@nxp.com>
> > Subject: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
> >
> > Apply the pinctrl setting of sleep state when system enters suspend sta=
te.
> > Restore to the default pinctrl setting when system resumes.
> >
>=20
> Ping @Uwe

2nd Ping.=20

Hi Uwe,
Can you please provide your feedback on this patch?

Thanks,
Shenwei
>=20
> Thanks,
> Shenwei
>=20
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  drivers/pwm/pwm-imx-tpm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> > index c50ddbac43c8..19245790c67c 100644
> > --- a/drivers/pwm/pwm-imx-tpm.c
> > +++ b/drivers/pwm/pwm-imx-tpm.c
> > @@ -393,7 +393,7 @@ static int pwm_imx_tpm_suspend(struct device
> *dev)
> >
> >  	clk_disable_unprepare(tpm->clk);
> >
> > -	return 0;
> > +	return pinctrl_pm_select_sleep_state(dev);
> >  }
> >
> >  static int pwm_imx_tpm_resume(struct device *dev) @@ -401,6 +401,10
> > @@ static int pwm_imx_tpm_resume(struct device *dev)
> >  	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
> >  	int ret =3D 0;
> >
> > +	ret =3D pinctrl_pm_select_default_state(dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D clk_prepare_enable(tpm->clk);
> >  	if (ret)
> >  		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
> > --
> > 2.34.1


