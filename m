Return-Path: <linux-pwm+bounces-4758-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08FCA257BC
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 12:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094AC1885874
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086D202C2E;
	Mon,  3 Feb 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wG5pZBBs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E61D5146;
	Mon,  3 Feb 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580600; cv=fail; b=ueGpdG+0q8cU21MUPdpfBWmWc22HcCrtN+2GaXjw4ENim7/gjUCvAzuWLDYISHvhxJIOxMx5IqMInBblfnHeiVvQB/6webPSYQ4iXRHQL5BtnSZuayjJxr7e/bLh2VteRAVaUY/J2S2lf0p05JL8DrhC6nqy/V/Z/tcQDJLaz80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580600; c=relaxed/simple;
	bh=oPZ2A3SpGdvam3BHaPzxZS9v6KOisC2Y6X6SuVC7SAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RI3JH76ATEqwlm/jXIkA+j9udyQ6Ui3rHA00/DXU3Wq7t076NVrTAY7c3ZVnJveJI/fIQKNYXkB+O7xPIfFTdNQAFAn9NjLAUwzNZi9fw86nawTxGND2cJtqhUcyKxLHoIY5DSfkneZ0r7MsjMQK0p222IeAQ40uAgnnEzlQnks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wG5pZBBs; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5138QoVN011580;
	Mon, 3 Feb 2025 06:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oPZ2A
	3SpGdvam3BHaPzxZS9v6KOisC2Y6X6SuVC7SAY=; b=wG5pZBBsZKgzdvkRMGdqb
	30c+f8G2Qzg+IVnWEauhfa7z84hmznMw3Vbo3ys/gNyfkrAVhAwRau/58UH9fBXU
	7EWR13rUYn3vY5KhA8deIwGxNmpGb5VLHn+W+VXUmvhye6wEcDCo0BGmWCNQBIyZ
	a/PXbD1siITvwuHXhe+kpKUASjDZmVCE3H4rNS6fKMXCqiMBQLQQvawc7gV33/9u
	wgOhJji0H7aarlbKFAU6ewi9paI9YFJoC0iCVQJGZ6wfnEPDg9qL8JkRwgMGtVUJ
	fAjNi5QLKC27Kq/l37QbmxqELb4PcQWKC9l3RMRlf49rbJYYtuosL6KOii0iOIeF
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44jn7m1h8m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 06:03:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZkF8TE9P/SxJwYt4X5fMsqmsl9JGRU4ELYmlewUCy+sDRKvMoZLd8j+oWbE67PzbxzYyqDhwkHURmmUd6zXdPikHFDTk1xi4v7CFm9SgNcUvmM0Uta5eOCg4KEX9+wIm/+C0FDMhhzo3+cdt+osdOzYQbcXadceukd+x2AXqKgeAsh22ghd184qXv6nEMOirijcdM2pQj0D2z0oXZ1faAID0ETsXL1sQPMnRJGbP7cpU0UYBFxewLXanUkqYpWaYIT+Adi0qLT5y7pMJua16c3cC4KW3u2egMfW5BL5ffu6FYpEYuB4a8uvF5eQFav49N70b72gl20l0JXTudW7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPZ2A3SpGdvam3BHaPzxZS9v6KOisC2Y6X6SuVC7SAY=;
 b=XUn0nwYvuQJrcDwAN12rsbSBwaJ+r+MV/roj447wzntfzdnEtR7Xwts846DtALJcjc86e+3xdPLb/oq1qy0Hf6SMt5HOIeLWxsPV8x96LuY/6dZzdphppK8arA5uvmxiUNu6If8ySCLagrxoYfni15KXZlZ2MZKPFYRL86mduzgaoLPM5QgwViXLyzzZAGibp7o/n3Z4950CjdOUCR0CCotXhDytuEGU0eIUclPUVlmh5a8AJo64S08TpHnlyvBLAmBwmWW+jXOCeSyYk6JS9jUKETGnNcf7k4EXM/lhYmSKFwrq7IGlYPZ0+6Cj1P3pj6ENSA3VyNC+n1E1BN609Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by LV8PR03MB7400.namprd03.prod.outlook.com (2603:10b6:408:193::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 11:02:59 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%3]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 11:02:58 +0000
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
CC: "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v11 5/8] iio: adc: adi-axi-adc: set data format
Thread-Topic: [PATCH v11 5/8] iio: adc: adi-axi-adc: set data format
Thread-Index: AQHbcKpS1b7YivAzWU2nI7FJoYlb9rMsXoIAgAkVPxA=
Date: Mon, 3 Feb 2025 11:02:58 +0000
Message-ID:
 <CY4PR03MB33993EE62F4E1B3939F213B29BF52@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-6-antoniu.miclaus@analog.com>
 <08d8e97d-752d-4fa7-95f0-d828ef80f7b8@baylibre.com>
In-Reply-To: <08d8e97d-752d-4fa7-95f0-d828ef80f7b8@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyWWpkalpUWXdNeTFsTWpGbExURXhaV1l0WWpBeU15MWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTm1JM1kyVTJNRFV0WlRJeFpTMHhN?=
 =?utf-8?B?V1ZtTFdJd01qTXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBNRFExSWlCMFBTSXhNek00TXpBMU5ERTNOakkwTURreE1UWWlJR2c5SWtS?=
 =?utf-8?B?Uk5XVkdWbXQxVDJScU9YRTRaWFJZUVZOb1dGTnhjVEo0T0QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTJOemRHZDBTek5pWWtGUlIyeFVhMDF5T1ZRMFEw?=
 =?utf-8?B?RmhWazlSZVhZeFVHZEpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlZFRlpOVTUzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|LV8PR03MB7400:EE_
x-ms-office365-filtering-correlation-id: bd19d877-6dc4-46d1-8911-08dd444251dc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3luK01tRVYrSVRuS2JDOFRsT2dBaUZBT2tZV0dtNXFjOTR1MkIvRWRnc1Zh?=
 =?utf-8?B?dlJGVEdXYXBBdVlaVjNwMzVEblBEUWQxZjh6UzB6NkVLRmlNWFFPRkRsYThR?=
 =?utf-8?B?NHByS3hSK1d1TFZpczFJeG9mNHNYem9ueDNqc2dYUzNiKzVSYnFhdzQycS8v?=
 =?utf-8?B?S3p0YzFwVEtQRjZwVFR3bW1GTkYxelNucVFZR080WU5hSkJWV1NrRGNjUVJt?=
 =?utf-8?B?bzFkNXRhTm54SklqNitEUkIzYUl0dzNDZHhCZk0xZkxtR0RET2VTV0ltTXBk?=
 =?utf-8?B?ODJmd0xRanNPTVYxNlFwR3ZIeW1YSzA5UFpYSnNIVU4wMHhjVHMvZ0xxVmEy?=
 =?utf-8?B?K1p5bld1Y1JRTmhTSWgzK1NFbE93Wk12RzFscVlHVVF6ZWhUL1JCdUxTZ2NH?=
 =?utf-8?B?K1cxMmRLdFRBeUtCTWM1eng4eVU1cmVabkhybUhqN29obUtzaVJrNFZnQzAx?=
 =?utf-8?B?OUVnejNjUU5DK0xNYTI4OGVPL3ZhSklhUTR2Smd6MVRDdUp4SDdDejg1NnVE?=
 =?utf-8?B?M1ZCSWJBMENWUXA0cy9kK1JpQmNYVEphVDlLMnh4UkRkYlhZTzVQMjl1bS9T?=
 =?utf-8?B?djB6TCt0ZHh4WTNwd2haLy96SmNtYW5mZGViUllyVnc3VElMVUhNcUNZam9B?=
 =?utf-8?B?K256djJQbFMxcDY1RzBicE15TGNXdStUVVptM2ZrSVM0cjA2cUNHazJPNjVs?=
 =?utf-8?B?OG1HTzkxcUdTd2NWaEVtRFBINDg3bDJ3RGdUTXYzdjRVcCtTenJsLzlFM3g3?=
 =?utf-8?B?QjRIWWRRNHRIbEQwQm5SU3dpZlZ1UHBhRC84R2tZNklpK2J3eWlyU0l5NU14?=
 =?utf-8?B?ZjVEd0ludXpSaGhabGg0ZVQ0M3hEZ2piWUJQbGwwazh0Q0JOWVdpaExBeDE2?=
 =?utf-8?B?ZkxwV2hDdU9uSUhibnNMMzh1Z1l3K2MrdURQMjN2ZmVDMFdTdEdrOTg3cFZ5?=
 =?utf-8?B?dnFUZDE0UWZkM2tiaHRUSzB1UXR0OWVqWXFibE9RUXhZK2UrYUU5cDZtaUdF?=
 =?utf-8?B?KzZ0K1lhUFRxQXJvS1hQNk40cG1POGJlSTdvL2pJYlVnckFSTWFhd1pjVXJF?=
 =?utf-8?B?MzE2blptcGZXaTBXL29XZ2NXZ0x0eUVsZG5LeGdKWWZOZEYwWEc2eHE0dDdp?=
 =?utf-8?B?cklhdTZtaGVmclBPMWpTaHFlQ3RFVGFHcEE0Q01IeVIyRkRKOEtaMmkrR2Nx?=
 =?utf-8?B?RUY0YzUvd0xsVC9sYlBOYUZZRkMzMjB2cXBZcVZNY1doNTdDa1hYU1hzN0xz?=
 =?utf-8?B?ZkRZYzRDbHNRanU1VnJxaUVSVkJVY211VERLQ0RLRGFwbG9LRVJLQzFWOXFp?=
 =?utf-8?B?L1VBZkhGNUtmNWdoa3d3bEx2d0M5S1Q3VmZiTUxjb1VKZkpMWVZkTzBWaDE0?=
 =?utf-8?B?WGNpNTk0cjZSQWdvWTE4dzBST1BxbnhsbHJxZFpsa1B0T29BQVRFeUJrMTlw?=
 =?utf-8?B?WUR0UHhKY1JlenFOYXlPa29CY1hlK2R3Szc3cEo1WUhCSzB4MmZub1d3VWh6?=
 =?utf-8?B?VXROVUlVS0dVVm9sdmt6RHFkRTFqNjgyMWxlZzR3VkRZTFRqWE4vSjg4Y1ZC?=
 =?utf-8?B?aVNuNkw0cTNWVkZPZlptd240My9IbVorYzI4ejF0MWNJeWdQRFl4MFNjcjI5?=
 =?utf-8?B?RDZyeU85TGtVaTlzd29BbmpNOFdsWHZoNzI2a0dTeFNDenpzNjJKYWxwaWxS?=
 =?utf-8?B?amRxMjJXS2ppdU4zM0syNVdMYUcrTGdKNzFvRHJIbFJjclV6UWp1N1dNaURz?=
 =?utf-8?B?RnlObHp3VzdWaGgzMnk3dXdKYlpjOG5mbEIvWE1Sd1FJeTRLOFJSbVlCME1K?=
 =?utf-8?B?VmN0TjVxNHZ6S0xGT2lzVUcwZHFkRU0rc2JKUnFJS2tralMwVmdRbmVxMEo3?=
 =?utf-8?Q?rkUAp/tzE8Lj7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wlh0amtuNDBuN0hxemJXQU1oc0hMT1NueUNpSTlOZW1NdUY1b3V0bG9kSlRp?=
 =?utf-8?B?SzBHZU95UXJlMEM0UkZRcGxvd3JKeEc0MUlTQTlNZ1EraEpRZjNoVEdVTkJo?=
 =?utf-8?B?WnkvVjBxUnpGSDh5TWdranExR3c3YldlQnBXOTlJV2JzV0l1eFJERmhpU3d4?=
 =?utf-8?B?cG9ncGhNZk41RWdsUFdqSldwNVlONFlOQm1Lb0prbE9BZlVkQWFQQnRLbFh2?=
 =?utf-8?B?VUZycXFlUXpuR1dOaTVQd2VZRlZtT0pmWkJzRWt6cVpueFhPeTNHaXEvTmJu?=
 =?utf-8?B?YS84VVliTDR0SEJsQXBRaThjSkFBT0M1SmlFUTM2U3hBa1lHcnVwOGNRcElz?=
 =?utf-8?B?TUNTWE9qUXdKTkFnei9ST1A2TTU0RUwycnpNMnFONldNMXA4V3VhUnNnSG5L?=
 =?utf-8?B?SG8zZjc5TmhPYklrUEZESi9NOEhweHJWL2ZDaUlHdzVGU2FISFd6dFJMUnN0?=
 =?utf-8?B?TitEdGRHVDVkTHppeGs4RWxSNWwwcWZXbGRHWnhla1ZjZU5uZVdDeEN3NW9r?=
 =?utf-8?B?cms0ckVEcktVM29JcFE4QXVhUjFkckpvclU3MVZYNVZjSkRtSVNtS3JBd1k1?=
 =?utf-8?B?SzdyamJ4cWV6NTc1ZlR5MituK21tRzRuVHloTGpyTjlqM0EwbDZaMkh3U0RS?=
 =?utf-8?B?MktTaWV2K1doZ3o0eW1lVndiVU82NTZqTnpIRDJYQUQ4RyswNTE1OFZMWmdY?=
 =?utf-8?B?Mkh2RDJWaFdnVHZiRHF4RVljRnRIQndGU1NQc05vamlEZ0NIUEQ0M0d2c1FK?=
 =?utf-8?B?Y1B4NDU3NWhKeEdsMytvNFNObnVudGEyMjNrZC92ejZyWnk3WkNKSzNWYm5V?=
 =?utf-8?B?S2tBTHZkSE5NYVppNERiTndVTGIzaXNHWFUzQVFGczh3c1lMZnBGVy9kaldL?=
 =?utf-8?B?SjdHMUFPcEo5Z3RQUno2dzR3UG9jamZETGNzOUpjQ1V2cnI2MDAyTmxvYUow?=
 =?utf-8?B?R2dxbE40NFJmVDExNmFsK0FTWDc5NW5wbXJSU2MrOTgySzdpZUNVMHBBbmxo?=
 =?utf-8?B?WG5SUlNIa052ZUlXVVc1VHNibnpxeDZWTzRQbk94QjU3U01FUDFwdEtvcDQ3?=
 =?utf-8?B?NncyWlBRS3h1S0c0a3BZWDJiMXpucUM1TTRrLzI4YnJkcWJxVTJuSWVta0RR?=
 =?utf-8?B?SHZyS29RL1oxckNFQTVxYWE4OGc5TnVCVFl4NFV3UFptUThKbVdjeFJwT1BF?=
 =?utf-8?B?bzlXMVd1aURMVWExWjJQMHNaSVJUUUZKK1pEWW54S1BtWlE5ZXdSaCtHZ1gx?=
 =?utf-8?B?QTl2VWE0ZTE3MThzTW5MZVlYZE82V0hZWlJsZHlrbkFyUlk1RWdlQ0lxZnF4?=
 =?utf-8?B?Q01teU9wRFBZbExjS3F1TVVyMmkyWE93ZU9KQU5kU0lLQzVmM1BwN0JaNWFR?=
 =?utf-8?B?aExIc1l4UHNpcVlFaXkwanE4MGVKSVV2dDFVczdlOHBRL2JQYlNLNnZDZVJS?=
 =?utf-8?B?UnYvOFJ1elFJQzFGTlRZSENJQ1ZmbDgrTnpSb2t3V29JUDRXQ0V1ZnBxOXZq?=
 =?utf-8?B?cFJuQUFWVGgzNEhsTnJGL04xLzN4Y2FUMS9uUEdXVHFyNDJucHRTMVpoMDJG?=
 =?utf-8?B?K1RjZmxTTklZV3RLK1lKbHB0TG5zaFZHZnFJY001L3haeWx0QzhuQ3JrYzNp?=
 =?utf-8?B?RTMyNWlBbllXQzUvYjdMSEZ6bjd2UFpVV1FQRTgrTm5YMk9MUU9DVjN5SXZn?=
 =?utf-8?B?dDA5OVZscEMzeFE5SnR3eldWS3JtWVNkemk2Qjd3OTk3K1pWRTl5Qmxaa25y?=
 =?utf-8?B?Rm1WTjRocEdjRGVOYmxMdi8zNUlVSnArdGloV3FoY3JYYlhqNENFT0R1RjNN?=
 =?utf-8?B?cjVpcmtNeWROUDNFSVB2S040TUVPNnlpTWdvY0w0RnlqdjgyTjU4aVUvbXhQ?=
 =?utf-8?B?NTdLeXNiMlJHMW5HaTYzVXR2SUplQWhvVUhjTGdRTTBmQ3hsMVdqcXQxMXpL?=
 =?utf-8?B?YnVjYUJMOElaWDRCUnpsMTJrQnlZWE8xZ2dLK0hEMlp2UmJwWTlqM3BxWGpR?=
 =?utf-8?B?N2RqOWVBUXBGVXp1cEZ3NGxUVjRFN0thQm03RVVFWEV5VSsvYk81VzFXeEFC?=
 =?utf-8?B?Q1V6RTBUWHBZSDU2cDFQd3VMalF4cmtoSHhScUt4SmlyWk9zZjRneGFrTjJN?=
 =?utf-8?Q?vM+145IT1UlCeGBX5pY+2KZWx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd19d877-6dc4-46d1-8911-08dd444251dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 11:02:58.8146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvDYYya6CLbOuhTXH1yjiHwj26WexyrKtC3LKBcEf1Bp9W7faziGM1qiGcMsxuzftsDhdkIa9r6LNGk48dAOBmpG5po/4qhNZNSt1/Ca+wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7400
X-Proofpoint-ORIG-GUID: g_nOiTf3HYb8Wy3NZp6GNXGeNpp-SWDd
X-Proofpoint-GUID: g_nOiTf3HYb8Wy3NZp6GNXGeNpp-SWDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030084

IA0KPiBPbiAxLzI3LzI1IDQ6NTcgQU0sIEFudG9uaXUgTWljbGF1cyB3cm90ZToNCj4gPiBBZGQg
c3VwcG9ydCBmb3Igc2VsZWN0aW5nIHRoZSBkYXRhIGZvcm1hdCB3aXRoaW4gdGhlIEFYSSBBREMg
aXAuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxv
Zy5jb20+DQo+ID4gLS0tDQo+ID4gbm8gY2hhbmdlcyBpbiB2MTEuDQo+ID4gIGRyaXZlcnMvaWlv
L2FkYy9hZGktYXhpLWFkYy5jIHwgNDYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMuYyBiL2RyaXZlcnMvaWlvL2Fk
Yy9hZGktYXhpLWFkYy5jDQo+ID4gaW5kZXggZDJlMWRjNjM3NzVjLi4zYzIxM2NhNWZmOGUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRjLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMuYw0KPiA+IEBAIC00NSw2ICs0NSwxMiBAQA0KPiA+
ICAjZGVmaW5lIEFESV9BWElfQURDX1JFR19DVFJMCQkJMHgwMDQ0DQo+ID4gICNkZWZpbmUgICAg
QURJX0FYSV9BRENfQ1RSTF9ERFJfRURHRVNFTF9NQVNLCUJJVCgxKQ0KPiA+DQo+ID4gKyNkZWZp
bmUgQURJX0FYSV9BRENfUkVHX0NOVFJMXzMJCQkweDAwNGMNCj4gPiArI2RlZmluZSAgIEFENDg1
WF9DTlRSTF8zX1BBQ0tFVF9GT1JNQVRfTVNLCUdFTk1BU0soMSwgMCkNCj4gPiArI2RlZmluZSAg
IEFENDg1WF9QQUNLRVRfRk9STUFUXzIwQklUCQkweDANCj4gPiArI2RlZmluZSAgIEFENDg1WF9Q
QUNLRVRfRk9STUFUXzI0QklUCQkweDENCj4gPiArI2RlZmluZSAgIEFENDg1WF9QQUNLRVRfRk9S
TUFUXzMyQklUCQkweDINCj4gPiArDQo+ID4gICNkZWZpbmUgQURJX0FYSV9BRENfUkVHX0RSUF9T
VEFUVVMJCTB4MDA3NA0KPiA+ICAjZGVmaW5lICAgQURJX0FYSV9BRENfRFJQX0xPQ0tFRAkJQklU
KDE3KQ0KPiA+DQo+ID4gQEAgLTMxMiw2ICszMTgsNDUgQEAgc3RhdGljIGludCBheGlfYWRjX2lu
dGVyZmFjZV90eXBlX2dldChzdHJ1Y3QNCj4gaWlvX2JhY2tlbmQgKmJhY2ssDQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgYXhpX2FkY19kYXRhX3NpemVfc2V0
KHN0cnVjdCBpaW9fYmFja2VuZCAqYmFjaywgdW5zaWduZWQgaW50IHNpemUpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBhZGlfYXhpX2FkY19zdGF0ZSAqc3QgPSBpaW9fYmFja2VuZF9nZXRfcHJpdihi
YWNrKTsNCj4gPiArCXVuc2lnbmVkIGludCB2YWw7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChzaXpl
KSB7DQo+ID4gKwkvKg0KPiA+ICsJICogVGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgdmFyaWFudHMg
b2YgdGhlIEFYSSBBRDQ4NVggSVAgYmxvY2ssIGEgMTYtYml0DQo+ID4gKwkgKiBhbmQgYSAyMC1i
aXQgdmFyaWFudC4NCj4gPiArCSAqIFRoZSAweDAgdmFsdWUgKEFENDg1WF9QQUNLRVRfRk9STUFU
XzIwQklUKSBpcyBjb3JyZXNwb25kaW5nDQo+IGFsc28gdG8NCj4gPiArCSAqIHRoZSAxNi1iaXQg
dmFyaWFudCBvZiB0aGUgSVAgYmxvY2suDQo+ID4gKwkgKi8NCj4gPiArCWNhc2UgMTY6DQo+ID4g
KwljYXNlIDIwOg0KPiA+ICsJCXZhbCA9IEFENDg1WF9QQUNLRVRfRk9STUFUXzIwQklUOw0KPiA+
ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAyNDoNCj4gPiArCQl2YWwgPSBBRDQ4NVhfUEFDS0VUX0ZP
Uk1BVF8yNEJJVDsNCj4gPiArCQlicmVhazsNCj4gPiArCS8qDQo+ID4gKwkgKiBUaGUgMHgyIChB
RDQ4NVhfUEFDS0VUX0ZPUk1BVF8zMkJJVCkgY29ycmVzcG9uZHMgb25seSB0bw0KPiB0aGUgMjAt
Yml0DQo+ID4gKwkgKiB2YXJpYW50IG9mIHRoZSBJUCBibG9jay4gU2V0dGluZyB0aGlzIHZhbHVl
IHByb3Blcmx5IGlzIGVuc3VyZWQgYnkNCj4gPiArCSAqIHRoZSB1cHBlciBsYXllcnMgb2YgdGhl
IGRyaXZlcnMgY2FsbGluZyB0aGUgYXhpLWFkYyBmdW5jdGlvbnMuDQo+ID4gKwkgKiBBbHNvLCBm
b3IgMTYtYml0IElQIGJsb2NrLCB0aGUgMHgyDQo+IChBRDQ4NVhfUEFDS0VUX0ZPUk1BVF8zMkJJ
VCkNCj4gPiArCSAqIHZhbHVlIGlzIGhhbmRsZWQgYXMgbWF4aW11bSBzaXplIGF2YWlsYWJsZSB3
aGljaCBpcyAyNC1iaXQgZm9yIHRoaXMNCj4gPiArCSAqIGNvbmZpZ3VyYXRpb24uDQo+ID4gKwkg
Ki8NCj4gPiArCWNhc2UgMzI6DQo+ID4gKwkJdmFsID0gQUQ0ODVYX1BBQ0tFVF9GT1JNQVRfMzJC
SVQ7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJl
Z21hcCwNCj4gQURJX0FYSV9BRENfUkVHX0NOVFJMXzMsDQo+ID4gKwkJCQkgIEFENDg1WF9DTlRS
TF8zX1BBQ0tFVF9GT1JNQVRfTVNLLA0KPiA+ICsNCj4gRklFTERfUFJFUChBRDQ4NVhfQ05UUkxf
M19QQUNLRVRfRk9STUFUX01TSywgdmFsKSk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBz
dHJ1Y3QgaWlvX2J1ZmZlciAqYXhpX2FkY19yZXF1ZXN0X2J1ZmZlcihzdHJ1Y3QgaWlvX2JhY2tl
bmQgKmJhY2ssDQo+ID4gIAkJCQkJCSBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICB7
DQo+ID4gQEAgLTM2MCw2ICs0MDUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19iYWNrZW5k
X29wcyBhZGlfYXhpX2FkY19vcHMNCj4gPSB7DQo+ID4gIAkudGVzdF9wYXR0ZXJuX3NldCA9IGF4
aV9hZGNfdGVzdF9wYXR0ZXJuX3NldCwNCj4gPiAgCS5jaGFuX3N0YXR1cyA9IGF4aV9hZGNfY2hh
bl9zdGF0dXMsDQo+ID4gIAkuaW50ZXJmYWNlX3R5cGVfZ2V0ID0gYXhpX2FkY19pbnRlcmZhY2Vf
dHlwZV9nZXQsDQo+ID4gKwkuZGF0YV9zaXplX3NldCA9IGF4aV9hZGNfZGF0YV9zaXplX3NldCwN
Cj4gPiAgCS5kZWJ1Z2ZzX3JlZ19hY2Nlc3MgPSBpaW9fYmFja2VuZF9kZWJ1Z2ZzX3B0cihheGlf
YWRjX3JlZ19hY2Nlc3MpLA0KPiA+ICAJLmRlYnVnZnNfcHJpbnRfY2hhbl9zdGF0dXMgPQ0KPiBp
aW9fYmFja2VuZF9kZWJ1Z2ZzX3B0cihheGlfYWRjX2RlYnVnZnNfcHJpbnRfY2hhbl9zdGF0dXMp
LA0KPiA+ICB9Ow0KPiANCj4gV2h5IHdhcyBbMV0gbm90IGFkZHJlc3NlZD8NCj4gDQo+IFsxXTog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LQ0KPiBpaW8vOWMyNjJmNTk5ZmI5YjQyZmVhYzk5Y2ZiNTQxNzIzYTBhNmY1MGU2Yi5jYW1lbEBn
bWFpbC5jb20vX187ISFBDQo+IDNOaThDUzB5MlkhNnVWeXRBd1dVQ3NFYXpPVVRBQ2VjTVFrYk11
SEJGOTVzYmxhNTBDYlRVRmtaa3l4Uw0KPiAtUzdqTU9DY3pwb3lLQ2p0QUt2TU95cnQwdWtZd2NY
Q19sNXE2MCQNCg0KSW5kZWVkIGl0IHdhcyBub3QgYWRkcmVzc2VkLiBJIHJlbWFpbmVkIHdpdGgg
dGhlIGltcHJlc3Npb24gdGhhdCBhZGRpbmcgcGFydCBwcmVmaXgNCmluIHRoZSBtYWNybyBkZWZp
bml0aW9ucyB3YXMgZW5vdWdoLiBJIHdpbGwgYWRkIHRoZSBjb21wYXRpYmxlIHN0cmluZyBzdXBw
b3J0Lg0KQWx0aG91Z2ggSSBoYXZlIGEgcXVlc3Rpb24gaW4gb3JkZXIgdG8gbWluaW1pemUgdGhl
IG51bWJlciBvZiB2ZXJzaW9ucyB0byBiZSBzZW50DQpJbiB0aGUgZnV0dXJlLiBTaG91bGQgSSBh
ZGQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhlIGNvbXBhdGlibGUgc3VwcG9ydCAod2hpY2gNCndp
bGwgbm90IGFkZCB2YWx1ZSBpbmRlcGVuZGVudGx5KSBvciBzaG91bGQgSSBpbmNsdWRlIGl0IGlu
IHRoaXMgcGF0Y2ggd2hpY2ggYWRkcw0KY3VzdG9tIGZ1bmN0aW9uIGZvciBkYXRhIGZvcm1hdCBm
b3IgdGhlIEFENDg1eCBJUCBjb3JlPw0K

