Return-Path: <linux-pwm+bounces-5885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA9AB2F36
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F88F171A8A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A72045BC;
	Mon, 12 May 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fTuJ7BYF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA33D76;
	Mon, 12 May 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029451; cv=fail; b=pvlRtQQSuIuvp5QWMNh8qt3zt/dhTK3gPUsT28+/W14wCosjKvqfrjuh0LJwvkiNDESjtMG5NhwtpVWPSlw/Dr5IzLOVyd3UMaGqlkHOB3gbNTGLtmFADfghJjJ4Dod6NP9UiC2IR8OdxY+GRq+PBJMhdAb1HzpOkgYRsLGbUVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029451; c=relaxed/simple;
	bh=Sp2RcXuTAe2Y4VzT/jTz79ERRWh84rzQnBW3+tTwJag=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cww9uA5OdEWBnlKFhbGtpWpE3jjedTgTRwdWef2K1LHQU+aFTf2iTjqTsP95b/1G5+YX3GRnx+f0rYVGUGWd6MTLTkHsoSjVLpqu4FC0cSVn7TvpqZ8cgmNNMuCwDgPyFBksdqvyH6YpGCjta0h3tu33rXODTMNxp7ML3RwJn+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fTuJ7BYF; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsVnDKse6Dv8ouhUziNfeDfXK5SGO/i/Oc9GJObLLBPliBgz5s1j4b8XQvoi5XLlKw8U0jQ5fI7mj3CY1OSRJI+FlEaXKoKmIkjEZQaKQxfwvBpY8o7PcoJBqsrPamAgq+RwH5621qcUp6yRfjte+WbvSh1G2NvJXTmeLliOaFFeaNtgDklgedG2nvmdUiy5IJ9iccjzubM9CzsN+rBw0fUdiAOiTvwJ8XjlMlJPyxupYaVH+7qRZeo4iS+p1a6437MOpgb0N/e3Q23FT7CqNOXgCcLXT0zPnRwGf+Nck/mYFWof+p2hU6mk1MTMzp+rXM5Ieh6l+AUwQguyRGc5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/cR0zsHgspW8pAlBNTx6K8RNpHnE76FYlF+9MDKu5U=;
 b=LslzMUU0W0YkZTdFYTK9r+a0bAR4ILScU41qUGwOy4l023CDR83vR1TGdDZSkzOEL1LYD2QLE/sVgp2JqWWCOuG2D4eoSenI5ry0QwgnYi3UL1EMJe5P6Mu5xIrPtxunB5bo25WgUD+EohfinVQ8UsMWCuyRw/y4J80P2E/OezHy5yzzi2jd7/47tJvZYIShpUkzby/ZDWg/sJrnveSadxx72iB4g6Fq65azZ1zhh6Is1Wl4UJTmt+P2cQTmmIA5dQhUhcQfmzEbReDnUov/PuqDJn0ywkLSUBxKGmyetZaYeCil3Zx04DqXBCKOUzPpkTAWMCR3qXgSCYWluG8RZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/cR0zsHgspW8pAlBNTx6K8RNpHnE76FYlF+9MDKu5U=;
 b=fTuJ7BYFF/JX7/sfBKjnJFlbjoLKYdJmhjrxavceJ30CHXBmu23NfXZ787ZRlyhLqGNVuXjomIT05/x5frAka6pV1EOypyyGehzk9tozV4nw5Ds8+blNVElEm70pJ0HmzG0LcZj35u5EqYBQYjJAxmxR7nFjTwldlcR1cxPiTgk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB14046.jpnprd01.prod.outlook.com (2603:1096:405:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 05:57:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:57:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will Deacon
	<will@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] pwm: tidyup PWM menu for Renesas
Thread-Topic: [PATCH v3] pwm: tidyup PWM menu for Renesas
Thread-Index: AQHbwtHrGtp3GZNpjESWAqPHbiLULbPOfvrg
Date: Mon, 12 May 2025 05:57:18 +0000
Message-ID:
 <TY3PR01MB11346BF34853871CF14B7BF028697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87v7q6y9m4.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87v7q6y9m4.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB14046:EE_
x-ms-office365-filtering-correlation-id: fd0d52f3-317d-4f8d-8630-08dd9119da94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?32/pJbEUI2+8yWEQpzRZt9xV/C7pLBOOSAK2enpVvEgvwpYTXj5YcJfa7T?=
 =?iso-8859-1?Q?LZEEfudKqrd684RlExw2XnGHm4aDGEmhll04Gk/ThR5FRf4U8tyyYTPsNm?=
 =?iso-8859-1?Q?xS9aHShLGbWa4m5owVJWTth5byyRB4xHqR2Ok12KtrMfiYz65bcJSKHfcD?=
 =?iso-8859-1?Q?ClzpjMvLuL4h/nfKJmdgO6CvqJS7YmEfzhSF5SOchPQ0M8n9oKtB9vTX71?=
 =?iso-8859-1?Q?FWQt69T9mKIYmu5pOLcmEoVT1rFZuPkHTAWwfvIgCRulgVVDW1/zc3lrsY?=
 =?iso-8859-1?Q?jLTImOA1DnjRsb+6PR+oFkWlAHjOr6canyPtkn9pBF5bN2N/sd2rzfBO5P?=
 =?iso-8859-1?Q?DOWYxbkG9gQh7sPLvUW60mQ+WwcxVB3bY7Xnw9QfUxj669iE31fX/w4b1D?=
 =?iso-8859-1?Q?vAVKLKivCdT/ScSqJ8nvAyCKttmna0trVsBySITt8Wo0P0yKQfHIXux7K5?=
 =?iso-8859-1?Q?s5EIaOmOAkPqnK1jppHENG89hbIeJfvJ4Sh1szFH0SQWvjpW+xxHhVVdeY?=
 =?iso-8859-1?Q?QVvuzNmp4C64HGj8HaBeMr1DfHA/zIvrZCXrrlzwVg5cOnMh7haZ/GzntY?=
 =?iso-8859-1?Q?Su4/2SeuG2oG1KInexCPzVMWPfSvdU2Ju7sT2icGntZk7D3oCytYCRFluO?=
 =?iso-8859-1?Q?9aMHmIv8hRT7WYnmwJi2mXuNrsFTCP9rRViOMnuUDOmSqLAeGaD0LssFZ7?=
 =?iso-8859-1?Q?GrFIOAk2hAWVjLdXVglabhnl3vDM1RZPYs3TzIIlvJ4pt9hKCIZOfsiO0d?=
 =?iso-8859-1?Q?ptyiQuaACmrQN9omkWrdJHfNjEK0bHbhyfD2wE3Axuc5NGDpW9RydGNqiy?=
 =?iso-8859-1?Q?HQSAGh4DQVDIh+rsq7y6PGUZ/HSra5XEcbZnmA7Syk7u73l6ivoZBR58H8?=
 =?iso-8859-1?Q?cDQojzhfgW049WovYPlWpUlUzqGua401fh7ZYlaiqu6o1NN88vGzdCeAWy?=
 =?iso-8859-1?Q?KZtkjxk13DrMw/IeVl1wpU+XmRv3E3S6AFGtI3JQCuWaznTYYkC4A6t9S5?=
 =?iso-8859-1?Q?uQ3c1ibdJ+CxMEumCl/CWgeGn8YLnx5ahspOZ9gz4mc7Xblj4B1rWY+J3/?=
 =?iso-8859-1?Q?Q/xSxI/6P5igfK1/We6jY0hMLRUwFdr3qSxmnjsMbgNj2w2Pw/CAW5ocM/?=
 =?iso-8859-1?Q?IN8ffGjlDESdXB+G5KbyJpInJC+WHuRr+pZSX6PuD8pJxVYZaSe+uHJvmq?=
 =?iso-8859-1?Q?IrgWYwbjqo7uydV79jzJhsuaQy06Au4Qb040MlEwF4fkDtCHQR1+P09LUw?=
 =?iso-8859-1?Q?5u5vEG2XzuGINg1shDREhTisOxVaTQuM9YwcZh3CQ1zlT4OGqJ6DZ6f+uQ?=
 =?iso-8859-1?Q?z+qk6CzLBCnOBD5xskD0Nl/ctOOnLcBC+L2XfSnTBFfHTlzQ55CQ98LzJ5?=
 =?iso-8859-1?Q?oetpeXsF8r51gfo3p444px6SbVSM4Q147ilcB9kWTYHZga1rkhBLjfiwj6?=
 =?iso-8859-1?Q?O1IL0b2Zy74GkI88eznIaYsQWGD+ltBMSj6PNLhqUvsqwcrcWg95V0woL8?=
 =?iso-8859-1?Q?Gj4WVIVM14+sLme2vsUrU3gdFiBHhdmG2bDWWC/ZSax7J5sBc/taYkygrO?=
 =?iso-8859-1?Q?fHsAGgk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FPnYIMPrmT9tXBOy/hxaUJWs5KE2WrazfdMVukDNpgrjlPN+cilFw2feCb?=
 =?iso-8859-1?Q?I+VMVjHxlqqP9GmiTLzC8kiX7YyhFZveuZix3TURkhsRKd6dmegzhBsbov?=
 =?iso-8859-1?Q?2cjEF1pn9X/PcvifnqGjd3l8Y+7WmZEn1kSAKMrLGbC+NoojrJsaDzCQ38?=
 =?iso-8859-1?Q?icDA4lGEx8zqkOnSBIReiwtQ3Job/axogrYEBpoAQjOtCxERyUm+Xd4bhd?=
 =?iso-8859-1?Q?+OG+PtdKJ4QRWYdOtW/X3EVuppAY8V8NAYBzTsM0Fk7UNs/LBbgAxuVjnn?=
 =?iso-8859-1?Q?mBSisuXohffRn1G/pNors3snOXMvMREOEXI0AAD77h5nKIOmt14Ba+IrKx?=
 =?iso-8859-1?Q?rijb4ST4WysSRa3zLnt01A9ooQrr5IPL5xU2cSGRoYAtkFWX/qWuuvp97F?=
 =?iso-8859-1?Q?Vy9p415IzVjvN1gjPRPqy9KdQFz8oS+PHh2labqh6HlPn/Ly9CiKLSMTWq?=
 =?iso-8859-1?Q?pik1qmd8OR7IrwfmfmLBN9JM1OfZd8jQQTDdDxpD38qhNlabZ49iCZv3bF?=
 =?iso-8859-1?Q?yVm+AC+++bpJTrA/FyEJWZd4duDTJHExpmqfVog3uxUzAS0RAnULOfSKQn?=
 =?iso-8859-1?Q?EE0981dFQdE8xtCf8AHGrrPmcSgkXXwn6kUxetDIPGqNaeg30yHT1bl7tH?=
 =?iso-8859-1?Q?WJMZYgO5eMvFMvH27014YWJd0frA0dXX9tw0xK+DkLdOtyUR+HnHHg38EP?=
 =?iso-8859-1?Q?NLbgZ2utpy8ydYzsR1MN0KDste71yCOjuK8eYR5DAia46suGwsKBtJvx/L?=
 =?iso-8859-1?Q?6bYBY14VZpGrkZGYs0bFzm1b+rM37VTMy0f3XEejjqKhIDJUQ98KIopevN?=
 =?iso-8859-1?Q?/NnqYvjdCkxy6dR5TSfRsnska6KnKFnGca9GkCu6hluwGumYIdKFln1x7P?=
 =?iso-8859-1?Q?NxfN3MxVYuAna4Py3cuW5eMt67kQcqI4zIpdgJU2WIM+aMHFhmHE9UdE6h?=
 =?iso-8859-1?Q?Xz/KyYbEOk4y2Vx26I5Iv3pn/rMHxGnNfs37/xH1ssBvzJvnaMudPRD5XM?=
 =?iso-8859-1?Q?8S1GUgOt2DFhwYA9JEjpglnyGIL8zRKR+t2Y9ccIhlYI+o3VKej9OMPDap?=
 =?iso-8859-1?Q?R8NSEOysVfvOK1y2tSjkDgoI6atts3jZRRC43aLZRdW/T+mPkIkVW1iC7W?=
 =?iso-8859-1?Q?95dQObntj9ZGwwdUy35njpEcNWwiVNP5U2KKuAT5saHLnZJNw/rSUSw5+h?=
 =?iso-8859-1?Q?vpN7jbzvTDcHXkyFdnqErWqvfXu7VUfeOQZxikVeT7jwVLz1o3ZQCQlOGt?=
 =?iso-8859-1?Q?R/BLKI0/53RzdlqFumwtdTI35bGdmqtzMXkiQXblbyfUJSyO+tWbwDGTN8?=
 =?iso-8859-1?Q?MeCG03+F2eRYPj1CEuxwMu8HI4EvmIxk16OK/DIWf4aL9A3XbmLLBPcwTe?=
 =?iso-8859-1?Q?aBscrUb5h+Lp3k9hmvPRcfnoEEPWx+K93myTByGp12dQqWp/BtZuljNvnR?=
 =?iso-8859-1?Q?J1dN7PCApsWCGP0erdObu+VuBNTXDmuRCF5PAdO3PdseMZntd5r3xZ+D5P?=
 =?iso-8859-1?Q?UmZdt7qyJH9XW4yMpkNLWJiYbpf9MqW884N2SRBx40DydSWAf7KFWucbSW?=
 =?iso-8859-1?Q?cpS993yrwlP555HGrGyznaXMV3YnBY3IWKTs0Qu+4hDxN9PkJN38DMLleg?=
 =?iso-8859-1?Q?4QG79js/lfriagrdCYvNbEMXjWqOuqCHxE5CC/VGIwj4LBe/DuleSvzw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0d52f3-317d-4f8d-8630-08dd9119da94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:57:18.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eg0XYy2OBVGS3EXpU0aJ1XIWkytcLPqSBzRQtnzIFjqJQqr7xlXjqV1/n/7sfsbVxxA1o+VPbXu0R7dNu2Bg9PK5B6wvx+KAyIkNiX+pf8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14046

Hi Morimoto-San,

Thanks for the patch.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Subject: [PATCH v3] pwm: tidyup PWM menu for Renesas
>=20
> Because current PWM Kconfig is sorting by symbol name, it looks strange o=
rdering in menuconfig.
>=20
> =3D>	[ ]   Renesas R-Car PWM support
> =3D>	[ ]   Renesas TPU PWM support
> 	[ ]   Rockchip PWM support
> =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
>=20
> Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas, and sort=
 it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 	- tidyup sorting
>=20
>  arch/arm/configs/multi_v7_defconfig |  2 +-  arch/arm/configs/shmobile_d=
efconfig |  2 +-
>  arch/arm64/configs/defconfig        |  4 ++--
>  drivers/pwm/Kconfig                 | 24 ++++++++++++------------
>  drivers/pwm/Makefile                |  4 ++--
>  5 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index 37e3baa33b678..8439b24f63534 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1203,7 +1203,7 @@ CONFIG_PWM_BCM2835=3Dy  CONFIG_PWM_BRCMSTB=3Dm  CON=
FIG_PWM_FSL_FTM=3Dm
> CONFIG_PWM_MESON=3Dm -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dm
>  CONFIG_PWM_SAMSUNG=3Dm
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmob=
ile_defconfig
> index fd28f3176c6ba..e4e69b381af15 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -216,7 +216,7 @@ CONFIG_ARCH_SH73A0=3Dy  CONFIG_IIO=3Dy  CONFIG_AK8975=
=3Dy  CONFIG_PWM=3Dy -
> CONFIG_PWM_RCAR=3Dy
> +CONFIG_PWM_RENESAS_RCAR=3Dy
>  CONFIG_PWM_RENESAS_TPU=3Dy
>  CONFIG_PHY_RCAR_GEN2=3Dy
>  CONFIG_PHY_RCAR_GEN3_USB2=3Dy
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig =
index
> 1f25423de3833..1a5d30a1bc481 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1537,10 +1537,10 @@ CONFIG_PWM_IMX27=3Dm  CONFIG_PWM_MESON=3Dm  CONFI=
G_PWM_MTK_DISP=3Dm
> CONFIG_PWM_MEDIATEK=3Dm -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dm
>  CONFIG_PWM_ROCKCHIP=3Dy
> -CONFIG_PWM_RZ_MTU3=3Dm
>  CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PWM_SL28CPLD=3Dm
>  CONFIG_PWM_SUN4I=3Dm
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index 0915c1e7df16=
d..a1000b48886d8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -510,7 +510,7 @@ config PWM_RASPBERRYPI_POE
>  	  Enable Raspberry Pi firmware controller PWM bus used to control the
>  	  official RPI PoE hat
>=20
> -config PWM_RCAR
> +config PWM_RENESAS_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -521,6 +521,17 @@ config PWM_RCAR
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rcar.
>=20
> +config PWM_RENESAS_RZ_MTU3
> +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> +	depends on RZ_MTU3
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rz-mtu3.
> +
>  config PWM_RENESAS_TPU
>  	tristate "Renesas TPU PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST @@ -540,17 +551,6 @@ config PWM=
_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> -config PWM_RZ_MTU3
> -	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> -	depends on RZ_MTU3
> -	depends on HAS_IOMEM
> -	help
> -	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> -	  RZ/G2L like chips through the PWM API.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called pwm-rz-mtu3.
> -
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST =
diff --git
> a/drivers/pwm/Makefile b/drivers/pwm/Makefile index 9081e0c0e9e09..a44e5c=
0ff135e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -46,10 +46,10 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.=
o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
>  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
> -obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RCAR)	+=3D pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> -obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o

Do we need to tidy up this as well [1]?

CONFIG_PWM_RZG2L_GPT-> CONFIG_PWM_RENESAS_RZG2L_GPT


[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250509&id=3D5ad7de623853570bd981be069ed5ce55540bedb8

Cheers,
Biju

>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> --
> 2.43.0
>=20


