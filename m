Return-Path: <linux-pwm+bounces-8485-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OilLniN02nFiwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8485-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 12:39:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359953A2E15
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E4F30117A5
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952132E68D;
	Mon,  6 Apr 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cT6GxbPZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E62494D8;
	Mon,  6 Apr 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471989; cv=fail; b=k9ZpKkchjgxCEh+MGOySmomH7vc2JNDNbmlnrhr8ipA7ocn48GkKdo/7dWCshAgm+YgEihtPxXF/fcoOjGsnU1aTYqRjZheV7rpduBOXMUp2JMCYT3YZRfgBO44mMqjO7DPXZ2iOwjVlh8GM+YxnBnjI0gOXA7vD3gZiyizNbkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471989; c=relaxed/simple;
	bh=KVfK+X8H3j4HwTKMeK9YOdyc1HNirZ9IqAVQiF9UlE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8Sup71N9gSSU5hSMFlwlbm8BuohjHzEptMKGSL1MkkcQu/cRZ70A1DCuMrsmE01+V8dsop8cGpd4oPAUn+Cu84vpdVkqT0tMY/kl+DCERybzNR789wsEW4E9ZQeqED4ILB3GuIf78hVi5Cz3BcgBXedpNnRng4U3UHvrX2nPAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cT6GxbPZ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636AAuVF286138;
	Mon, 6 Apr 2026 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KVfK+
	X8H3j4HwTKMeK9YOdyc1HNirZ9IqAVQiF9UlE4=; b=cT6GxbPZOZbdmnS0afDbO
	nJgoIEzdM/masC79JIH4oC3Sg8CZfmpXW35th3OoFEuqIjeYAJwu1rkIrD0hLzon
	QaAcKbWMKNR6/U3xsCOC4TmfFCT5X+hJxOAUm1VCNE3WmRrJwXQCEffB1vKmkeqb
	nE11XqsAvQ7sizWLWZbbRy+6P25LDMFwUuNPEeeKaYEMaI6PSoWoXSnvTdX8wnlJ
	kuRNr+79HgqdsPwWkswbHNC6ewWiIacA6d7OtZAIopAHhFb81uK2Zbh/C5shEXS6
	nRlbqttghjWjz3dEhR7roEgevrjCSUQP6vguN5ZhMq3sKhD47w6okSZ+8d/NxqHk
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4day93xh15-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:39:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mniW596BN9QdCLdwcPf2DPQhacmMyN2aXahsVkD5ILh2DRHN+oBAHLTsU5yZN/o8LdzrcWB4kVPYs0bDRHHp+ols4nKEC+3/w1MO9lO76tNHaTJWW9i91PTzh1zVM+LdYT7IqL3LtGImhAwkiwgIFnlM1zQIjE0PtKZV7NkvdVEc24s5xLuPj7ro0L43ZLOFNyBkPuHIDJKyUsJaZMCcMMKDxgxtjH7tCmumuPsTJ56w7h4P3XevZZZRHzYVtSXck9v9chbtMa9ttkRwsTE0g36g+mJQ5NH6tVg5vxJgK82Mj8cgS0RCA8UGN0vGmLXI4iQMWs/hRCm7TKn7ON0xlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVfK+X8H3j4HwTKMeK9YOdyc1HNirZ9IqAVQiF9UlE4=;
 b=sifbSArqJzHCBmLsRIS3zdAtNWklTHI2r524QLNNnXM+6TEt1b1XyWYqu3BD+Mig6ywvXLkIXR18ZyR2mfMHJ0orwOkbGDGY7Snba3+blBaSTVaVW5T/M+8E34tgieUd85ofGZazfD9nS7D94rbec0UGGtpeaOIMJjO705YFyky+yJIwB8tNBXUo0WeqY3kqj4zH+YlEeD0bxAhfsE3smX1h3kdqAlIItaa0+fO2XHoAhi+NUmLWuTxZn2FeJGzvnGl6nMFmX+44bDvaWAx9rxy0eUcMko1GBbwFGkImVDF3Wx4S4mVyEJh9qhaZ4cWXQQaCALpGiu4rXmP8/15onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MN2PR03MB5229.namprd03.prod.outlook.com (2603:10b6:208:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Mon, 6 Apr
 2026 10:39:24 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 10:39:24 +0000
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
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPELuAgAK5+HA=
Date: Mon, 6 Apr 2026 10:39:24 +0000
Message-ID:
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
In-Reply-To: <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MN2PR03MB5229:EE_
x-ms-office365-filtering-correlation-id: dc492614-e8d6-424d-4304-08de93c8c528
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|921020|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Tu/A2VwOwXkTLeUZKG86QaG/5FQeusvVbrybxFNDfwu2R/kvWEJ//DaDMdxFF9sIf8NIugs8qrnb1/pti/SQ1MBmnsTyWvuZQcOEpUly0H26D5nehhBkSBJO+T2ezinwj35dypncEKyd3uVWIvQCrmhsjQWmNH66QaNtWOK2fL3VxOLcLBL8nkkNnH1CveoBqRZfacbY57jQQJc3cTgPhhKOIHDH2Q0J0YvpFFo9TSQpbH5oKrnCZtdJ0GY22ZWeh/cd4hzZTEitGLdHE810Eq+Fjz1K6R57g3zq1FWWNvUu/RftHoo0jPK/cGVpMNZqQNhtAyodgh+prOooTH87GW1uRBzgKp9W3CqlNaDrU1no0dubAqlrVb30OD9i8JQSzNDOOJTtiszr5oeVTPtvU2GB9vqKu4yIO6rInU2/cX+r9x8UnwKMOLVnPa2axWZCQLO0RH+RGmXydyhkkwypFXGnQ+f7eraNmgGUJr5qgoiTV5XOcP3Iz0nUA/QiPQ1kB12NulKSuocLu7+nXfLwilbiFINQqnXi48CmaSntK7Pbo67xXtzH2FBovyjHqZkIDYjkX0SXylBCmB6OnGC2WOHDRWEoP85dtOn+u7byYqEG8K5h+WYVr18Lqxh6hajtiiUQKBU19d2x/9/tdMarMPpWTV08zH6PhbxOuKe1hkGnKJ+1zYUmyqF1Pug+x5cdZ5jb8s+RuJpv0TS5r44FrvQB3u4ljrgbK0XNlXqprGxxTenoK2mrJPtReNcnx/ZeEqwOZwbwxotxwYd3RbjIv1LX4xMJF3olRupRlfsNmfbwWJlg6bI2H4qyVN8VRIrL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGQ4dUZocnZncW8xYVd2MjJJQmJkbUJLSXpucDNTaG9YVDRXU2JYa0pqVGRC?=
 =?utf-8?B?YkJVZzRocmMwN0o1Ly9wT056VVMwYjBDOG11dzg0VnlkaURMRmRWaExGUUcr?=
 =?utf-8?B?VU9STFNaMElYdDlHYkxCckE5TGh3TW9BOFlBWmxqbmNMSWVYdHEzQlAvRmZ6?=
 =?utf-8?B?WlZoWnZoMlpmM01SQ0ptY0FWa1JWUG5RMHNUMlNteFVnSUxTVGJtNWJHVGR6?=
 =?utf-8?B?Z3VxTzZWZnZsTGN1YXF5NytXbjcrRzA5UmxGVituSTdyMnE2MHp3L3pFSFdZ?=
 =?utf-8?B?SFhyYmVGRFh6WHRPbkkyNkkxY3FVRGM5RE1tM3BZdXlBL0NVVVAxeTJmU3ll?=
 =?utf-8?B?K2ZROXV1ZFJKNjlUbDY4Q3Y0UkVZWEIrK21EckxtWTBLRWVabVFuRUhQYWNQ?=
 =?utf-8?B?YVhHVHpYK3J1S25QbTZQb0Z0WEJVRHVEY0VkNndhRng1Y2VBR2VHYzExYkla?=
 =?utf-8?B?bnNObzdERzcxdDlXVGhEdTJOcEZXK2ttb2JZUHJRU3lIYXZXNmpYT2hFMGRs?=
 =?utf-8?B?WWczY3Z4NUhFNlBTV01jSmpMZDZKTUJiMS80UzgrOHB1VWJ0dDYxd1kwTCtl?=
 =?utf-8?B?eVh4bDYxM3BOdm9kTVJuSjMrN0tnVytRK2FsRU5IZG95ODVUMElGZThBN2hs?=
 =?utf-8?B?bEYwdStpbFZpd3dGVkpLblVvUVRJYzBhWmc1Wm4vdEJzdnRTdmFSVE1YWXpW?=
 =?utf-8?B?YW1oZGlpdDZVdk05NUtVOTlJWGNvbzNHWmhEbTdDZ0Nuc0d5NGpXTzNBWTY3?=
 =?utf-8?B?dGRqT0pYQ1RnbUFhMHZkZlAxVHRKZDdDeUtGemVDN2lJTDFobkVITFN3bktZ?=
 =?utf-8?B?cGpaWklEandoaFpoTDAwRW1vejQxSjdWTldveGt6MUs3b0RSZGU2N1RSNzk4?=
 =?utf-8?B?Z25LakN0S25FSWZ0dGcycnE5RmxHSGE5czB5TG9PYjBHbFo2Nm5yUEJNRmlw?=
 =?utf-8?B?OWhGUUJuRmpuUjdjWG4vc0YvQ3NLazl1Q1NmWTkzZVNRdlluZkMyeVBrYk9B?=
 =?utf-8?B?NzNuM0ZReTJyVHBYZDBRdm16UDBmcFZHMHBhaWJBSlNvVGcyc0Exb1hZRGNE?=
 =?utf-8?B?NW9tSDZvK2VUQ3F0WmNoQjlhSC9PSDVScUhSNndSajBKNVhFWFJIVG9KNFpP?=
 =?utf-8?B?cmQrNlZOaGxEV0VOTkhZT3cyZS83ZXpjYWFkdHg3UmNqK2tzNXplS1dmK3BR?=
 =?utf-8?B?R1QrcFNLY1M3SHNOc2J4LzhhMFBpbTBERHdFTW1RenFKVitoZlRoSUEvQlI5?=
 =?utf-8?B?SGVIT2dGSlM2ZEZNcTZKVXcyeTBqTEcxdFVQN0pwWGtRdHZNSUN2a1hGRXhO?=
 =?utf-8?B?dTVsdld6M2xnbjZSQ0E2b281ZVhRZDVpTkZSdG4vNjgybXU1OGtDS2xLZmM2?=
 =?utf-8?B?eWNORWQ2ZzduaDM2NEZPSkRVT2k5UFpDMlB2RFNKRncyWFljVG41UWp1eEtT?=
 =?utf-8?B?WWJpU2xMMmY5Q2h6eFBJZ0xJZHp3aDBRMDYzQzB0WHhsV2RHRDlnRkFNUkhR?=
 =?utf-8?B?U2ZwVlhBQXZHakFJaFYzZ0V2MFpISGRuQy84bDFLSFBWSVNJVlF3b28wQ1Zw?=
 =?utf-8?B?TGhEQmJZcmZWZUZuNHpnMnlTQnFTRG5GSDRkdUY4LzVGdmovV2pKbUs0VnRu?=
 =?utf-8?B?UjZ0ZmhzSDFOd0ozbDVjbDRscHBPa1cxbitwbEI0YmRzR1RQUEh6d0Zvcnl2?=
 =?utf-8?B?YjhRQngzdTdlTVZiMVlvMTV1V1FRbEdqK0JsajFSUkNlVGd3dkFtUzExZGVQ?=
 =?utf-8?B?Y0d5Z0hDSWU2c2prS1l0TFY1QXZqdmFxemVPbTl6ZXU4Z0tIWHJCUFB2VWlO?=
 =?utf-8?B?eUh4cGNFRmVMcVZDS2ZRZXNvU1FyQ0JoeVFiYVhmTXVKS2g4aHAyUFdiNnA5?=
 =?utf-8?B?N3Z2SFpnWURvZTJMY0xqdVdvVjdDN0RkSnlYRm4vcFBQLy9iSzFSbWxjaFg1?=
 =?utf-8?B?MkpsVisvMmxkRER4eDIybU9HRFdhSTIvSlpzSUQ3NVRrbHcwQ0JOY3JlWHpX?=
 =?utf-8?B?dC9mbjVidEVMck5yK1ZnMjFJaExJU0YxUlpPWVVBRGZEV29Ja0VBYjZvZm84?=
 =?utf-8?B?OVpzdDFESFJtczBWem5Gd2xKMkFVeVhnNGZEUXVZN2JuLzlXMVpsaTNpTzJ5?=
 =?utf-8?B?R0lmbVZnNjBCaGhDN013MTJxd2ZJQjhja3c0MlR0UUFRZnlyd3JCMVg2VDVM?=
 =?utf-8?B?cWNYQ1hPSHlGRmFzNjArdXBNRTA2L1FNWGdYTzR4UTJrTnRsTGxZYnhCWTNv?=
 =?utf-8?B?M2lrRmlIcWJlVHVPRk52ZzNUdW1vYmdjNjlFSXd5L0pRUGRtTXVBenZwckc4?=
 =?utf-8?B?SUx6VHZDR1VwV2oyMGlvTW1ENzZ1YnoxZG4yS0IzTTh1YldZcytvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LqSpvQ2GTTDEgsUVDvW6CaKUUWFCpr/Q/EycLxkfkiO4BRjtFbdbGNUjtJMyVjpr+GCvVm6AGXhvBsoI6S89/uWiVD6akwiWJXg7pRgBjBlRTxuZd/E6I3wPQv3Ldi7PsfXLBVsKYvryUQDOTOjzt21QejTT/cS9/U+uwJ/ShIgFO8RPfTpk350ZrIwJzhdPu112abRgbi0IUEyE5GF7PT/hdstZ+Ihmb8A+8xnXhk4h4g7cYgLWsq8nb8fnmP/x5JyXh343cnwqXttsGnHvu3Y15bkpZf2g36s1cAweWNCS+/tav1F2R4wXp/W3Pmgwoe6rXco+9RP//V+/XZrnIg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc492614-e8d6-424d-4304-08de93c8c528
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 10:39:24.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzMrRN6/ZW/RyO9epUcccas0te6sWxZvDCQ5DZVxYg9gESrp7wwlNaufgtierPFiKeYs8MoHM4sd1CjXIaW5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5229
X-Proofpoint-ORIG-GUID: d02DJ8zmYIbspfmx3MhxcocTCw13FNlW
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=69d38d5f cx=c_pps
 a=WMD2V7/OXcB8V+UEbxscyA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=IpJZQVW2AAAA:8 a=_Yzk77Yv_yBfv9nWwcwA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEwNCBTYWx0ZWRfX0urfLgU3aTY+
 tyakBg1UCpsk7tWXkgZfe0ozpZJqF8TsKMLOWf7V3Vy0SgdclwhkGZeFpUDeZJxFzZSEK9vOQ+C
 evi9t/QaVFbZwIft0mkVLPKa8bQqngRkHMbkptzE8k1F4cuCjEfEnZJ3F15Px5oKR0aHdouRkud
 Qdq8GaMqCRU8EIQsdq4r1KL64QZP0ok+WGXCHkdB3L++zcxig77Mase/ye/Y6EkDcBf9LO7R6vg
 RfJqCJ6YYXZ75+5JE7sKhDAZ93+Sa9iOocqQx8iBCuc5mucYygR/B/GUVzZ7ix/MLNNqTnu6ktT
 mAMzjjQj1iFObNYLobzTu9976nibW6Iv7hgmQNNOAD0Y69pigjzRz4+m32LGTXj1pBl0S8BmFsy
 zK6aWe+ZVgSbArMr3fsnvPqolgTuEVdXMzfj2qxnioTnxDbepEQRSexPALm29yy2cWccy53941Z
 rkRc3/zNDzo5zcYvvuw==
X-Proofpoint-GUID: d02DJ8zmYIbspfmx3MhxcocTCw13FNlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060104
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8485-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email,analog.com:dkim,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 359953A2E15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA0LCAyMDI2IDY6NTcg
UE0NCg0KLi4uDQoNCj4gPiArDQo+ID4gICNkZWZpbmUgQUQ0NjkxX0NIQU5ORUwoY2gpDQo+IAlc
DQo+ID4gIAl7CQkJCQkJCQlcDQo+ID4gIAkJLnR5cGUgPSBJSU9fVk9MVEFHRSwJCQkJCVwNCj4g
PiBAQCAtMTIyLDExICsxNTUsOSBAQCBzdHJ1Y3QgYWQ0NjkxX2NoaXBfaW5mbyB7DQo+ID4gIAkJ
LmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0gQklUKElJT19DSEFOX0lORk9fU0NBTEUpLA0KPiAJ
XA0KPiA+ICAJCS5jaGFubmVsID0gY2gsCQkJCQkJXA0KPiA+ICAJCS5zY2FuX2luZGV4ID0gY2gs
CQkJCQlcDQo+ID4gLQkJLnNjYW5fdHlwZSA9IHsJCQkJCQlcDQo+ID4gLQkJCS5zaWduID0gJ3Un
LAkJCQkJXA0KPiA+IC0JCQkucmVhbGJpdHMgPSAxNiwJCQkJCVwNCj4gPiAtCQkJLnN0b3JhZ2Vi
aXRzID0gMTYsCQkJCVwNCj4gPiAtCQl9LAkJCQkJCQlcDQo+ID4gKwkJLmhhc19leHRfc2Nhbl90
eXBlID0gMSwNCj4gCVwNCj4gPiArCQkuZXh0X3NjYW5fdHlwZSA9IGFkNDY5MV9zY2FuX3R5cGVz
LAkJCVwNCj4gPiArCQkubnVtX2V4dF9zY2FuX3R5cGUgPSBBUlJBWV9TSVpFKGFkNDY5MV9zY2Fu
X3R5cGVzKSwNCj4gCVwNCj4gDQo+IFVzdWFsbHksIHdlIGp1c3QgbWFrZSB0d28gc2VwYXJ0ZSBh
ZDQ2OTFfY2hpcF9pbmZvIHN0cnVjdHMgZm9yIG9mZmxvYWQNCj4gdnMuIG5vdCBvZmZsb2FkLg0K
PiANCj4gZXh0X3NjYW5fdHlwZSBpcyBnZW5lcmFsbHkgb25seSB1c2VkIHdoZW4gdGhlIHNjYW4g
dHlwZSBjYW4gY2hhbmdlDQo+IGR5bmFtaWNhbGx5IGFmdGVyIHByb2JlLg0KPiANCg0KU28sIGp1
c3QgdG8gYmUgY2xlYXIsIHlvdSBhcmUgc2F5aW5nIEkgc2hvdWxkIGhhdmUgZGlmZmVyZW50IGNo
aXBfaW5mbyBzdHJ1Y3RzDQphbmQgY2hhbmdlIHRoZSB0cmlnZ2VyZWQtYnVmZmVyIGZvciBvZmZs
b2FkIG9uZXMgaWYgb2ZmbG9hZCBpcyBwcmVzZW50Pw0KSSBhbSBhc2tpbmcgc2luY2Ugb2ZmbG9h
ZCBoYXMgZGlmZmVyZW50IHNjYW4gdHlwZXMgYXMgd2VsbCwgYW5kIHRoaXMgd291bGQNCm1lYW4g
MyBkaWZmZXJlbnQgY2hpcF9pbmZvIHN0cnVjdHMgZm9yIGVhY2ggY2hpcCAtPiB0b3RhbCBvZiAx
MiBjaGlwX2luZm8gc3RydWN0cywNCmVhY2ggd2l0aCBhIGRpZmZlcmVudCBjaGFubmVsIGFycmF5
LCBvciBwZXJoYXBzIHRoZXJlIGlzIGEgbW9yZSBjb21wYWN0IHdheQ0KdG8gaGF2ZSB0aGlzIGlt
cGxlbWVudGVkLg0KSSBjb3VsZCBtYWtlIHRoZSBjaGFubmVsIGFycmF5cyB1c2UgdGhlIHNhbWUg
bWFjcm8gYW5kIGhhdmUgdGhlIHNjYW5fdHlwZQ0KcmV2ZXJzZWQgdG8gc3RvcmFnZSBhbmQgc2hp
ZnQgZG9uZSBhcyBwYXJhbWV0ZXJzLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0
cyBvbiB0aGlzLg0KDQo+ID4gIAl9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIGFkNDY5MV9jaGFubmVsc1tdID0gew0KPiA+IEBAIC0yMjEsNiArMjUyLDE3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWQ0NjkxX2NoaXBfaW5mbw0KPiBhZDQ2OTRfY2hpcF9pbmZv
ID0gew0KPiA+ICAJLm1heF9yYXRlID0gMSAqIEhaX1BFUl9NSFosDQo+ID4gIH07DQo+ID4NCg0K
Li4uDQoNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTg4Myw2ICsxMTg0LDIwIEBAIHN0YXRpYyBzc2l6
ZV90IHNhbXBsaW5nX2ZyZXF1ZW5jeV9zdG9yZShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+ID4g
IAlpZiAoaWlvX2J1ZmZlcl9lbmFibGVkKGluZGlvX2RldikpDQo+ID4gIAkJcmV0dXJuIC1FQlVT
WTsNCj4gPg0KPiA+ICsJaWYgKHN0LT5tYW51YWxfbW9kZSAmJiBzdC0+b2ZmbG9hZCkgew0KPiA+
ICsJCXN0cnVjdCBzcGlfb2ZmbG9hZF90cmlnZ2VyX2NvbmZpZyBjb25maWcgPSB7DQo+ID4gKwkJ
CS50eXBlID0gU1BJX09GRkxPQURfVFJJR0dFUl9QRVJJT0RJQywNCj4gPiArCQkJLnBlcmlvZGlj
ID0geyAuZnJlcXVlbmN5X2h6ID0gZnJlcSB9LA0KPiA+ICsJCX07DQo+IA0KPiBTYW1lIGNvbW1l
bnQgYXMgb3RoZXIgcGF0Y2hlcy4gVGhpcyBuZWVkcyB0byBhY2NvdW50IGZvciBvdmVyc2FtcGxp
bmcNCj4gcmF0aW8uDQo+IA0KDQpJIGFtIHRoaW5raW5nIHRoYXQgc2luY2Ugd2Ugd291bGQgaGF2
ZSBkaWZmZXJlbnQgY2hpcF9pbmZvIHN0cnVjdHMsIG1hbnVhbA0KbW9kZSBjaGFubmVscyBjb3Vs
ZCBvbWl0IHRoZSBvdmVyc2FtcGxpbmcgYXR0cmlidXRlLCBzaW5jZSBpdCBpcyBub3Qgc3VwcG9y
dGVkDQpieSB0aGUgY2hpcCBvbiB0aGlzIG1vZGUuDQoNCj4gPiArDQo+ID4gKwkJcmV0ID0gc3Bp
X29mZmxvYWRfdHJpZ2dlcl92YWxpZGF0ZShzdC0+b2ZmbG9hZC0+dHJpZ2dlciwNCj4gJmNvbmZp
Zyk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJ
c3QtPm9mZmxvYWQtPnRyaWdnZXJfaHogPSBjb25maWcucGVyaW9kaWMuZnJlcXVlbmN5X2h6Ow0K
PiA+ICsJCXJldHVybiBsZW47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0ID0gYWQ0NjkxX3Nl
dF9wd21fZnJlcShzdCwgZnJlcSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7
DQo+ID4gQEAgLTk2OCwxMCArMTI4MywyMyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWQ0NjkxX3Ry
aWdnZXJfaGFuZGxlcihpbnQNCj4gaXJxLCB2b2lkICpwKQ0KPiA+ICAJcmV0dXJuIElSUV9IQU5E
TEVEOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBhZDQ2OTFfZ2V0X2N1cnJlbnRfc2Nh
bl90eXBlKGNvbnN0IHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKwkJCQkJIGNvbnN0
IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWQ0Njkx
X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+ICsJaWYgKCFzdC0+
b2ZmbG9hZCkNCj4gPiArCQlyZXR1cm4gQUQ0NjkxX1NDQU5fVFlQRV9OT1JNQUw7DQo+ID4gKwlp
ZiAoc3QtPm1hbnVhbF9tb2RlKQ0KPiA+ICsJCXJldHVybiBBRDQ2OTFfU0NBTl9UWVBFX09GRkxP
QURfTUFOVUFMOw0KPiA+ICsJcmV0dXJuIEFENDY5MV9TQ0FOX1RZUEVfT0ZGTE9BRF9DTlY7DQo+
ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gYWQ0NjkxX2lu
Zm8gPSB7DQo+ID4gIAkucmVhZF9yYXcgPSAmYWQ0NjkxX3JlYWRfcmF3LA0KPiA+ICAJLndyaXRl
X3JhdyA9ICZhZDQ2OTFfd3JpdGVfcmF3LA0KPiA+ICAJLnJlYWRfYXZhaWwgPSAmYWQ0NjkxX3Jl
YWRfYXZhaWwsDQo+ID4gKwkuZ2V0X2N1cnJlbnRfc2Nhbl90eXBlID0gJmFkNDY5MV9nZXRfY3Vy
cmVudF9zY2FuX3R5cGUsDQo+ID4gIAkuZGVidWdmc19yZWdfYWNjZXNzID0gJmFkNDY5MV9yZWdf
YWNjZXNzLA0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTExOTUsOSArMTUyMyw3NSBAQCBzdGF0aWMg
aW50IGFkNDY5MV9zZXR1cF90cmlnZ2VyZWRfYnVmZmVyKHN0cnVjdA0KPiBpaW9fZGV2ICppbmRp
b19kZXYsDQo+ID4NCj4gJmFkNDY5MV9tYW51YWxfYnVmZmVyX3NldHVwX29wcyk7DQo+ID4gIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgaW50IGFkNDY5MV9zZXR1cF9vZmZsb2FkKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYsDQo+ID4gKwkJCQlzdHJ1Y3QgYWQ0NjkxX3N0YXRlICpzdCwNCj4gPiArCQkJ
CXN0cnVjdCBzcGlfb2ZmbG9hZCAqc3BpX29mZmxvYWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9IHJlZ21hcF9nZXRfZGV2aWNlKHN0LT5yZWdtYXApOw0KPiA+ICsJc3RydWN0
IGFkNDY5MV9vZmZsb2FkX3N0YXRlICpvZmZsb2FkOw0KPiA+ICsJc3RydWN0IGRtYV9jaGFuICpy
eF9kbWE7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCW9mZmxvYWQgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKm9mZmxvYWQpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghb2ZmbG9h
ZCkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlvZmZsb2FkLT5zcGkgPSBz
cGlfb2ZmbG9hZDsNCj4gPiArCXN0LT5vZmZsb2FkID0gb2ZmbG9hZDsNCj4gPiArDQo+ID4gKwlp
ZiAoc3QtPm1hbnVhbF9tb2RlKSB7DQo+ID4gKwkJb2ZmbG9hZC0+dHJpZ2dlciA9DQo+ID4gKwkJ
CWRldm1fc3BpX29mZmxvYWRfdHJpZ2dlcl9nZXQoZGV2LCBvZmZsb2FkLT5zcGksDQo+ID4gKw0K
PiBTUElfT0ZGTE9BRF9UUklHR0VSX1BFUklPRElDKTsNCj4gPiArCQlpZiAoSVNfRVJSKG9mZmxv
YWQtPnRyaWdnZXIpKQ0KPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIo
b2ZmbG9hZC0+dHJpZ2dlciksDQo+ID4gKwkJCQkJICAgICAiRmFpbGVkIHRvIGdldCBwZXJpb2Rp
YyBvZmZsb2FkDQo+IHRyaWdnZXJcbiIpOw0KPiA+ICsNCj4gPiArCQlvZmZsb2FkLT50cmlnZ2Vy
X2h6ID0gc3QtPmluZm8tPm1heF9yYXRlOw0KPiANCj4gSSB0aGluayBJIG1lbnRpb25lZCB0aGlz
IGVsc2V3aGVyZSwgYnV0IGNhbiB3ZSByZWFsbHkgZ2V0IG1heF9yYXRlIGluIG1hbnVhbA0KPiBt
b2RlDQo+IGR1ZSB0byB0aGUgZXh0cmEgU1BJIG92ZXJoZWFkPyBQcm9iYWJseSBzYWZlciB0byBz
dGFydCB3aXRoIGEgbG93ZXIgcmF0ZS4NCg0KWW91IGFyZSByaWdodCBhIHNsb3dlciByYXRlIHdv
dWxkIGJlIG5pY2VyLCBmcm9tIG15IHRlc3RzIDMxMWtIeiB3b3JrZWQgcGVyZmVjdA0Kd2l0aCBh
IDEwTUh6IFNQSSBmcmVxdWVuY3ksIGJ1dCBwZXJoYXBzIHRoZXNlIG51bWJlcnMgYXJlIGEgYml0
ICJvZGQiLg0KDQpIb3cgZG8geW91IGZlZWwgYWJvdXQgMTAwa0h6IGZvciBhIHN0YXJ0aW5nIHNh
bXBsZSByYXRlPw0KDQo+IA0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlzdHJ1Y3Qgc3BpX29mZmxv
YWRfdHJpZ2dlcl9pbmZvIHRyaWdnZXJfaW5mbyA9IHsNCj4gPiArCQkJLmZ3bm9kZSA9IGRldl9m
d25vZGUoZGV2KSwNCj4gPiArCQkJLm9wcyAgICA9ICZhZDQ2OTFfb2ZmbG9hZF90cmlnZ2VyX29w
cywNCj4gPiArCQkJLnByaXYgICA9IHN0LA0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXJldCA9
IGRldm1fc3BpX29mZmxvYWRfdHJpZ2dlcl9yZWdpc3RlcihkZXYsICZ0cmlnZ2VyX2luZm8pOw0K
PiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0K
PiA+ICsJCQkJCSAgICAgIkZhaWxlZCB0byByZWdpc3RlciBvZmZsb2FkDQo+IHRyaWdnZXJcbiIp
Ow0KPiA+ICsNCj4gPiArCQlvZmZsb2FkLT50cmlnZ2VyID0NCj4gPiArCQkJZGV2bV9zcGlfb2Zm
bG9hZF90cmlnZ2VyX2dldChkZXYsIG9mZmxvYWQtPnNwaSwNCj4gPiArDQo+IFNQSV9PRkZMT0FE
X1RSSUdHRVJfREFUQV9SRUFEWSk7DQo+ID4gKwkJaWYgKElTX0VSUihvZmZsb2FkLT50cmlnZ2Vy
KSkNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG9mZmxvYWQtPnRy
aWdnZXIpLA0KPiA+ICsJCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgREFUQV9SRUFEWSBvZmZsb2Fk
DQo+IHRyaWdnZXJcbiIpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJ4X2RtYSA9IGRldm1fc3Bp
X29mZmxvYWRfcnhfc3RyZWFtX3JlcXVlc3RfZG1hX2NoYW4oZGV2LA0KPiBvZmZsb2FkLT5zcGkp
Ow0KPiA+ICsJaWYgKElTX0VSUihyeF9kbWEpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihyeF9kbWEpLA0KPiA+ICsJCQkJICAgICAiRmFpbGVkIHRvIGdldCBvZmZs
b2FkIFJYIERNQSBjaGFubmVsXG4iKTsNCj4gPiArDQo+ID4gKwlpZiAoc3QtPm1hbnVhbF9tb2Rl
KQ0KPiA+ICsJCWluZGlvX2Rldi0+c2V0dXBfb3BzID0NCj4gJmFkNDY5MV9tYW51YWxfb2ZmbG9h
ZF9idWZmZXJfc2V0dXBfb3BzOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWluZGlvX2Rldi0+c2V0dXBf
b3BzID0NCj4gJmFkNDY5MV9jbnZfYnVyc3Rfb2ZmbG9hZF9idWZmZXJfc2V0dXBfb3BzOw0KPiA+
ICsNCj4gPiArCXJldCA9IGRldm1faWlvX2RtYWVuZ2luZV9idWZmZXJfc2V0dXBfd2l0aF9oYW5k
bGUoZGV2LCBpbmRpb19kZXYsDQo+IHJ4X2RtYSwNCj4gPiArDQo+IElJT19CVUZGRVJfRElSRUNU
SU9OX0lOKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
KwlpbmRpb19kZXYtPmJ1ZmZlci0+YXR0cnMgPSBhZDQ2OTFfYnVmZmVyX2F0dHJzOw0KPiANCj4g
U2hvdWxkIGluY2x1ZGluZyBhZDQ2OTFfYnVmZmVyX2F0dHJzIGRlcGVuZCBvbiBzdC0+bWFudWFs
X21vZGU/DQo+IA0KPiBJIHRob3VnaHQgaXQgd2FzIG9ubHkgdXNlZCB3aGVuIFBXTSBpcyBjb25u
ZWN0ZWQgdG8gQ05WLg0KPiANCg0KRm9yIG9mZmxvYWQgbWFudWFsIG1vZGUsIEkgdGhvdWdodCBi
dWZmZXIgc2FtcGxpbmcgZnJlcXVlbmN5IHNob3VsZCBhbHNvIGJlIGF2YWlsYWJsZSwNCnNpbmNl
IHRoZSBvZmZsb2FkIHRyaWdnZXIncyBmcmVxdWVuY3kgaXMgYWNjZXNzaWJsZS4NCg0KPiA+ICsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGFkNDY5MV9w
cm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmc3BpLT5kZXY7DQo+ID4gKwlzdHJ1Y3Qgc3BpX29mZmxvYWQgKnNwaV9vZmZsb2Fk
Ow0KPiA+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gPiAgCXN0cnVjdCBhZDQ2OTFf
c3RhdGUgKnN0Ow0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMTIzMiw2ICsxNjI2LDEzIEBAIHN0
YXRpYyBpbnQgYWQ0NjkxX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gIAlpZiAo
cmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiArCXNwaV9vZmZsb2FkID0gZGV2bV9z
cGlfb2ZmbG9hZF9nZXQoZGV2LCBzcGksDQo+ICZhZDQ2OTFfb2ZmbG9hZF9jb25maWcpOw0KPiA+
ICsJcmV0ID0gUFRSX0VSUl9PUl9aRVJPKHNwaV9vZmZsb2FkKTsNCj4gPiArCWlmIChyZXQgPT0g
LUVOT0RFVikNCj4gPiArCQlzcGlfb2ZmbG9hZCA9IE5VTEw7DQo+ID4gKwllbHNlIGlmIChyZXQp
DQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gZ2V0IFNQ
SSBvZmZsb2FkXG4iKTsNCj4gPiArDQo+ID4gIAlpbmRpb19kZXYtPm5hbWUgPSBzdC0+aW5mby0+
bmFtZTsNCj4gPiAgCWluZGlvX2Rldi0+aW5mbyA9ICZhZDQ2OTFfaW5mbzsNCj4gPiAgCWluZGlv
X2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPiBAQCAtMTIzOSw3ICsxNjQwLDEw
IEBAIHN0YXRpYyBpbnQgYWQ0NjkxX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4g
IAlpbmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmluZm8tPmNoYW5uZWxzOw0KPiA+ICAJaW5kaW9f
ZGV2LT5udW1fY2hhbm5lbHMgPSBzdC0+aW5mby0+bnVtX2NoYW5uZWxzOw0KPiANCj4gQXMgbWVu
dGlvbmVkIGVhcmxpZXIsIHdlIGdlbmVyYWxseSB3YW50IHNlcGFyYXRlIGNoYW5uZWwgc3RydWN0
cw0KPiBmb3IgU1BJIG9mZmxvYWQuIFRoZXNlIHdpbGwgYWxzbyBoYXZlIGRpZmZlcmVudCBudW1f
Y2hhbm5lbHMgYmVjYXVzZQ0KPiB0aGVyZSBpcyBubyB0aW1lc3RhbXAgY2hhbm5lbCBpbiBTUEkg
b2ZmbG9hZC4NCg0KSWYgZGlmZmVyZW50IGNoaXBfaW5mbyBzdHJ1Y3RzIHdpbGwgYmUgdXNlZCwg
d291bGRuJ3QgdGhleSBhbHJlYWR5IGhhdmUgc3BlY2lmaWMNCmNoYW5uZWxzIGF0dGFjaGVkIHRv
IHRoZW0/DQoNCg==

