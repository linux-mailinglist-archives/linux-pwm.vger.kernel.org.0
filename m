Return-Path: <linux-pwm+bounces-4800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33FA2A570
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 11:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235F63A78EC
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF19226882;
	Thu,  6 Feb 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xEV6CPpZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4652248A1;
	Thu,  6 Feb 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836049; cv=fail; b=AjSIXCKbU9C4KPGbloVvHJ93ryeWJDUbcFU3SihUk6982e1YZ9wg2KmLCTxOQrK3M3bA+AkYpZ1YWCAZtzs/bPBMLgGkTEdfIhyt37HpMAywMnjwOB8nyBdUoIEB51//QjT8dZJZND9Rf75nrk0zytnCkcu9E/+Fns7gpQn4MSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836049; c=relaxed/simple;
	bh=poRfo9iBwzf9RBjNum0RkEGe6IDrsyhB5VCkFQ7tBHI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czeCInAtYJiiy8Vh/JZQfJC5H5acfURC9glwxOi7vLTAD1rBbockRj/rxg2cnEWNcwwZHa+J7oBkHljCCuhf7C7NnPqA823spBgFxOLPlPf8sD8U0g3SIBpJ6iokX68TlOW/Bdtxy69RHyKA/OBb7OhnHnyxamxbhug2p7p0UW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xEV6CPpZ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5169e1Dq014753;
	Thu, 6 Feb 2025 05:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=poRfo
	9iBwzf9RBjNum0RkEGe6IDrsyhB5VCkFQ7tBHI=; b=xEV6CPpZYIVCk9dZGeCFM
	mQMONqCnNE9ns+qnXAYFFr/oDlBDYTtjfTHMdoRJScwlp8wQVAetO+BmC5bTeyXl
	ayuIKRzZ73rtd5SAZS2tliU8wLLaX1ropnyUUkogaGimn9QI/Ypva6yEgu7wW1I+
	rJrb4Kr5Dps5I++rPYn7KIdSg1POigLkMCf7Lkq8Sw4WK4WpC5VdParh82SvWpOn
	ACylYNNGaLhsOf6iKh3PENoSpq9VUTeoYiNVmICty6+IeX+boQPs0CXqjdK3RW8i
	5EsMuUJVL4lB1PImcidpSUNST/BP0vpk30rMi3nyLldIYSqpKTt0VAQi1uXIxELl
	g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44mtnb028h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 05:00:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF7onXeDOtwRDirmDtOOXAh+q60Bs0ex1PZz8bcSEf800G2x1IIUyoXnV3/buGWA52Qig7NJgJy1ozhe3HvHneSI1nK8dRaSMPwA/qVtzwZ6NsR5n0yuIDred+N4zqJvS2lAaL6VroGTpQ15Tx7y0sew4hJfM3YBId1gR1O4t2QGiVEs7v27sv3AcwT39xfrKvVZbC8J7ZX99yikfISUkUkeBDI9nUjW+8qyJTm2qU5MC6kE9307G9uQOqF0vwGlmnY1skIqInhQZ/ebAufszQBMi0c7KAgEDkFE1vQ20VCZeXZFAgGW++9Vwl88qyFZOQ47DBerRDe6RoOA8RR1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poRfo9iBwzf9RBjNum0RkEGe6IDrsyhB5VCkFQ7tBHI=;
 b=iNO9nlke/HzeJkHKZkOPSAFsv55Xh3A+5BnUD/Hwo8ePIeYjZFOUBgWe8wPri2NHz45MjCQsnHnt6bWE5riWUNh0SWhheNl4/eBymbZHgHDACZ+3zmAF7Jted5nAEFqjLISDbnYstid5sbSBJcBDRLjdnl9XLsfpPkEpBGjkm2T9FEkxb6sy4OcXqTXmLedEIA5ieoOkYfE+Tq9d3gpJv777kvWCyCNTGTYO6O52NknA68+lQKfBODBod9+ZsZjbItaM1M6yWZsxQc8GgiJbgNKOCuGS5JEsKhb1XilPw4cOG5gU/19WwdLPeIaYuxK3DhPdAmlP5HF4/LddttdLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BL4PR03MB8073.namprd03.prod.outlook.com (2603:10b6:208:591::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 10:00:42 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%3]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 10:00:42 +0000
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
Subject: RE: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
Thread-Topic: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
Thread-Index: AQHbcKpV+m8nOqKDHE2jZfQS3EayZbM2OGEAgAPhzCA=
Date: Thu, 6 Feb 2025 10:00:42 +0000
Message-ID:
 <CY4PR03MB3399B389972E92742EA3060D9BF62@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-9-antoniu.miclaus@analog.com>
 <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
In-Reply-To: <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB6TjJJMU1ERm1ZUzFsTkRjeExURXhaV1l0WWpBeU5pMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTXpkaU5UQXhabU10WlRRM01TMHhN?=
 =?utf-8?B?V1ZtTFdJd01qWXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNell3SWlCMFBTSXhNek00TXpNd09UWXpPVGt4TVRjeU56a2lJR2c5SWpo?=
 =?utf-8?B?VGNVOTBNazFSZDFwaVJYZGhZbFJHV1V4dE5HSkhhV000VlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVOW5RMEZCUkdaWGR5ODJabGhxWWtGWGJHMVRiRVJwYmxWVVpt?=
 =?utf-8?B?RlhXa3RWVDB0a1VrNDRSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVJMFFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlVtWjVlbXRuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWRS?=
 =?utf-8?B?UVdGUlFtWkJTRTFCV2xGQ2RVRklUVUZoVVVJd1FVZHJRV1JuUW14QlJqaEJZ?=
 =?utf-8?B?MEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQlpFRkNjRUZIVlVGalow?=
 =?utf-8?B?RjRRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQklp?=
 =?utf-8?B?OCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BL4PR03MB8073:EE_
x-ms-office365-filtering-correlation-id: a8bfbc10-d908-4713-0900-08dd46951dd4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjFoRjdNaUg5THJMVW9XdC9kelZVeHZZdUVOVGRtTkRQbnlGZVFwazBrRTR1?=
 =?utf-8?B?MmQ2NnRaWFZMZ0pnckFWVndDMjVlajgwdXc0UVBGeWpKV1NVeUY2a21SbnFT?=
 =?utf-8?B?Tm51TU9rSWhET3FDZlkvVDdjQWhydE1RYWlzdGJDYXE4RjBFOVpuZWZYSVRm?=
 =?utf-8?B?WDMyYWgrenZwcGVEVGlmVlZSSG8zVUxkaXVUeFlaMDBacmRtRGxWTHZEUjhq?=
 =?utf-8?B?RVRrMWs5UTR2Yk52SzQyWDBqSlM2bkJnd2VONHhVbG0zZzdpMFRZMVBVNjda?=
 =?utf-8?B?M2VxOS9WL01GaFVNbXFUQkJscXZueEttNjJwL3BnSGt2SS83aFJONWNPdzBI?=
 =?utf-8?B?bGwwd2JKKzZEZFNkWHVUWk5KUmFyWm9EV2lxWEJRVDJWL1FnNys4M2FXcHZz?=
 =?utf-8?B?MENJUUV2RkpjakZlb1hlS20rZUZ5ci9xejJJZVlybjJOdlN3QXRvb1JQc0dl?=
 =?utf-8?B?djZEVEtqNFdxMmZuUmlHVUI2ZWc5ek9IdWVrQmZZc3BMelhXYi9sbGRYc1ZG?=
 =?utf-8?B?ckpKTTFHNi9hblZRSld5TWp6TmtvUU1zbkpPT1FSSVJ0Sk1GWU50UmsvcGpY?=
 =?utf-8?B?WUNhcUpJQm0rM2kwUVhLNFlPMFVyN3ZEQmtndUwvbGlkbkMxUUpzcDB3bVZG?=
 =?utf-8?B?OExFUURGeEN3VFBsT3RRTVJVbG1TaWh1MFFwd29GNk4vSmJvZDExeEttSVhX?=
 =?utf-8?B?RlljbmRlVTd3TzFoQXFQQlFLbnR5bnBqRFRGMVh3NERMdm9MbnFXV0tqbmRV?=
 =?utf-8?B?L1JPMjJZdEpTZ1dOSEkwWXZoaHRrRmZEUzQ3YTVmdytYOStIR0sxOEM5SUpo?=
 =?utf-8?B?dm80MHNmSitGZU5DSVdzVHQ3NDY1aUkvSzQ1Z3VvMERmOG93dWRBZkNPTkhm?=
 =?utf-8?B?bnpkcElDOXV2VTI2dzZUZ1RvWUluek9TTjdhTG8wR0JLK1llbGNLQmk1aVh6?=
 =?utf-8?B?dDM5NzZvRUdaMGxya2Z0Z0JpUkdnaGI3ZHp3Vll0YXlxcFh0RW5XNE9pMGRV?=
 =?utf-8?B?bUJ4SU1lS1NzYjJicThLSm5LNXVWcTZIRjZxZVpVcEtIbEJ0VEJLVWlhbTdV?=
 =?utf-8?B?emdKNURsZkltZWhyQUVMQ29vcVJKRkw5MVVVS3JvcmFvbjhaQlVhdG5wNVJz?=
 =?utf-8?B?UDFubFNQc0tTNk9SekV1UkFVZ1Z4UnNWN3ZVWGdiUS8xVGVvUXFZd29NZWlM?=
 =?utf-8?B?MjVjZ1VDY3JLMmo4OXpKaDZxcThIRXF5eExRNnpLcm1yMERrODFQbDhGZjZ4?=
 =?utf-8?B?UnNCM2xDQ3RNWEVZZERsdElUQUNPRVByN1hYSEc5Qkc5QzZla1M3L3M2ckND?=
 =?utf-8?B?OCtHZExweTRXb1IxZnZ0dzlkTW5PRm4vQkFpbHFRVWUwc1FPbitWeUVVNmkv?=
 =?utf-8?B?YmNuSCtnS0pOSWI5UUtoUE84UlhHMEQwVFBGTWRjQ1cxL01sK0JkMWN0cG5X?=
 =?utf-8?B?aUMvcEF4MHhlRFBiTU5WVVo1Z1FrWEhJQWZsK2RGWnlROG1JY2ZqQkU5bTF2?=
 =?utf-8?B?RCtZbk9uUURjZzNKU2tZTkIxVXpLY1NMZWhnQUVWYWZISXoxL0ZONzB0ckI1?=
 =?utf-8?B?Q2YvWGhaY2ErU1lyQkRLSUpMU1puZmNKYXkzbnZ0TkNrY1dSRjZaQmJ3MEVr?=
 =?utf-8?B?TDF0bkRkWFoyeEQ2SUVxU1FWUmd4elJqTnNGeXRQMWtFbHhSWnQ3Y2pKb0l1?=
 =?utf-8?B?b0N4VGs5andVRk0xSDZpNDVXYy9BbWhNeGowVkZqaHVVdkdLRzZlMjRFRUUz?=
 =?utf-8?B?bGtpQ0xMS1ZtTXJKd0Z1d0hDSUJTZDFDb1VCbUtueW1HMWswdWVmazlMMXB0?=
 =?utf-8?B?aFdobnd5VTFsOVNYcGtseDhZZ3lZWkxGblQ3UVl0Z3NuSFRPUDRLVGd2aW8v?=
 =?utf-8?B?M0RqSjVFZFYrWHdxeFk4Q2hONVVYUTAyTTFJQmxEbUFxTlJJd2hRTHMwK1Z5?=
 =?utf-8?Q?nXvyy4pPDyk9ClCwkvLNvzeSQgo4GbFz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0NPRGc0dkVibEJiMVp3bkNqQlBsOW9kSTFaaHNUU0tvTWs0cEF1bENjVDJ2?=
 =?utf-8?B?eWpzMFZoY0pDM0RXUFo2akhrZVRvVjg3Zk00NnkzY20xNEtmYjdvd3k1ZVlp?=
 =?utf-8?B?Umg5VzRQdEVmbnprUVlycS9mSG9EekdiQ1VibGtSMEJZeWpkOU9DWFh4S05S?=
 =?utf-8?B?eTBjNCswS3M1ZmFpR1BDNUdEQmtqUEVPaC9wQWZDZXdKVFpqQ2lncXhMekNi?=
 =?utf-8?B?TnJMNjl2b0pxRTFIR3FEeFBYeXFVbExaU3pqL04yWDlxWG1wOTFLY1ZyWHU1?=
 =?utf-8?B?ZlpaaHEzZk1rWHRFZkFDcTd2eVcvQkx2ano5bEtseXh0cTRXam9nUFYreVlw?=
 =?utf-8?B?YzNVb281eTFKaWtlYjJid0dzQnBPcTRqdENIY0lsbS9qS3R0K2ozQkZySlhm?=
 =?utf-8?B?N29GaDhyakZEN3ZKbGI5cXlZMWJoZUl1aEZ3TEJ5ckNlaVNlYjZzL3lYa0J2?=
 =?utf-8?B?VXlZZllBZk5Lb25xd0JXaUJTdmhQV3RHbFJYM2h1REpkbVBpOFFQQnhkYTlv?=
 =?utf-8?B?ZFlaVFpuSkFKVXRTc1c5NUJ5Rjh6L0tFQ0NlM3h5Tk91bndBOEVOdHMwSmVN?=
 =?utf-8?B?NTdmRGFqekJWeUJWS05URncrTW1WdFpKOVUvN04ycFBKMkRVVU1aMU9PZmhT?=
 =?utf-8?B?Nk1mMmxkdVUvU2N1MlVVeFNYd2h6emxFczQvT3ZIaElFUTA1SXVqWUpIczJj?=
 =?utf-8?B?c0tDRllsUFRDdnpiN2xuRDBSSG9zcVZtdWd0ZFNjSHVxdUxRaVA4MWdqWXli?=
 =?utf-8?B?Y3kvbU5sckc4TytrTFMzdDBGSlBIdENGclNGM0NlSDZlb0o1NzFIeDduZ0Nt?=
 =?utf-8?B?dzNMM0NTc3JwaDlWM3FpTlFlbTBKNXNLK3RaS0hGc3FYRzVpQVZxVEp0K3Bv?=
 =?utf-8?B?d2lBRWFRbWFqejJtV3NJaUJ3NzJ3UnJtT1VVbnk4bWw5TDF6VSsrRytrdWhz?=
 =?utf-8?B?MkZhcmFrUnVwd0p5K0UzZXhMbzdjblBTR3hIME03Q1M1TVY1aEpFNjFZa1F1?=
 =?utf-8?B?bXdjRGNzOXYrMDQrZkprQXVjNUNIVzdqNmZzNjZHM1dldDNXbnR5SkNxOGgx?=
 =?utf-8?B?aTR3YlZncEY2cHBFVHM2S0pleUNpamlqeDVlengrc1Z2WmtUSWNkNVRtOXcy?=
 =?utf-8?B?UnhpbHBOeWNzUlEvU1hLN1lNaHh0TjNOTXk5UmhIc1pVVUluSUtXYmFSZkUy?=
 =?utf-8?B?NUpNcVpkVHdMSm1mbFNUaW5VUXdxZnZtRWQwZGFYak1CRnBEUjdFS2dVQk51?=
 =?utf-8?B?Zi9GbGdyZmlocGNrOTl4Rm4zL0ZZajdzcXViNzhKaW10d3p5blhjMTZOd0hR?=
 =?utf-8?B?NVhncUNubUJmMnVKK0JmTTdqZHFmb29SeFNPLzgxSUVqK0NadVZLSTQyQjRG?=
 =?utf-8?B?RGhvRElKMzI5Wnh0aUk2NW5MSEN3QXVxcGc3K1J4ZHhhLzAwUDNiVGw1TWJ6?=
 =?utf-8?B?UURPQ2U5NzNtK3E4K0IwdCtWK28wRG9ZUjVpRmR5eW8zTStzeG1tNGVHcExk?=
 =?utf-8?B?RVBOWE1YSGRseVZLcUFHZzhrNXY1V2U5VlRRVGUxQVhHRkZ0azljM1BwUng2?=
 =?utf-8?B?d2dVWno0UUx5U1JmTHdDOVhHbjZQZ1hCSWd1YUh1UTdmaW1UTmNNMkdGWEVT?=
 =?utf-8?B?RGQ1OVZYblExdGdpOHhreHVVS05RU1hYS21hdTZhNms5SnlJdUc4QS9HdlVz?=
 =?utf-8?B?ZjZSYm1ocFdYaHBkMmVoa2llV29nZUlCQ2l6K09JSEdJS0Rubk03U3p6Tm9V?=
 =?utf-8?B?eU9Palo4dXArV1I1dndqWG1LMWxEQVVVV1RnckxQbTgxdDJnMU9oK2g1eTJ0?=
 =?utf-8?B?dXkzRHRvZDFid09QNUJrVzZiVk8vRXozTHlCeEdyMVBlSkhMZmhxQTBhVUJu?=
 =?utf-8?B?cUtRYzVIano2UGo1WkppbEFPWEdscGd3d2s0b3N1bTMwaEdTZ0ZvQmZUVVVq?=
 =?utf-8?B?aW1PaGtYWXgrZE5XWFZEOHJtUllOZVVYTmFvUkRiaXRsVjJGaGFKWHkyRjRr?=
 =?utf-8?B?ZHVaTlprdm1WdE9XSUZsYXYwQnBnQVE3L3MzeThyVi9BUGF1WW5wWkk1Vk1Q?=
 =?utf-8?B?K3VoRU9haFV1czFHamljR1EyODNSRXlxU0N1QWVyaHVlVS8wK1BjbGdnMWNv?=
 =?utf-8?B?bVUzSTVuYkY5NmRQNDNBbmFYc3V6YnNqTWMxN0J6elNRM2U5WWtwZXBJdHhq?=
 =?utf-8?B?aGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bfbc10-d908-4713-0900-08dd46951dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 10:00:42.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXJJLteZ8uwm/b+PN62SAQeivHaUrkZqU7NxVUfAbCCOigN1I9Jlm4G8o6d1V+f/ONHDd4wOReAuGYUaeSfGxY/BgBCAs272wN3mpxj4X9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8073
X-Proofpoint-ORIG-GUID: rfZJYRdjAabHBAvh7yNPHLExQ6SutIcI
X-Authority-Analysis: v=2.4 cv=Fr3//3rq c=1 sm=1 tr=0 ts=67a4884c cx=c_pps a=lNr+GoA8Iy63YGCceF2HJQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=udXclQch7WkA:10
 a=gAnH3GRIAAAA:8 a=Hq6TfkCBG8-G7Rhx6tsA:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: rfZJYRdjAabHBAvh7yNPHLExQ6SutIcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060082

PiBPbiAxLzI3LzI1IDQ6NTcgQU0sIEFudG9uaXUgTWljbGF1cyB3cm90ZToNCj4gPiBBZGQgc3Vw
cG9ydCBmb3IgdGhlIEFENDg1WCBhIGZ1bGx5IGJ1ZmZlcmVkLCA4LWNoYW5uZWwgc2ltdWx0YW5l
b3VzDQo+ID4gc2FtcGxpbmcsIDE2LzIwLWJpdCwgMSBNU1BTIGRhdGEgYWNxdWlzaXRpb24gc3lz
dGVtIChEQVMpIHdpdGgNCj4gPiBkaWZmZXJlbnRpYWwsIHdpZGUgY29tbW9uLW1vZGUgcmFuZ2Ug
aW5wdXRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW50b25pdSBNaWNsYXVzIDxhbnRvbml1
Lm1pY2xhdXNAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gDQo+IEkgdGhpbmsgd2UgaGF2ZSB0aGUg
aW1wb3J0YW50IGJpdHMgc29ydGVkIG5vdyAoaS5lLiB1c2Vyc3BhY2UtZmFjaW5nIHN0dWZmKS4N
Cj4gSnVzdCBub3RpY2VkIGEgZmV3IG1pbm9yIHRoaW5ncyBpbiB0aGUgbGF0ZXN0IHJldmlzaW9u
Lg0KPiANCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWQ0ODUxX3NldHVwKHN0cnVjdCBhZDQ4NTFfc3Rh
dGUgKnN0KQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQgcHJvZHVjdF9pZDsNCj4gPiArCWlu
dCByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKHN0LT5wZF9ncGlvKSB7DQo+ID4gKwkJLyogVG8gaW5p
dGlhdGUgYSBnbG9iYWwgcmVzZXQsIGJyaW5nIHRoZSBQRCBwaW4gaGlnaCB0d2ljZSAqLw0KPiA+
ICsJCWdwaW9kX3NldF92YWx1ZShzdC0+cGRfZ3BpbywgMSk7DQo+ID4gKwkJZnNsZWVwKDEpOw0K
PiA+ICsJCWdwaW9kX3NldF92YWx1ZShzdC0+cGRfZ3BpbywgMCk7DQo+ID4gKwkJZnNsZWVwKDEp
Ow0KPiA+ICsJCWdwaW9kX3NldF92YWx1ZShzdC0+cGRfZ3BpbywgMSk7DQo+ID4gKwkJZnNsZWVw
KDEpOw0KPiA+ICsJCWdwaW9kX3NldF92YWx1ZShzdC0+cGRfZ3BpbywgMCk7DQo+ID4gKwkJZnNs
ZWVwKDEwMDApOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXQgPSByZWdtYXBfc2V0X2JpdHMo
c3QtPnJlZ21hcCwNCj4gQUQ0ODUxX1JFR19JTlRFUkZBQ0VfQ09ORklHX0EsDQo+ID4gKwkJCQkg
ICAgICBBRDQ4NTFfU1dfUkVTRVQpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiBy
ZXQ7DQo+IA0KPiBEbyB3ZSBhbHNvIG5lZWQgZnNsZWVwKCkgYWZ0ZXIgc29mdHdhcmUgcmVzZXQ/
DQpUaGUgZGF0YXNoZWV0IGRvZXNuJ3QgbWVudGlvbiBhbnkgZGVsYXkgcmVxdWlyZWQgYWZ0ZXIg
cGVyZm9ybWluZyBTb2Z0d2FyZSBSZXNldC4NClNob3VsZCBJIGFkZCBzb21ldGhpbmcganVzdCBh
cyBhIHNhZmV0eSBtZWFzdXJlPw0K

