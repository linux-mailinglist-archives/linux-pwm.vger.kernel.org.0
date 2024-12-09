Return-Path: <linux-pwm+bounces-4295-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D89E98E8
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 15:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10AF283062
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E335972;
	Mon,  9 Dec 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XR9Aqe33"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81281233158;
	Mon,  9 Dec 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754658; cv=fail; b=taNaTQ2puhAV23TDSefKKDjuB6mExSCMqVSnK6jwsN3nU7I5TO0A20N1/3rNv/GhU3Fe+C3sUXKDa5Kmfn/GInhT99qe1ONbH6NevuOsME+x+2R/t83UAc6r8gLOrtif07qxMXOdWBw+uoOO5G8KF6iA2Hg1gwJT8chxTkikPg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754658; c=relaxed/simple;
	bh=kHwryx2Sb4rXpm5ZjMWkZ14rVoHOlCz2E/lf2F5UGvU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RwDA6LeVKxW5UK+Tz7cGJK4XvhsCzFdeHChIvqL5VoPvhrtZ+zNyyyvvAPmZyn/W8uWSQvQ/RnmwXpK2je5Prl6+nKDhIQZ9LPM1wShanYVqdamuxSBesP9zeTQgharyeB58yIGEpbcTAXMrJ+Sb3AmJSJlY0XxSuo6PK3yAT24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XR9Aqe33; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B98En005728;
	Mon, 9 Dec 2024 08:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kHwry
	x2Sb4rXpm5ZjMWkZ14rVoHOlCz2E/lf2F5UGvU=; b=XR9Aqe33ave6SWEO+LfQ1
	qT34MLGDvNAeCwzgyu0NYm+CurFVFGyCg2/CtLN7h3z0612BCy7vnZM4aRM2XdhV
	CAU9pdtHfjVY7a7KF/ezfLx3lmOZ7FX4B/6Ck77XfoJRXejW/4+xrprsevVngR4h
	1JzyffNwn64S2Tng+p0Iv9lwdNl8KXoXtSv3f7Il0MG2HJrZwF2+W6KYTNH6Kh8p
	L86wgDRySrjeYX1yfljg49I1qQWeSfjXOQZQJIQYp10QQbRhNLG5h7+nBpQPFDm4
	/2311KFhDdStRzVqschS6GVxTq2ZkSo70r7W7gPSUNTmr5g9UOnB90Mkee64PqDq
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43dye2gmsc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:59:00 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3D+1j8I1XYHgyxknM8pF69VeRugfca6XmuvKaKPWtMqGNhMBfSvPoUGH9eQ+ymM4KnDoE+CTPTFPaeFrJre5wOp4PqqerZoBEKvMcKG0c4T9+Pp91T400wrIToVI/L1gsfkATOLI2Ba2nYAMId6bCG20qJfR29EudZPbLRi8om3Ep07zENU+UURreMQecxOMq7mGlNwPJNMV1uZCYv5izoT03fTVCeGxugWETGV1JTrMTuZ4xC4HAJFKTnWPqViXxl6IlWzjzMby1PeIJJbQAXHQJtNWh7MRppQhVyKQq/C5lRlrsXJa+X6Jb6pBpg/CLXWF9+4V0BTKbEJ3mrc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHwryx2Sb4rXpm5ZjMWkZ14rVoHOlCz2E/lf2F5UGvU=;
 b=qan6zyw+VwrFo7cygwzQfEmNdpRsq0C0Y3DIn7iHucuj85uEpH//5Pbnru6JzN1WRnFS92S4USScRRIOzkGDTv4AIpZHdtiktrgO8tbVjyUbKtmomPmbH5NsYCldoLFxNmGaDLXJvSrIp8SX96SbwayhYZeJlnp3tPIhxbGBudDd6mr+OrG/LiTuXjsS6DLlOtFyfnZv4AizPSwae/RX0xIE+bh27McuHum/EHQo41B7iczPmi9tzNlD8wmw0rPalaXheuf0KGSz+wLXTw3QIrUr6ZEqFNk9NO/NSWyqvpfRDsG2aucmbQ7O0r3mtxW8jx4uLvLFmccjXx5GdnAFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5114.namprd03.prod.outlook.com (2603:10b6:5:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Mon, 9 Dec
 2024 13:58:57 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.8137.018; Mon, 9 Dec 2024
 13:58:57 +0000
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
Subject: RE: [PATCH v7 5/8] iio: adc: adi-axi-adc: set data format
Thread-Topic: [PATCH v7 5/8] iio: adc: adi-axi-adc: set data format
Thread-Index: AQHbQnRxa+982wbDVEKS92ZWCyQFlrLW2R8AgAcl/yA=
Date: Mon, 9 Dec 2024 13:58:57 +0000
Message-ID:
 <CY4PR03MB3399749EAF99EB164A96CBD09B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-6-antoniu.miclaus@analog.com>
 <7caec777-e234-4bd7-872f-4a5d5dd32fc0@baylibre.com>
In-Reply-To: <7caec777-e234-4bd7-872f-4a5d5dd32fc0@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFpT1dNNU9HVmhOUzFpTmpNMUxURXhaV1l0WVdabVpDMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWWpsak9UaGxZVGN0WWpZek5TMHhN?=
 =?utf-8?B?V1ZtTFdGbVptUXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBOell4SWlCMFBTSXhNek0zT0RJeU5qTXpORGcyTXpZM05qY2lJR2c5SW01?=
 =?utf-8?B?T1QydElVbmsyYVhnclpVMXJNM2xTYlc4MmFqTldlbmc1WnowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW1aeVExSTRVV3R5WWtGbVZrTkxMM2xoVG1ZME56?=
 =?utf-8?B?bFZTWEl2U204eEwycHpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM6PR03MB5114:EE_
x-ms-office365-filtering-correlation-id: 5accf9d1-ded3-402a-fca1-08dd1859a037
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUFmWXl1b0kzV2pMeXNhbkU0bXAyTGdYajZaWjIzZDFiTS9yMGF5Wkw2WUY3?=
 =?utf-8?B?bFJuSkhEWEM1TGRyQ1VtT0d2Y2pBTWJZb1R6eTcyaXRxVHA2aisrU011ZWFo?=
 =?utf-8?B?RWpEYm1TdjJkMGJNUFpXRm0yUHIwUy9aaG9BZm1pZ28zSk9hTHNUVHNTMlZK?=
 =?utf-8?B?QlBValRTTW5SdjlSTXk5ZUtzRzZyT1VoMnBPcWRyNGR6QnlmZUExdFNCZW9p?=
 =?utf-8?B?STFWME1lNjl3ZmROSEI2ZHcrd0xlNUszMTErTjZQZ3FrQzZ0YjRBcUdJMStE?=
 =?utf-8?B?a2IybTNGa3JWZGxtK0R1RitiUmVnbTJwdkNwdjNHQ3ZGa3ZXd0VaVnR2YUZU?=
 =?utf-8?B?RkdKMVRuSk12M0gycDZCWjFVUm9xS08yVytFMWt1blAyUytxYzVuZFU5bUJP?=
 =?utf-8?B?MnZ1NFgwRk40WVFxK3ZnMTlTYXh3NGJYYlVuc3pvYTNnelNWT3lLZUJ6NFdK?=
 =?utf-8?B?QWtOd1B3a3dKMG5kMEpVMjVrTTNyclBUeEs2WFhSY3pXMlRqb01oTzNFN0pk?=
 =?utf-8?B?ekUvL0pva010OVhJZFJYNVI3aG4zM0x6NnpQOVdNdmRFWlVmN0FkMzZCNzJI?=
 =?utf-8?B?N2NHalE1elBYU3dPSlJtT1hZcnMwZWVGNFczUlV5aWU5aUVLWlE2dGQyR3BF?=
 =?utf-8?B?S1BBbEg4Z0hjeWwvYWRWc05DdmlrUCtZRk9oaVdEMGMrc1RRd1p3dlpWSGJ3?=
 =?utf-8?B?L1ViWEVpOStVMnc2Z3RGc2dmdzlOeWZjVnZNWmVEbEQrai9lQ0NURHlpaTFa?=
 =?utf-8?B?UUx1RHRBNUVpdU1qeW8ybXRGcnllRS80YXh0TnltTW9hSkZrb1EwNUdZU2VB?=
 =?utf-8?B?QkFaaGJ3dk4rWktmcWQxcE1LQzhXMjJzUjd0dmFZOWhUZVdzNjZCK2lJWmFm?=
 =?utf-8?B?MEMyVlM4bmozZ2RWVnZIZGFBbnMvM2hDQ0VVeVdMeHNtVFJMUG85Z2hxL2JQ?=
 =?utf-8?B?TjhFbUZVQS9nSTVRTDllSm16UkFaaVlQM2dzbWV1TjVSa2ljdDFXKzVsa2dW?=
 =?utf-8?B?WFdpMG5sV1NCcDZHZHY0eTgzVndGK0V6KzZ2VzlmK3E5TzFjRGU3SVloRTV0?=
 =?utf-8?B?RDdoUjhYN01rWW1wQlRqcU5PSWhXYTloQWpJS1gvWjhabWR1aENGT3l2dDNu?=
 =?utf-8?B?YlhZa1FTRkt1bjRCVHlIRnhRMEpFYlFkZU1PbjlIdHpZSHl0RFdxMUVScWJt?=
 =?utf-8?B?MnlDSjR0OTJXL283emdnV0JqZmgvTklrSE9xZkh0ZXJnYkM5UEFvclZFeXJr?=
 =?utf-8?B?YWpEQ2NiNkx6WkJCUy9SMmNIdHl1dkdpYmtHSXV1ZjU1Q0tHRnYzUnpyaFpr?=
 =?utf-8?B?cTNQenBpRzJySmFIa2RPSE52S2FNMmdxMURsSm45SGgzVWR6cS9NRlAvSDF4?=
 =?utf-8?B?STV4cnN4VGpkdVl1SS83U3FGbXQwOWdRa1l0bVc5bmFOSzJJLzhvbHI1VUVr?=
 =?utf-8?B?TVFpQlA0Qk5LMzlmRnVpNEwxNU5Ec1dza0NoMjgzODBrVEpoZnh6Y3g5ZDlN?=
 =?utf-8?B?d2pwbEx6QUVERFppaW4ybFdsS0lwWTVBVkZGOFBIOC8xcDdpa01GZWI3czVS?=
 =?utf-8?B?VHZLR2xVWG5GM283RStYZFcrdmMydzBkNkwrWGlmbCt5RytHb29rSVNxYkdk?=
 =?utf-8?B?VWFJcExTMnUvejJoKzgrc1hKS2hQckVxaE45Q2xaVFQwQWFubjM4V1Z0K0kz?=
 =?utf-8?B?UnZJT2JmVXRoZ2JTWmtZcU1qVElIcDRtaXFFdEFrQkYvNjRvdjhzSUNwTjc4?=
 =?utf-8?B?aXVhZktpajh2eTJHaHVEL1JhbEt2Q1RhYlZWQkxtQzZaSDV5OWJtbnZRNXF3?=
 =?utf-8?B?UzJ1WmZPM0ZHYzc4bzdaUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm9XSWY3bmcxckt0UTNUVmNVeHhmamNhOWpKWStjOE9MNHhlYjFIbk1pcXBO?=
 =?utf-8?B?MFFGb0FWc2I0ek1jNndoT0RFL09GMmpxaGtiVzFqWCsyN0J2UE5XcmhxS3Ru?=
 =?utf-8?B?TDZyVitLVHVwMzJocklORitNM1REN3ZTdTVnbzFIZU50dk5YZVllOW1ibnpw?=
 =?utf-8?B?d2RXYWphdHhML0x5YldQL3AzNmxmNmdTRnJibkdLTkl1VmYrQ0R0dmRsSjFS?=
 =?utf-8?B?cXIzNXNrYzZ6ME9CYWdkQ2N4OUhJV1FjcHBJcTF4VmRGbUZlRVkwMEJwOFZI?=
 =?utf-8?B?ZHh1eVdaOEp3N0VQL1JmUUR0YjJ1aFpNd3hzdUQxdUE2YXVKRWlMTld3em5W?=
 =?utf-8?B?alY1NEwzU1hsQkZ1WWNmZ0VwN1p5TUlZMGRSV3p6RmhXZkVVM0UxQ1puVkNH?=
 =?utf-8?B?QVpOQ1FZRFFhbFZwOUNOcHk0NmZqOTNCdzhSWjd0ZGx2TkZMT3o5cjl4dXlD?=
 =?utf-8?B?SGduVWorV0s1SW9ERS93a0xkOUhwMXlXejMxK2ZXbWhTN09FS1NtNHBIVmVm?=
 =?utf-8?B?NUlRakw4dGRuK0o0bDNadkJPSWlxRVlmY0s2TGw4NTZsUnBtUWd1cnhYUnpu?=
 =?utf-8?B?dy9kRzRnN1VzUHBPdTluSGRaUWtkdGxNMnZUd3ArSWc4MkZZaFZiMTg3Nk10?=
 =?utf-8?B?U1RuU1VVWkVmS1BKdDUvYlpVZExGNWgwSXg4SURNMm43TmQ5aFVnSzNlVUVt?=
 =?utf-8?B?VHp1QmRSRlJIZ3hqa0g3b1lxdm9YcHQ0RUFWS0U2eWo1QW02aE1tYTVlQmND?=
 =?utf-8?B?ZDc0ajloRXFya3RBdE1YYmRBTXhnV2c4TU9yOEljcXk3bVh0Y2xzbWdlQmVI?=
 =?utf-8?B?Z2pEbkVOUkxibWhKWTRjTUVFRFhWOStiUXpKbUJZR3BwaEtYV2xZOEdMb3Zr?=
 =?utf-8?B?dTdhclpYakV1ZEpQandHNGhwUXJ0T2V6bzdpTzdYeU0yWkVXL1l2TnhxajRJ?=
 =?utf-8?B?cjNNdGNKNnQxRkJuNnZYNG9TVXJROFFwY0xZOGE1WDJLdWhnd3BzelQwdEFQ?=
 =?utf-8?B?MVh1UWxRNWxFckZVTFh6YVRhZW43R1N5OUIvR3ljT0djOHlYS3BzME1EOFNy?=
 =?utf-8?B?ckFOU29OZW9PaFVPem4zZWtySXpUUk5mZE5scGhoVVlkMnppeTY2amVOVjhx?=
 =?utf-8?B?UnU3MjJlTXJSNE9Mb1FoNDZpOFJOMEhsWExycFFLUEkwU2lEN2hISVdPRnNi?=
 =?utf-8?B?UkRyaHNMSUw0djRYQjJYVW5uUmVQRWMxN2xyNnZrZTA2R21Vb29mMXJxMDZD?=
 =?utf-8?B?b0owQk5OL04vLzNaUTZobjBVbnhCRFA3Q0l5NG0yMFhCUENtSHc1TVY0b1Ri?=
 =?utf-8?B?VFBJN3NYOXRHanVaOUFtQlRZY1lDbFVLUFl2Q2JXTFcxNW5DVGZ1ekdUdUx3?=
 =?utf-8?B?L243dTcvT2JMa05IOHVVZms3eFR4L2pieFZqd3EySzVXL0hMTGNLUFRiRzU2?=
 =?utf-8?B?aUMxa0J3U21YUHh2RU9EaU1WMFFhSkpwSWtzemV5NnMrTzRoMmVZWWlrKzBr?=
 =?utf-8?B?R2RsRkFGelhUWEU5TkcwTHgrQTZiNEJCTEdUcFNxZHVrL3V2ZVg0a0UxSUhF?=
 =?utf-8?B?aGovWisvUEZKb1Juc05rcUMvLzdIVWZPQ2pnaEViY0E0Slh4VDBXSVlpcDNT?=
 =?utf-8?B?RkQ2cmR0alIvVjhBZVpTbFJZaEVsaHJia1h2ejdFY0MvRmZmWWxmMk10U2dX?=
 =?utf-8?B?UlVVcnZDTUI5MUpENkxuaDRQT0dkYVo1cU41ejA5R1dkaE4vOTBIQm13aStM?=
 =?utf-8?B?UVQ3d0IyNjhFRjJEc2t1Y3gxS2VyMDR4N0U3SVdLNGp3TS9YTTF5MG16U1hO?=
 =?utf-8?B?anJoVEpEVi9od09JZDUydUgvdTlxdU9jZ0NUUGJNREtiMGNsaVY1dU92U3FP?=
 =?utf-8?B?aHhpR0xvOGlXZkc4RzMyRkI3Y3NRUk13WGZLb1UzY0QrS2NJYUV4clZmVmZF?=
 =?utf-8?B?NnhOTExNSFZ0M2t2UGtVcHU5MzdjTlBTbUJwbmk3d2Rxc0x2SlNzVlc2M3VU?=
 =?utf-8?B?amxSR2o5ZHhvVlVneXBOWHB6dU9meVRqcVBtYTlueVpBYS9DaHRsNmwzTVFJ?=
 =?utf-8?B?eGdIakZzOHJnL1hFdzdpV1p4aWxMTFVCYlM5QkRjL1A0RzV1ZS92QWVpMFlp?=
 =?utf-8?B?VlZXYnJzS3d3NEwzTm1CQ0txYzJhRGYwSTRqbjJmLy9CSEV0TG4za0Uya3Rj?=
 =?utf-8?B?amc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5accf9d1-ded3-402a-fca1-08dd1859a037
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 13:58:57.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiFwTGXGR3mESlYfpcmDsZjPQX4TXcxUIgIM6/jxTB1FlkniZd/58RIcV5pgOI35Mki6+2lLWDoNkpCil3er9MiQcQLJU9QX0Qdt4IBnh+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5114
X-Proofpoint-GUID: wp9MiU9JQvm5q425ZV09bCKLSvRpc6sB
X-Proofpoint-ORIG-GUID: wp9MiU9JQvm5q425ZV09bCKLSvRpc6sB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090109

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIERlY2VtYmVyIDUsIDIwMjQgMjo0NiBBTQ0KPiBUbzogTWljbGF1cywgQW50b25p
dSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiByb2Jo
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDUvOF0gaWlvOiBhZGM6IGFkaS1heGktYWRjOiBzZXQgZGF0YSBmb3JtYXQNCj4gDQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDExLzI5LzI0IDk6MzUgQU0sIEFudG9uaXUgTWljbGF1cyB3
cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3Igc2VsZWN0aW5nIHRoZSBkYXRhIGZvcm1hdCB3aXRo
aW4gdGhlIEFYSSBBREMgaXAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbml1IE1pY2xh
dXMgPGFudG9uaXUubWljbGF1c0BhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgaW4g
djc6DQo+ID4gIC0gYWRkIGJhY2sgMTYtYml0IGNhc2UNCj4gPiAgZHJpdmVycy9paW8vYWRjL2Fk
aS1heGktYWRjLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2FkaS1heGktYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMu
Yw0KPiA+IGluZGV4IGY2NDc1YmM5Mzc5Ni4uY2IzYjgyOTlhNjVlIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaWlvL2FkYy9hZGktYXhpLWFkYy5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2FkaS1heGktYWRjLmMNCj4gPiBAQCAtNDUsNiArNDUsMTIgQEANCj4gPiAgI2RlZmluZSBBRElf
QVhJX0FEQ19SRUdfQ1RSTAkJCTB4MDA0NA0KPiA+ICAjZGVmaW5lICAgIEFESV9BWElfQURDX0NU
UkxfRERSX0VER0VTRUxfTUFTSwlCSVQoMSkNCj4gPg0KPiA+ICsjZGVmaW5lIEFESV9BWElfQURD
X1JFR19DTlRSTF8zCQkJMHgwMDRjDQo+ID4gKyNkZWZpbmUgICBBRDQ4NVhfQ05UUkxfM19DVVNU
T01fQ1RSTF9QQUNLRVRfRk9STUFUX01TSw0KPiAJR0VOTUFTSygxLCAwKQ0KPiA+ICsjZGVmaW5l
ICAgQUQ0ODVYX1BBQ0tFVF9GT1JNQVRfMjBCSVQJCTB4MA0KPiA+ICsjZGVmaW5lICAgQUQ0ODVY
X1BBQ0tFVF9GT1JNQVRfMjRCSVQJCTB4MQ0KPiA+ICsjZGVmaW5lICAgQUQ0ODVYX1BBQ0tFVF9G
T1JNQVRfMzJCSVQJCTB4Mg0KPiA+ICsNCj4gPiAgI2RlZmluZSBBRElfQVhJX0FEQ19SRUdfRFJQ
X1NUQVRVUwkJMHgwMDc0DQo+ID4gICNkZWZpbmUgICBBRElfQVhJX0FEQ19EUlBfTE9DS0VECQlC
SVQoMTcpDQo+ID4NCj4gPiBAQCAtMzEyLDYgKzMxOCwzMCBAQCBzdGF0aWMgaW50IGF4aV9hZGNf
aW50ZXJmYWNlX3R5cGVfZ2V0KHN0cnVjdA0KPiBpaW9fYmFja2VuZCAqYmFjaywNCj4gPiAgCXJl
dHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBheGlfYWRjX2RhdGFfc2l6ZV9z
ZXQoc3RydWN0IGlpb19iYWNrZW5kICpiYWNrLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gPiArew0K
PiA+ICsJc3RydWN0IGFkaV9heGlfYWRjX3N0YXRlICpzdCA9IGlpb19iYWNrZW5kX2dldF9wcml2
KGJhY2spOw0KPiA+ICsJdW5zaWduZWQgaW50IHZhbDsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKHNp
emUpIHsNCj4gDQo+IFRoaXMgY291bGQgdXNlIHNvbWUgZXhwbGFuYXRpb24gdGhhdCB0aGVyZSBh
cmUgdHdvIGRpZmZlcmVudCB2YXJpYW50cyBvZiB0aGUNCj4gQVhJIEFENDg1WCBJUCBibG9jaywg
YSAxNi1iaXQgYW5kIGEgMjAtYml0IHZhcmlhbnQuIFNvIDB4MA0KPiAoQUQ0ODVYX1BBQ0tFVF9G
T1JNQVRfMjBCSVQpDQo+IGlzIHJlYWxseSAxNi1iaXQgb24gdGhlIDE2LWJpdCB2YXJpYW50IG9m
IHRoZSBJUCBibG9jay4NCj4gDQo+ID4gKwljYXNlIDE2Og0KPiA+ICsJY2FzZSAyMDoNCj4gPiAr
CQl2YWwgPSBBRDQ4NVhfUEFDS0VUX0ZPUk1BVF8yMEJJVDsNCj4gPiArCQlicmVhazsNCj4gPiAr
CWNhc2UgMjQ6DQo+ID4gKwkJdmFsID0gQUQ0ODVYX1BBQ0tFVF9GT1JNQVRfMjRCSVQ7DQo+ID4g
KwkJYnJlYWs7DQo+ID4gKwljYXNlIDMyOg0KPiA+ICsJCXZhbCA9IEFENDg1WF9QQUNLRVRfRk9S
TUFUXzMyQklUOw0KPiANCj4gQUZBSUNULCB0ZWNobmljYWxseSAweDIgKEFENDg1WF9QQUNLRVRf
Rk9STUFUXzMyQklUKSBpcyBub3QgdmFsaWQgb24NCj4gdGhlIDE2LWJpdCB2YXJpYW50IG9mIHRo
ZSBJUCBibG9jaywgc28gd2Ugc2hvdWxkIGV4cGxhaW4gd2h5IGl0IGlzDQo+IHNhZmUgdG8gYWxs
b3cgdGhpcyBpbnN0ZWFkIG9mIHJldHVybmluZyBlcnJvciBpbiB0aGF0IGNhc2UuDQo+IA0KPiBP
ciB3ZSBjb3VsZCBzb2x2ZSBib3RoIGlzc3VlcyBieSBqdXN0IGNyZWF0ZSB0d28gc2VwYXJhdGUg
ZnVuY3Rpb25zLg0KDQpJIHdpbGwgZ28gZm9yIHRoZSBmaXJzdCBzdWdnZXN0aW9uIHlvdSBtYWRl
OiB0byBleHBsYWluIHRoZSBkaWZmZXJlbnQgdmFyaWFudHMgaW5saW5lLg0KDQo+ID4gKwkJYnJl
YWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJlZ21hcCwNCj4gQURJX0FY
SV9BRENfUkVHX0NOVFJMXzMsDQo+ID4gKw0KPiBBRDQ4NVhfQ05UUkxfM19DVVNUT01fQ1RSTF9Q
QUNLRVRfRk9STUFUX01TSywgdmFsKTsNCj4gDQo+IFRvIGJlIGNvbnNpc3RlbnQsIHdvdWxkIGJl
IG5pY2UgdG8gdXNlIEZJRUxEX1BSRVAoKSB3aXRoIHZhbC4NCj4gDQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyBzdHJ1Y3QgaWlvX2J1ZmZlciAqYXhpX2FkY19yZXF1ZXN0X2J1ZmZlcihzdHJ1
Y3QgaWlvX2JhY2tlbmQgKmJhY2ssDQo+ID4gIAkJCQkJCSBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9f
ZGV2KQ0KPiA+ICB7DQo+ID4gQEAgLTM2MCw2ICszOTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGlpb19iYWNrZW5kX29wcyBhZGlfYXhpX2FkY19vcHMNCj4gPSB7DQo+ID4gIAkudGVzdF9wYXR0
ZXJuX3NldCA9IGF4aV9hZGNfdGVzdF9wYXR0ZXJuX3NldCwNCj4gPiAgCS5jaGFuX3N0YXR1cyA9
IGF4aV9hZGNfY2hhbl9zdGF0dXMsDQo+ID4gIAkuaW50ZXJmYWNlX3R5cGVfZ2V0ID0gYXhpX2Fk
Y19pbnRlcmZhY2VfdHlwZV9nZXQsDQo+ID4gKwkuZGF0YV9zaXplX3NldCA9IGF4aV9hZGNfZGF0
YV9zaXplX3NldCwNCj4gDQo+IEFzIG1lbnRpb25lZCBiZWZvcmUsIHRoaXMgY2FsbGJhY2sgaXMg
c3BlY2lmaWNhbGx5IGZvciB0aGUgQVhJIEFENDg1WCB2ZXJzaW9uDQo+IG9mIHRoZSBJUCBibG9j
ayBhbmQgZG9lc24ndCBhcHBseSB0byB0aGUgZ2VuZXJpYyBiYXNlIEFYSSBBREMgSVAgYmxvY2su
DQo+IA0KPiBbMV0gYW5kIFsyXSBhcmUgYWRkaW5nIERUIGNvbXBhdGlibGUgYW5kIGxvb2t1cCB0
YWJsZSB0byBoYW5kbGUgYSBkaWZmZXJlbnQNCj4gQVhJIEFEQyB2YXJpYW50LiBTbyB3ZSBjb3Vs
ZCBidWlsZCBvbiB0b3Agb2YgdGhhdCB0byBhZGQgdGhlIHZhcmlhbnRzIGZvcg0KPiBBWEkgQUQ0
ODVYLiBXZSBjb3VsZCBhZGQgdHdvIGNvbXBhdGlibGUgc3RyaW5ncywgb25lIGZvciB0aGUgMTYt
Yml0IHZlcnNpb24NCj4gYW5kIG9uZSBmb3IgdGhlIDIwLWJpdCB2ZXJzaW9uIHdoaWNoIHdvdWxk
IGFsbG93IHVzIHRvIGhhdmUgc2VwYXJhdGUgY2FsbGJhY2sNCj4gZnVuY3Rpb25zIGFzIHN1Z2dl
c3RlZCBhYm92ZS4NCj4gDQo+IFsxXTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiBpaW8vMjAyNDExMjEtYWQ3NjA2X2FkZF9paW9f
YmFja2VuZF9zb2Z0d2FyZV9tb2RlLXYxLTItDQo+IDhhNjkzYTVlM2ZhOUBiYXlsaWJyZS5jb20v
X187ISFBM05pOENTMHkyWSE0MHhhVjJrd3Y5R0ZuaDF4TFBHUHcNCj4gR2Q0bkZ3N242ZHpqNFZq
bzlKVEhYMVNBR044QS1WbFdtZ3ZWeW43QnEtDQo+IFdLbEpfZHlGYk9FcU5qYV92YnF3SHlDYyQN
Cj4gWzJdOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtDQo+IGlpby8yMDI0MTEyMS1hZDc2MDZfYWRkX2lpb19iYWNrZW5kX3NvZnR3YXJl
X21vZGUtdjEtNi0NCj4gOGE2OTNhNWUzZmE5QGJheWxpYnJlLmNvbS9fXzshIUEzTmk4Q1MweTJZ
ITQweGFWMmt3djlHRm5oMXhMUEdQdw0KPiBHZDRuRnc3bjZkemo0VmpvOUpUSFgxU0FHTjhBLVZs
V21ndlZ5bjdCcS0NCj4gV0tsSl9keUZiT0VxTmphX3ZpZFA5ZnNRJA0KPiANCj4gPiAgCS5kZWJ1
Z2ZzX3JlZ19hY2Nlc3MgPSBpaW9fYmFja2VuZF9kZWJ1Z2ZzX3B0cihheGlfYWRjX3JlZ19hY2Nl
c3MpLA0KPiA+ICAJLmRlYnVnZnNfcHJpbnRfY2hhbl9zdGF0dXMgPQ0KPiBpaW9fYmFja2VuZF9k
ZWJ1Z2ZzX3B0cihheGlfYWRjX2RlYnVnZnNfcHJpbnRfY2hhbl9zdGF0dXMpLA0KPiA+ICB9Ow0K
DQo=

