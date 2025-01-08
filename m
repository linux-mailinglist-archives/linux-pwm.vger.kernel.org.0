Return-Path: <linux-pwm+bounces-4552-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCDA05E22
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38D01885B78
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F441FBEA6;
	Wed,  8 Jan 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="U6m+8PqD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011067.outbound.protection.outlook.com [40.107.74.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4813BADF;
	Wed,  8 Jan 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345600; cv=fail; b=fzmNX2r6tEy1lh/yThKYI1/Bjt3in8S1/A3wbceJ5/Jv81v9NHtS5iN2fD2JfM0ME5T9JcNK3LLjf+cVwDWYfGeeC5yh3Hxc+cuoO1XkUjsqnV3HXaM8mZhukdl7UeULw19Wv8Nrz+6fjqJJoF1XU+eJfXwkLB19leWmYjZH9Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345600; c=relaxed/simple;
	bh=fN0N5fIuGAwtIgDL6+ADKtIlqk99vcQGgJMadORbHvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DXjMR7H96xPfS2MqMoy3LoaawYzT1J9MGdoRGz0tIPWk2lPzrDnDOnNG6wjYiC3be+CKKXyn0CgYLO6lZJAGpyf3zTi/67PtpZ2TxlU/m9MGQoGkbuREcjvpbmkn8FL/9kuajMDDtDE4iXUCzUokJtEewvsxnTwKwxbiQRbcFGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=U6m+8PqD; arc=fail smtp.client-ip=40.107.74.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoX+YmdWwBr8awYYyp0tfpZ271cCTXOytLjiOYk883yGxlt6pztcYdoXSy1T7vjDhXf042vkaTq5VrNNfQ3reu4KVetTeyeYgc1FSbFJd2oCSFvjvMqU/lSQAAuNfoGGw8AspPXHZ+sv1XF1ngJtkGW/nYZjUQI8zWD3obpIXdnYjibQ71aXGySW9psSQVHN0oKZUtUmID2Wriyh5wSjlzV63PAXYxk1NJdT1EuqQTqoAq8AmtIkSkcA3vif88NxQnXxL6EXlVCGTXWkF5yyWihmip3PBAinM9qnIwvHY6j+kE5F/gsICBZ/QioAbqlhyS50U37hCERiGJHXAPQ0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljDqMFTUGr1uQRidQ+bWJv0XeZOpjgboefdM2qwqyTM=;
 b=XTrstiUGTgeAYU2JpvYReRGN2FUgKF8byKvpCxsqZOPg9k1FatNy+BvEf6zfHcw/NbU6MXaoQJrmMr8ETWFFpbz75Ciz4rnbAFFAJ4L0+Tm2tI89YvSQ/KFYKcYStpjAFBW660xnrUSypEuLfleOTfB5KLvuVUN/ne7tI6IRHCH06ML0se/ppth9ffi3FeFEV6JCm1KFYTbD9YFaklM0IW9cb3m7Ei1YNZUemIUTa+mgIilmL+Jt+l2/wnuCXhndBegy6ndNbpt84l3g+HxrkFT+96HRNt6CFdd9nIISF22YJiLKqkwDxt7tESPT1DGtKCZdxmUif3RTPumP2+H37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljDqMFTUGr1uQRidQ+bWJv0XeZOpjgboefdM2qwqyTM=;
 b=U6m+8PqDebTnW9dCVetW2ze7eprQSK+qC9p77rqfOemrOmzgKrLOEbXlcJAx0TQUAQ9ltnzgQaF5UIzhDwBXbmr9ZoSbSGko529mgrskuz5QbmmudrX++9yFcxfRlOnjCcsbdKmO5/HehfIh9LEfnAVBTDqMaFnoyZgyZ/ngvy8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14042.jpnprd01.prod.outlook.com (2603:1096:604:363::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:13:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:13:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: kernel test robot <lkp@intel.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbUIfEye5JKGoBg0O4godryy/UCLLsKj8AgCDikqA=
Date: Wed, 8 Jan 2025 14:13:09 +0000
Message-ID:
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
In-Reply-To: <202412182358.9wma1UUE-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14042:EE_
x-ms-office365-filtering-correlation-id: ff850120-463c-4a46-3e5e-08dd2fee946d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Q88b0dFR8uo5iFggAyXvOAAV5vSdnibrKYJEfaRI95RWo3Zz/gnldp24iC?=
 =?iso-8859-1?Q?qETKXxzWwFd7/s+vfQqpxigcmdKXzmwFyBKf/RHh74TB6V4HEV2EVjd3yb?=
 =?iso-8859-1?Q?LdoBufJaEmL/Z39NXjmVApjaGAaFRVVCWlwdEnhVGggK1Rjp3wzRKrSsEG?=
 =?iso-8859-1?Q?V4h3ruxU1HHzgLOlB8qghzTqH3sIi3iBpNhJoYnb5ilWXWLLU1NiP0ekii?=
 =?iso-8859-1?Q?PeoIDTWiPD53w5r0inmhRpeRaOfy2ZMxKVUn7ZiXU/Yhsg9/A0/N9+APn/?=
 =?iso-8859-1?Q?TQBB2GFZMOdmvvkc43mCAFGf4n+xFlAfFEWDpuK5wOtJK3l+EbY54NQojZ?=
 =?iso-8859-1?Q?aXC6U/HZSWPbU+lLLmBw3dXwLz4HC6xVG38MOxmkb9LhuMHKki4SDwVXiu?=
 =?iso-8859-1?Q?YH9+NW6Iy1uPT02daBl3xSP6zdvOZMQvDiEyjLoGkJAkdhxeHOxzjEzRrL?=
 =?iso-8859-1?Q?pQ+4rKoLLOaM/cP3awrqX/aS6mQHqXqNpgHLCZKx9EBqfE4i1bFIhvMaYu?=
 =?iso-8859-1?Q?PoTS1plDLeBz/KY3owcWXvKOshbUjQFY+Wd4UIY2sMYMVx8PQksIpMaWvI?=
 =?iso-8859-1?Q?Nl0LNWvrNOwDl/0eVWOM9LDNUAVGk/bxYDWeO7/zjEc2NEKQbN1Ymt1bLu?=
 =?iso-8859-1?Q?/mRNtz6pH7ZQeg/WUf7fEybXiCthSlJKY6/+G2Nke2LPn19rcf2Iy2Hvsc?=
 =?iso-8859-1?Q?VEGI8k7SSytgaYmSeGOLgKu8wm4rsBcjqSNL5p+LZmYcD0CbpharkdoJpE?=
 =?iso-8859-1?Q?C24QXFdqLgMuocCG2ssOP6lXtWySn2K8zcnjyp1twESixJzXE+sCdT9drf?=
 =?iso-8859-1?Q?JSZFLpPu+40vN+dlVH1GGkjOFf2Ejf5JiPZTdwk9Fh+dp/SgrsLpwYBUJS?=
 =?iso-8859-1?Q?ttpJuPU80mL6GTXZDplwN7j1sMprk9PRYZeoVoGMfyDH+1xCV6jX+dnAGg?=
 =?iso-8859-1?Q?rMGX5tBNhQLVzdh8A5qVgqiqgn4PGxX+lSei6pNtUr2GHBP5h7xlZyPOip?=
 =?iso-8859-1?Q?EiCv7dRr1b/LUT0jhE9/m+/lUUXljdt31gBKjhqZ0FfjT4tJgsA2lwlnen?=
 =?iso-8859-1?Q?uVLpuw2vcgcW2Ajdlwye7Upi0DeYo94c7+kIGgSd/KOYfjyqLfNqTp3zD9?=
 =?iso-8859-1?Q?0vPWT4dpMYHudoCsE25EcG1Z7Pbqy93zJhHj6Ih702Mbueem/U3hH1W8v+?=
 =?iso-8859-1?Q?mwA2HhmBzsyRra2vXkNtiBojfK6EaVvXgSxeIcZ3VvmkSTxRlGdm62x+xi?=
 =?iso-8859-1?Q?9CJrU8gswQFeV1EkU4mroHI6hQeE8ewYKu8nk0+4h+wbbWt8WpXgR0OaFs?=
 =?iso-8859-1?Q?1nDq+L6bL5sNIYPeo9qKnlGusgNVwWe+LDyccg7k9FHVZK3g3vPp8qGKCh?=
 =?iso-8859-1?Q?BscoYR5FmZdWTps6tlHOq/S6RBQ3i/BCKxGQsvQ8lf9H9kEIfuho6HpSet?=
 =?iso-8859-1?Q?91QYc9xM1k8G5k0HYatJCuMtGzZNfMpOI2WBPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5E0BLABF3Y3JPejfYnaZs9pfxAEQhZEGnHgnD+az22wIRlHxFkvqsiRDSb?=
 =?iso-8859-1?Q?zVNDl2DUh41CAOAeTVwegNBsMCB7shs5sZ8NsrozfLTmd1yr0FbgGiDoKP?=
 =?iso-8859-1?Q?kD26oecdLp64CEMjSc/e8oi6ejjd8en7Fek8TvdaHZKCht94PgUb7ysTjG?=
 =?iso-8859-1?Q?nTQDZERghzG6Ung/u5q6wmP0C7Mz6HoqsoEDWNQCAskX/IRDq4aF0sV8/X?=
 =?iso-8859-1?Q?OwRg4fm1nZ6xCJw5f2x9vSSgt7BQuFN77YOv/3R+8beGSlWadQamCMwRct?=
 =?iso-8859-1?Q?CQds1OL1x5iUS0GiXv/FyAAZ5s4YLP7YzELh3XE9ZD5VjYneYLfLAdz7tr?=
 =?iso-8859-1?Q?74PaCYYtZ/1h6J7yBHtzhIUqklCZ1S7jHXQDIMm7TcJAhmc0SENXuxHE7+?=
 =?iso-8859-1?Q?uTQGkUc5q8N9W0DtzJ5tAPlt441FOyLj7QPI/EDR6wQDCurIXRAujmNsIl?=
 =?iso-8859-1?Q?6q7ZcRv0qnskM+i19LjCcvidtscGWw4vZrLt5526nst1AYpEkee3lSgku6?=
 =?iso-8859-1?Q?quulEs0nPrr/iJtTZPNr+d9nlkHstXXs+mAZnNI/Gk55Qe2Uggfo+/RYV4?=
 =?iso-8859-1?Q?pUOZQNN1h4wpeYIXtMn9xshLsnxU/4XJXQ2Iq6sS/bmAq2eHnECR7YyrAJ?=
 =?iso-8859-1?Q?bAwLumLitT4056nQ+V0CgY8ebtztZRUvYJc1Eaqq1d0AEJzNm0lWFHRW+i?=
 =?iso-8859-1?Q?vOXHa7H5Cfl+jy+q0eG348eYrxvvdGfndnfY0bxGpg0T/tdjyh8JmvicSU?=
 =?iso-8859-1?Q?1JOiilm+1W98yHVi3HGHVx7EwxZByt0vKd8BSUjY9naCCPHu3P4loAZ/Ru?=
 =?iso-8859-1?Q?rVr9I7b0hPNnaa7QKF+JTo/vcNw+IgtL0LCz/e16lXJi9+G0yM05C3onOb?=
 =?iso-8859-1?Q?0CxvtKHhsf4eOjtuxbmeSz8kHBwSInAd6XT5nmiUOI0l0Z3DcMw6/sADan?=
 =?iso-8859-1?Q?aLyhYcPxqzatrk6nkoDaOVGIy1VFn2dVlCmQx2m904+udODVgEAkZDbyE+?=
 =?iso-8859-1?Q?KReZ2UvxksG4FdqW6b0Bnx0FIQjhscoCFovOr7yiv7/SAC3iXuOKOzrtIt?=
 =?iso-8859-1?Q?Aq0UmpN7+Daz50v1bKe7Qe/LQlJfu0hgUgebt9G91HUSPKiuHBKRbtzJVr?=
 =?iso-8859-1?Q?Lw2c4GAJCcJILzgaOdWalK/Rs8MDzMiF+xYPoFWl3zZ1yx4x+uFbuWWU9W?=
 =?iso-8859-1?Q?Wpi+ryXfnsFOJbLWOozbhos608By36kVS+pYYCixMMRD6ibim191AVZBhC?=
 =?iso-8859-1?Q?12U//h9OHfHrPkrXX64EpCvYHvZX07vUHAPotbOXu76udv0S0CJcXdscva?=
 =?iso-8859-1?Q?G3W2EgBuQhGlq3KmZF4pCbpL8KCIwconN9rP8AxJHa6sUkuMtAVgDKocpk?=
 =?iso-8859-1?Q?WZDOmOI4tjjhi5vGPsG8fWIadOQ+TL0kMhriKPcUGxcm+s6iZiElXxF+7V?=
 =?iso-8859-1?Q?jdSo7eSAycXuDUSOn/8xeTfsxAVwlW/E3C85nxkRrwi6t7pbmujMW6MY4c?=
 =?iso-8859-1?Q?Ea8aG8cWsUMx/iBSS1283WdYyIiLO4CcEg5ULWd4kswT6gapmVbPmpAYDr?=
 =?iso-8859-1?Q?KiwebA4PC3jb2vePbgAsD31HcbX3PqtKu5dBJ4eoh2Wjx0mBRuo0v+aZ0l?=
 =?iso-8859-1?Q?a0FAvbpdeGQvXhmjLj4MY4l+JfTA+9nKrh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff850120-463c-4a46-3e5e-08dd2fee946d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 14:13:09.5181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlxvMyO0QLRjyo55orFXIULkQsrETIDJi35EM1IMOAktWD7QGKXmd0ILwRFTOQ3Je3JvVsrN1X5CRUNTRFGIlSg6E2AMYv+U/oQfr+etaS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14042

Hi Uwe,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: 18 December 2024 15:58
> Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Biju,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 483082d78a092a3c1f343a76a2edb196069b4092]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Biju-Das/dt-bindin=
gs-pwm-Add-RZ-G2L-GPT-
> binding/20241217-213809
> base:   483082d78a092a3c1f343a76a2edb196069b4092
> patch link:    https://lore.kernel.org/r/20241217132921.169640-4-biju.das=
.jz%40bp.renesas.com
> patch subject: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241218=
/202412182358.9wma1UUE-
> lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> ci/archive/20241218/202412182358.9wma1UUE-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same
> patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202412182358.9wma1UUE-lkp@intel.
> | com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/pwm/pwm-rzg2l-gpt.c: In function 'rzg2l_gpt_probe':
> >> drivers/pwm/pwm-rzg2l-gpt.c:374:13: warning: unused variable 'i'
> >> [-Wunused-variable]
>      374 |         u32 i;
>          |=20


Please let me know, if there is any feedback for this patch series or any n=
ew API to be adapted in next
kernel version which simplifies the code, So that I can send next version.

Cheers,
Biju

