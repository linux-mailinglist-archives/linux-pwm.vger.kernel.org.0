Return-Path: <linux-pwm+bounces-8875-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLLDFp3DBWpMbAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8875-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 14:44:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1754541D48
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C096303BBAB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7613DB641;
	Thu, 14 May 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kjumxhhg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B83B9D86;
	Thu, 14 May 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762647; cv=fail; b=S3sXV5hyNAE/N7uH+E1g/rrzd9PEnfzb9VQ0uq/FkiBWc4Np9ViueVXaQrKpUhyurL8K/cEQ4Eei81eosgPsTxU3W7tx/63yePtsV7JeHlNQ4zm+s2LXQIe8GyVjtOYyiMA//KS5i+qLqazK9Fr2OELqfJENEvFT3mroYxQifdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762647; c=relaxed/simple;
	bh=mQQfbGcYQsK/9Nyg8BTZ2W7R11gHFy1hwBRwSbnKh0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzFVavyiycLGkW5ilsxLNcKKqq4KKbteTb1b+9Jp5NzL1Xm+kCgK8vWEBusWOC+pLClFWSvzUPj/74DzDeWJA/suR+ivi/fgVoVAWvqqHjsX4laqMyZAYmQVUsf4XTqnASknMux2rC1NWBGWD1OqHR9C/0vYods9yBaDvM/d7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kjumxhhg; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6ER0o3555450;
	Thu, 14 May 2026 08:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mQQfb
	GcYQsK/9Nyg8BTZ2W7R11gHFy1hwBRwSbnKh0I=; b=KjumxhhgW0DbsjqcOgs2H
	TMW4tcnoSZO4orIoXUGc53oUSFkOLwR+ueinKZjgs3gUmb04tsFR5UcyriL6gQSB
	ymfNBRihinEt5vroXYd6CcsQsJd00BjX41kIvDPbgEU4yUCNEQt73U4wySgIyxzQ
	J+yBZnkSwSH2ihizZ5VHb/IDVfcN2VQfTuS/4N5Kk2e0r0oKfjr3/+ozwqsty1Fh
	fkmBtZp0CRkBgP3iGAI4MWyL+fIPPf5gzpvTMYxi3uFA9GMzrilOgW+jr4Y7CgCM
	FYNlQdizwhLBLT6wV5qkdTqE/YKMrxM+iJJWbeQpxxMi6O1B/OdNBimaduL4ik8Y
	A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e58xjs30u-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 08:43:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THUH95i+eeoItxWs8fhOV5/pxZdlcLIA9GYOIK9Lwigw9lVq5NT1GSNhBKtelsvyC9BiA1DTXNGdeY8VfkxwhKIQDe5EOtvJdBJUhY/hYeY4aFUY1xenLgQ9BfL487Rh/pudr4uOX97RGwI3ufkCHtfgz1P4VK2mo55DlyIdgN7rzrOHPTDF+4efNbsfX2XRPUWbT4b+9zqMniKTHTqbOPp0DEUwNp6HqTOxwnBPp5Z/Fi8o47UrMIct4xQbCFIfUyW58KhlMXYBP3DFoSvZ4Qm5h3mfirW3bjZVn/onzarSFZ6Y1spQCA5ORB/xJvFSCRSB7rtpvboMtzpYuekHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQQfbGcYQsK/9Nyg8BTZ2W7R11gHFy1hwBRwSbnKh0I=;
 b=Ft9WgWk8NE7cLWpDgbo11PRdzclb2yREF/Dv3IJ8RPsf3kPJVUXnYMtz/LExovajmpOv3rx/nBOepIyGljQoZSF4KX57hfFcPhkTGAGhqdbkFzRcxhxHUyjFStGWQRRRekYYjhyeu5KZ77xHvlPfUAe0elp++q/H4H+cWH4kE17IUUlvjlw14aSDlOyRS5yFYcsfa6EvQ8aGTRpCb4Xv94YXsETgTgc+6k47qvvGwiLshiHRaUaHuHqc/cmB6Y4jpZLfxFS2YIWtlUzZC9L2RhOpgmP7yPXfRU87vk8dqsfT4BiSBvoKVeuKtSyMUJycLS+XDh1yfEY3GRuF5AHDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MW4PR03MB6459.namprd03.prod.outlook.com (2603:10b6:303:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 12:43:26 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 12:43:26 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
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
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v10 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v10 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHc4Tzo6fmdfHnv8kamSG76CifqfbYKiisAgALuvlA=
Date: Thu, 14 May 2026 12:43:26 +0000
Message-ID:
 <LV9PR03MB84140FFE3C60A3E741AD800BF7072@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
	<20260511-ad4692-multichannel-sar-adc-driver-v10-3-e1fbb1744e38@analog.com>
 <20260512164514.38bbfd4c@jic23-huawei>
In-Reply-To: <20260512164514.38bbfd4c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MW4PR03MB6459:EE_
x-ms-office365-filtering-correlation-id: 564667ca-a8ca-4509-b521-08deb1b664bd
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|4143699003|38070700021|18002099003|22082099003|11063799003|3023799003|56012099003;
x-microsoft-antispam-message-info:
 3qmeRM/QMtwjlwLlORznjyAQ0IWaSgzcBWdK1QOjv3WWML3NW1pfcWpnUdLsEX/gPE2H6f5vTg2E10M14aT2JWxJkZRQy0w6nnkNftfAiNf1KRg0OSyj0IvXohvnfuF5Wt0OGe8XuIdtM3HRHNWIDkdHOsH2bLOrE32zk95pWcgstt3bOXEsD/SIJlUzKcE8JIt7TM3ILYw7KlR/WgIAYW1p7dQjR0fNB5DooUbsaWc1/EwY+dVwul8AMpj7FUCLC/bI1hjZ61zajlcQja4aUc1t00Nskpur24KdYwnN1WqUOsIWE+ZOVGR+NXh+YfDrVv9f+Dt30po8jSAXArHbWcUIObK+Zt6w2xJPt3Oc6yby1h2PFMY0Qz4yM1TiCukk+hdP54p2Uj2lPWFUGqCJQSwcRjl0K+faWbabHo6gTGnRtdO2vv/jKhNdhLDvjuKt/xv5MY/imVJoNznV9MLst2mhqOqYlu6+CjZARx7GNO1jT3Se+dXCrXA1jF0EzFJn5XqSiiXC6USwyp/AQSpZKbscYIg6FqrDR2EOBQWZyZpVYbzG/Gl17tSgPhjYm1/mW4CqPDhD1Buav2gn1r9B0dVbIX4UTYgKlFf0v/sLt5MSyTPtp6VJolygZKl8UP48RGq8dC6sM+iFnVxwopNh/QL3QbFCfGWt2D6UDmwM/1GeEjpDNUYwoLUwAvrkHYx8CwRzsSGWExk/G2wRgEpXH1W3m8nTw31ZsjGkFh36dyo/ZivP2GepdcSpya1LDDZu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(4143699003)(38070700021)(18002099003)(22082099003)(11063799003)(3023799003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WG5TQUxHOU9YUDhjaGFHVGR6YVVmZVlCUS80c28xTlQzMXVlekxNSkQ4aTBo?=
 =?utf-8?B?T3IxZVZGYUtvaCtWUGlaSzRENzdVZytDeHJIVEkyVzRzdWNDbnh0MjNCQmwy?=
 =?utf-8?B?MWw1M3dtSk54ekdIYXZleHQ5UC90UHBVUnFBNFV4MTVYMURMa2ZpSU9MZHlr?=
 =?utf-8?B?aWlCN1RBZGE4eHplSThrUGNydzRWUnlJeUVVZEg0ZzBrUVptRmo0U0J5Y0N2?=
 =?utf-8?B?RnE1eUphMDJxUUFUVHBDRVIzdm0rRGhSTHV1NzhWTFRyTUMwb2V1WVYralpo?=
 =?utf-8?B?WEdnMWltVko0OXF4SmwraGgxOWQzSGlBZFF3ZW1vdzFndVc0Y3h1Y2FzNGdP?=
 =?utf-8?B?RGpQU0RLZlpuYVhWZUY0WmFsaUpjbmdUUG9vcUJTTi9BRVJmS1kwdUx4Sldh?=
 =?utf-8?B?Wnl3UkIxSGZieS85QkZoekRsb0IvakxoNCtGMzdsTFduVVNCUmU2T3FvMGU1?=
 =?utf-8?B?bm00b2FPZC9qRmRqcmpMV003N3VYZTQrTWZQa2RTcStRMEpQUkFPOHZ6VkFw?=
 =?utf-8?B?dFJ0YTdyOEhoRlR0aHFKSjVXMmpNOXNzYkNmNi9TcVRvU0pNc2x1VFVWaXRz?=
 =?utf-8?B?SHorcmtBUCtHb3JSZGZYZDVWSXphandrTkpVdndyTzVHTTAxY3gwSEhGeHFK?=
 =?utf-8?B?bkd2bXkySUxHdW9lSkh3MDA0aXF0ZUlMYjdxUmdVODh6UldWeGdjbXdCQno3?=
 =?utf-8?B?a0pybVpYbmtWT2ZTbzJabW50c0RCd0t4UUV1bVluQiszOXZabmNhWHhIMTkv?=
 =?utf-8?B?UG5sWVp1NHg0UEgvQzBHdDRtUG5wSmgyS1FzUUs0OW4vbUd2WkpSU3prNGlP?=
 =?utf-8?B?WkJ5UFB0aXFWZnFaTzVYOXhVcm5Lc3pPS1BrY2drOW9Qdit4Z3BDK2xaS0tw?=
 =?utf-8?B?b2ZRRm9WbVZtL0FLUXFKV1NhUmxIMEg4aWM2aTBmRHRxOVI1TEQwTkw5TW5T?=
 =?utf-8?B?RmJ5Um5EV3NRSVJxekc4S1RYMG55UktZclRITzVkR2w5MGdnWG9YQU9Kd2xY?=
 =?utf-8?B?aXRqUnNLcks0dktZamJ4RjIxOVZpN2psNE4zVVAxSHJrZWU0ejZjVmV0L2Ir?=
 =?utf-8?B?YTFKQUtYVE9RdC9LUU9Vck1wbENjQzlyMjV5R1pHaGtTczNaYWxwQ3JRdXZr?=
 =?utf-8?B?VEM3Q0tEeUhEQ2NEazVrQ3AzVjcrTzVEYWZmVnRDMlYzT2kwR1doVUNjSkZN?=
 =?utf-8?B?RVBsdnlDYXhWZTdXMU16d05PVXNZek1ycXBzbnc4eUZuT3ZKY2VLZ3hNVHpC?=
 =?utf-8?B?bFFyem9CL1FiUHFQbXRHc1BrMWFKQWlIcElGNlRXWFJCRWtPQytGc0xzVzhD?=
 =?utf-8?B?bGhzbnQ3WnhlVzRDa3FONG5welgzUWR5cGlBa3AzN1c0ZzR1ZzdWUHJnZ0hL?=
 =?utf-8?B?eFVNNmdDZUFzWU10UFBGRUJ1MTNKcGNGcmoxTDYyR3I2UUE5R1R3aGlBMW1Z?=
 =?utf-8?B?THErbTdNbjk4cmNNc1d5Yjc0c3VPVEVueVh6OHlNTnpIUmNQMTRtMFg4SGN3?=
 =?utf-8?B?c0tQQzhzcGIwL0RydExYTmUvQUt6eVczSlVuTVh2UHpFT2R6OXZLRDVnanZ3?=
 =?utf-8?B?SmJsYk1CMkNXZWQ3bHl4eUdRUHAwR0ZmTjhxc0JDYy83MnJFSHVpcXJ3dHlU?=
 =?utf-8?B?QkFQTE1rckxPODdhdG9qUk9qcE5aL0ZzWEMxQlEzTTdKREZvSHl5ZENWZ2Fs?=
 =?utf-8?B?MmtBN3Flc2s0bEYxU0RCYWlDYzdySVVvWjZ2L29wbER1ckpnaGpTWWR0QmlH?=
 =?utf-8?B?QmhqTlJSZkVxVkZpT3JHS1FGcmVIRmk4L2ZZL3VuOWtsQ2wxWVg1ZFRrRVRJ?=
 =?utf-8?B?RFRLVWZtSUdzMzFQWTRtc3ZNYkZOcVpoRkxzZExpbE5GcXA0L2d2NVdDT3dr?=
 =?utf-8?B?NXZoZ05zSnVON3phNzRXK0gxblQ2N1VQRC9FWDk5TnpYUHA3dU5EM3JMZTJy?=
 =?utf-8?B?MTlmR01Lc1hWMmJwSWVNSENNRnZzb1ZxOENmYUc5eERWMHQ5WlhuNERPUEZF?=
 =?utf-8?B?WDR0MDFmQVhlb1hVZUlUMFBkK0NqUVo3bkZOREc0ZVZMdjJ0MnJKYmVxcS9W?=
 =?utf-8?B?MythOVF4KzQ4cjdiUCtIam9zbVlmZk5VY20rRXVBN3U3a0dKQlhzRHlxTXRx?=
 =?utf-8?B?cG1UM1N5VVYrRmdHTjJuNGhPK1dxZk5rRFMrbjBidnFYaGU5bW16OVlTZEU4?=
 =?utf-8?B?bXZ6SVRaTFlGamNkZ0lacy9kTHdFS1NIdGhKUy9Rdm9vVzI2Q3BJNU5yYUxq?=
 =?utf-8?B?RG5ud042YmtGK3k2YWlDWmtBRHRnWHJRRzVyQmMvVXlCRmI2clR6eUcrQTNs?=
 =?utf-8?B?WllLcWZ4bWRPdXRadmN2UmlabnRJWEtsZFpBSklMZ0FMVTlYTUFodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RN2Rj6vbcuNaJmHcQjo8dUOglILrtMrBM4tY6IwYTxToi8iIZmUwAxP6eEwKOQlRmq/PUsVffqWnhX9q/In+KtLrihjOVAhzGHBU7ThulseJkLfrtPxGE1uxq08Aqk0WBG1t4xip9LPqp3VYkkxHyYseMingkxABPn95ArJSfTZ/TH4jI2NEFvHdYVJKyWVmkL/mHxbvLJpgZl+qMLVmrk5LDuDojC6OPOLS7BZ0KFCh/czWd9mCUqT5AXBVqP1siZJcWtSVXD/k/9utwdP/e7OIOVhKd1HYaSj7uxI7MldxuttnHnk8NnPfaxaV9cu1laa9gWo/05xkDI6CAdOGXw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564667ca-a8ca-4509-b521-08deb1b664bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 12:43:26.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5q+pnq3FfYw87fCCEqY9ghSCfRwcIqYyBmn/DXAK36Yoz1ih3n+hcUmoZKCW9KpUmesEzulIkQX9iXy4DW3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6459
X-Proofpoint-GUID: EhbpETKoTwG94cORDqjuxDVMOdwsUTg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNyBTYWx0ZWRfX62ibs+Relwcx
 NvJiwBpGV4RfhiCYbNpbK2oJMK/Hj+uGJpsWo5YSg6Hyencnqbw6aSYVJjusxsbtyTcGsTy0Biz
 F/015Wra9PANCybrAkr6kjE0leFGCCMpXLWzgc7mzNSTi+YxFFmbFlyJLswEGo+mTBUOFQjXGxk
 wl8Ue6RlxbS9SYR2tqW4r+t5Ny04UHIrELQnHttpzGZawvEIVq7Ws/uVtdPBoTqhNBYVPNwRnoJ
 9ScrGJKjpmNe37tQIwxKp/UlB3gztB0zcjNzEn8FQYjsQqeL2O8p4TlSYlVIw7+7gVL5e8oqtrY
 oS/qDu+6GEV8JdtFh8ue3+dQMyd67r1ge0Y3UzXgnNvupTe5ScpBE/eBihcI7N8nqfua97O3VR2
 CZlYP7CZ3uYEQ1UIt2z3srutbq2+enRpM0r/rh5wpehw52dIDr15rYqjRNXmfHN3fherIsyV3o5
 n0sZ53TrPThf+7I7clg==
X-Proofpoint-ORIG-GUID: EhbpETKoTwG94cORDqjuxDVMOdwsUTg0
X-Authority-Analysis: v=2.4 cv=AeyB2XXG c=1 sm=1 tr=0 ts=6a05c372 cx=c_pps
 a=3vo4EN8bzuoLd/SmvO3peg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=GWXUKDMCWC4GU-43Vv4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140127
X-Rspamd-Queue-Id: C1754541D48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8875-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[analog.com:server fail,LV9PR03MB8414.namprd03.prod.outlook.com:server fail,tor.lore.kernel.org:server fail];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[analog.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjYgNjo0NSBQTQ0K
PiBUbzogUmFkdSBTYWJhdSB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmFkdS5zYWJhdS4NCg0KLi4u
DQoNCj4gPiBUaGUgQ05WIEJ1cnN0IE1vZGUgc2FtcGxpbmcgZnJlcXVlbmN5IChQV00gcGVyaW9k
KSBpcyBleHBvc2VkIGFzIGENCj4gPiBidWZmZXItbGV2ZWwgYXR0cmlidXRlIHZpYSBJSU9fREVW
SUNFX0FUVFIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IFNhYmF1IDxyYWR1LnNhYmF1
QGFuYWxvZy5jb20+DQo+IA0KPiBTYXNoaWtvIHBvaW50ZWQgb3V0IHlvdSBoYXZlIGEgYnVmZmVy
IHRoYXQgaXMgYmlnIGVuZGlhbiBidXQNCj4gY2hhbl9zcGVjIGRvZXNuJ3QgcmVmbGVjdCB0aGF0
LiAgVGhhdCBzaG91bGQgaGF2ZSBnZW5lcmF0ZWQgb2J2aW91cw0KPiBnYXJiYWdlIG91dHB1dCAo
dW5sZXNzIHlvdSBhcmUgYWN0dWFsbHkgdGVzdGluZyBvbiBhIGJlIG1hY2hpbmUhKQ0KPiANCg0K
SSB0aG91Z2h0IEkgaGFkIElJT19CRSBpbiBjaGFuX3NwZWMsLCBteSBiYWQuIEkgZWl0aGVyIGZv
cmdvdCB0byBjb3B5IHRoZSBsYXN0DQprZXJuZWwgaW1hZ2UgdXBvbiB0ZXN0aW5nICh0aG91Z2gg
SSBkb24ndCBrbm93IHdoeSBJIHdvdWxkIHJlbW92ZSB0aGF0IGxpbmUpDQpvciBJIGRpZCBzb21l
dGhpbmcgd3JvbmcgdXBvbiByZWJhc2luZyBvbiB0aGUgcGF0Y2hlcy4NCg0KPiBWYXJpb3VzIG90
aGVyIHRoaW5ncyBjYW1lIHVwLCBzb21lIG9mIHdoaWNoIEkgdGhvdWdodCB3ZXJlIGluIHByZXZp
b3VzDQo+IHJldmlld3MgLSBidXQgbWF5YmUgSSdtIGNvbmZ1c2luZyBkcml2ZXJzLg0KPiANCj4g
VGhhbmtzDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiBAQCAtMjA0LDcgKzIzMCwxNCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGFkNDY5MV9jaGlwX2luZm8NCj4gYWQ0Njk0X2NoaXBfaW5mbyA9IHsN
Cj4gPiAgc3RydWN0IGFkNDY5MV9zdGF0ZSB7DQo+ID4gIAljb25zdCBzdHJ1Y3QgYWQ0NjkxX2No
aXBfaW5mbyAqaW5mbzsNCj4gPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gPiArCXN0cnVj
dCBzcGlfZGV2aWNlICpzcGk7DQoNCi4uLg0KDQo+ID4gKwkvKg0KPiA+ICsJICogQXBwZW5kIGEg
NC1ieXRlIHN0YXRlLXJlc2V0IHRyYW5zZmVyIFthZGRyX2hpLCBhZGRyX2xvLA0KPiA+ICsJICog
U1RBVEVfUkVTRVRfQUxMLCBPU0NfRU49MV0uIENTIGlzIGFzc2VydGVkIHRocm91Z2hvdXQsIHNv
DQo+ID4gKwkgKiBBRERSX0RFU0NFTkRJTkcgd3JpdGVzIGJ5dGVbM109MSB0byBPU0NfRU5fUkVH
ICgweDE4MCkgYXMgYQ0KPiA+ICsJICogZGVsaWJlcmF0ZSBzaWRlLXdyaXRlLCBrZWVwaW5nIHRo
ZSBvc2NpbGxhdG9yIGVuYWJsZWQuDQo+ID4gKwkgKi8NCj4gPiArCXB1dF91bmFsaWduZWRfYmUx
NihBRDQ2OTFfU1RBVEVfUkVTRVRfUkVHLCBzdC0+c2Nhbl90eF9yZXNldCk7DQo+ID4gKwlzdC0+
c2Nhbl90eF9yZXNldFsyXSA9IEFENDY5MV9TVEFURV9SRVNFVF9BTEw7DQo+ID4gKwlzdC0+c2Nh
bl90eF9yZXNldFszXSA9IDE7DQo+ID4gKwlzdC0+c2Nhbl94ZmVyc1syICoga10udHhfYnVmID0g
c3QtPnNjYW5fdHhfcmVzZXQ7DQo+ID4gKwlzdC0+c2Nhbl94ZmVyc1syICoga10ubGVuID0gc2l6
ZW9mKHN0LT5zY2FuX3R4X3Jlc2V0KTsNCj4gPiArCXN0LT5zY2FuX3hmZXJzWzIgKiBrXS5jc19j
aGFuZ2UgPSAxOw0KPiANCj4gT3VyIG9sZCBmcmllbmQgLSBjc19jaGFuZ2UgPSAxIGlzIHZlcnkg
cmFyZWx5IHRoZSByaWdodCB0aGluZyB0byBkbyBvbiBhDQo+IGZpbmFsIG1lc3NhZ2UuICBJIHRo
b3VnaHQgdGhpcyBjYW1lIHVwIGluIGFuIGVhcmxpZXIgdmVyc2lvbi4NCj4gDQoNCkkgdGhvdWdo
dCBJIGhhZCB0aGlzIHJlbW92ZWQsIGl0IG11c3QgaGF2ZSBiZWVuIGxvc3QuDQoNCj4gPiArCXNw
aV9tZXNzYWdlX2FkZF90YWlsKCZzdC0+c2Nhbl94ZmVyc1syICoga10sICZzdC0+c2Nhbl9tc2cp
Ow0KPiA+ICsNCj4gPiArCXJldCA9IHNwaV9vcHRpbWl6ZV9tZXNzYWdlKHN0LT5zcGksICZzdC0+
c2Nhbl9tc2cpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4g
PiArCXJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfU1REX1NFUV9DT05GSUcs
DQo+ID4gKwkJCSAgIGJpdG1hcF9yZWFkKGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzaywgMCwN
Cj4gPiArCQkJCSAgICAgICBpaW9fZ2V0X21hc2tsZW5ndGgoaW5kaW9fZGV2KSkpOw0KDQouLi4N
Cg0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgYWQ0NjkxX3RyaWdnZXJfaGFuZGxlcihpbnQgaXJx
LCB2b2lkICpwKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWlvX3BvbGxfZnVuYyAqcGYgPSBwOw0K
PiA+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBmLT5pbmRpb19kZXY7DQo+ID4gKwlz
dHJ1Y3QgYWQ0NjkxX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+
ICsJYWQ0NjkxX3JlYWRfc2NhbihpbmRpb19kZXYsIHBmLT50aW1lc3RhbXApOw0KPiA+ICsJaWYg
KCFzdC0+bWFudWFsX21vZGUpDQo+ID4gKwkJZW5hYmxlX2lycShzdC0+aXJxKTsNCj4gDQo+IE1h
eWJlIGl0IHdhcyBhIGRpZmZlcmVudCBkcml2ZXIgYnV0IEkgdGhvdWdodCBJIGNvbW1lbnRlZCBv
biB0aGlzIGJlZm9yZS4NCj4gVGhlcmUgYXJlIGEgYnVuY2ggb2YgcmFjZXMgaWYgeW91IHJlZW5h
YmxlIHRoaXMgaGVyZSAtIG5lZWRzIHRvIGJlDQo+IGluIHRoZSB0cmlnZ2VyIHJlZW5hYmxlIGNh
bGxiYWNrLg0KPiAoU2FzaGlrbyBpcyBwb2ludGluZyB0aGlzIG91dCBhcyB3ZWxsIHdpdGggbW9y
ZSBkZXRhaWwgb24gd2hhdCB0aG9zZQ0KPiByYWNlcyBhcmUpICBUaGUgc2hvcnQgc3RvcnkgaXMg
dGhhdCB5b3UgY2FuIHJhY2UgYW5kIGhhdmUgYSB0cmlnZ2VyIGJldHdlZW4NCj4gdGhlIGVuYWJs
ZSBhbmQgdGhlIG5vdGlmeV9kb25lIHdoaWNoIHdpbGwgYmUgZHJvcHBlZCBvbiB0aGUgZmxvb3Ig
bWVhbmluZw0KPiB3ZSBuZXZlciBnZXQgaW4gaGVyZSBhZ2FpbiAtIElJUkMgdGhlcmUgaXMgKHJh
dGhlciBjb252b2x1dGVkKSBjb2RlIHRvIGhhbmRsZQ0KPiB0aGF0DQo+IGNvcm5lciBjYXNlIGlu
IHZpYSB0aGUgcmVlbmFibGUgY2FsbGJhY2sgYW5kIGEgd29yayBpdGVtLg0KPiANCg0KSSBhbHNv
IHRob3VnaHQgSSBoYWQgdGhpcyBjb3ZlcmVkLCBpdCBhcHBlYXJzIGl0IGlzIG5vdC4uLg0KDQo+
ID4gKwlpaW9fdHJpZ2dlcl9ub3RpZnlfZG9uZShpbmRpb19kZXYtPnRyaWcpOw0KPiA+ICsJcmV0
dXJuIElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGlpb19pbmZvIGFkNDY5MV9pbmZvID0gew0KPiA+ICAJLnJlYWRfcmF3ID0gJmFkNDY5MV9yZWFk
X3JhdywNCj4gPiAgCS53cml0ZV9yYXcgPSAmYWQ0NjkxX3dyaXRlX3JhdywNCj4gPiAgCS5yZWFk
X2F2YWlsID0gJmFkNDY5MV9yZWFkX2F2YWlsLA0KPiA+ICAJLmRlYnVnZnNfcmVnX2FjY2VzcyA9
ICZhZDQ2OTFfcmVnX2FjY2VzcywNCj4gPiArCS52YWxpZGF0ZV90cmlnZ2VyID0gaWlvX3ZhbGlk
YXRlX293bl90cmlnZ2VyLA0KPiANCg0KLi4uDQoNCj4gPiAgc3RhdGljIGludCBhZDQ2OTFfcHJv
YmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnNwaS0+ZGV2Ow0KPiA+IEBAIC02NjMsNiArMTIwMCw3IEBAIHN0YXRpYyBpbnQgYWQ0
NjkxX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07
DQo+ID4NCj4gPiAgCXN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArCXN0LT5zcGkgPSBz
cGk7DQo+ID4gIAlzdC0+aW5mbyA9IHNwaV9nZXRfZGV2aWNlX21hdGNoX2RhdGEoc3BpKTsNCj4g
PiAgCWlmICghc3QtPmluZm8pDQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gQEAgLTY5Miw4
ICsxMjMwLDkgQEAgc3RhdGljIGludCBhZDQ2OTFfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNw
aSkNCj4gPiAgCWluZGlvX2Rldi0+aW5mbyA9ICZhZDQ2OTFfaW5mbzsNCj4gPiAgCWluZGlvX2Rl
di0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPg0KPiA+IC0JaW5kaW9fZGV2LT5jaGFu
bmVscyA9IHN0LT5pbmZvLT5zd19pbmZvLT5jaGFubmVsczsNCj4gPiAtCWluZGlvX2Rldi0+bnVt
X2NoYW5uZWxzID0gc3QtPmluZm8tPnN3X2luZm8tPm51bV9jaGFubmVsczsNCj4gDQo+IFlvdSd2
ZSBsb3N0IG1lIGhlcmUuIFdoZXJlIGFyZSB0aGVzZSBub3cgc2V0Pw0KPiANCg0KQXQgdGhpcyBw
b2ludCBJIGFtIHN0YXJ0aW5nIHRvIHRoaW5rIHRoYXQgd2hhdGV2ZXIgSSBoYXZlIHNlbnQgaXMg
ZGlmZmVyZW50IGZyb20NCndoYXRldmVyIEkgdGVzdGVkLiBJdCBzZWVtcyBsaWtlIGNoYW5nZXMg
SSBoYXZlIHJ1bm5pbmcgb24gdGhlIGtlcm5lbCBpbWFnZQ0KZG8gbm90IGFwcGVhciBoZXJlLiBJ
IGFtIHByZXR0eSBzdXJlIEkgaGF2ZSBkb25lIHNvbWV0aGluZyB3cm9uZyB3aGlsZQ0KcmViYXNp
bmcsIEkgYW0gdmVyeSBzb3JyeSBmb3IgdGhhdC4gSSdsbCB0cnkgYW5kIHNlbmQgYSBiZXR0ZXIv
Y2xlYW5lciB2ZXJzaW9uDQpuZXh0IHRpbWUuDQoNCj4gPiArCXJldCA9IGFkNDY5MV9zZXR1cF90
cmlnZ2VyZWRfYnVmZmVyKGluZGlvX2Rldiwgc3QpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQly
ZXR1cm4gcmV0Ow0KPiA+DQo+ID4gIAlyZXR1cm4gZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKGRl
diwgaW5kaW9fZGV2KTsNCj4gPiAgfQ0KPiA+DQoNCg==

