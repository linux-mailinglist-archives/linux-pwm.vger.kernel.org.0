Return-Path: <linux-pwm+bounces-4685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E96A16C6E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 13:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB4D3A5166
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296E1DFE11;
	Mon, 20 Jan 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Lcy4HX6d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51F1B86F7;
	Mon, 20 Jan 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376665; cv=fail; b=bY+YMRb7cAEsttMunOb3oq224ZfbSe6ThYHrIbbgE46HwbQobZ+p59N/usSjjA36rVGdI9jBck6b0MjVW3R+0pia0kccRH0P19g133RXafxpTJQvemkAq6Bh2V7lx/OY6lZt7ZJeiTWIVd5scQLR/UQYB7SeUZcAAkldl1qDc5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376665; c=relaxed/simple;
	bh=ogNHhVmu3CvaNhYSuCPpASPSTOnEWubqgbs9fwDTNLc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IGxfUeNITH0mi1D//u4aVXiIOEHSpGC3VxCdflw4jn/4XfguHJfZZkk08U94WTvEc5RYN27prTga0plCOwOkPLfzyrMQo4/V22D4BflETfbaxV1SHKKRBCLKUT4pe4famX43LAVIZu2zZ3xJa5jQgz2PmvyX3vPI/R5VzB5wtpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Lcy4HX6d; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K8x414006756;
	Mon, 20 Jan 2025 07:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ogNHh
	Vmu3CvaNhYSuCPpASPSTOnEWubqgbs9fwDTNLc=; b=Lcy4HX6dHF+oq2N41rKWE
	TkrrvS4sdKB7VptBjcAV013S9bBffyESG8lvUlr4EtkmhE1w6vQkztQy2GU5Bzz5
	AzQc466zwfS1wKlVfqdSZaleaniH/yyN0LLfWyis0ay6DJKsfuyjhBoAsaIgOH3f
	C9tfJAZJOjZS4YfUn8JxMvpa5jlJuOi0FbN4tzAyJPdpZHcvE9Z6nfvBWsOGVzUE
	zZExZINQC2D3NZ8bgBXdWqARFpC752AmyGGTh3h2qwznD26NE1lTP/9BCFpfYLJY
	y25+bEYpiCIIN7VQgPnNk7eirFJzATroEGtFrM89WN1hQ9nYk2uRrf+ZoO/R8Eid
	g==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.9])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 449eushvxy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 07:37:29 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct4JC24G5s6hQZiJ8qI5OHBloo+0/vfELFWIFmEmlSg6sWWckP6xGgKp/k8QP7SVDvvTvsDAPl9JN0+2e5W/Xjnh6XdQfY4qrOAfmyVhgKt0XF5Yx3mtP+oJLE79SPC+mkvdadYn652iEdKoC3xCAjoODsbFN5P4SO3PwVzLDAowmyfm1Gm0ckAiVC6f3w3zPQRxLrNKCAgHRMnKbsW0BeREdhHJkUqn2pJso3ld3F5/zGa6nPcQ+ACaMajivgr9YZ9XpikP+68IVh1QKl7ByltZg+3wFSlBGxxJGnD7ClREwM9USsNm3KNrjGqn+NGJwJiSbgRu9YDL6dDVQDh0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogNHhVmu3CvaNhYSuCPpASPSTOnEWubqgbs9fwDTNLc=;
 b=MJy95WScw7LqhQfxoaVvZ+vM4DuceI+jjKMI+WrVxpf+p1Pg3aMsWn8wj/b80aqsaOSzyxhEq2wE+GGlecOa8rEuHBBuTDfiHPiFKZNmqkw73SfCO5hre7a5Erpq0JlYybhGt4fhRKFexaMJ5LsHbGZ9v4O5e4OecS40p8aLrw0SACFSX6hnWWbPhQmlPw/vAgogoPuM438oFtXBFUu5GPDpeFHDnGAuppB/q77RsClgPBsplEH7j60Wk1eFQ6fhFVWf6mstef5UuGbPmNi1lwVGpk7pewmpxLbtn9KzEzVQHBNOLbJH3LortYu+V/e282x9Oe0kTx+FPh79K0bIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN6PR03MB3395.namprd03.prod.outlook.com (2603:10b6:405:3f::23)
 by SJ0PR03MB5840.namprd03.prod.outlook.com (2603:10b6:a03:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:37:26 +0000
Received: from BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::cce9:c4dc:ed0f:f7d2]) by BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::cce9:c4dc:ed0f:f7d2%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 12:37:26 +0000
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
Subject: RE: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
Thread-Topic: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
Thread-Index: AQHbaODGvTepExZjxE2VdhkNmjcY17MbgIWAgAQdQMA=
Date: Mon, 20 Jan 2025 12:37:26 +0000
Message-ID:
 <BN6PR03MB33953EC70A02D0031373C2BD9BE72@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
 <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
In-Reply-To: <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwWXpZeFlUWmhZeTFrTnpKaUxURXhaV1l0WWpBeE9DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTkdNMk1XRTJZV1V0WkRjeVlpMHhN?=
 =?utf-8?B?V1ZtTFdJd01UZ3ROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNVE0xSWlCMFBTSXhNek00TVRnMU1ESTBORGN3T1RreE5EY2lJR2c5SW1K?=
 =?utf-8?B?R1RreEdhMmwxY0VGek9HTXZOVWhqZVhsNFJGaGhjbmxrVFQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVV3M1luTlBUMGQyWWtGbU1GWlZTRlZOYlRKTmFT?=
 =?utf-8?B?OVNWbEZrVVhsaVdYbEpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: BN6PR03MB3395:EE_|SJ0PR03MB5840:EE_
x-ms-office365-filtering-correlation-id: 454ebcf4-d7cc-4d1b-6f12-08dd394f325c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlpKRUMreGk3djdBcFRMTDh0VThobGxmdWFRN2pQdVU0aGJaL2krUEFMaHdZ?=
 =?utf-8?B?ZDFwREJOd0o4dTZXbGJkSUg0emYyMDJwY3QzZjhFRXUwRkJscG53cnZNalZ5?=
 =?utf-8?B?Z0RqMTFNSStJS0NUWWxjaUcwTkUxTlV0YjM3azlwY1NPQmlrRTFGV0JFL1Ay?=
 =?utf-8?B?QUpLczdNdXJKV3FHeGovRkJ1OGNaUFZrK0FWYUFldzZFaUl1OFBGckpUTVNm?=
 =?utf-8?B?dmFxb0RnMmVjSE1mUGloc0FoUUw3WFBCbEc1Y1MvczVQY1Z4QmVrV1VvcnVn?=
 =?utf-8?B?V0NDM0NZd1Y0dk5nWmkvME5FRnhXcUJlSDRsU1YyLzFKQ01vR0hrSElkbUM2?=
 =?utf-8?B?a0huWVVJeTFiMTJiWXRKZkZwWVJqS1JFdmhuVGV0L3dmYXhKSDVxeFBLWDV5?=
 =?utf-8?B?NVViQlRuc2FpWWI0bzBCNlZWam9lOVVad043cU5LTmtrcTJzc2d5eWVRUjFx?=
 =?utf-8?B?OFhMOHdFaW5lKzhSQnBna1pSbExPMU5JT3FoeHBGZ3Zpa3doVVNPUWtNb1Jq?=
 =?utf-8?B?K2cxSTlaenlQMmdzUjY4TWFMTXBIV1FXaldQWER4RktzSGxualJNYkYrTEsx?=
 =?utf-8?B?WlQxd1JrWldpR3VSRlpPUTVHSDVNUTdNOEJLN1V4QlYyclFDTEVTNnZWaHlq?=
 =?utf-8?B?OFdyS0d4K2pmYnZBVW5abGhsVDNkc25ReE93TXVXR0duaW1HVi8yN1pMMEpQ?=
 =?utf-8?B?UVFpU2RiY3o0OWE1YzdGclA2S2NjZHJaZkdySEl0dllTaEVpTTE0SkpCYTFL?=
 =?utf-8?B?S1IyTUtUYVJoNitZTThHVUs4SHo0cnpYa2hwMGkzSW1EaTJNckxQL0ZMZWN0?=
 =?utf-8?B?amx4ZGhmdHl3NG9LeE9KRVZEOWJTdVVraFlGU09BcUJuMDM0QWdJblFnSG1W?=
 =?utf-8?B?OU1PT2Izb05mOUMrRnY3ckxpak5UTHgxVlNJK2w3aWo3SnBYcFB1Mm1lbDFG?=
 =?utf-8?B?S3JVVWYzVmFpODFCcWZHeWtuNUpzdE9BUkVLTGJObUppSXVEa2M4ejdkVmhO?=
 =?utf-8?B?NGE1VFEyVUVVT3RjaXIzL1d5UEduNWpMZllCL3BKOVJ6eFJFSDQrTVYvUEVE?=
 =?utf-8?B?TjBQODJpYmQweUlqZ3BhdVVoWS9jY25KQ0ZWaE8zazBuRVJBSTRGcjl3b29w?=
 =?utf-8?B?N2NwS2VrNllVa2dVQU5mZGxlZ2JuelErTnl5eS9iMTZxZUJTS29adlBsN1Ri?=
 =?utf-8?B?UzRMaFBDazRORTU1bSs4ZFF4VzQ0QitXZWsvdzJZT1NxK2JZTHhPcXdTbC9w?=
 =?utf-8?B?MjVZaEVqajJDL2dXRHZ1MFArU21KU1VZYXlFNzUwMjJsVk11R1lRUVdmcGN1?=
 =?utf-8?B?cUNBR3dYaXl0RW9FeUxLNHhxUDRHMG5iTXpLdGRQOW5yMDZvVFJ0OXM5M3U1?=
 =?utf-8?B?cDg1SGIrTW9UUmhQY2RPS1YrNlYvMjZCckhZRytEUVVOeXMzL0YvVXdJRi9t?=
 =?utf-8?B?cnJQV1pKMTVPZ0kwSDdrbFo5MktKZkpUMzZzKzUwWUVRM0Y3UzdLMDk5RG12?=
 =?utf-8?B?S210Nmt2QkRmcUp3cHU4QmkrbExESVN0L2p5eWhjRk1GejVxazMzZ3FWMXNW?=
 =?utf-8?B?cEdyTkhEVmloS3psRnQzYjVaOXU5V2hSOTVxQ1RPenZMQXhQbG9HNWhqSW5U?=
 =?utf-8?B?TWJaSGY2dktJTGpsY2FoamNlcklGNjcvL1QydGtlSkt6Ti9ueng3NFV6UXZM?=
 =?utf-8?B?eFpZQkRIalJsYWRWVDZlZ2xKQ3YzbzdMRkVmckQyWk1iYllPcVRuUVNEbHJ6?=
 =?utf-8?B?UldXK3JGejJENFdlb2tqbEZBL0gxQWk5VTAxQ1JYSWQwOE1KaEVIYTNhcXc0?=
 =?utf-8?B?ajdJeXp3OGNtNGROSnZQSDBuMWpBNkFvOXR3aGlnNWpiK01GTWgyZkgxV2l4?=
 =?utf-8?B?SG5LcktVRzZEdUVIS3Q0ZXpWbEl1RWEvTTZMNllCVjRWclNvMVhiZU54dkFF?=
 =?utf-8?Q?8Xmhvw97SNvrT9gwRkThdMpS37gqPkGI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3395.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sy9qZGMwcnBLR09CcStMdU8xeXMvTDB6RGxnUU9VaitNa3psQ2xrdUFnQ3BG?=
 =?utf-8?B?NDc5UVROblJxWEZWUE13SmJ4QkNEeDc1Zi9XeFdqWEtaaGpxenhUZnlZeE4z?=
 =?utf-8?B?a0IzQUJxM3ozQ0oxRUp4U3RiZTZGWTFvcUxqY1ZXalJHM2krTnZtT3RyWDlI?=
 =?utf-8?B?YjdJYlg1N1RBNUF4Ni9MMENVeWpHTnBEcHB5b3EzeCt1RmZobXczQjB2ZVNR?=
 =?utf-8?B?bENaUEhjOUZrWU9ZQis3VkRlZTlhMDAzVmhnaE5yRW9VaWM1aVFBQUNNTSs3?=
 =?utf-8?B?UXNNbkIzb09YbCtDMzdueTRkdi9QQmIrMDk2QVpxS0R0bmpHdlZwQXoyVU5j?=
 =?utf-8?B?ZUFZb3hNdEFueFRPVC9GNkNldXRqODhyaGFvMFIrT28ySS9uTXpka3FTTGJS?=
 =?utf-8?B?dTJTamVsL2pvZnJmcE1zeFFlaFNjcjZSbWpQNi95ekxXbDNERGxtbkI1cERM?=
 =?utf-8?B?OGZKVzMzTUhxWVJGWFBHQkxlN1Nib2lhN3d1NUpiSDMrbjcramI0VStHVTly?=
 =?utf-8?B?eWN4MUxJbUtlT1JNVXZUd1VkVC95SWszYTY5cnVmSWZRb3BiWVFzcWlkRXpG?=
 =?utf-8?B?cGdyaEdPU0NHOVVCVVpuNHU0aS9VT3dHTUhEd0pubnJFRFEvQ1JqVzJVVFdZ?=
 =?utf-8?B?OEtpN3pRbFh0bWVNZENXYkFXODJ6VXpyQjBaZW5ndU1CQjJoMlBzZ3NFRVFB?=
 =?utf-8?B?eldZRW5SdG9ZTHBoTzlZc3JBOHFub0dIM2JzcWI5clV6S1dSZWw5UjlER1BO?=
 =?utf-8?B?b0VqcmtoSE5WQW5GVnVlaC9YYkE4dzZLRGJvU2Y3aVl2QllsSzdiclpFaGc0?=
 =?utf-8?B?TWp2eGpHV0xiRjh5ZmQ5SlR3clBrNUxJcHduQXV4THd2RGIyWXg4eVFQSTVH?=
 =?utf-8?B?NnhjbG9XWlV2L1VPSWlwcTAvZkFtTk50TmgzMEtFbGZsVFhLekdTb1I1VU5p?=
 =?utf-8?B?Rm9PYnZKUlQ1SkJYcE1ZcGhtQUU2Sm5idDd5WkFtY2M0K3gwaXZIczZNbHJ4?=
 =?utf-8?B?TkhLdkhlTDFuTCtPd3NyRmptanpidm1xTjNtM21jSWtqZDYrNW1aeWlaWEFj?=
 =?utf-8?B?K2xsbHRPL3YxdmlRZWxEa1dVT0JyWUhGZ2hhamFkOC9QbXFibU1hbis3RURN?=
 =?utf-8?B?WmtocHhFcmIycXR1NzFGUi9jYndJblZUK2tOdXo1YkJzWUhrWFFMdjBKVHRP?=
 =?utf-8?B?dUFaMVVmUHAwcGhYQWlDOFl2VVJHNDlNanpuV1BOMytORG42UzIxQ2JYM09D?=
 =?utf-8?B?dU12NzVlZEdPaHpqTkx3MjdoczlnRTUxMnM5K0tzUUgrQ21ueUg4bkM1L0Nz?=
 =?utf-8?B?VTBwTGNRWmlURGxwVjAxaU1lcVpydk12cTM1SE0rYUsvbEtSOWVKMFFHRDlh?=
 =?utf-8?B?T1RLaGJpNXY4aFRyeVFZRk1ZR1VhaTMxWGQ2QlJrMmlPZ0ZXQTcrQnZ4T3lF?=
 =?utf-8?B?eXpJUmxBRkY0YkFMRGlnWkdHcGtxRkd0M0d1SUZ6cFUrSHNWdjdXSlBPUTFn?=
 =?utf-8?B?SW43b2pZbi9MOE1Eb29IZjdMUTRKa2E2OVU4MlpCUFRvbWoyUk9lSmFnODBZ?=
 =?utf-8?B?a0JNbGlxNDJjUjU1Tk9zM0NkZkFzSFprenp1V29Kc2EvdDVBWXg3c0Nvazc1?=
 =?utf-8?B?WUZnZEpNaHlwMVNuaFdyNkxPaWhiRWZQZDd2Um15dXBETWRmUzZIY09GWlVD?=
 =?utf-8?B?Q3VWUjhjclZ2aFJkR050QkdqNUVidnozdldwdG9QN0VyeUJFWU8vZStSeTJS?=
 =?utf-8?B?NUY4MXROcHRvNnZNZ00vbFBZcTE0aEV2cHdhUnpsNy9DSXFTSmgrZXg2TXdD?=
 =?utf-8?B?ejBuZk4wRE1oUjYrNVVpd0tmQW0zUWpFRWRnUEpnU3FIVGppVGFaVU5lSVlK?=
 =?utf-8?B?d3JaOXpiNytEWVVyUVJHVTdySzlNRjR5TUZMRlduRk5aZ2QwUENQWVpIUzBC?=
 =?utf-8?B?YXFMVkJWV1pRSFJJaXlGVDNSQmltNlNyVVdoUlVTZy9rS1llK3dMQ3FoSWll?=
 =?utf-8?B?QncvMjI2SE5QYzZQTU9JRFl5TlFEZmFVMWtrak1vZjJHdWV6SVR1dWJDWXRm?=
 =?utf-8?B?NjFlTkFsc1RjODlaR3g5TVJoMTI0THhueUIzejRIckVQUnJQd09STUIxRE54?=
 =?utf-8?B?SHVwOFZrRkY2Zi9Vc0tXWGYxcldIeGJkaW1JdE1zczd3UWlKQ1IvcUczTU1I?=
 =?utf-8?B?OXc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3395.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454ebcf4-d7cc-4d1b-6f12-08dd394f325c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 12:37:26.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uehx8QvInZBF3VbjOwrq7g31mJGuf5bcz5tIP5+FPtQcEVyricB9XlOrpLrMVVZ1gKSWMg93PxIiPbIER4nARnCnoyvIjV2uFcCnEUV238c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5840
X-Proofpoint-ORIG-GUID: biWaGNMBdQJM2RQ-aFRlG8pQ0zVgGixm
X-Proofpoint-GUID: biWaGNMBdQJM2RQ-aFRlG8pQ0zVgGixm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=790 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200105

PiA+ICsJCX0NCj4gPiArCQljaGFubmVscysrOw0KPiA+ICsNCj4gPiArCQlzdC0+Ymlwb2xhcl9j
aFtyZWddID0gZndub2RlX3Byb3BlcnR5X3JlYWRfYm9vbChjaGlsZCwNCj4gImJpcG9sYXIiKTsN
Cj4gPiArDQo+ID4gKwkJaWYgKHN0LT5iaXBvbGFyX2NoW3JlZ10pIHsNCj4gPiArCQkJY2hhbm5l
bHMtPnNjYW5fdHlwZS5zaWduID0gJ3MnOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCXJldCA9
IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLA0KPiBBRDQ4NTFfUkVHX0NIWF9TT0ZUU1BBTihyZWcp
LA0KPiA+ICsJCQkJCSAgIEFENDg1MV9TT0ZUU1BBTl8wVl80MFYpOw0KPiA+ICsJCQlpZiAocmV0
KQ0KPiA+ICsJCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
KmFkNDg1MV9jaGFubmVscyA9IGNoYW5uZWxzOw0KPiANCj4gQXQgdGhpcyBwb2ludCwgY2hhbm5l
bHMgaXMgcG9pbnRpbmcgdG8gbWVtb3J5IHdlIGRpZG4ndCBhbGxvY2F0ZSAoYmVjYXVzZSBvZg0K
PiBjaGFubmVscysrKS4gQXMgaW4gdGhlIHByZXZpb3VzIHJldmlldywgSSBzdWdnZXN0IHdlIGp1
c3QgZ2V0IHJpZCBvZiB0aGUgb3V0cHV0DQo+IHBhcmFtZXRlciBzaW5jZSBpbmRpb19kZXYtPmNo
YW5uZWxzIGFscmVhZHkgaGFzIHRoZSBjb3JyZWN0IHBvaW50ZXIuDQo+IA0KPiBJdCdzIGxlc3Mg
Y2hhbmNlIGZvciBtaXN0YWtlcyBsaWtlIHRoaXMgYW5kIGF2b2lkcyBuZWVkaW5nIHRvIHByb3Zp
ZGUgYW4gdW51c2VkDQo+IGFyZyBpbiBhZDQ4NTdfcGFyc2VfY2hhbm5lbHMoKS4NCg0KSG1tLCBo
b3cgY2FuIEkgdGhlbiBkbyB0aGUgYXNzaWdubWVudHMgaW4gYGFkNDg1OF9wYXJzZV9jaGFubmVs
c2AgPw0KDQpkcml2ZXJzL2lpby9hZGMvYWQ0ODUxLmM6MTA1NTo0MjogZXJyb3I6IGFzc2lnbm1l
bnQgb2YgbWVtYmVyIOKAmGhhc19leHRfc2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBvYmplY3QN
CiAxMDU1IHwgICBpbmRpb19kZXYtPmNoYW5uZWxzLT5oYXNfZXh0X3NjYW5fdHlwZSA9IDE7DQog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KZHJpdmVy
cy9paW8vYWRjL2FkNDg1MS5jOjEwNTc6Mzk6IGVycm9yOiBhc3NpZ25tZW50IG9mIG1lbWJlciDi
gJhleHRfc2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBvYmplY3QNCiAxMDU3IHwgICAgaW5kaW9f
ZGV2LT5jaGFubmVscy0+ZXh0X3NjYW5fdHlwZSA9IGFkNDg1MV9zY2FuX3R5cGVfMjBfYjsNCiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQpkcml2ZXJzL2lp
by9hZGMvYWQ0ODUxLmM6MTA1ODo0MzogZXJyb3I6IGFzc2lnbm1lbnQgb2YgbWVtYmVyIOKAmG51
bV9leHRfc2Nhbl90eXBl4oCZIGluIHJlYWQtb25seSBvYmplY3QNCiAxMDU4IHwgICAgaW5kaW9f
ZGV2LT5jaGFubmVscy0+bnVtX2V4dF9zY2FuX3R5cGUgPSBBUlJBWV9TSVpFKGFkNDg1MV9zY2Fu
X3R5cGVfMjBfYik7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCmRyaXZlcnMvaWlvL2FkYy9hZDQ4NTEuYzoxMDYxOjM5OiBlcnJvcjogYXNzaWdu
bWVudCBvZiBtZW1iZXIg4oCYZXh0X3NjYW5fdHlwZeKAmSBpbiByZWFkLW9ubHkgb2JqZWN0DQog
MTA2MSB8ICAgIGluZGlvX2Rldi0+Y2hhbm5lbHMtPmV4dF9zY2FuX3R5cGUgPSBhZDQ4NTFfc2Nh
bl90eXBlXzIwX3U7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXg0KZHJpdmVycy9paW8vYWRjL2FkNDg1MS5jOjEwNjI6NDM6IGVycm9yOiBhc3NpZ25tZW50
IG9mIG1lbWJlciDigJhudW1fZXh0X3NjYW5fdHlwZeKAmSBpbiByZWFkLW9ubHkgb2JqZWN0DQog
MTA2MiB8ICAgIGluZGlvX2Rldi0+Y2hhbm5lbHMtPm51bV9leHRfc2Nhbl90eXBlID0gQVJSQVlf
U0laRShhZDQ4NTFfc2Nhbl90eXBlXzIwX3UpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeDQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+
ICt9DQo+ID4gKw0KLi4uLg0K

