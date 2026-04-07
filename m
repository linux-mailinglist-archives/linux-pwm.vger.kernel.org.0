Return-Path: <linux-pwm+bounces-8508-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHvEGV771GmgzQcAu9opvQ
	(envelope-from <linux-pwm+bounces-8508-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 14:41:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 264083AE892
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 502C73061D4B
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF53B4EB1;
	Tue,  7 Apr 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vpc7hpxL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6C3AA4FC;
	Tue,  7 Apr 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565545; cv=fail; b=OCn/qSLVll/++wz4gOyVep4vxgVYs0PUiCy+lcdnsGmRuB1a6aMUlRzUn12RhiOWDA5omTwtcYaCw+yybcN8clDJiDbi6kazLJMC8Gm9+8hzfuEHwQ/d2l1l9ZyzbtAaeon3CF2c2/EMIHuWON3QSp1Zqir0xLKztuU6BwwIhcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565545; c=relaxed/simple;
	bh=IXsPeI/v0MlD+kOEbmOTbZ7q6tW04XIy9GuT9YTCecs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5Oc17fqSX9BdHcEAiDtPTakjmjiTdFSvLLL0HokXg64jyXfS236n2Drff8hrYLcLt4LMOOhPtBXndhUXYlgS+GvmUgPSsnytjmnO/sZInzdrurb66JcWayqXnQEzpH2abvmor+V9mjVqmZ0Zj3yMAVxaJ02/zxtXPWjh5jiU8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vpc7hpxL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6378iot74007812;
	Tue, 7 Apr 2026 08:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IXsPe
	I/v0MlD+kOEbmOTbZ7q6tW04XIy9GuT9YTCecs=; b=Vpc7hpxLB8HNHQ4ITgpLp
	BLYG3i5q2mXSwnQWbGJkbkV4yw8yMYpsXtzXLrtUFOOfpdj48I6EhTcNUjjPyA4E
	hMRygwpfP/F9SH69ANB4S9gUWysBOf7gdLpn9qA0sp4wmaH9L0Pkd/HD3O7qIPW3
	xwnIT8BfP9M83LQZO1TLhUF4AUniOFebjXDL2zjezLcba2TJrbupugcKZMwqg/w0
	2C2uCBssCL69U2UQ6OTaJT91OTAZyO6ZNEg7++jTpjUl1bAF44gWS62ve2XJq7lP
	nNbeE6CAdsT7qmUh+3ItnYYH6h+2Z2So5znfXJIflHi/TwfjMEu3sy0RB9PJtTwb
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dcmsnam98-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 08:38:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqe6hsBx322Q7bBUfKuelaMXyqcQGGUusQQqwmvbg824Ro1qFmUeXwAJvMNQZl+XPWyTOxwKUM+TS9f2HUxSzm3eWAGRw05BI6bR16vphfCtLjzP7YAgC0Owd4V5g5RJ7hOL6YuBa1KjTAoE8ppV9MWTUZZ4uBIOpFCrMsFhSfOC+JlzAq6yQ7GiUEintyI8pgHg3UxYwLXS4rLbi00pLO9x6bMRuYCwty9z2nlQpjbKJnZl3ByZ/1uNd5cr+ucBSdJ8LNpzqISGsQCfevtlbJIIX3lzAyfkrohGk9MDO023DXsrYFSPsD6O/pIhh+2hQv/LxSHpnc5NF8Zes+P0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXsPeI/v0MlD+kOEbmOTbZ7q6tW04XIy9GuT9YTCecs=;
 b=NOs4JlIZVQO8BpLiwgT+LChvDQoMfdPcU8IdUaBor/Hp4T22OT67ZNt/ODhYgAJHVTk0BhQFdXvFV0sA/mRAAqEbOE+3J3oQIdJCje2SQPcd/6S+OJIzMOqdut8qcLlcS6KY3AXdHMVbJvmx91nn0XqN/7SbgK0FxR//dqDMc86o2i4rAIhUYix5do/84U57OfaW5lIZ+Zk4B6oEmKSSxgYuPNmkXvrTAdC5SRoIeAR2G1EEU02hCZf09iIIiSjib1ZkQwcp/PKG+Ci/C1RYwM5hNnxAUs+rBr+E/jYf1MhcPwn2Mz3fmw1SbAfgl1V4MyHz2tiIpF2MCeDTGI0fNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BN8PR03MB4948.namprd03.prod.outlook.com (2603:10b6:408:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 12:38:28 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 12:38:27 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPClqAgAK8tzCAAEkagIABev0g
Date: Tue, 7 Apr 2026 12:38:27 +0000
Message-ID:
 <LV9PR03MB8414DE6AA9FC7BB7B6326888F75AA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
In-Reply-To: <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BN8PR03MB4948:EE_
x-ms-office365-filtering-correlation-id: de145c79-45ea-47b7-b081-08de94a29175
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|921020|18002099003|56012099003;
x-microsoft-antispam-message-info:
 gcThEHfepNkODQm7+o+bbj5s3Ju5iRDy2BGiOfJEkpRvQpq9L3vd5gtmRNTQcu3xuUu/0bolgdrNV+R9e5vmOBWcfJ/bUpPZBc0CtgTEEmF8d/hwxh9XOK1QH3VFvf9Wd2aSEFstIe1kFLlBMaNH7MXmHPUGcjThmwNfxBGL7MNIRSyQcKKt/HSL0IvS/TUnf/OD6qyI/YcHxkkzf5vXlgC7B67TWURgNDjtERbcgByv8bMRa6bxcnkhkxd5jqobjv4K6pmnqunOMhxGSMTfxQc1hsr0tNBGE3yqnw7fk5UtSR4OWWQWWc3bV6eZprVWJ1ZD/ryItpgPmZClM5blpyptKfM0WGLS5wTuMk/0BMMVFll3jFW13NJq/dyBkQ/ZB4Ta39AkhzQPz/ScYiu8WN3OAnGNU746v0FiZK2jyYfiJmjv25lBZhnDgS2pm1WXiVAoVYWpNthSej/Km/AzxqC2yVg4NedgSE8eP7oTyC27WgxZ1YAX6BPfCqYIRE4d//36zSvkkcloPQIVCgu34F/qXL1PDnyj1rkjVUUQc9mc8OkhMHrq2NaVVEhHl8DMN7EQxBhdJYg0qSV8nSG5FvrQQm/b9swooA86wC9AWgfasRhD3QUYqxixH74bnnaz6b/TiL3J1JqT2bQXCABNmx4xpCicnWamhg8MTVXr3Ej1xUlOIxZJdqc2Hkr44ILh15tqYkPcvQbbtRMtwosJiHtb1IalvAY/AWgHc/I8iYmBnm3vgRTQEtkjWjvfg+BmUyf8QKVKE7Il+4Y26dt1xveShJp7IHC3LUzozNzhWHkKyctc1HpziyYHG6KRa9LS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2tKWFFtOGtJcm1HTFhkdWpvTmZLeXRVZjJYOUxTMnhjamJCcWZ6Y0lSWFN3?=
 =?utf-8?B?dk5UTE1Pa1V2LzVzN3ZvUnRzTVkwY2k2ZXBqU0x5Q0VnUlVLWjNPd2tlTmt1?=
 =?utf-8?B?WWVZd2U3K2VGajRQemxkVXlITE9LeTNqcDR4RUJ0bGZBU2hVcG1MVTNsYy9q?=
 =?utf-8?B?dTVoMVU3QlR1SDFPYjRsVmNiNEloaGVBZlhzRDZZZFozUjNmM3RLSkpjS21P?=
 =?utf-8?B?cHljeDREYXRqSGRKTWN3cjd1SkdKeldHQ1NtK2MrY0FuTTJ0Um4rZFh4QTEx?=
 =?utf-8?B?dVBLa0RBTXBjMDVNclkrOFVuMDdQZ1UyN3lpcUNyU1I5VE9XZ0tBSDdZSUFa?=
 =?utf-8?B?bmRVUTI4NUlaYytCdS92eXlRV0ZmTXhabWFWV2V1NFp1OEJoSUhySkZVUVF3?=
 =?utf-8?B?eVlDVFVkaUFaSmdyYXJmakZhK041eWhrNysxZENGbGlIaXpBVTBBNEhaaEFr?=
 =?utf-8?B?OGZXWUttM25qKzZDQVBpVlpUZnVFdDA5RTRTWk9GWWdsa2xsQUdJZnRla1pU?=
 =?utf-8?B?SGcrTSsybUpUVkY2Z1N6OEZCbml2SXFqQklVZ08rekJhOHAyTFo4aHU2VVpD?=
 =?utf-8?B?Q29iMUk4VGN2bUFpSWhmNnErNEZRd1h0bXZQemNmMW1HK0szejBEeE4yQnpa?=
 =?utf-8?B?VVZVM1FwQVpJZ3lVbWtQbzhSU1BudWRjNE5hMlFtV1poRGRNaTRiaDAwWUtF?=
 =?utf-8?B?TUtmYmRhVCtFbW9GeVNYeVArajhwRElLdmRkY2ZvSmFONVFjUEYzQTVDZENX?=
 =?utf-8?B?ZmFrRkJQOXEyNlBMQm0wTnpoS25ESHdXejZiQ1orMHpVajBzQkUxRG5nSVc1?=
 =?utf-8?B?NjhrYU1sSzMvRE1pS2R4RSsyL0p5VWtJbTVacnFON3FyeVpzaGpwS0srclVk?=
 =?utf-8?B?NzRWN0xxQm1UMWRXdkhRUE9aVzVvZEY5OXZVSWcxNUhsQmRpR0hZZFRUdlVn?=
 =?utf-8?B?Q1U5ZUFzb1o1MjZJSW9EdE9MekpmcHNINWRFZEpWbExCWjFFazl0bHFBK0F0?=
 =?utf-8?B?OVBIb0NpQnpaOHdYbis1WXJUc0RKS1NsMWoxN0NHWCtnVmlXdlpJUTVtdHF2?=
 =?utf-8?B?bmhRcit1aUZkZThoZjJJTmVCQzd5V2c0djdxSU1KRUIySkt5YzJWVldXVytr?=
 =?utf-8?B?VHhnNkdKTWIzNjRvSFFxVTFjeXVocm55aHEybUoySXI3Nkk1SEViTWg0bG9O?=
 =?utf-8?B?dFY2UkltVDNIdWVjbFRibmR0bVU4R01PLytoYWhJRklQbDB6cUFEWXZGajcv?=
 =?utf-8?B?OG9ETGYvdEtjY2JRWTJ3VEd3M0NWSTRqTmxxbFQ0ZFFFOXRENlpicHozK3Y1?=
 =?utf-8?B?TElhRmVJNlVzTXN2dllGVzAzVE5ieWk3NGhkdVlQc0hyM0NLTTI2NmdyaHVB?=
 =?utf-8?B?RlNNSk1XQ0V6cHhBSmM1bXZKbzQ4b2hMZDV3UHgyNG9TUVRhY3pKVEJVaVpE?=
 =?utf-8?B?U3FkVnVjYWlaZ09IWkdVT0p2Z1BkZ0hxcGVlWVo0S2NjcnlkWkNjNWxsUTJh?=
 =?utf-8?B?bjQxRkJSRlBaNXBiTDFrOEVaL1FMN2kxWG5yelR3cHhBb1E4Y1pqNlcwYUdT?=
 =?utf-8?B?SUp1WnNZdTVacVZtVitLS1BnMVY4RU5sekJ6elVFcjBjSEpCY3NIbmxCOGF1?=
 =?utf-8?B?b0xIZ1JRN3U2bkFBakFYa0toTHpqSzgwM1ZyMW9lcXphZFExSGtneDRFUXVD?=
 =?utf-8?B?MHhzTFNjT1ltY1NkUUVzMmVtcEVHbGt5anJBaXhjcFJHQmdVSmU5dGRFRUV3?=
 =?utf-8?B?b252V1lNMXJwdGhLc0JNQUNjcGx5UkhSQ0JrellFU1dXakxBZ3h0VHlsQnp4?=
 =?utf-8?B?amR3d1hXdG54d0hnWVI4M092L0RhWGRJZE5tU3VZOEh1elgza0x6R0lVb3BU?=
 =?utf-8?B?RGNmMWNxT2RNQWNiUjNCWGNzQXd1NlNxYnBaVDc1WWhlSlVwcitQaFZTQWxW?=
 =?utf-8?B?L3JlTlBYZDV4YW8vckZNdjF6eTRHVU5xQkEzcXNDOGtKbllVSzMwZ08zZHlk?=
 =?utf-8?B?c2c5RWd6T3o3azVxWHhXZEhMWWZva2p4MG1rYmw0d1NrRHpCUk5BT0pjRlgv?=
 =?utf-8?B?citVTVFrQTFEYnkvUHU0aTFjZFQ3MkNBdVdNQVVQYW1UVm9GLzhLNXFrRnYy?=
 =?utf-8?B?algxUndOeEF3M0NiZmdXOXpCSEZSQ3dGVFI5RXp6OHlWd3ZNcXN4bndLMkQ2?=
 =?utf-8?B?ckhSdVlkdlVITFkzdnh6R2RxQkNGWWI2dVNhdTBNcjlKNzE2eFNPUFJrRkVQ?=
 =?utf-8?B?OHA4d25rWDdwRGlOSzlkNkdXZkhCNWJEc1VpWHhIOUwyRzRpcVM2czdEck1k?=
 =?utf-8?B?dE5DMkswcmVlQ0RyQ2h5WHgwTUlEQUlxa0ppaXFvUDI0RjIvWlBRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VRrrAo6oI2nouvE7Mf3qgojdmTD43/hhQbuTSqxtpJ++MGsrD0Tnb9E+iwoLYtI8wWEZE8V6GZjWxNZ17C7B5gUY3qYLmWHBsLuvGO5X7MsR8+PO+unvRtmRGEXhn2iS9zIh6AHK+Zqsi/DV6207oiIuLFGzO8jtH9ZfAe3VFSWSITM1s2FXYbu5CE2f1JuEQzQ4Sk9uHniIlVEAi4K7OILxVkhKHe2NZGJJnJ6mUEiBFJR//Qrn3dJJtAbg2zjbcrJ86GAHpg4z2eavlvWpOuzGEJSHHQW4yQxbiQOfKajRXHpCfbVqDrLI8aIuMgwqXDsG4CD8iXAkWygBqwJ6Mg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de145c79-45ea-47b7-b081-08de94a29175
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 12:38:27.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aA+0OSdVsyQEq6sYTwg6WBadmtHQGmLRZHIjN8PPnbD8NxUlA7koZwWeDosvEJyzUZTWx0Rxq9iAbNksDJf03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4948
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOCBTYWx0ZWRfX7MO/TI7VaFE3
 bAr1I0HQbhqN7XSITvhj55fObB7rlgAkABKCf7/O6/wknUSciTNdtDKVloBskNAB42SCMTkVIL4
 5ffFDkddrfFeE7/4sZYNxPKyBQanyKBBre8g3zB2fo6MffrXJpOx6JPrZKDiO2oH8GC4Lpxt0DZ
 zpYPHqp82QE5nH6msknUnQQ78HYF5dvt3RrkcaxYknh6ZPeyqPb1O4KjtT2ow0RQr90gcDpzyqk
 d12mvug1dYyU/ClasMFljeixqaP+d2fK+Ey/Vg6fveLmmdTLJ6DltAs37U0m0IShYZxW73E19XC
 5pt1r4DCIJMlq6OJzZjadkeawSD6fOzmDDr+1IObk9Ao8/IvPqIUR/z5XJZdfGQ95Hlr1ptS8k4
 lodINj3PBuSNoEVuk5vvIeZDPg157ERM2NwzTLDBgAN/ZZR0bphHGKHiromoKOiebXhApk8M2xe
 Cdhlg+AuL3NIfkT1m9A==
X-Proofpoint-GUID: x5AWa14q1ypmQ0M53q-wvZglyh_VBdxy
X-Authority-Analysis: v=2.4 cv=D6Z37PRj c=1 sm=1 tr=0 ts=69d4fac7 cx=c_pps
 a=AaLFskbMOPjKyn39sRDTkA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8 a=L-S9R04XG4cGFLjoiaEA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: x5AWa14q1ypmQ0M53q-wvZglyh_VBdxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070118
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8508-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:dkim];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 264083AE892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDYsIDIwMjYgNDo0
NCBQTQ0KDQouLi4NCg0KPiA+PiBJZiB3ZSBzdG9wIHRoZSBQV00gYWZ0ZXIgYW4gSVJRLCB0aGVu
IHdlIGRvbid0IGdldCBhIGNvbnNpc3RlbnQgc2FtcGxlDQo+IHJhdGUuDQo+ID4+IElkZWFsbHks
IHdlIHdvdWxkIGxlYXZlIHRoZSBQV00gcnVubmluZyBhbmQganVzdCBwaWNrIGEgcmF0ZSBzbG93
IGVub3VnaA0KPiA+PiB0aGF0DQo+ID4+IHRoZXJlIGlzIHBsZW50eSBvZiB0aW1lIHRvIHJlYWQg
dGhlIGRhdGEuIE90aGVyd2lzZSwgdGhpcyBtb2RlIGRvZXNuJ3Qgc2VlbQ0KPiA+PiBwYXJ0aWN1
bGFybHkgdXNlZnVsLg0KPiA+DQo+ID4gU2hvdWxkIHRoZXJlIGFsc28gYmUgYSBjb25kaXRpb24g
d2hlbiBzZXR0aW5nIHRoZSBzYW1wbGluZyBmcmVxdWVuY3ksIHRoYXQNCj4gd2lsbA0KPiA+IHBy
b3RlY3QgZnJvbSBzZXR0aW5nIHRvbyBmYXN0IHNhbXBsZSByYXRlcz8NCj4gDQo+IEkgaGF2ZW4n
dCBmaWd1cmVkIG91dCBhIGdvb2Qgd2F5IHRvIGRvIHRoaXMgc2luY2UgdGhlIHJlYWwgbWF4IHJh
dGUNCj4gZGVwZW5kcyBvbiBhIGxvdCBvZiBkaWZmZXJlbnQgdGhpbmdzIGFuZCB3aGVuIG5vdCB1
c2luZyBvZmZsb2FkaW5nLA0KPiB0aGUgdGltZSBpdCB0YWtlcyB0byBkbyBTUEkgeGZlcnMgaXMg
bm9uLWRldGVybWluaXN0aWMuDQo+IA0KDQpUaGVyZSBpcyBhbm90aGVyIHF1ZXN0aW9uIHRoYXQg
cG9wcyBpbiBteSBtaW5kLiBIb3cgd291bGQgb3NyIHdvcmsgZm9yIHRoZSBidWZmZXINCnNhbXBs
aW5nIGZyZXF1ZW5jeT8gU2luY2UgdGhhdCBjb250cm9scyB0aGUgUFdNIHBlcmlvZCwgYW5kIGlm
IHNheSBjaGFubmVscyAwLCAxLCAyDQphcmUgdXNlZCB3aXRoIG9zciAxLCA0LCA4IHJlc3BlY3Rp
dmVseSwgdGhlbiBpdCB3b3VsZCBtZWFuIHRoZSBQV00gInJlcXVpcmVkDQpmcmVxdWVuY3kiIHdv
dWxkIGJlIHNvbWV0aGluZyBsaWtlIDoNCgkNCglvc3JfYXZnID0gKG9zclswXSArIG9zclsxXSAr
IG9zclsyXSkgLyAzOw0KCWFjdHVhbF9zYW1wX2ZyZXEgPSBzYW1wX2ZyZXEgLyBvc3JfYXZnOw0K
CQ0KVGhlIHByb2JsZW0gaGVyZSBiZWluZyAtIGJlc2lkZSB3aGF0IHlvdSBhbHJlYWR5IHN0YXRl
ZCB0aGF0IHRoZSB4ZmVyIGlzIG5vbi1kZXRlcm1pbmlzdGljIC0NCnRoYXQgdGhlIGltcGxlbWVu
dGF0aW9uIGNvdWxkIGJlIGZyYWdpbGUsIHNpbmNlIGJ1ZmZlcl9zYW1wbGluZyBmcmVxdWVuY3kg
d291bGRuJ3QgcmVhbGx5DQprbm93IGZvciBzdXJlIHdoaWNoIGNoYW5uZWxzIGFyZSBlbmFibGVk
IGFuZCBzbyBjb3VsZG4ndCBhY2NvdW50IGZvciBvc3IgaW4gYSBzYWZlIHdheS4NCg0KVGhlIHNv
bHV0aW9uIEkgcHJvcG9zZSBpcyBsZXR0aW5nIFBXTSBydW4gZnJvbSBidWZmZXIgZW5hYmxlIHRv
IGRpc2FibGUsIHRoZSB3aG9sZSB0aW1lLA0Kd2hpbGUgb25seSBkaXNhYmxpbmcvZW5hYmxpbmcg
dGhlIGlycSBpbiB0aGUgaGFuZGxlciBiZWZvcmUgYW5kIGFmdGVyIHNwaSB0cmFuc2ZlciwgdG8g
YWxzbw0KYXNzdXJlIHRoZXkgYXJlIHJpZ2h0bHkgaGFwcGVuaW5nLiBUaGlzIHdheSwgdGhlIFBX
TSBydW5zIGF0IHRoZSBkZXNpcmVkIHJhdGUsIHRoZSBvbmx5DQp0aGluZyBoZXJlIGlzIHRoYXQg
aWYgdGhlIFBXTSBpcyBzZXQgdG8gYSB0b28gaGlnaCBvZiBhIGZyZXF1ZW5jeSwgc29tZSBwZXJp
b2RzIHdpbGwgYmUNCm1pc3NlZCwgd2hpY2ggaXMgbm9ybWFsIGlmIHlvdSB0aGluayBhYm91dCBp
dC4NCg0KRm9yIGV4YW1wbGUgOiBpZiB0aGUgdXNlciB1c2VzIGEgMU1IeiBTUEkgZm9yIHNvbWUg
cmVhc29uLCBhbmQgd2FudHMgYSBQV00gb2YgNTAwa0h6LA0KYW5kIGVuYWJsZXMgNCBjaGFubmVs
cyB3aXRoIG1heGltdW0gb3NyIGFuZCBtYXhpbXVtIHBlci1jaGFubmVsIHNhbXBfZnJlcS4NCg0K
CXRQV00gPSAxLzUwMGtIeiA9IDJ1czsNCgl0T1NSX3Blcl9jaGFubmVsID0gMzIgKiB0T1NDID0g
MzJ1czsNCgktPiB0UFdNIGlzIGFscmVhZHkgdG9vIGZhc3QsIGJ1dCB0aGVyZSB3b3VsZCBiZSBt
b3JlDQoJdE9TUl90b3RhbCA9IDQgKiAzMiA9IDEyOHVzOw0KCXRTUElfcGVyX2NoYW5uZWwgPSAz
MiAqIHRTUEkgPSAzMnVzICh0b28gc2F5IHRoZSBsZWFzdCkNCgl0U1BJX3RvdGFsID0gMTI4dXM7
DQoJdFNFUV90b3RhbCA9IDI1NnVzIChhZ2FpbiwgdG8gc2F5IHRoZSBsZWFzdCkNCglzbyB0aGUg
YWN0dWFsIHNhbXBsaW5nIGZyZXEgaXMgMjU2dXMgaW4gdGhpcyBjYXNlLCBidXQgdGhhdCdzIG5v
bi1kZXRlcm1pbnN0aWMsIHNpbmNlIHRoaXMNCglpcyBub3RoaW5nIGJ1dCBhIGJlc3QgY2FzZSBz
Y2VuYXJpbywgdGltZSB3b3VsZCB2YXJ5IGJldHdlZW4gMjU2LTI4MHVzIHRvIHNheSBzbyBpbg0K
CXJlYWxpdHkuIA0KDQpJIHdvdWxkIHRoZW4gc2F5IHNvLCBzZXR0aW5nIGEgdG9vIGhpZ2ggYnVm
ZmVyIHNhbXBsaW5nIGZyZXF1ZW5jeSAoUFdNIGZyZXF1ZW5jeSkgaW1wbGllcw0KYnkgaXRzZWxm
IHRoYXQgc2FtcGxlcyB3aWxsIGJlIG1pc3NlZC4NClNvIHRoZW4sIFBXTSBmcmVxIHNob3VsZCBi
ZSBzZXQgYnkgdGhlIHVzZXIsIHRvIHRoZSBkZXNpcmVkIHZhbHVlIHdpdGhvdXQgY2FwcGluZyBv
ZiB0aGUNCnZhbHVlIHNpbmNlIHRoYXQgY2FwcGluZyBkZXBlbmRzIG9uIHRvbyBtdWNoIHJ1bi10
aW1lIHZhcmlhYmxlcyBzZXQgYnkgdGhlIHNhbWUgdXNlci4NCg0K

