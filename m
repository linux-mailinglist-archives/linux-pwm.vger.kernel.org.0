Return-Path: <linux-pwm+bounces-3443-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610198ECBD
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 12:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900AD1C21CB3
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B9148314;
	Thu,  3 Oct 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hf2jpvO9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B671B969;
	Thu,  3 Oct 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950558; cv=fail; b=hmwIl0UGQKawJ3yqa6qWWJNLmqzVFUUtXX0m3muz/ynLNc0HYngVo+fTf6oj24m97D99XonKQxdVvlmU1336g5JtJP43+cheAXNMJ5EaNvYA+HgiCzpcRL3xpEx9LrbcJBYGnznBF+9hAEGl1ZMMCfMACjJSa85rKbMJ/xZp5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950558; c=relaxed/simple;
	bh=PphRnRUCnX6o66eoVO9J19GRHAxfbkpF/BIbKryfgTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6xM4pet5KsPtXToll8MtoUV05BpgEbRyoLrj1hR0bIg6KBHE6m+PSJ7qT9dRaN4zqjEPXYsNLDltMI3OvWKItItSYqjU5cQBdkoXBKz4E0noqPVRvauXKF/m0mjKCJZCm0Emz/Oi+egddwdFTo+zW8ElghgMRhrucZBpQYxMJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hf2jpvO9; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935ghqm023108;
	Thu, 3 Oct 2024 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PphRn
	RUCnX6o66eoVO9J19GRHAxfbkpF/BIbKryfgTw=; b=Hf2jpvO9CSvzMy1URvWMM
	pxErrRzBCmQjLdtbZfJIc9q0uQvM/6j5kMc82HSCvFgZvK2zsVZvUEln67gjRGbV
	TzOzoz4Rsm929SMC48WOwX5iB2o4fUhDvR3h5UK9lfGaeVziaMu7eHAd5BfybOBj
	RE0PaHOIdcodUCBaEu+HnOj5Lp53CH3LPD8iLVpZOHJM7+/FlTjw0dXB3fdOCh0H
	Da0plQnviucoGDKVaqb/wSxtkbqOJaTAUwGse2n4/90NMCIcjRqHvZsYYvpFQXRF
	U/zeiO1DOzYqUYnFHtBL/jfIPLbT1U3wkMCNyKoDifjGUjhsFC/vneSqvpUqRBDg
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012055.outbound.protection.outlook.com [40.93.14.55])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41xbj9nk6w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 06:15:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXJ3E6EkIPbjuqskj2rxR+C6tiW/A3/01MVuTgA/gboKBS02A6TNdHi1uBdfBexi3vaBEv/4BTbLUGMpuTK8rE9I8fY7H2rENHqVldUaHIa3+0iZ0CqvVWp+QSOtxCahEiPyW5FTIj0pP1VkNxaJGLar+B/bBckhz7Xjzi56PxrG05VyL0l4ml/1PDTVxro4K8t42+ibBE+sBkT/cQ0FcBzSs0MHPTaccmBGNH6OcXeHpRcbSVop0DYe8M+iBqGxSV35ZuipVBTTlU8YT5/gmDXANgvY1kDNei0eNjyw/k9p85sHbkwDIyRPiDNkYqUdticzVBPkosq9ok09l5JQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PphRnRUCnX6o66eoVO9J19GRHAxfbkpF/BIbKryfgTw=;
 b=ooLqGjRVfynRoDhs/JbXg2DGtJnWp9XONwnHBIo4Hn4x3AIsrUg09yvTcdmmDlGlmbp29/Sqe/n8lIzCHUXm57FF11uTy0oAy2W+4FLKFa3DQJ7nIpOHFutfRbNkOMHfk/e5gZP00H8Gbn1ywmhyNH7TiVOcN4jQC0RpribfeSPHjRG/YSdmHqBcIQFW+rBw5QFQ+Hm9rXkQNqqU5kIDyB/QHgWWq6yi3EgHUX71n45TsQXngCGGxJ0+qgSR1ciACNh138mZjj9rXBYMyorBgRnA8u/cG/K+41KRHQyajoWwPo1ICcJ3ElEz8r6j5Ruoh6Lshb1kohduTa9AxQjHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS0PR03MB7204.namprd03.prod.outlook.com (2603:10b6:8:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 10:14:57 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8005.024; Thu, 3 Oct 2024
 10:14:57 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Topic: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Index:
 AQHbDaHI9TSlXyKXhk60pta64z5+prJtga0AgARN+RCAABcUgIAAD0aQgAAFf4CAAuGo4A==
Date: Thu, 3 Oct 2024 10:14:57 +0000
Message-ID:
 <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
 <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
In-Reply-To: <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAxTlRNMU5EbG1aaTA0TVRjd0xURXhaV1l0WVdaaU9TMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTlRVek5UUmhNREV0T0RFM01DMHhN?=
 =?utf-8?B?V1ZtTFdGbVlqa3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOVGczSWlCMFBTSXhNek0zTWpReU5EQTVORGd4TlRJd01qa2lJR2c5SWpW?=
 =?utf-8?B?eUsyVllUMDVaZDJaeVkyZGpZbEEyZURkM1JscG1jR0pyUlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkdSNGNFbFlabEpZWWtGVllYZE9NakJaUVM5Nksx?=
 =?utf-8?B?SnlRVE5pVW1kRUwxQTBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS0PR03MB7204:EE_
x-ms-office365-filtering-correlation-id: e53f9af9-d35a-48ce-cf7d-08dce3943b70
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWQzOWNRanFnb0pvRFpTd251N2d3QmJGaDdhb1dvUmdIdXdLbDUveC9iWFNW?=
 =?utf-8?B?NnFhZ1NxZjVKQi9CLzhNQmE4RWp5bmR6NUpuSE52VHVKc2ZkTnNtTVo3VXdQ?=
 =?utf-8?B?L3NGajVCQXowSkZVNmVJQ25aQitJOExIQ3lEVEZ2cncvWjJVV2xRWkZsMXVL?=
 =?utf-8?B?WGh1bHhiZWRUMmorRHNOMEthYndZY05nVWtKOHgvRzRrOTIzZk9FaEsxZlNj?=
 =?utf-8?B?VW5FVjRHQWF6MWtIcDMvcW5DQjMvQnp3ZS9aYytENTB1YW1Md3JpWmpSQ1o2?=
 =?utf-8?B?czdtQTcrTGF5OEZUZHJJU0xiWWszcGp2THlLNGx2R1Q1RVc0ZllucjJuZ2NP?=
 =?utf-8?B?c2dhZzdqaDREbnZYcGtySk8zZFZKaDh1bXRBbFBlaS9jcS9NVDdUd1JjQTFI?=
 =?utf-8?B?aHpxYUlGWThEdzlqbDVvVnlJV3doTlpiVTBqV0w5dWhpRUFrLzBzTnpGTXdO?=
 =?utf-8?B?MG40V2MzRlJtU1dSU1NOMFZXMXRqbWFiejdWUXd4NHRvcmdRSmRWK3MrZklG?=
 =?utf-8?B?bG5ieUFaMDlneU5RWkJCd3A1U05KaUZabDJRSXJkQjFnUmtFcE9aL080NnJy?=
 =?utf-8?B?U2UrM3ZDUmNRd0lLSTc2NVhFL2lYV2VaTTJGYm1TYmZvLzZGN1R5VVBlMlZn?=
 =?utf-8?B?d3YzVzl5UTJOanFBc29KZGdKbGRBdVhFZUdSSzh0Zmx5N3owekl0dnMxRE9t?=
 =?utf-8?B?NHlGLzJMNzA1UDl1SWNlUDdELzFRQ1kwTm9iOFQrZGdoSmEySDdrVnN3cFdV?=
 =?utf-8?B?dGR2eXhJeU80bHNWQm1EVG02U1JiaFZpQll1L29oSHdqVFlrV3pTTmdMeWgy?=
 =?utf-8?B?WnRxcmRHUTIzMmVrWjdSbjZ2MnM1NFBEbWs5MXZJZitxaURJL3Q4ZWtWYU1F?=
 =?utf-8?B?L3R6RkFqUXBQaWxKNGxFUnRPR1krWldycXcxVCtkTFI3dmROSFNyNUNnWlpr?=
 =?utf-8?B?a1BrTjdObW5SN1hEakRVYTVrVFZ2a0d4ZmJINEx6TGNJY0dyQnI4emlxUDQz?=
 =?utf-8?B?SlU1V0tiSzhuWVM4SUR4emcveXNDdng0bEVFUC9hQlg5U2ZkeE5BSXBWdHpp?=
 =?utf-8?B?QWpqRFR2S29mc2I1SEtyMER3dkh0V2lld3NyRHZTNy9VR21NbktNaEtWcWRa?=
 =?utf-8?B?c3hUYlFJbE5ZQ3Y5dno0M21xSFVnU2RQR3B0c0p2YUNtSWZEN3pJRmpuYldL?=
 =?utf-8?B?c3N0UG04SXVGdG0xWkdDYnI1c2dxUkFFOGVJQTQ1U0JVMVR3aHB0YWIraUFy?=
 =?utf-8?B?Z042czM3bzd5cUpWcGdIT2xJbXVEbzFkQ0JaeG0ycThzQ0N1UlI0T1JXUkZr?=
 =?utf-8?B?cFVMRFNYZEg3enpOcjl6dDhPcUFjaDJ5bDRaRHJNMUhLOGRNT0dPdEY1MjBS?=
 =?utf-8?B?L2xrNk5ZdldNaTdyQ2tjYkdDQXJwU2FMSjdPQjdldlBhRStMR21lWVpsQ3JC?=
 =?utf-8?B?YTRpVGJRNXBoK0F2czdQRE92Rk9GYm83ck9sZ1RHMkI4Z3dBejlxa2JLc29w?=
 =?utf-8?B?bnREeW4xMWtDaUUrZ21qK1NxcEs4WlNDQkxSR0lTTmN4R29mdExvbHN1YmZE?=
 =?utf-8?B?N3hTMnhRaHRkaDVEUG1oTHRDTnd4VEpIMUdjZ08rUzBOR3dqYzFEcWt5dVAr?=
 =?utf-8?B?VGYvb2swSzYyZFdNUVNnRkE1WnpKVWlkZTQ0T2FhUWI3bHZFRnphQkc5c1hs?=
 =?utf-8?B?OUhlRFJHOURQSktOZkZLcSthNFNTU05zdWxsUk50d213RURkVTlpbTZMbEdx?=
 =?utf-8?B?am1rWjNCUkw5VFZIdVZ6OSt1eU03VlpaMXJIN2MzVTZmYWFxSGhTWHZPcW14?=
 =?utf-8?B?YWhwQlNoYkg5VG5RTTFhZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWh1bUQ3d082c245Wm8vWTFZOFV2ZTA0dkVITHJqUzdwSjNZd0hXaGhGRnNR?=
 =?utf-8?B?R2FkRDQ0VW5GMkZlbzVlS2dhRnhCeE4vUTBCUGFLOUk0eWZWeXBYWmV1c3dq?=
 =?utf-8?B?U05BSWUreTBrb0d6WVVCajBIVU53eVJCclR4TG1oQTI1ZXA5N1NzTGJwaXd4?=
 =?utf-8?B?SWdBUTZ0ZHJPZGpTQWYxNm5TdnZ0clVaZzltWlUxOUsrd3ozTTNzS1cxN3h5?=
 =?utf-8?B?NTk0SWpMTmlmSUxOemFhb3lDK1BsNWVRVkhNeWhTOE9JbmRhNFpZY20xVjdi?=
 =?utf-8?B?bjdPYUhlbkc2Vk95dWNDU1FCRGJUMFRDWnVxWTF1QUtrelNYOFRnT0xhSnZa?=
 =?utf-8?B?ZVorZWdJemJxYkZsTXNZREJ0dTNBcUtIRXFncVAwOGc5MWc1MDU4SlhnbUx6?=
 =?utf-8?B?c3dpMnFKL2lkUkFlZ3BFQ050eTA5ZUdvM1RWcmpsUTM2TkUwZENWZ3VyMlp0?=
 =?utf-8?B?UThZK2FHYlA2Q3hrMkNRWGhQK2t0ZkwyUDlSKzR0M29DU2xGMmdTeWRlY3pY?=
 =?utf-8?B?UDBWclNVVmgwa1QrV1RCaGNnemFMNldCQVc5Z1VhN08rWkJPZEFlbWNNbkpD?=
 =?utf-8?B?Sk5FdzFBWUN2T29rZ2ZBaFpHMG95OHNmMzRuSTRlL2NnYlFVZHlyN2QzMFBt?=
 =?utf-8?B?NHBrNWJyVzNSbG1Eb1U2SldHNVpURWpZUHg5SFhNaHVranJJNWpLNStWNnY0?=
 =?utf-8?B?bFN1RHhIRWFjZlBPb2ZhN21yemRsZW1zMzJzSFkraFlHNWthTXdubXNvc3k0?=
 =?utf-8?B?SUNpZEEyMTYydldHYzRUYityUEc5QnE0dlRES2JOWW1VRFh0TzVNb2dnMmtm?=
 =?utf-8?B?Y3grdUNxU0pGK3JIUUJBSUxuL3JVZ2NHekc3ZjF0c0hVcERzRXFKc3lQY1Nr?=
 =?utf-8?B?RTJweTdwTGd0STJ1enk2Smc4ZFRzeGk4MWlGTzlJa0dMUWwvVkJmcVBJWStV?=
 =?utf-8?B?b2NKYUVDSjlSUENZYWNRbTZBQzNwSjc1VEVYQy9PdTJHL0kyMGZ5bWVqQnJM?=
 =?utf-8?B?SUhQb0laaVhVa1BnZllNei8wYXlGSEpBYUJGRHNpR3gvd0tvV0phVnVrQnhF?=
 =?utf-8?B?aXNhV2JxWWMxaktPRzhTYk12enNsbXZGcVVMeURNMElIUTErL3RuWlRTd3lo?=
 =?utf-8?B?MnlIUmtnc2s1U3ByUU1XZ0R0bTVQbTVlN0FwT2JPTTRMeUVEaUtVanJVS2pn?=
 =?utf-8?B?dFhKMXJ0bmREQ1FDdnV5V1NFQ3RQeGFid3pJZFVyMmJhOVROK2JOU1A5b2sw?=
 =?utf-8?B?c1pURm1sblBhSFJ0SHFKUG4vRmhRZjZCL0J5RzBpblRvbU9zQXdtaEZqUDM2?=
 =?utf-8?B?OGdEWWhzNmJ0ZCtJQUJIVWdDSHlEM2l0MmJQTDNVamd3NUtzbkFieXFJcDgr?=
 =?utf-8?B?L0J2R2hNeFJXSWxzUkw5aTNmVkpycUlBVXFpUjJyblc0YVZCOVR6MnJRRmFq?=
 =?utf-8?B?cEFuTzFNKzVYeUJEeTJqUzBvbS84RG9iTmNuUUhmbGVLWEtZRFZXeGNkUVNP?=
 =?utf-8?B?VHl2SFBmWjYrb1dlWHpEbW9wSkFNSDRCaGQ3S1ZrMU0xb1o2SzJpMWdkNndF?=
 =?utf-8?B?b3FudzduR1cvQmIzblFoNzdzUVluNUlta1NtQkx1ZzRHZngwUllwVUpxZFlw?=
 =?utf-8?B?V0x5V09zTXZSbWhJNG81ejBibjRURFZYQmRNREpEamtOQVhtb3RRN21LUFh6?=
 =?utf-8?B?bktQR3l2SlBTelRoSmdjK1h4U0p5N3Y1TkZWcFovY000eFBCQkRQbFR5aGRi?=
 =?utf-8?B?cnphYlZkdG5jVHk2YWIyM2dDMWZZK3R3SkdoSHNpYlNWNEhRaTFyOVZERDdE?=
 =?utf-8?B?eEQwd2Y4TW1hSm9SdDNva09wbXdkNUpQTFlLdS9iNzV5Z1dseUVRQkFTQXpH?=
 =?utf-8?B?UnpGeUxYY0N4d09FM0ppckxadW5WK1NzQVhBallESEZOc0JpNHFrdW1qNG1T?=
 =?utf-8?B?QkpGYkVqWG9ORnNQQU1DRU4xdzZ1eVA3NUo5TzJGalRXaHdUSzBta0NWT1dQ?=
 =?utf-8?B?M2Z0YWR3QXVrZHhHcHdwZWozT2hWdUdodVR3U1IxUGNLZ2hXampKMVdxc1Y3?=
 =?utf-8?B?c013L0ZYNDU1TnVCVk1FN3AwL041bTFkOEJuN05ERktUQm9FUnlPN2hPN1Zj?=
 =?utf-8?B?d0RRNXBReE1UaXZ2d1NUU2gwMFB3QkhYQTdvQ3JQbnNBaW92blVaSHp5U1d5?=
 =?utf-8?B?RUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f9af9-d35a-48ce-cf7d-08dce3943b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 10:14:57.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwzYzhrosJHE5B8ais1dHMViTXhIZqdNjY1NpgEPC2ws4AIT1VWKjSt8ekjCxB7k61TlDidVKtsN+27JZkQr7zYrdi2TdYN3xZxE5kYds1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7204
X-Proofpoint-GUID: S_teEM-XZKiTZgmCu4weGBA9-gyIUzNG
X-Proofpoint-ORIG-GUID: S_teEM-XZKiTZgmCu4weGBA9-gyIUzNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=721 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030074

PiBPbiAxMC8xLzI0IDg6NTEgQU0sIE1pY2xhdXMsIEFudG9uaXUgd3JvdGU6DQo+ID4+PiBSZWdh
cmRpbmcgdGhlIGJ1bGsgd3JpdGVzL3JlYWRzLCB0aGUgbXNiL21pZC9sc2IgcmVnaXN0ZXJzIG5l
ZWQgdG8gYmUNCj4gPj4+IHJlYWQvd3JpdGUgaW4gYSBzcGVjaWZpYyBvcmRlciBhbmQgdGhlIGFk
ZHJlc3NlcyBhcmUgbm90IGluY3JlbWVudGFsLA0KPiA+Pg0KPiA+PiBXZSBoYXZlIF9ub2luYygp
IHZhcmlhbnRzIG9mIHJlZ21hcCBhY2Nlc3NvcnMuDQo+ID4gW01pY2xhdXMsIEFudG9uaXVdDQo+
ID4gSSB0aGluayBfbm9pbmMoKSBmdW5jdGlvbnMgcmVhZCBmcm9tIHRoZSBzYW1lIHJlZ2lzdGVy
IGFkZHJlc3Mgc28gaXQgZG9lc24ndA0KPiA+IGFwcGx5Lg0KPiA+IEkgYW0gcmVhZGluZyB2YWx1
ZXMgZnJvbSBtdWx0aXBsZSByZWdpc3RlciBhZGRyZXNzZXMgdGhhdCBhcmUgbm90IHJlZ19hZGRy
LA0KPiA+IHJlZ19hZGRyKzEsIHJlZ19hZGRyKzIuDQo+IA0KPiBJJ20gY29uZnVzZWQgYnkgdGhl
IHN0YXRlbWVudCB0aGF0IHRoZSByZWdpc3RlcnMgYXJlIG5vdCBpbmNyZW1lbnRhbC4NCj4gDQo+
IEZvciBleGFtcGxlLCB0aGlzIHBhdGNoIGRlZmluZXMuLi4NCj4gDQo+ICsjZGVmaW5lIEFENDg1
WF9SRUdfQ0hYX09GRlNFVF9MU0IoY2gpDQo+IAlBRDQ4NVhfUkVHX0NIWF9PRkZTRVQoY2gpDQo+
ICsjZGVmaW5lIEFENDg1WF9SRUdfQ0hYX09GRlNFVF9NSUQoY2gpDQo+IAkoQUQ0ODVYX1JFR19D
SFhfT0ZGU0VUX0xTQihjaCkgKyAweDAxKQ0KPiArI2RlZmluZSBBRDQ4NVhfUkVHX0NIWF9PRkZT
RVRfTVNCKGNoKQ0KPiAJKEFENDg1WF9SRUdfQ0hYX09GRlNFVF9NSUQoY2gpICsgMHgwMSkNCj4g
DQo+IFRoaXMgbG9va3MgZXhhY3RseSBsaWtlIHJlZ19hZGRyLCByZWdfYWRkcisxLCByZWdfYWRk
cisyIHRvIG1lLg0KWWVzIHlvdSBhcmUgcmlnaHQuIEFsdGhvdWdoIEkgdGVzdGVkIHdpdGggaGFy
ZHdhcmUgYW5kIGl0IHNlZW1zIHRoYXQgdGhlIHJlZ2lzdGVycw0KYXJlIG5vdCBwcm9wZXJseSB3
cml0dGVuIHdoZW4gdXNpbmcgYnVsayBvcGVyYXRpb25zLiBNeSBndWVzcyBpcyB0aGF0IGhvbGRp
bmcgQ1MgbG93IGR1cmluZw0KdGhlIGVudGlyZSB0cmFuc2FjdGlvbiBtaWdodCBiZSBhIHBvc3Np
YmxlIGlzc3VlLiBBbnkgc3VnZ2VzdGlvbnMgYXJlIGFwcHJlY2lhdGVkLg0KDQo+ID4NCj4gPj4+
IHNvIEkgYW0gbm90IHN1cmUgaG93IHRoZSBidWxrIGZ1bmN0aW9ucyBmaXQuIE9uIHRoaXMgbWF0
dGVyLCB3ZSB3aWxsIG5lZWQNCj4gPj4+IHVuc2lnbmVkIGludCAobm90IHU4KSB0byBzdG9yZSB0
aGUgdmFsdWVzIHJlYWQgdmlhIHJlZ21hcF9yZWFkLCBhbmQgaW4gdGhpcw0KPiA+Pj4gY2FzZSB3
ZSB3aWxsIG5lZWQgZXh0cmEgY2FzdHMgYW5kIGFzc2lnbm1lbnRzIHRvIHVzZSBnZXRfdW5hbGln
bmVkLg0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gPj4gQW5keSBT
aGV2Y2hlbmtvDQo+ID4+DQo+ID4NCg0K

