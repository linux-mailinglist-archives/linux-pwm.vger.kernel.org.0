Return-Path: <linux-pwm+bounces-8421-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BfbHlWIymn09gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8421-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:27:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2935CD04
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EC1305E30F
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322673D7D92;
	Mon, 30 Mar 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l3C40f88"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BE3A4518;
	Mon, 30 Mar 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880461; cv=fail; b=rnS1sC4b3lAC9/MlsuxcQZpuX9zSS6tO0BERm1rHufQcDmi42gss3dA18geqtivp2/7dCiITeTlqwTr6DzT1pFvcsT5li0uDxm81s6irO+e2naUbRrvztqyLVg+t/FyS+UaezB9jCgp9OAkLeYelvtXQkJ4IoQZSfWjaZ2aVw6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880461; c=relaxed/simple;
	bh=vBQ7r2vPsaifNbBZoaHwvqixWE7VQl9rCVCbvhTB5sM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwNW4k7nK7ByKWMxksJqUeoqv/V3BkgrmZ9Jgp1eEO0wOzXutCHpwE2lqJWEQhHnf8wbKAigxUm4i+VqN/ra7qeNO2mAyGmtXsDrqaZUmW7S9dnuondDVeIWZYdGi0aeTT1bhDjV5ERl6AOsM4FYWZJiHWFMqpMyjH01MbrF8AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l3C40f88; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAw2vR3972697;
	Mon, 30 Mar 2026 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vBQ7r
	2vPsaifNbBZoaHwvqixWE7VQl9rCVCbvhTB5sM=; b=l3C40f88m0Swu7P51Cmjc
	kTl2alpoi7tphFLsuvjOj2N/xqkrdsi4fGMAqVPdG624Y92pU8jVuYxUQChAUzWB
	KY2ShRLumBKEu1CmztR36kRT8SmwfiR/pjX1vETpzHnfWzDLDde8qwYUnX4kutR1
	U1m8+KXi+DDZvPSoHz3dU+HU3mJtes3WUqkMGtGnKXcuhWiSqp6l08jTjEkPESHN
	09ivj/QXvy6QMtUe2vIKwg67s5+dOkBKYGui/BV/Gz1i21mmGu6DM6Rs3GXCVjcm
	gqpdkXUdtytV6JAEU19YisCuXgTQwIV98RLjQHn3q8RZIFaXbd79gcqrAqxcEOKh
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkva7nq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:20:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7W3eGzDrJDgkx1OASYnhgSJyEq5BADrpnLyZ+RwLsbStwJ3p+dPlfAaBimbO2w16Klr+9G1s6r2T5tmIqt5tqbgO6kT+ND6D35nqcvk1PK7ocEj/B2KFS+SBTkytIiRVrD3EGkMQnJGZw+ltwZ6hX2CT2/Rv9Akm5LkmcDyaW39fniptcIgreQuq7ssmUCa/fd2EtR1p0KZmuvVjIFzdjI2zr/SwJPfLF8PgidWmh+rKAxna5/uiWHmjQZ5DzDvsMUwtfhCXYy0EjCRenTEvcDSkpXlWFUiRpIJo2a10tUDkGEzHXwUoD22dw6pxXVIsLBAsXqoZgBk2wYGX/RMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBQ7r2vPsaifNbBZoaHwvqixWE7VQl9rCVCbvhTB5sM=;
 b=nm2YUjfLBPOK7k+glYC0gvyeWgeZry3XBMuA5IchMxibr+cXjuTr4MTZXBxKyfTLDrAnYpKtZvTjsZQK2GVfaP2dnzvqiqvBqYdm0RPJmtW1RzoCeE9reqxxasG2PZ3ZAOXD2MgrKmBPbTlrnymyJQl/PNuHdWnYwqxLikNNiZ2che4eIr8/NmhTxuHuzcISF42suXDSD/5Sul3EWudyG4+1Uzfv/NuqRzaQf6ajgiDY4FI9yKBp0ds04g38DnlK/5086nL8kyUT3u0Ca5YZ4FpNDgIKdbcyLJ7JNg2O75UJlHFPXm5CwSZlhF1G4qJdimmyOmbf85KpPsKgtHRX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH4PR03MB8018.namprd03.prod.outlook.com (2603:10b6:610:236::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 14:20:27 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:20:27 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcvdoCw4o9rbwX3EeiToji+73F0LXCQCsAgATiWGA=
Date: Mon, 30 Mar 2026 14:20:27 +0000
Message-ID:
 <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local>
In-Reply-To: <acZrthJYQX-h_9p5@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH4PR03MB8018:EE_
x-ms-office365-filtering-correlation-id: 8d3063d0-8a3c-4da7-60f0-08de8e677dbf
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 N6svVxx3X+/0vhzNOhBe7XvV2Yl8EOIfef4DwtMmPyLQLtbWZ3trZnuDLDscvgZPF/9k5IT84pJw3D6JBfh0bRNIrn+7HqZpn55ayhJ2ZanqhLdTnFsXkZF9RdSJyJ4r0aJYSJUqtteUTOiLagRXZ374RNNKeMhPLE3IfjMIvWPPFp7bYm8inBV+WzdRf1RgeFZyzT3oN9skuWDLJO7SAWUuIF9OIeqsPVAdG2Vr39UE5mcQmt7Kk8miNqn2b3gt8011dIsrIibAooTfMX+KjpHPGMI92Pg7jD8TfjG6YBy/lU8XDgqdXHwbo2ZQeuHwJSTpVmuDwKtyUpOLcwzbt9bpZQdpi2HEqCT0xOQXwqzo0QwBMHWe1VoF+AfUKZEwce6wlBa1ptVech3nJL/iVhADvKMWJrpNWesCme+kDkaMsgXpXpmpfIXsoXOgJOSnHLcJ7j9uETYzyfI8ao709MBoXfH+WrZSq4SAo7/dsOx1UcC5/eLkK/QJepFavtg0pNVt0Bb10AP0zD+XdMaAVQpFkFwPzVgQA6FBnqYYgsZoYoaPcUuHRUWNJo9pLhp1HPbRZnrSQG02tH/P/hu0sc5prOModsXccfCYrzFMTOFcYtKxv9l0FZUhxYCPuT39pjCpfUkrWShTN4yZI5vC9Q5P540XS6ZtMR8M6AaM9Xiz1zs4aOGSPZgH16J5v4UWNjtg4cNFiphrpPRrFYUCYKMrq5y3rdcYw9d3PgCXNb7Rx9z6M8bQtlSmIo8an1Fc9bbA75qaAMuwcrdupt2s22LmrFfzuRSrxR4Pjs7tOBo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ltoLCLPtrPt8SYnA6Do4NNNNijKDJpTY9krDzcbHBkHIglHedHfhQsH4ir?=
 =?iso-8859-1?Q?bOWdIZc11UyAMCHSrlmmsGg+kLekjv3uNMQgGAUIriB4nvXeJdudyH+B6L?=
 =?iso-8859-1?Q?GcyiUsR6lOUJ36PPf6kgf9NmtGrfDyjMWbZcX8RF2Mp/BnSNvHfUrPgA3S?=
 =?iso-8859-1?Q?53KI9DN8u869roDqLaLNt99/ZyvaFAWBA+ADe6g6+MdO1RA4avJBTZSh+G?=
 =?iso-8859-1?Q?UdQdc9fESQpiEgbJ0FUSDXQUSwQ4cnqbV3lZ/zmvnKlQTIl4VMsawf97s1?=
 =?iso-8859-1?Q?+JP1uUAH8YoLjm3M1PVIgrpBx9hPOoZ8pCa65M/03HpJ8Ls63S4MDUklPm?=
 =?iso-8859-1?Q?XkMsmYRbf2pt4a/hcLtMEjDY7fu0yWQtxTSAq6XM9bfB/9N5H8N06ASkpa?=
 =?iso-8859-1?Q?Yq/T45KsWzuuIiNcOTmCnzSaytZq20d5iAhAs6a8Ly9zoV/WvOgP6JlaK4?=
 =?iso-8859-1?Q?HezOhaUGcsM5pSBq1q5CfFJZa6fygcORKn2vzkeJzXKq3v4Zsw9SAFHIF8?=
 =?iso-8859-1?Q?H90/FZ+L27+aIecQBtl3EChD98q9TwCHZ2IjFwaSqtGDBB1B3gYbbB3X2L?=
 =?iso-8859-1?Q?NiNKkIANkHtZyhAmTFnm+jHG7qRfZ1oPvKhwnx4ePm8cngLv58MY1dm+k2?=
 =?iso-8859-1?Q?UGBRjA4wNZ5sODleaDmwYwsGZ+l7lS51THW7T9W3HQPtOpCPwmp8d1gB1f?=
 =?iso-8859-1?Q?zHkDZGWwByHMUknUdPvWtfcZb1yXKbC6zf4D2OE2dYc8lISMTR1Jqy4los?=
 =?iso-8859-1?Q?bjnKdvnz9cNg/J75fuWLNu2vPbc8M0dv1UAYEDmsHCl9R3fRzc4sqTOIxq?=
 =?iso-8859-1?Q?t+ZIeaa7UwdbPR+DizKmPTnOobV+9zdpI05Jiw/1zCz+TKQAD9euFf6T/H?=
 =?iso-8859-1?Q?w/X0pEujcyoUGTDSYxKSl5F82V7KlumMWKz7kZ2gOHh0xkKvLuJHqHWCLj?=
 =?iso-8859-1?Q?VXDI0fvPj4B+Ozo6KVCgpVMEDda7O99YoqBGqNu6ilbsPfCrIg8Q8XAzWd?=
 =?iso-8859-1?Q?QvVrx3kD5idloqQoaOkNFwhXa1fC4Umm7WJPTh6PzCDodywLvD8PohIsP9?=
 =?iso-8859-1?Q?A4EISYNVAvaTkj4Xz/uUQ5M4B300NvwIvGwgTx30oxtP9u1AvNk3qzEkot?=
 =?iso-8859-1?Q?VWIFlF3mxPZS5LkGCrndMCdwMbOtscvQaN7+M8xk1SdTX2TGfR5j9Qg1pZ?=
 =?iso-8859-1?Q?Ks4nXkSTytcLyVmebx/tKpwAdVo94pceMqpNX25TweWt9Sqjr5gfHEaL5U?=
 =?iso-8859-1?Q?t6pMoPbNXPt5cyCoNiBA+SBkJnbMgsAy0eJ/d0Z3t9cxr9iNrWLnlsMSKF?=
 =?iso-8859-1?Q?QQZxG2rxOgrvz1IYoj6+gBHBXBH2svd15G7GgWYH++tczpJGldqCVr0kkr?=
 =?iso-8859-1?Q?wg6IfqDzu/e8Ixq5CphdgpBuDIanhHsZmFcFZJHeVoSyxq/oE87k0VpH7Y?=
 =?iso-8859-1?Q?f7hYG0aAmaQbb0cPfVxKuirExbsmkB4neVgbsXEtNRMSpvul8QlwiXO5tT?=
 =?iso-8859-1?Q?HobEECCplNdl7QEq9iYe51aB4XLMBhc+UVfQua1YDyli9QbP/9BjVEHqHx?=
 =?iso-8859-1?Q?egRUKGDvgaV+G1GGxXI2iLRjJARPXYkc8fsz0CrefTA2jhbb62qPLyrQ2w?=
 =?iso-8859-1?Q?Agld5OtZs36VhiQP4fTJcqJ27++f3X84u2tlErw38FWM+76BEcfMKPyi5g?=
 =?iso-8859-1?Q?GVw/r/Hfyjd4zHjrRR4H/2EjQYHm3YSNWUm6ZBpGUNSXlkQ6WPZOFqxZ9i?=
 =?iso-8859-1?Q?9AhZz72pCK7Lk6xuOzmvAywgZUrXy2auz3fgUAoJNihRr0vdwISg1zkItQ?=
 =?iso-8859-1?Q?qAbrcgM7Gg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	uA86lk5/HCG7VbRHPu8F7djmJY+xQM5I9zjwNnAXzIvMC6E2rFNebJYRWTcmeKn1dhTdL78B0urfik2GqIIc/yODQjWSMis2YRXoRLrP/3SafK/9M3feGxO+GDoKCcC+nRE1XBR0Cnpkf35JSOb+tNk2cYYXGfnnP7fdKW5ei6mlSOdoeq47XVPcpaqwbnEtTAyvtQZPl4FYPvnfI/8747zKlPjTEuRHG0g0t9P4UkMxSgw01oTWcAMpLKICtaKoiaE0hr/m6lbsB3PojRvPUWJIXtdzR1PmTgjMTJjgxhV1zcXgSYkWzYYW6Yfs/Qox9Bm1ExhWhkDl/nENjXQCiQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3063d0-8a3c-4da7-60f0-08de8e677dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 14:20:27.5400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXKan71K6560KZpc/ekF7+qfqid/h7CgZlD/gyFH5ngg7aFU2QX9a8G0QH69nc95peowpYEzYn6CUiaBXsbNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB8018
X-Proofpoint-GUID: mdMzV7nqP_aRdBTcUwF5BNz4a-Ie6K96
X-Proofpoint-ORIG-GUID: mdMzV7nqP_aRdBTcUwF5BNz4a-Ie6K96
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca86b4 cx=c_pps
 a=Kac4Oh/pgoirBk7HbaAweA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=dnFdfbny24WZlfKQ-RQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDExMiBTYWx0ZWRfX3a1laztfAHFL
 oJgZyYi7eZDaU6ZCb+Qz3hNWp31LUzOc2eiJdj8LRQU0TgNk4YSPb/8T1NG1BGXH9rAFm9ZtBJT
 wRcWNvk2/wLrnCP369zAPb5Ujgsm6NsK3n9rBle0NTviKzUmaG7IaZ/XQ2IFvAm0MZWdxtBFlqM
 SZh/icEZ9UKRqJdvpedmEJm1taj0dP7uLzNgoQALW4d+ym5YyJVfSztLO5uh12lk69pi8lp/NY6
 18xzAPXsyZCOUj+l7WY/cwRNv371L2zvu4V5ecnBoZILAMImqlZlP27OEGXZoAXD/WtJAWMSVmh
 qEJ6axmkAhHog6uzA7qdkxyDmxuG2pC2kBMuuc1CJsHUIyh+NiaksZKUHGpgI/aEbrqbjKlZJAg
 DQ9r272Vpr9jS8qaPi6JTT2h1zc4KLzKmei3jvBcqfW+c72ZkIiMxyTmtl+gppr+kDGxppHrTzu
 AlqK/7GqLAMe4zRNWpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300112
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8421-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:dkim,analog.com:email,intel.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 28D2935CD04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, March 27, 2026 1:36 PM
> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>

...

>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
>=20
> Hmm... Is it used? Or perhaps you need only
> dev_printk.h
> device/devres.h
> ?

Hi Andy,

I have checked this out and it seems device.h doesn't actually need
to be included anyway since spi.h directly includes device.h, and since
this is a SPI driver that's never going away, it's covered. Will drop it!

Thanks,
Radu


