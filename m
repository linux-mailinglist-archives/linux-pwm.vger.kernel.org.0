Return-Path: <linux-pwm+bounces-9112-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOReHHY6FGpDLAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9112-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:03:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95B5CA3EC
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254D33008200
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB73803DC;
	Mon, 25 May 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p1biV6J0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC531F9BD;
	Mon, 25 May 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710577; cv=fail; b=gLsyP6cLDdOJYgiGYZbCFBQumvK3aScAt3BQylkCRGt8w7LA7lhBPNoSk1F+/EZ1BdVum1ohG5BgcbAiImsB0377VQWxTfiksgJ4+oQl5gPZczQXjjVYc6iO4tYxn7HeVFoCh57I13ON9LAWc6BB9yhySUZzW+h4tESz5DokJNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710577; c=relaxed/simple;
	bh=gIG80a7g56pX9vzP5A9A78EfHMxY/hK7Rj/tGORAaI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFlqk4c8jQjhhEIy3/wDL3LIAKdQZe2ZoUsrCetCyiNHC90gRRUseSafjGY31IXZ1RDrQ2+DkrujveeJ1pWyOrZriIqiOxm9vT5zmrCc248flR0EC35jH45lFFbFc6RVOotzK1V6NBvwxVI5mPsh6QaDBf/lYg92K35B3aGF7Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p1biV6J0; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PAVVZ6753662;
	Mon, 25 May 2026 08:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gIG80
	a7g56pX9vzP5A9A78EfHMxY/hK7Rj/tGORAaI8=; b=p1biV6J0R0VmZ+YrU7Gc1
	a+4wQOlTc1c+Hv5ekTEnmqvclX44E04VcUzJJZ4ENLom7ZRdsNgMCsIwbD6fYnNL
	q9ufEpTFuVqc1Vn+mbrUSTUQMGF3fegn40u1bgUWnyTkYGbEMnQ7fyfejXl8Q6uA
	BWfhpRUOopjTyZVK73/3iCyaotHrk49A98Z4AaOGfqIsEBBy7WCzOOWTlW+v9Xa4
	Gd3722BknV+FmLDsjx8xP5AYEB3SnLfg3bDZ26QNxotFV+6Rfg3jDUz4fLfpKAgw
	Ifpj/oyFHQUNVp7ATHqq22nO7cnWDFDRLN6LTE13fDIqFVEDfia9r41xB2avCPU4
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgta3wq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 08:02:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQqo2MI9VqYbR55blwRBKrou7nXpf742dcEVMd+5nqzKN19rAaD4LnlybM+n6jfAogPz6DIpXZpjcUuC+Z4j/tv83Fnu6z+PWXzr3+SAwvwyJZjal9e5kSqtw2nfB/+PYqfOMLNooOX0LttbL/CXXleA7sWs+f9bFO6vOWkYrLUhey967iWX46f8aWeBnayo5Oueq6nXZUAEGV9MMEmfyzZorJ3uLXch9FyjzeS6O41JZ8i4CJ2RyRBxgrVIibR4z3ZYzhhrBEW2vesxoeFrP6UrvbCEdbLkaY74PNC6IidIQLkiuuN5GS1fPxnZEUmaizp7ne7U71zXw7IRBZl8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIG80a7g56pX9vzP5A9A78EfHMxY/hK7Rj/tGORAaI8=;
 b=NtZGw4jwW5l+7h1zohAA9sZEsQ5BnVI0TSm+ti3ziTA/iKfLZMW7HHy0QlKQPraqOhlLqNylBvlaOJ4OHbg/r7TDBAXz55YyE6AP/c/AnkXwH4plDvQ+kGm4fBxdWU9+e860DenWX4nhMUCHhaj5BnnkrJsHh8EuEV1WBj3GfWvNEUOogTYhUslZr9aXyfmNhpef1sDXPepyuaUIj53yPbcn9NzR8eINtrHQ936I+3BszmEYXR61qlFSH7Q8ou+HoOCd7tx0OiQGySfHFxxBrunxzJk7m5WlDrYuO6DhQ87pxccx5J+rKBtfXR3CBJyx4I7GNmZsDFwpzLkWvuqPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:02:23 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 12:02:21 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v13 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v13 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHc7C6yq8/Qp++HwkCGZM+fJjZWdLYeolLg
Date: Mon, 25 May 2026 12:02:21 +0000
Message-ID:
 <SA5PR03MB842591AE2C7AE7F0C19AEF8FF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
References:
 <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
 <20260525-ad4692-multichannel-sar-adc-driver-v13-3-1b7626d3b35c@analog.com>
In-Reply-To:
 <20260525-ad4692-multichannel-sar-adc-driver-v13-3-1b7626d3b35c@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|SA6PR03MB7904:EE_
x-ms-office365-filtering-correlation-id: 53d8047d-8ebf-4cea-c97d-08deba557a1d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021|6133799003|4143699003|11063799006|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 BYfN63gt8LoyJSwmK1KrfWqHDdIJLapIkW39fxSlzCJlV5VP6dakYDmCVAMVvFCSQ+6EBoxc+WqGvUqVE3roi0VdW6NtTKBYup0SxzbA356rOFFJfvX/Bfe+Qq587vWaAaDJKkL03kpJFMGSuLOP2+LjDtMJSIP6S6yjutmIINdjYT4+dkXUltlAn56/eHVYh//sZC0YkMfAEyn1Wd07bGmvBc45INP+5sEn7CWYvB8/PdXVZY0y6C8Px+fiX0PtAeIKDXyGQDaQOPKVzqrdFvoGHwBxxZIuQkN1Iu2+LTS36UbutqVApj2VzsD0bgZwoOpfQ/GcMrcFEG8vUqJl61mQlPEEAIkoCXCHlIXC+iXTr9eR01g9RhmI1M5BXLX82zc8PnWs8rWWq8GdVgwYppQFdNWdgzgbz10nqONyaGeUxrN0WglDV0LP5fv8oC1t44bWFXua6EBWBzW0bpNpl/2TPZgR9S9pYHp3OBv/ZlendAfaX/wrE+ydJGcD3h9I37/m6N4I+Bg1416dFxxWGLnaDb+4s2zSlYJTqIbjiz+wsUDca0ok/eShp6TQwqY+GsOlpGWgiZGp+YNV9QX6FRl5BtVLOIQvAa8gBSyvSY/PC1156v3cUcgACN1j2k+DDzlsoTt7goLGPz48D/K2F2iiwanyVWlFhsaEjZ7EVljskWppHaWxQXwFrUf1e+3rH1x/bdYL0oJOREzslquNCoGRBdsL82zavqATpWIGazSKXaYOX7mzd+5OuACZTTNlO9UaYJypiUlgHILKvEZ7aQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0RxeWc2dVJNMW5kQ01HVDMxSnVILzdnemYvZ0JBbktWbU0rRWlVNFhnYkJP?=
 =?utf-8?B?SXhzYTBBSTdhK2FUK2VXdDA1VkR0aUViNXNZeUVncGpQZDdQQzZaMC8zdkRR?=
 =?utf-8?B?ZkZFZ2pXU2NjWGYrWmJkdDhDdnhtMGxqT2VhR1QyWTFLM1NMZGE3cXdpSEtw?=
 =?utf-8?B?L1dXZnBWemo2ck12VDFXYitIMjVDS3kraGhZd1ZtRk5MZm1IWVFBWVhiK0VG?=
 =?utf-8?B?U3RvMm44QTdFMHdTQXorMHNjUDhTWWYxODhzMWFpbkhETjA5d3MyYUdZb3Rh?=
 =?utf-8?B?SjZCTnVNL3owdkVSL3dwc3I2Q1ZvcDZycXY5QnA1YS9JRCtlc0VycXpHK0No?=
 =?utf-8?B?OFRldGRqbnhBTHcrYkNSV1BlOUNsazJZanR2Z3hpUS8yNnJDYTA5WW9USjAy?=
 =?utf-8?B?TktaUG54MG92L2RZQzRVYVp3aGhmOW9iaXpNc2VicDNNOUR0b1FIdDFLQUNE?=
 =?utf-8?B?Zyt3L1hLVXZYYzNJSHRCdHFVZlBnSTNNMlRvbVR1OEVYM3p1VC9ISFNWWlY0?=
 =?utf-8?B?eGZpY2RUSEhZcElUY0pnNWcwamxhRUFNMjAzT2FCYXRldVVXSVlsZ3RKd1k0?=
 =?utf-8?B?VWp6alJQTWRZb2NORjRHdHRYaUtZclI3UXdNZkxIVEhGRklWQ2RCR240LzVU?=
 =?utf-8?B?WWZFK1F0Q1pNajZMbVk4dnF3UUFOWjBsYjdJeW1lOEs5QzhRaUJZdE1nWDVM?=
 =?utf-8?B?NTNiRDlyc25uTnNwMFpNYWlhdTdHa0paM0M0UGhWT2Z1ZGlySmhWRVR1eGsz?=
 =?utf-8?B?SlQ3diszYS95aGFJWHBQMUljZzc4cnVhSVlKY2FrbEhYWmtNT1FCQ1pvTy9i?=
 =?utf-8?B?akFYZEFoUHRlTVE1UWFHWStKSFlJMlQ0VDZBbGRYNE01NXYyVFVYT0JaTUNJ?=
 =?utf-8?B?YWJlUVhvOGxNUCtHL0dRWEo5Q0dSdWxnaVMrc0VNM2NqZmxpdEJDK0thVGY3?=
 =?utf-8?B?WXl1dndzZ3dmWGsvL1ByZWN3cGhGbWlRUEFnMGtmWTdOQ201MXZMYUg0TVJ4?=
 =?utf-8?B?V1gzUmhZcE9pTjBHNHpTTjh6NG9ZNEMvSXFzS1p3a040SXUzbk96RWR2QzZE?=
 =?utf-8?B?YzBiSUVTVUFlZ2orRU5aekNPaUhXdEFCSEc0Q2lxNkpBQWRuQnUzNktRcEFv?=
 =?utf-8?B?TXZOTC91NWJJeHBBTUorbExYQTZaU1ZZWGRQblpNZGVoZDJaalBGaG9JYnBE?=
 =?utf-8?B?TXQ5cGYwbm8zTUNKbStzNDBORDZFMmpmMjhZa3hSTmF5eTIyNE1kMTg0WENC?=
 =?utf-8?B?QnVkNktZMDlBaXJ2dlY3MlVpQXpHUlMwSE9pUWFpdXl5aUhSMTZRK296aDNL?=
 =?utf-8?B?RzJSSzBWZ2NGRVV1alNuODJBYXlkckUzZE1TQ0dYOVlmYmFvTlZoV0FXR2ZD?=
 =?utf-8?B?TVJOMS9mNkZzZ0daa2Y0dG5SK1E5YkxrSjI4WmlMQ1d4YVRzeHlRT2FWN09s?=
 =?utf-8?B?Sjh5MEJ1MWxMRzQ1MEtqV1FkdlZRdUk0N2dtRnZWMDZuMTlRMmdxL2QrVFVR?=
 =?utf-8?B?Qk51NzQvZDFZUU1zdGZTTWZJU2RsQU9tWkRKVW9ycjB6cWxCTUpCVzBRcWN3?=
 =?utf-8?B?NmNYcTNNcXFhMmV3UDBvWCsrMTdES3Z3cmJCcnVyK1o2d0F5T3lyUmU3NG9C?=
 =?utf-8?B?cnEyeW9CY2pVZnF3QmRMTmdSU0JVWW5IRlNpV1FFZDBCbStnYWpaLzZncDRM?=
 =?utf-8?B?Q3J4QkQreVorUm96QmpGQVFLbnkrMXh3cjlTcW5FeWxVcGJmTS9wRmNKWks5?=
 =?utf-8?B?QnZBR05NOVhoZi9NSUhaUHNaZlZjM1NKYUZmaWw1eXJSVGdIcFVIRVJiRXRL?=
 =?utf-8?B?ZGFWTXFzWTlIeGFVaEo1cmZFUUIvQ2FjbjA3OS9VY1lmZkk2S0hKWGt1bkNT?=
 =?utf-8?B?QXUzT0wrSTRvUGU0d3hqL2lBODB1QkRNRkgxUUh4TDFzM2dxU05UaFc3RFpX?=
 =?utf-8?B?d0pvQ04wbThIZCtVMlZNc3Zza01QV1daSk45c2hoTWdFY2Fhb3Y3YTBjTU9n?=
 =?utf-8?B?aWtQeGVBMmVmaE1rS0ZMRjlsTlRDckJveXNRRFFpd2dmd3JtSVIyUlJzeSta?=
 =?utf-8?B?TDdmdnR2c21TY3hGdS9hWHpHenZEWWJ1cjFJWkt4T1F2Q2IyQk5SdG1MdTls?=
 =?utf-8?B?cm9MMS9nZEtubnUraGk3SVR2ZFBTaitqTC9xWlRBT2d1T1VtTm5KcVRtdlZ1?=
 =?utf-8?B?aW5NS24rYU1lRGRJZUpvRk8yRk1EVnBHMHlmcUZPeG1NZ0I2Y3VTZGg4L3ll?=
 =?utf-8?B?MU8zMjRuUDRTSldkclAvaENKL2ZLQzQvbnZuTGlqcm1xeEtPeEZnd0dlK1Zl?=
 =?utf-8?B?Z0M3UW8reHA5WmdKNlJCK3ZEKysvQU9kNTNYWUN6RWo0UEhMcEFxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jYjT9PFLZAU1x7TXHoxowJLDyD6DNVEGFfP/SW8YdHkdS7whDLatj5M3bbzOIBRGKLAm5j7PmHrxVydlAbwoL4rSTcnAds4BK5Vcbc/qT+VsobyyZgLtmHsdpJ+bzTOIaHPS4s/BsvYEoIjnd5ois2Ue0NzOK1ubmdTswUGu/oFYxTJ30lEU4RGGrnrE4AcuG1eiiONoOO/JomQ6yUZh7cjBFIE9KyjvoGBkPzXrqjH2T3swmeeSvJMmc6IScUhgjvSOVWK03xQMk8Ebx/ocDGxtq7WkeuRGhkBstgZCJ/PgES9aQedqz2QBdNRldbKW3xJR8C5OGi5iqD/BKHq7Pg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d8047d-8ebf-4cea-c97d-08deba557a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 12:02:21.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdm3FsyURuEImRmOWm9X5fmq6chNz5iBHxosbfsZWFEFDwncsz6Zg4pRqAehz0uiNQqs5t5oWjlEDM+6MsyQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904
X-Proofpoint-GUID: nJyOCCeksdMLzC_WeXr-3bdHJeRAKG0O
X-Proofpoint-ORIG-GUID: nJyOCCeksdMLzC_WeXr-3bdHJeRAKG0O
X-Authority-Analysis: v=2.4 cv=L5EtheT8 c=1 sm=1 tr=0 ts=6a143a53 cx=c_pps
 a=Sa5LwqyZh1jbhgnehO2qiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=nz7eydqLr3yPts_NIVMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyNCBTYWx0ZWRfX8pnx8QaJIMXP
 cK99mNSIx0b1dotqPPxQLpbJVlFrdOgJS/jvZRL2kEhIJ4epFmc3TQ5zlwl3ZBoFoiLJ72Jxkxv
 CoNk8dKZdXvWwpv8hd1C5FmBgO+9qimfwZG1TOzUzbtBuRGP9FWzOlSCHlYUEu80MutLj8VIUIm
 tCINP5m3cFG75Rv3cWXT/Bocv8hu0yPlhomMHPAYw+ITnmEw8eQv3P1KeFqO3YFVPAttgL7oava
 2X7woBlfm3sb9YrjFisgctvl9pgVwuXD1ZJkUrm/ObvIFoQ0HOzCIJ2QWrqJvbQZj30hSVra+vw
 mkbPYeZeaOPdVXA+m7Ax8NCpVYukS07adXQVVeiP5iMVaMxuDn1m01JOaDI+4/fN85lEKhFq22v
 mNxgACWXk9CrEqCkleWipN87DyymVI588Np6hGRv4hqZ+RRurBaoITmR3F0IrzIMAzhSUH6Ba0k
 rZmfg7vcowM1VV5fV3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250124
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9112-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SA5PR03MB8425.namprd03.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_SPAM(0.00)[0.526];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E95B5CA3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBNYXkgMjUsIDIwMjYgMToxMCBQTQ0KDQouLi4NCg0KPiArICogYWQ0NjkxX2V4aXRf
Y29udmVyc2lvbl9tb2RlIC0gUmV0dXJuIHRoZSBjaGlwIHRvIEFVVE9OT01PVVMgbW9kZS4NCj4g
KyAqDQo+ICsgKiBDYWxsZWQgZnJvbSBidWZmZXIgcG9zdGRpc2FibGUgdG8gcmVzdG9yZSB0aGUg
Y2hpcCB0byB0aGUNCj4gKyAqIGlkbGUgc3RhdGUgdXNlZCBieSByZWFkX3Jhdy4gQ2xlYXJzIHRo
ZSBzZXF1ZW5jZXIgYW5kIHJlc2V0cyBzdGF0ZS4NCj4gKyAqLw0KPiArc3RhdGljIGludCBhZDQ2
OTFfZXhpdF9jb252ZXJzaW9uX21vZGUoc3RydWN0IGFkNDY5MV9zdGF0ZSAqc3QpDQo+ICt7DQo+
ICsJaWYgKHN0LT5tYW51YWxfbW9kZSkNCj4gKwkJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhz
dC0+cmVnbWFwLA0KPiBBRDQ2OTFfREVWSUNFX1NFVFVQLA0KPiArCQkJCQkgIEFENDY5MV9NQU5V
QUxfTU9ERSwgMCk7DQoNCk9uY2UgYWdhaW4sIGFuZCBJIGhhdGUgdG8gc2F5IHRoaXMsIGEgZm9s
bG93LXVwIHBhdGNoIHdpbGwgYmUgcmVxdWlyZWQuDQoNClNvbWV3aGVyZSBhbG9uZyB0aGUgcGF0
Y2ggdmVyc2lvbnMgYWQ0NjkxX3RyYW5zZmVyIHdoaWNoIHdhcyB1c2VkIGZvcg0KcmVtb3ZlZCBm
dW5jdGlvbmFsaXR5IGZyb20gdGhlIGRyaXZlciB3YXMgcmVtb3ZlZCBhbmQgd2FzIHVzZWQgdG8g
c2VuZA0KMHg1MDAwIChTUEkgY29tbWFuZCB0byBleGl0IE1BTlVBTCBNT0RFIGFuZCBjb21lIGJh
Y2sgaW50bw0KQXV0b25vbW91cyBNb2RlIHdoaWNoIGluIE1hbnVhbCBNb2RlIGlzIHVzZWQgZm9y
IHJhd19yZWFkaW5nKS4NCg0KQXQgdGhlIHRpbWUgYmVpbmcgdGhpcyBpcyBhIGJ1ZyB0aGF0IG1l
YW5zIG9uY2UgdXNpbmcgdGhlIGJ1ZmZlciBhbmQgc3RvcHBpbmcNCml0LCByZWdpc3RlciBhY2Nl
c3MgdG8gdGhlIGRldmljZSBkb2Vzbid0IHJlYWxseSBleGlzdCBhbnltb3JlIGFuZCB0aGUgU1BJ
IG9wZXJhdGlvbnMNCnVzZWQgZm9yIHJlZ2lzdGVyIGFjY2VzcyBjYW4gbm90IGJlIHJlbGllZCBv
bi4NCg0KSSBhbSB2ZXJ5IHNvcnJ5IGZvciBmaW5kaW5nIHRoaXMgb3V0IGp1c3Qgbm93LCBJIGd1
ZXNzIEkgZm9jdXNlZCB0b28gbXVjaCBvbiBPU1IgYW5kDQpDTlYgQnVyc3QgTW9kZSBsYXRlbHkg
dGhhdCBJIGNvbXBsZXRlbHkgZm9yZ290IGFib3V0IHRoaXMuDQoNCldpbGwgbGVhdmUgdGhpcyBw
YXRjaCBoZXJlIHRvIHNlZSBpZiBhbnkgZnVydGhlciByZXZpZXcgY29tZXMgaW4gYW5kIHdpbGwg
YWxzbyB0YWtlIGEgbG9vaw0KYXQgU2FzaGlrbyAsIHBlcmhhcHMgaGUgZmluZHMgc29tZXRoaW5n
IGVsc2UgYW5kIGEgdjE0IHdpbGwgYmUgbmVlZGVkIGFueXdheS4NCg0K

