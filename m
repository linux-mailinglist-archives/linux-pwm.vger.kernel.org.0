Return-Path: <linux-pwm+bounces-9114-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD4oNj5BFGpGLQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9114-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:31:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071E5CA8A5
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD4743005A89
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBF8382289;
	Mon, 25 May 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0IkOG9vG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D123101CE;
	Mon, 25 May 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712316; cv=fail; b=NFNaV9VjJSHB6uk1LPqo4Zo1XYfvBB41fxO5a1N2eu35AR7XQyMLqQHp5XAALTH8MW6KhXEB5dBwSLvqz1EPjLL4rYnG4ilwqAnEdXBl9xan3n2I34r4k6/0G3pBtc41+Eo32ruEQqlJZ9rKtRtKI9ZSbLQ8CmagQN9FDhOADWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712316; c=relaxed/simple;
	bh=LVFx7guAxF1PuHHezNjumQcFfm8WD9DK9aWzJfwECvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYQBfsj163La0vyCYdLZHuwBgdJWpiEeGfGAQOpmAefKJAb+oCUvQ99hgFqang4z7Xqgb+rre/0AawQbhfXQcDV2rBKLk2sWo0TdR00IG/uNMPvycJUsihtQgcx+iISri7XRyBFx1qW7my3ZN8rDBHol8x6z507xaS2dG+mrHSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0IkOG9vG; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9xVlZ1018769;
	Mon, 25 May 2026 08:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LVFx7
	guAxF1PuHHezNjumQcFfm8WD9DK9aWzJfwECvI=; b=0IkOG9vGwuHWKL4WNFJvK
	JsihUOROuKokx3NPS1TPBPL6bLSJWdXgYqfMp53EQFVD7iFWF1YE1CRQikyRY+RS
	LRbiDg80K0SnTVE5ygm0VyiZVHrjlTM1XerE9JeRdd2WazPtYIJE4mVJXhfoVv7w
	scT52pnq5x0Exn50wh6K5nj8SLnPRU46EG/ODP2MCFuhPY60qVTZmuuzpfCs4p9+
	7KIeS+tevy2ViZMhsYQUtlHO9HbUrIAucxv2ymcVrJaNBP4n6XkT+2Ld3zYeogrO
	HQkdQr5gVoj+DAD9McFpAmz4tFAaDWY+TOZYR6JxPJ2NwSwLupiw/ee5irgNSG6i
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4eb608ws21-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 08:31:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8Gjq213DT1lDbz6wAc1Csb+vuKKzjlR1WMgEYVFgFfxbYu+kaX9cJBZJ7xyQ6bLWMwQJHG3h/ud0XSwN3IN0wlzOrcdMaspe3PyQJJjItdkh+J6k0w5T5mjBj7Jn+OAPqYPtzGFqxGwC2u3tvK0SJUEI3Sc6+D1uTIihmNjvlvf4gPrXiTxFoB8/QXhV/HSlsyQidAwH8m5x0G4uwV7nInu6QNJGLfqpQvRalvTyCsNmrhYW3HZVactvNgRE2zcHzvvtkFeWd+ceEJSI7kl37kKtMo/5eGnRlxgbojHQBDscpGonKiiq3Rh0nIA7Bj+tPLA4xwyD3S3dEMNVrfNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVFx7guAxF1PuHHezNjumQcFfm8WD9DK9aWzJfwECvI=;
 b=CP5j+IAATe4RGmsvNVLCIS6Pyo2Xldoidmv+9JTepXZ0a7sdiQ5/u4xCcx3C/tJbhFgsyxaaPBg1pLUC5KGN3447nzeqfzpBvLi4XgDRZiCdnghCagspsAmUJuG0I2qj9mznkfnKyO8OgJtTQ4n7Asx4vxxbeDC73CWjHGAyPClQsgaQbrXbvc1sAgu6O1wM7Lfmp3FyQzW1FPth1BVIxf1/RG6zxAZ1IPgcrZ1XrsXSXtnbPJH19HrVJYIZPiaj9rYuWBzmX10JAfmW1X3kKn4Ed2/HzBXgeP/pGxARal01qEY5p4Ees/LuzqCbNfj+5jgDLldRAV30rMWB3qNmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by PH0PR03MB6592.namprd03.prod.outlook.com (2603:10b6:510:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:31:26 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 12:31:26 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: RE: [PATCH v13 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v13 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHc7C6yq8/Qp++HwkCGZM+fJjZWdLYeolLggAAIrxA=
Date: Mon, 25 May 2026 12:31:26 +0000
Message-ID:
 <LV9PR03MB8414D02F4D7BFABAB1E550F7F70A2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
 <20260525-ad4692-multichannel-sar-adc-driver-v13-3-1b7626d3b35c@analog.com>
 <SA5PR03MB842591AE2C7AE7F0C19AEF8FF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
In-Reply-To:
 <SA5PR03MB842591AE2C7AE7F0C19AEF8FF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|PH0PR03MB6592:EE_
x-ms-office365-filtering-correlation-id: 0d060381-1f9a-4891-7ed5-08deba598a04
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021|4143699003|11063799006|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 D17hKBBKexo7ls8zv10aLd48kVcfj5jh+4lrF0kSLcncLoPAohW6CLCEq4YYH31q5TXHfR4aFWLMaKBXyiMuSiUW8MphQE1roVUEY+WrAlM0Exo4l6qtEEbtvDuFdmeCGsFs9oloKNUC7tSC+6GVTUYBKIBDUtXTEUg5PvCdkZLfMr0z2vedXfMLJugfp5Re9fUhhvTw5Xt/MjJHj5XjMBGVO5GOTRdUiRZ+17ORfcosH5l1xY7t5Uactj5+aDxbLPhHkH0nDSbDM4fwfjCnjd5zIUhMhG2dKEAdHytlYf1IpY3OTGf8J++tMZJGAQSICpdZOYndiMZ+PpsTVhuk9ynrcPB6QjT2/BS1AljPzmePE7i30rguHjL5v8irj1Watr9MDSiWXzrwa1dRTKFIKjFK0l/EMzHD1QclsTLW/ZVmZrYcq7YFmQpp0KVatjSsJ0HYJYEFar31/dVeqFrPFNlDJVf8YAeQ8n+kl9MjUtZeyu3tAdOUcer9mF2Soyf6ulKpOx4PIWGAxrKeCQiM3NZXA9SqqP6rDUNHC3h0tMX3FBdVw1xMP9mFjB5XHNe9QhOpkxk/xcD4jpZo+m9bfd5cRCcsWLm0/SqrefYlWfcHOXW7ALihdDcHPwfbhJzJjU+KMjZVtOGlXf1Ts0FmeOwli82Yqq7fYXrh2V/yBPAowpWnoR/Vs/KrB28VnI1oSKGlxP4mPTo2asXsGIsMq8iMk/V54Jfq5LQ6qnqMpRD8jYyLUz7WXgsE16GMdquUdSew3eZho+ddTQIUiuIaRw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy85NVBvc0N4NVVDeTA0ZGpBbG04K29LV3hYUGxIQmNzaGREKzh2dmVjYmJZ?=
 =?utf-8?B?QWtWdmdWOGdHR1pxbFNXNnhGQXV2MXRlajJ5UWhBb2dTUldZUUJnWUVMS3l4?=
 =?utf-8?B?bVlYWmp1TVZnUUxOc3A0c0VlNSsxcXFkRlZKL3pwZGltRUkvdEJWeE1LanZM?=
 =?utf-8?B?eWhSTWZwblFVQmI2TkNvRTZ0OHBTSlZuSnhQTXNXdDJneW15bkppazlFMjVO?=
 =?utf-8?B?ckZ5WVJEZFErWGZ6bHNJK2lMVzArd2xMYTlhTXRqSUdvZDdtcGYyamovdjFG?=
 =?utf-8?B?dGdKcHBLYzV2c1JRVzhEZnlUdTBhRXBnY1d6WU03anh1RlpaUUhOemxOWHFJ?=
 =?utf-8?B?QTJXMXhKdVpySG9RV3Z2eU1DdFY0Kys3a0hTRXN4a3FsRjcrUmVnaDFLdTdi?=
 =?utf-8?B?bUNpMm1UT0V5bjJxb2lFRWtxeGV4SnphSCt2TjNlL09GRENJTXBiODZGTFF3?=
 =?utf-8?B?STZFRThld1U3RTlBY3NlMHhiWW5aSWtUZlhwWGg2ek4zQmYvdGh1dHBQS2p4?=
 =?utf-8?B?c3A4OFZtVk90UTcxeGcrT3UrVk5YSEE3amNTajVJYk5SVnc3QVVpMnl2YnM3?=
 =?utf-8?B?MUpQMGZZaTl0WW5TWk9vR2owNm5tK1YrbkJvL0lkakpLZmlnUDhka2NvNFlG?=
 =?utf-8?B?UGdQV2gwUGkwZjJYSW1uSXloN01Ma0szSDZxZ3JKRnJhK2h0Q0dlTzNqV0pJ?=
 =?utf-8?B?T0FwdlhkNlFyWjZsT2lzNzEzekg0M2dKalJyc0owaTdsaXVJbzN6UUx2KzUx?=
 =?utf-8?B?U0dZNlI5VWwvWGtYNTg3ek5yUGx5ZzVOYUpUNFREQ3VRYlh0NWxWNGhJUHRG?=
 =?utf-8?B?ek5JTnU0UjBYN2Rkb3ZSdzRJMTZyTjhLUk1VanNnNTRNaE5pRG9jTlhlenhw?=
 =?utf-8?B?SE0zdUVMTkFVWEZFVnErbjhNZlFyNWZMSlVncUdjUEd3T0tpNjd1aURxQW1Y?=
 =?utf-8?B?bFZYWDhhVldHdkJSZkcwNFVUVEsyZ3gwTGxZUnZPbFNQTThwcWxLcFlWbUt3?=
 =?utf-8?B?elRDcUduQnRQSTBrbFQ3T2pnWmtGMlJIM3h1anYwMzRldTY0UTVMWW55OVFG?=
 =?utf-8?B?eWswSnF5dGxzNjdqR2sxOTRPMVlYUW5lY1BGOWZWeXY5VDI2NXgxUTk3d3Ri?=
 =?utf-8?B?a3l2dmRKNHU2S0pPZVFpUjBrRmdmcTZmVW9YVGVHQ3h5TDk0Umc1QlpBV0da?=
 =?utf-8?B?RDZOZ1hsOXRCWEJsRURKVEhwd3U2SGxsWmduU2p2bjl5Yi9VMmE4aC94NVpG?=
 =?utf-8?B?Wk5WSEFuSlU4Tnd2cjNNVGE4WGUrRG9ubXNuaGFSN3ZRYXlnUVFWYjBEVEZq?=
 =?utf-8?B?ZS9TV3ZKT0R6b1hyYjlNN1ZPSE9vK29DNGZNaWozSEdtRitQL25CVXBENlBw?=
 =?utf-8?B?cS9tTUsvdlFnSXF5K2VsV2dBb05VNnJROElhM1hlUzlKemZZZzRYTlZrTU9C?=
 =?utf-8?B?MkVjUmNLVkJyYW13WGFBTmZiSEZqT1dVZjhjWkdOVkF3NUxtT2Y5UG1hbmVr?=
 =?utf-8?B?U0VqYldQdjVQUUgzMGZZMTFybHlFQUlIaFd5YzV4dXlmbHJxYWpQZDlWdXRn?=
 =?utf-8?B?ZHUvczR5cDVlckJpVGFYdW1BSVhOR2YvOCticEM3TXpqYnlpRFd1MzlIYmQv?=
 =?utf-8?B?V3JsOXV1MzBFTHprNTZzUlYwQ3ptMDAzT0hKS05tSW9jWXhNV0ExMVp2U2pN?=
 =?utf-8?B?T3k4N1JINFpUUHZ0RUxWQ0hCY0RkZ3RwVXU5QSs3b1NUUTBKTHB3NFlnWi82?=
 =?utf-8?B?MnVtaFhmU0FtT3BiektNeXh4N1NRa2RJQ2tJTmplY05LR0pPWGJuN0JvY2JK?=
 =?utf-8?B?cU80cnFiaFljZHc0eGVFL2xhTEtJaVVBeVFZckhvYzVNVUxMeXlpTlZtdStZ?=
 =?utf-8?B?Ym5kZ2RqdnFvZU04S3JnMUFyVDd0OTFtSkEwdnRvK1dMWkJHRTBlRUhvY1VC?=
 =?utf-8?B?MjZCV21tRkJXOVR1M1JnNkZzTFJqWURmZzA2UjRHdFJLdTRNQUtIaUV2TEZM?=
 =?utf-8?B?d2l5UnZTZ3RhWEZVOTEyRGN6dS9YTVNsdEErbEo0cUpIV0Q3eHdXeDFKNjZ4?=
 =?utf-8?B?Z1lOb2FaS0d0YWhZTHdJbm0vNVg5Z1JkUzdEc2RuUnN4ZlBvQzVkWjl5TVR6?=
 =?utf-8?B?blFmOWJRMlI4MmV6OE9nNCtrYlVYQndPM1ExWFM1VTdycXRiNFoxd21vZTJy?=
 =?utf-8?B?bms4d1lNeXloUHlUOXd6SStWenFHa3lZcURUY3JNNWJYY2JQYnBIQVBsOUc5?=
 =?utf-8?B?M0Z2OEhaS3VIVmVKZktMM3Z2elh4OUJtVmYwZmk5Y2ZMWGcxWG0zRWdxdkRx?=
 =?utf-8?B?QzRkV3B0OGlDN0oxUHJSL1dIS0NZVVNuWUp1bEY0L1duR3BwUktZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VCN2G+/tpBkrUKmYwXvRLHQSPaCZluSuONPOjPLAg5Fbyv6IxUAO6rkzRZXYcN0GIKqBcur7UDfO0ZLv7dYiK7ltLovpbDhI94mzMlpT/NMBvJSw4MfEOz6KYaX9KOWgkTAVzTUZ9vXUYCaQzx1O6qrD40buJvkobkUfEgwb4eId2Tt8vjemuxUtg5f0azAxgcXCojnzZPBwSeZAdevU1q/pccilcaXbh9KOx2Af1kcPvcUAJpcBEmQ01H9r5+oz1g028rg9JP7sl1d1xtrUmf53xt/yx+QdjDbNSPJ86Gzs3D/DzKFIV8K0BX1jKfAu6MmzykJ8vQycf4pHGwf3MA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d060381-1f9a-4891-7ed5-08deba598a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 12:31:26.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lr5h7S4B2Sxe3+keTOTWvqW6XzDe3vFer5gxtmZDynV8ZpCgqUDz4m3PhzBkpYyu8iizxZfpZCgMNDeaG8QuFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyOSBTYWx0ZWRfXzaFtJsLaJWns
 bEyqzDywgSIVMlcCABR5QZC9XYpNFfK8+g61wD4WNFINjKFnhC2Bf6DDqy3YDnFZTaeU7rjOK3W
 e0gu3ANmozwIb9M/ivo/QH05WuNEh+nU+sJsXRMJ/3cqCiy9RCRO/Hu0J8KPRyvaEP6cTib6md6
 GW+Ndzz/N0fxd46Z/MQ4PC40v6c8sZgZ7lYp9np+o9T+8v9hj57YiyoWOkpvoaF0w1LcN+bwW5H
 LYWkMgUKEA1np1T0fHeaszQhThFqlu9YhW7FVl+LVdHrF8+boVW4uY2wMnfR301XzUS0eW+4+Kc
 Od7dUyqhvVbv3oR3P3hMRoQKPUA2FZ6SI8KIn96y9dATGuaBk539GWAxID3v4usX99LSXbE1F75
 ww5r9aANCRERTpKpzfEMK1gdDMGtN/wwvBDxKiApu0FvLPgia3Gm/FXNyM3r8zao9ySn7Mcg39s
 PD+/b2YuFfDNl0ZP0fg==
X-Authority-Analysis: v=2.4 cv=VYDH+lp9 c=1 sm=1 tr=0 ts=6a144123 cx=c_pps
 a=/fsfGrOPy16csppsbskbtg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=gAnH3GRIAAAA:8 a=xxH_YHIcqme0N4bohcAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XB1PsCP-qFRh6CbnB1LflYa9CjGMc6dm
X-Proofpoint-GUID: XB1PsCP-qFRh6CbnB1LflYa9CjGMc6dm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250129
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9114-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_SPAM(0.00)[0.527];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9071E5CA8A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FiYXUsIFJhZHUgYm9n
ZGFuIDxSYWR1LlNhYmF1QGFuYWxvZy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDI1LCAyMDI2
IDM6MDIgUE0NCg0KLi4uDQoNCj4gPiArICogYWQ0NjkxX2V4aXRfY29udmVyc2lvbl9tb2RlIC0g
UmV0dXJuIHRoZSBjaGlwIHRvIEFVVE9OT01PVVMNCj4gbW9kZS4NCj4gPiArICoNCj4gPiArICog
Q2FsbGVkIGZyb20gYnVmZmVyIHBvc3RkaXNhYmxlIHRvIHJlc3RvcmUgdGhlIGNoaXAgdG8gdGhl
DQo+ID4gKyAqIGlkbGUgc3RhdGUgdXNlZCBieSByZWFkX3Jhdy4gQ2xlYXJzIHRoZSBzZXF1ZW5j
ZXIgYW5kIHJlc2V0cyBzdGF0ZS4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgYWQ0NjkxX2V4
aXRfY29udmVyc2lvbl9tb2RlKHN0cnVjdCBhZDQ2OTFfc3RhdGUgKnN0KQ0KPiA+ICt7DQo+ID4g
KwlpZiAoc3QtPm1hbnVhbF9tb2RlKQ0KPiA+ICsJCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMo
c3QtPnJlZ21hcCwNCj4gPiBBRDQ2OTFfREVWSUNFX1NFVFVQLA0KPiA+ICsJCQkJCSAgQUQ0Njkx
X01BTlVBTF9NT0RFLCAwKTsNCj4gDQo+IE9uY2UgYWdhaW4sIGFuZCBJIGhhdGUgdG8gc2F5IHRo
aXMsIGEgZm9sbG93LXVwIHBhdGNoIHdpbGwgYmUgcmVxdWlyZWQuDQo+IA0KPiBTb21ld2hlcmUg
YWxvbmcgdGhlIHBhdGNoIHZlcnNpb25zIGFkNDY5MV90cmFuc2ZlciB3aGljaCB3YXMgdXNlZCBm
b3INCj4gcmVtb3ZlZCBmdW5jdGlvbmFsaXR5IGZyb20gdGhlIGRyaXZlciB3YXMgcmVtb3ZlZCBh
bmQgd2FzIHVzZWQgdG8gc2VuZA0KPiAweDUwMDAgKFNQSSBjb21tYW5kIHRvIGV4aXQgTUFOVUFM
IE1PREUgYW5kIGNvbWUgYmFjayBpbnRvDQo+IEF1dG9ub21vdXMgTW9kZSB3aGljaCBpbiBNYW51
YWwgTW9kZSBpcyB1c2VkIGZvciByYXdfcmVhZGluZykuDQo+IA0KPiBBdCB0aGUgdGltZSBiZWlu
ZyB0aGlzIGlzIGEgYnVnIHRoYXQgbWVhbnMgb25jZSB1c2luZyB0aGUgYnVmZmVyIGFuZCBzdG9w
cGluZw0KPiBpdCwgcmVnaXN0ZXIgYWNjZXNzIHRvIHRoZSBkZXZpY2UgZG9lc24ndCByZWFsbHkg
ZXhpc3QgYW55bW9yZSBhbmQgdGhlIFNQSQ0KPiBvcGVyYXRpb25zDQo+IHVzZWQgZm9yIHJlZ2lz
dGVyIGFjY2VzcyBjYW4gbm90IGJlIHJlbGllZCBvbi4NCj4gDQo+IEkgYW0gdmVyeSBzb3JyeSBm
b3IgZmluZGluZyB0aGlzIG91dCBqdXN0IG5vdywgSSBndWVzcyBJIGZvY3VzZWQgdG9vIG11Y2gg
b24gT1NSDQo+IGFuZA0KPiBDTlYgQnVyc3QgTW9kZSBsYXRlbHkgdGhhdCBJIGNvbXBsZXRlbHkg
Zm9yZ290IGFib3V0IHRoaXMuDQo+IA0KPiBXaWxsIGxlYXZlIHRoaXMgcGF0Y2ggaGVyZSB0byBz
ZWUgaWYgYW55IGZ1cnRoZXIgcmV2aWV3IGNvbWVzIGluIGFuZCB3aWxsIGFsc28NCj4gdGFrZSBh
IGxvb2sNCj4gYXQgU2FzaGlrbyAsIHBlcmhhcHMgaGUgZmluZHMgc29tZXRoaW5nIGVsc2UgYW5k
IGEgdjE0IHdpbGwgYmUgbmVlZGVkIGFueXdheS4NCg0KSnVzdCBmb3IgcmVmZXJlbmNlLCB0aGlz
IGlzIGhvdyB0aGUgbmV3IGNvZGUgd291bGQgbG9vayBsaWtlLCBub3QgdG9vIG11Y2ggb2YgYQ0K
ZGlmZmVyZW5jZToNCg0KCSAjZGVmaW5lIEFENDY5MV9FWElUX0NPTU1BTkQgMHg1MDAwDQoNCgkg
Li4uDQoNCgkgc3RhdGljIGludCBhZDQ2OTFfdHJhbnNmZXIoc3RydWN0IGFkNDY5MV9zdGF0ZSAq
c3QsIHUxNiBjbWQpDQoJIHsNCgkJIHU4IGJ1ZlsyXTsNCg0KCQkgcHV0X3VuYWxpZ25lZF9iZTE2
KGNtZCwgYnVmKTsNCiANCgkgCSByZXR1cm4gc3BpX3dyaXRlKHN0LT5zcGksIGJ1Ziwgc2l6ZW9m
KGJ1ZikpOw0KCSB9DQoNCgkgLi4uDQoNCgkgc3RhdGljIGludCBhZDQ2OTFfZXhpdF9jb252ZXJz
aW9uX21vZGUoc3RydWN0IGFkNDY5MV9zdGF0ZSAqc3QpDQoJIHsNCgkJIGlmIChzdC0+bWFudWFs
X21vZGUpDQoJLQkJIHJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJlZ21hcCwgQUQ0Njkx
X0RFVklDRV9TRVRVUCwNCgktCQkJIEFENDY5MV9NQU5VQUxfTU9ERSwgMCk7CQkNCgkrCQkgcmV0
dXJuIGFkNDY5MV90cmFuc2ZlcihzdCwgQUQ0NjkxX0VYSVRfQ09NTUFORCk7DQoJCQ0KCQkNCg==

