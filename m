Return-Path: <linux-pwm+bounces-8577-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fb8H+YZ3mmFnAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8577-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 12:41:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF43F8E19
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C3BD3024906
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4C3D6685;
	Tue, 14 Apr 2026 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g/L7kLCO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91639B4AB;
	Tue, 14 Apr 2026 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162767; cv=fail; b=BKFX3UnGPopv9k5muvjqdy0mR7iSSQal7fjwjwS1Llis7fyNAC9wp9q3l0Ps+lrgYjn7FbSQgiKiM/w/5MTevZfOjfYqZzn/Y3565seLCJ/QwMpdCKEqq8oFDzxIcFc6fRZDifPGaae3uuQZLMnTLzRyyJWr9OdPfp86NXX0sk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162767; c=relaxed/simple;
	bh=ScNxXhcvnm8juDIC8lPRAVAHr4PSDAqRFgRdhx2hd+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Syl0gd8I+9jAi4no9gJOQyBCOPpzVtLWwAVU6DMcyfJ9AznLHodgQK4YPzPOX2SjbpQbWONB5IVEMRiVntOhZuUG/B3mPU41uhTXLW229w51MsRBQtZusjz71wRtURZJ7KAwNr+qCLt21Ic5JZOU/wb6pL6m+cWrJ3jF6bc/A/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g/L7kLCO; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E5c4Yh3389509;
	Tue, 14 Apr 2026 06:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ScNxX
	hcvnm8juDIC8lPRAVAHr4PSDAqRFgRdhx2hd+0=; b=g/L7kLCO9HaYO7mlvovRT
	FDJuzjzmD81GuSMyMY9K268tQmslag7dHzcBnoRfP7tiGXHvEqxw70x4lBUWFXZo
	O8ZG0817Xu+qgK/0qyR+LFLZkmgXWxvRA0cdu3RnTW6HvF9T8BQglMrxX/nS1Eup
	Un9ZwFunx+/ZS7xtRHsZXPYjBUD/kVHO9QkPIJl7HGEiwfgn52eFL46iLI+io9vZ
	kLZiSku9CVxusvECgC7I6tY/7mF6ohOgkhE7510tWX3vHdaQGJ3Res4ipSqmWBT2
	GpECGkiJG8c+sDNK7W5BV/oky+ivmrm5SWxTkqwpfLnTmZsSJX2BbfhJflTXjcDX
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dh86w2m1g-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 06:32:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9SwLEz5Qot7IZNj9h1NvQIzg1WnV6PbQFqXCF4/vMJhCWHWcJYYGkNyxnJcK30V//T2zDP/wxpsewcefoHFXBhVb+vpBEfSylDmaTFrJpJQzf7xRcoEbXac+kLulQinOgVXR5EqoSDoPzPl08nY/ou8US8tybktNCPpowMYjCiqgss0i/Uli5y2mW4G6vOol4xTCQvHLaHSzbaxxp244TFR++cF85PDkCcZF/HxSNaUYrHaYoUz4LbADEE+MOwqEzgoGwiBQzic1vU5ttlDNSHtrnIsPLbbSxQz9C2Vxw4h9NEXKDyX/d0ch6t2topumoCOGxTlz742I1fx+wVl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScNxXhcvnm8juDIC8lPRAVAHr4PSDAqRFgRdhx2hd+0=;
 b=iYViGYoI+ZdqF1HdEhFDq0hVgDdRImoWXZK/j5juIw7XBqOhtpSWLK6oftZLoCz9mthv9QOHtvzx7tsmMHeHQlJ0ln+9gueenCCedY5/reCTH9dZJV+w+KKl4yWYcglNgjX2fuOSGx9vi0y+EPDaQimSBjUpKgNTPeZGKrXPeP/4lmjijJXgI7u2X6UzLPtZ8Dh6Q1V7+9EpD5fh0IAwBLLYiG7u9Phaslk2ZXZ4lOcMbOb0J+Xi8fb1SpOfGEwk8JQoXcPaSb2IGnZ1J6KCiQjDZnkTwDjHNDeAwGLkav6GPIg6IvRgwScOAwcK/8DbAQX2NB8mC1rRlOac3A2myQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ2PR03MB7096.namprd03.prod.outlook.com (2603:10b6:a03:501::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 10:32:10 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 10:32:10 +0000
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
Subject: RE: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Index: AQHcyDWKLXLdMUxvy0qzqrU5i7lMELXYzdoAgAWUvhA=
Date: Tue, 14 Apr 2026 10:32:10 +0000
Message-ID:
 <LV9PR03MB84148010A9C3D7FB35619A42F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
In-Reply-To: <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ2PR03MB7096:EE_
x-ms-office365-filtering-correlation-id: 6b851968-407b-4922-6ba2-08de9a111610
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ZhWZbueKE+eKB9aqKe5cwvVeiDIg0HIYR7FQLlRiouzb/pIWaB/a4u7fOcfgqGmy2GjMMLrXOdJqQPGNgaOnqpk2hhFHJpNj8yL7v8tMmppeErdlwmKnUQnKm5rA5MeQLx/RWW0FSKSHk6v2kHiFt4IzqfOkJy3Alj+U0dZ93O2PdXivZpOWoEmr8sDQUILFf/9iKkyAy5Sy6AcEEtQ5gPo/OOYCDTl+PRVU8R17ya3SWQDQZ45EIZcOGyFu2DKM6LojIgbdMcx7y97uFVgoDaUl/uHDEnJzvJ59ULc/8Fe+OOwycEoEentMhIgfH+YDBWYk++STKYD59ypC2SoMoHfNhzNGH6bs71rjmgbqWqAynvbcneRPqSzSQqjcEnKmRDVqp5ZIn9kKjXKHTSLNYCZCPUEj59fLI/yjxTQKlX+h5ehiuYgNzWIDaPfXhs2z6zgNgNskvSnk+qdEZJ49Y4H3RXW5MyIDw8D75B8NOlVLvRaDz7qK5l2DkqSXAr6c7+DQvZ+TqCQUtic8t/TD4IJuhKg6sdhIWsKFsUl3x72pS9nE/NeaCj1m0sVaKeyEzbXQvOxeNYZ3rpNW+IglHx8kt1H8ijVqRt8NzRnyx+nQrsei6DsGnIL42zRCR5JnNyqjrHOqsJXYa40geXt61QSaRv69fGw1rMMhJGxC06t5dJjkE6uXchVxFWYaFBh5ffqpNxglBe8MvgzWhiqtiarpiLBMhEmSVDzWjbTcV1wpeApER0BasJDrPmLI56wHUqTrvB931EvG7KLYzSoPkb11VIFU5e7FEX842wZw6qWQ1k8haeXXfRA94CFgta5i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEVkU1ovUVA4Y2VKdG9iSm5qanhOekdoUkdIQ2x0cmsrcVc4QXJoc0swOEJj?=
 =?utf-8?B?NVQ0SFhpSlpQVzIxSHowU3ZPcGxHenlROXFMMkhhUFlEcldXWW5kcVdRNE53?=
 =?utf-8?B?SDhldFVDL25Vb05oeW51U2V4eUtpaVVmQWtHS0pFcDFVZ1pVVUYrb250Qlhj?=
 =?utf-8?B?bFBCRWxxTkxZLzJpMEVyaG1CQnB3L0NvQ2VFclROeDRPYi94R2lKSUdib0pZ?=
 =?utf-8?B?Y1FZMlFPcWh3ZkczS2hEZnlxa3ViSklNNnFFeUJFVEVJbmZuZ2NoRjk3Nno2?=
 =?utf-8?B?WHpoSkt5dEVOZTlmdXV0MnQvNEVVMHBENnh5K2ovWm5IQjFMTmZoaEFYbHpG?=
 =?utf-8?B?OXFjMXhVVkZHdjFEQmFSRnNwdU1Bc2FSWkp2NkFqMDVBZVNwdGIxTFRwQmtV?=
 =?utf-8?B?SlNiUmVvWDhxOU5hL0hZcE44T05aZUpMbnlZb1c2UDVKcHg0a1c0WVdla2Ri?=
 =?utf-8?B?eW1mMmZZZzhmUlQxWElhd1gzY1ZROFlmWmRhVUU1dkVtM2JNU05JZUtiWDRH?=
 =?utf-8?B?bEhvUlo1RVpIUTBPOEoydDBMWnFlOXZxNHRsRERtb2FXbEE1UTJneFVqVnBL?=
 =?utf-8?B?U21SdHk3Z2ZFa1hvc2tPa3BGQWJ5R0UrSlBEeGNiR0h1dm5rTFV3VXZydm1W?=
 =?utf-8?B?N3FIUXhlb0pnLzM2WmZRa1VmYTYzdndUbTRJWWRjbkpVcVdNRWp0OGY2WFhp?=
 =?utf-8?B?cDU0M3dRR1hhUmdXM3FEVlFldDRqY0UvQmhkd1NSQzRibHpUb3ZpaytLbjFG?=
 =?utf-8?B?YjlQRVRWbTNUdlkzTHMyTGdGTTh4Z0srWUpnQ2d2cEZ0NmtBNGhYT2tMQWM2?=
 =?utf-8?B?VjhLY3pqYmY3YjQ2NytHbjRTaytBajMwUHNVeHgwc3ZyaVlZVFA3TGhJVEJz?=
 =?utf-8?B?YzEvNjZvZ09WU1liN3lmejYvY3ZDS0NpRmZDSHVwVCtjZzFwTnFIYXhDbEc2?=
 =?utf-8?B?MkpRSFB2OFV0S0hXcjlGV3BYR1FHdTg2UFdOOExucDB6RWYraVNwYkFzbG1I?=
 =?utf-8?B?R2huQ1VZYUExWW1rM25ON3gwMkptMTh3UU1XanVocE1EaHBuejQyb2ZoTzZs?=
 =?utf-8?B?V2RYdTYwN3hteUVPWGZTK1h2eENmbTR3aldVcnhlYjJQQTltbVNHWmlMYXNJ?=
 =?utf-8?B?UlRjZitBZ0QvaHYzMm51Z1hLcTZrRlgxTjRpVGZETlBHanMxWWV1TDJWcFFO?=
 =?utf-8?B?cTN4TS94NmZIcHdHc2ZMSmJVNTF3clZaWkl0M0V0cjZZRlY2YkFtclQ3UUYv?=
 =?utf-8?B?eU9Mam1LdFNlMG91WWdjMkQ2dTVweXJEVnVtWGdWYUk4bFNlTnRqTEc0VXJo?=
 =?utf-8?B?SlZQb1B1c3hub3NITHp6cTZpdWJQZWNCdzcxOXBBT0dKUjFZV04xZU1ZYy90?=
 =?utf-8?B?TDdHT2dnUlh1UGNQSEN4ZjlLVHlUME9EOUxwa1kwcjZIS3JtWnQyRTRwUzA5?=
 =?utf-8?B?WjBKVmJ6T1pPTG5FZEhZTWVoMC93TG1NOXpsM0lUZHhTLzc3VDMxL2N2MGFK?=
 =?utf-8?B?T29yazdQanUzSkJjT1JBbTJtK1M0SXhHMVFLR2hwN1JTdTZGSTBkRm5XT0xM?=
 =?utf-8?B?bW00a3R3ZFIwMWQxRFhvU1lmdGJzSzJUZTdXeG11alNqRGYySlBjRWlJVU9L?=
 =?utf-8?B?OEtjbTFBY2dVSUxFRXBrNXZUclpkWlRpWFE1djdmOGdlTDVEazIzd09lci9N?=
 =?utf-8?B?cHlvVGQvUlVOODFPZHdWcWJJZkNEaW8xdThya1BYS2Q2L09FOWRUVmgrbzJP?=
 =?utf-8?B?ZGZld3AzQ3RpMWtTUytQZ3pkaDdya04rNTJYWEMzYVpvNXBsamQzaStNem9v?=
 =?utf-8?B?a1g2c2ZaODloM1FGNGwrTGRmK2NsNm52NCswK2EyM21Hbk1zN2pKbzB2UXBa?=
 =?utf-8?B?RWpjN0pQeFBvR2l6c0dTMVVQV2JVU0k4OHBMWXlQcHFseGRudnd2VzJuOFR2?=
 =?utf-8?B?SUcwV1gycFVPaXN1dzBCWmRRbnRHTldmVkJ4bWdYbzUrbU5VczdxaEphSmJC?=
 =?utf-8?B?Znl2dFpKd2Z3dENIc29YbmdaQVcvRUV4SGxpR0tHU0JFeXFoZ25LMDJHeVNZ?=
 =?utf-8?B?UHV5cnlxVkhmVG4rQzI1WlVNa1FGQTB2UEwydVg0cGdwd05KMm1IeThLa0xq?=
 =?utf-8?B?WXY5cVc4VEgyNHBxUHM4VzE5bjhkbjZwV2g2SEsvVk4xZS9DV0U4ZUpQR0NT?=
 =?utf-8?B?TC8xVkpiaDFGUE56M3NsT01sbEFCcFNXVkVQS2FuSG12eUpQVzBOSCtkSDd3?=
 =?utf-8?B?all2VHN1MyszR1UvVnE3TGVKMURCcHVKWmV3Z0tkQmtpV1lNMnhEZURpbmRJ?=
 =?utf-8?B?dGU2VWlETVpJdnNGazA5cUFWOEltOGV5d0lDVENZWkdxUVQwSzVhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mUVPYOL2tw3gZm0pCKTeWTXxiJZe/nhLfXjF8cLnxNLOEMXFBrnWOizje5+BdBW5mfV1xR8zDX+me5j+fPyYFFAteNaIjz1xCrdQjh303e66i6Vm9Fz9Pu1maEOsSKEA90waAX/jJChrIbKMaNMPKBnBKzike7Y3HwpPk2FPtO1dvVUmqRZcJH2vMIFqcOcwzt7XTTVrVGzcbycKD0qqu/j6LHXE5YzsNmyGqP7ALJwViBmSqta1SEIdeEeN3hoNb2SgvN4tuVAOhP8kAnB4i5Um+TGBJngt/uJt/DiMTazfovLZitos2QjGjDqgp0KxHd3PwTfFZDtbm0Uo0Ff9RA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b851968-407b-4922-6ba2-08de9a111610
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 10:32:10.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EI/b5OcuRbhmrfFzICy7IwpgPxbUVivdTSVplY/4Qqxxr7rSxJ4CgIMJCIf9QkXuQqCU/kAzAAqKdaPwHsEYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5OCBTYWx0ZWRfX/onawJq6QJCs
 12mYpMI4UdByiK1H1/3eR62Pleh7EZ4trbGxdTHn5yh9AxH7C8nZRIrQ2Lr0mQB3PWD9OLRzyG5
 xzKkQVbhwePOTR0OZmoMEj7Yrs9OuSG+mzX0J/VW8fYLN5uSTSO4YPLcPRDbHELwK3sHyyr1M2W
 sZy+FkKhiJahUR4OLDZjahj4znjycsBpVZgzEUNk5ALAkbVDh3zmCIoxIiybKg0CxOfC+SewXYH
 QQFjiv958at6gzURf2YvN8KLjmnBnOp9vGn5vzv5FUJpOZEDU5jfFzHn9xaNmHMiAxNXBQAg8Ki
 et3SEmd40c/1F6cjp6Hu5GIb1G7E/uiBybaHmeTNSyn84+BMVnCzxadx6QTTjSNUze3E+oWUnm0
 qzhwylblAdJBs3mV49RG0Ii6dRiPN+7bI4RQedFFbMCner5w1jMh8ol4baNhIESjXkZ3sxLCpx7
 l+F8q3dRNaSYoQL4NzA==
X-Authority-Analysis: v=2.4 cv=FKcrAeos c=1 sm=1 tr=0 ts=69de17ae cx=c_pps
 a=xBU3AFOX62plvdJ7VrUh9g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=IpJZQVW2AAAA:8 a=y5pfCZu2jHKkDq2gMbEA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 3isPBJTvzaAYockILohcUrxnJzxOP8gV
X-Proofpoint-ORIG-GUID: 3isPBJTvzaAYockILohcUrxnJzxOP8gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140098
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8577-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 93CF43F8E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgQXByaWwgMTEsIDIwMjYg
MTI6MTUgQU0NCg0KLi4uDQoNCj4gPg0KPiA+ICAJb3NjX2lkeCA9IEZJRUxEX0dFVChBRDQ2OTFf
T1NDX0ZSRVFfTUFTSywgcmVnX3ZhbCk7DQo+ID4gLQkvKiBXYWl0IDIgb3NjaWxsYXRvciBwZXJp
b2RzIGZvciB0aGUgY29udmVyc2lvbiB0byBjb21wbGV0ZS4gKi8NCj4gPiAtCXBlcmlvZF91cyA9
IERJVl9ST1VORF9VUCgyVUwgKiBVU0VDX1BFUl9TRUMsDQo+IGFkNDY5MV9vc2NfZnJlcXNfSHpb
b3NjX2lkeF0pOw0KPiA+ICsJLyogV2FpdCBvc3Igb3NjaWxsYXRvciBwZXJpb2RzIGZvciBhbGwg
YWNjdW11bGF0b3Igc2FtcGxlcyB0byBjb21wbGV0ZS4NCj4gKi8NCj4gDQo+IFdoeSBkaWQgd2Ug
bmVlZCB0byB3YXkgMiBiZWZvcmUgYW5kIG9ubHkgMSBub3cgd2hlbiBPU1IgPT0gMT8NCj4gDQoN
CllvdSBhcmUgcmlnaHQsIHRoYXQgZXh0cmEgcGVyaW9kIHNob3VsZCBleGlzdCB3aGVuIHJlYWRp
bmcgcmF3IG5vdCBkZXBlbmRlbnQNCm9uIHRoZSBPU1IuIElmIE9TUiA9IDQgdGhlbiB3ZSBzaG91
bGQgd2FpdCA1IGp1c3QgdG8gbWFrZSBzdXJlIHdlIGFyZSByZWFkaW5nDQphIGNvcnJlY3QgcmVz
dWx0LCBzaW5jZSB0aGUgc2luZ2xlX3Nob3RfcmVhZCBkb2VzbuKAmXQgdXNlIGFueSBpbnRlcnJ1
cHRzIGFzIHRoZQ0KYnVmZmVycyBkby4NCg0K

