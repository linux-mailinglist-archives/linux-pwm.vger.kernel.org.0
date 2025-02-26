Return-Path: <linux-pwm+bounces-4994-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A38AA459DB
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 10:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3700189CBA0
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438322423B;
	Wed, 26 Feb 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="k3Jq1p2G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAC1E5B85;
	Wed, 26 Feb 2025 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561646; cv=fail; b=iVinheGi9FZfb/fGnzzNrsvsWH2mEpf5qtoKyvlShvjqgscPjDY7nPJnjF/45hYcXD36UsJEHz/9iaeldnoXwWTWq6/bRL8TM+2r6I2lZqurhCMPUBT5tG3shj7kF8C79KWjr2Y63JCaLIs76Xzw1t27AqCyebaaAHmcqb3LkC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561646; c=relaxed/simple;
	bh=S+OG4woGnAi3pcvSc/pbpFBksslNf+AaLpiYiWwIMlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYhAR1k3284ZXW/9WdUBTyBCghfDR7RJG+Ih6G/B9SdbfQ24v9AJkXsVIbyvXVCEsuWU9O7/S6vl9aphUyeDts4+C9g9f6lk0MFMiEM0P7r7f5Tc6T0keX7/2YKPZdU+w/RQP9IMbbMZGjn0+xTjcHri6CbMXWqynb3CzOT1c2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=k3Jq1p2G; arc=fail smtp.client-ip=52.101.228.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV6ztxqb78xdawJIStLuez3cWYnSkw0nVaFNxUzygOSXdn9uC2sXqkfHWhfT2s30KkXgL788x+GU6KZHRljSlp4nBIXwCAvtzwCqQfhXcTvtufhMWTXmTAKmIuK7MKMzYli2826dwydK4wQWymwEHHvY65XWcxuoQvDfkv6KNbI3KtddiIorZ/WYMsRLpAzmaIO3KSoXCQMkxTuH6i4J6IsFIb9cO9lbhGn1dVF3JqWD4rRKs4de8L1JNuKq8QgstYzek5wKYvzt80eUgseflu+Hc/6lI2crD3WPIVuZY6dcDGq5B112tj5LfkEGkpJk4OF/WLPHxfAd95LL3UbWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxZUk1cpPyh9fyT9o0PVQ2hF06z8oJv3C0OYBLhu1g0=;
 b=BDy/neChmLFAJmGHNw56dO3w2kXotgv+SRYeGFmWGXguGoaL7FgOQEJMBBFZcI4/LOheBqK7nLprg8ugfDf7IS0gf3UhveRcS/RXYFpwT2nSon3v6IkxAZbDyv9ccoOUlHsxHj9elZYWK3AJTXArrExR98RFzysQ1OxClgv7+kLGgHrTuFfypMLYx1/UHD/4w5aP4o6ui4eo9Q1qWblJmZnJlGUV/NcK7SEuwEHadUyiHdk8Zmttyekp0cZ+VtPJvp+2v5tSoCfy+sbYWMZ4U5R3US2WKubsv8JsdY1xP9YlRqGqz2lC2fb0S23Jri2PNXnHcjew36Y+4tI26oabAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxZUk1cpPyh9fyT9o0PVQ2hF06z8oJv3C0OYBLhu1g0=;
 b=k3Jq1p2Gvsdsi+GkN3n0W3jGUSELAatzO9FC421TSnA6BgZM2YlAP4Ou4kn3LXSwFxya505bSutgXBTLRZ6z7bdiOvX5xFxHzThD9gh1PV8IUGxIMzqRW0mIfLP5z1ikEYmwgTP2cU7IYnzA9AqHFEYgMeXFTwIB4yB1T5H19RU=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OS3PR01MB7407.jpnprd01.prod.outlook.com (2603:1096:604:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 09:20:40 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:20:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: kernel test robot <lkp@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index:
 AQHbUIfEye5JKGoBg0O4godryy/UCLLsKj8AgCDikqCAAUJZAIAAAFoggEOPvgCAB91nAA==
Date: Wed, 26 Feb 2025 09:20:40 +0000
Message-ID:
 <TYCPR01MB11332CCA52D52AA982BCDBFA486C22@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
 <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <hb7agtiqcuotiie646a2nzwg2cfwmahtgzzexxsf4tqu3rztf6@qqq2a7qkazh5>
In-Reply-To: <hb7agtiqcuotiie646a2nzwg2cfwmahtgzzexxsf4tqu3rztf6@qqq2a7qkazh5>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OS3PR01MB7407:EE_
x-ms-office365-filtering-correlation-id: 71ef120d-6fce-401c-9e95-08dd5646d663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?g6oxEk1anjkMWEscXX+PT0y4OguHGLgNisReQfOKz8xQQJRIcF1MkOw4vv?=
 =?iso-8859-1?Q?RZVEAUyulxN+vRYWHi/Gi+Q3AQsUfwOPK9WFlq8uuIgx0fIyHlkh2vgHvp?=
 =?iso-8859-1?Q?HHAJheUpIx9h4XSYA3P6DWhmEBAm9W8rQT8jnp7U+CiFAy3yMaXC708Ruz?=
 =?iso-8859-1?Q?I/5CvDNl/Bp/GdhW04/5FEwSwDIy6Vv/YVGmMbD5ojA//wl2Ez6K9Bw9VR?=
 =?iso-8859-1?Q?6zctwnuMtYWKvx0kfl1FtjI5MWQxX6Cqjg6qoL8FyShxEOTT8Pb0fjT4BI?=
 =?iso-8859-1?Q?RWNWgopqKIGGN/Lrj9fJoK2JVuiArBO/U4ySDkewuD++2uMC3mF1awCFLt?=
 =?iso-8859-1?Q?Jl2J4MrsqDTmtXVwQcJwoDWosKsB8y/GukYeVjZ/YNoX5rG7LiNA2GquxK?=
 =?iso-8859-1?Q?vt7ceNfDH0BIW5NbWVmdXoMzVqVIKng9bOGRu8xwPACgOXHP6bGgOVZPpc?=
 =?iso-8859-1?Q?+NhTAp2kA57D7s4ONLvXRHNRAmXwidYVn+JKXDKhNj2WesXtVUnhj/S+t9?=
 =?iso-8859-1?Q?zOdL9UU/uJ1OPBWTCu6nfIhZW0Gf3xRAUVkOlcjChhH9x2T/ySKnRLraan?=
 =?iso-8859-1?Q?BWPYgzOMotUw7eo/IX4NtMOIcb60kKXwIHyPqAsvX3AxAUrsQVhr/orgsy?=
 =?iso-8859-1?Q?S5iA745d0zV/la054I2kpfA3bgNkFxcx+cKqcNWNMBJljS0GdVulMgXbBQ?=
 =?iso-8859-1?Q?bQjR915aF7L4IxlcOlaPm+50aMv4t4KDm0FRdmXAulyFHETbFgS/fGQofP?=
 =?iso-8859-1?Q?ebstMk513+H1tiZ8SzpF4NF/iiehhIxNaU6GWGiBruYkQnHgRs4BGZtYqZ?=
 =?iso-8859-1?Q?o7mzh0eXhq2TD9xzm6bypvkTyY0chlPKCe86GXkV4r17wdVZlBHIuoNski?=
 =?iso-8859-1?Q?nEjDif9/N0Y6ESKw/0ExwHHgG5w+VIPBYqCWJaSNATHevXSlk/bAunocBj?=
 =?iso-8859-1?Q?74ZpBl+4VW3oddT5mmX88fj9KpwiAN1gxv8Hw2a96OCJf2op9B/bZYaGiN?=
 =?iso-8859-1?Q?qKzdD9M057xUVtRhA3GcCU6w+/N+lPGKefhUVie8nGTxMFIbNP7rcAikSb?=
 =?iso-8859-1?Q?b81lq4YEA3N5ugxT51ys9925hNZ1NBZIOC8EBYIxJfsSUwVD9WEutNFTbl?=
 =?iso-8859-1?Q?733unvnSC7vLEHLXaKgUFxRViJVSBx2IeSOrMwbO/LiXohalXYgT3fLaqQ?=
 =?iso-8859-1?Q?dL1f+YcDhpL+EfSmXLm+YkmJvyl1gob4CCG+J9Bf3X8smra1r5SrsKbBIb?=
 =?iso-8859-1?Q?dWoKaCQNzfuVOYJBXTIGYhayCTx9b2tIDxVsqZvA1UaE+IDoPPvfDxCf09?=
 =?iso-8859-1?Q?XE2Cy757ItUHZlS0ueTLRxpzMVJxmddO9ESUSK1RgkEosqNObRZDvOI1cw?=
 =?iso-8859-1?Q?k4GQeQH2usQN5dQjrLcvJrUKqyreSOkFQIDSwHmOCNQShMScKQCK1xj+4G?=
 =?iso-8859-1?Q?Ea7GqgRMtMSPknhezWtymz/m0lQkdEn1SDyAZ5E/Q1Jzxl6Q/9F3EMixl/?=
 =?iso-8859-1?Q?EduX2VDO3+bpLVVJcFJBYj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SYhmx1gKiqvHLFeEzzgBDqVRBLX/qTPrgwHYY08tzoltuxzaayMdiauoDf?=
 =?iso-8859-1?Q?CuAvMAQfVuxHDIp0KCpTTeU9yPIs/Vbw/l8rzl/kWScQ2GeWbrbp6fIVHD?=
 =?iso-8859-1?Q?9T90mPDcmtoZw1ibbWD7ZB5J3oLLNM0SWXbUM1zOuzB1yOMoRBRB0YiUFe?=
 =?iso-8859-1?Q?hyleAJa0Eo4kp1lNPxAbNZyJF1MeBvRV1T28yiUdIrytEqB1brBTucwKL0?=
 =?iso-8859-1?Q?Z1cQu3ySadsyP7WuY3cU0NhXLJczrqXvNYF2047CSLAyF7hsM07spgyAUg?=
 =?iso-8859-1?Q?P14WpF5wqyWKmxnkES1phHsHIUMoiIDrPYqmfEPLOAqNWWc4w0caHgz4S3?=
 =?iso-8859-1?Q?mw6ojrFYlJwCbc0VSYGWBblMThx3Ch75rY2jiWh9FMabzDYkxWl+b+DBVV?=
 =?iso-8859-1?Q?yEkXrSkYUxLJmQQ/FbrMysMNO2S/VHfcJOnXPI2Q48zX3EJ5TMINzZdHFx?=
 =?iso-8859-1?Q?zBrydimZyyisuBtubVoSSbN4UXslw16GTzXkigsNU8xBqY8RfrJp0I0XSf?=
 =?iso-8859-1?Q?/zB4C6Bzt08YEvKxy7y9UZDDYmFFLH1KeOHK/LLSwuM9wJCew6nTKc0ITT?=
 =?iso-8859-1?Q?RCFGl9P34lZJ52uIK50kyxdeWNCdsFIjhWe7jgacaqVKBCoZwU6IU2vAbm?=
 =?iso-8859-1?Q?la3jUCICjOPgOYd35t3VnpAaZRFh5q3Cw5m74CEj9hkOfheuOaQ/MkGo3i?=
 =?iso-8859-1?Q?gic0AD7tHna0UJWIRPr0uZg+ZKmgTbePBqiiqrEPMER5q7NPK9bVl/E45V?=
 =?iso-8859-1?Q?X6aSMhHq1+gKCXWLy52quinp99ZTjRTaTGQn6tcMSYmQ5f84NcJjkUJAwC?=
 =?iso-8859-1?Q?pAcMTClBdF+3q1ziZ9JY7oxrcv7IvdcuHxvGDzPQPTh2ZVEn5E2FsXijtl?=
 =?iso-8859-1?Q?IN8EkbIj5Gkv66OcRCfeyamXg4+im5VBBfEJSu4d1pYiCLa7YR28bseOQa?=
 =?iso-8859-1?Q?YgVICdaZxdpNmo0dQlmz/j2uwDsS1g3zOdvpOvFILSrXDdyTbIdpGdeZjh?=
 =?iso-8859-1?Q?aEMfS7IV0torZ4YEtacCpm1NxSHw+1D8kGD2K0qfcN7dVZjM7T1iHgqrrt?=
 =?iso-8859-1?Q?vmK2eFoR8VoqRReL6DpshB6aNHlcmJ4J26jlGZZaW7ej+9MhtcYD6Uvg9K?=
 =?iso-8859-1?Q?SiHj6ZVGXBNIseBVPz1LU+Gmqbf2giOWO7nrH5QoH8jlEZgoHVwF0LVzS/?=
 =?iso-8859-1?Q?6+f4V3Oy9lBUlSAYi4jR4JB4Wzfg7GcCoK4z05r8JVSbkwRJaW6OSXKe3u?=
 =?iso-8859-1?Q?ElVdvDZXc/OvhCY0GDPW4wVt5mIFg3lubVvskJ4xYOiMLfes/y8a8nLpe1?=
 =?iso-8859-1?Q?iEpRPtj0du77moMfYDC85TLQXT2jsRZhvHn0QONoPTcDEOrG6Gs2UtdfqM?=
 =?iso-8859-1?Q?qkKVdNIqTRtJFRjOVXKfNtd8k8Pgf+RMwsvxFLkIFrGz+vTChlTbtNUXSM?=
 =?iso-8859-1?Q?+niAFaD9E2DcmKgdcPUIsPsZxHjTxFgyNQEdj0PJ/WgAi+bIM/iV/n/dTB?=
 =?iso-8859-1?Q?7EJvih1F/d09O2euuDWEti15wgYK9YqbJVL3JBO7cpxF2uWRnSvwOkB3ja?=
 =?iso-8859-1?Q?LUQtz6OPpVfqu9i3a8XcpL4UVPsPQEh1t+7blfMXaSo94qSZYR0vM1oQZQ?=
 =?iso-8859-1?Q?j6GdxkDFeZKz7Om3br9rw10k1BOpqhgqD5Wo38twQqNmXZHNWgSAldYg?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef120d-6fce-401c-9e95-08dd5646d663
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:20:40.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OuO+73a/whfHL+akTxECjuqlLJPzJQg522jEqJfSag4pakUPDHklgiomhEIOO3a4f2BS+2FtygG2r9NNbJodRbTmh5RjSfpE0LyxDF8uok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7407

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 21 February 2025 09:08
> Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Thu, Jan 09, 2025 at 09:32:58AM +0000, Biju Das wrote:
> > > On Wed, Jan 08, 2025 at 02:13:09PM +0000, Biju Das wrote:
> > > > Please let me know, if there is any feedback for this patch series
> > > > or any new API to be adapted in next kernel version which
> > > > simplifies the code, So that I can send next
> > > version.
> > >
> > > I didn't look, but if you're ambitious you can convert your driver to=
 the waveform callbacks.
> >
> > Is it ok, after the acceptance of initial version, will switch to
> > waveform callbacks to enable the users of GPT(Reason: lot of customers =
are using GPT for backlight
> for LCD panels)?
> >
> > Please let me know.
>=20
> I'd still accept your driver with the legacy callbacks, mostly because yo=
ur effort is already that old
> (which I consider my fault mostly).

OK.=20

>=20
> > Is there any documentation available for waveform callback? What
> > scenarios we can use Waveform callbacks compared to traditional one?
>=20
> There is no nice documentation available yet. The improvements include:
>=20
>  - arbitrary offsets for the duty cycle, so the active phase doesn't
>    need to be at the start or the end of a period any more
>  - consumers can query the result of a configuration request (before and
>    also after the request was issued).
>=20
> Both are of little importance if your focus is mostly backlights.

Mostly RZ/G2L GPT users are backlights. So, from RZ/G2L usecase point, lega=
cy
callback is sufficient.

Later, I will switch to waveform callbacks, for complex GPT usecase support=
 for next
SoCs(eg: RZ/G3E).

Cheers,
Biju

