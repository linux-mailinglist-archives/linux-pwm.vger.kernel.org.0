Return-Path: <linux-pwm+bounces-4294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C09E981E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B2C1888ED0
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8A1B0401;
	Mon,  9 Dec 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hhyy2Rdy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079D35971;
	Mon,  9 Dec 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752958; cv=fail; b=knRyeFu62sTwtzKx1EyzLJpndnOJ/cR2yju3mCz+dDE7wN/RW4JiK89Jcgzndciy//AiQFwExACMSsko3hWSVcaZB7UrExgrAxM9V6vx5L7/bN4udgOlcstdSfV3grO2nwnQB7tYFkGk4IRb0tvvWbvnxeDgyfSMxvPxzZ+QyPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752958; c=relaxed/simple;
	bh=/7iAIpOgWhvfru5IU7DI8/2KoNVbctvII1NZejIhTv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qBmrbnAXOXQDh02a4RDiIm9otbku1D5Q+XA0xHfiBqd6cJ2Ahyrh1w/REHP82643m7R/qXi79tEJ0ig/0BSgvQW2OiM0TlC3DTsrbFnt6HNBKk/IZpt08Aee5X1M1vMADBr0bzmA9yrBCmaVE9LQdyoMtY4N4W8kjWRpQn0T5mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hhyy2Rdy; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B96Xe005654;
	Mon, 9 Dec 2024 09:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/7iAI
	pOgWhvfru5IU7DI8/2KoNVbctvII1NZejIhTv0=; b=Hhyy2RdyKO5iTxqCFZnZ6
	PSuisLkPAdC5Th4lc6Q5p6bf5cu9PbD0oprLhy6R5QdigvQ8Mizhdasd5SBIV4/7
	wPETyrC3O/mwm5QPQhf0Mcb6o8CXlHya+PAwD2aoyYeLcTQtGaPlfLhz6hyP6cNG
	Cf1nglK4uu6fTS+mJb/6mc9CbAZQMQEnJMntjx1cgj8awftuWrARFoQ7Pp+NNfQp
	Nm0W0iso5hp5+zC7Xep9gItpWnANe5YR+xBsReMFnIg79CkFPTqk4te6ShcpNo+t
	g+Ugd6JVizSxxNv8AhXFxY68z2g97sIoiEOODb9VxFYzTZg46BNL3RcJbgTUTqaD
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43dye2gncd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:02:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHjs21tXrsCnFR4IJ7lTm2djKMgEYQJMItQ9usXwtvi32dXnMN124rRr75g9oHHNNbhgl5qk110ITeva+0ltn8L5Aj85daoJh5NIGE7tCYl5EJMeZnx1n68kYglNiLJk7Rtm5uED8YjiH+Is2KFZ6176BM0dnQQtVlJOOzN4WAoK7QdMSEF+PytsQ73z3fyyJtPn+b3WR1wusH9VSgCu+5BGTqhwWK4bmc+XtcQ+6gQtW87VtuLkXMvJxjJQu8CWCNH0juTJ46BLW/isgmNI28WjVSLKpFSeFMjjJ+eXEQ6BmXLvGzr7muoBV13Vfy3QBsSFeoUv749lo0uVV3WDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7iAIpOgWhvfru5IU7DI8/2KoNVbctvII1NZejIhTv0=;
 b=gCERuC1B/FkRZdVzQfni1iWyh+hyCJzyiR+3rpuaExlG9MB75KLcQPf3xKT5kMdnjxO9ZUHwMh7GvR6vZZWVf4DrQnJBKZ0G3Aw03h3D/atZlDqdLwPp5ro/Y6At2tsIEAPtl62iFU5TmsK9mMttKzvVvX3kwU2JACEdNg1rM3bNJEyXcoWcsBPLObpLG1+fcE2X90JEheyqEw1PZ2c0ereaFv4S2cO49sle7ZpYmY9rfPsh+4KGCCU7mDhE9OJiVbFl97L2hp3vv6QuEWgzBZaClweG/lXcGnH0s1LdpGzcJEPKUdGa61JhwyLrx20tzejus5thffEVQhFSeu/9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5114.namprd03.prod.outlook.com (2603:10b6:5:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Mon, 9 Dec
 2024 14:02:28 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.8137.018; Mon, 9 Dec 2024
 14:02:28 +0000
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
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
Thread-Topic: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
Thread-Index: AQHbQnRywf+nZYqk106wKidFVGgDN7LW2USAgAcm4xA=
Date: Mon, 9 Dec 2024 14:02:28 +0000
Message-ID:
 <CY4PR03MB3399F17206B01006467B602F9B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-8-antoniu.miclaus@analog.com>
 <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
In-Reply-To: <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB6TjJZNU5HVmxPUzFpTmpNMkxURXhaV1l0WVdabVpDMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTXpkbU9UUmxaV0l0WWpZek5pMHhN?=
 =?utf-8?B?V1ZtTFdGbVptUXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPRFkxSWlCMFBTSXhNek0zT0RJeU5qVTBOalUyTkRBek1ETWlJR2c5SW10?=
 =?utf-8?B?UFVXUnVLM1F3WjJFNE0zVTNTVGR3U1dST04zQTBNMWxSWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW5ac1ZsQTJVV3R5WWtGUmVIaHRVRVZMTVc1MVUw?=
 =?utf-8?B?UklSMWs0VVhKWFpUVkpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-office365-filtering-correlation-id: 8d4fa5b3-d9a7-4ac8-c935-08dd185a1dd0
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1VVUFJjWlhXOXN2TnA3MlRNK2xnVEcwenhHeGdUQ1pOOXdXMHN4WXRPZUJB?=
 =?utf-8?B?NU9pK1RyY012bG5FcTRTbVZYRFhaOWk3MHhtbE5jSUd6dzZ0VWlVV2hRRkJu?=
 =?utf-8?B?U0hRZU5aeVpxKzVscmprN2l2aHgzOWVZa1ZEY1cwWkRiU3QvR1NMQkNzSVQz?=
 =?utf-8?B?WU5yNnErMG53MC91eDlYUkVlYTBZZXVjcHBDRWNZQzh4d3JmdGF6VFREUHZm?=
 =?utf-8?B?QkpJc2dzalZrbmtzYlRRelc5dHVNWlZLNW1MZnNwRGhHbm9wdmNiQTAydEdH?=
 =?utf-8?B?eGxwRGZwalp2M3hkWTZkajM5VHNhbzVpdmVtRzVZd0ZTeFBXU1dtNVlLZkxY?=
 =?utf-8?B?SStZK2l0dGdPVHRDVVlTeWFaZDVKZy9laldjSU9Vd1B3a1dpWW5uV0VMRG5n?=
 =?utf-8?B?REUyMTE1aHFEdU5iQnFjNXQxVWNJbkoxUFBJamVUUnROcjFqLzF0ZFVmbzlq?=
 =?utf-8?B?UnRQRVUwT0ViS0hiRm1zQlgwZS9qcXduQnlPRm83SVcvOGlWN3lRWU1NeTZ1?=
 =?utf-8?B?cm5DYUt1OVhlb0wvUCtLTjkzWk9DUmk2SGMwc3o2dWpBRkJ3NDd5N0Y4WUtz?=
 =?utf-8?B?V0ZycGRBRjUxbDNaWHRIc0I5Z0hFbjJMQkswOGFMSjFHcnZZQjBTWUNCeW5T?=
 =?utf-8?B?NTV2ODc5KzRzQ0pTVlA0T1JaendUZGFoaWFTVzRKU1Y4RUM5RDZTc1JEZ3Ji?=
 =?utf-8?B?Um1UNVBXRlJtVGNJS0hsTE1yNEh6b3p1bnV2ZTYwZ2lsVWFHY0JyQ2FpRXp1?=
 =?utf-8?B?UmpjaVcxM0piTG96REIvUTNFbUdWdlJUUFFTNjcrT2x4ak5NV3pIUWdlMmhV?=
 =?utf-8?B?S3hadW01UTRpU1Rza1BndlhXUGdIQ296R3lJZnJIWXhISUIzaWNrS1BxVVNn?=
 =?utf-8?B?cEZJL3ZRVEx5cFp3M2o3RXlJVEhMWStGOThDbTc3Q0RqRnk0aWFRRW1KcnZi?=
 =?utf-8?B?b092WGNlWi9YSDNpczZTSUxBV1hUeithNHd3eTRrajBSWjFQVTVXNU9STnB3?=
 =?utf-8?B?bitwVFcvL0JWd29rdGpLcWx5dWtTUGtDNmlXYU11UmIwUy9oTUNzMXNtS2Zm?=
 =?utf-8?B?U0tGL1h3eC9uNVBtRk1nbE12MkJvU1pwVzhuTVFaY283YzdSWThaT05id21k?=
 =?utf-8?B?MlJnT0l6TDVDaHhPQ0xXbW9vdnoxUzBoZ0w0Nkh6YU9ZNDM1bEFrdUo0TG9l?=
 =?utf-8?B?aFZnZWRuME5kV1JOanREMjEvRTNHVk1NVHVwMGl4ZHF6MGt4SzBlUTZoZHlB?=
 =?utf-8?B?cUNqdll1WlV0TkwwK1R3V05DZUx5TWkxWEVPem5iK0IvckR2ck9IYktNdWpo?=
 =?utf-8?B?M2hVSXlEeU91UmxVeE53eTdkeVRudHpTRUYzUTAxOWJFeFlQbDRmeFlGK0Rr?=
 =?utf-8?B?WTNwNlVtcGtVVzFEMk1tdGZ6NmZmbGUyOUNLMXhSQTRJN3h5eXJqelI4V2da?=
 =?utf-8?B?VkZxTGNDMEU2TDR3ZjVtcDA4NzRpOG1hZHpUcjFjM2JMeGhwV1Bjc29JMXdW?=
 =?utf-8?B?K2wrZFFKZHRJZEpoSnp5OUZoWTJ5UEtheFRLT3BBZis0Q1NXSENBRCs2cEl4?=
 =?utf-8?B?dGlOUlZDYzFWVTYrMkJ5TGgzZTNNby9SR2haVHNnUHFNK1Y0RmlTdjRKaVJi?=
 =?utf-8?B?SmdnNEVDWTRnYlllZDcyamhoV05CZVFiTnFQVW1vb3FSK0lwZ0lRcjdhS0FL?=
 =?utf-8?B?bFdMV0RaYmZlekg4cnFxdUwxcnBEU0xzRW5Id0Rja05NRnZVbmVSamlUS2xI?=
 =?utf-8?B?a2JGdEkydUVKNVpZUEpLd0QxT3ZHRnY0akZ1VG9LcnRGRVBGUFVNWnE2a0Jp?=
 =?utf-8?B?UXNvdVFIYWVRY093RlhMV29mbzFBVzJyaW5OOG5mbllsdG5QdVdxTkpPc3o5?=
 =?utf-8?B?Q24zcHZhZUtZNVJiNmNwTTZCQkxLTkZPQXh5bE0vTFpPV0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXVieE5YbFQwSEhqbTVNQ3draU5TUThIajZVNGpsL05qT0RKTTV0bE9YbjhF?=
 =?utf-8?B?SU9scFRRM3pyenpBWFpEeTFJRnFtd1dnQjZoZGRZOXNGdzNxOUF1NG5RaXNL?=
 =?utf-8?B?UDd1SWI5RHFucnhOWUFHUmtpRjVUSkpFNXk4cGl4Rml0Q1BycUNNU2NleVdr?=
 =?utf-8?B?Zkx6NUxpOGtwTUFkUEd0WFowUy9pUi9tV21tS3BzbHpVSmxiWEsxa3Z6bFVY?=
 =?utf-8?B?aXNiQnhnUFMzSDVXQ0F4K0VxVjQveWlxL1h3M1g3cEY0SXZBeTU3ZEpJcFJz?=
 =?utf-8?B?MzJjWkMzQ1F6K3hOWStzOVlSZUl3WUJ5TXB4b0p3OWtTVTRqM25MeGFaaTZ6?=
 =?utf-8?B?cERmK0l4S0ZzMnlwYWl0cHZhNnQ5dzFYWElSRTV2T3JwdXdMSlRGNmpReWsr?=
 =?utf-8?B?WnZjTXdTTHd3anN5MGZ6ZXRsbTJlZmU2SWMyL0dOSkdKME9QdU1HNkFHaXVh?=
 =?utf-8?B?UkQyUTRpUm1qTzZSTEN6dU95VGl6d1NkWVJnRFBXcEtPZnNJTTM4cnpaQ0Mr?=
 =?utf-8?B?d2ZxYjFBcXNUcEVEQys1ZEZxNFJFLzhqSjJnLzRmaVBQVFcvNk9iODJlbWxi?=
 =?utf-8?B?b1VCc3hLNEhjRmhicGdlaDJYeEh2bTNUbnlucWpRVzB2dEoyK0UzMzhnUEpv?=
 =?utf-8?B?VHpjRVJZOU5vcjVsWU9DVDNkczk5UWVqUUJscThWYkxhYjJtN1U3a2tlcXh6?=
 =?utf-8?B?UGloYUkzNGZoZmkxSjRhTDdJTmkzVENIMFlUUkJyS01GTWt1ZWlqVmRrTHAz?=
 =?utf-8?B?UUw1U2o0UTRJYkV4bE43djJQeVF6Mno2U1E1bCt1NnhmbFZlTko3bFFqUGNa?=
 =?utf-8?B?VzV3L3k1OThKdnhiNjUyMWQ3d0p5UklUYTF4L2RaeTZIb1VkYm4rSDZCdTJi?=
 =?utf-8?B?aVVQeTdZTEdKdG1UR0pHdE1sS2pvdHVJcStVOFVSRWdTQVZaUm9RWVFaYUEz?=
 =?utf-8?B?MXE3MTZ2N1FjYkwwM2F3WnN2alJFb0VCY1VVSFNtWWNwL053T05hU0FkZ1VR?=
 =?utf-8?B?eGdTa1JraGIvWmxLbmxHZSt4ZURPVHVFdTdGTzh0Rm54TXJZMW9VVmxDM2xZ?=
 =?utf-8?B?czh5c0tFbTVSZFFwdWJpZDRFdzJQYW5XZm9WZ3piQkY3QkNPSjlnT1lXdDBS?=
 =?utf-8?B?WU5yTngyRm5CY21TUVpVemc5a0NjVmc3Vk5IelpGVElkTUhrT1RVdmZSem83?=
 =?utf-8?B?TXhUM3dCRklZZW1VMnc1SEt5MTJFQVBNMjlqWTdaeXpBUzZxcHErSnJPTTdu?=
 =?utf-8?B?cGtsOW1ncUFZVjVLek53N2NuSkdSVmd2MFJNOEJHSEpRN1lLUk1MQ3JkU1Jt?=
 =?utf-8?B?dUpHZ1ZkZUhialVVMHhBbE9wR0IzUGtHWUREYjA0dUFZVmEyK0RUWDVsdm5u?=
 =?utf-8?B?MUlCZHphd0NuS0VuQzlhaXRnZDB1bk40SUxOYjZWa1JVR1VDNVdZUS9rSk93?=
 =?utf-8?B?MHVvNzYzdTFrWGxINy9zOXdoZE1EOHVJYXRPai83UmhkbHNlUXhyWnhjTVVt?=
 =?utf-8?B?eDZqODRWVGlPR1I0RFNQUitWRGlnUGZiTEVZMSs4eGlKNkdrVGRXa3JjcExv?=
 =?utf-8?B?RW9zVUYvdEd3Ny9mdjdha0E1Y1Y4RWMwZTlwWG9OMGJDUFh5NTlmNllDNEZn?=
 =?utf-8?B?dlpuejc1S1g4Z3lCdHRUbzFUenJPbzBWbWRZTVAweFpHUnYxamMxVCt1djlG?=
 =?utf-8?B?TVAzRUFlb2hnU2pYL3hha212T25nejVTYkJBWnF0b3AzSXhBVGtmL2pXbG1J?=
 =?utf-8?B?YU5CRTRFYjB3V2dUeGlydldIZVN5VWtOS2E1RDBXR2hQUy9KNWp6ZXdrYzhO?=
 =?utf-8?B?S1NJb0RzbGJjUVNKRDdFcm5mdlJpcVRjTU11N1IrcnhEVUVzUXQ2ZjA0WU5S?=
 =?utf-8?B?K3BHMHZ3cktsLzZIYjBLbGVyWGRsN015aE14aUlnRi9OTVpDUXo2WnBZY0Zs?=
 =?utf-8?B?dm9qMDRMSExhM1dUNC9ybThEWEZ1dmdJcmxVditENHlVOFZSTVpYZng4Q1pX?=
 =?utf-8?B?azZXOVllNmJuVVYwWWhiY0RCREtyclFEdGh6ekZKd3BMc3ZOaGlsVURlT2xr?=
 =?utf-8?B?WFNHdU55T3loNGJ2a1FSd3QvclhIVmo3blBlZndqT0ZGb0M5aFhnaVdXK3hn?=
 =?utf-8?B?VWFXcUR2azJXS3ZMQUV0aUdFQWtxRnFDLzJuZXE3dFFncHhVbmF6NzdiQTJO?=
 =?utf-8?B?blE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4fa5b3-d9a7-4ac8-c935-08dd185a1dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 14:02:28.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh3xr3MlAT5YTNDisD925RnZgtHlt7n1mddpEyx6DAKwjypwKqMevC0A3G30o5YnBRfTc1rKE8bQ+ODrasRkVJ9NMrPIwdKC8NIUM9BVbTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5114
X-Proofpoint-GUID: Z16fX_LrisqD4KWKu9lBxg6dT3mlSrpw
X-Proofpoint-ORIG-GUID: Z16fX_LrisqD4KWKu9lBxg6dT3mlSrpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090110

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIERlY2VtYmVyIDUsIDIwMjQgMjo0NiBBTQ0KPiBUbzogTWljbGF1cywgQW50b25p
dSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiByb2Jo
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA3
LzhdIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogYWRkIGFkNDg1MQ0KPiANCj4gW0V4dGVybmFsXQ0K
PiANCj4gT24gMTEvMjkvMjQgOTozNSBBTSwgQW50b25pdSBNaWNsYXVzIHdyb3RlOg0KPiA+IEFk
ZCBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciBhZDQ4NXggZmFtaWx5Lg0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4N
Cj4gPiAtLS0NCj4gPiBjaGFuZ2VzIGluIHY3Og0KPiA+ICAtIGFkZCBhZGMgY2hhbm5lbHMgc3Vw
cG9ydA0KPiANCj4gV2hhdCBpcyB0aGUgcmVhc29uIGZvciB0aGlzIGNoYW5nZT8gSW4gYSBwcmV2
aW91cyB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzLA0KPiB5b3UgZXhwbGFpbmVkIHRoYXQgd2UgZGlk
bid0IHdhbnQgdG8gc3BlY2lmeSBkaWZmLWNoYW5uZWxzIGluIHRoZSBEVA0KPiBiZWNhdXNlIHRo
ZXJlIHdhcyBhIHVzZSBjYXNlIHRvIHVzZSBjaGFubmVscyBhcyBib3RoIHNpbmdsZS1lbmRlZCBh
bmQNCj4gZGlmZmVyZW50aWFsIGF0IHJ1bnRpbWUuIFNvIEkgYW0gc3VycHJpc2VkIHRvIHNlZSB0
aGlzIGJlaW5nIGFkZGVkIG5vdy4NCj4gDQpXZSBoYWQgYSBkaXNjdXNzaW9uIGFuZCB3ZSBkZWNp
ZGVkIHRvIGdvIGZvciB0aGUgZHQgYXBwcm9hY2ggZm9yIHNwZWNpZnlpbmcNCnRoZSBjaGFubmVs
cyBjb25maWd1cmF0aW9uLCBldmVuIHRob3VnaCBpbiB0aGUgZmlyc3QgcGxhY2Ugd2Ugd2FudGVk
IHRvIGF2b2lkIHRoaXMuDQpPdmVyYWxsIGl0IG1ha2VzIG1vcmUgc2Vuc2UuDQoNCj4gPiArcGF0
dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgIl5jaGFubmVsKEBbMC03XSk/JCI6DQo+ID4gKyAgICAk
cmVmOiBhZGMueWFtbA0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogUmVwcmVzZW50cyB0aGUgY2hhbm5lbHMgd2hpY2ggYXJlIGNvbm5lY3RlZCB0byB0aGUgQURD
Lg0KPiA+ICsNCj4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgIHJlZzoNCj4gPiArICAg
ICAgICBkZXNjcmlwdGlvbjogVGhlIGNoYW5uZWwgbnVtYmVyIGluIHNpbmdsZS1lbmRlZCBtb2Rl
Lg0KPiA+ICsgICAgICAgIG1pbmltdW06IDANCj4gPiArICAgICAgICBtYXhpbXVtOiA3DQo+ID4g
Kw0KPiA+ICsgICAgICBkaWZmLWNoYW5uZWxzOiB0cnVlDQo+ID4gKw0KPiA+ICsgICAgcmVxdWly
ZWQ6DQo+ID4gKyAgICAgIC0gcmVnDQo+ID4gKw0KPiA+ICsgICAgYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4gKw0K

