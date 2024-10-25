Return-Path: <linux-pwm+bounces-3880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A09B0169
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750B81C21F69
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F21EF931;
	Fri, 25 Oct 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ClJ0ONWK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8A1C0DF0;
	Fri, 25 Oct 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856126; cv=fail; b=J8mzK/mkdtLUlkMhYq0uF0GURMaOyNd77CYOmuCqmrdis0JUumslInmMgOi1bfr78B5gbThyV8j9ihC0Qi5RchsWscKuBZmlo7jNKt7dKw0WOKNXLeqUG/9fEVWnAGLyaye+GzqY6/nFIGxv9dnisigyghGitIcAuGRt+f6ULTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856126; c=relaxed/simple;
	bh=RviqktFmGElanZnyWVzAxLwZHL2spSpdvg3GFC1NRD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mH9trwvTHEwxsglS2jjAfJtCiWFqhbdbOtd94gV+OnYd0VWLxgnmGs84oep5GKq7iTLQ5m44iogWRZz3yPJTqymCGVwi3ANvqsg4YU68m7xy17VRpzFDYWlhum7bqdAFUzxVx50OM+NdQDazAAEenGwgQoSRdW86CIn7Wyx4Qy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ClJ0ONWK; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8LfP3029221;
	Fri, 25 Oct 2024 07:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Rviqk
	tFmGElanZnyWVzAxLwZHL2spSpdvg3GFC1NRD4=; b=ClJ0ONWKFR09eTyR4cle+
	1d5pp7ZH7gjVvNlQms4vImRewoAa7/v0NoOK0hbaDXJtUWBfWIwp1lOS+5vfRtPr
	6SskceNS4BlNNMLBSSTddBX9HP+J+saec7JXAMCHjU7niPbtMCOVrsVlV6KaL9pP
	4M/nRAQ1BkKYN7M3jbq+w7qGWICsft1zbAclo1AD1ZbOk1AUvE/BJCfPMWoYcC6E
	HW1VAihzAyh7YquiLIjqYQKGcDByV4vKuIxwTwN5iIO4f6iXa482yh8WDK/nGPdz
	bxvYl07QBzQSNtyTaTKSIf1UB7x/pXPZGqc49qgrjvSvb+mZ28Bm7ycKerrDuBkR
	w==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42g2uf9x9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:35:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDSrUK1JA1do8Q8oMJQnTihTZgUJeDXH1fY2aHX37Ulc1Cmu+QU0USSM4kzAx8xAVNF84EcNpa/jV3X4RNEo6vNnX7LWwKo06B7aQ26zsK9NbyLRp1/WM+f8Tv81lnRS6Rty5X0gzgcodn1lA8zIClHISjjAjPF2uhB/e7dWMSoi3iCnj8WOK0Ka8Tishf6xqaxrbccaubDI9DhoenqnfkGc3/QGKflamgYTPFs7ElQIq+tHjMA+O0wavPA0TxsvEwX+IBUKxM1y9572aTxwsjWCEzkuXmh3WQs1h6QwmZOBDv6+LXqTz47nMLMUPh/zA6oe/tWd3bOU+tbKKySB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RviqktFmGElanZnyWVzAxLwZHL2spSpdvg3GFC1NRD4=;
 b=r+TxQ+Mr7Cvx8DxUnWicCvUpvId343qEW5NIaLZhr0j4PO/RQxj0WQQtrQqh6glD4g4bpgpoA8XIOBBWFXO4q0lcdjijIcM6VPgf59qRcccGRrZ+fqylXlFdYdsIyxRIXj33rbXxI42vGhBxU3tel3AKk6VJGUWqkTkg7I/cpLgEsGCxMqMS0gAk1ZseIa/ndpS1eUwS6hUSeATHmVlolRETi2BwEiGDuSvcq3ZiUkTu1zV7HPpFB1kUtxLu8Q+w1IxlwQqB1oTSwLqnmLhypn8riXV+fyvt5wmhcxgQcTxgoex03tclNYrMRHjmrvkYPyVAU7vFDPAhYwWB1DVnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA1PR03MB6642.namprd03.prod.outlook.com (2603:10b6:806:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 11:35:06 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 11:35:06 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan,
 Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Thread-Topic: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Thread-Index: AQHbHh5vTD2IDt3G+0qZAjfsQopGKLKG8ZIAgBBw/PA=
Date: Fri, 25 Oct 2024 11:35:06 +0000
Message-ID:
 <CY4PR03MB33996900AAB90A050375CBB39B4F2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <60452f83-28a1-4a80-8e90-1f1ed32a594e@baylibre.com>
In-Reply-To: <60452f83-28a1-4a80-8e90-1f1ed32a594e@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB5WTJGalltTmtNUzA1TW1NMUxURXhaV1l0WVdaa01TMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTW1OaFkySmpaREl0T1RKak5TMHhN?=
 =?utf-8?B?V1ZtTFdGbVpERXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBOalEzSWlCMFBTSXhNek0zTkRNeU9UY3dOREUwTmpRek5UVWlJR2c5SWxW?=
 =?utf-8?B?VWVuWjJSMlpSUTJOSFJEUnlORFZ4Y1VjM1RFNDVjekkyTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVdvdlJEZDJNRk5pWWtGaVZFZGhTVEpvWjIxR2Ju?=
 =?utf-8?B?Uk5XbTlxWVVkRFdWZGpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA1PR03MB6642:EE_
x-ms-office365-filtering-correlation-id: 12bd766c-6925-4fa6-c754-08dcf4e9131c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TS9pdnZGQ0hiTkduSUpFbmI5d3R3UWYzamVmeWhQUmZSdzNrT2VTRzhlZ0FN?=
 =?utf-8?B?cld3OEFISVhxSFY1cEVIU1pMYnlDV3pWRCs2RVVDZU1Gc1FqamdTNXdMQ2RI?=
 =?utf-8?B?RGNRMTRRQjJyVTdYdkZ1d09WbkZManpzNHlKcSsvcFh5dDg2bzRrRXVwNzd5?=
 =?utf-8?B?SGIwN3JxbVJPOFV5YkJqbmk4UmVVcE5kR3Z0cHlwUWoxMzRLSVltbFZkNWVj?=
 =?utf-8?B?QmxOcDNzSUJSb0xEQlJqZ0ZydkRnckxTa21Jc3RKanhUNDljTVZqWDM5RzJq?=
 =?utf-8?B?LzlYOWFaejA1N3hHNWtNR1NrUkxJNkczZTZNYjZpQnJNSnJ1U3BodWJoWlBC?=
 =?utf-8?B?Q2ZzdTRBWEdtOFJ0UjRkUzd4aGkwSFpyTlFINGYyekZHaVBJRUpJTE96emV5?=
 =?utf-8?B?S0ZEZElhU1JPOFAwd2xIaEs2bzM0alRNTXJuQndKSDZPcnJkbFUzc05GTjFn?=
 =?utf-8?B?RGlDRTZQZXRwTDBJRXpwalFLNTRvQ0xpb0l1dXJUd2VZejVvS21WbUpncytT?=
 =?utf-8?B?bW8xeU15bEh6L1pYR3VRV1ZJMkhiMnBIbXRyeG5FdGE0Qk16bFZIbXJibVNP?=
 =?utf-8?B?YkoyVlBXaUtaKzQ1THRaeTNrdjh2OHYvWmdvcno5WHcvU2VLdHVaZzMxVllI?=
 =?utf-8?B?OXJGZ216dlJidkpjZTZNMXJHemFnSkdlM0J4L3VlcXZIdlNmRHBqelZxdURk?=
 =?utf-8?B?N2lySDJRZkNQaEZ3c1ZEa09ObXZZaHNqWEtFVWVjVGl6VytoajRNMkkzVy80?=
 =?utf-8?B?eVJKUi95U0xlUWROOHBhY21jTWF1YXVWRXUxWnlWZlFiZVhOckF0SjhWbTFu?=
 =?utf-8?B?SUt1VkYvNDJHYkhKTGFKYXBsUkd3aWxGNnB3YVdxUy9HV1pOc3g4VVRKNDgr?=
 =?utf-8?B?TTAzR0U2R2lnOUt2R0ZGVEkzUmpFZnJFNVBhUkNBaHQvVnpXSjlaQnNiZ1ZO?=
 =?utf-8?B?a0RReEE5MFhoMkNlNjYxMVQwSy9kdmZhQjN5UXJUaUFPOFBoL3gyR3hmYlh5?=
 =?utf-8?B?QnFJaDRtd2d1VC9JcmF5MkV0ZnppTFlyOHFhQm8rdGpNazQ1TENtZWUyWlNk?=
 =?utf-8?B?UXVHOTZtclRCQ2VWSlNERU9WMjN3c0RpRHBRamh3aGhGQWEwQzYxY0FBQ3hE?=
 =?utf-8?B?amg3cnNtb0RVdWd5Z2tNYmVJWlZqSmRLakc2NUdxZ2tnOFdNbGNJdXd4R1FQ?=
 =?utf-8?B?eHUwZk9wdlRtYW41cjhIcStZSHNBRXVwZDFBVVQvTW1EN2VRdmlxdWh5emFO?=
 =?utf-8?B?RW1hQTZrbXZ2ajl6ME9taFlqdmpFVFhLOFQzT2pJdlRrT2Vtb2ZWN1VLVjZF?=
 =?utf-8?B?SzVxajIxcHV5MkVWOGV1MkViWVdSZlNlaWRtYy9mS0VhbSt0U1NlZ3FLc0pN?=
 =?utf-8?B?K21IV29lNWRSVDcyU0hCaHQzd3YrUnAyaU1VUURYdDk0bU5zNXBpSkp0OWND?=
 =?utf-8?B?ZGJWM3dVSG84dTdXcjFRTlUvTUJyVnRzZmpqYmVuUW1qcEVtRWZBZDY4ZWNJ?=
 =?utf-8?B?MElZclNtNFVMNXBzZ2o2RHFucFVQV0lrazgvTEROL2lHZzRldDdleG4vbmpQ?=
 =?utf-8?B?VEI3ZUg1c0xhZWJLWDNIMWw0QnBsYjFncWNjL2RRSVdwbncwTy9OTWFzcUo3?=
 =?utf-8?B?QWNTTWRoc0VqVGJtdlRudnRtU3pqaTBiZ0MwblJraldMUmhMWjQ3bFp1RmE4?=
 =?utf-8?B?dG9ESlVDS0tBVUl6Y3lUS04wc3AvZ3VEemthMUpsYW5ZOGFiYXROSUZVeUlM?=
 =?utf-8?Q?eqJyBUckR4Q6dtPrYqfD26BaNGHal5n/Mb4m+dI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3JsVGhuWEtjOTVQS3lnaWpLeEFlUWx5ZlY2OXMvdWdNSkFCWVg3M0VyZWND?=
 =?utf-8?B?VWtqcVFrQk5FR09KR0pJb3V0Z2FPSjczdVVWMWloUEFBM0JzSmxZUndNbmVS?=
 =?utf-8?B?REtmYlZkd2JYRkpvU2ZpZWNvNm1YZUhlQnVlZWhHanc4OERMeHMveEdGL3JC?=
 =?utf-8?B?bGZVNmRFbmM3dWJEYVlxYXV0cXBrN0c1c3owZnFqRkREWjRBVjdLVFg3Ti9p?=
 =?utf-8?B?cmdYNTVkM1JWUmN3bmtQL0x6aEhNd0ZrZTQxWkZMT0pWWE5oank3N1kyd1hs?=
 =?utf-8?B?MzdoRFpYZ01qcTYrQVBSN2tjbzFmYWpYYkJ4UEQ1VllhOEdGSEx6TDV6bU0v?=
 =?utf-8?B?ZkcwVGNUbTE3QURidkUweVRFTEFDQWFrbmkreklCZmMvT2NCSzJGQnNlRk9a?=
 =?utf-8?B?c0w5ZmdkL3FMQkhHMVVIQ2cydGtFUUUzU2tzWUxhSlBWOHlVd21HVG9LYVVL?=
 =?utf-8?B?cnl1dXRCbk43SjFCc0tzQlRwUlNuZTFlSkdDcFVZaFBpK0Z4cStUWWplQlpo?=
 =?utf-8?B?RjF1V3lySDd2a216Slh2WXExQkROWEhnRklraGh5SEN0T1FKUXFIcjVOc1J0?=
 =?utf-8?B?a2NpVjRqUUprZGk5dDh4aHFBY3daS1R4LzFCVlJLVGU3TENDV2NIQzJVOVAy?=
 =?utf-8?B?NEdKZzN0eDdFZWZmbG51VThrYW9kaXpPR0NQbXhxMGhoNjk5S1g5b3Y3NHZa?=
 =?utf-8?B?QVpvK1pYNENyZ3loM3E3YVBvWSt3MUhwaldXc2Y4dHlONlVjTlZzNWdFNFhj?=
 =?utf-8?B?dEhRdmk1Vmh3WVN3ZjQ4Z2hKQmRMVG5nSTJrcitwSkpFVjNaYStNL3R1YzFE?=
 =?utf-8?B?RFBZazVYdUFCb0V1OEdwTzlxUjdUV3pOanRzeFdzNmpNVVdoczNHYzdLK1Av?=
 =?utf-8?B?akgyVEJIUnBWWG5weHRiZGNqM1ZBbklBdU9QSG5DZWFzaTRuQi9Lbk1yKzRa?=
 =?utf-8?B?NW9XbTJuMkFnbGxSSnpHMlhQWjRyNmlBOU1tQ21WRno0bVA4Ly83Q3UzOUlJ?=
 =?utf-8?B?b2t1Zzg0MU5JZFNyYktZV0RGbFdmV0d0cDhLRmcwMWdacUs2ckhSZERCRzhQ?=
 =?utf-8?B?RmRzTVpvOVR3b2NpK1ZvdjRZSHFvWGhVV0NQekFqQkFvcGZCYkxLUmViWm5W?=
 =?utf-8?B?VjZyODRYcU1XN25lRXV5MWFTenp2QVpHQ1pNMzJGTFVOYTNPRjVIaUF6T3Nx?=
 =?utf-8?B?aWJnM1NOQ2huM0dhVWFOTWEwNkE2SWpHNVJqdFl6S2h2MXB1RjAzZlI1b0tF?=
 =?utf-8?B?OGpRTkJHOFltcXp1QTlXdEJSVHpOWEoyL1VIdnpmblpzRUozMEQ3RHRtMllO?=
 =?utf-8?B?dDQ3aVpMZEsxbkRHbERIMWdzcG4xWVQzSWk1M2JwenNhaDdXc1FnNTM5azhq?=
 =?utf-8?B?NGZOTlN1ZmMvUXJTSmQwV0R1QWJ5eGhPOTRySDFpYVlodWpxMHo5eHJVakxm?=
 =?utf-8?B?aTNibW9pN3lmMnlFT1dXRlpWa0RpSmRxNEtySHBLMHZjaUFIeVhqemFHRHkz?=
 =?utf-8?B?amZhMlphbGxpcGcyYkNFbUY1NzE0SVFNb0FOdTY2a2U0Y21lOTljL2NCVnRn?=
 =?utf-8?B?REs5NUNTOFJtL1JYL0g5ZjlrbHlZNzRsTUVub1VzV3AvVXZjdWY0RzN3UUpT?=
 =?utf-8?B?Y1BvTUllRHpDR1hWTmZ3ejVQS3YxZ3pxYmpUQ25HRTNHdU9pVVJCTjVxNGE1?=
 =?utf-8?B?RUxvOEZQRUFSWE5ZZXhwOFM3Z1lkV3M5UjZobG0zUnNUT3ducW9kZE1YTlpo?=
 =?utf-8?B?aXpSRlpPVGxseHQwc1YwbmlqUHNLNkM0VE5NR0g4czFmLzk5aWJhOGJXV3M1?=
 =?utf-8?B?OWR1RmdqR2FrODVYMGZ0Vi9GbHFwcHFZSHdGdHR2ZEtJeWd6TmFKaGhveHVM?=
 =?utf-8?B?ZkhTckxjOHdINUZhdTdpVHExcG1TZVB5QVMvVkM4Ynd0cXh4YnphdG9lNS9k?=
 =?utf-8?B?bmo2MS8wNHZONGlDa2ZLQWluQ3BuK2FFanhYRlBFWHdNZlI0OGJRMUJvRW9q?=
 =?utf-8?B?SjA3YlB4V1pMbE5ZNkJ2Sk9qMlVkanozbktqc0FGZUk2bDNYbnVsbmR0c2M0?=
 =?utf-8?B?Sk9IcnRSdmRlc3Y4WW9pbXlTUkxuYWlSTXRpRjRnNEE3dlE2cTlRRU9henk0?=
 =?utf-8?B?a1dLNzYwRjBjZDJhNTdBTTR5bnJFeXN2TjJoTndkbm10b3F4SG5SaGJtby9K?=
 =?utf-8?B?Y0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd766c-6925-4fa6-c754-08dcf4e9131c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 11:35:06.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlnyh5OlLo3YuAa+6aMiKhNv+flH2+d1v6ktOWoHK3asUtHqTm4E81LYz/MqCYKOgQwfGexYFCgOddYSt4ApNB630NZsoOUYHnUzdaWz8vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6642
X-Proofpoint-ORIG-GUID: r31pzLDUf9n8U6Ilil465sVFmYx-Hhae
X-Proofpoint-GUID: r31pzLDUf9n8U6Ilil465sVFmYx-Hhae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250088

PiANCj4gPiArc3RhdGljIGludCBhZDQ4NTFfc2V0X292ZXJzYW1wbGluZ19yYXRpbyhzdHJ1Y3Qg
YWQ0ODUxX3N0YXRlICpzdCwNCj4gPiArCQkJCQkgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMg
KmNoYW4sDQo+ID4gKwkJCQkJIHVuc2lnbmVkIGludCBvc3IpDQo+ID4gK3sNCj4gPiArCXVuc2ln
bmVkIGludCB2YWw7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWd1YXJkKG11dGV4KSgm
c3QtPmxvY2spOw0KPiA+ICsNCj4gPiArCWlmIChvc3IgPT0gMSkgew0KPiA+ICsJCXJldCA9IHJl
Z21hcF91cGRhdGVfYml0cyhzdC0+cmVnbWFwLA0KPiBBRDQ4NTFfUkVHX09WRVJTQU1QTEUsDQo+
ID4gKwkJCQkJIEFENDg1MV9PU19FTl9NU0ssIDApOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJ
CXJldHVybiByZXQ7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXJldCA9IHJlZ21hcF91cGRhdGVf
Yml0cyhzdC0+cmVnbWFwLA0KPiBBRDQ4NTFfUkVHX09WRVJTQU1QTEUsDQo+ID4gKwkJCQkJIEFE
NDg1MV9PU19FTl9NU0ssDQo+IEFENDg1MV9PU19FTl9NU0spOw0KPiA+ICsJCWlmIChyZXQpDQo+
ID4gKwkJCXJldHVybiByZXQ7DQo+IA0KPiByZWdtYXBfY2xlYXJfYml0cygpIGFuZCByZWdtYXBf
c2V0X2JpdHMoKSB3b3VsZCBtYWtlIHRoaXMgYSBiaXQNCj4gbGVzcyB2ZXJib3NlIGFuZCBjb25z
aXN0ZW50IHdpdGggdGhlIGVmZm9ydCBzdGFydGVkIGluIFsxXS4NCj4gDQo+IFsxXTogaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiBp
aW8vMjAyNDA2MTctcmV2aWV3LXYzLTAtDQo+IDg4ZDEzMzhjNGNjYUBiYXlsaWJyZS5jb20vX187
ISFBM05pOENTMHkyWSE0TFM3VUkxMVhxSUhSZ1QzY2t4NzZWWQ0KPiBuQ3llaWtwVHVteWpPMHFE
VG43ZUY3RmQtDQo+IGpGRkw4eXFwWWNNQXhQX3UzVkMwOWJmSUFCN2dXX3J2M3lHTURXcyQNCj4N
CldpbGwgZG8gaW4gdjUuDQo+IA0KPiA+ICsNCj4gPiArCQl2YWwgPSBhZDQ4NTFfb3NyX3RvX3Jl
Z3ZhbChvc3IpOw0KPiA+ICsJCWlmICh2YWwgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPiArDQo+ID4gKwkJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHN0LT5yZWdtYXAsDQo+IEFE
NDg1MV9SRUdfT1ZFUlNBTVBMRSwNCj4gPiArCQkJCQkgQUQ0ODUxX09TX1JBVElPX01TSywgdmFs
KTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCXN3aXRjaCAoY2hhbi0+c2Nhbl90eXBlLnJlYWxiaXRzKSB7DQo+ID4gKwljYXNlIDIw
Og0KPiA+ICsJCXN3aXRjaCAob3NyKSB7DQo+ID4gKwkJY2FzZSAxOg0KPiA+ICsJCQl2YWwgPSAy
MDsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJZGVmYXVsdDoNCj4gPiArCQkJdmFsID0gMjQ7DQo+
ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMTY6DQo+
ID4gKwkJdmFsID0gMTY7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IGlpb19iYWNrZW5kX2Rh
dGFfc2l6ZV9zZXQoc3QtPmJhY2ssIHZhbCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVy
biByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhzdC0+cmVnbWFw
LCBBRDQ4NTFfUkVHX1BBQ0tFVCwNCj4gPiArCQkJCSAgQUQ0ODUxX1BBQ0tFVF9GT1JNQVRfTUFT
SywgKG9zciA9PSAxKQ0KPiA/IDAgOiAxKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBhZDQ4NTFfZ2V0X292ZXJzYW1wbGluZ19yYXRpbyhzdHJ1Y3QgYWQ0ODUxX3N0YXRlICpzdCwN
Cj4gdW5zaWduZWQgaW50ICp2YWwpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGludCBvc3I7DQo+
ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IHJlZ21hcF9yZWFkKHN0LT5yZWdtYXAs
IEFENDg1MV9SRUdfT1ZFUlNBTVBMRSwgJm9zcik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJl
dHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKCFGSUVMRF9HRVQoQUQ0ODUxX09TX0VOX01TSywg
b3NyKSkNCj4gPiArCQkqdmFsID0gMTsNCj4gPiArCWVsc2UNCj4gPiArCQkqdmFsID0NCj4gYWQ0
ODUxX292ZXJzYW1wbGluZ19yYXRpb3NbRklFTERfR0VUKEFENDg1MV9PU19SQVRJT19NU0ssIG9z
cildOw0KPiANCj4gV2h5IGlzIDEgbm90IGluIHRoZSB0YWJsZT8NCkJlY2F1c2UgdGhlcmUgaXMg
bm8gMSBpbiB0aGUgT1NfUkFUSU8gdGFibGUgZnJvbSBkYXRhc2hlZXQuIDEgbWVhbnMgeW91IGRp
c2FibGUgdGhlIE9TIHZpYSBPU19FTiBiaXQuDQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiBJSU9f
VkFMX0lOVDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZDQ4NTFfc2V0dXAoc3Ry
dWN0IGFkNDg1MV9zdGF0ZSAqc3QpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGludCBwcm9kdWN0
X2lkOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+IA0KPiBXb3VsZCBiZSBuaWNlIHRvIGRvIGEg
aGFyZCByZXNldCBoZXJlIGlmIHBvc3NpYmxlIHVzaW5nIHN0LT5wZF9ncGlvDQo+IChkYXRhc2hl
ZXQgc2F5cyB0byBjeWNsZSB0aGlzIHR3aWNlIGFuZCB0aGVuIHdhaXQgMSBtcykuDQoNClN1cmUs
IHdpbGwgZG8gaW4gdjUuDQoNCj4gPiArCXJldCA9IGFkNDg1MV9zZXRfc2FtcGxpbmdfZnJlcShz
dCwgSFpfUEVSX01IWik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsDQo+IEFENDg1MV9SRUdfSU5U
RVJGQUNFX0NPTkZJR19BLA0KPiA+ICsJCQkgICBBRDQ4NTFfU1dfUkVTRVQpOw0KPiA+ICsJaWYg
KHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCi4uLg0KPiANCj4gPiArCS5zY2FuX2lu
ZGV4ID0gaW5kZXgsCQkJCQkJXA0KPiA+ICsJLnNjYW5fdHlwZSA9IHsJCQkJCQkJXA0KPiA+ICsJ
CS5zaWduID0gJ3MnLAkJCQkJCVwNCj4gPiArCQkucmVhbGJpdHMgPSByZWFsLAkJCQkJXA0KPiA+
ICsJCS5zdG9yYWdlYml0cyA9IHN0b3JhZ2UsCQkJCQlcDQo+IA0KPiBTaW5jZSBlbmFibGluZyBv
dmVyc2FtcGxpbmcgY2FuIGNoYW5nZSByZWFsYml0cywgdGhpcyBkcml2ZXIgd2lsbCBsaWtlbHkN
Cj4gbmVlZCB0byBpbXBsZW1lbnQgc2Nhbl90eXBlX2V4dCBzbyB0aGF0IHVzZXJzcGFjZSBpcyBh
d2FyZSBvZiB0aGUNCj4gZGlmZmVyZW5jZSB3aGVuIG92ZXJzYW1wbGluZyBpcyBlbmFibGVkLiAo
QWRkaW5nIHN1cHBvcnQgZm9yIG92ZXJzYW1wbGluZw0KPiBjb3VsZCBhbHdheXMgYmUgYSBmb2xs
b3d1cCBwYXRjaCBpbnN0ZWFkIG9mIHRyeWluZyB0byBkbyBldmVyeXRoaW5nDQo+IGFsbCBhdCBv
bmNlLikNCg0KV2lsbCBkbyBpbiB2NS4NCg0KPiANCj4gU2VlIHRoZSBhZDczODAgZHJpdmVyIGFz
IGFuIGV4YW1wbGUgb2YgaG93IHRvIGltcGVsZW10IHRoaXMuIFsyXQ0KPiANCj4gWzJdOiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+
IGlpby8yMDI0MDUzMC1paW8tYWRkLXN1cHBvcnQtZm9yLW11bHRpcGxlLXNjYW4tdHlwZXMtdjMt
NS0NCj4gY2JjNGFjZWEyY2ZhQGJheWxpYnJlLmNvbS9fXzshIUEzTmk4Q1MweTJZITRMUzdVSTEx
WHFJSFJnVDNja3g3NlZZbg0KPiBDeWVpa3BUdW15ak8wcURUbjdlRjdGZC0NCj4gakZGTDh5cXBZ
Y01BeFBfdTNWQzA5YmZJQUI3Z1dfcnZHb01fc0VBJA0KPiANCj4gQWxzbywgSSB3b3VsZCBleHBl
Y3QgdGhlIC5zaWduIHZhbHVlIHRvIGRlcGVuZCBvbiBob3cgdGhlDQo+IGlucHV0IGlzIGJlaW5n
IHVzZWQuIElmIGl0IGlzIGRpZmZlcmVudGlhbCBvciBzaW5nbGUtZW5kZWQNCj4gYmlwb2xhciwg
dGhlbiBpdCBpcyBzaWduZWQsIGJ1dCBpZiBpdCBpcyBzaWdubGUtZW5kZWQgdW5pcG9sb2FyDQo+
IHRoZW4gaXQgaXMgdW5zaWdlZC4NCj4gDQo+IFR5cGljYWxseSwgdGhpcyBpcyBjb21pbmcgZnJv
bSB0aGUgZGV2aWNldHJlZSBiZWNhdXNlIGl0DQo+IGRlcGVuZHMgb24gd2hhdCBpcyB3aXJlZCB1
cCB0byB0aGUgaW5wdXQuDQoNClRoaXMgdG9waWMgaXMgbWVudGlvbmVkIGluIHRoZSBjb3ZlciBs
ZXR0ZXIsIG1heWJlIG5vdCBhcmd1ZWQgZW5vdWdoIHRoZXJlLg0KWWVzLCB0aGUgZ28tdG8gYXBw
cm9hY2ggaXMgdG8gc3BlY2lmeSB0aGUgdW5pcG9sYXIvYmlwb2xhciBjb25maWd1cmF0aW9uIGlu
IHRoZSBkZXZpY2V0cmVlLg0KQnV0IHRoaXMgaXMgYSByZXF1ZXN0IGZyb20gdGhlIGFjdHVhbCB1
c2VycyBvZiB0aGUgZHJpdmVyOiB0byBoYXZlIHRoZSBzb2Z0c3BhbiBmdWxseQ0KY29udHJvbGxl
ZCBmcm9tIHVzZXJzcGFjZS4gVGhhdCdzIHdoeSB0aGUgb2Zmc2V0IGFuZCBzY2FsZSBpbXBsZW1l
bnRhdGlvbnMgd2VyZSBhZGRlZC4NCkJvdGggdGhlc2UgYXR0cmlidXRlcyBhcmUgaW5mbHVlbmNp
bmcgdGhlIHNvZnRzcGFuLg0KDQo+ID4gKwl9LAkJCQkJCQkJXA0KPiA+ICt9DQo+IA0KPiAuLi4N
Cg0K

