Return-Path: <linux-pwm+bounces-8486-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE1sGUWU02lWjQcAu9opvQ
	(envelope-from <linux-pwm+bounces-8486-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 13:08:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8353A3083
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8CDB30078A8
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019CB3321A3;
	Mon,  6 Apr 2026 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QyU7eHfn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F45330666;
	Mon,  6 Apr 2026 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473729; cv=fail; b=cAb9DVWa/f9UQ/Kg3As5cwyphIAOcyCv6IxBDq0deN3PEr0EaF6kQ5TPm85eVexPmbe5rXA15bzsDXFljwWdNCzdLx0NUmvbj31qaRgHiCXLXT7SIODP2SYlsjgd/Gr2LwGeJiB7sUvZY9BDqfLha3OdT9/7Hbjgf5vitxhlygY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473729; c=relaxed/simple;
	bh=yw0d2dhM6HA4Go53sxpR+XUk6VXDX4yXESpFsowc1Zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eD5nhGSECMxcovhT8jKN+mwimyJm8wA/gmxBzMaJJhqlrnZIe7/AsjzV+koy0LcZJpA4mz7LfEdzMbZ5QqmsU63a9XEaJC/7KWfZFg2eMIH4rvE7eXIPMsFrSfgtyToOQKwGJT0PhNf5JhcAC0eHea8Bva/2s7cPJOEpQLp3N78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QyU7eHfn; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6369QI7k3346243;
	Mon, 6 Apr 2026 07:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yw0d2
	dhM6HA4Go53sxpR+XUk6VXDX4yXESpFsowc1Zo=; b=QyU7eHfnqdnY2H3ezB4no
	TnY5DrQ5T6buLvgzJlFB9DzSrdoj6c67trY5If0Kw/ff4fthgURXjqU6ns0p9WXv
	yGzhSUFCJoj6Mj2iuRR9w58T1lw3W37aTP3W6aw7DBjiBsdkQUR+Sa91n+OEOM62
	ZPGxPPbBzzE9kI70Z0yJyL5XoKcGlXlhJJLi1L5w6ehO2ylgn2O3NBv9s4kJtBoa
	FufxrKpYU6KnZxMKXubxlSHatBeHeaQl4gW+Ca+a/2QnV6fbvX/Kuw+J2Phv7Q0b
	PZUdXPKowHHA7D19SsGVPos+2AiQFRRB8h/SKFw6HdN3WWf5Tm8gGhwZ+l4ul8/0
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dbmpfmf4x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 07:08:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1Zn9hJz3WhcU8ol4qjcTjNNN1hEbmxUs/xwTExv/ZaCtUiltbFUWVIBJr3hBD1TnVPae0+WYOK02pTqLTbQXHUQ7aZUj//QOR7KJkbPj/ueiQ1hIJuJJ36MRdFdXrVLW9JjNm5Pzv8ufq3PwpYyvRBfLITHeC64tY5Z45zg1kbqDICWhWyjvbewuFVtIvl5mahCQdKk8vG1Zna7qahMzwQ96/lLnYB1tnB/VedNaCUC/QL/Bf1PHjB3mPULUvMeSJJ60zalZ5DMyVARspPyZePiwFa+qgqfEm1Myl6cVlQXlkv6lHuE4UXy3mO4J/6QgsZX0TCEwhsrnjOiH/jBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw0d2dhM6HA4Go53sxpR+XUk6VXDX4yXESpFsowc1Zo=;
 b=epqWEpeUM/kkfcKF3vXqaqm68IYaXfASBSN8UiqKxp7xiByVciVYBAT8lwambPZ+pC9kYWs97braz3SBhBHAb8t46VfqQ4QqXmtzn+STzhoSs3Oi8r5AK5/omR6bCdK85Ten829IV4rMEkBsHiOnXWUN5ExQPun1gVfhG8WfMGiY15lG2hJvlj+BdAi4Etv2r4wXl3cnemphk8FV2aImZrLh6CZ/7h+zQKzllRIKONyazBGgr91AWeOuatYPeWeSrUfaJ/sfyMZTtLetP94vg/zrwbKyFYuzYWICuT7lO2b4B3O90tZ+RUuP7KXKG+l0wX0T3fI5QLqm4WNFOMq41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7783.namprd03.prod.outlook.com (2603:10b6:806:435::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 11:08:25 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 11:08:25 +0000
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
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPELuAgAK5+HCAABcC4A==
Date: Mon, 6 Apr 2026 11:08:25 +0000
Message-ID:
 <LV9PR03MB8414C570998C4C1EE59ABFBBF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7783:EE_
x-ms-office365-filtering-correlation-id: 5d7ccb7e-8105-45e2-e5a3-08de93ccd2b8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 N8qnCHrbw+I9mi4l7YDEcMY9JNBL2LY7l82KHbMnIgXrwIfw7F9ZMWCYKnefD7zDObdbVKM3ZqGmIix/9JjogaZmdyuiRafcfmtulj8L7kfs4CC8r7ka7Z9MSwLXsCj/3fXBhjvVoCQ3T3GttRTjNrC+VJGWPEoSVTKkWHaoNGlstsXebWNkEq9uQhv43rjegyl4rHWjYXo7Qv2OYMk0Nh2OZH8V06Nb9y6HAGHTZhdeOWNpC8Gok3eXYJb+TYlwizztEAO9UFBjmcPFu1nBZCNXsXiPTMlQUoVvt542pGGiB/fRHatloknraWdcky0TyeCKbj2t5N6m2/ryWzC/e1qGtppJWciFNlQ3QcyCpK9CEEaU4E7rFbzfoV+hc+2YCVqf4GIv4tyQtwhmupaFnnwgBLOhSA2Sg41eYTGvUBPgSFdQwE9vDr9+RaVzwFUALO1BkBUT8PjJ1jMV1EzuAhCPOyteiOcxMIq8XeHBy5q6tP4B9aVK1GK9YPJDY1/5xjIS9yr0BJ1FEwBuEdvN+DeaR4EWrzmj9IvlHfwRIGMYihIj5qsB7kQCS+cj65A0m5WOZl6CxVoxVB9QkEpa0e/SElXKZqiBR6cBnu7SfVHbevIU9yuESHGmCspYvBYaWp/5Q1nF+o1ZhWyZrM/EjxEyEjjN/3Y6J+poyunh3boiRs6FUZtX+JBS/lvDTXePE0oqE5tUsD9lpVuBiNy63GKhQpxKXP4pblIyWjoU8Dk1gg8eXMleyyNPElC4JmsaS6muZ7DKMVA+BisUYTjzFXIoF+xwPWeEoFYCOQNEosqKhsmS8fjlpo1IZTrCbyhy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHpGR3FHTUN2MFF1SmtKM2lYTXlTMjNiclgyWld6Yk5LaXlJK1VqRzIwWFVN?=
 =?utf-8?B?Tkgzb0p3b2g3UWNPMFFaNDROUkcxaG9RMEUwV3FzM3ErK2ZQdDFESWloK1Jh?=
 =?utf-8?B?dm4yMldpaGMySityeUdVYURvcHF5clJ1eFV0NGhIenQ5c09iTFJlcjZGUGJx?=
 =?utf-8?B?K1BuTk4rbDNtS0E1VWxQUWVDS2pmSDREbjJFQXZrTlM3ZlZUYjhMS0cwM3Np?=
 =?utf-8?B?NkpXelJ0Tnp4Y1haTVdQK1o5YWtaMFdsK215QzhDSFBHZ2s3NGxqazFmdjIv?=
 =?utf-8?B?WGxqS1gzcDB0NXhsa2ZESjNXTUxCaVlLaHNwaXNhaGdvditJdHZsVzZpaGJJ?=
 =?utf-8?B?dkhJQnpXUkhXNEthaGJpZW4xcVhGZEttRHVFOWtDWVFlL3RqSE5UMFZqR2lJ?=
 =?utf-8?B?SXg2ZkNuakZ4VDZQbzFvZlQ4ckd0R0lxbjg4K2lRZnM2dW8wTE1rTWczMlRR?=
 =?utf-8?B?NlV6SDhMUUR2R1NwNy9aRGpSdmxpMDd2RTJTVU45NmpmSFNxZXJQVk5yNFF5?=
 =?utf-8?B?V25ZL3o2dTZmcWZuMVBDVGRoT2tvSmZoUlZuNVh4bk5LdzNLNnNVUHhaMys0?=
 =?utf-8?B?clFGK1JRU3hXRzR2ajZlWTV5dnNBdGEvNjVleU9TSHNLQTkvVkh2TUsrbEJM?=
 =?utf-8?B?d0tmY0FhZkYvUWFkR2pyTDNaQVZwNHBtSVhRSisyN3RNczl3S1pCeGRvcGlI?=
 =?utf-8?B?ejY1M3BCOEVvT0FtZTJITGtQUWhGamZTQmxmekVIZjlib1JEaFk4TW5RUGRI?=
 =?utf-8?B?WC81b0tRdytSTlJHTUtGZlFuczZRVXVVN1g1WWtvQnpWUlRzSXZMT1pVWXhX?=
 =?utf-8?B?dHRhdzRPVW12RzNyZUc1MkV3THdGNFQ4WjYxY0Q4R3hUUnBJUVVxeXc0d2NN?=
 =?utf-8?B?OExlYWtqcHBYTFEwQ0tVcVpDUkp2ZXJsdmJybjdJc1l6dVQxSXNobnplUjgy?=
 =?utf-8?B?M2Zka3A1WG5yTkYwTnA0Mi80bjVDK2IwMlV1RzliNi9GbmJNc0ovYm5ONXFE?=
 =?utf-8?B?QTh5RlBIaVZOYnV1Z1lwQlg1bU90VS9BOVdtamRsd2pieXFDM2VYWnRrWFlN?=
 =?utf-8?B?NUJoWDE5VkJuSEg3eldxdTlDMXVXWDFtTHZUclRWMXV2MmFTUTlaRHE0VnBX?=
 =?utf-8?B?VmgraEFLNjV6ZGhJNVF5RkZJWmJ6SHloQnFRWDJsQ2dudU83aHpGR0Y3MFVL?=
 =?utf-8?B?MS9sN3JmYzgrbElnLzVUcnFnMExtQllxZzFiUzAxL2xaRWJ0bEYyclVqVmJL?=
 =?utf-8?B?eFc2VzQvUXJrQmtYaTJTekFXenZHN2lIZGs5NFRmcm9BMzE1UzNiTXBtTG0w?=
 =?utf-8?B?SWhRdlY4Q3FjQWJkcmVLNE05eG1XNWVZbVp3VXZaSmd1MlpTRG1UUzNhSVlL?=
 =?utf-8?B?anFDNUFrWkt6c2JLbXMwdTJXSHpVNXZLc21SdGh5RlAvZkVNTzdOOUZtb1hj?=
 =?utf-8?B?T0ExTWVzZFIrYmx2NWF1L3Zhbjl0SzRENExJTWN6S1YzeDlSM0VNbm5qQUhU?=
 =?utf-8?B?RWIvbkVjbEF3T1E0Zi9vY281eW1MbnZIand3Q0hzN2UrYU1MRXVvalN1MVJQ?=
 =?utf-8?B?S3BrVTBFbzJtRGFqbTVtVTFLY0NiNXdDcVI0WVdDTHhyRElXcFRYUWFMcWxZ?=
 =?utf-8?B?VnV4M1JvUFU2enJybkl5TjJrUm1sTWVPZWl5TXAwWFpZMkV3RFNMcHpEV3hk?=
 =?utf-8?B?ZzdXalEwMlpuYzY3SGh2NnpCY1RqR3I1TUhBSDNXNFdxMkVKWk1RUXN1citR?=
 =?utf-8?B?Znl5QzBjVHR2d1g5U3Nwa1hMb1l2Q1cxMk9tSlI5YktJdTlOSlRnbnNDTkxk?=
 =?utf-8?B?UkNYTHlQUjhHZnNZZi9neHlwWHcySGRhSHhpanh4THNQR203UDQ4YmRrVHV2?=
 =?utf-8?B?V3Fkb3dOMUhGeUdoU1lQcHltcHVYSGFlVWcxdnZ5enNFRThNUmxZb2NWSnFD?=
 =?utf-8?B?cW1iY0tKRGhVR3c1THFSdzNrdWpEUnpLN1c5N0FNL0tjNkFobG1KUmR3Ulc0?=
 =?utf-8?B?aEVSUStOemtqZXRhaG1SRWpNblpNZVZPWi9UMHVHVExiMXJma0Y0SG83VDUz?=
 =?utf-8?B?ZlNTVGwrRk1LNVI0Qkx5cVI3ZU15czdtQ1ZaYmRUSDRZdkVSZkVZdHl3ZC9V?=
 =?utf-8?B?dCtJV01HaW5yTG5SeE8vcHo1ZE5nbk92VWFjamJzQVhXdVBOWER1eW9Wd1J0?=
 =?utf-8?B?TnRhNGd1K3B0T2wvdjQ0cnBvMm5nWHo5cHFPZkhHSklZZ0VsY2Zmc3FxTG9V?=
 =?utf-8?B?UnZBUHNsR2JDendwKzNzSU94YTFWMVdTUGxCOUZib2MrZkg0NWJNY3ZXYmJR?=
 =?utf-8?Q?+1msFLocRRonRXf7vW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CGQPRfmO8+9epzRyAOZBTASyU1BWmeOTrwkc17V51QpD0JgRAAaSARiGvxbgqzv+TuSJwyELIZyHFJ1RMYbvXAJjY2GM7WNnC9g/7eqT6Mutp6RephhM0G9fYnFuTqWTNCs3JnzPPlSGoCtxBt/M7eLWW3A+MRQ9Fn5C9E7U7F9Ncrs0OWyyufCtfoRYW2ofFD0LE3RSX0kmseS7E1rqLU9CQACJPnj20i+IBBkvIgEcQpIKPkr5AVEfUYxQWo0/seBPoW7CK2I0/mQKmiZGeH9gZPP1nl42XaEVX6B87GMwE83GXzyDTKlIskRENjqmAhuaExxm9/d+zzHvdlHXaw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7ccb7e-8105-45e2-e5a3-08de93ccd2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 11:08:25.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8OZIy4Mnsxrwjq4flkMVWzoUzcfr8fVwPTOl8RcWOw3QRWsev0JFWo1xrEdA6XbjcdzEqzR7dUrPt7lehYTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7783
X-Authority-Analysis: v=2.4 cv=UOvQ3Sfy c=1 sm=1 tr=0 ts=69d3942b cx=c_pps
 a=64b+Fh2X7ngyiwpNPLbe6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=dV2D_78nj3Y1UyBvJKoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XjzSkCzXiTDwpJzdd_mrNfzekAcuwTC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDExMCBTYWx0ZWRfX7BAYSOvR58wJ
 Vy/5pWmu84x9AYCw+pSDvFZ3ZByVNXy3HnUFRdWC1+Amy5SnAvAlCFrPUTbyl1sjPxMGAuD1clO
 BbstbIQTkKyy9Fg83AVo+WHZ2XrLaL/YwLjv+Vyr6qZFEvCg8CVMMEL17l7gfwNn87Mlu/YrKoS
 ljooBT4g/gHT7QsZ7WBTTml0W81kGkNgzC4q/2Mu6cH/u+Z2zByx1VYyIYW93QiAnnBMl8Ieqfx
 gMuYoKG51Yt7AWbx9Psc8EZxNDxNzCbuR66d8/D0XsM9Sr0mo6sspyLM+QWWldnuQNYaRXvGtoW
 a1afhn4ZRWVKDZSohuSajzCVvE28CUwxWM1JD5/e14IYn6w7FYjfYmd4aB0T62y6DsXpi4eZJVn
 Gq08qB1kVIl8qAkSn8H32odFDUHPsHJcU/TTt1DDr4HExrIUGXeGg/5DZUJ9sqaFDWO0TYHWQ0B
 +v1lH2+bm8toylEKunQ==
X-Proofpoint-ORIG-GUID: XjzSkCzXiTDwpJzdd_mrNfzekAcuwTC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060110
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8486-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:dkim,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.986];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D8353A3083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FiYXUsIFJhZHUgYm9n
ZGFuDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgNiwgMjAyNiAxOjM5IFBNDQoNCi4uLg0KDQo+ID4g
PiAgI2RlZmluZSBBRDQ2OTFfQ0hBTk5FTChjaCkNCj4gPiAJXA0KPiA+ID4gIAl7CQkJCQkJCQlc
DQo+ID4gPiAgCQkudHlwZSA9IElJT19WT0xUQUdFLAkJCQkJXA0KPiA+ID4gQEAgLTEyMiwxMSAr
MTU1LDkgQEAgc3RydWN0IGFkNDY5MV9jaGlwX2luZm8gew0KPiA+ID4gIAkJLmluZm9fbWFza19z
aGFyZWRfYnlfYWxsID0gQklUKElJT19DSEFOX0lORk9fU0NBTEUpLA0KPiA+IAlcDQo+ID4gPiAg
CQkuY2hhbm5lbCA9IGNoLAkJCQkJCVwNCj4gPiA+ICAJCS5zY2FuX2luZGV4ID0gY2gsCQkJCQlc
DQo+ID4gPiAtCQkuc2Nhbl90eXBlID0gewkJCQkJCVwNCj4gPiA+IC0JCQkuc2lnbiA9ICd1JywJ
CQkJCVwNCj4gPiA+IC0JCQkucmVhbGJpdHMgPSAxNiwJCQkJCVwNCj4gPiA+IC0JCQkuc3RvcmFn
ZWJpdHMgPSAxNiwJCQkJXA0KPiA+ID4gLQkJfSwJCQkJCQkJXA0KPiA+ID4gKwkJLmhhc19leHRf
c2Nhbl90eXBlID0gMSwNCj4gPiAJXA0KPiA+ID4gKwkJLmV4dF9zY2FuX3R5cGUgPSBhZDQ2OTFf
c2Nhbl90eXBlcywJCQlcDQo+ID4gPiArCQkubnVtX2V4dF9zY2FuX3R5cGUgPSBBUlJBWV9TSVpF
KGFkNDY5MV9zY2FuX3R5cGVzKSwNCj4gPiAJXA0KPiA+DQo+ID4gVXN1YWxseSwgd2UganVzdCBt
YWtlIHR3byBzZXBhcnRlIGFkNDY5MV9jaGlwX2luZm8gc3RydWN0cyBmb3Igb2ZmbG9hZA0KPiA+
IHZzLiBub3Qgb2ZmbG9hZC4NCj4gPg0KPiA+IGV4dF9zY2FuX3R5cGUgaXMgZ2VuZXJhbGx5IG9u
bHkgdXNlZCB3aGVuIHRoZSBzY2FuIHR5cGUgY2FuIGNoYW5nZQ0KPiA+IGR5bmFtaWNhbGx5IGFm
dGVyIHByb2JlLg0KPiA+DQo+IA0KPiBTbywganVzdCB0byBiZSBjbGVhciwgeW91IGFyZSBzYXlp
bmcgSSBzaG91bGQgaGF2ZSBkaWZmZXJlbnQgY2hpcF9pbmZvIHN0cnVjdHMNCj4gYW5kIGNoYW5n
ZSB0aGUgdHJpZ2dlcmVkLWJ1ZmZlciBmb3Igb2ZmbG9hZCBvbmVzIGlmIG9mZmxvYWQgaXMgcHJl
c2VudD8NCj4gSSBhbSBhc2tpbmcgc2luY2Ugb2ZmbG9hZCBoYXMgZGlmZmVyZW50IHNjYW4gdHlw
ZXMgYXMgd2VsbCwgYW5kIHRoaXMgd291bGQNCj4gbWVhbiAzIGRpZmZlcmVudCBjaGlwX2luZm8g
c3RydWN0cyBmb3IgZWFjaCBjaGlwIC0+IHRvdGFsIG9mIDEyIGNoaXBfaW5mbyBzdHJ1Y3RzLA0K
PiBlYWNoIHdpdGggYSBkaWZmZXJlbnQgY2hhbm5lbCBhcnJheSwgb3IgcGVyaGFwcyB0aGVyZSBp
cyBhIG1vcmUgY29tcGFjdCB3YXkNCj4gdG8gaGF2ZSB0aGlzIGltcGxlbWVudGVkLg0KPiBJIGNv
dWxkIG1ha2UgdGhlIGNoYW5uZWwgYXJyYXlzIHVzZSB0aGUgc2FtZSBtYWNybyBhbmQgaGF2ZSB0
aGUgc2Nhbl90eXBlDQo+IHJldmVyc2VkIHRvIHN0b3JhZ2UgYW5kIHNoaWZ0IGRvbmUgYXMgcGFy
YW1ldGVycy4NCj4gDQoNCkkgaGF2ZSBnaXZlbiB0aGlzIGEgdGhvdWdodCBhbmQgSSB0aGluayB0
aGlzIGNvdWxkIGJlIGRvbmUgaW4gYSBtb3JlIGNvbXBhY3Qgd2F5Og0KDQoxLiBQYXJhbWV0cml6
ZSBBRDQ2OTFfQ0hBTk5FTCB0byBhY2NlcHQgc3RvcmFnZWJpdHMgYW5kIHNoaWZ0LCB0aGVuIGRl
ZmluZSA0IGNoYW5uZWwNCmFycmF5czoNCg0KCS0gYWQ0NjkxX2NoYW5uZWxzW10gLSAxNmNoICsg
dGltZXN0YW1wICh0cmlnZ2VyZWQtYnVmZmVyIHBhdGgpDQoJLSBhZDQ2OTNfY2hhbm5lbHNbXSAt
IDhjaCArIHRpbWVzdGFtcCAodHJpZ2dlcmVkLWJ1ZmZlciBwYXRoKQ0KCS0gYWQ0NjkxX29mZmxv
YWRfY252X2NoYW5uZWxzW10gLSAxNiBlbnRyaWVzLCBzdG9yYWdlYml0cz0zMiwgc2hpZnQgPSAw
DQoJLSBhZDQ2OTFfb2ZmbG9hZF9tYW51YWxfY2hhbm5lbHNbXSAtIDE2IGVudHJpZXMsIHN0b3Jh
Z2ViaXRzPTMyLCBzaGlmdD0xNg0KDQogICAgVGhlIHR3byBvZmZsb2FkIGFycmF5cyBhcmUgc2hh
cmVkIGFjcm9zcyBib3RoIGNoaXAgZmFtaWxpZXMuIFNpbmNlIG51bV9jaGFubmVscw0KICAgIGJv
dW5kIHRoZSBpbnRlcmF0aW9uIGluIHRoZSBJSU8gY29yZSwgdGhlIDhjaCBjaGlwcyBzaW1wbHkg
dXNlIHRoZSBmaXJzdCA4IGVudHJpZXMgb2YNCiAgICB0aGUgMTYtZW50cnkgb2ZmbG9hZCBhcnJh
eXMuIFRyaWdnZXJlZC1idWZmZXIgcGF0aCB3b3VsZCBuZWVkIGRpZmZlcmVudCBjaGFubmVsDQog
ICAgYXJyYXlzIHNpbmNlIHRoZSB0aW1lc3RhbXAgaW5kZXggd291bGQgYmUgZGlmZmVyZW50LCBh
bmQgb2ZmbG9hZCBkb2Vzbid0IHVzZQ0KICAgIHRpbWVzdGFtcC4NCg0KMi4gY2hpcF9pbmZvIGNv
dWxkIHRoZW4gc3RheSBhdCAyIHN0cnVjdHMsIGFuZCBoYXZlIGNoYW5uZWxzIHNlbGVjdGVkIGF0
IHByb2JlIGZvciB0aGUNCmluZGlvX2Rldiwgb3IgaGF2ZSA0IGNoaXAgaW5mbyBzdHJ1Y3RzIGVh
Y2ggaGF2aW5nIGl0cyBvd24gY2hhbm5lbHMgYXNzaWduZWQsIGFuZCBvbmx5DQpudW1fY2hhbm5l
bHMgY291bGQgYmUgY2hhbmdlZCBhdCBwcm9iZS4NCg0KPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91
ciB0aG91Z2h0cyBvbiB0aGlzLg0KDQo=

