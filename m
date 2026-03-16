Return-Path: <linux-pwm+bounces-8279-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J7JDFgpuGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8279-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:01:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20D29CEC1
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2C83007959
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54383B7B83;
	Mon, 16 Mar 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JWvpYK8W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D293A4508;
	Mon, 16 Mar 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676624; cv=fail; b=dgsKhBmvawutPMdgwomLVQGxNsX6a7pG9ipgAoVB2ES6+OThMZ6LUx6TUCxC+8Ep39gNOjy6+vswj7qwAIsdy2gnvGSXUk2gQvAPKEoiSjdndYpLNwfvM7996p6DeOTqZZfg2xDjZPzzw6wYlOaQvi5/LjrVoXeHky9YJQDFlrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676624; c=relaxed/simple;
	bh=PW9ZJYuv/EJqEelCsIMLom2xhwfyJcndznVIviJ9JPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=azg5TR8JTw3Q3xH49abbnzXN7/wN9q9ZGXnPW6dRIdB6fWMN9wU3ZxmObQF7Aa9F29KJAXW5swzUwF4c8orAL5C+sQxOhS9FoHZ1TiQjJYV0CpYP7sPnRwrfoUH5p9I0ZNjyDsbwFVW3Zk8B3PMiJ99Mozvqm0+++UAbdYnYZYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JWvpYK8W; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9XrWp408768;
	Mon, 16 Mar 2026 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PW9ZJ
	Yuv/EJqEelCsIMLom2xhwfyJcndznVIviJ9JPg=; b=JWvpYK8W5ajZsQFkDmynP
	Uc+/rigTLQlyy47oQORM+/WUh9xJ8w0UffONJAtiJswpUND7DtxxEXjtoSi/PuFT
	GteTwkHUvHOEYTp5TZAWtD33mD0VEGE3X7FVTpBBj5VQyc4wDuf7Ff08IYkIAqj+
	K2HEnW16pOym8flmAnfS2pxQOmclILXIHigZGJmBlIO5ov05OETLTZUcDF8IMUhN
	WjgRaeP1aaNIgNSAyQhReOJAeJfQLu0K00PTM0eSpye9iVZqNqW7WKW0aGQZnipz
	1ty/NrYfzT7QIbnjsVw/YLh4jyPAfxChaqrv93R77izBEuIdo9xWKdY5kwY3NOI2
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1e5paxx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:56:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MofzGD0OjTJlKtiprWDeYbqPRF8vi7p3v4MS/j/5nAAq6xKoSeyWo9UhRFK8h8g/mu7YIyj9ImWmZ9SHzDu0d323bgcRi3nuzaldf0xGRfjixSSnrj0QyscPhEiXIhYpfpmtBxnH8YRGhnG+yQ02iUufLsj/0Rr4yc+BWBCEdj0xa8ToUHTc0lHFxEMGXr17idWPOiWJKzpWupApDq9iCebBEx+zIbUL64y9Shnml1OuVmlOql7aBLbAVO7KEgGOXOnhfnajwCE9x8vyk0gUN7jx4n0hZ5ibpsR6Rsjk3/275uNxlvORa24Xzer8jJG6WukvV7v6rJ72DzrduARQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW9ZJYuv/EJqEelCsIMLom2xhwfyJcndznVIviJ9JPg=;
 b=RYon7vxiem3zmVyqRCVfj2B6W8YV/jWwuCQaztGxaDQrN4bGBf91eg8bKqsyjlUJLUQg0Cx8wwe5kUxCBnAMZRkMrgEeioEsIRPI0s2hSRoCxvcQtGJDfIDzaF/KFZsRksKSq7lWXFk/mi9BPNIg+NzxZi1bxb2I2S6p2ux9iwAQJFx3koAO3uglnbdQ4zozBxsA+y7S1XwOWM6TGddFiDTg7dKOkdqoikK6MnOF4jWMWOKgLAcIXYHLfgGFVR5oFqcZYhBWn/s80OJ/FcYT/GMY9TN6KaxayOcXxGrpxW3wOBhAG98HZOqgOxZxxpzmWIBCJ7kRz6myE8dax6rpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH0PR03MB6113.namprd03.prod.outlook.com (2603:10b6:610:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 15:56:35 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 15:56:40 +0000
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
	<p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcstE9lpW0ZwF28UejM3whwuuFz7WuXaCAgALHEUCAACtOgIAAAwNA
Date: Mon, 16 Mar 2026 15:56:40 +0000
Message-ID:
 <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
 <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
In-Reply-To: <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH0PR03MB6113:EE_
x-ms-office365-filtering-correlation-id: 3bc58438-d2c2-4117-3cdd-08de83749d04
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 WAQSnFmxkZb1W1w/A6F48zYjXJ3fx9Pr3mGmtg9/Vsjnj+DHafiLVAsKh+dJg42/wbMe2nn+uRPTK3GEAIw8PsyWgkE3XYm66MacrQf9M/5PGJOVcruT7y4CcJyGMm1SbwDsSPGR66H5RvtHZeHQntK34aoJb7S6bDYHn0ff/NeOh1vPBLUORn5hvUimfWTWmrkTKGGurjt+VBPvpwhmp/8VWptXAfo5cAp8KOMy9HwPKP8f2KPIBHf6eb5B8FylkaB8kpkAF3bM+syE2xGulFkJWTrdk+QyeccUif9k20y/GFLDVii2eJ0SNa99EoUfCpVwA+FRg11HZUrbJSnY2Q4zK5GiX1YYO9T4gTTS0ijRsaXjl5XRQfqKUk5gqnVN9U8Yo2aqXnbyL+Nv+Qoxqx1KqGcW7Bjv4rcWQ7P+w8bBcTomdx47fnrleUA2W/ik32jNYeKUhf4QJAKoWI3HY5Oo43Oan/xfdvSGTJKvGUm8W8BWivsVusDoZop4TiMCLVEnlnNgRiKRHKLuuxOa6qO4EtEAEzhWfV/9zdoXXinLu4eDsYdPy6IrygAha6MV1dUGxZ1XqtvM48CSiVwt9qimaSiwAtSV7xGT990tTTblnmWjqRn/yXdHy8/RQeuYHdUDPVJ1FWtLTULslonNnFI8/qndd7oE/WXZSGGrsGEdkjOwGAf7vpbGgdLuHko0/oMxC4cuSEon/TbQqBgQWHIis+blGApNxhkEIV9/7K8m7wlBXg8Im3piVj79Wss5zC55BatRQnj1cw9WAGXghlIZLwUhWUq9aHWIqaHaZr1bt69+SCNje6XuF4iBBQma
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW5DMDRkOXVVR1pTaFNNTUU4R3psR0ZoWlBpRDluZjVJcjNLSitxYTNWTXJZ?=
 =?utf-8?B?cXVCamR3Mm1nT0dkS3RVbDE2Y1Y5YVlBSGxoWXNNZm5UUUVLMmJ0Zzl1enFq?=
 =?utf-8?B?SVhSaVE4QjlNditoUW1HK3dWM1k0TUVNN1JUandKcWh6OWJlWTFmcXZpREpT?=
 =?utf-8?B?OXk0ZUJlNkxyY2hHZks1SWI1M1FYR0ZNRnpZUnpiMnJZWC9Nby9KMlhZUzFC?=
 =?utf-8?B?dkx2S3JCK1hsTGZyVEFiZUErby83Ym13cFU0Yk5SQUw5RHQxaE5BK3VZaW1p?=
 =?utf-8?B?eVY1N3cyRk54RnRSR0VlSmE4WVN2M3hpWmF2dVZFaHFSaUlocnJlWk5vclcv?=
 =?utf-8?B?Q2RMcU9BOURMTHYrV01jVTROTzJVZ21BUGR3WUFHWDdDaUlXc0RETUVoQXNR?=
 =?utf-8?B?T29LT20zdllleTQ2enhzSXYvbldSWFpnZ3dlZitvZkZTbGdOc2xiaUNYZjd3?=
 =?utf-8?B?dVVwUEdKK1lBTnRvRHlxY2VSSmpXVEk0WFExNVVIajBNNHpzQ0lrTXFZVnI3?=
 =?utf-8?B?dkFBcVJhZzZqaFZzVk1GcVk2dmNIL3VPWVpxTXVRN1FOckxBaUF3MHpJVVh5?=
 =?utf-8?B?S2V4cGFDM0ZteTN5OHlMQXVuQndKWDk1eVlETG5Edm5QZm1RTHRtZlVManNU?=
 =?utf-8?B?N2wyWUZ3dWU3ck1GQXRMcjhnUEp4bUlMSnJ0SHVSZkQrT1NjVERKOW9Ldm1o?=
 =?utf-8?B?WC9jQUJlcjZzdGtuVFZ4ZkRuYTFpSlJlWjVGNVR5ejRGWTNtL1RuejdtVStX?=
 =?utf-8?B?NXp3eTJDUElJUzBGVFdLK2VQNjJIeHIxTEl2VUpPZkpxZlVDaHltam5VME91?=
 =?utf-8?B?R0RYNFhaNzVWNVAwVTh4SWdXdklTdnRwdElKWlo3K242K09nU2RWNlh6WDhr?=
 =?utf-8?B?Vjk1ejliTWRzOS9yelAvZDdHdTNjT3QxUkc3bS9BV1FhYTVrdCt4amxVMCtw?=
 =?utf-8?B?M2RNOXdLMUJRdFJaK1R1Q1Q2OHZqU0t1LzZxU1paZ0NJTXlhc0xOYUJnZFBJ?=
 =?utf-8?B?eW4zb2hPMk1lNFdNcS96WmJ2SHB0eWFxZHYzdkhGNkNPUHFnbmtPMDNNdXFu?=
 =?utf-8?B?eDJGcmpmOGkrdXU0MzluaWIwZlB4T0lJeHU4R1hlcmlWamgyMDRGK3Z1UlZN?=
 =?utf-8?B?NWhWOHRQN1NsWVFNV3k4VDJHWm1EWHVqTEhUZW03M2xvR0lQR2dKMGNhbjJB?=
 =?utf-8?B?RDZnNUVoaHNCMDZ2TDMxdVFKQWtBVzFlTGQ2V2lzQXpaRXVQVExwWlJEblRH?=
 =?utf-8?B?Y0VlZnM2TDZXOUhiRzlFRUN5YUR6cWtpejJUNTVnbEZWTXpyMld4bThQZFJK?=
 =?utf-8?B?L2YxOEc4aXYvdDNOSEdqTlB6cUJiTnl6VFM0QTVtMmpIWTYzcDgwdC9yMDEw?=
 =?utf-8?B?VXFBcVJVT3NHMnVZMmtIbjgwNTBHb1h4czZ6SFFsKzVGTlJTQ3MwcFFiWEMy?=
 =?utf-8?B?dUhSTFJEV1oxTVduUmpJSGJtb3JXTDF4Q3dxYXh5UzVYNEVacityN0Ivd3ZR?=
 =?utf-8?B?U2pBelJ2S2pYOFAxQ0N3NFQ0RjQzVXFNV3FwQ0xqbUUwaGtCQ1VEc3h4TUc3?=
 =?utf-8?B?R2NIbDJxakx3S0VBOXdTNHFsTmpIWDVlaHV5YjEvck5odGpDcEJIbHpvczQ2?=
 =?utf-8?B?dHlZT2FCRWhQcElHYkZweFNqQVUrTEt4UWIvNktTYWpiY0pwZGxYVFgyTTBB?=
 =?utf-8?B?bWhzUjlacU8wUkl1QStya29LMkRNOWV5NEtKVlJHc0N0c0JHYUhPZDZheTEx?=
 =?utf-8?B?enQ5ckVST2ZqQkpYZ2xTS3FzZG5hNVkzeDFoMENna0twZjlvb1gxUG1rc1Nw?=
 =?utf-8?B?dTVwR3VDNDRTQitPbTYzYTdjQ2RxVVkrVkZ5WmFpVmJiVlpFOHFoR0VsamhX?=
 =?utf-8?B?NGlYK0xyV3BUVjFMeU1JbFNiQ3hPN3FPejUwMkRuaWZEVFJjRWNoQytVVGZk?=
 =?utf-8?B?cVpqSmRQVVErZW5OTjFoUUljZXlSTmlxbmRRZzZyakExcHJPVXdDSWtMRFoy?=
 =?utf-8?B?WDNVclhwU05zOFhZVkZ4VnFiWFRPaGhKeWRBQ0NDUHc5QmpCa0RmNFVXdU1v?=
 =?utf-8?B?RzByczVmQUZ6RXJvQndDb09GeTBvamZXNTJ2TFZ1MmlPTDdmN1g3UWFQQWhY?=
 =?utf-8?B?WDNNa2hmdXlwc2hPanQvYk5FL0w5bU81ZldQQ01qS1hkd3hmQlNQVjhNTnA4?=
 =?utf-8?B?RUxyK2s1ZEI1UldDRjZtMWRsQzdVZ21FQVN4N3pvcGY1ZGJHZlRGbEVkVTZN?=
 =?utf-8?B?dlQ4SjdEZVZqdnRJc0grR05CMlVwcXhTZmYrRUNJOHR0Smw2M0tzUFRpTitm?=
 =?utf-8?Q?yNofpAKq0vZ5jP5957?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lpM6uWkM3BXXJVQgqowQG4EPPkNTLsbhCKTPTTtymziH3ncxnyUrMwwVmMRqMJi4rPgY9k65aeGxVMd+Z6fW5o8LgSJOOX9YB1DbL5q8WmTPbvdcz2ESpv4AgvUw2YyyOa/cva3zn8D3bP/EzoUQeHbUfDAY8c0syqSDbfGRnX9TooIpVhUwAFbviOpXVw4BN4L4Xnk47gLeGNgmSuwc2b9mRqrfIMhXR7rgONbpPnPBI7GzW9ojWiHOMugwctgpqCLVC5PzVgXjg0amGLVdfiL0jAU4t9VYcnog+eeDfv2pbLKqVc5i8Ho7ISuJkVfYM1sKJBwUi5botcCtPlM2kA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc58438-d2c2-4117-3cdd-08de83749d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:56:40.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7I+y3670zki8L3ng8fTMiBIswSaPipNwj/FjqqgC3qy/o5ND0sFq5SFMAyyhnrd5oOQW0wZgkAkSv9+XO/cng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6113
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b8283c cx=c_pps
 a=fQjKmEXVym7+EbnoMZdWAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=vKTDN1AO2VkWszZV_CcA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: iCmgDscxNzsOOWeXlju-Jf3xN5fZAdd_
X-Proofpoint-ORIG-GUID: iCmgDscxNzsOOWeXlju-Jf3xN5fZAdd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMSBTYWx0ZWRfX699BVrYuCcbv
 Y2gqZDh81IMHlOKHLAYh+kK+KFihGfvFjwdQAiqs2BaEpkXdizGxgaUw/XCenAQt4N3XxMtLAxi
 e/YYfmYnjoFPEZP2LC4tu4t+WBUzs20a2KKk4ss7Snsf+qOJy3BgEaQeau+rBbXLZTiEZ3O9GIH
 C2LiR9iNplq6Q8cLT5+5JDFHBFiH1WF4ITk3BpyCnJmNuBLrhCECbGYPxkYJWMlrXad4tY91AFa
 Q+WVcdA0Io9VHbydMsLzTQ0a7awvbDf6s7EPrAZSi6rFEzHUipEsPhuB8Q08vYORdMZjpJa/Klk
 biowZgk3/rvH3KWv2UVS5NNV9r6mAlj+oV1Yg6I7vk4aJPLMWa0mkw66ndKz1DyWLJE5iHG7o6A
 JqxL1YpsFHT1zMI2J/UwjJ2gLT4Mse7D/m8Wlo+qvSG2J6KqkfCes4I143JdyypgvD8NrrzrWSt
 Jg0FLCmZYd/f4YUF8+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160121
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8279-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB20D29CEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDU6
MzggUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsg
TGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hh
ZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPjsgU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT47DQo+IEFuZHkg
U2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERv
b2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5l
a0BrZXJuZWwub3JnPjsgTGlhbQ0KPiBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IExpbnVzDQo+IFdhbGxlaWogPGxpbnVzd0Br
ZXJuZWwub3JnPjsgQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBrZXJuZWwub3JnPjsgUGhpbGlw
cA0KPiBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGdw
aW9Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy80XSBpaW86IGFk
YzogYWQ0NjkxOiBhZGQgdHJpZ2dlcmVkIGJ1ZmZlciBzdXBwb3J0DQo+IA0KPiBbRXh0ZXJuYWxd
DQo+IA0KPiBPbiAzLzE2LzI2IDg6MjIgQU0sIFNhYmF1LCBSYWR1IGJvZ2RhbiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERhdmlk
IExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIE1h
cmNoIDE0LCAyMDI2IDg6MzggUE0NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+PiBCb3RoIG9wZXJh
dGluZyBtb2RlcyBzaGFyZSBhIHNpbmdsZSBJSU8gdHJpZ2dlciBhbmQgdHJpZ2dlciBoYW5kbGVy
Lg0KPiA+Pj4gVGhlIGhhbmRsZXIgYnVpbGRzIGEgY29tcGxldGUgc2NhbiDigJQgb25lIHUzMiBz
bG90IHBlciBjaGFubmVsIGF0IGl0cw0KPiA+Pj4gc2Nhbl9pbmRleCBwb3NpdGlvbiwgZm9sbG93
ZWQgYnkgYSB0aW1lc3RhbXAg4oCUIGFuZCBwdXNoZXMgaXQgdG8gdGhlDQo+ID4+PiBJSU8gYnVm
ZmVyIGluIGEgc2luZ2xlIGlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90cygpIGNhbGwuDQo+ID4+
DQo+ID4+IEl0IHdvdWxkIHJlYWxseSBoZWxwIGhlcmUgdG8gc2VlIHNvbWUgdGltaW5nIGRpYWdy
YW1zIHRvIGtub3cgaWYgd2UNCj4gPj4gYXJlIGltcGxlbWVudGluZyB0aGlzIHJpZ2h0Lg0KPiA+
Pg0KPiA+PiBGb3IgZXhhbXBsZSwgaXQgaXNuJ3QgY2xlYXIgdGhhdCBpbiBjbG9ja2VkIG1vZGUg
aWYgQ05WIHRyaWdnZXJzIGENCj4gPj4gc2luZ2xlIGNvbnZlcnNpb24gaW4gdGhlIHNlcXVlbmNl
ciAoaS5lLiBJSU9fU0FNUF9GUkVRIHNob3VsZCBiZQ0KPiA+PiBpbmZvX21hc2tfc2VwYXJhdGUp
IG9yIGlmIGl0IHRyaWdnZXJzIHRoZSBzZXF1ZW5jZSAoaS5lLiBJSU9fU0FNUF9GUkVRDQo+ID4+
IHNob3VsZCBiZSBpbmZvX21hc2tfc2hhcmVkX2J5X2FsbCkuDQo+ID4+DQo+ID4NCj4gPiBUaGUg
Q05WIHRyaWdnZXJzIHRoZSBzZXF1ZW5jZSBhbmQgSUlPX1NBTVBfRlJFUSBpcw0KPiBpbmZvX21h
c2tfc2hhcmVkX2J5X2FsbC4NCj4gPg0KPiA+IEFzIHBlciBkYXRhc2hlZXQgcGFnZSAzMSAoQWNj
dW11bGF0b3IgU2VjdGlvbiksIHdoZW4gZWFjaCBhY2N1bXVsYXRvcg0KPiA+IHJlY2VpdmVzIGEg
c2FtcGxlLCB0aGUgQUNDX0NPVU5UIGlzIGluY3JlYXNlZC4gSW4gY2xvY2tlZCBtb2RlIHdlDQo+
ID4gYXJlIHNldHRpbmcgdGhlIEFDQ19DT1VOVCBsaW1pdCB0byAxLCB0aGVyZWZvcmUgaGF2aW5n
IG9uZSBzYW1wbGUgcGVyDQo+ID4gY2hhbm5lbCAobm8gb3ZlcnNhbXBsaW5nIGFzIGRpc2N1c3Nl
ZCBpbiBwcmV2aW91cyB2ZXJzaW9ucykuIFNvIGVhY2gNCj4gPiBwZXJpb2Qgb2YgdGhlIENOViBQ
V00gaXMgcmVzcGVjdGl2ZSB0byBvbmUgc2FtcGxlIG9mIGEgY2hhbm5lbC4NCj4gDQo+IEFzc3Vt
aW5nIHRoYXQgImEiIGNoYW5uZWwgbWVhbnMgIm9uZSIgY2hhbm5lbC4uLg0KPiANCj4gSW4gdGhp
cyBjYXNlIHRoZW4gc2FtcGxpbmdfZnJlcXVlbmN5IHNob3VsZCBiZSBwZXIgY2hhbm5lbCAoc2Vw
YXJhdGUpLg0KPiANCj4gQSBzYW1wbGluZ19mcmVxdWVuY3kgdGhhdCBpcyBzaGFyZWRfYnlfYWxs
IG1lYW5zIHRoYXQgZWFjaCBwZXJpb2Qgb2YNCj4gQ05WIHNob3VsZCB0cmlnZ2VyIG9uZSBzYW1w
bGUgZWFjaCBmb3IgX2FsbF8gY2hhbm5lbHMuIEluIG90aGVyIHdvcmRzLA0KPiB0aGUgc2FtcGxp
bmcgZnJlcXVlbmN5IGdpdmVzIG9uZSBjb21wbGV0ZSBzZXQgb2Ygc2FtcGxlcyBmb3IgYWxsIGVu
YWJsZWQNCj4gY2hhbm5lbHMgcHVzaGVkIHRvIHRoZSBidWZmZXIuDQo+IA0KDQpPaCwgb2sgdGhl
biwgd2lsbCBoYXZlIHRoZW0gc2VwYXJhdGUuIEkgYXNzdW1lZCB0aGF0IHNpbmNlIHRoZSBQV00g
cGVyaW9kDQppcyBjb25zdGFudCB3aXRoIGVhY2ggcHVsc2UsIHRoZW4gdGhlIHNhbXBsaW5nIHJh
dGUgd2lsbCBiZSB0aGUgc2FtZSBmb3INCmVhY2ggY2hhbm5lbCwgdGh1cyBoYXZpbmcgdGhlbSBh
cyBzaGFyZWRfYnlfYWxsLCBidXQgSSBhc3N1bWUgeW91IGFyZQ0KcmlnaHQgYWJvdXQgdGhpcyBp
biB0aGlzIGNhc2UsIEkgd2lsbCBoYXZlIHRoZW0gYXMgc2VwYXJhdGUgaW4gdGhpcyBjYXNlLCB0
aGUNCnVwZGF0ZSB3aWxsIGhhcHBlbiBpbiB0aGUgcHJldmlvdXMgcGF0Y2ggdXBvbiBuZXh0IHZl
cnNpb24uDQoNCj4gPg0KPiA+Pj4NCj4gPj4+IEZvciBDTlYgQ2xvY2sgTW9kZSB0aGUgR1AwIHBp
biBpcyBjb25maWd1cmVkIGFzIERBVEFfUkVBRFkgb3V0cHV0Lg0KPiBUaGUNCj4gPj4+IElSUSBo
YW5kbGVyIHN0b3BzIGNvbnZlcnNpb25zIGFuZCBmaXJlcyB0aGUgSUlPIHRyaWdnZXI7IHRoZSB0
cmlnZ2VyDQo+ID4+PiBoYW5kbGVyIHJlYWRzIGFjY3VtdWxhdGVkIHJlc3VsdHMgZnJvbSB0aGUg
QVZHX0lOIHJlZ2lzdGVycyB2aWEgcmVnbWFwDQo+ID4+PiBhbmQgcmVzdGFydHMgY29udmVyc2lv
bnMgZm9yIHRoZSBuZXh0IGN5Y2xlLg0KPiA+Pg0KPiA+PiBUaGlzIHNlZW1zIE9LLCBidXQgSSB3
b3VsZCBraW5kIG9mIHdvdWxkIGV4cGVjdCB0aGF0IFBXTSBhcyBDTlYgdG8NCj4gPj4gb25seSBi
ZSB1c2VkIGZvciBTUEkgb2ZmbG9hZGluZyBhbmQgbm90IHdpdGhvdXQgU1BJIG9mZmxvYWRpbmcu
DQo+ID4+DQo+ID4+IFRoZSBBREMgYWxzbyBoYXMgYW4gaW50ZXJuYWwgb3NjaWxsYXRvciwgc28g
aXQgc2VlbXMgbGlrZSBpdCB3b3VsZA0KPiA+PiBiZSBtb3JlIHVzZWZ1bCB0byB1c2UgdGhhdCBh
cyBhIGNvbnZlcnNpb24gdHJpZ2dlciByYXRoZXIgdGhhbg0KPiA+PiByZXF1aXJpbmcgZXh0ZXJu
YWwgaGFyZHdhcmUuDQo+ID4+DQo+ID4NCj4gPiBUaGlzIENOViBpcyB1c2VkIGluIHRyaWdnZXJl
ZCBidWZmZXIgbW9kZSBhcyB3ZWxsLCBub3Qgb25seSBpbiBvZmZsb2FkLg0KPiA+IEluIHRoaXMg
bW9kZSwgQ05WIHJlcGxhY2VzIHRoZSBpbnRlcm5hbCBvc2NpbGxhdG9yIHNvIENOViBpcyB0aGUN
Cj4gPiBjb252ZXJzaW9uIHRyaWdnZXIgKG9mZmxvYWQgb3Igbm90KSwgd2hpY2ggYWxzbyBpbnRy
b2R1Y2VzIHRoZSBhZHZhbnRhZ2UNCj4gPiBvZiBoYXZpbmcgYSBtb3JlIGZsZXhpYmxlIHNhbXBs
aW5nIHJhdGUuDQo+IA0KPiBZZXMsIEkgdW5kZXJzdGFuZCB0aGF0LiBXZSBqdXN0IG5ldmVyIGRp
ZCB0aGF0IGZvciBhbnkgb3RoZXIgY2hpcCB5ZXQuDQo+IFVzdWFsbHksIHdlIHdvdWxkIGp1c3Qg
dXNlIHRoZSBpbnRlcm5hbCBvc2NpbGxhdG9yIG9uIHRoZSBjaGlwIGluc3RlYWQNCj4gZm9yIHRo
aXMgc29ydCBvZiB0aGluZy4gQnV0IGlmIHlvdSBoYXZlIGFwcGxpY2F0aW9ucyBlbmdpbmVlcnMg
dGVsbGluZw0KPiB5b3UgdGhhdCB0aGlzIGlzIGEgc2V0dXAgdGhleSB3YW50IHRvIHN1cHBvcnQs
IHRoZW4gd2UgY2FuIGRvIGl0Lg0KDQpJIHNlZSwgYW5kIHllcywgdGhpcyBpcyBzb21ldGhpbmcg
dGhhdCBuZWVkcyBzdXBwb3J0LiBBcHByZWNpYXRlIHRoZSBmZWVkYmFjayENCg0KPiANCj4gPj4+
DQo+ID4+PiBNYW51YWwgbW9kZSBjaGFubmVscyB1c2Ugc3RvcmFnZWJpdHM9MzIgKHNoaWZ0PTgs
IHJlYWxiaXRzPTE2KSBzbyBhbGwNCj4gPj4+IGNoYW5uZWwgc2xvdHMgaW4gdGhlIHNjYW4gYnVm
ZmVyIGFyZSB1bmlmb3JtbHkgc2l6ZWQgcmVnYXJkbGVzcyBvZiB0aGUNCj4gPj4+IFNQSSB3aXJl
IGZvcm1hdCAoMjQtYml0IHRyYW5zZmVyLCAxNi1iaXQgQURDIGRhdGEgaW4gYml0c1syMzo4XSku
DQo+ID4+DQo+ID4+IEkgYWxzbyBkb24ndCB1bmRlcnN0YW5kIHdoeSB3ZSBhcmUgaW5jbHVkaW5n
IHRoZSBzdGF0dXMgYml0cyBpbiBtYW51YWwNCj4gPj4gbW9kZSBidXQgbm90IGluIENOViBjbG9j
ayBtb2RlLg0KPiA+Pg0KPiA+DQo+ID4gSW4gTWFudWFsIE1vZGUsIHN0YXR1cyBiaXRzIGFyZSBy
ZWNlaXZlZCB0aHJvdWdoIFNQSSwgYmVjYXVzZSB0aGF0J3MgaG93DQo+ID4gdGhlIGhhcmR3YXJl
IHdvcmtzLiBIb3dldmVyLCB0aGV5IGFyZSBtYXNrZWQgYnkgdGhlIGRyaXZlciBhbmQgdGh1cyBu
b3QNCj4gdXNlZC4NCj4gDQo+IFVzdWFsbHkgdGhlcmUgYXJlIHJlZ2lzdGVycyB0byB0dXJuIHN0
YXR1cyBvbiBhbmQgb2ZmIGluZGVwZW5kZW50bHkuIElmDQo+IHRoZXJlIGlzbid0IGl0IGNvdWxk
IGJlIGhlbHBmdWwgdG8gYWRkIHNvbWUgY29tbWVudHMgaW4gdGhlIGNvZGUgdG8NCj4gcmVtaW5k
IHVzLg0KDQpZb3UgYXJlIHJpZ2h0LCB0aGVyZSBpcyBhIHJlZ2lzdGVyIHRvIHR1cm4gdGhpcyBv
ZmYsIGFuZCB0aGV5IGFyZSBhY3R1YWxseSBkaXNhYmxlZA0KYnkgZGVmYXVsdCwgdGh1cyAxNiBz
dG9yYWdlIGJpdHMgY2FuIGJlIHVzZWQuIFRoYW5rcyBmb3IgdGhpcyENCg0K

