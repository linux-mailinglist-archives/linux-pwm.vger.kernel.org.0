Return-Path: <linux-pwm+bounces-8484-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LswGEt+02lZigcAu9opvQ
	(envelope-from <linux-pwm+bounces-8484-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 11:35:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920F3A2AA3
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C293011F3E
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45E320CAD;
	Mon,  6 Apr 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UNyhEkJJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158C2E6116;
	Mon,  6 Apr 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775468101; cv=fail; b=OuPtbMY0xGMJjD7b8vQJ0c0AaX/ofrfttYrwCGF3t6hRpXFX+3VL7sjNQ/P5eQPZpe+SGA0NuxFal53ZT4+Pl88U3kbHYjkLuaEzNY4XadtzOe4rl/T5qh0/L2HXJ+9OjG7BV48vcESN3Fxn/VBzfpWMEQzb1PZT24nD9WhimlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775468101; c=relaxed/simple;
	bh=vDhopd32/4+Q4WlsGUe3AOGYZBillW8SqUcTWnPOIg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n4hWjIWSq8jkKSv4ErAGZHGQY/JDUZB3kjfWocIVPk4PMUBXkRUar2+STHnaKEpMvOjjHQDCUbgcZePl3+2lwCtda/cMgborKkEh6EXo26v6AchcCcDFeoLpVDHS1AgGvWzmy4OdeHhoimPbteqqHgfDlD9oWmrFROg+Pb1r98c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UNyhEkJJ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6368OpGO021179;
	Mon, 6 Apr 2026 05:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vDhop
	d32/4+Q4WlsGUe3AOGYZBillW8SqUcTWnPOIg4=; b=UNyhEkJJ+KFsxxaXrvs9Q
	yZ7OKYPdvAjiTXxuMLYHE0AC056gZMlGN1eiu1LkyhjMl6+wI1mLuYN9a47oqhdw
	WRsINkvcfe4mHRGlyA0Orn0P6b9qm+bstmiaVjLYYJsbWJ4ft09sbiCgahC9KqXL
	H/qA2eBG9ggBZ24jCLC/j8ktnoIWx3fbVacOE+5q9EXh8CWoPp/oPEY59lLvMSwv
	Ci4jgGHTBwnSWnwQsXGFA1hhlGClB7lBjvWwRhnsaWU82n15xW4xKhBhFxBN+hCI
	FtMhBOuGpqRW5cn/aaDoOpk5aYZYrwbdcmER/4TPyskFupJcfw/3+4D4fgE49CYx
	A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dayj1erb0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 05:34:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqrziQ+zkENr27Ro4bqDGLm5JnrUZdnZ5boAGzVujNHlkI7qiCwAJ+SkSGdVB4hLHa1rOCiZQEjmb/pmE1ihpccMKdsNirMkzUBWYQ8OfH/A0KvRLQO9AJ2NdZL8GkwnZ3YRnfJ7o4E4kJzICktAc2C+FW2uBScktAF4aG32Jr9u7VsAFMZXOoeroEjCZtBSSruo21TiKQmnjrl+UwTly2IZVZuX1vFKoPtSvJT5umNWS+KTFKyO3JPbVHkiPjt3if+9/8VijR7DBBZIIbCjORuSXeifjz8UV24TsfkMZ2Ra76uImRIm07k2/6jPUi2KumsssybMSa1ZZ4eEerfrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDhopd32/4+Q4WlsGUe3AOGYZBillW8SqUcTWnPOIg4=;
 b=jVrzx1KdWgadzTu7HFsTL0n5CYuSFLhxdjD+cxcZqgON4B7oZ8KLkfczanaMVB0yg4XjDIGl1jQahvL3lcm/Bsej9USC96cr9QsG7gNH/Yis7wVpPuGSQrkk/9OJNGL9zYo8BZmWLh5ag00OBLPWF3tq+ji5g8vO5gFbSNjtaxBzg75YlNqAyKH+X87SKDi1xHPmoelp7iAIPCdPXofjRnNRKzBxthP6uJFS9PKMPPYLS/ccll64qF/Un05HrqeQC+/AreDbSCESk8OvqoU93kOqwAnKrTPTmb0K4zTuN4a2/C94IzoUnHeAd4j9gDwiHw7Lk6wKbUcYOvEltWzlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BN9PR03MB6074.namprd03.prod.outlook.com (2603:10b6:408:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 09:34:35 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 09:34:35 +0000
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
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPClqAgAK8tzA=
Date: Mon, 6 Apr 2026 09:34:35 +0000
Message-ID:
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
In-Reply-To: <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BN9PR03MB6074:EE_
x-ms-office365-filtering-correlation-id: 0f67ae15-6358-44a2-572d-08de93bfb723
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 o/YGz9o4XeUpo0+Rm+0858iiPO54k71pIYz4+1GZXI4pL1f0rHeQIuC1/YLinWeqRQupd+lBgufJSSZt5hXrMJZKjQRVKtCIjSEt68Z0pkpaKm6m+aYCsmvazywnsei4Eg4PMRPD1nAtYDZoWo85T80cgvp5/fFdMSq5wyb55XrIuH/UWH9WCd48TXVyT41nx33r54/GH8VZsziTbXRr6cYwaGsGJ+Q/fy7drB790RxvA0vxoG2Cd6YGVRWJa5gW0pG3I8CaH80Iu/RlAAZABpg+x38M70xCSn8tdpMXh/uCzfEH/v49zd9HC/29TWhNs//MwN54BnneCzxsF8t7JqdWkQKN7whRa2zXAz4xrmGTIsfZBZ87i6QkA6AYwbNmGZWG/aBEb+/YTky0oSNhWj0eJnCAYz+En14xxnO+RsbarvKm4z2i9TztsFvBVjJk6cU1vy61Y/HiLi+Zu8bop2KZ+ZSKB4HS+NahnvlezAwbNzqKq9v2s1Y7zn2iCzM1AZmCJQmiNFw3HzRpl4HrFUsnNLDX10iCuOoPlg017uie+00Ked2//vcnyX3F+/ZSgQzy5bmGoUhf8Jfi3kKzmXQOdKixGGlrVDh3hVmUd6w4vAge9Rr7wjNo6wOT4bq6KkmtrhUlX3LVdsozW44BTKW28tpnU77opTRw4CMC4O94jJ96K2TnksCYDR9llwow+3RkO21b0pHEPNe7FvatG7sMuFmUxg0aeRV7MLIofya+RMerFIvLHk27UDx/Ua/EJwkRgesItHerfzRDJwa46Pi6QgBkfuSp2SSj7uBLkuJAWdkEKT7A5EUbqnz+zLJM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG1ncS9jYmE2dVRKeGpLUXhkR3RZcktxNjFoWVpicE1lVFk0dVJrQjd4UGx5?=
 =?utf-8?B?NnhDUk54V0NReDdHOTZLaXBGZXlKdU82ME81ckgzK0orMlJXSzFXbEZEUnBD?=
 =?utf-8?B?c1Z6Y2RVTmgyU1BXVjV6SUtFSUxyL25wMzR5bWljNnFTQ09PL1RIL3kyUWpS?=
 =?utf-8?B?WUZRZW82algxcHV6cGd2K0MvbzREelNmY1VQZzRIVFVYZXRDNmd5WE5Db2Rr?=
 =?utf-8?B?cUp3ZXFVczJOU3ZndlBReENPQ2lnZ1B6dUIxMVJneGZDZGtnc09rcW9pMytS?=
 =?utf-8?B?d2RFTk5kT1puT25DM1YrU3ZCZFBETHRXL0JLNzROd1VZN29LRHFadTY1d3da?=
 =?utf-8?B?Y3hSbExHclBHaS9pQ1Z2bkhZcXhCYWtaUEpOakpxRnI4U3dYY2JIcG5BQmZV?=
 =?utf-8?B?WlNTbTQvNUM1UlpicEFDR0NCWng0bFAvL0NmRXQ3YnNKMFZSQ0d1Ti9BeExl?=
 =?utf-8?B?RmN0MDVUZExaUUxZS21jYUJhWXRpTyt5NVQ3MVpuM2Y3STZ4WmhoR2gwaVZ3?=
 =?utf-8?B?YTJEVGk4cHNCNlV2Mk1Cb0xBQ3lqZUQ0UWlmVUpvc3VkTklJYWI5NnlVL1hZ?=
 =?utf-8?B?bzJJcHVENitOSWN3MnVORXUwTlpEcEdDSGJROGdNeVZiM2xMYnFyS2NXcTlq?=
 =?utf-8?B?ZUVaakxxU3Bmc3FjMkVaYUljeWw2ZmxrWnR2em1zUHVRaGl1OFU1WHg0OFpK?=
 =?utf-8?B?YWNST1E4TW1zTVZvTTI4bVhzUDA0N09rUGQ0N1lXY1o1K2w5Z1QwcitNekpJ?=
 =?utf-8?B?TFhkYjhhMllTRXR3ekR0WnRROER4NXlseUJMUDdvSEFDYUlmQzNZQUtsM0Rm?=
 =?utf-8?B?c1IrMi9qK200Z0JlS0h0WlIrVGM2T3l2V0V5NmY3cEJXWTdUUTA2S2ZVeDAy?=
 =?utf-8?B?SjlwSEFSbUsxYjdQcnZ2TG5aUWdNTjRQRWlvblhubUl5MExNRDRvczRGMW1H?=
 =?utf-8?B?a0s3VEUrQlhQM09TSUUxQkRTL0tDV09jMFVDdkh1dlhMeVozUFgvMFV1ZzRp?=
 =?utf-8?B?N29nV3J3VVNjc3ZaZDBkWGZIZmlkU0RNTXk5eW4zeEw1K1BGZ0VCUVZCVDNW?=
 =?utf-8?B?R2NlWWI1ZE9PWGRwbXhhaWoyL0s0WTNjY2szcTZXQUpod1dFbUc2QkRuRFJ0?=
 =?utf-8?B?V0gyT0ZqYmtJSWswV0FmSWNmL1NFSnFkL3dvMTI1bEZCZ2RMSi93TzNsYXhu?=
 =?utf-8?B?eWRyd25xa0dtbzl5bUg1bS9veFZEQUgwWGpuSTZSYU40SmZFK3VqZTZmRjRS?=
 =?utf-8?B?SVdpZ2pRM2FmMVdYM3VxazI5QVhJQUpRSGlwWUlBZWY5dHpBOEdJUUNYWE5T?=
 =?utf-8?B?MjJDZkJVTnk4S3Y0eGhNeHlxWEUwSlpkL2tOWWZWencxeXR4MVFxN3M0U2FO?=
 =?utf-8?B?QVg1Sy9NY2dtQ1JvUWlsZURaNHo4QkZibDg5c0JqZmVIOTNlYmRqNjYvU1Er?=
 =?utf-8?B?WlYwTW9BTHJ5bHlPY0hqMmYyMnYrd1VZZUhqNlN2MTRqaDhlNVpDaWMyNnJ0?=
 =?utf-8?B?KzJvWGFUTlZFMHpscThWSEJpR1ROYXFuTGMvcWVNSkkrUHJlMXRRWmJIdXJ4?=
 =?utf-8?B?MnhBVitxNUJvdk42ZzEyMlc1b1FXeEV2OXhWb1Nrc21GMUwwbmtCZDRkaEwv?=
 =?utf-8?B?MUgwZyttR2NOY1VPeWhyb3hKUlJpYWFDbWpkakdsVU5zeE91K3Q5WUVOeFlL?=
 =?utf-8?B?SHErYlE0aWxGbnUzOVM2aHMzNmNsTGhuTUsvZkc3bjV3VDd4eGJadDUwZ3dX?=
 =?utf-8?B?K2Y0SHdmbXJQUTFld1V5a3JaZUozdjA0aVhiL1RqMUhkNjY2WHpGbXZDdjVv?=
 =?utf-8?B?cnJDekUrcW5ybDA5dlBFS2RjSEw0RzVSdk9qR1RTVktad2lqNmF2VjZnenE0?=
 =?utf-8?B?V0FTMkNDUjdvRml2NWlzbXRDeStOWXQrdStXak43cjlTNW42N2tPdVczQXJk?=
 =?utf-8?B?OEpjK1BCdk91ZGZyeVkvZHBNUjE1Z0JyYXNxMGQ4TlplWXd6cXBHUE4yeUJa?=
 =?utf-8?B?MGtUYy9hS1pSZnQ4ZTgwejJrWC9zaUN6eS94UWRxTVJUVTNHUUkvSWd4QmZJ?=
 =?utf-8?B?cWI2Z2xXT0QzR1hudHhpRFpyWU0ydHQ3MlhjMjVlN1Y0WExvbzlndmJQc1ZX?=
 =?utf-8?B?c2pocGtyYkpiU0I3UC95NG1DdWVkM3p3aldWRFlpVExmUHdxMUNsb0hjYmxX?=
 =?utf-8?B?cUNGS3I4TTVocjdHZ0lNazkwMkMvZURmSXZLaitHUlFqMFl3WUVBZ0htT0xv?=
 =?utf-8?B?M2s0ZFk1N2M1QnIxLy9GQUtXK2xiandXOFZNYnlqSlhMQi8reFVhYVlUenBs?=
 =?utf-8?B?eUd6YmkyNExWdnNCODZRb3d3U3NwNFlJaFdiWXFKY0M5YW1qeElDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BvmxVAe3FOXU+qKIA8Jr85RYiGKKA0RFYKit/VFiNC9maz8g/SJjKTxEBAfDRKQxWUzCBnCskYXMupxcGFTaeoI6cUZMQw4E1/EZORROpcipRhoc+lSksMDYG1N7usGPnIsQYRKbflTxTMCK71nFxRPXOrJUXy9WwkWc9IENBr3OUjkiwXRC2+7JX5cMV5AakDwZAmWA3nOdttZn+FC3x2wYlS2m9R4ufb7ADzjss/uSzaitg31hCE2FIdWm4NY1jbe9LL0HDGL9npJgYA51j3Pg3HJCKmtCoxJADBoo+RhofPjskuUdSGQTjRMgJewGWB15Fye7CkQ/qlePssncOg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67ae15-6358-44a2-572d-08de93bfb723
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 09:34:35.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VWSnHmlzza/WsabYueJ0TTblgSa/bWpBz8QYgnhmcS+dbdabZYFo2I5Y9H3L3JwrajybVa20RRr6LlhHMRACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6074
X-Proofpoint-ORIG-GUID: sIX3cC8Tspymjmo_yRAi0ef7Gl4O8ggu
X-Proofpoint-GUID: sIX3cC8Tspymjmo_yRAi0ef7Gl4O8ggu
X-Authority-Analysis: v=2.4 cv=BbvVE7t2 c=1 sm=1 tr=0 ts=69d37e2e cx=c_pps
 a=ImwGUT2bfrWU7DBu6bNfJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=DkDdAUqFXoVUgL-olHgA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MyBTYWx0ZWRfX5Ep3NZciE7dW
 iHN33gygKVRYNYxyCT0gPD1ssUtXOfqUE4nofqNDzQi+BwxS8KFB2c7ATBJPHZi5YPo7+B/acui
 XO1txDyjfv3J+EcQoJIcq2Ev6oXfaZ1bHIHK5v26PRkFM2au0fNR/nhpsgrWnRN/5n7PE7BcvCQ
 qYgRz+UEJ7taE2p0UCzUEMt7qAEDkXz7xY3ivxeGO6INkNIaibXfb15jWAeV9gLgoz7/M8Tj7jS
 bvCkvdrKWD77S+gx9qfiBGuVb77GPEq2V8xyJxMtJz07yuLBSbBb+cxSgSNWUBZzze9dz9Mu6IK
 Vyo8nuzyVFlzp5wa1wzM5BCe1w3LW/xOh58add/BZ6scBfgE+7cUJOuiQMlTln9mxaT3toB71CV
 zsLiH9U6D9RfCFrSnqp1zfRiwi0KjV0qjmbu8wfVuzTiRPKECwysYTgTzAhtO+MRIPAbbBglvDI
 VVyjYyor6tA3MLfQ1Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060093
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8484-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:dkim,analog.com:email];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.985];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0920F3A2AA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA0LCAyMDI2IDY6MzQg
UE0NCg0KLi4uDQoNCj4gPg0KPiA+IEFkZCBkcml2ZXIgZG9jdW1lbnRhdGlvbiB1bmRlciBEb2N1
bWVudGF0aW9uL2lpby9hZDQ2OTEucnN0IGNvdmVyaW5nDQo+ID4gb3BlcmF0aW5nIG1vZGVzLCBv
dmVyc2FtcGxpbmcsIHJlZmVyZW5jZSB2b2x0YWdlLCBTUEkgb2ZmbG9hZCBwYXRocywNCj4gPiBh
bmQgYnVmZmVyIGRhdGEgbGF5b3V0OyByZWdpc3RlciBpbiBNQUlOVEFJTkVSUyBhbmQgaW5kZXgu
cnN0DQo+IA0KPiBEb2N1bWVudGF0aW9uIHNob3VsZCBiZSBzZXBhcmF0ZSBwYXRjaC4gSXQgY292
ZXJzIG1vcmUgdGhhbiBqdXN0IFNQSQ0KPiBvZmZsb2FkLg0KPiANCg0KTm90ZWQuIFRoYW5rcyBm
b3IgdGhpcy4NCg0KPiA+DQo+ID4gS2NvbmZpZyBnYWlucyBhIGRlcGVuZGVuY3kgb24gSUlPX0JV
RkZFUl9ETUFFTkdJTkUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IFNhYmF1IDxyYWR1
LnNhYmF1QGFuYWxvZy5jb20+DQo+ID4gLS0tDQoNCi4uLg0KDQo+ID4gK1NlbGVjdGVkIHdoZW4g
YSBgYHB3bXNgYCBwcm9wZXJ0eSBpcyBwcmVzZW50IGluIHRoZSBkZXZpY2UgdHJlZS4gVGhlIFBX
TQ0KPiBkcml2ZXMNCj4gPiArdGhlIENOViBwaW4gaW5kZXBlbmRlbnRseSBvZiBTUEkgYXQgdGhl
IGNvbmZpZ3VyZWQgY29udmVyc2lvbiByYXRlLCBhbmQgYQ0KPiBHUA0KPiA+ICtwaW4gKGlkZW50
aWZpZWQgYnkgYGBpbnRlcnJ1cHQtbmFtZXNgYCkgYXNzZXJ0cyBEQVRBX1JFQURZIGF0IGVuZC1v
Zi1idXJzdA0KPiB0bw0KPiA+ICtzaWduYWwgdGhhdCB0aGUgQVZHX0lOIHJlc3VsdCByZWdpc3Rl
cnMgYXJlIHJlYWR5IHRvIGJlIHJlYWQuDQo+ID4gKw0KPiA+ICtUaGUgSVJRIGhhbmRsZXIgc3Rv
cHMgdGhlIFBXTSwgZmlyZXMgdGhlIElJTyB0cmlnZ2VyLCBhbmQgdGhlIHRyaWdnZXINCj4gaGFu
ZGxlcg0KPiANCj4gSWYgd2Ugc3RvcCB0aGUgUFdNIGFmdGVyIGFuIElSUSwgdGhlbiB3ZSBkb24n
dCBnZXQgYSBjb25zaXN0ZW50IHNhbXBsZSByYXRlLg0KPiBJZGVhbGx5LCB3ZSB3b3VsZCBsZWF2
ZSB0aGUgUFdNIHJ1bm5pbmcgYW5kIGp1c3QgcGljayBhIHJhdGUgc2xvdyBlbm91Z2gNCj4gdGhh
dA0KPiB0aGVyZSBpcyBwbGVudHkgb2YgdGltZSB0byByZWFkIHRoZSBkYXRhLiBPdGhlcndpc2Us
IHRoaXMgbW9kZSBkb2Vzbid0IHNlZW0NCj4gcGFydGljdWxhcmx5IHVzZWZ1bC4NCg0KU2hvdWxk
IHRoZXJlIGFsc28gYmUgYSBjb25kaXRpb24gd2hlbiBzZXR0aW5nIHRoZSBzYW1wbGluZyBmcmVx
dWVuY3ksIHRoYXQgd2lsbA0KcHJvdGVjdCBmcm9tIHNldHRpbmcgdG9vIGZhc3Qgc2FtcGxlIHJh
dGVzPw0KDQo+IA0KPiA+ICtyZWFkcyBhbGwgYWN0aXZlIGBgQVZHX0lOKG4pYGAgcmVnaXN0ZXJz
IGluIGEgc2luZ2xlIG9wdGltaXNlZCBTUEkgbWVzc2FnZSBhbmQNCj4gPiArcHVzaGVzIHRoZSBz
Y2FuIHRvIHRoZSBidWZmZXIuDQo+ID4gKw0KPiA+ICtUaGUgYnVmZmVyIHNhbXBsaW5nIGZyZXF1
ZW5jeSAoaS5lLiB0aGUgUFdNIHJhdGUpIGlzIGNvbnRyb2xsZWQgYnkgdGhlDQo+ID4gK2Bgc2Ft
cGxpbmdfZnJlcXVlbmN5YGAgYXR0cmlidXRlIG9uIHRoZSBJSU8gYnVmZmVyLiBWYWxpZCB2YWx1
ZXMgc3BhbiBmcm9tDQo+IHRoZQ0KPiA+ICtjaGlwJ3MgbWluaW11bSBvc2NpbGxhdG9yIHJhdGUg
dXAgdG8gaXRzIG1heGltdW0gY29udmVyc2lvbiByYXRlDQo+ID4gKyg1MDAga1NQUyBmb3IgQUQ0
NjkxL0FENDY5MywgMSBNU1BTIGZvciBBRDQ2OTIvQUQ0Njk0KS4NCj4gDQo+IFZhbGlkLCBidXQg
bm90IHVzYWJsZSB3aXRob3V0IFNQSSBvZmZsb2FkLg0KDQpUaGUgUFdNIGlzIGFsc28gYmUgdXNl
ZCB3aXRoIHRyaWdnZXJlZC1idWZmZXIgaW4gQ05WIEJ1cnN0IE1vZGUuDQoNCj4gDQo+ID4gKw0K
PiA+ICtBdXRvbm9tb3VzIE1vZGUgKGlkbGUgLyBzaW5nbGUtc2hvdCkNCj4gPiArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCg0KLi4uDQoNCj4gPiArDQo+ID4g
K01hbnVhbCBvZmZsb2FkDQo+ID4gKy0tLS0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICtVc2VkIHdo
ZW4gbm8gYGBwd21zYGAgcHJvcGVydHkgaXMgcHJlc2VudCBhbmQgU1BJIG9mZmxvYWQgaXMgYXZh
aWxhYmxlLg0KPiA+ICsNCj4gPiArQSBwZXJpb2RpYyBTUEkgb2ZmbG9hZCB0cmlnZ2VyIGNvbnRy
b2xzIHRoZSBjb252ZXJzaW9uIHJhdGUuIE9uIGVhY2ggdHJpZ2dlcg0KPiA+ICtwZXJpb2QsIHRo
ZSBTUEkgZW5naW5lIGV4ZWN1dGVzIGFuIE4rMSB0cmFuc2ZlciBtZXNzYWdlIChzYW1lIHBpcGVs
aW5lZA0KPiBzY2hlbWUNCj4gDQo+IEhvdyBkb2VzIHRoaXMgd29yayB3aXRoIG92ZXJzYW1wbGlu
Zz8NCg0KQXMgcGVyIHByZXZpb3VzIHZlcnNpb25zIGRpc2N1c3Npb25zLCBNYW51YWwgTW9kZSBk
b2Vzbid0IHN1cHBvcnQgb3ZlcnNhbXBsaW5nLA0Kc2luY2UgdGhlIGNoaXAgb25seSB0cmFuc2Zl
cnMgdGhlIHJhdyB1bmZpbHRlcmVkIDE2LWJpdCBkYXRhIHdpdGhvdXQgcmVnaXN0ZXIgaW50ZXJh
Y3Rpb24NCmluIHRoaXMgbW9kZS4NCg0KPiANCj4gPiArYXMgc29mdHdhcmUgTWFudWFsIE1vZGUp
IGFuZCBzdHJlYW1zIHRoZSBkYXRhIGRpcmVjdGx5IHRvIHRoZSBJSU8gRE1BDQo+IGJ1ZmZlci4N
Cg0KLi4uDQoNCj4gPiArSUlPIERNQSBidWZmZXI6DQo+ID4gKw0KPiA+ICsqICoqQ05WIEJ1cnN0
IG9mZmxvYWQqKjogdGhlIFNQSSBlbmdpbmUgcmVhZHMgQVZHX0lOIHJlZ2lzdGVycyB3aXRoIGEg
Mi0NCj4gYnl0ZQ0KPiA+ICsgIGFkZHJlc3MgcGhhc2UgZm9sbG93ZWQgYnkgYSAyLWJ5dGUgZGF0
YSBwaGFzZTsgdGhlIDE2LWJpdCByZXN1bHQgbGFuZHMgaW4NCj4gPiArICB0aGUgbG93ZXIgaGFs
ZiBvZiB0aGUgMzItYml0IHdvcmQgKGBgc2hpZnQ9MGBgKS4NCj4gPiArKiAqKk1hbnVhbCBvZmZs
b2FkKio6IGVhY2ggMzItYml0IFNQSSB3b3JkIGNhcnJpZXMgdGhlIGNoYW5uZWwgYnl0ZSBpbiB0
aGUNCj4gPiArICBmaXJzdCBieXRlOyB0aGUgMTYtYml0IHJlc3VsdCBpcyByZXR1cm5lZCBpbiB0
aGUgdXBwZXIgaGFsZiBvZiB0aGUgMzItYml0DQo+IA0KPiBJIHdvdWxkIGV4cGVjdCB0aGUgImZp
cnN0IiBieXRlIHRvIGJlIGluIHRoZSAidXBwZXIgaGFsZiIgb2YgdGhlIDMyLWJpdHMgYXMNCj4g
d2VsbC4gVGhpcyBsYXlvdXQgY291bGQgYmUgZXhwbGFpbmVkIGJldHRlci4NCj4gDQo+IEFsc28s
IHNpbmNlIGV4dHJhIGRhdGEgaGFzIHRvIGJlIHJlYWQgaW4gdGhpcyBtb2RlLCBkb2VzIHRoaXMg
YWZmZWN0IHRoZSBtYXgNCj4gY29udmVyc2lvbiByYXRlPw0KDQpUaGlzIGlzIGJhZCBkb2N1bWVu
dGF0aW9uIG9uIG15IHBhcnQuICJjaGFubmVsIGJ5dGUiIGlzbid0IHVzZWQgYW55bW9yZSwNCnRo
aXMgaXMgcHJldmlvdXMgdmVyc2lvbiBiZWhhdmlvdXIuIFJpZ2h0IG5vdywgb25seSAxNi1iaXRz
IHdvcnRoIG9mIGFjdHVhbA0KY2hhbm5lbCBkYXRhIGFyZSB1c2VkLg0KDQo+IA0KPiA+ICsgIHdv
cmQgKGBgc2hpZnQ9MTZgYCkuDQo+ID4gKw0KPiA+ICtUaGUgYGBpbl92b2x0YWdlTl90eXBlYGAg
c3lzZnMgYXR0cmlidXRlIHJlZmxlY3RzIHRoZSBhY3RpdmUgc2NhbiB0eXBlLg0KPiA+ICsNCj4g
PiArDQo+ID4gK1VuaW1wbGVtZW50ZWQgZmVhdHVyZXMNCj4gPiArPT09PT09PT09PT09PT09PT09
PT09PQ0KPiA+ICsNCj4gPiArKiBHUElPIGNvbnRyb2xsZXIgZnVuY3Rpb25hbGl0eSBvZiB0aGUg
R1AgcGlucw0KPiA+ICsqIENsYW1wIHN0YXR1cyBhbmQgb3ZlcnJhbmdlIGV2ZW50cw0KPiA+ICsq
IFJhdyBhY2N1bXVsYXRvciAoQUNDX0lOKSBhbmQgYWNjdW11bGF0b3Igc3RhdHVzIHJlZ2lzdGVy
cw0KPiA+ICsqIEFEQ19CVVNZIGFuZCBvdmVycnVuIHN0YXR1cyBpbnRlcnJ1cHRzDQo=

