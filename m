Return-Path: <linux-pwm+bounces-8493-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oESlJe/B02kalgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8493-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 16:23:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE43A3F4B
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52AA03012F5D
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2AD382F2D;
	Mon,  6 Apr 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fyVrT3j0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA4381B0A;
	Mon,  6 Apr 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485257; cv=fail; b=PNMGXlZXl/6W311Nx5OKy31KbEqK+ylrmJ0fHVdMPd1v4vDyTvxait7kmiz9RrUNe6wst4RNXVeFbP/EEqP7D6lUl1JLTAckfjTej9Zr0+Wj7CxYnEJ8uZ6X7kV67+U0DXxZGFi7Y9mkF1nxYKT/bJisqnsYcEnSWk5HGSbCMyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485257; c=relaxed/simple;
	bh=kIGvrhUTesAveC61LlC5yqunsQBl1oSlkT1NZH0yL+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo/em4BHNS/Op3WKK8YxGGV5N40BEy5sFUN769ksr8Gg1T6wPrFA3thbL8OnnhCU5vkoHiNxWJOba/aNGKSdA2GC4jb5EBecgKu5Rn/jGaBNWqf1evRNP5AwSS+XvE4pBSUFzn1BPPBTDUHIuqEQEo2fCWBzLBArUGR3Dy2i4aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fyVrT3j0; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636DFgT91037505;
	Mon, 6 Apr 2026 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kIGvr
	hUTesAveC61LlC5yqunsQBl1oSlkT1NZH0yL+I=; b=fyVrT3j0z5fMR6lxAju3D
	qdB3lpfPQ2XiqrwvYTNeoz2fRccgQS7fviOViNXbk956osms0y6nhht4kktcX0BQ
	22prL38SaQK03cccdWru0apxsK+bm1CjLMxKt/XAqE9FDhmZkb1hh5IE4LDjrPkq
	f/coyfcpiNUsNsEuEwiYQcf8aho08KZFZeHr4qQQyLhnf3h9aWpmK5WqPwodh372
	CxQPhUXmXQmb8ssCDMZwmTT1/zJgSd2Lqknfd/p0nocDZzaOkQT3B0PdripNye5V
	sQiBYrgiJ1VIuqJZ1HA3pEwwu0kUh1vIUaJxVKJId+3gmZQ8sgfaZ9qapH/T8uTa
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dc13gwb1b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 10:20:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3ja5y7MkAVyJcJtocUG53QcUcEbPVaUMhjmowJRedYPUcn4FIlv6V7LngyaMNB1wBIJ5qKgqp0FOlb7aMu4qyNPY4yEMV0CidFwPeJfC+aArOPapevx8WGNEULPXw79qfGfH20zpg21nWJpC2wbkNGZPWQXxY5Fj6jUarQ6Mx1I/tsUqczC5DtDddMVZbK/qTQjWxX6bMWS2FEqUPi4xUdz4GhR3MWlJckIdJQVBF1GKUK/XKsu47RfMN9snSXuqwJ5xOIasUBTCoUzd5P+cbYUplKpcN01rX86Qo0ApNYZ4TKy0V3QxUYQaxZYDHkZVNPGinQfqsL9PpiTGyzNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIGvrhUTesAveC61LlC5yqunsQBl1oSlkT1NZH0yL+I=;
 b=TBnrXstWf9gVvipw0ozMOEK5yBU/mZR+eKcrZ4ZidpEt+qDDneRb9TEz0dbfnu0dbwBHVolH3VgAWK1O2IUPhKSGwl4m45Gedu4YUKZDrY/UtbXq/0jA1Qrh47BiLZE0cxzQamRU1iIPniY5pxgSL2I8b6/uXvrIX4Hl3i0YTmkextV7CqKTFVCYwIxtLL/sNOhnWx6Na+VrWN+DL8f3bjn4OnfHYFd+yNM7OKqGj6GI2oN57cOyb4Ixv9737KAJotpibb6Db10S7mmrOG6XQbImKAslUcT5y/5Zri+Eh3VHO/RimHkuO/TQp/N1LPi2+h7+KJeCyrwZYRHqSdtOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB7026.namprd03.prod.outlook.com (2603:10b6:a03:4e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 14:20:31 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 14:20:31 +0000
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
Thread-Index:
 AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPELuAgAK5+HCAABcC4IAAIQJAgAAQ8wCAAAXa8A==
Date: Mon, 6 Apr 2026 14:20:31 +0000
Message-ID:
 <LV9PR03MB8414A8775346A72826D4C9CFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <LV9PR03MB8414C570998C4C1EE59ABFBBF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <LV9PR03MB8414BB41577A8B5A0432463FF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <83971700-ea17-4fd5-8985-68c798222800@baylibre.com>
In-Reply-To: <83971700-ea17-4fd5-8985-68c798222800@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB7026:EE_
x-ms-office365-filtering-correlation-id: a51becd4-4574-4443-1a3b-08de93e7a8c1
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 RQYH6jGKZgcdd/++be1jDSqAs0rvsCjF5kSWhsNy8RjWBS9ZTdpezanPHeZYzWfRfz6ByAUCwOBGK+J0Akd5fJgiAz+Go7HFMZPxHWQ9wJMtkgJS0EoGEbZ6JO38iCvEacsBM8vHp5n7zNzmjTDeAt9A2+dvIthXyKahcNejtBYOel3GTgs5AGWKbA8h6KF3jLYZFQHXj02uwLaGfytkLh45ZMc9BsUxOQDspCZZnB8sNws60kqBs5O9d+O5ws1UfZDVOOeMaw703yXm0D0wrRkRjcCvUlUPNRizCLocOeMmh7aGjUugesUIXK/mx5VE9E1VauMwDiIf/+/xxcBnylJDmlixydxKraA6M6gJZxA5TK8HzDx/O3OcPWSI8SwUVixIMeJ5vX2p/NgdBjZ0GkYdZLTPwfPAVG9EkH8vvqtW8ZQ2UuobwseS17pg+HD0ViX+OOlBHujgj29ItqSaJEM+b7BiJNw5MwbmBWRpPpFCJ3Vp3FEZAo/IPtDaocFBtfOVGhWm/63v0/vobUlkdJAS/1MEr/Ef6pk3MAD73aMoYjd6eQq3Qq8QyrHeiq4ek5x9A6o+MDBZANkxvu3ovTU22VikUOZS0q2G9PCW1GvZtVuyzVi6UZmsYuuKmATP0pG/tsRPpm8IrMqsskwk777Ua8o3ba92ZsJJdrE7lhejs3WhVjuRxpPpNrKVHbdhkhRiqJ0PUJrJRFZekOemrj6gUT6JWqwv6dINsJ0BtsXs9E8sEb64IO5VAkmKFp9LujBmrhTjLGNGqJfphFsn9sXUev45tVBFkV0o9M00wOQFxl2ftDpWGeNyC+FQ/21N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2hFdjNST1FSdDBWOGRIYlpjUjBEQnB2WlZLQy9tc0FtVWkyTlgyaURQVjlB?=
 =?utf-8?B?aFdlNmFTQVJlN3IyUTNLWHVZTFQ2bk1qaWtJSGNpSDFhaVJqalFkU1F3c2VI?=
 =?utf-8?B?ckJzN1FDZHlZOHlnNzhtRlZBa3BLMVJRR3NLOXJENHgyYzhXR2lpdUhuV2Vk?=
 =?utf-8?B?bG13NW03N2ZZYVk3eDY0eUVQUHpLcUh6WjZ6aGxud2dhVVFkalh6Z1h6dUpq?=
 =?utf-8?B?dWdiZDVpa0V5elNWYnJ2c0FnSzBNRHBuWUo3RUtHbVZpQzJoNGVMQWQ0TVV3?=
 =?utf-8?B?QjVTaCtVS2R5NDkxcUlpL3dmWjdHSWV6TjZiTGJ1Y0ZyWlVCRnhheGxGcG8y?=
 =?utf-8?B?UnY3eDRmK0hGZ05hRDkvaUpLSVI5RFk3eDZxUG00UWJxVUpjaklPNG1jWXZM?=
 =?utf-8?B?K0s5c1lzYjkydkxCdHRSbWQyRnBQc2N3WUNCNGdMQmlqZFhsQVBmSG5BY3RS?=
 =?utf-8?B?aVlRTlFwcTJmdnRmR1IyeDhIUlBzYnIwdHp1NUlQRjcyWklCSjZ2bWhmK3ZE?=
 =?utf-8?B?MHRDSm1HcnBBY0R5TUowbW02TGIxd0lIZ243eGx1bXVyb04zclJaNGlud2V6?=
 =?utf-8?B?SnI0L0p6cm1lQTJLOXJyVDZmNm4yUXlVY1ZDODRWTmpybE0zdVVUSGJsRXRK?=
 =?utf-8?B?WGNOY2x1Y0dJNEZGazgyUkd6akJlZU0wekZuaTBtcnhmdmpQTmpDU0VZYVUz?=
 =?utf-8?B?Yit0KytnYkdoL2hTZDRVRkZDSnQ4V20yenUyZ1lYU3JGZWpIenNQYUtya3hV?=
 =?utf-8?B?UmhzbzJUTXpuckNkT1VJUkVjNEdLeXBkbisrNXNOdUxJcTFRRXFxWHJpSHB4?=
 =?utf-8?B?S0E0ZmR0NGhsRzFxUlprM2FNUGdiQnpsbzRVQ0t3a2pQa0FCNFZnWnBBZzdn?=
 =?utf-8?B?bDJyTjlMeE9MbDVFaWRyZnY3ZEYrcUVMaWlOVTlCZWxwQkU1NnE3YkFIT3FV?=
 =?utf-8?B?Nm05OHhEMTA1Yy9sYlNpbERsQnRWZ0VGeHMrWGZ4Z01CbnhkRjNwQksydGZ5?=
 =?utf-8?B?MUs4QXg2TmpVSERLcUY4b2VZTXRFMWNYNTRzTDduUWN5Y0xLZE5aWkFvYkZT?=
 =?utf-8?B?Y2JpWjY2akkrMW9mTVYrZXBYK0YzaE0wSWI4ekJ3UUdRREIxWmR4b21WT3Z1?=
 =?utf-8?B?Ums5a2w0V1grakxKTU9rOXBYbVJFNWFPRFJzbWtXc2wvck1YZ0hjR0xSVmlD?=
 =?utf-8?B?YkZLUUxvVGhmcy83M3dBR2VzOFVIM2JFMW5YalZxU0MxbTMzN3grbm8yY2oz?=
 =?utf-8?B?eHpFL2VBSFh5bEFVSmFpcldXekJHb2NTQlk1Y1pUa0J3VFJIaEhrdnNyVzBy?=
 =?utf-8?B?UDY1MmFSM2IzSGlyb3VYWHNqNFNrZ2NiMnBranA1c2dhMTVpODBERlFBa2E3?=
 =?utf-8?B?eHhybjd1aE5FdzlJbTNpZlVwc05IZll6N3pka1B3Z2NMNnRyZDFOSnl6RFJl?=
 =?utf-8?B?OGY4Z0h2RHlFSkRoaEg2SmJHckp0dlhkS1NBdWdWUU9ZSlAxZ2hzTDA5QVo3?=
 =?utf-8?B?VG40bjhvWUVMNkxwQkd2QU5WVEE2VTF6dCtpTDAyOGpaRHFFYUtpMVNiY3BH?=
 =?utf-8?B?VGZOWkxrSXJmVnRnTmhqMUc5RUI5d1d2ZU4wdS9panJYU2ozZ0hacDY3b3FS?=
 =?utf-8?B?SmlNYU0vL0pwUThiMFJlTitYRU1MVC8ySWhMM2tNZFk1QTJSVGd6QmkreEMx?=
 =?utf-8?B?UUdETXR5dmh1c1Y5aWxsaThJdjhDRUQ4U2pIeTdPbEhSL0hHTVNiRnNsL3Qy?=
 =?utf-8?B?Yk1DYVBLUEE2SkZ0bVpWUmU3V3NxczIvazIvK1Ntc054RytLYzhWdU5CNmxL?=
 =?utf-8?B?bWtVbE16d3dUT3hrWWp4b211cS84Zi8rZ1RtYmVvRG9FR2x2TXRZM1FXVUJN?=
 =?utf-8?B?dmpQNEFzOFlmcTFKZ1Y0VGkwNmNzSTAzVUhTSWpjdklLS0RSS3plQjFFeFlr?=
 =?utf-8?B?N0FCU0lCbzdqL0FGdG56aUF3Sy9RYzYrRXVKRHVtTWIwUkZHb2pzUGd1ejAx?=
 =?utf-8?B?MlZyaE1vaXg4ODRBTzExRFZ4RUZFZ2VLYk1ENXNJS0xRYmJWVVRMRVdWM2p2?=
 =?utf-8?B?aGk5dEZDSVN2Q1dVWGRzMDhmNnh2OExEWUdkdWYwZzJUdlp6U1BYUEhUUStk?=
 =?utf-8?B?eTByMWN6bFoySDRrRElQMXVnS0ZGdm1hY0hkb1NXdE1EL1ZsSVpyZ242TXBo?=
 =?utf-8?B?M2RTWVZYM1F6alhpSGdFK3dUdGJVVkdUN0M5UkZFaytSYXRSLzJTYTBJMVpN?=
 =?utf-8?B?d2Y0aEF4NXNYUkZkajNpMlJnUEZ6Y2hPQS9vR21ZZGQvMDQvNlQrbzJHekpT?=
 =?utf-8?B?OUR5bXp2WFI4STg3Sjd2TDAvZ3hMazNxYTRGL3lKWUVQNDFnNklSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ev7/b2fGc/tA/Z51c4QKm8KnFvmwP0ZKIMUVflAsQ2R4B6hB4wSiE2MAT0JZYGHFODAn9x+vS/6VU7JVwsHXoYPeM1QnIif4NO2oiVj3n/Uwq/XbOpRpucyYtXn/0ZeQt9FSGNh8gtHaXV+24rSoUAalQyE/0QcwgA5KxpGaX5Cbt4UJ3E9MoA5IQKDESH/m+bZbwM5wM7nZNEtG14jrafdP8mRnnclGPRIwOTuyHpqpRO4QNwqpIJMilcUZ+plJ4nhld0ZgjCBahFtZ3ol9iiBOjRAe5KhNH3RakYypLNVQTpHKrVoukFcJhDp6+FPefD28KFK22uCTZM55PHbBFQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51becd4-4574-4443-1a3b-08de93e7a8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 14:20:31.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBoVCMJkgC4aXLcNKJEU4rGGThO2r8aakz00EyQbCZ0xQgrNoHdoUfWRkhTxHYRAoO1TpfpCDIOqXjLEMPru/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7026
X-Authority-Analysis: v=2.4 cv=Af+83nXG c=1 sm=1 tr=0 ts=69d3c134 cx=c_pps
 a=jCxDXDPT0EaKR6BOOOS6sQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8 a=EBLspJBUUlJ_NnQwIVMA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE0MSBTYWx0ZWRfX8sM0SVRgx1vI
 OEZq2k0MAqOtLj09YSSkZiX04HWMbimqRDaLKfDSpG8LlEt7Y0PaUntgcXK3VPJgvc9rxKuL/4Z
 GHVic9JIMUZuVD+I7Mo9Nr/lXzBNnPQcRtOJLXOtfxpcQofIJIAzxGl6NlgZ0RyXOeXM3Fei/a+
 7YYq0W7bkQqCUmd4XJm2nDPMEHxzaD0R/bDOYq7waY36DuvnvHse24zyEw0f6YsK6QvPKr3/u+s
 VRlwp8zc0kKvDFcpJj/1yV0y8mtnuOqi2+ubCCx4QYIiOa6fgdsApEtmoR5fTl2ev6iiok/CbPL
 1WTRyW8CJhw1ZHSEFNi6s4uFvMiadNxuoFkhM7rIdLT4Sr/EA83OQboKpoMpEe5mt0yW+FdLESX
 psGfPs0wFRdlpGA0+B49mvY+9inpdhLr65H7I0rbQ9iYqtJ/8l+hQgKmWMAYKo+1G58BQlv08eQ
 xWxrsFGDe5q1qjEwmeQ==
X-Proofpoint-GUID: YDXCY0PTCtxVs9bArka5aN8TLcMRUY5B
X-Proofpoint-ORIG-GUID: YDXCY0PTCtxVs9bArka5aN8TLcMRUY5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060141
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
	TAGGED_FROM(0.00)[bounces-8493-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,baylibre.com:email,analog.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 3AFE43A3F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDYsIDIwMjYgNDo1
NyBQTQ0KDQouLi4NCg0KPiA+DQo+ID4gSSBhbHNvIGhhdmUgdG8gbWVudGlvbiB0aGF0IHRoZSBv
dmVyc2FtcGxpbmcgY29tbWl0IHdvdWxkIHRoZW4gaW1wbGVtZW50DQo+ID4gQUQ0NjkxX01BTlVB
TF9DSEFOTkVMIG1hY3JvIHdoaWNoIHdvdWxkIG1pc3MgdGhlIE9WRVJTQU1QTElORw0KPiA+IGlu
Zm9tYXNrLCBhbmQgb2ZmbG9hZF9tYW51YWxfY2hhbm5lbHMgd2lsbCBiZSBkZWNsYXJlZCB1c2lu
ZyBpdC4NCj4gPiBNb3JlIHRoYW4gdGhpcywgdGhhdCBjb21taXQgd291bGQgYWxzbyBhZGQgb3Ro
ZXINCj4gYWQ0NjkxX21hbnVhbF9jaGFubmVsc1tdDQo+ID4gYW5kIGFkNDY5M19tYW51YWxfY2hh
bm5lbHNbXSBhcnJheXMgdGhhdCB3b3VsZCB1c2UgdGhhdCBNQUNSTyBhcyB3ZWxsLg0KPiA+DQo+
ID4gVGhlbiwgY2hpcF9pbmZvIHdvdWxkIGhhdmUgYWQ0NjkxLzkzX2NoYW5uZWxzIGFzc2lnbmVk
IHRvIGl0IGJ5IGRlZmF1bHQsDQo+ID4gYW5kIGluZGlvX2Rldi0+Y2hhbm5lbHMgd2lsbCBsYXRl
ciBiZSBhc3NpZ25lZCBhdCBwcm9iZSwgZGVwZW5kaW5nIG9uIHRoZQ0KPiA+IG1vZGUgYW5kIG9m
ZmxvYWQuDQo+ID4NCj4gPiBJZiBkaWZmZXJlbnQgY2hpcF9pbmZvIHN0cnVjdHMgd291bGQgYmUg
d2FudGVkIHN0aWxsLCB0aGVuIG15IGJlc3QgZ3Vlc3MgaXMNCj4gPiB0byBoYXZlIGRpZmZlcmVu
dCBpbmZvIHN0cnVjdHVyZXMgKHBlcmhhcHMgbmV3IHR5cGVzKSBpbiBjaGlwX2luZm8gYnkgZGVm
YXVsdC4NCj4gPiBTb21ldGhpbmcgbGlrZSAqc3dfaW5mbyBhbmQgKm9mZmxvYWRfaW5mby4NCj4g
DQo+IFllcywgdGhpcyBpcyBob3cgSSB3b3VsZCBkbyBpdCB0b28uDQo+IA0KDQpPayB0aGVuLCB3
aWxsIGhhdmUgZGlmZmVyZW50IGNoaXAgaW5mb3MgYW5kIGVhY2ggb25lIHdpbGwgaGF2ZSByZXNw
ZWN0aXZlIGNoYW5uZWxzDQp0byB0aGVtLiBUaGFua3MgZm9yIHRoaXMsIHRvbyENCg==

