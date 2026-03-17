Return-Path: <linux-pwm+bounces-8288-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCl4HHgfuWmergEAu9opvQ
	(envelope-from <linux-pwm+bounces-8288-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:31:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20CF2A6C57
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4313036044
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668435DA57;
	Tue, 17 Mar 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="akjpueuS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF133CEAA;
	Tue, 17 Mar 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739693; cv=fail; b=maJC/+a4RYi/ujmNn+xwBbiE9K9WosjTgm6QWVK72IJNlpgtrevY/Q/TBWme95P8MzHL0oDE1OOtAWnnR812tAyHGkv3wXsxSa2eFz2XPU7U8Ii1d/hdk7ihMTs9KpiteLNkB0JEwAKTiO0UdktadXCKbvQnRfh3OIwXc22KJzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739693; c=relaxed/simple;
	bh=cuIr/e6D3Zm5K+Xu3jVE7RsNEEuL/P+eZ7/q3X5MUgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KVxrTKgEIH5L6KaOyRdHjKIgIUQ7sOHHC5NLgMb45sHOCQqza+F4gezvqgSswecc/zMl4kCYuVFeb6+lu+tFq3+nNFCAFuiKU+G+qgFBnjVm4MS0UFukSFdWoN4/PriRwcoCycrlrTFBtp5UzAUQZBiEjM0MkomrBi6ptwXMM6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=akjpueuS; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8x1Ph3761351;
	Tue, 17 Mar 2026 05:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cuIr/
	e6D3Zm5K+Xu3jVE7RsNEEuL/P+eZ7/q3X5MUgA=; b=akjpueuSvHMjQaOgXDMqd
	Qxj+GfYkYfK02TpE0tL2PCSl3dQmg4hZ99zLhZm+SGt2PRoiFEReA92HNyxyVcBk
	yO34QSFHZ68hc/JQnyk6bKi3tpyiJH6+h74F80FtxGaaFpsvusvnEO2dbJVuk31R
	frf28rh6X/A+XtDSm+N3ZklibqQeyBbUCwvMZhapeky4kHNfLXiT5cjCxTRQmCql
	M6C09SV5TKhZ8msiaO8iY61rMJihwd/1so11il5QY7aKCe9PYUGSnkp7nz23rhzh
	ZX/rCHV0pDxc4UU8JtpVgCQf4aie5K2sEkrhp7DtxVSPM+7blFK0BLhmckaJci6g
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0frj40-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 05:27:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIGXBoRX5JLckgN0uNvCp0SjAOYwRJDjrTLEayn5cA1Zst8jUgc51cORT9nzZU6IzvbH1U/lism2F20mRGpimwmorMjO4JadLajCiRvGH0Jn6PUzlhlsW8hGlKqo2X5xKUgFAqmyBKdz3SZ2Z1iLU7zIqq4NwV9lDvsoM3EKyMoggCDVCAtFaII8QGE4hBO4KOFZJxqqLcJ2dbaIU+0lSCo8infzI0ciDcCV8vO0QnGACtE0TxZBMikVsY1ketz/sllcx+F/46ZXf+KG4XNFvhM3OLa31q6jGSJe9deF+z+ZGDnotGlAQpDbPad/cRUGDCU7kIiHcBTsIoDPsQxoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuIr/e6D3Zm5K+Xu3jVE7RsNEEuL/P+eZ7/q3X5MUgA=;
 b=soS7dmOe24qVOBpvwUeSA6VQeFoSuYWWlGSY2x6j5oaMB5FFj/G429qy0F51R7gTAyyUoCEKTBVmbxR12vtcMks10D88COZM1glKwha1uBHp4LJGOh/DIbcWhcnv6ODu9aX1f0MlgdBncFMJfN9qwEa2lProt/kfiJ6Y4knygCR+KgMKPwvi3BAVWOcI17tkK0nPirfePDrpJNa5rZHcJYy5M+2oQJY4l/2x/Hb0eEhZsQNZaklwM/Sfk55Jrl+JgjIsGoLM53GCkc2r3H6sonAFaibcjFYqxJNnupaUox24J3+P1DYIYKAyq7WM+qW3L8UesOE57V9VG3woZBWS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA3PR03MB8278.namprd03.prod.outlook.com (2603:10b6:806:480::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 09:27:37 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 09:27:46 +0000
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
Thread-Index:
 AQHcstE9lpW0ZwF28UejM3whwuuFz7WuXaCAgALHEUCAACtOgIAAAwNAgAAPvQCAARXvYA==
Date: Tue, 17 Mar 2026 09:27:46 +0000
Message-ID:
 <LV9PR03MB8414E41D540B6948DFF4D480F741A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
 <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
 <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <06b48810-f997-40a4-86db-d3b7db9dfc18@baylibre.com>
In-Reply-To: <06b48810-f997-40a4-86db-d3b7db9dfc18@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA3PR03MB8278:EE_
x-ms-office365-filtering-correlation-id: 610a4d7c-a442-4061-2c68-08de8407734c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 bXEpQ5QkEOD5EWslKnZOuia0k0QbvBc+zsHgbTZMrP1H472oOJoTnJ8AABbYGoTHMX++hAiLRuLfHkyxx8v/Tw1UMosrh/mik69ev3xMR9iTqpgPBvVtL9s2jyj1ZttXsKbC2ifOKyg/gn1UV/g7FPNuYFyMtlOOGAmvRZh/zNphrLR+D7YZnzVbGqK2lwTg7VjrZEKRKdidlNF6nFKbbLEbWr/yl+K/wmLjdYa//Jz6zenyn41zWgTwSv0vRipxvnxZBoFFQ3WxFSRke9f3OS3kLmmhMlnLniMAbFddElCgeSjLFZKVRpkjnRb8c9vTE3FmvV1KQffGnR4C6sejBPF5/84AUN9o2SNZQ2vWmQfOAulZabyvs8H/rOZsjxDrxlqqQRDfBafYIPhXe+rpeCs1Bnq4e0kkAzvewXHFkKexb1MZ2cAz5yS5WSqU8roVKTb08UysVC4w4jtrN/h/IkaeOIdEgnXMyHjWKU6KSU22+mUEeuAml0i+JgGMt0c4ontCgGT+DGIxSN0XEtHdEC/aTEFk5nwuk/X2XFpwgs5U7QGryJ9jO5+Ypx9Y9ug3KfVrUTouPGSQ74ZewYSl1di5+y7u3VFgG14FIMs3sbUq25yUPYVQ44kGVIpak9uLd6jwDWQSOrHXU6oGSOxqs7FIrCXGDOPcDw8zvn801xg8Z4/7FsaZTaKN5/ZqdlaELnQiA1NN9af+8Urc+qhPWo47AN8v8EJECGsJvseWOsilZOutnuH0e/+NW+wxruJWsVmgakKvM6hIrkOXp2nxGTU+fz3gnz2nHlQqt7qeOYykl7tuhmO+IVID3NQ5bODW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEZwWDYzY2pzeWtwK1A2WHFyMTBBejB0NThmODVjNzBTYTA3T2svTHNoWWoy?=
 =?utf-8?B?Q1hpVytMYmlZNU1PdDkvd3dRdjdDeEpEK1VweFdkV0hOSmViM3ZQK2hhdDkx?=
 =?utf-8?B?QWhUcWp3QTNjZ05rcU9LaXMvanc5RmV2SktwUmtUdlZpbmN6cDR4aEdlclpX?=
 =?utf-8?B?ZUl1c3JvMGt5VVNxenpTNHdybXZqSU42ZFROVEEyMW1ISEsxaEtXbUpxWEhL?=
 =?utf-8?B?U2tkSXVZeHZVeUJFK1I5OVgvQVJnZTlZbXhrNnFvcm5TRUJTSUVQcGYweG05?=
 =?utf-8?B?dU1WYWZmNzBibnIzQUdDVWFGU2dHbHN6a3hvS3hDUlpKc21ubk1mQ1l0ODBB?=
 =?utf-8?B?YmM3dmF4M0pGY2VTTit1bVdwdDdxaTdnM1ZRUG5IbXRTTUlUSVJmRlhoc1V4?=
 =?utf-8?B?U1hPZ3krSFpUaEk1bTFkSVZjTE1CemVURjhrcHBzeVMrY2M3RFkzMlJHenU2?=
 =?utf-8?B?WURqUGZzby9HalR4R0kzM2laMVV2VVJONE9IbVh1YTA1Ykx6c3dIeVdMWHZh?=
 =?utf-8?B?Y2l4MThVMkxPekh6U2JpeTVsdUlvMllNTFhNUittckVPOUtDTmdkTWlOU0dq?=
 =?utf-8?B?bE0zcTRrTU9xQjh1UkNXeTFlcExMYTlnRExqeTkwalRNU2NxYVR1TjZoWVMz?=
 =?utf-8?B?ciswZEROSC9iU2RCcG9ycjVYNGY0TTJZWjZhWE5vRmJvbWEzYUphN2pjc0Zt?=
 =?utf-8?B?UE5pTDZlRHZZbGFEcjBUQkNESk1LUmVnTEZqK0I5S3o4UC9TMWJpYkh5dzRs?=
 =?utf-8?B?Vm9rNnAxdGYvOEdYZGNFdGErZTY3QWVUYnVXU1k1OFp4WFQ5TFVvZS9wdC90?=
 =?utf-8?B?OEhsL3MzcDQ5bzlwS3lOTkVoOFVNUGRzMlpoMVphVVZsNjZIYjRhdXlvR0FU?=
 =?utf-8?B?RnZxaGt0d3g5VGU0a3RFZHZqblhDY3NTY3VYVElRVG1oQXRjaEMvWEpOUjZp?=
 =?utf-8?B?NnJTeG01d2t2VVcycDZnc255ZStudlpkaWM3bG1MWVpQS0NkOHNnV0E0Um1N?=
 =?utf-8?B?T3Q4ZkIzU1R4clJaOEJxYk1icGNEaS96WFB0cWc1ajh0ckRseEpMSzI2d3da?=
 =?utf-8?B?YytYdi92bE9zKzFRUlpNem01THUxZGYwMm1ZbE9KbndaRDFLREJJMUlyaTdx?=
 =?utf-8?B?RWtIRkpwRWVaZ1hJeEpuQ0FHYlBCQVUzWEliL0xSZkFZeWlFdXc2Y2VROW9t?=
 =?utf-8?B?SjVsaTRMcjl5VVRtQ1VOejd4K2pNSnQ1STlKSXdIbFUwVFZNMjhkcHJQVmdk?=
 =?utf-8?B?UXRDQkt1ckgwUVJEb1NSNFAySzEySWNLOWpjVWN4dytNRy9LL1Jia2duRFNr?=
 =?utf-8?B?d2JpVDVtS0FwOFNOU1pGM3hwS2hIODkvb2VQVE1VRHRJajQ1eTF4V1pkZWtF?=
 =?utf-8?B?VkxnakdyU0Z6cmMxOFcwWVJ1bmhiT3BoUDY2bGxiSjc4TTI0SlM1anlVV1Bn?=
 =?utf-8?B?aklkRDBsN0MwUzJvNzRGRUdnNjViNVM5ZjVHU3NzTnpVL0YyNWNsUFEvbFEv?=
 =?utf-8?B?V3BVYmp0TG9MaW9jYmlBN1htWVd3Mmp5bXhvSlJKYjVSMWFiSGN0S3JhcjF6?=
 =?utf-8?B?RUkyQmpVMndJUGNlamgrYUN2S0tvSW5ORTVZdXQyMHhyK1hUOGRVSjZnVWZH?=
 =?utf-8?B?d0pvbWtsZVorTTE2V2k2T0ZFdWN2TFBOOUhabmNYV2kxMTFKdjRSV1NsOFA5?=
 =?utf-8?B?RGNlWjl1eHZtWSsrOCtLOHZwTDBXK3lyU3BoYTlMa0pySmhMOU1XWDRNZHow?=
 =?utf-8?B?SjdEbjhsNk9xY1Z4S1lmRGVIamRrVWRzdlRSRERuakNBWGh1YklzcHg2N2R4?=
 =?utf-8?B?ZkF5eXRhRG5HNENGZGdBbjFjVDBhVEJKaWhWSzNFbTJSdGhFQlhtaW1CNEtr?=
 =?utf-8?B?QmhGdFYvcVZ3Y3FjWUlrZXByWkk1a3dQYWM3cnp3eXZibDVkRjc5a2k5aFlC?=
 =?utf-8?B?K2t3NHY4T3IvY1hZdGZrK3VrVWlFbnIzRllIZ01ZK2czTlNiMkJsRlhPdllY?=
 =?utf-8?B?NDYwWU1Ydkg0Sk1xaE01WUdiMEkzbm5mVUxXRkZ4SmtjY0EwNjhhSEMyY2tm?=
 =?utf-8?B?dWF2WkhvMmhaSjUzSEFpcC8xV2lXaXZWSFM4ZnF0UVNUcXgrRDdDK1Fua3FX?=
 =?utf-8?B?TDVDMndOMFU2SVFiRGEvYVYxQ3U2dUhJMUVOM0tKMTJ5TXBMSTdUOUZ5WHdp?=
 =?utf-8?B?ZzdMeXpnbDZGNnNNOVVRZ2JRR29EN2tjTTVzNzNZcGU0T2liU1ZzTWZjYTEr?=
 =?utf-8?B?SXZWcFhuanpqdlI5UHNPWml1ZTFpTEp4QTZmMWZsa002REdadzAvdytxK2JT?=
 =?utf-8?B?YXJSNUk3R3hMNEFTTkZleFptcEtSa05FdGJMQ1N2SGV6ZWxSWmZhZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iR3blmvs/1tHuNaBtviRBeZ+rKzx82LUL+WJIsi2iSKnO7W1hc61IPgzR7lVnl0OOdgovgcnfAT7RoZjFDqFyPRI2CFZola4zSeheDWQ35vEUdkGFZjhVegC1uIoIc8rraID2XENGx0G5RZ8kWehOXUZfI+pfMNVef+WhbShgD9fWj8xIFteHej/xdsfaXzUie4mzkHCnVIOoFAQOfVjQ2tx4A938ZdLYhLc2q6e3W11fc84j0qLFetmZEuvxkV4dXegTK1xdnX3x23mOGIcAKdhScam+J6Lw1zkzzlUsutbyg96ByKUZQeV1OZIEBRmO4flANvBRjCc+adz4htg7w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a4d7c-a442-4061-2c68-08de8407734c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:27:46.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKs0TKphVLjd8aHure5YTNYO31vkO8OdgfQu4kHA54DwZXRPd9FbYVhabkq/Qxu1egBuOxKU3ibG8odNj66mXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8278
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4MyBTYWx0ZWRfX9NdBrvAMW4Xh
 OkUnjvZUTOJp52s73HQ8mDtMjyq/SXkWfMJAHMX90vrR2F+annuj7UrK7qPO8WbBNWwNWIXO9r1
 ixlRjd9RE9wsofWDTCmdW1Zxw6Zrd1xAaXYDCaS8QDKz8qJbnRYQWZQ45GcC0966eW/o1wF/wBV
 yM7VjEg2V+3nMGBKP//jSkEIPV5t/PwA/S3ptj8WoY4NX6BEY5BzCcQkAVXzy9N47ato1JvxMH3
 Oh1PFy8wjsjlF2cvYJT0JOo2gAp4QB5WwTZe7Zn9P4s1iU1mbT4GBxewMvNfyh+tImE2Va2OWRy
 8py5MSs/Pa2dBFnLYyuRTOFuQKPdKhACH2Lri8sTBHvoXqUgPvnNAs3nN8jBRouAGI8IVDNrJW3
 zyQQ9CVhKXYYi6ghsaEq0qcf5Q5nfHfsfvjdnvWMIvZdR+NQp0RSMNGeBRkJjwexmspgpJ5E5pn
 7sU4og0J9ju5VKXdqtw==
X-Proofpoint-ORIG-GUID: s-2wtxNXKGHDzieFSye5WrnO-Th7CoOQ
X-Proofpoint-GUID: s-2wtxNXKGHDzieFSye5WrnO-Th7CoOQ
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69b91e94 cx=c_pps
 a=cX17BFbqy3c2X70AxBoB8A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=uchtUendwCxtkJgNKKoA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170083
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8288-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D20CF2A6C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDY6
NDUgUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsg
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
DQo+IA0KPiBPbiAzLzE2LzI2IDEwOjU2IEFNLCBTYWJhdSwgUmFkdSBib2dkYW4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEYXZp
ZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMTYsIDIwMjYgNTozOCBQTQ0KPiA+PiBUbzogU2FiYXUsIFJhZHUgYm9nZGFuIDxSYWR1LlNh
YmF1QGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPj4gPGxhcnNAbWV0YWZvby5k
ZT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47
DQo+ID4+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBTYSwgTnVubyA8TnVu
by5TYUBhbmFsb2cuY29tPjsNCj4gPj4gQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gPj4gS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+ID4+IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsgVXdlIEtsZWluZS1Lw7ZuaWcgPHVrbGVpbmVrQGtlcm5lbC5vcmc+OyBMaWFtDQo+
ID4+IEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25pZUBr
ZXJuZWwub3JnPjsNCj4gTGludXMNCj4gPj4gV2FsbGVpaiA8bGludXN3QGtlcm5lbC5vcmc+OyBC
YXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+Ow0KPiBQaGlsaXBwDQo+ID4+IFph
YmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiA+PiBDYzogbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+PiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4g
Z3Bpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzRdIGlp
bzogYWRjOiBhZDQ2OTE6IGFkZCB0cmlnZ2VyZWQgYnVmZmVyIHN1cHBvcnQNCj4gPj4NCj4gPj4g
W0V4dGVybmFsXQ0KPiA+Pg0KPiA+PiBPbiAzLzE2LzI2IDg6MjIgQU0sIFNhYmF1LCBSYWR1IGJv
Z2RhbiB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0K
PiA+Pj4+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxNCwgMjAyNiA4OjM4IFBNDQo+ID4+Pg0KPiA+
Pj4gLi4uDQo+ID4+Pg0KPiA+Pj4+PiBCb3RoIG9wZXJhdGluZyBtb2RlcyBzaGFyZSBhIHNpbmds
ZSBJSU8gdHJpZ2dlciBhbmQgdHJpZ2dlciBoYW5kbGVyLg0KPiA+Pj4+PiBUaGUgaGFuZGxlciBi
dWlsZHMgYSBjb21wbGV0ZSBzY2FuIOKAlCBvbmUgdTMyIHNsb3QgcGVyIGNoYW5uZWwgYXQgaXRz
DQo+ID4+Pj4+IHNjYW5faW5kZXggcG9zaXRpb24sIGZvbGxvd2VkIGJ5IGEgdGltZXN0YW1wIOKA
lCBhbmQgcHVzaGVzIGl0IHRvIHRoZQ0KPiA+Pj4+PiBJSU8gYnVmZmVyIGluIGEgc2luZ2xlIGlp
b19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90cygpIGNhbGwuDQo+ID4+Pj4NCj4gPj4+PiBJdCB3b3Vs
ZCByZWFsbHkgaGVscCBoZXJlIHRvIHNlZSBzb21lIHRpbWluZyBkaWFncmFtcyB0byBrbm93IGlm
IHdlDQo+ID4+Pj4gYXJlIGltcGxlbWVudGluZyB0aGlzIHJpZ2h0Lg0KPiA+Pj4+DQo+ID4+Pj4g
Rm9yIGV4YW1wbGUsIGl0IGlzbid0IGNsZWFyIHRoYXQgaW4gY2xvY2tlZCBtb2RlIGlmIENOViB0
cmlnZ2VycyBhDQo+ID4+Pj4gc2luZ2xlIGNvbnZlcnNpb24gaW4gdGhlIHNlcXVlbmNlciAoaS5l
LiBJSU9fU0FNUF9GUkVRIHNob3VsZCBiZQ0KPiA+Pj4+IGluZm9fbWFza19zZXBhcmF0ZSkgb3Ig
aWYgaXQgdHJpZ2dlcnMgdGhlIHNlcXVlbmNlIChpLmUuIElJT19TQU1QX0ZSRVENCj4gPj4+PiBz
aG91bGQgYmUgaW5mb19tYXNrX3NoYXJlZF9ieV9hbGwpLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4g
VGhlIENOViB0cmlnZ2VycyB0aGUgc2VxdWVuY2UgYW5kIElJT19TQU1QX0ZSRVEgaXMNCj4gPj4g
aW5mb19tYXNrX3NoYXJlZF9ieV9hbGwuDQo+ID4+Pg0KPiA+Pj4gQXMgcGVyIGRhdGFzaGVldCBw
YWdlIDMxIChBY2N1bXVsYXRvciBTZWN0aW9uKSwgd2hlbiBlYWNoIGFjY3VtdWxhdG9yDQo+ID4+
PiByZWNlaXZlcyBhIHNhbXBsZSwgdGhlIEFDQ19DT1VOVCBpcyBpbmNyZWFzZWQuIEluIGNsb2Nr
ZWQgbW9kZSB3ZQ0KPiA+Pj4gYXJlIHNldHRpbmcgdGhlIEFDQ19DT1VOVCBsaW1pdCB0byAxLCB0
aGVyZWZvcmUgaGF2aW5nIG9uZSBzYW1wbGUgcGVyDQo+ID4+PiBjaGFubmVsIChubyBvdmVyc2Ft
cGxpbmcgYXMgZGlzY3Vzc2VkIGluIHByZXZpb3VzIHZlcnNpb25zKS4gU28gZWFjaA0KPiA+Pj4g
cGVyaW9kIG9mIHRoZSBDTlYgUFdNIGlzIHJlc3BlY3RpdmUgdG8gb25lIHNhbXBsZSBvZiBhIGNo
YW5uZWwuDQo+ID4+DQo+ID4+IEFzc3VtaW5nIHRoYXQgImEiIGNoYW5uZWwgbWVhbnMgIm9uZSIg
Y2hhbm5lbC4uLg0KPiA+Pg0KPiA+PiBJbiB0aGlzIGNhc2UgdGhlbiBzYW1wbGluZ19mcmVxdWVu
Y3kgc2hvdWxkIGJlIHBlciBjaGFubmVsIChzZXBhcmF0ZSkuDQo+ID4+DQo+ID4+IEEgc2FtcGxp
bmdfZnJlcXVlbmN5IHRoYXQgaXMgc2hhcmVkX2J5X2FsbCBtZWFucyB0aGF0IGVhY2ggcGVyaW9k
IG9mDQo+ID4+IENOViBzaG91bGQgdHJpZ2dlciBvbmUgc2FtcGxlIGVhY2ggZm9yIF9hbGxfIGNo
YW5uZWxzLiBJbiBvdGhlciB3b3JkcywNCj4gPj4gdGhlIHNhbXBsaW5nIGZyZXF1ZW5jeSBnaXZl
cyBvbmUgY29tcGxldGUgc2V0IG9mIHNhbXBsZXMgZm9yIGFsbCBlbmFibGVkDQo+ID4+IGNoYW5u
ZWxzIHB1c2hlZCB0byB0aGUgYnVmZmVyLg0KPiA+Pg0KPiA+DQo+ID4gT2gsIG9rIHRoZW4sIHdp
bGwgaGF2ZSB0aGVtIHNlcGFyYXRlLiBJIGFzc3VtZWQgdGhhdCBzaW5jZSB0aGUgUFdNIHBlcmlv
ZA0KPiA+IGlzIGNvbnN0YW50IHdpdGggZWFjaCBwdWxzZSwgdGhlbiB0aGUgc2FtcGxpbmcgcmF0
ZSB3aWxsIGJlIHRoZSBzYW1lIGZvcg0KPiA+IGVhY2ggY2hhbm5lbCwgdGh1cyBoYXZpbmcgdGhl
bSBhcyBzaGFyZWRfYnlfYWxsLCBidXQgSSBhc3N1bWUgeW91IGFyZQ0KPiA+IHJpZ2h0IGFib3V0
IHRoaXMgaW4gdGhpcyBjYXNlLCBJIHdpbGwgaGF2ZSB0aGVtIGFzIHNlcGFyYXRlIGluIHRoaXMg
Y2FzZSwgdGhlDQo+ID4gdXBkYXRlIHdpbGwgaGFwcGVuIGluIHRoZSBwcmV2aW91cyBwYXRjaCB1
cG9uIG5leHQgdmVyc2lvbi4NCj4gPg0KPiBEb2VzIHRoZSBzYW1wbGluZyBzdG9wIGFmdGVyIG9u
ZSAiYnVyc3QiIChyZWFkaW5nIGVhY2ggZW5hYmxlZCBjaGFubmVsDQo+IG9uY2UpPw0KPiANCj4g
SWYgeWVzLCB0aGVuIHdoYXQgY29udHJvbHMgd2hlbiB0aGUgbmV4dCBzZXQgb2Ygc2FtcGxlcyBz
dGFydHM/DQo+IA0KPiBMb29raW5nIGF0IEZpZ3VyZSA2MyBpbiB0aGUgZGF0YXNoZWV0IGZvciBD
TlYgQ2xvY2sgbW9kZSwgaXQgbG9va3MgbGlrZSBpdA0KPiBkZXBlbmRzIGVudGlyZWx5IG9uIGhv
dyBsb25nIHRoZSBTUEkgbWVzc2FnZSB0YWtlcy4gU28gdGhlIGFjdHVhbCBzYW1wbGUgcmF0ZQ0K
PiBpcyBnb2luZyB0byBiZSBxdWl0ZSByYW5kb20gaW5zdGVhZCBvZiB0aGUgc3VtIG9mIGVhY2gg
Y2hhbm5lbCBhcyB0aGUgSUlPIEFCSQ0KPiBzYXlzIGl0IHNob3VsZC4gSXQgc2VlbXMgYSB3YXN0
ZSBvZiB0aGUgUFdNIHRvIGRvIGl0IHRoaXMgd2F5IHNpbmNlIHdlIGVuZA0KPiB1cCB3aXRoIGEg
cmFuZG9tIHNhbXBsZSByYXRlLg0KPiANCj4gSXQgc2VlbXMgdG8gbWUgbGlrZSB0aGUgQ05WIEJ1
cnN0IG1vZGUgd291bGQgYWN0dWFsbHkgYmUgYmV0dGVyIHN1aXRlZCB0bw0KPiBob3cgSUlPIHVz
dWFsbHkgZG9lcyB0aGluZ3MuIEluIHRoaXMgY2FzZSwgdGhlIFBXTSBmcmVxdWVuY3kgd291bGQg
Y29udHJvbA0KPiB0aGUgZWZmZWN0aXZlIHNhbXBsZSByYXRlIChvbmUgUFdNIHB1bHNlIHRyaWdn
ZXJzIG9uZSBjb21wbGV0ZSBzZXQgb2YNCj4gc2FtcGxlcykgYW5kIHRoZSBpbnRlcm5hbCBvc2Np
bGxhdG9yIGNvbnRyb2xzIHRyaWdnZXJpbmcgZWFjaCBpbmRpdmlkdWFsDQo+IGNvbnZlcnNpb24u
DQo+IA0KPiBJbiB0aGlzIHNldHVwLCB3ZSB3b3VsZCBzdGlsbCBoYXZlIHRoZSBpbmZvX21hc2tf
c2VwYXJhdGUgSUlPX1NBTVBfRlJFUSwNCj4gYnV0IGl0IHdvdWxkIGNvbnRyb2wgdGhlIGludGVy
bmFsIG9zY2lsbGF0b3IuIFRoZW4gd2Ugd291bGQgaGF2ZSBhIHNlcGFyYXRlDQo+IGJ1ZmZlcjAv
c2FtcGxpbmdfZnJlcXVlbmN5IGF0dHJpYnV0ZSB0aGF0IGNvbnRyb2xsZWQgdGhlIFBXTSBmcmVx
dWVuY3kuDQo+IA0KPiBUaGVuLCBhcyBsb25nIGFzIHRoZSBQV00gZnJlcXVlbmN5IHdhcyBzbG93
IGVub3VnaCB0aGF0IHRoZSBTUEkgbWVzc2FnZQ0KPiBjYW4gYmUgZG9uZSwgaXQgY2FuIG1ha2Ug
c2FtcGxlcyB3aXRoIGFsbW9zdCBubyBqaXR0ZXIuIFRoaXMgaXMgd2h5IEkgd291bGQNCj4gZXhw
ZWN0IFBXTSB0byBhbG1vc3QgYWx3YXlzIGJlIHVzZWQgd2l0aCBTUEkgb2ZmbG9hZCB0aG91Z2gs
IG90aGVyd2lzZQ0KPiBpdCBoYXMgdG8gYmUgcXVpdGUgc2xvdyBjb21wYXJlZCB0byB3aGF0IHRo
ZSBjaGlwIGlzIGNhcGFibGUgb2YuDQo+IA0KPiBJIHN1cHBvc2UgdGhlIENOViBDbG9jayBtb2Rl
IGNvdWxkIGFsc28gYmUgbWFkZSB0byB3b3JrIHdpdGggdGhlIHR5cGljYWwNCj4gSUlPIHRyaWdn
ZXIgc28gdGhhdCB3ZSBjb3VsZCBjb250cm9sIHRoZSBhY3R1YWwgc2FtcGxlIHJhdGUuIEl0IGp1
c3QNCj4gd291bGRuJ3QgYmUgYXMgcHJlY2lzZS4NCj4gDQo+IA0KPiANCj4gSWYgeW91IGhhdmUg
c29tZSBleGFtcGxlcyBvZiBob3cgdGhpcyBjaGlwIHNob3VsZCBhY3R1YWxseSBiZSB1c2VkIGlu
IHRoZQ0KPiByZWFsIHdvcmxkLCB0aGF0IGNvdWxkIGhlbHAgcGljayB3aGF0IGlzIHRoZSByaWdo
dCB0aGluZyB0byBkbyBoZXJlLg0KDQpZb3UgYXJlIGluZGVlZCByaWdodC4gRm9yIENOViBDbG9j
ayBNb2RlLCB0aGUgYWN0dWFsIHNhbXBsZSByYXRlIGlzIA0KcmFuZG9tIGFuZCB3aGF0IGlzIGV4
cG9zZWQgYXMgJ3NhbXBsZSByYXRlJyBpcyBub3QgYWN0dWFsbHkgYWNjb3JkaW5nDQp0byB3aGF0
IHRoZSBJSU8gQUJJIHNheXMsIG5vciByZXNwZWN0aW5nIHRvIHdoYXQgYWxyZWFkeSBleGlzdHMg
aW4gdGhlDQprZXJuZWwuIEkgY29ubmVjdGVkIGEgTG9naWMgQW5hbHl6ZXIgYW5kIHRoZSBHUDAg
aW50ZXJydXB0IGlzIG5vdCBhY3R1YWxseQ0KY29uc3RhbnQgaW4gdGhpcyBjYXNlLCBidXQgZm9y
IENOViBCdXJzdCBNb2RlIGl0IGlzIChJIGhhdmUgdXNlZCBmaXJzdCB2ZXJzaW9uDQpkcml2ZXIg
ZnJvbSB0aGlzIHNlcmllcykuDQoNCkFsc28sIEkgdGhpbmsgeW91ciBzdWdnZXN0aW9uIHRoYXQg
dGhlIHNhbXBsaW5nIGZyZXF1ZW5jeSBvZiB0aGUgY2hhbm5lbHMNCnNob3VsZCByZWZlciB0byB0
aGUgaW50ZXJuYWwgb3NjaWxsYXRvciBhbmQgdGhlIHNhbXBsaW5nIGZyZXF1ZW5jeSBvZiB0aGUN
CmJ1ZmZlciB0byBiZSB0aGUgYWN0dWFsIFBXTSBmcmVxdWVuY3kgb2YgQ05WIGlzIGEgdmVyeSBn
b29kIG9uZS4NClRoaXMgd2F5IENOViBCdXJzdCBNb2RlIGNvbXBsaWVzIHdpdGggdGhlIEFCSSBh
bmQgd29ya3MgYXMgZXhwZWN0ZWQNCndpdGggYm90aCB0eXBpY2FsIElJTyB0cmlnZ2VyIGFuZCBv
ZmZsb2FkIG1vZGUuIE1vcmUgdGhhbiB0aGlzIHNldHRpbmcNCnRoZSBBQ0NfQ09VTlQgdG8gMSAo
YXMgaXQgaXMgcmlnaHQgbm93KSBhbHNvIGF2b2lkcyBvdmVyc2FtcGxpbmcgYWx0aG91Z2gNCkNO
ViBCdXJzdCBpcyB1c2VkLCBzbyBJIHRoaW5rIHN3aXRjaGluZyBmcm9tIENOViBDbG9jayB0byBD
TlYgQnVyc3Qgd291bGQNCmJlIGEgcmVhbGx5IGdvb2QgbW9kZS4gVGhhbmtzIGZvciB0aGlzIQ0K
DQpJIHdpbGwgYWRkcmVzcyB0aGUgcmVzdCBvZiB0aGUgY29tbWVudHMgYW5kIGFsc28gY2hhbmdl
IHRoZSBDTlYgQ2xvY2sgTW9kZQ0KZm9yIENOViBCdXJzdCBNb2RlLg0KDQoNCg==

