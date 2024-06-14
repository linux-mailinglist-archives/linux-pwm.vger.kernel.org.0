Return-Path: <linux-pwm+bounces-2475-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AAC90927B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387521F2111D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731A19EEBB;
	Fri, 14 Jun 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mtal5BKl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE51474B1
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390608; cv=fail; b=tayNVse5tvIwQ5sVBXie3OJC9kNrgAWxfd9kMqyap8QXEVwgheGMj8kJxImkbNKKFUk+CCaBlsrqW6esxvZTZr9iut7mpBjGuBjTZtQU6jj4IJOo1tFLO7V8Bk58JZNcTxTqaldo37WRCf+KHT23yYKGfkdHHxCh1ZxOmmgX+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390608; c=relaxed/simple;
	bh=56F/N4BLVVcITUIpOTjXbh5AzDe5SWIrQnZla16xOJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AjnohJ7hFyBCWSyLzXGJkbw3wp+Oo0vv/EcmBBbig/ifyfVuDJbhi5ts9sly68XWG5Z9qotJ6AVdOUh9zNqKBt+fa9EE1TOPIwTF/HOlZufW3tZQZuz1pzD04egTvEqVp7Fzumv0+OKMYmxu+IbblxI8g7Kl85IXwuOKflqziW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mtal5BKl; arc=fail smtp.client-ip=40.107.15.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY3M6uqVb2epiPBVYcnaInApzM2XwzJzFvKJzfzthVPi57G3qHm45YILTVkkziP+VbNVoYeCo+axprTPQNWgBVOsd16Qqc2PGK020RwQ3OZTB9J7fOINc5ybtdH4MPttL2/6TIQuf/MVE3H4hBYfcUwGP6TXxUwScZr89CiyKZv5cXYApEow4O0YzcqAJ83XUOJs/EYyPl9Ub75yjPuMXTGIfKzYU7zgtp940C1pEDSrD8Z2QKw5oWYkI7vaE07ftpWNh9TpcSIdnZaX4uocljbAsvKhKGwQ0mhlOeIJJLgFQK941LxF0NrvSQ92V5knc09oaqnVciJShUa45qJLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkq5F+EaBJeazQODtxa5idD7O/bfQWm/zSm6y63Hl44=;
 b=X8V/0x2vo8tB3YhDNUgN0YIRpkIm+mxqlqUoiCBVpa4aO3RqZlo1GuKReQeovLpKz2ETZ2eVbUR9ND/+a8jCKLGQ2cH+cXsMgVrHZ2pRUnI5P7gnDEUxIs/D6vEoYXd964nwjo7Y+0wmWEss8Yivf8YoOdGmySpZhQY5FJsTtTfH26bTIDmPpo1bLDVXYya8RDdMLJUxDWN1PKeaZFRvJ+w/mWlZXSSowWmQG+UahykBXY5mJaW7s4mv2BAWCRTaKmsVv7bbWEJN3oPqXZuAfIcDdSV108LVkahRwXIfvdlIitCv3JhGwAxzYU1NhpgrWgQuWLAndQC7fjQYxtJpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkq5F+EaBJeazQODtxa5idD7O/bfQWm/zSm6y63Hl44=;
 b=Mtal5BKlDmkuSaCgJeCTcA6iZgHvHfu4hmEekffcldamI3zCsD/J8ba7l/cikSlikdKOQNNfYxI3Fhg5icQ6Fy20EfTs45Foz2GqFj1TjHj3ZCDqd7vzJhndq6cXXH3pqFbrYLpOCLoqKyqHn7hiXQy0ks6uISDc0ZHtl91ST+k=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 18:43:22 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 18:43:21 +0000
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
Thread-Index: AQHapjoZMQpjrTjUq0W2pX8yHVRnNbHHxyhw
Date: Fri, 14 Jun 2024 18:43:21 +0000
Message-ID:
 <PAXPR04MB9185BC1C3E3FABA2BC3C0B1F89C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240514200534.73847-1-shenwei.wang@nxp.com>
In-Reply-To: <20240514200534.73847-1-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB10332:EE_
x-ms-office365-filtering-correlation-id: 70f222c9-f477-4d62-0737-08dc8ca1ddde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yhjz5ydefu/oZ/04INM0LGBf0QEryhlOKE6I75TAJc6EBcT16AbRrR7f7w?=
 =?iso-8859-1?Q?raRDgiYQ4/0+hxfhLcqVfRei+U0lM8iijXsd8NU8c7f8bXsdUM9VmGmbTS?=
 =?iso-8859-1?Q?AAe4lFAhcGIBFhRjCg6kvXPX+XYAd3WcH0zJBjBwytn3pLDwvJuLALZqKe?=
 =?iso-8859-1?Q?xukKU3RGttVJ2TBWE9NHartxLFmlCJgIkY6gQnvqoLlntBPo0albHAclMX?=
 =?iso-8859-1?Q?e8YEsxeuTJqBz8ktcLZtC0YIUl7TXBiS/W7Rj3xn/0T4mgSPweQm0cRZGJ?=
 =?iso-8859-1?Q?i0Nv12cysExh37bOb1j4d5+y4/VeFNMmBUtCW1389Wiqq6PleaZneF9HA8?=
 =?iso-8859-1?Q?++tWPPE8COD90fkVv5t3ePxEugJ/xPqpxaxtt/xmP6iL0fvni5UKiQ8Y3E?=
 =?iso-8859-1?Q?sEAIlOEsS8/v23wezEf123TS+vAGQz8UKFQI5Ox1R2OmYP4upWTnimrqOe?=
 =?iso-8859-1?Q?/EwLzK0mTR7Klp3MQCToFY/JDNZoIpIqxg9w8BbK4rHuqSm21rd6un5yZl?=
 =?iso-8859-1?Q?jeXluFd7+ZVjAGsKmg0vxCnGqr7wMVhR+GeG+ILHarTlGIiCmgmmD6qx57?=
 =?iso-8859-1?Q?Zz6IJWt0BJHFJfv4i2ilXMFXwB6BfOV2z2buUOuyVt2HB73KhzqVrZgQFD?=
 =?iso-8859-1?Q?Audfb/B9RsMrDOe5W5HFzPaM7V6U/bR7Y0WlQR00e7I7vsMArItYrBGjAK?=
 =?iso-8859-1?Q?OLiN14lnyW36MXNJsIKtBw9XuPGxwJOt0ywbwak0TB7t4yizK90m5NZ764?=
 =?iso-8859-1?Q?f7aHlTtIxVp447hsUGupM35rmHUGUQ6maPRg5a28Ve/Nuv9DZMrBjbj8mT?=
 =?iso-8859-1?Q?zYMxOOBjo/9o87raX3RYspKft8AZuz0dx7W5Z1UarPFN7Iu93Kru3f78BH?=
 =?iso-8859-1?Q?Kjxd+i+BSBSsJS6SaBxa3R5UBoQwWxl2n3CRvrsM2YbgYZjPCn4VeE7S9N?=
 =?iso-8859-1?Q?NrMhJ2ZF9gINWgokXTh0Z7/RWCtbfY4BY7BybbMeSvQsCz9HK5FO8sXWfj?=
 =?iso-8859-1?Q?LkxeTKIlC9xNTKi9McUqlctFwd2MMRGdafASfhNs8MzaVIpy1RIFcwgmhz?=
 =?iso-8859-1?Q?15r4cGrQCb6zwJmUoPhe98s38yM2uQajWqdkzKeoh3MHZbI3mAmVdsw8oe?=
 =?iso-8859-1?Q?9vmiyiDtkdUqkD8B8X+bA/BCrxYjyfYjlAYpwTin49Z79Sa93pBDQh+AxL?=
 =?iso-8859-1?Q?rBgFo9KlKPqmsRnJOSwIkb6MHRz2xgMFojfOzRlZn9bMf6p0MdGQT9QQZZ?=
 =?iso-8859-1?Q?I6D71iBnYhwdnrLZlL/1511Es3K1C3zBcC2Yo6YneTBVdr+tqLLro9PMRD?=
 =?iso-8859-1?Q?ezfBqIss4ykXTjyVmrMbr/Jwx9r41Rs127hYekSDNWvi7jv78u/kjIS4qA?=
 =?iso-8859-1?Q?MwFHdf2gKyPFSIV7bAtpJYz2JIslaMLmPC3VO3e5V50Txmuq0K4kk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?U8Jl5+slbwRvueFiBXfk18Shda3sDoeftWFpoMcduJkgJVco2XU/W+Bf+8?=
 =?iso-8859-1?Q?ZHA0XZDZxoYdayYdP7wVTKRrWhjaFkLrUMvjhz71qR2rcN3PxGBO3Eh9ke?=
 =?iso-8859-1?Q?XKjvWcm4UN5oFO6O6IAa/Rec8CRzDvL/WAHG5z3pPCKYDkM/P5t27hrubO?=
 =?iso-8859-1?Q?cQE/rhpBtfQ/Snd3zqijwxwPhKdD/FMCvA9SJzEUPshc4D+o8mJclBRwl+?=
 =?iso-8859-1?Q?EaPliVbv/X6G4PKSV4qIA1c6oN+kG0jhqL11pHLIdxp3zEtVQpkgg/CUrr?=
 =?iso-8859-1?Q?fIJvLY+KYc9kkX+BavgjMKAVTLh58pxgOHY8mGsqQPMVucPk9l4w2MM2/Y?=
 =?iso-8859-1?Q?Z97wZoGqynSHMa5AU2BKlE1E0QI72adq7ZoAbF1yNvzN/Uy60p6aHIdnmz?=
 =?iso-8859-1?Q?Xo4ehrRvbC0J9ICWZouxSrQXewsYC/RCTFHjcl1Zet6mOX7QmjYh9uq/LG?=
 =?iso-8859-1?Q?izUARF9BTi5sJN/QXpSg+B89x7/6JHreTt5DZ8Rm9irt5MmXv6CiQcwoTU?=
 =?iso-8859-1?Q?dQbRx581IVbEuDMDp1v5hILpJuApcTNDQfhwoMTevJ3AdOCocNqLjUDnDT?=
 =?iso-8859-1?Q?Nlpe7jqgIOkhCeMyONFThg/nDIG+xogqdTZJPyPIIW3vyQoNCEEzbDeDld?=
 =?iso-8859-1?Q?381NbTLHF+s0HfhTxpCRMLd7/mi6Q24SmkCBQzQw7GKDA4hLa97tUZGSkg?=
 =?iso-8859-1?Q?Nal5zTZMIntRQM5MU91Cd4ljKs1uwTy4yVPrUu4/AxogsKdQr4l5RNO0GU?=
 =?iso-8859-1?Q?aVagYWMnIiGfImXywvIanlRqooIuMiV3xVvMaSj5absUsUleoSSo6hMZNr?=
 =?iso-8859-1?Q?f4aKH3ZmsIB24IWU6Mg7Ruxt5p5di6D1IPIieZlXfK/pT3DBDIIa8aA1VT?=
 =?iso-8859-1?Q?fCuUhnRtegTFFPM1AW8lU3NdG5w4Gjs6Xwb8N8/Rw1qTNFYWvyZQd/L6ep?=
 =?iso-8859-1?Q?d+Xei8Ue8GuFrcDChFZ8MmXp3q6Ct51IOFidd63yLCun52vrrfJjhbKOJp?=
 =?iso-8859-1?Q?eJkPz75I6x0cOBSdFi2MZT2QcGZtyPAPiF2Tz4Qol6Q8ctCCjyyYR70VpQ?=
 =?iso-8859-1?Q?hYjz5qoiUxGcyYR8hjICZRF2HZTfswHomn4VttoqcBRbtLaeoRCqzbT5LT?=
 =?iso-8859-1?Q?0WYXMsNz+pkU0CShnVqrQFepCycMa8FumDli7p9SON2ds7ZYHoI/uboaeg?=
 =?iso-8859-1?Q?uHuPoC5oM3H9NoZ0eIEenCbu2Zk9q3sp2h5ELqF73Y39Ppo1nusmBrTvWT?=
 =?iso-8859-1?Q?fDZvmg0gseVFZAhnxmJmcErOi0SYuh5+Mw4MjYMC3wMD4Ug+OW/bBKduec?=
 =?iso-8859-1?Q?Li92zyEYeUBTk4eK3LWLzRtAtMcjSYQNTGTolKeXRYs5sPhYX9jZ+/uYid?=
 =?iso-8859-1?Q?RgF2J7Kl5GhKT/M18KBJb0oQVs26qjFl8Nz9JpUwVwZCoaPHofxSVjy9ow?=
 =?iso-8859-1?Q?WvhCu490O2Mh3AOgPZi9rjaRcFTH+Rr9biNHmW//3CEfiIAQFdRD2IX859?=
 =?iso-8859-1?Q?lGY/H1hQIphcXXj4WCBJbm1Tpfa9PHYM7mxI5rWDiBB2RUe5iyu6KcUpp8?=
 =?iso-8859-1?Q?VGnfY0KCiRDVAaYcJ3Cdr8sRdpT3E3tVKTvyS1rPVxMtVoGldsFl6Y6jLP?=
 =?iso-8859-1?Q?Lo34MCzOE4wlusXGU1aHrWJKowWwFZ/bkH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f222c9-f477-4d62-0737-08dc8ca1ddde
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 18:43:21.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZUHjhoyqUNQzJ5WLf2mcbnBtW/cL+A8OD8YUAqDsTPBxbOmbA7I/vxRapgaMO1Bj+0MiK5sJs4nIXRKUz7AgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332


> -----Original Message-----
> From: Shenwei Wang <shenwei.wang@nxp.com>
> Sent: Tuesday, May 14, 2024 3:06 PM
> To: Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; linux-pwm@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> Shenwei Wang <shenwei.wang@nxp.com>
> Subject: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
>=20
> Apply the pinctrl setting of sleep state when system enters suspend state=
.
> Restore to the default pinctrl setting when system resumes.
>=20

Ping @Uwe

Thanks,
Shenwei

> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c index
> c50ddbac43c8..19245790c67c 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -393,7 +393,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
>=20
>  	clk_disable_unprepare(tpm->clk);
>=20
> -	return 0;
> +	return pinctrl_pm_select_sleep_state(dev);
>  }
>=20
>  static int pwm_imx_tpm_resume(struct device *dev) @@ -401,6 +401,10 @@
> static int pwm_imx_tpm_resume(struct device *dev)
>  	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
>=20
> +	ret =3D pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D clk_prepare_enable(tpm->clk);
>  	if (ret)
>  		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
> --
> 2.34.1


