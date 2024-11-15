Return-Path: <linux-pwm+bounces-4080-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C399CDD24
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 11:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D91F227E2
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758A1B5EDC;
	Fri, 15 Nov 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EIi90kuB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D21885BF;
	Fri, 15 Nov 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668380; cv=fail; b=Xm9TA+8MqR3UyivZkRy+Jj9r+20AOJ5ogyXRxJR5feOuxFCkFh53QsKxN6/NsJfK8XKXp6y9uyB0wDV/2ApCj9y/88nayi6Fc2MNFMhox1FA3H6RSG1p9rBkBntjindEf45W2Yo5VLbCU3+1nBfGU4V/4ckaQfM0dbhptxLvMmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668380; c=relaxed/simple;
	bh=FihRiwpZ7WEif64YuH8GU3YK1HAcfHnIKw6R36MDKbE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qC98M+KSsoZQhEs5HksNdUt8KQl1T6Dej9uZ1/klKfJlvqIxCOGMO6tuiou0wgIEdN9RQn5fYoAQ5ig2BHsmrmbcneFKyhb8p+IjXnsi35VjPUTn0snGlsjVAKrTu36Sh8/49hKfmFrKrNYkx+moWdzZwjB8c1YT82doL7cHQ5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EIi90kuB; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAGwBE006059;
	Fri, 15 Nov 2024 05:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FihRi
	wpZ7WEif64YuH8GU3YK1HAcfHnIKw6R36MDKbE=; b=EIi90kuBJbnxckjA6uuK8
	c1r4OCWnybFRcjY9LJ88PE/XhaYXYwBHaeKVs4wBSdkbRSivUkFfWmTqCVT8fXWe
	9HLV54ijfIKd5FqsV80KxL11qhAnR0Lhb46TNURZZHNYL+Zh9bKTHE9QbKtrBizV
	5PUyDBcUcQkTSewzKheLU+ieoNpPchTtwZXmYHH9MrAxnF8WTQxFnb8mtxnA8MsX
	iDc/nFNtmNQHtxUws5X9J7/cnplKR1ELSbs4DfvSjLrQ3iKvrlPVZ6D2UOyw6W3p
	A3KySi3dYX+PPHDe3KaVWCU7SOcafcXRC0bItizhJCio1se1neh968JmeAD4a7mt
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012014.outbound.protection.outlook.com [40.93.14.14])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42vrwwp2en-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:59:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf+05DH71Y3vy13qv28EQGDwk05w9FHJoP0Cba64QiMVukLFWggk7dKxlaMakIybjAo4WkSgeQebCIMrIXaEE3vAsA2x/6Fp+ADS6sE4zGt25jl8niXdCpQRne68zp+riAbaukc/Lf0uEto0QSV2/jLbOUVNN2V+xM7x7rlz5fkrpK97iS5s8cQlsYL35+nigiRkgnGrD+Blifa2fPO4959eVB63zTQxlxGYAkNTVMU5+blkiG7bfosqiwwDRcjN01gOyju3h6fDj70KJngQuOLhXzVBZnQmVhKXTG4A6MKsMNrfBq9VB//2Z/fawmTeSXpOcNoR9KGWjWqggKAzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FihRiwpZ7WEif64YuH8GU3YK1HAcfHnIKw6R36MDKbE=;
 b=C+raT63MfpVwfoO+qTvzyQ1P5dY+/U5WVkW1devAzTNqXG9OmHadAp9xtB8hHO93yVzJ3T+ByJV46VV92nXCOguoAxZPQ4dICdyXhze4j0HvxfVLFwad35FwZR5Fu9yZhJJWbn6Ypbq9nPLnnMeoHjobCaSHOmWUm0g4vRv9EpzVpHfXelPlDlnjcZVnam2nP5UV6UG2iLevcnCtsXVYyBpYk9Q1Aay57HEzbKxKS3hsT6gXk5EHfuNhQkCHB4ai0XVkbCo90Nv14lVikDn1axPVotCtgUzl2G2o5HTvHkC/hZraMNHsm1dfKW1R9uMvo1zTgE+QRpq4b3kHHkVJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BY1PR03MB7922.namprd03.prod.outlook.com (2603:10b6:a03:5b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:59:30 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.8137.018; Fri, 15 Nov 2024
 10:59:30 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
Thread-Topic: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
Thread-Index: AQHbNDMFlup0uAxPr0GP3n6fJH5kPrK0ExqAgAKHNyCAAEWSAIABUl9g
Date: Fri, 15 Nov 2024 10:59:30 +0000
Message-ID:
 <CY4PR03MB33991C99B1BB42CFD20B18C29B242@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
 <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
 <CY4PR03MB3399FA960416CEC64E1FFF929B5B2@CY4PR03MB3399.namprd03.prod.outlook.com>
 <6c034f2c-1f07-4dfb-8e65-dbf41e803f01@baylibre.com>
In-Reply-To: <6c034f2c-1f07-4dfb-8e65-dbf41e803f01@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFoWldGaU1Ua3hZUzFoTXpRd0xURXhaV1l0WVdabE15MDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjWVdWaFlqRTVNV010WVRNME1DMHhN?=
 =?utf-8?B?V1ZtTFdGbVpUTXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNRGM0SWlCMFBTSXhNek0zTmpFME1UazJPRFUzTlRnMU9UVWlJR2c5SW1o?=
 =?utf-8?B?VlJXZEZUWFF3VlVkcGVtVTVXVlpPVTFsaEwyNHJabTFQV1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTBSb1oxWjRWRlJtWWtGVFZrRkJZMjlXVWxCWFpV?=
 =?utf-8?B?cFZRVUo1YUZaRk9WbzBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJXazNTbTFSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BY1PR03MB7922:EE_
x-ms-office365-filtering-correlation-id: 6d7e6c7e-cef9-4396-4b89-08dd056494c6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkNwNnVuVXRoaS9IQTNBTnQzUHE1RTB0NHZFaDlaNEJ3ZTRRVHBHL2ZmeU5v?=
 =?utf-8?B?QXVNYVNSY0xQYkNGYzV5NUxpVzRiT2doT3Z2SzRtU2MyaCtDZjNqcGtGUlVT?=
 =?utf-8?B?RlFkNUFCaG5hTHpKSFZ6QmpxbEtwYzkyUndIQTExTmxuZTc4SUNPbFNCTGFQ?=
 =?utf-8?B?K29VSmw5eFR0bTVocTBKSWo3Q3Z4elJsS2ROQ3NKUHg0SXJDUS9OSFlab3c4?=
 =?utf-8?B?Qzc0NFIyUFlqMncydHh2M05BNHMrRXl6Mm1xQ01yRm9XTnIyU2pTSTBtV0sw?=
 =?utf-8?B?dGw5Vnpvc0pFV3BmeEtLZWVZaFR0V0lYa2FYRTNydm44c0pnc0xyd05uMjE1?=
 =?utf-8?B?UlRJM21EaXRHaDFNalF0TzkySFNmNHluNHpLODV0STRFQU1YeWtmZUZzNU15?=
 =?utf-8?B?blhZdnZjYnZHV2lKcXgwNVhLRzBWL1FIT1ROelN3a0RvRGc4Sit1SER4U2Jy?=
 =?utf-8?B?U0FEaE9NK010WGN1aUsvcklBNmJDdXlWdjYxTlZFQWJwc3ZQM0hwSVlKTHlR?=
 =?utf-8?B?cnJYTXpuNFNLVjU2QVBlc0RyTmR3dWZtdHRkTkkvb1JyeitTWjNMSHppdVJT?=
 =?utf-8?B?UjViOThadWNVeTB6VDRBMThQUXFHVDhXZHRScm1velJ4YVc1NXEyNWpRYkZG?=
 =?utf-8?B?cUlScEU1R2tBeTJCSExzcFk4eHhabE51aU9YczVmaTdCV2dGQlV3alkwdlB5?=
 =?utf-8?B?Q1hYMm45MHVzamVRamZOLzIrUVc0aFhrdVNEcStQa04wSnhrOUY0dHRxRWpl?=
 =?utf-8?B?YnF0TDg5YWlRVVRjRm03eVkvc1hHQ0lTcUgrRUFoNDdidmVSeGtkV3RBZTQz?=
 =?utf-8?B?Nndnam5oblpRZUZMTDRjZExBUnpjbjdRcXlLZzl5U09MbHBySzVSOG9ETlRn?=
 =?utf-8?B?d0NlaHNWOG5LK01sR3JMc1FIUXYvZDl6SSt0SkVKMFNaT1FuZXgyQ3A5UzlZ?=
 =?utf-8?B?eXFLVm1FT3JzYzNGVjVvZmxZSnFuZG5UL2hwajdhcFZETDdZMUlSWXhWR293?=
 =?utf-8?B?T3AxL2ZMeWs4N3lkS09EWm9OTUhHTHhBTmhOVkFsMVFKM0xVN0tudmZSUGl5?=
 =?utf-8?B?MjdjeGR2Q1ZBTU92cEM0TjdTckFPNnJTdkdpbHl1c2JOZ1ROUnp6MVdXVno1?=
 =?utf-8?B?Z3JtcjJzeEVoZjdpWlU3RWFkb3dOY1VxSHdrbjBMVkZkR0RLb3o3K2ZNMlFP?=
 =?utf-8?B?V200ejR6bS9DNHM5Q2JYNkJtU0pFbWJxaEU5bTBuZE40L2JZN2I4ZzYrY1Vy?=
 =?utf-8?B?YjdZeW9NSVgvM1ZUUWo2TDVERzJOeUZDbnIwWXlOU0ZPSXQ0elc3WGZ4R0xH?=
 =?utf-8?B?N0JRa3BuUTVEdlhpSno0VEk5S2twS2JmU1VpcC8waUZmRnZZRVVOQlVEd0pu?=
 =?utf-8?B?RU5hZ1p3VmF2aXdaTmZmdy9qN0VaQkxzNXNyUU82bW9yS3hEanMxZHlnNXc1?=
 =?utf-8?B?bUJqVE5YRnI0Yk1sMUU3S1FOQ2pNVTQrWGwyeHJPckFEd1lDWW1IbTFLQzhD?=
 =?utf-8?B?UmJ2T3VydmtpN0FqL2FUZVo0YWVaUWplWXpjTGdRQ2tnTGg0VWY2aHBEbE5i?=
 =?utf-8?B?R2tOaFhhRVcwalNRckJUNlZZMWlVUGp6TW9uSzd5NmNnWko1TEpTWjhVeWRQ?=
 =?utf-8?B?NTlSbUtkMndabWdDOCsrL0ZOWE9zbmxNVTQ3NkhDNXdoNzBMZHB1dHcydkVn?=
 =?utf-8?B?bVJkaG5raFNCQ1UxL21QY3pEZzJTYlRsZzJmWlBpVTc2UVhXd29ZTjN6MHFH?=
 =?utf-8?B?YmQyK0w1R0dFVGdtL2w1dkx1T2ZhOUdmWlZZK1g2UldvU3YxNXVEOXMxK1R6?=
 =?utf-8?Q?cu96SSCq5VmdyLKzTc0/6IVY5VqTNMUUKAiTY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2Q4QXNxU2IzVjl5dDIrVzlDanRSamFZZjZ2TDlWTVg5dDRGY2lySS9WY3dW?=
 =?utf-8?B?aElLK0MxOVhTdy8rbTBiMnpqQk5LdnFOY25IL0pCaURuSzEvM0NIdVZnbUVi?=
 =?utf-8?B?RE41N0NmR3U4dURIcTIrN3JIdmZHMEhodjJ2NFQzS3Z3UUk5eUFIN3Z5ak9U?=
 =?utf-8?B?U1V5UW40MnpHalhmUWlHM0RwZzZlVEZpS2lUcUl4czBIZlFzZ0lSY1NsQ3FV?=
 =?utf-8?B?bXMrcnpaMlRrRTZ2Y005UThheWlUWFhhVWM5dXhLdEwwMm1tdnFiOHRnWnNQ?=
 =?utf-8?B?aCtiMW43YXB5bEdKODlrTWdlRndVK3BrU1pIdE9tS1N5MW1jTXVHQ1ZPZThy?=
 =?utf-8?B?WWd5NGpUREdCWmlTSlUzUnZhUWhTR3pZV1liUlVaemhiVVdhbUM1MUwvV3Zl?=
 =?utf-8?B?SitCL1BEZmFrbGlsTzlDWkxtMHZ5bG9SN1hvVWg5bm4razZKaWpPazdaSW5Q?=
 =?utf-8?B?WDB4Q3dXN20vRlVLdjJMODFSL3d1QklYZ2VSWGFYT0lhSXdiU0lFTWgyWVZJ?=
 =?utf-8?B?REdMUSsySEY1cnY4d3p0c1RWZ3Q2TFVzL2NqSTFYNnBWVEx4MW8yZUFYSG54?=
 =?utf-8?B?cjFUaDRzZThFUnF2YnNjdGtiV3Y3Vyt0SDlsemoxSTBSbUl3cjZzanhkMmxJ?=
 =?utf-8?B?dkNBdThPNEl6RHp2aEhCM2U0WUQrSmFROVhNUDhGV1RuMlBsbG1pMlR4cEI1?=
 =?utf-8?B?QXRGaWxCWHJ4dmkwbzdLd1lLRXA0Smljcmt6TTRBV2RhQmxOTlU1dDFkcHY3?=
 =?utf-8?B?MmNCTEQwTm9nNURyM0ZieDVUb09WaFpGMC8yYjhyL3hBVkpueGNmT3BHQWhY?=
 =?utf-8?B?bkFkcjJ3cEJ3NTNUakMxaGR1VnE5Q25ubWh6MTQ5K0R2b0xsWmNUMjlxR2lt?=
 =?utf-8?B?Z3lWWHZtMTZoMjdSNnIvUVdKNzlYYmhPOWFtTzVDM2FraFUzVlNYSU03c2k0?=
 =?utf-8?B?YVd6SmVoM0JIRkFYSlVmK3QySG9IU3pTRGVhMkxZVjdKOCtveVFvRlNuTWJJ?=
 =?utf-8?B?MERXeUdvMjdFSmFIazRnMm1SUmRLd3hEYUwvRzRtV2plemxxaTRhY1RNSVVM?=
 =?utf-8?B?WC9pUTFYRVpKa3lPU3RLN2JNa25UcFV1REdPV2pJQjJjS1UyNFFKYlBVNk5P?=
 =?utf-8?B?SzFtaU92TVZxc0pKaXQ1YUFzejZPck9kZzcrQ0ZsN3B2RWs5RlFvdk5JSnNp?=
 =?utf-8?B?TGVmSERnVFcrMDNtRS9ZSUFqYUIzZWhxdXNVa1NSYzdkVHB0RE9VZnE0VGd4?=
 =?utf-8?B?dnJVTHBLVFlRUGdqWmpOenkvMDFQUUdjNWIxbjA3bXB2VWJGa1lEdTR4NUVT?=
 =?utf-8?B?VGN3cmZSMTB0VXdvcE1JL0ltaDU0QUtSMjQ5MzZkdXFyOFBzK2NETHBOSDIv?=
 =?utf-8?B?ZWRkaytSRUJxbVY1QmgrMGJJNmhZd3VUMk5sZEVxYmFUaFU0ZWljNWQyU0x0?=
 =?utf-8?B?ajdtVlQvTm1vZ25iM0cwTGhTYk1lUStVQmNabTk0TkpoTDlOSk1weERpUy9Y?=
 =?utf-8?B?b1BwZ0JSelgyRU40M3p5TUYxZkR0bWZFUzVGeVJRdFREZmR0VmdWN0M4NHpj?=
 =?utf-8?B?QU1FY2MzajlNODJGTjBMRzEvcUFvODgxZEx3Yjl1d2RlVWdQbmVvSklMcDZX?=
 =?utf-8?B?SXJsZ3ZuaDAraU1pc0ROSk0wWnNHRno2SDhKcjd4RWZkR0Q3V2NvN0hSYUhC?=
 =?utf-8?B?SGFXakh0dUNGTnpKUDR0RStTdHpzNjlaMlRuZ1Z1MWMwTmVVV2o3b0ZBb01D?=
 =?utf-8?B?MDQxZ3pOUnhGUExHRVAyVUFJaGppQ3Y3SXBLaWJuNE5XdHRHZm9ObC94bG40?=
 =?utf-8?B?eTlKSDlMVk9HeXlpK2hxcE9OeVJOS05xemlvNkk4d0VYejl0Y3k2ZElyNi9r?=
 =?utf-8?B?a2N4RFV3SGk1WXhhSHQzOGJQU2p2eGZPRlR5QXF3dk1UdXJ3amZoUHppU1Nn?=
 =?utf-8?B?dURDL0xlRWREYkZrdmpyUzE0azlqSnNQTkxsNGQvelJKcWU3VkpLQW5QcDBs?=
 =?utf-8?B?K2JRaWZVbEV1QnExL2FrV0g2YlB1QVZNMWtFVVhHamhUdHpJbGg2NEhuWTVV?=
 =?utf-8?B?L3JSVmkxaG04TG1nbkNTckJRbTFxLzE2dWRlN2dlMVk0L3VvbzU4UmFUNFFi?=
 =?utf-8?B?ZHRiZ1dIa2JZQ3lzVXZJZDRKdVQ0ZWpCKzF0eEI5cng2cFkwbWxCMEk1TXA1?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7e6c7e-cef9-4396-4b89-08dd056494c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 10:59:30.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaNCDTlnNVhbdStkFLKUtrDta0Qhxw2OTn5Z3VIDmsxx/O9P27K7bNWTqhdyZqBpIqtXUnxLELW8uAphovLB0TN1ZTX45O9SFNL6W6M8KTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7922
X-Proofpoint-ORIG-GUID: b7D7TBP0aoh92mNsL0_QfciOMsGfEIKE
X-Proofpoint-GUID: b7D7TBP0aoh92mNsL0_QfciOMsGfEIKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150092

DQo+IE9uIDExLzE0LzI0IDQ6MzkgQU0sIE1pY2xhdXMsIEFudG9uaXUgd3JvdGU6DQo+ID4+IE9u
IDExLzExLzI0IDY6MTIgQU0sIEFudG9uaXUgTWljbGF1cyB3cm90ZToNCj4gPj4+IEFkZCBzdXBw
b3J0IGZvciB0aGUgQUQ0ODVYIGEgZnVsbHkgYnVmZmVyZWQsIDgtY2hhbm5lbCBzaW11bHRhbmVv
dXMNCj4gPj4+IHNhbXBsaW5nLCAxNi8yMC1iaXQsIDEgTVNQUyBkYXRhIGFjcXVpc2l0aW9uIHN5
c3RlbSAoREFTKSB3aXRoDQo+ID4+PiBkaWZmZXJlbnRpYWwsIHdpZGUgY29tbW9uLW1vZGUgcmFu
Z2UgaW5wdXRzLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8
YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IGNoYW5nZXMgaW4g
djYgKGltcGxlbWVudGVkIG1vc3Qgb2YgdGhlIHJldmlldyBjb21tZW50cyBpbiB2NSk6DQo+ID4+
IFdoYXQgaXMgdGhlIHBsYW4gZm9yIGFkZHJlc3NpbmcgdGhlIHJlc3Qgb2YgdGhlIGNvbW1lbnRz
Pw0KPiA+IEZvciB0aGUgcmVzdCBvZiB0aGUgY29tbWVudHMgSSB0aGluayBJIHJlcGxpZWQgaW5s
aW5lIGluIHRoZSBwcmV2aW91cyBzZXJpZXMuDQo+ID4NCj4gSSBkaWRuJ3QgbG9vayB2ZXJ5IGNs
b3NlIHlldCwgYnV0IGF0IGEgcXVpY2sgZ2xhbmNlLCBJIHNhdyB0aGF0IGFsbA0KPiBzY2FuX3R5
cGUgYXJlIHN0aWxsIG9ubHkgc2lnbmVkLCB0aGVyZSBpcyBubyB1bnNpZ25lZCBmb3Igd2hlbiB0
aGUNCj4gY2hhbm5lbHMgYXJlIHVzZWQgYXMgc2luZ2xlLWVuZGVkLiBBbmQgdGhlIHNjYW5faW5k
ZXggb3JkZXJpbmcgaXMNCj4gc3RpbGwgd3JvbmcuIFRoaXMgbWFrZXMgbWUgZG91YnQgdGhhdCBi
dWZmZXJlZCByZWFkcyBhcmUgd29ya2luZw0KPiBjb3JyZWN0bHkgZm9yIGFsbCBjb25maWd1cmF0
aW9ucy4NCg0KU3VyZSwgd2lsbCBpbXBsZW1lbnQgdGhlIHNjYW5fdHlwZSBhcyB5b3Ugc3VnZ2Vz
dGVkIGluIHRoZSBuZXh0IHNlcmllcy4NCg==

