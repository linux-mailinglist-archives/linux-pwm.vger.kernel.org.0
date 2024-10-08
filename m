Return-Path: <linux-pwm+bounces-3536-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0A9945C9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 12:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F254F1C22216
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438031C2443;
	Tue,  8 Oct 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DKSS6Tnq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1A2CA8;
	Tue,  8 Oct 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384525; cv=fail; b=mhfdGZWxQhFoYBPHNdX60Id1tNsQBpNSfxE5xM3zdQ3PkFHWjZ9e2k+vp+hMARCbXL6v2lVylkgzaXpp6jS4MhEd/FHpWCz2hlw02z1MEolMkBhttt9PNK1N/UJAt5biHT5a89Yk4EqtDfm22vZn18iOESQkcmFJQP+Y/ioHweE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384525; c=relaxed/simple;
	bh=02GY3ACCSjGGDEkPYs070Uiwus3CZn+5SmN+mFdxiH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jONvFE+yq15KjWwXAKJLiOrSGoubJFQk9zHP4Auw0//xy7Ug2tXjrCbrb7bc4XmcS0/yyBsc5L3XpDQQgRBKZgerDeev3SzQWFkgUhtYR9biPqySbZLLn7YQqc2q59kfu+39kzRyIpL8qSIwHPW2DZSQImU9vSgfT74zJFZ1yyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DKSS6Tnq; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4989RFms021194;
	Tue, 8 Oct 2024 06:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=02GY3
	ACCSjGGDEkPYs070Uiwus3CZn+5SmN+mFdxiH4=; b=DKSS6Tnq8tqP+CCWXdD8A
	i/8qU37oXk7bWT1OzfNqNhZHnuPt9OMJGzltu2T0ZQ0S/KE5lRsQ3tC4jwdhcSgb
	0ZA4g/94Wf6a+q6hp1zrpk2m5KRc15o6vYv9Rcv5IeoiHP6x34BQFKbI/jK/k+++
	JKWCOJ+NmpShenXVpBVObB69z1cdAtbVBHIio8geYWeo9H4qVVYRhylExHdV8nPV
	Fb90coX0jvdnl7hz1KVzx8iQcQfvne3iZWJqez2ZLn7zzcX/MxDQa1KAqeO3utDr
	lF0HaaOaxHDcpZx3jIw2qf30k+9zKG8JP51VBuSi8146XqtbQSjWQ2fCT2zMJt4r
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010006.outbound.protection.outlook.com [40.93.20.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 425244rar0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:48:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJg46pWvxDaRYQex40+ZadMuh8kcsmOyG2ogk0vizth2erNvil3+8f7u9FVdKvD66bzBXx9SOl+3AnueTYhwgmC+1EcbuNN1JyxSZsigZux/PxezvzizH5W7GAPwqPXAcF2ByUs7EI918nIu9aOKZg6HnQr8Gi8Q05dkAsBDx2bZ2JOIWsIaeDTl59eVX4uOE644gtSBiB9/DMo6unLFpZfDcMLkZAXkavGZx2LThzeLFnN2Osy5kNs7O6K96s5BhBtUDw1ZbIzdr26Al24gq5Vg1m0RV4JnPmKIYNHyBocrI2G1wJWyCLWXYDf3M9gxxX/L2VgiXU/txtuAc1hsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02GY3ACCSjGGDEkPYs070Uiwus3CZn+5SmN+mFdxiH4=;
 b=GkzqppfXi3DwfWDRjvykLLUgfXK41uA+vK6DHHnp8DVtgZb0CuABGN4Isr7H4V8ZN0Egwgnih4MLKlSWIiS+06TjpIJQzH/cuoUmDnltFYuq3zXIdJyElJKL9JO43e56lwQ+XkV+EqL1ohpwLqhH6jFG2XIOuE3aLbcvwCcca6AvVmhfWGzLwaFfoxGyU+a/iI8rxPLc+q4Oagm5nfL/lY2g9CccGFUA80sXFcdF47Dd1ohZTSKn3XJv+YFukGwszNnxjMejoARWAQQlnOYRY2c2R40i5ccppWQO4VGQwuKrYUA53R5D1Z74jCVbEInobs/lEaCHMfNPN5s4t8x9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:48:08 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8026.017; Tue, 8 Oct 2024
 10:48:07 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
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
Subject: RE: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Thread-Topic: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Thread-Index: AQHbFmd2i/Hp4PBeYUypvnokWgp3WbJ4gweAgAQtsiA=
Date: Tue, 8 Oct 2024 10:48:07 +0000
Message-ID:
 <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
In-Reply-To:
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFqWVRaaFlXUTVOaTA0TlRZeUxURXhaV1l0WVdaaVppMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWTJFMllXRmtPVGd0T0RVMk1pMHhN?=
 =?utf-8?B?V1ZtTFdGbVltWXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNakUzSWlCMFBTSXhNek0zTWpnMU9EQTRNems0TkRFeU5Ua2lJR2c5SW5C?=
 =?utf-8?B?c0sxSkVha3RyVDBWNk4yVk1jMXBzT1RaaVVFWlBUMEZTVlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkhKdVZXRk9Zbmh1WWtGaVJqZDVabTVtZERoWU5u?=
 =?utf-8?B?Tllka29yWkNzemVHWnZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BN8PR03MB5092:EE_
x-ms-office365-filtering-correlation-id: b8430808-7175-425d-528c-08dce786b1f8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzVwb3BJQ05rQTdodWNzR1JsZm1Nc2pZL3FrZ1F1NnE0SE44S0dac2hRek1t?=
 =?utf-8?B?QjNacXBQdWE5a0Y0c2VvVC9rLzJKYnhmMi84TEV3am5aaCtHYXkrNU1GVHFJ?=
 =?utf-8?B?V0wwak9kVG5SUHJ5REZITFhldDZuajhZQkhKaXE0N2IwQUNzeHQvTkJWeFFI?=
 =?utf-8?B?bExYeGpJS0lhcmhDSWY0eXY2aWFYcjhabWNLRjQwVWg5U1dmWjROWmxaLzhK?=
 =?utf-8?B?dm53UGNBSDFOU1JPQXJuN0Vad0Zaemk4QUJJc1hmL1ZJT1pvQmIzbXJIdDZn?=
 =?utf-8?B?ejM1Mnlac0Z2ODJxNXJTR2MzZk01cUxWZ0VUOUZWVEhsd1V1VmhHR1ZkczhE?=
 =?utf-8?B?RjlEdXRHOTl0c0JIV1diMGpPWlF6YzV1c3FmeC9uTFJNYmdmWFZobktvN0Rp?=
 =?utf-8?B?UnZWeG1pcmlCT3EybVovZG9QQThRRERxQjFDRUVubnptU3h4azlZVG1BdDhr?=
 =?utf-8?B?bUEwT3poaUN6RFZ5TVh3ZFhtZUdMQ0xUTzZNTEsrZi9mc1NURzhIaFZrOGZa?=
 =?utf-8?B?cWQ2QXhneVhaTG0rRDY0dGR3Qk1KNXN1dUZ2d3pIZjFDMHRud1ZjV0FQcTNs?=
 =?utf-8?B?WUlLNnY1YXJJZ1gxMnRpUGl6R2ZYTnpsNXdUT2dUNjB0bXVoanlUR0txcHJD?=
 =?utf-8?B?VE5udGpsR01CeUJrTnBNMHp6THc0VVpuNWFLV0FoNEVGbEZvc1lTNVMzcit0?=
 =?utf-8?B?K1dJaC84cHNzc0IzK3ZRWjZIY2NlTmNlaVZ4azVwa29hSGIxMVY5TU1YSVZB?=
 =?utf-8?B?NHRCQ0JHYzA0dGR0Yi94VnRYVFRnWGY2M0cyUTVzVlVsRFp5amJidjBadTVI?=
 =?utf-8?B?dUtOK0J1ZTNuWHUxNkI4aGZxWHMrdTNETTN0L0ZnNURzMGZQVkltcWlNanoy?=
 =?utf-8?B?N1IyOWtjWXhjazJmcVRwUnNBVzk2bGZZTUM5YmNKK1o5SEdoNGUzNkVKWGlO?=
 =?utf-8?B?MjBoK25MQ2RTK1FBQWd6MXFPTGp5RDc0Q0NrNXJDRjVhUWJrUW1xK2Ribyty?=
 =?utf-8?B?SWhYUERORERtKzQzdFNDUUxrdStwalZKRmNVaytRZUVxaVo3UmgxMEgwT0ky?=
 =?utf-8?B?RTlyZEdxc05Uc0grcGRhMDFrT2JsVTlFNlNUNmZxRmc4ZWN6ZDVUWVJpN0Y5?=
 =?utf-8?B?SzQxa0VweWxBalRlN0lvMlc3Q1F6L291My9CUGdqUE41Qm95a2hxcXhVekMy?=
 =?utf-8?B?OTdqY0x2UFBCc29zb296TWxYRm83WWNFZDZHNDJ1dWpxY1E0R3BodGJqUFNo?=
 =?utf-8?B?S0hmSzJ0Yjc0U00yK3JvQ1hGY3A2OW9UQnhKUmZqMlRHcHFrT2ZONUJmUHdR?=
 =?utf-8?B?dDVQdXF4UTV1b2lTQ0QzNDVwRVhxMDFDVFVHenJDNlVQK1phSytJaXhiSDVS?=
 =?utf-8?B?T3ZYeVRDckJYME9WMnlmYUFVM0dSbzJKNDdyWG9xZENkdGUrbjVodmNrVDFl?=
 =?utf-8?B?MUc4eUt5a3N5TU5wY25NQnNldTgxV0lsNGl0dEdZbDNEd0E1RWYyL1MvcGVK?=
 =?utf-8?B?TlIyUURKaTRtSTRkd2hteVMrTWU5amxEUW5YZWU5Z281RXNjMlRHaCtzVXRq?=
 =?utf-8?B?ZXl6c0ZjZmpYQUNkYXRvK2dWWi80d01CNG9ZRkt3dDh5Uy96dzlOVlJxYkhV?=
 =?utf-8?B?RkdyZzBtSTE2ODc3N3hZNU1XeXQweHI5VVBlWU1iM3pZRDhPYmY1RVFMak5w?=
 =?utf-8?B?TEFGYXhSZlcvSTN4SFpPc3hScVljaHdzRXM5cWtNbjZiQkNDWk1HSG5lOCtO?=
 =?utf-8?B?MjloYXJLSWFxUE1WaTdmQS90cld0QnRuOFo5bkc0R05Hb0hoMUtLek4rc2NU?=
 =?utf-8?B?L2syVTlTcGI3SUdrbG5zQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0J1RmxhZXppWU5IU3pUeXVRakx3akpjTGU4NHF1K0oxMWU0UXlmWmk0U0pE?=
 =?utf-8?B?OVFkTWpXU0JycE9xN1J6azRkbHJlSGhsQ3VBanA3dlg3Q3pQL0VOSzZ2OXpB?=
 =?utf-8?B?d3l6QzJocitvOEtpektIMzA0YVJTb09uRkh5TjhxU2xwZVcvWVdTOWJxMm5r?=
 =?utf-8?B?RWRxZlpDZi9yYjBtNmJwWnFOMENLVXROSlVrL25KZ1p5R0dvdkZxQ0ZWTzhr?=
 =?utf-8?B?U01PWUN5aFZtMjN5YXlwM055OFVhQnNtUExwTG5MRlBNTUVqRkdlSVNsQ2hp?=
 =?utf-8?B?dWJhai8rSnVreEpWajR6M3NzVU9xQ3NnbmdPZWJhOVRFTFpIa2NESmUxOWdy?=
 =?utf-8?B?VGlWeDcrU3FqeW1FNmxRd0NhUmhLcTdqV3c1Q2N2YmdJWW9zNFJrbURla2Fv?=
 =?utf-8?B?Q0lBRyt1OTdjalFoWVhLb1BJSlBMd1B5RDY2Q1hGSEJTeUd0bExMZHNFcThT?=
 =?utf-8?B?K3FZdWlxTTJ3SnczWTd5ZmkraU56dUJWQ0FmblppRU4vK3lKdS9qMTVwdnB1?=
 =?utf-8?B?UEtISHNCV2ZsWnBERlpJV2tMUVlMSXlkZHFYV1JJMDd5NzBuVkFqLzdKeDZL?=
 =?utf-8?B?WGcxR3ZPbjBZb05sc3BOb1FjQ2s2Wnhud0Y1OElYa0FxVzVwSkxXUjdRaGJh?=
 =?utf-8?B?RG04dk5iM0VWeWdLM2RjWml6b1lEYWVuY0xheU1qM1dEUTRkd2tiN2tZZjRD?=
 =?utf-8?B?YWx1bFkyL0R5QVZhUVhaNEQ5MzFWTnBWSEduU2xNNFE0TkYvb1JLczVJVUMw?=
 =?utf-8?B?SnFpNWJEWXdCLzljZHJzcThtQXEwOWs0c2tLZmd6TFU3VjAzRzhsU1lvZVZX?=
 =?utf-8?B?ZWlEUTVjWVg0QWxGQU5TNnNRcU1zT21yaUxCdXNkT1ZCaldzQUZlTzFSV2Fo?=
 =?utf-8?B?WklxWENtTGliVGpoYUFXUldGSXJ1Zm90TXVDMVRUeWM2dkhMU2ZLdDZidXZI?=
 =?utf-8?B?c2lzdElyeFJscFgwSEt5bEh5Rzc0NGhycDFIMVdEZ0VaZm9UWFFOZm9LR2Va?=
 =?utf-8?B?L3BYQXYwaG1sR3dVNEVDa0dhNGVLN1QwY0VJSGJ5UzYxZnpVQVBRNHNXZTZV?=
 =?utf-8?B?Y0I5U0NFc0xXeXNHRTNoZHFMVkZSMDBKeHRkeDJkcUJTaG14VmFsUzFBUGZa?=
 =?utf-8?B?b2N2RTJQdTRpZktMM2VhZnovb3ZaVGNadzc1UmJtTGtpQUNVRnNrT3pOalJS?=
 =?utf-8?B?RlMyZ2YxNVhrRDRobEdVL2hVN01FY1o3UTYyR0xpaXQ5Nndpd0VmWmxYWFJH?=
 =?utf-8?B?bEhWVlRFbVBNciswKzVPTjM0YnNORzBYLzVDYVBFQnJNRUpFZnA1czhEbWp0?=
 =?utf-8?B?QW93QkJub0FBWFBtdldjTlMrWmlacFZPRk9YaGNsT3J1SWJneUptUloyem9y?=
 =?utf-8?B?c0YyM0VtNkIyUk11dDlDZy93eS83dnJFdW92Rk4vc1ZUbmtaUklxYzlqU1hw?=
 =?utf-8?B?a254ZU5wdFZ0K0xzKzhkY01IK2Q0dlFhdmdIY1hNRFhVcGJneDdSLzBubmMx?=
 =?utf-8?B?Y0taRXQ0cVFoTlVHTkJZZ1NZaGhIWG40ZmRuNjlWeFJnaVpncVprWWx5QURD?=
 =?utf-8?B?ZVpQaXlyZHpidzYzYkp5bnhxM0NROC9vWnI1Um4xWWIrRkdQMnhhNFVnd0pI?=
 =?utf-8?B?c0hkbEZtYzlZbXl2Sk1ESi9GUDZOZkVjZHliZCt2TGVhejA0M0hUYUo5MUln?=
 =?utf-8?B?ZnJuaDVwTUtQU3ZjWDBsT3NiREducFZPbHc0YjlyTlc2Zkg4dlo2TGQ5SDk3?=
 =?utf-8?B?aUZ0bjZQaGJsaWd4c0E5SUM4dm5HWjFvNG4zeWlmdU1RV2R6MlA2QStKdGY0?=
 =?utf-8?B?OGpaY3BTcjNyVkM4ZXZVaGFVOHEwYUZ0RmVPdVkyUXVRZkZ1OGFHdmdzb09l?=
 =?utf-8?B?cXZ0SUkxSnNxWFlCdjZHREhQajI3bWlqMTh1REZvMEdHRmNXbTFTVWVkN1Y3?=
 =?utf-8?B?TktXVEJudHFjeHQ1RHhwRzlVb29HNFJycFFndHl6TFRZZUgzNE0yL0wxdVVO?=
 =?utf-8?B?YlVxVDBNRWtoUjJKWTBlQlN3bjdpWDIwcTRBSlBaMUpkcFZZa3hIZlRSc1RY?=
 =?utf-8?B?WXpNMFdLMnhoeHY4a1FmL1cvNmkyOVZETjhkOXJIb0hwZXNhVjRsYkZUaklX?=
 =?utf-8?B?VllTQm9iZWViNlVvcUF2cTU2Wjc2dndlRnYvZkl5V05ZYjBvNVZVdDBZaThR?=
 =?utf-8?B?cXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8430808-7175-425d-528c-08dce786b1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 10:48:07.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RsOhgKpFn2tOCcLzVcnJlJoAjOI0+rRfQWZ+WvkVf5zWKTRNFNFCIlcY1swzIaFdoVh/LtgqLPbdb8wfpC+dru021AZf24IAo8Dn0lJwCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Proofpoint-GUID: Yr4uGm1ht5wjNXK2m-lqfe1tWN8ovePx
X-Proofpoint-ORIG-GUID: Yr4uGm1ht5wjNXK2m-lqfe1tWN8ovePx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=746 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080069

PiA+ICtzdGF0aWMgaW50IGFkNDg1eF9nZXRfY2FsaWJzY2FsZShzdHJ1Y3QgYWQ0ODV4X3N0YXRl
ICpzdCwgaW50IGNoLCBpbnQgKnZhbCwgaW50DQo+ICp2YWwyKQ0KPiA+ICt7DQo+ID4gKyAgICAg
ICB1bnNpZ25lZCBpbnQgcmVnX3ZhbDsNCj4gPiArICAgICAgIGludCBnYWluOw0KPiANCj4gU2hv
dWxkIGJlIHU4IGdhaW5bMl0gYW5kLi4uDQoNCkFzIGRpc2N1c3NlZCBpbiBwcmV2aW91cyBwYXRj
aCBzZXJpZXMsIHRoZSBidWxrIG9wZXJhdGlvbnMgd29uJ3Qgd29yayBmb3IgdGhlc2UNCmNoaXBz
LiBUaGUgQ1MgbmVlZHMgdG8gYmUgcmFpc2VkIGJldHdlZW4gZWFjaCBieXRlIHJlYWQvd3JpdHRl
bi4NCg0KVGhlcmVmb3JlIHVzaW5nIHU4IGdhaW5bMl0gIGhlcmUgIGFuZCBpbiBvdGhlciBwbGFj
ZXMgd2lsbCBiZSBqdXN0IGFuIGV4dHJhIHBvcHVsYXRlZA0KYXJyYXkgc2luY2UgIHJlZ21hcF9y
ZWFkIHJlcXVpcmVzIGB1bnNpZ25lZCBpbnRgIGFzIGlucHV0Lg0KDQpGb3IgdGhlIHNldCBmdW5j
dGlvbnMgaW5kZWVkIGl0IGlzIGZlYXNpYmxlIHNpbmNlIHlvdSBjYW4gcGFzcyB1OCBkaXJlY3Rs
eSB0byByZWdtYXBfd3JpdGUuDQoNClJlZ2FyZHMsDQpBbnRvbml1DQo+ID4gKyAgICAgICBpbnQg
cmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIGd1YXJkKG11dGV4KSgmc3QtPmxvY2spOw0KPiA+ICsN
Cj4gPiArICAgICAgIHJldCA9IHJlZ21hcF9yZWFkKHN0LT5yZWdtYXAsIEFENDg1WF9SRUdfQ0hY
X0dBSU5fTVNCKGNoKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICZyZWdfdmFsKTsN
Cj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gKw0KPiA+ICsgICAgICAgZ2FpbiA9IChyZWdfdmFsICYgMHhGRikgPDwgODsNCj4gPiArDQo+
ID4gKyAgICAgICByZXQgPSByZWdtYXBfcmVhZChzdC0+cmVnbWFwLCBBRDQ4NVhfUkVHX0NIWF9H
QUlOX0xTQihjaCksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAmcmVnX3ZhbCk7DQo+
ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+
ICsNCj4gPiArICAgICAgIGdhaW4gfD0gcmVnX3ZhbCAmIDB4RkY7DQo+IA0KLi4uDQo=

