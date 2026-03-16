Return-Path: <linux-pwm+bounces-8272-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB8aOA4UuGl/YwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8272-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:30:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9C29B678
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EACDA30420B7
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CC282F29;
	Mon, 16 Mar 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m3FRl39O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613827EFEE;
	Mon, 16 Mar 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671379; cv=fail; b=GV0cEPwyWlh3IkKsg4xiDWqIdzZWBr1vJ86a4Biei/N2Yy22BKCmTzkt3ApEy/P0htCWAMQKxft3MiGU5gpTNmJ2EirIVWbJa+QWgPUSwydIuBUUkVvQR8HVun0cy+f3gUzebSecsy8u/+E9UizfDKZLCO4NF/swTrZwi/5z798=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671379; c=relaxed/simple;
	bh=gIMwZuNrzLy4IxPmzsUPxyoPcQ9be7BwGS6EeL3YqlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=swVF3qxZZiFPv+5ymC3EvIXGj1BImxBz+Sv2WzltSwQp3Gwv1LMJMDa+1cGOOoMgvWS/n6J8Pc1w8qMQfz5y+8/Sq1zbkdU8IU5Hr+pHTbv5bzi3bCuM0G2HWULD+Qi/XZPF5NEfDFKFoV5N30YaqrlacBvBto34XaNUIIO5GzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m3FRl39O; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBeCdw2122571;
	Mon, 16 Mar 2026 10:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gIMwZ
	uNrzLy4IxPmzsUPxyoPcQ9be7BwGS6EeL3YqlA=; b=m3FRl39O6XiATRlB4oo78
	+IEglbjKWqQS+SeXzmtccnusm9xlNI70UCotagCzKlIZiZhjrQ/iyABpHsYcSzRI
	LOrx74V0lt2hd5rMSKYj86mIWB+iqQUfmWAjazCunGfK9iiPrFPDwLV3udrHrzE8
	UkYvaS5n/nZDp1aBSLYmEipOJK7Y21jVgjq5DKWbdGaT8ykUt+vemu8r/FCBL0EG
	ay5tQIoUwwqNyuTsTg5t9PxgD0H8owzi9DoF4wnLshAeS92yz4zQ8SCzmICx1Frn
	aMLkGB8UWcB0GYKySxioxAFdGq9jLDpX2yqtu37jxB/g6VWEERXH99ZblZIsP92J
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1fkat-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 10:29:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC82X7zulxdYx/y0gIvAggsmpBpSPDvFZXaj3LYyrbxFl9NmqBgq04KfEadr9xdIWDkY/LCudYvAJHwOP8m4sKxF2ItCVNc0tWpsBbD3+hSXTHYuUJh1NAx3Q/3FL9D3XdvRymeNgd8EKiiBHObo4Edd7Z072uJF8M4bFFRkrRoF2SvVwk9eEOOwB39UibEFvyjALjSmUM7PqH2pBKdUW7XuYJUvH6Nnd3tk2u3HQbVKdItrDSSAG3R/ss8XoBFuAJlIJwji6BrlBnjcTApvx40wNu1mXeX40+ifKQ91XUaW0X8lCeK0GDanzT80NqqTk/UmEJA0U9F41ZDOFuAjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIMwZuNrzLy4IxPmzsUPxyoPcQ9be7BwGS6EeL3YqlA=;
 b=bnUKGqIxZyXfKsuDBO8x/3J6uEzQ7gmjOAgmNZ0afqOkISq+ZUWNcFphQLmM9TOR1TQzcpt3h/rS1S4m4eVYrd+xFhpnwrIYp6Vzcbn7pKqdpl6U1mPKXmKS1jk5gcu/7KZV9xlscuCmrfkaYpovYrr0wZJEEt6VcMCNbFiFp3y7eK7E69lBeN7UcTUCsITZ1bOAfFht8pttVA3BRPvopIba7REALpRWBX3xNTesArXhc8fJK1vADQpj+Q8HeWrud2oDd4U+9bGpdnooK//82p/qmTHh+b/NQbX3jnnEEiYJVL6UzNQBlYAryjDEUsxtVyBrz35h844IbQwY23h3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MN2PR03MB5102.namprd03.prod.outlook.com (2603:10b6:208:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:28:52 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 14:29:12 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcstE9wdxbJGrMMUOmE/HdBho5IrWt3ymAgANcjiA=
Date: Mon, 16 Mar 2026 14:29:12 +0000
Message-ID:
 <LV9PR03MB84141EA25CE36ED760E91A7CF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
	 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <ccba355fd43585a9b0a2ae4a54ffa4beaeb3bc71.camel@gmail.com>
In-Reply-To: <ccba355fd43585a9b0a2ae4a54ffa4beaeb3bc71.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MN2PR03MB5102:EE_
x-ms-office365-filtering-correlation-id: 7758bade-4f3c-48da-b8bc-08de83686508
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 SXVjX2L8T7Y2j0PMh7KTo8p+CT0GftJnB4N2bH/dd/UFoqWzkHZ+DdRKyrYtZYEik3GRH9y5xu8bYIyZROTxAeFuujrA41iH2HGTkWlCFRm/YgELA1i3kyCZbcWBXeRBaCi4ra9SLaQ0Dfet3WQjNW7kiPGUpFdkM4324+UApcKY2b4i7dlmfimF+kkPd9xeFwioogtE1qXw+sdeONIkN/f8WDh4mXzurD7zvwkhscOO+juRS6H5jdi3aUd0Z3QF5ofn43bQKyFDW84I3w9L+esCKnfBgjo2WlC5dARCK0f3TVUnqvm7J7Nz+6nHOpDb5q5zzLpqVh1Tn6w94Z3HdoT3yup51/lAQO2ujeGz13St8yeCOqq+02W9DglztoZrKfMRuspkn5r6jCd9+zUyEnKOeOZBk/9avMynRabNPkdGlihwAmBJqT88/FPdPtNb/OWExNEZwu1ZrTYK0+JL4yHG8myBj2QScSPuv4A4hhz0ao8iwDx5vD3+NR3kRZrU314V9DmoWpZ1xTT6mLseNjbjnPlyE1u8p0KccYQc/QlcdSter3DjX/GaK2mE3wyjlug36py7blLbGldSSSuYOnKu31eEUkJFB/7myh4DCCX6lSfhEJeboBWnZ3BDMCAcoGSVFE4yDbcPYVFNCvFslsmRquZkCeCbCQXUdiNFGkd8/j2HnQXzOdHxemJe701dPV0biFDvtv4ajWlfsq3k90t0PcmfcxYXr6aaVvjSRmi36diIAlE76Y9bgUW6JRNX2fAYZp2zE9f31XUpgQeHCB4ecOqkv6Vl3KXtNS1FoZijor2W0KE2wYMH1Bs0VXYC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWs3ZmJJWDRNbllHS2UwT2kraWo5VlNGMmZPSWg4d1dueTdNQXFXZFpvQUZk?=
 =?utf-8?B?WGF1d2N2R0hndCtFeUtIQ2tXcGgrZnZWdExNc0ZMVFJUakJTQWRyQkNQWHZB?=
 =?utf-8?B?S1hoUndwdDdnRGh0c1gyNS9hODZGZFZJQmJtbUY2SCs3elRHc2oraHgvc214?=
 =?utf-8?B?emFvY3pHYXpCU2l2dllkNzBtZ1lubG1kMVJ1a0F2WGpuTExJMHhkSHVwTW5u?=
 =?utf-8?B?Y3Vlb3VDRXQ4S0tlR29qVmkvRXZCTnN0Vk1lUWRIamFkVlUzb1JRc205c2du?=
 =?utf-8?B?Q3orZFZxQWhuNllRUkRGbEt5NnJYNW1URVdJajZUN3NjNzgwbUQvTEtGalFG?=
 =?utf-8?B?aTBSL0o1VWtybGpBb2h2L0lxdGdxK0pCcGI5aUt0YURIK0sva00reWdxZDE1?=
 =?utf-8?B?ak5UQ3NobjZtWjVuclZSTS9GZGYyY3VSOGpNZzhkK0ZjbVowZWFQSlpzTGtk?=
 =?utf-8?B?bFBRMkh0eDh3OGlXdEQzRzdzMFZ4L3hQdjYvdzZ6eGkxUEljMWdxUE5IblN2?=
 =?utf-8?B?TGh4L1lBczdydStITUlWQTNoK0dCNGxVYzllZlpDZktXWkVOWGVzQUd6ZkxL?=
 =?utf-8?B?bjdpb0RhTVVpMzI3UGVwSWpqWWtMUFVXMmt1Q3U4bDlpTis3Z0FGSURTT0Jh?=
 =?utf-8?B?Y0Z4UnhRcnoxWm9mYWppU3BwZDA5MXB4T2gwZ3FLSGVtRThwbWx1TDNyNFVX?=
 =?utf-8?B?N0V4U2ZXNytuR2pUVkJ3cnAwczlJSzZvNHlCYUNVUnFyemVVSFdydlhzeXoz?=
 =?utf-8?B?UGlJbm1UMW9kUzZUcUY3MS9vMEd5dmZ1OWU5YmxwWjNiNWtDY1lYWHhJNlFY?=
 =?utf-8?B?MVI1Y3F1YllzM3M4eU5rems3SGdFOEhNQTZGb0FlQW1EbE5CRHp2cEVoV1Zq?=
 =?utf-8?B?STc4TlRlTC9yZEpVaytpendrVWppdkttZGZFcm9QaVRXODFqblgvcHJCd08y?=
 =?utf-8?B?Nm91SkhyYXRuUzZCV254ZHpDbVNvOTdtTjRxMUJ2cXhYclJyK3dXTWpFeER2?=
 =?utf-8?B?c1F0NWtDRStiNGZBVzV5RmpyY2RodnV4a1VTcmlibVYzV3pWOTdLVHBSbzJ3?=
 =?utf-8?B?QXlhODhyZ3ErTVNhMnpucmJDblFIK2RjMG1lV0RTSXhNZjdVZnZQN1pKbDBR?=
 =?utf-8?B?TVZZUlozRS80OFd2aHlwQUZEaXBRaWpIWjN5QW9KQTZ3RGRyQXhnQ2J4bVVn?=
 =?utf-8?B?TFNsQ1htNmJQYzNQT1V6TlBta1FpeWN4VWRSRnpFeitCYW1CZXIzSTZnSy8y?=
 =?utf-8?B?czBUYTVpdCs0aXpxRk0vTUNadEpmdjFnSjdSTzR2RndPNXFwZDUvdDhCWU93?=
 =?utf-8?B?azFUcXRDN1lLTkp3a0FkY3RpeFhpcDM3K3RFS3d2NlVpWmtySkt3V3k5N0Zu?=
 =?utf-8?B?amN3ZHFWVExWYmdPMXloWUVIMkRuMk0zZnoyTmJpeTY4OUZGWFdITURKRXIv?=
 =?utf-8?B?ZEdCd0RvaEFJcDRHRDhmZENUd0xBUlNYbXZzRjA1Zk8vcmtkclVzNWpoYm9L?=
 =?utf-8?B?cmJDL0Z5dFRrS3Y0eHBSb3poOXB6T2VpczQ3Wld4WTlNOTlUdjROS08xZVAx?=
 =?utf-8?B?a1U3bEVhZENWT1BVKzlnMW9GTEUrdjBxcCtuMzJpKzdGUUVrOXdTSEt4eTRG?=
 =?utf-8?B?Mll1MzhYN1d2MzBhNytNVWhVNWxPdUd5M0d0ZlVha2tVOC9GY3BWbGhiR2tJ?=
 =?utf-8?B?SnZiV3VhU0FJeWNtcVU2ZUdnbDdtcHdqS1RadG5zdVRybmdmSU95OWJQOGN5?=
 =?utf-8?B?RGJpU05JYm1HVkZodG1IL3FKT2FaRzhPVkR3Y0NEM2ZqWlVVU1pvL1FVL1Vx?=
 =?utf-8?B?dElRTnE2dGV3bkhreEhUT3N0RzBhVXBJTXJoMUZ0cW5jbkRZR2F0U0Vzd0x5?=
 =?utf-8?B?UUVoS0JBc01xZUJpUkw4bHUvTWMyWnJQMEU0NjR2MVdlcHhIWEZ3UTcxaitQ?=
 =?utf-8?B?SEpSOCtqcVkyNFByVUJYMFRVT3BGOHBJcm9iYVhtMCtucTZ5dktqRDNkUUJm?=
 =?utf-8?B?ZUFJdkdpLzJPcDZzeHV2YVpQSTFJVnpuUWM2S0RuYytIK0pscUVHQnJLYTBr?=
 =?utf-8?B?c1BPQzZnZU9WMUN1dE9wOGo0T3duNEtLUmJ0NjFuOUc2QXhpWm5Ib0RmTVJr?=
 =?utf-8?B?a1hKQWFONTkvclIraUJSYjBlTmVtQmh1VDd0M0k3S09aSWt6RTltY05qWnBK?=
 =?utf-8?B?bkhuWWhoWDc0djNMUW1BRDEzdm5YTWp5K2hRL2FtTElUR2JZM3FpQnRkb05v?=
 =?utf-8?B?bmlqcVBHL2RtQUhCU2J3OHhmRHZPYUs1czVUYTEzbTMxcjFxMEdTdklLRWVv?=
 =?utf-8?B?c0NHc21Eem9PQ0tMbHdLbFZlWFJBU2pyU2c2S0ZIME45T3lKNDJQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wZXapUUZxqpFbsp/pNLJwwincB2GJwHQfjTfMwvmk7AOIui6uBaslBvhkgBAqb1Ms1OLkBQ2wNMP37pdVZ8la1X4MF51pPeyfR66tJpO4zCxTx13yznfbafpfzico5Ry3FposIGTb5icPDhe6DilJUWBcr1mUM/XfwTq6CstOE4vz2fctOypyGfr/Kf9xwR0FPLj6M+67EGy6CCbHE3JVxfT10N0pVd1KLAEwAPqH2K0ZLDMDzbVjWii7eH3J65yMg2kNG8hw3eVlru4MIt4FOK2Cc6KuIFMbK7oHTmSnISGRLSZD8eJ5uMKdGXiSfZ8SnuI7w9FqdO8gTHW2LZPOA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7758bade-4f3c-48da-b8bc-08de83686508
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 14:29:12.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35IAn5hvSNFUn2JlVHlZg0ike4oTy5PYCsXKAVXaniliO6ioIAtxnwOtBrmg2p2NenpFshRi1Pnb25TVIuKpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5102
X-Proofpoint-ORIG-GUID: LVK2A2ZdtNDGB-hpbTy_GTZ3hvE6-2hY
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b813bc cx=c_pps
 a=FRwzarAYk3lDJRtuO2pFeQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=pGLkceISAAAA:8 a=t4Si5T5BBepHxzmBgF8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LVK2A2ZdtNDGB-hpbTy_GTZ3hvE6-2hY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOSBTYWx0ZWRfX2y1KSZ3tD+Bm
 BQZsgmD2019WY/nCUc16LzUpBHx1XryYI0izDpBomK3ZPW72y+yZ/hOmT2WuDowOUTFiWyIeUbZ
 Zqo6UQer97lPi9HDWmwslphceWNn2POZKQGdFutgPcXQtP+S/Aa2Ehl/85b5Yka3GkCWFbTTmN/
 NoceDs78W/Vcl8hLNaqKuyFN5BXGxuEJpOYLeftGVkYzqLEJx9r+1GoJp8o3Mm5kW/FtvjFZkEP
 Vah682jsKxQUK5Iq4L0gDrFP+eucRMBBl0LpojkCuAzxQ4xdETisJxQRORNjZObtf6qpha+46Mj
 F59xNUg7vOepKMqCKh6tYrDuAClyj0nByIteMkl+OOtA9iTGJOIYvIx5yCS2Ih0IVo3O1sjH8Ai
 AbWo0IkebWCfhaFCPHTzY4eRSVTpdoGA7Jmgct/5OFW4k8CG1hs/V1OrxZL0yUcC1RoDByuL05b
 4eiZ0A5IC1yOz4H3xPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160109
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8272-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 8DB9C29B678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDE0LCAyMDI2IDE6MDUg
UE0NCj4gPiArCXJldCA9IHJlZ21hcF9idWxrX3dyaXRlKHN0LT5yZWdtYXAsIEFENDY5MV9BQ0Nf
TUFTSzFfUkVHLA0KPiBhY2NfbWFzaywgMik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVy
biByZXQ7DQo+IA0KPiBOb3QgRE1BIHNhZmUuLi4gTm90IHN1cmUgaWYgdGhpbmdzIGNoYW5nZWQg
aW4gcmVnbWFwX2J1bGtfd3JpdGUoKSBidXQgYmVmb3JlDQo+IGl0IHdhcw0KPiBub3QgZ3VhcmFu
dGVlZCB0aGF0IGEgc2FmZSBidWZmZXIgd2FzIGdvaW5nIHRvIGJlIHVzZWQuDQo+IA0KDQpIaSBO
dW5vIQ0KDQpXaGF0IHlvdSBhcmUgcmVmZXJyaW5nIHRvIGhlcmUgd2FzIG15IGZpcnN0IHRob3Vn
aHQgdG9vIHdoZW4gaW1wbGVtZW50aW5nDQpidWxrX3dyaXRlLiBIb3dldmVyIHNpbmNlIHdlIHVz
ZSBjdXN0b20gLnJlZ193cml0ZSBjYWxsYmFja3NtLCBtYXAtPndyaXRlDQppcyBOVUxMLiwgdGhl
cmVmb3JlIG1ha2luZyByZWdtYXBfYnVsa193cml0ZSBhbHdheXMgZmFsbCBpbnRvIHRoZSBpbmRp
dmlkdWFsDQpfcmVnbWFwX3dyaXRlIGxvb3AgYW5kIGNhbGxpbmcgb3VyIGFkNDY5MV9yZWdfd3Jp
dGUgLT4gc3BpX3dyaXRlX3RoZW5fcmVhZA0KZGlyZWN0bHkuIFNvIG5vIERNQSBidWZmZXIgYWxs
b2NhdGlvbiBvY2N1cnMgb24gdGhpcyBwYXRoLg0KDQo=

