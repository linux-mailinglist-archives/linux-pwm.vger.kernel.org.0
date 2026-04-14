Return-Path: <linux-pwm+bounces-8579-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOMEH5NQ3mkrqQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8579-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 16:34:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE03FB538
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C370302C933
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ADB3E8C64;
	Tue, 14 Apr 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MOx55aMl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197153E715F;
	Tue, 14 Apr 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176787; cv=fail; b=b8SJu/qhSBWKNu5yNJbTWzx40ZBuMFXhfUmrO51+uy4tGCjY26dLYVKbJnWt2CEOXTUzm7DO09sFzo3CcW9p4kS+mmzjiRoplqkyvC88IStKv44F4Lds/o/IxZNANwJLR5JDRIEQ96EXt0easpJEr2wyEvwhfsxv/7P34c1qPV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176787; c=relaxed/simple;
	bh=7nS5iAdPFnAauUwkp6Iq15Dbsi0ot0iOw6C3mbFWFGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxfjNnUtLGMC3gl6F4nJumna7p9cd8EN2NIFIV0RD7BGGJh/pv8A503YLWmPflWYhL71bq9/y4+WM7kjDU80J0JBx5DfQUFFcCta3TzvbFcKCOvy7oJ5YwscV30YveiN/36pk0dnydKHFNCgJ4ci4VccUZ9O2R1gwyRO+w62t8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MOx55aMl; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBe9T21974616;
	Tue, 14 Apr 2026 10:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7nS5i
	AdPFnAauUwkp6Iq15Dbsi0ot0iOw6C3mbFWFGY=; b=MOx55aMlyHhWDF9mYElwf
	ZtjRPLJNAT4lPvDha3JZocEw0rcPs89T5KVHsKRjgkVHDO8tLxJJBZQyE9HaINj/
	jqjoYHODYvIQC/WUm19J9Tm1mxJmjMs3Yk42iXY2ZFHwKb1IIGRkon6baaafHU35
	9wxpr45qH7amVyGVaQmwOK2AyYHAcG2G/JXKtIXCuFu97zrvy7yBjVPSC4e0jZ+2
	7YOZ7tMug7Bs8S8qdfxWrBNfBzOePyW4+iS1KN9ed3/hUan6EHcINN2ywd4mVSnM
	er3MLI2CH3rEhQm/FQO/v+LH41ugy4QAz3wskvmBTZ45DpnCod8nFNIEVWMm6mr3
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dh851bcay-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:26:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP8KVUHpx4mvRaJBipgLmyOfbAnEreaThOkZWKGzsq1b3ENRInLxFyuIcKBgKb8tne9SGLtZDydlWyJBNkEPBf7SHrGRSooyV6MfNBratSpbpgwB6FBn2PulxieHNJ3mVld6eyk99X6fdQLcmU2NdYGIbb59lBvT23WmJS9TQGSjfRIhgN+pL2F6o8ScEHWZ/J9rrWtHPnEzjXu/EMBMgYOHN7/LjMTvN3uHBH9IswWetWr3YkiNwiaOCnWE3SxNTO2INmMfxS7fAhu49NUGDB5fmE16GJ/YWAVkJtzCzwvDHpbRnIGGRr+SunB84REGSBP+dPOgHGwDrj12YpxGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nS5iAdPFnAauUwkp6Iq15Dbsi0ot0iOw6C3mbFWFGY=;
 b=MuagdwWslm3ay+F/OazysvQMV6zlvQNdYPQ6SA54V0LzY5drDiGhMEw4AqM+vXtNlXdLQmSAcF8oK6HhWDamkA9vQ0tprG6TTR5UY48r0GP/fcMTOeZlUYu//4N/dhdv4E+82em1R0ci+RLD5Ny0PyNbCRcL5psFFtfg/vqJbkpO31mzhcETEMfYYSHn+OgMXU8VEHWyKk2T34R9SUBOg32otvjvyzsZdQVE2r7X6xaeRBCIdyvu66LQxI1ubs6/mWvelqyfnM26XzfYDIL3qSnaRu8Yf2Ab19V3CH3NgJZBeFieQcws2Nhyd11CTyX9gYK4bypZUBgmWvF2EF9tBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by IA3PR03MB7714.namprd03.prod.outlook.com (2603:10b6:208:50e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Tue, 14 Apr
 2026 14:25:57 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:25:57 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
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
Subject: RE: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Index: AQHcyDWKLXLdMUxvy0qzqrU5i7lMELXYzdoAgALtoICAAuQOgA==
Date: Tue, 14 Apr 2026 14:25:57 +0000
Message-ID:
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
	<742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
In-Reply-To: <20260412185821.739e477f@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|IA3PR03MB7714:EE_
x-ms-office365-filtering-correlation-id: b56e8dbc-bd36-412d-3cd3-08de9a31be9c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|38070700021|18096099003;
x-microsoft-antispam-message-info:
 T1mq8dS7gFZ9XAceHJOzJBHdY6tQ1U7qKdUcMlzHOXSn6QSgR8MEyhx9lMdEEupUd45b1qzz1ovEaisWE0AM2kUys28V3jw3J6sl1K/vQPE929BirA1loHmuyKWgPtgIWrC1BqW1fq8zGLIaYQNG85QWJcJ6f2gj9Jwjh1LGqyqN4IQfHyrXQ/Lo/jb/babaXZVgCK0Pjuzrrq+4DvfZ1gZxAC5TAhP6vLomnoRSA/OTPFuPFRdVEu+qvyj3o3ZXrxWBgGWDShSIdG08JU0v3jkLNLSuz+r163cMoxkQt5Z5RwNISBD+X11H0Xc49GbLi2ZTkAzP/QI8koZQGCPjxrvBaEM4BSJFYsX95XbcnhF9+ripQoipRHqfUyo8Mm4g/PGtF8v76lwbnFVafC/S938m6T+HIacJG3pOr50VyQ5fAZqwU0QudNCrQpc/jArCrXqcVwNtWqoNXIrM4tgWJ2eEgm6w07UODtiDqxww+v4/eGS8RXTag8spkTAitQGQs45SsTyv8MG1qvBY7U76X2CodJkI8rc1Bwz0sYxEa6A6KvJWAIY+nq2WOilIEFJI5gpKMv9Du0agKXQbhgj8FfwCzxACo/OegR441SAoR4Fz1XYGq9wllIpY19J1Q+R6mIFxOeOkkiRGWAlcLbZYDm8nX54W4HBfiAU+mP8FeZUaHjJL3xgI1DKJDGLFdXNBoAmO2NQgWsWeMI+2ZgSwF1CyvKowBHe0K5BXFvXD2kUfb+txcinGUaBOhExxpLTVBspvurazhZPRKAtDIoPcAhpg+CIKOrtmAdvsVmCxM+8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HRNt4tEa7+EsP1UeBLNiwPkxeFVH1jnrthJXUbbieufvxOLt4rhr3AGzQT?=
 =?iso-8859-1?Q?m4E6gUwGLZZQhJWIBpAa02rFIEhG1j6FhjKZMVDR2l1tpKMGvQLWR1mOB4?=
 =?iso-8859-1?Q?VZZUCNsnZx546cpTnfZtjaJULXuvZkjVzpYndFNvpGnIMWoX4ckhYjf1p+?=
 =?iso-8859-1?Q?PDCy0ozwcGC1nq2FzZcpmUZULxLe+jItVRzOnsbqUOR5t3R+nZPzWK4/zK?=
 =?iso-8859-1?Q?HxVwQsswvIYifXmNz5CHsyg1XwiJPgrjrYSOxtCIzvkbAIHDIxH3PwGy7Y?=
 =?iso-8859-1?Q?S3B+WVMy7Qe7AhqJV0U5uR4mO4KX5RTSe2zQRV0YvP7WOBh+EKcXrJLeWV?=
 =?iso-8859-1?Q?iBuo/OTfLhETmR1L96EYhTRDSepaXmsBelIiqgezDSAiyBrpc2ixGYpy5P?=
 =?iso-8859-1?Q?DC5NCKfHa1bSsNucLix+hWXGRT2ubcoN0ChNJtGFqnx04ifI7cK2a0UUgI?=
 =?iso-8859-1?Q?YDtjEOo5loLwuxRhxMWj26Q2MlC2LJ7ScCvoVVFfbY8Ni9ePiKn7Snw7hF?=
 =?iso-8859-1?Q?ysJALcL6qamilFdM2ya5+rilh8z3nLtKpGEcm18goJYnhQwJTBoqiykX84?=
 =?iso-8859-1?Q?shvGo6ksOVMbNFGacj1cFxyj5W8eeAPY51wmEuOpuw1pGdqyNQ8NsExKqu?=
 =?iso-8859-1?Q?Zo8muAPOxgx/LOV88hSVcnnnzPrssqV0O///eectgHjv/Xvp1NkpIrEb7i?=
 =?iso-8859-1?Q?35Le56OmZ0fLOmQ1ohvPp3CZH3zBWjaCOYVwOm4GEtPNofeb0b8CD0UHQb?=
 =?iso-8859-1?Q?9U53crjGzZlEZkyZc6fHIFqHP3A3eL7RyoipGr8Uw3AOtFlFHRPWnM6cVB?=
 =?iso-8859-1?Q?ALBBZWHD9FukXJI/dMBWAWftMhMXyMO+PuRi6WBzRiS6O8byIQaqqnberp?=
 =?iso-8859-1?Q?Ze+uihJaGeahyFem0aOIVwe4dPpeUbHt7ZHd5cLCEDBhgODc4VQJ/aqMc0?=
 =?iso-8859-1?Q?nh8/hzXjeWSgGJeJE9lVqRk5d4fgh8+L8lOvQN7gbCnbiWHeKsm8z1fOF9?=
 =?iso-8859-1?Q?hLh21+5iKBs9jABTAypx0dt5POgGZ5cZj9em5nvSa3SBOQsU43gLOddM76?=
 =?iso-8859-1?Q?qJeic4+f3F0LKdVSBivIzjJ9p8jbA6M5HWXtiwdDCQCqmQdr5bvGEOUQR+?=
 =?iso-8859-1?Q?wSwnOLsiGY/B2Zk0mHVlhOV0ktnc8c0Yu0HidpvijNfHv2K+NOLTK1Z1Yx?=
 =?iso-8859-1?Q?02oGcysEwqM6LRM2OSfL9uxnMj2hrKHkbF4esKvlyMIj6BeNe1XiXmbH32?=
 =?iso-8859-1?Q?Co6okVsNoXEVX09dU0W6ujkWrDqjfmmpYO5CiTiDjiejar6H/6+8h7MSnj?=
 =?iso-8859-1?Q?o/p8NTg+H7jouBF4aCd+edwOCbTK8/Jt73c9CW1cISI2bnofqNpwCNhEr4?=
 =?iso-8859-1?Q?eMHG9Nk1CPqiByNqe0wEUQMzULRoTLh0JqDayqhiikUiwNKK+l/9aBWgjd?=
 =?iso-8859-1?Q?zwCOgC8wX8hnaqJ2bpd8lCDEsDiZeUG3tkDlFA6F9gfHEG/auFpbZ223JK?=
 =?iso-8859-1?Q?t7Fgey+3itFf/+kJoKfX+3zbr5fWNQYdinYS+zhFfiyvmk3/2M3mPrNRIR?=
 =?iso-8859-1?Q?gNU8iXvAU7SH/Rvp7pjo0gf2zYttTpX2f6QxNoRiTVbSSZxlSVqSxqVxlh?=
 =?iso-8859-1?Q?Eo1dyr7HxkVWP4LPeoF7WgUwFzjdSX9w4PcjL3p9YTq/0bDGLqCs9v9n8h?=
 =?iso-8859-1?Q?9Fx+p2SZpvFQsUV4T26R/0z/tOYmUiSaHwWH/LRykFQ/dnqChtXgmj0CZO?=
 =?iso-8859-1?Q?+2U+TTe2leoM4P+XGVHVKtwDGzVdwNfQkCijRCCb/q7lC93mSR8k3oeFTf?=
 =?iso-8859-1?Q?HwvWM1G2Iw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fgKx79HiWqskKkXkSjlRuAsmv5+6IRuZgEylbjLlWoJsLTfs3lsmlq1GfLAnFnZVBRR1QdDjJLE34/Q3ti32VIfwRs0ku5jNsm8ddK0no11Lu0hQiYNoShkcSQdVSM5FNK1XjGjjHc6j+qPBY5+RjIMnvzoyhBC0TqPJSilnxxN/4l69RMDnR6RMMJpjvfJvPWiR1zThWnTtjWgV+xiL+nFjfPXVli47bfYAMojQ/Opp6433SCbpZC5V9vLICdmeLsXBALb82B275Dsjk9vJ80eOOMOryUy731MynOSRU4YB8Ls9F1clg8LFBx7KDh0TesVTxCP+KV5qwEM7M1YhpA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56e8dbc-bd36-412d-3cd3-08de9a31be9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 14:25:57.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLjDQ0kBqqx8gWyMwJ9dwIH5ftQnDKrNvqNCNQ9bEhKzDu4iOOGeCSg2/Fe+jzpHPqpt2mrtnTS/unq/AFbdDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7714
X-Authority-Analysis: v=2.4 cv=X9Vi7mTe c=1 sm=1 tr=0 ts=69de4e7b cx=c_pps
 a=keqI8JQlqSRTfAJNayiRog==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8 a=XPY_eM9CPOv7d0Pjw1cA:9
 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: p8h6tDa5sRvzlzAF7iaID-EmAIeCK4jt
X-Proofpoint-ORIG-GUID: p8h6tDa5sRvzlzAF7iaID-EmAIeCK4jt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzNSBTYWx0ZWRfXwFD7lsrP+ikg
 VK4NikhdbcfPV9FpaptX1N8Pans0KIEiKtwKUB6hpp3U7pD/nsK+NnRIUajvZFHg90ELIQbRtqZ
 N8lQmeJx3PiClSb9WyRJdzhFHdkEt8Ygjx8UJDsF2ORF5dAPVTtYAGTC0nwHALh25lvvCLfkNSw
 6ucb6PcQDAs1SIunSEa3/SjowgmjxXNM1kFjXQL70eiIZXex9hHsg4suf1zCF/QOY1iJmL3Qq3V
 bzkYeDfNDnej8ScgfKD7zaU0arydlrYHOpL11dAXR8WFBPWVIDmhuk4H2qkoG8fYVHi5xkp/amN
 T6+g7PQP8Z5+gsm0F7ZyXAEkxVmS4CBW+7UYUoidyv5+f+7mwGSVRFZ+jVAeL4QTVn344ws33AY
 YUmBaA4viXhkTgzbf+zQZipjA4prLxfni3cS8UBFqNFMWeX90Q4QLik8ewYWhxLYtXa4MLnWPif
 y9SoxUyeRoDU4l/3Cng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140135
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8579-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3BE03FB538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 12, 2026 8:58 PM
> To: David Lechner <dlechner@baylibre.com>
> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Uwe Kleine-K=F6nig
> <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Linus Walleij <linusw@kernel.org>; Bartosz
> Golaszewski <brgl@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.or=
g
> Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
>=20
> [External]
>=20
> On Fri, 10 Apr 2026 16:15:20 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> > > From: Radu Sabau <radu.sabau@analog.com>
> > >
> > > Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> > > The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> > > selected OSR at buffer enable time and before each single-shot read.
> > >
> > > Supported OSR values: 1, 2, 4, 8, 16, 32.
> > >
> > > Introduce AD4691_MANUAL_CHANNEL() for manual mode channels,
> which do
> > > not expose the oversampling ratio attribute since OSR is not applicab=
le
> > > in that mode. A separate manual_channels array is added to
> > > struct ad4691_channel_info and selected at probe time; offload paths
> > > reuse the same arrays with num_channels capping access before the sof=
t
> > > timestamp entry.
> > >
> > > The reported sampling frequency accounts for the active OSR:
> > > effective_freq =3D oscillator_freq / osr
> >
> > Technically, the way this is implemented is fine according to IIO ABI
> > rules. Writing any attribute can cause others to change. It does
> > introduce a potential pitfall though. Currently, changing the OSR will
> > change the sampling frequency, so you have to always write
> oversampling_ratio
> > first, then write sampling_frequency to get what you asked for. If you =
want
> > to change the OSR and keep the same sample rate, you still have to writ=
e
> both
> > attributes again.
> >
> > In other drivers, I've implemented it so that the requested sampling
> frequency
> > is stored any you always get the closest sampling frequency available b=
ased
> on
> > the oversampling ratio. This way, it doesn't matter which order you wri=
te
> > the attributes. In that case, the actual periodic trigger source isn't =
set up
> > until we actually start sampling.
> >
> Agreed. This is more intuitive. Now generally the userspace should
> be sanity checking the value anyway as limitations may mean the new
> sampling frequency is not particularly close to the original one but
> at least it increases the chances of getting the expected value somewhat!
>=20
> So to me this is a nice useability improvement given the code to implemen=
t
> it tends not to be too complex.
>=20

Hi David, Jonathan,

What I understand from this is that the osr should be taken into account wh=
en writing
the sampling frequency as well, right? Here's what I understand:

If the user wants a 125kHz freq with 4 OSR, then when internal osc will be =
written
to 500kHz before single-shot read, buffer preenable/postenable.
However, if the user wants a 500kHz frequency with 4 OSR, that would mean a=
 2MHz
Internal osc freq, which is impossible.

More than this, if the OSR is 32 the maximum effective rate would be 31250,=
 so 25kHz
would make it the closes available one. If the user would select 1MHz from =
the available
list it would be weird I would say. So perhaps a solution for this is to di=
splay the avail list
depending on the set OSR value.

Linking the two together is perhaps wrong to begin with from my end, since =
in this
driver's case, the per-channel sampling frequency is controlled by the inte=
rnal oscillator
which has static available values. So perhaps sampling frequency should be =
separate, and
OSR separate as well, which would make everything cleaner.

Indeed, the effective rate is changed by OSR, but perhaps that is something=
 the user
should be aware of, since the sampling frequency is the rate at which the c=
hannel samples
(1 sample per period) and OSR is how many times the channel samples upon a =
final sample
is to be read. The user already has to take this into account when setting =
the buffer
sampling frequency, so it would make sense to take this into account here t=
oo.

Please let me know you thoughts on this,
Radu

