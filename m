Return-Path: <linux-pwm+bounces-8831-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDywGKVc/GlPOwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8831-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 11:34:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D084A4E605A
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E74302AE01
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048683C0639;
	Thu,  7 May 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qMRq51w8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61D37BE8A;
	Thu,  7 May 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146002; cv=fail; b=Y16B3MWTsecaZqVpeZtVN57JRGt06yl2gymaUQLxaKl37GeA+qDo9tMdbtLqy92nsNc5dBjCl910AKLPd2Ao+vLsw8fRjNG8BMZ6ScLm8ppFvESs3RAdor+D1upoGL6gWFP1TjP6rgSD+FdzBxtc3aE34NhH7EI5vTuywinspes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146002; c=relaxed/simple;
	bh=xRoKqBz1yDDMTMFj8YSfXHmYdg4CjeqKavYG1PwkFKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCWV2bXz+cbNnEQmvwwSejXXc/dAG+5qnJwy3PAxU49IUg1zP8G1C2tnHJI8G/cqaLOuIMsaUbo4wlnGEsuVMmenHQ1k8zxLAWxcRJYaqt0xnNFMnTWRQnC4WosTNYqt+LO2bWHrGjlfywI/tiVHwYnxbUVZlo/QMvWYE80GpdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qMRq51w8; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6477FFhJ819501;
	Thu, 7 May 2026 05:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xRoKq
	Bz1yDDMTMFj8YSfXHmYdg4CjeqKavYG1PwkFKk=; b=qMRq51w8hTIUrwjraqH26
	oNcrIOmRYMij7s7g5Y+ehzgtKA4kPCLBcA9jgUivXwE3gqe7J8QFnU/EuNeS3GQ7
	Bna2RAFFtNX3qoTEdwf+ftHDmJrnHQzDlOEhDo6qid7feuDvHSttkhL7P6kHWnBx
	8EniyfZdf1bpLUch1vX86tgQewnu4MDo+cXo4rbps0tfKQ1mhX/aVu5WaQca5DaT
	AaX2yyf8WAbYL/LMtwmHkaZoShHf7DOR+yo9oPrfNzkZq8U2VvtDpGUSkEiLO33b
	IFnw0H/u199ipTM+KbmRX4rSQdOPMHIhMMrdleNqFvXL62EIyj01iW1TfypsGI1y
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dyjef7875-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:26:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTr7xFveq4piF9v4m4ZMXYjk5rKzkL7amlcgT4sf0WItUsVHs4BLPLRz6gYtNX73jNzuEauxEMtCgghcJKk/eEKWGGI+l3Mc733F72OlT3ZTnYE6O7GAogWFQU79HF5QyqksevqbLyMj//oDNvUGcYVy2DBtpttPJrJiKHeI5Q4f3UhiMyOVGNw+7pRnMDvigFaT6/zp/fHZyyWIX2wwc0wrtFfizsjWlhPM/ynCtI64zRZCY73KIetjQPL/snP7P6fJLQPDDRKEjENZbYL15Db8U+V+7KNL3dtj1QJl+eD0lz2d2RzNujANDcjSyGwY1wVVygrV1h78gNRI5/mbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRoKqBz1yDDMTMFj8YSfXHmYdg4CjeqKavYG1PwkFKk=;
 b=le5+kfw4QnQVlBGCwC/UnijNYUVWXgb0rmPMXPsp1dpxjd8qwPNgL/+BBG4hv5dgwIVYVFDa+f4mXTETtUSbMedWnIJQHerPkIKRJUHtQCBqxEod4RjL/D1JBFLH+yt9kEvkg+kIUVrRfVzxTrEwqhLFuGYGAreBPWLew09n2ioUdzIx1xdjZmxi72y2Ntm6IV+Th4UuheawrOzeCA2E1/EOXAVgN/6A5NtaWS5otzJbp9I8LzI6LPnUmiwv4ZXIq/CgFqLW4VUXfrs1ovonQjV7JA2gvZ0PLMQ1LFH60849fB4ONSmbo7BPExQ2KG6hNoOPUau6y7Nnh8nI8p1Iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BY5PR03MB5316.namprd03.prod.outlook.com (2603:10b6:a03:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:26:00 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 09:26:00 +0000
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
Subject: RE: [PATCH v9 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v9 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHc2Ip5rxDjrc5X70C/4XCGYyViUbYCUrCg
Date: Thu, 7 May 2026 09:26:00 +0000
Message-ID:
 <LV9PR03MB841460307B0CF4C6F267A631F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
In-Reply-To:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BY5PR03MB5316:EE_
x-ms-office365-filtering-correlation-id: 69c5d81c-07dc-4226-7a25-08deac1aa73b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|3023799003|38070700021|921020;
x-microsoft-antispam-message-info:
 R+wYOmV3vLgfUq370NUENSFoYoIavjwYOIY6E3ztiatl13/PeJtm42x2uRDxj4pFs2oXo3z+yGV9WTcjcElYbKpLij8BKwDM79KodFIt7VDdC/nzwEfYsyQGpSV3Ccyt2D2EIEVGd0MTYy+Z0wMa3ezJJ1I7+TA9AMLnt/etwcbV/58zzOZAJejWkS/mN1MAKqeOSxFALBdRxP2QV+2CEnuFXUpwv5JALNVIWC+vjVDzrd+pRVJjqGSQiTljjd3aplomWnBPHZkLOZi6j0vSapt8IqkL33xkQ7D477auw7Lcc/x3sDaeqeASjb2lBwefaIaaX2VIy08qjnsbjLDPziWV18MBcxaV/v7E5EzfF+vtVDPofIR4rXR5JghYKqYrRrFZ43wB59tb8M18ZFkhf8cRpHXLd2JJwPwbANgXWtFNMlw2PbDqFdhiY2/zS69U7kP8iHLnXE0K5EHvVe/fX3v9r774ZAxCCJzA4uUlCqwFBcs4vr/c1Nc/DwbCDE62bardxeB7p0JTqMx68X+DE67ESQd3AFc6Bh8YN2E+BIwTc0SryHs1Z+MDe0UF4xANTw56WoilJTJab4jrtMKnPBL6p8SNw2ndV+slSHG2/xL52xWpi1aSf8aDX99VZJZ4PpwRA8P924C2r0bRnCaXcQecNsAc+AahnbjN15/SQoNGxqgT0fMeEmtsloNREw9S6CX/g4RREn5TtVKhcXDs+sWRL7zL8WUjrk9mfzBOVhzRYT0J48sVYLQVVhafwpY4q4lnSGQ22TKoxNoNWV4hUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(3023799003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWxhV0FKWDZNZGswL1JBdHJwVEhNS0tHWFJtR0xzWWg3ZldPVVlpMGhFdHQw?=
 =?utf-8?B?amhON04vdE94OVFTL3NPSU1TSFFCeHlZSU5yK0ltL29XT09QRmwzTTFHczg0?=
 =?utf-8?B?UmRrendVeGtpekh1bkhJbUVjaVZUMUx5bVIvVEpMQ012T1RtQVZyMmVMdXhN?=
 =?utf-8?B?Mkpra0E5MmsyZnFCY1FrUHh6ZHJ4d2Zva0NUS2thNzZxV3MreXJpcVVEUDJt?=
 =?utf-8?B?K1h2aEgzb3UrNnJYSGlkSjlDNUJzOG01NEVQTlJXcFdDRUJSd2FjTXRHMWN2?=
 =?utf-8?B?WVBkZHcvT3pESWtzMkNDR1RNclFvRHBZcnU5dGZoLzlPOXR2SGlKOThyNHRB?=
 =?utf-8?B?ak5UYVhTOTVMYUtiN25hTVVXS1lnbXpNQmU3bWM0eEFrWGgvcGJUdGF0dEhu?=
 =?utf-8?B?blVKYTgxSmtIbkNGa3BDa0l1VTh0enBRWFVkUjd1Qy9MYjdGbWVCeWNvN3Y3?=
 =?utf-8?B?dTlSRUl4RTBWYXZzNE9kZmdxWEFqdUppdTVCdUp4V1dpYlIrLy9HOUREem1V?=
 =?utf-8?B?bmQ5RW9RNnJqYUlGbDF1R0I0TzVHVFc4VFdmaWtKbzVvbUJKOThubVFKQjVU?=
 =?utf-8?B?T2VxOEtHanlkM0x1Y3RkYXlqZ05WcVQvckdlMk1IbmVUVmF6bGVWWjVZSk84?=
 =?utf-8?B?eldzY1MrTWdxb0tLcVBTTWs1d3J1dWRzU2JlOG9PQ3FEV2NpaGdZWVI2VUdP?=
 =?utf-8?B?aGVMeEVpbGtOOFhxQS9jeWN0bjU3d21zdWcrTVRzOXZybTI3OGdPQUlWeWVR?=
 =?utf-8?B?b29LbFZRVlZKeTJ4Yk5GVCtIcE1leGtCN0J4NC9nZHg0YkF0SGhZUy9zdmZy?=
 =?utf-8?B?WTY1VzF6VjNTUXNhaHRFRUMxcEhJS1pKYzRvK2sxKzd0TGdLT1Q0eVo2VUl3?=
 =?utf-8?B?RFZsRUQ0MUhaeG8rZjYrY1dHazkwUnRGakdwb0JLeGdCc2NSY01NcjNaUnJD?=
 =?utf-8?B?TXVYV2hoYlduVkVwc1UyYXlaQ0lGTDNKeUZmSnl5Y2VRNE5vNjFJcEN3cnJJ?=
 =?utf-8?B?T2V2MU9vL3NUS0dqb0JENTdGdVlCaU45QTE5cUpDRXpaa21tV1Zrd1ZBWjBP?=
 =?utf-8?B?UEIwclBzTHB1eVFFZGtPeUd2WVFNcEhPNlJnWjN3cTBKNHJJbWhNZ01Vcm40?=
 =?utf-8?B?cmt3RTBONGlWT2pXNXpEMngzaElkRFZSSVFyRzR0U3M0UFlkRDVoTVduNGZY?=
 =?utf-8?B?TjUzQ3lKQ1JQOXlJZTh5U1NYTkp6MlduSFBUYW5lajFMcFgxbStLSTcvRGV0?=
 =?utf-8?B?N3NEc2JBb21ya0dNUktZOEQ4eVB0eXZQLzFvZzVHYlVhZHMxTko5UkFXWnFS?=
 =?utf-8?B?QXN5MmIvazBFTVM2cnk0eDh0STFtNWlNYkVYaXlSUWZKTTVTSlB4bzc2NVZn?=
 =?utf-8?B?bVBJUjc4QzV1WjViVlFYRDZMOG1uKzEzWmdRaFpiNHZmNWJNVnhWRVRtSjlF?=
 =?utf-8?B?QjgrSDZ5OXJzSFJ4M1BOQm9OQlZGMDBhZ25pVXAxL1pHODZEQjhNZTFMWFVM?=
 =?utf-8?B?YzRuaEpSL0d2Y3VQbGR5a0FjUUFmd25LK1Q2cXhMNzR2Y3IxUTJ6dkROdDkr?=
 =?utf-8?B?SlBsMnpWMTF5bDhlSlRva25LaWRXYWJFcDJEZ1ZkT3dxcUhaVmNkNEN2d2Fy?=
 =?utf-8?B?Tmo3WkliZXpRMWxLZXdab1dSTDYrM0NZZmRQT0dxakZkVkhrQkVyWGNrQlU3?=
 =?utf-8?B?Sjh2Y1FIWU93anJlMmc1clIvVnRualp4aWFPaTNpNmMwUUhqZnJIUFRucGtp?=
 =?utf-8?B?c1JxVUtSbUcyQnBCY1JLcEJFeGMxTi9XcDAwMnB2YnZaT0kxZVZqTUVJcS9v?=
 =?utf-8?B?U2tuMDdubEVrRUFRajNMZmFhVTJPZnZGOU9XUnhVYnI5NHRORGpTNDVlSTNo?=
 =?utf-8?B?OTNEaDZIUTM0aTh1c2RnT1p3UlVZRWp4L0xFN1JPUkVmYVRyYm41QUhFeTNF?=
 =?utf-8?B?cW9LQXAxUFBrMjJ5ZlA0bmFaY3VhR3N1ZmRVWWN6NXJtRG9RWVR6TVluOEQv?=
 =?utf-8?B?ODNiU2F1aDJiZUE0L0xaWjErZU81OHNMOXVRN0JBQkNPZjhDbTJkbXh6aW8r?=
 =?utf-8?B?bktSRlZZekI2YkZXNWo3bVFXeDh4Z2J3dGR1SHFUMU9JRms1U1JSOVRGV1BV?=
 =?utf-8?B?TUZhYVRuSVBvdFBRUFEwS0hlK1ZYY3RFdGRCWENOYjJXY2RpS0lUWHJzQjky?=
 =?utf-8?B?QnhPU29oTXVxbE9KUW1TN01MalRRVkdtcnMzdjltSjkwc0pMUU96VzdodWV0?=
 =?utf-8?B?c3BMRVlBVk9qZ09zY1FxcEM5cjE5ajBYMUVheUwwMzhrYS9xYW9lWU9xUFpJ?=
 =?utf-8?B?WmRFamIrYlBoVHJUZytvRndFMWZEL3NRUzV2QXJZMlVOeFN3ckN0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZPofjnrymiW49cSi+deI49cieZMnrpGlWmg3ooYE8K/L3ssMUEbBnQrW1f60Dp6EkRwwv4gW02x31frif7ZV6gc35PwLyDDp0nMpFgzXoZdeEGZ49+20ZzdfJDFSDoVFO8I1WAREbTaR8fu7OflMCr1AjKmj2NxWbw5DHEas6DhpuetrXlW5dcxZF9JlHD8q5+2wPGZrSgpvdA4O+CJujsDqVKKmsNcHRueuw90d3rr2bD2UzCIRdqQBMGLm8SntRoLMgk9XC3YxBe58t7deOhYxlDVO04Qm7zGjVSMgSmdVZSlH04xol8O2g0hg3QwHML1FGH41pOTr4HhlivYIUg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c5d81c-07dc-4226-7a25-08deac1aa73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 09:26:00.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBhr4xvNsHTvYm6guANFkkbHwxhk1cEkFho6BJbn7DxtNaSHrtJ4YPEOodQBNImLV94nRYGyWMa82dGpFVUz0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5316
X-Proofpoint-GUID: JeYUByzXQp0e6OCPMvNFr_CFltjzg6MF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5MyBTYWx0ZWRfX5DNIGPUB84eG
 3r84PPb8t0wHbSAIg6UI51whOivzcGJdqY+RkrA3hjcGJL3re0ZM/d1TcbEnQqCKm7Io9RV68w0
 gylFOLCpFbJ97wJnGzSqWCjAUNicxKIIdstpsSxxhKGqBuuOWfPjsCGIMqvYeN+O1mbaZVy3Coi
 MrCmkoXSwlGSBRoUpyrbXljWpxnvwAPfOjxV6gEjGsOsh5oM+phDiUEiZ5mOpwlQ/fhBWQ2WUkU
 CoYJeJM5yqfwtEz8MzbCzvNtuwDT3uOyZHCZl62mV9DrgF4Fc8DdNtGrwzy2Z4/I+lvVlEHvrp8
 DeMx0Ie8Qnv1/aqLglAne85e4klcw65VEqCYx/Uaj+CHXkMCTKhHyQL/YuVAKHHj/dKBA21eWNJ
 G+w9AtrKInGIYcrP6JtkibkFHJMEycyMHzrHU1x1vi8DTe3uQGnlDBXNHk5UtgGJ9ahkxMd8FsX
 AEoYP1VKEIimCwvBzvA==
X-Authority-Analysis: v=2.4 cv=Kp59H2WN c=1 sm=1 tr=0 ts=69fc5aac cx=c_pps
 a=8uZh/oWqEamKeU/uFK3X6A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=VwQbUJbxAAAA:8 a=_Dew-ffWsTdNCoK9EQkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JeYUByzXQp0e6OCPMvNFr_CFltjzg6MF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070093
X-Rspamd-Queue-Id: D084A4E605A
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8831-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Action: no action

QWRkcmVzc2luZyBTYXNoaWtvJ3MgcmV2aWV3IGZvciBpbml0aWFsIGRyaXZlcidzIHBhdGNoLg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZHUgU2FiYXUgdmlhIEI0
IFJlbGF5IDxkZXZudWxsK3JhZHUuc2FiYXUuYW5hbG9nLmNvbUBrZXJuZWwub3JnPg0KPiBTZW50
OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMjYgMToxNyBQTQ0KDQouLi4NCg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiBp
bmRleCA2MDAzOGFlOGRmYzQuLjM2ODVhMDNhYThkYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
aW8vYWRjL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4gQEAgLTEz
OSw2ICsxMzksMTcgQEAgY29uZmlnIEFENDE3MF80DQo+ICAJICBUbyBjb21waWxlIHRoaXMgZHJp
dmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwgYmUNCj4gIAkg
IGNhbGxlZCBhZDQxNzAtNC4NCj4gDQo+ICtjb25maWcgQUQ0NjkxDQo+ICsJdHJpc3RhdGUgIkFu
YWxvZyBEZXZpY2VzIEFENDY5MSBGYW1pbHkgQURDIERyaXZlciINCj4gKwlkZXBlbmRzIG9uIFNQ
SQ0KDQoiU2hvdWxkIHRoaXMgZHJpdmVyIGFsc28gZGVwZW5kIG9uIFJFR1VMQVRPUj8gSW4gYWQ0
NjkxX3JlZ3VsYXRvcl9zZXR1cCgpLA0KaXQgcmVsaWVzIG9uIGRldm1fcmVndWxhdG9yX2dldF9l
bmFibGVfcmVhZF92b2x0YWdlKCkgdG8gb2J0YWluIGl0cyByZWZlcmVuY2UNCnZvbHRhZ2UuIElm
IHRoZSBrZXJuZWwgaXMgY29tcGlsZWQgd2l0aG91dCBDT05GSUdfUkVHVUxBVE9SLCB0aGlzIGZ1
bmN0aW9uDQppcyBzdHViYmVkIHRvIHJldHVybiAtRU5PREVWLCBjYXVzaW5nIHByb2JlIHRvIGZh
aWwgdW5jb25kaXRpb25hbGx5LiINCg0KV2lsbCBhZGQgImRlcGVuZHMgb24gUkVHVUxBVE9SIi4g
V2l0aG91dCBpdCwNCmRldm1fcmVndWxhdG9yX2dldF9lbmFibGVfcmVhZF92b2x0YWdlKCkgY2Fu
IGJlIHN0dWJiZWQgYW5kDQpyZXR1cm4gLUVOT0RFViwgbWFraW5nIHRoZSBkcml2ZXIgdW51c2Fi
bGUgcmVnYXJkbGVzcyBvZiBoYXJkd2FyZS4NCg0KPiArCXNlbGVjdCBSRUdNQVANCj4gKwloZWxw
DQo+ICsJICBTYXkgeWVzIGhlcmUgdG8gYnVpbGQgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMg
QUQ0NjkxIEZhbWlseQ0KDQouLi4NCg0KPiArfTsNCj4gKw0KPiArI2RlZmluZSBBRDQ2OTFfQ0hB
Tk5FTChjaCkNCj4gCVwNCj4gKwl7CQkJCQkJCQlcDQo+ICsJCS50eXBlID0gSUlPX1ZPTFRBR0Us
CQkJCQlcDQo+ICsJCS5pbmRleGVkID0gMSwJCQkJCQlcDQo+ICsJCS5pbmZvX21hc2tfc2VwYXJh
dGUgPSBCSVQoSUlPX0NIQU5fSU5GT19SQVcpDQo+IAlcDQo+ICsJCQkJICAgIHwgQklUKElJT19D
SEFOX0lORk9fU0FNUF9GUkVRKSwJXA0KPiArCQkuaW5mb19tYXNrX3NlcGFyYXRlX2F2YWlsYWJs
ZSA9DQo+IAlcDQo+ICsJCQkJICAgICAgQklUKElJT19DSEFOX0lORk9fU0FNUF9GUkVRKSwJXA0K
PiArCQkuaW5mb19tYXNrX3NoYXJlZF9ieV9hbGwgPSBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSks
DQo+IAlcDQoNCiJTaW5jZSBhZDQ2OTFfc2V0X3NhbXBsaW5nX2ZyZXEoKSBtb2RpZmllcyB0aGUg
QUQ0NjkxX09TQ19GUkVRX1JFRyByZWdpc3Rlcg0Kd2hpY2ggY29udHJvbHMgdGhlIGdsb2JhbCBp
bnRlcm5hbCBvc2NpbGxhdG9yIGZyZXF1ZW5jeSBmb3IgdGhlIGVudGlyZSBBREMsDQpzaG91bGQg
SUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEgYmUgZXhwb3NlZCBhcyBpbmZvX21hc2tfc2hhcmVkX2J5
X2FsbA0KaW5zdGVhZCBvZiBpbmZvX21hc2tfc2VwYXJhdGU/IENoYW5naW5nIHRoZSBmcmVxdWVu
Y3kgZm9yIG9uZSBjaGFubmVsDQpjdXJyZW50bHkgc2VlbXMgdG8gc2lsZW50bHkgYWx0ZXIgaXQg
Zm9yIGFsbCBjaGFubmVscy4iDQoNCkFncmVlZCBmb3IgdGhpcyBjb21taXQuIFdpdGggbm8gcGVy
LWNoYW5uZWwgT1NSIGluIHRoZSBiYXNlIGRyaXZlcg0KYWxsIGNoYW5uZWxzIHNoYXJlIGEgc2lu
Z2xlIG9zY2lsbGF0b3IgcmVnaXN0ZXIsIHNvIGluZm9fbWFza19zaGFyZWRfYnlfYWxsDQppcyB0
aGUgY29ycmVjdCBhbm5vdGF0aW9uLiBDaGFuZ2luZyBhY2NvcmRpbmdseS4gVGhlIE9TUiBjb21t
aXQgc3dpdGNoZXMgaXQNCmJhY2sgdG8gaW5mb19tYXNrX3NlcGFyYXRlIGJlY2F1c2UgYXQgdGhh
dCBwb2ludCB0aGUgZWZmZWN0aXZlIHJhdGUgaXMNCmdlbnVpbmVseSBwZXItY2hhbm5lbCAob3Nj
X2ZyZXEgLyBvc3JbTl0pLg0KDQo+ICsJCS5jaGFubmVsID0gY2gsCQkJCQkJXA0KPiArCQkuc2Nh
bl9pbmRleCA9IGNoLAkJCQkJXA0KPiArCQkuc2Nhbl90eXBlID0gewkJCQkJCVwNCj4gKwkJCS5z
aWduID0gJ3UnLAkJCQkJXA0KPiArCQkJLnJlYWxiaXRzID0gMTYsCQkJCQlcDQo+ICsJCQkuc3Rv
cmFnZWJpdHMgPSAxNiwJCQkJXA0KPiArCQl9LAkJCQkJCQlcDQo+ICsJfQ0KPiArDQoNCi4uLg0K
DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IGFkNDY5MV9yZWdfcmVhZCh2b2lkICpjb250ZXh0
LCB1bnNpZ25lZCBpbnQgcmVnLCB1bnNpZ25lZCBpbnQNCj4gKnZhbCkNCj4gK3sNCj4gKwlzdHJ1
Y3Qgc3BpX2RldmljZSAqc3BpID0gY29udGV4dDsNCj4gKwl1OCB0eFsyXSwgcnhbNF07DQo+ICsJ
aW50IHJldDsNCj4gKw0KPiArCS8qIFNldCBiaXQgMTUgdG8gbWFyayB0aGUgb3BlcmF0aW9uIGFz
IFJFQUQuICovDQo+ICsJcHV0X3VuYWxpZ25lZF9iZTE2KDB4ODAwMCB8IHJlZywgdHgpOw0KPiAr
DQo+ICsJc3dpdGNoIChyZWcpIHsNCj4gKwljYXNlIDAgLi4uIEFENDY5MV9PU0NfRlJFUV9SRUc6
DQo+ICsJY2FzZSBBRDQ2OTFfU1BBUkVfQ09OVFJPTCAuLi4gQUQ0NjkxX0FDQ19TQVRfT1ZSX1JF
RygxNSk6DQo+ICsJCXJldCA9IHNwaV93cml0ZV90aGVuX3JlYWQoc3BpLCB0eCwgc2l6ZW9mKHR4
KSwgcngsIDEpOw0KDQoiV2lsbCB0aGlzIHJlc3VsdCBpbiBhIHRydW5jYXRlZCAxLWJ5dGUgcmVh
ZCBmb3IgQUQ0NjkxX0FDQ19NQVNLX1JFRyAoMHgxODUpPw0KQUQ0NjkxX0FDQ19NQVNLX1JFRyBm
YWxscyBpbnRvIHRoZSByYW5nZSBiZXR3ZWVuIEFENDY5MV9TUEFSRV9DT05UUk9MIGFuZA0KQUQ0
NjkxX0FDQ19TQVRfT1ZSX1JFRygxNSkuIEluIGFkNDY5MV9yZWdfd3JpdGUoKSwgQUQ0NjkxX0FD
Q19NQVNLX1JFRyBpcw0KaGFuZGxlZCBleHBsaWNpdGx5IGFsb25nc2lkZSBBRDQ2OTFfU1REX1NF
UV9DT05GSUcgdG8gcGVyZm9ybSBhIDE2LWJpdA0Kd3JpdGUsIGJ1dCBpdCBzZWVtcyBtaXNzaW5n
IGZyb20gdGhlIDItYnl0ZSByZWFkIGJsb2NrIGhlcmUuIg0KDQpWYWxpZCBidWcuIFRoZSB3cml0
ZSBwYXRoIGFscmVhZHkgc3BsaXRzIHRoZSByYW5nZSBhcm91bmQgQUNDX01BU0tfUkVHOyANCnRo
ZSByZWFkIHBhdGggd2FzIG1pc3NpbmcgdGhlIHNhbWUgc3BsaXQuIEZpeGVkOiBBQ0NfTUFTS19S
RUcgbm93IGdldHMNCmEgMi1ieXRlIHJlYWQgYWxvbmdzaWRlIFNURF9TRVFfQ09ORklHLg0KDQo+
ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KDQouLi4NCg0KPiArDQo+ICtzdGF0aWMg
aW50IGFkNDY5MV9yZXNldChzdHJ1Y3QgYWQ0NjkxX3N0YXRlICpzdCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSByZWdtYXBfZ2V0X2RldmljZShzdC0+cmVnbWFwKTsNCj4gKwlzdHJ1
Y3QgcmVzZXRfY29udHJvbCAqcnN0Ow0KPiArDQo+ICsJcnN0ID0gZGV2bV9yZXNldF9jb250cm9s
X2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2LCBOVUxMKTsNCj4gKwlpZiAoSVNfRVJSKHJzdCkp
DQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihyc3QpLCAiRmFpbGVkIHRv
IGdldA0KPiByZXNldFxuIik7DQo+ICsNCj4gKwlpZiAocnN0KSB7DQo+ICsJCS8qDQo+ICsJCSAq
IHJlc2V0X2dwaW9fcHJvYmUoKSBhbHJlYWR5IGRyaXZlcyB0aGUgcGluIGFzc2VydGVkLCBzbyB0
aGUNCj4gKwkJICogZGV2aWNlIGlzIGhlbGQgaW4gcmVzZXQgYmVmb3JlIHdlIGdldCBoZXJlLg0K
PiArCQkgKiBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZV9kZWFzc2Vy
dGVkKCkNCj4gY2Fubm90DQo+ICsJCSAqIGJlIHVzZWQgYmVjYXVzZSBpdCBkZWFzc2VydHMgaW1t
ZWRpYXRlbHkgd2l0aG91dCBkZWxheTsgdGhlDQo+ICsJCSAqIGRhdGFzaGVldCAoVGFibGUgNSkg
cmVxdWlyZXMgYSDiiaUzMDAgwrVzIHJlc2V0IHB1bHNlIHdpZHRoDQo+ICsJCSAqIGJlZm9yZSBk
ZWFzc2VydGlvbi4NCj4gKwkJICovDQo+ICsJCWZzbGVlcCgzMDApOw0KPiArCQlyZXR1cm4gcmVz
ZXRfY29udHJvbF9kZWFzc2VydChyc3QpOw0KDQoiQ291bGQgdGhpcyBzZXF1ZW5jZSBicmVhayBv
biBkcml2ZXIgcmVsb2FkPw0KV2hlbiB0aGUgZHJpdmVyIGlzIHVubG9hZGVkLCB0aGUgcmVzZXQg
bGluZSByZW1haW5zIGluIGl0cyBkZWFzc2VydGVkIHN0YXRlDQpiZWNhdXNlIHRoZXJlIGlzIG5v
IGNsZWFudXAgYWN0aW9uIHRvIHJlLWFzc2VydCBpdC4gVXBvbiByZWxvYWRpbmcsIHRoZSAzMDAN
Cm1pY3Jvc2Vjb25kIHNsZWVwIHdpbGwgb2NjdXIgd2hpbGUgdGhlIHBpbiBpcyBhbHJlYWR5IGRl
YXNzZXJ0ZWQsIG1lYW5pbmcNCnRoZSBoYXJkd2FyZSBtaWdodCBub3QgcmVjZWl2ZSB0aGUgcmVx
dWlyZWQgcmVzZXQgcHVsc2UuDQpTaG91bGQgcmVzZXRfY29udHJvbF9hc3NlcnQoKSBiZSBjYWxs
ZWQgZXhwbGljaXRseSBwcmlvciB0byB0aGUgZGVsYXk/Ig0KDQpWYWxpZC4gcmVzZXRfY29udHJv
bF9wdXQoKSBkb2VzIG5vdCByZS1hc3NlcnQgdGhlIGxpbmUgYXQgdW5sb2FkLCBzbw0Kb24gcmVs
b2FkIHRoZSBwaW4gaXMgYWxyZWFkeSBkZWFzc2VydGVkIHdoZW4gd2UgZW50ZXIgdGhlIDMwMCDC
tXMgc2xlZXAuDQpBZGRpbmcgcmVzZXRfY29udHJvbF9hc3NlcnQocnN0KSBiZWZvcmUgZnNsZWVw
KDMwMCkgdG8gZ3VhcmFudGVlIGEgcHJvcGVyDQpyZXNldCBwdWxzZSBvbiBldmVyeSBwcm9iZSBp
bmNsdWRpbmcgcmVsb2Fkcy4NCg0KPiArCX0NCj4gKw0KDQouLi4NCg0KPiArDQo+ICsJc3QgPSBp
aW9fcHJpdihpbmRpb19kZXYpOw0KPiArCXN0LT5pbmZvID0gc3BpX2dldF9kZXZpY2VfbWF0Y2hf
ZGF0YShzcGkpOw0KDQoiSXMgaXQgcG9zc2libGUgZm9yIHN0LT5pbmZvIHRvIGJlIE5VTEwgaGVy
ZT8NCklmIHRoZSBkcml2ZXIgaXMgbWFudWFsbHkgYm91bmQgdG8gYSBkZXZpY2Ugd2l0aCBhIG5v
bi1tYXRjaGluZyBuYW1lIHVzaW5nDQp0aGUgc3lzZnMgYmluZCBpbnRlcmZhY2UgaW4gY29tYmlu
YXRpb24gd2l0aCBkcml2ZXJfb3ZlcnJpZGUsDQpzcGlfZ2V0X2RldmljZV9tYXRjaF9kYXRhKCkg
Y291bGQgcmV0dXJuIE5VTEwsIHdoaWNoIHdvdWxkIGNhdXNlIGEgTlVMTA0KcG9pbnRlciBkZXJl
ZmVyZW5jZSBsYXRlciBpbiB0aGUgcHJvYmUgc2VxdWVuY2UuIg0KDQpBZ3JlZWQsIHdpbGwgYWRk
IHRoZSBOVUxMIGNoZWNrIHdpdGggLUVOT0RFViBpbW1lZGlhdGVseSBhZnRlcg0Kc3BpX2dldF9k
ZXZpY2VfbWF0Y2hfZGF0YSgpLg0KDQo+ICsNCj4gKwlyZXQgPSBkZXZtX211dGV4X2luaXQoZGV2
LCAmc3QtPmxvY2spOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQoNCg==

