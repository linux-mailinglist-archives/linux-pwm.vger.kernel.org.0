Return-Path: <linux-pwm+bounces-3412-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1698BB82
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4651F22B25
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D61BFE11;
	Tue,  1 Oct 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JBHhYBgv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AF3209;
	Tue,  1 Oct 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783643; cv=fail; b=fkYRGlLZJAGJWoTYB27kSddveaRZHZOTDcZv7ASFUyq+Kbc1QyfSsAAfXVO0q+CnzXWuKI1dzFLrx10ciRvb0YMZGNfPLLWR47u6wfiRor2NUrAsAopH875lJoaujyx3KvSkIoKWUr2TnRUe4O3IYRHfPUOsc4DFbTQgwEWmYy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783643; c=relaxed/simple;
	bh=tn8h1y2MaZ8SPW2geT8l4pxf2rmtMLcwvXuqrIlH9+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttdh3+gKtq4z98bU8eDQm4m1nXZkfu3sQRqNPjrE+CmSrUxzj+1X4Ih09nDvpTyRES8A+PWxXe44cAzz3O3qfkcxhwn/BRr2dkn5wJ08gFe19JuJTbhYkXb7qc4KtvIfKb4Netylb4GXWQnEXM7J3CPluMViZ7JuoP2aufHh/5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JBHhYBgv; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4918LIHl032158;
	Tue, 1 Oct 2024 07:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tn8h1
	y2MaZ8SPW2geT8l4pxf2rmtMLcwvXuqrIlH9+E=; b=JBHhYBgv4F0Aym+TlFU9h
	OUtnF+FPV0H79qFOnvBP7bfp6dZVqUN/GNJa+nktPruoY/6Y2nFHnuqlzZp6dFKG
	FGRkiz9Y6aOumvShYUJL7s36frKcwvh9v58BgKryE3Lj3Qm3yfwSAaVqg87FBB1K
	JRblZlKfHGx6c2CNGFxHUjEqM/gog9kIB1XkyjEOfWYaQInLz2EYdNro6rjVgoIt
	XnumnhTIE97I7mjTs08VTnoAXiAo64wnLvRzLLNJV/qhQ56+cOCDT4GEZQe8shzQ
	hdXhx+ahe9vz/kG0KaDSNoVfk4zYnSqx4uI/CDF7LRPU7CL4rpze94ETjSw7/d1u
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010007.outbound.protection.outlook.com [40.93.12.7])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41xbn4cvmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:53:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgGuwxhkdeMNI4hJB5HS7GT82uy6egTeVunwV/HJZnV7dpOrETwjJ6afjV5d2dEJ5MLYnlnydaV03t2tcLZb3U+xlaSOsMd9aB7R+G25RsGvDsU6TFPfjm0hcNRudVB+npte7rMf2NdWwAUx+QOZizaFeJUzE8TutFCXsS5JOa1A/4FLQHiBKc5hxmVFmjqTE8OauUjr4R0M7tyEtx1NUr2JOtO8/SKoKDkO6Bbf2/3aTIwn8LYN6R2pUiHkpqGGmnKBsSo9aE+4upBln0RrBUREH8PPUrPbUAYn3empYmG1CD/30fULzbG9uXEGb2EdqxM7/UMCww5D2EshwOraVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn8h1y2MaZ8SPW2geT8l4pxf2rmtMLcwvXuqrIlH9+E=;
 b=pYurDkAFbHfKyhROSwEd4sYjrheqmAwOvGIWT/Z+ZgBRd+aUreQsZIjBDBb9r5Mwpt2tFx6v08TTpqKW0gEpKthjTquZ2UALYOPHI9YHubGUp21XX4zvz8jHPoYDzQlONKrpMF+ye/TI7uV/BzWE/wnBR5XDFfArAdjrFJBKSitD5stCQ1KUBPFoWY91R7r8/G5XHjYdq7vETNrvKX3uxi7ueI+dnsFNrckfr3niDYa/j5r3pTR9ZZ7JoIExsJjpk4y23zplilfNxyAJpLuMzOXurq0SSTZqv/HKdkGLWM6ixdODpmUF/FehrNaOAKyjBaMmpK2xMQiUicGu1FGf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MN6PR03MB7600.namprd03.prod.outlook.com (2603:10b6:208:4ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 11:53:18 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 11:53:18 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Andy Shevchenko
	<andy@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
	<joao.goncalves@toradex.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
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
Thread-Index: AQHbDaHI9TSlXyKXhk60pta64z5+prJtga0AgARN+RA=
Date: Tue, 1 Oct 2024 11:53:18 +0000
Message-ID:
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
In-Reply-To: <20240928184722.314b329b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFpWW1ZMU5EWTFOeTAzWm1WaUxURXhaV1l0WVdaaU55MWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWW1KbU5UUTJOVGd0TjJabFlpMHhN?=
 =?utf-8?B?V1ZtTFdGbVlqY3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhORGMxSWlCMFBTSXhNek0zTWpJMU56RTVNemc1TWpjeU1qUWlJR2c5SWpG?=
 =?utf-8?B?R1p5OVFRemw2YW1sTU1Va3ZlVlZFWVRZNE5WVXpPRkF3V1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWpSRmREa3JLMEpRWWtGa1VsQkRjMGhLTlRFdlRU?=
 =?utf-8?B?RkZPRXQzWTI1dVdEaDNSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQldWQlVTVEpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|MN6PR03MB7600:EE_
x-ms-office365-filtering-correlation-id: 3424a612-789e-440a-423d-08dce20fa3fe
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0RDVWk5Q1c5NGJyQ1MrZGY3Q3dnMlRVQzhDWXBNN3BCSzdCT25JRmlxRmEv?=
 =?utf-8?B?UVk1eGRURTM4K1ZpSGQwcFArUEhBbkJkbTRncytFZVdVRDZwNVM5MzU2Mnh2?=
 =?utf-8?B?MlBRSVBzR09oWksyUDJUNXhsWGE4Z1ZsOTU3eExmdmdOUGRMZHN3YWVad25s?=
 =?utf-8?B?VjVXT2lacm4rL0V2VFpaei8wbFptMVRwRStJT2xBZ0V3eTllU3FJNEExM0p3?=
 =?utf-8?B?OXl0cW81YlFxNlhKYW5KaHEvdlZNNFdwWkM5RzRLUjdYQW5WV0hEVUYwSVBQ?=
 =?utf-8?B?clRZV0N2RDMxV2hMaG55cUFicVJnQndXR3NjVXZ6ZGNYMndIYjN3enN2ODBY?=
 =?utf-8?B?bGNXak1teXY0RE9LbDlhc0tLZU40ZGpOa2dXbzBNUEZTVURDYmp6c3hWMU9Z?=
 =?utf-8?B?eW1EYkVuUThaK01RbU15R0dWTjZIcGV3eTgrcEZlNndjVWI4cURWVDNqZEVu?=
 =?utf-8?B?SHVZTmJaMVJ3d29YYWRYdXpCcExYOFQwUUU2SU9CWm4wUldBU2lDaGsrY1pq?=
 =?utf-8?B?YzhqKzJLa1Q3SmNQTFR3UU5Kdi9oSUc1OEovUnYyZTRJYzFyTWJqMURySDZl?=
 =?utf-8?B?akFTN0VPaVhORVkyamNJUnpHRHAxVlNKMEc3SkhPcTY0QWdEMWgrdFpmRkNy?=
 =?utf-8?B?b1lCR25TOUNQd2dtUkxVSmJ1dkVkMFZyOVZJMFdtamphOFQ5cGxNVjRZL2da?=
 =?utf-8?B?NytSZVBEWjdZcGdZYTJ1R3I3aTVCOEVuY0Y3Q3Bmd2lDWnlmeXp0cjNBTGdn?=
 =?utf-8?B?b3Ntc3o4SU5RQi9MUnFHR2daVm94bzFmT2lQNWhUVjZYalhsd0t3em9EN2Nm?=
 =?utf-8?B?VDBFV1RFM3hFenc0K1VWZjlWOFZKaS8wU095UGxIT1Jpd3pBMzRnQjBuQlNG?=
 =?utf-8?B?TDY1bGwxNjJhb2g2ZGYwVnQ1c3hHU1dKdmtnaTVRWm5ENFlaMlhkdkV5SEF5?=
 =?utf-8?B?Qk5MU0tBc3VFZzV1blRkQmFOcGFrQURBQVRobEt4bnVUbjV4TURRdlp1RmhW?=
 =?utf-8?B?eVBXUERGWWNabWNRUVhENCtxZC9zeDJuL0ZwSGVzWnE3clF5TFVBa2tMMjRh?=
 =?utf-8?B?b1ZqbGRWc3FaZjBVZkRES2VMV21PV054Sk5vdkt4TzFpY3FmWEFiak9UTkh2?=
 =?utf-8?B?YjV3bW12alE0MXBNZGtYQTdaQXR6WFd0ZThSWENURGNob1A4TUIwRzA0MU5n?=
 =?utf-8?B?V3ZRUFFzUmJZNkQvY1cxR2JsZGFNVzN2SVJOeGpnRGp6UGhya2dXL20wWHZn?=
 =?utf-8?B?b2NEYnU0M1NReGQ4UTQxL3BXTEsxNnk2bmw4d0MzU3BjZXcyUzRPSjBHblRF?=
 =?utf-8?B?Y2xwa3BmVTdnd2UrU25oVHMxY1BwUzNJWEFSRXJ2S0w3cXloZTZOQ0p2QzIw?=
 =?utf-8?B?ZnRLOU9ncE1JdlBEcU9CVGxQNXJoc0FxNXY1cERMVkZsc0FEc29qcitSSTRF?=
 =?utf-8?B?azRwaFNDcjh2U3phQis0OFBnYjhOTFhxbitnQW1xTnJJVy84b0hiOVk5KzZO?=
 =?utf-8?B?L2NRMEgyWHJLbDdpZnpvR1VwTlVBMnBhN3BvSEJhZUdCUDM5dy9VMHFmT2Vn?=
 =?utf-8?B?bGNFNS9nemMyMW5tcEZLMVdmVjI2WWtvMmdscWVieERWa0VNb2dzU2QzMFhD?=
 =?utf-8?B?bm5TUWltWjFLVlNMb2c4VGZJZDdOc0lCS2wrOE1TNnNiRVhUOTN3cmxPOENt?=
 =?utf-8?B?YjlDaUFsNTQ2YkNneUFPUWthQWo5ekw2VHZPN0s4dEpQdHU3cm1wTGIyemQ2?=
 =?utf-8?B?eWFSTmx4a3BTY1JNdU14OXNLakF6akppd05Zd0s5VHRuTUJKaFIxYUxadEk4?=
 =?utf-8?B?Rm93bFpkT25PWHNlKzkvd0diYWhUdFptTG0wbnlOakNTY2dLUmVxV21IRkJR?=
 =?utf-8?B?OWhrRUgxWGZWa2tuUmxyc2Y3TlE5ZElMbVV4ZkZmVGw3OHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2xNUGU1aTRnVDVWT1J4YXdrQ0ZNSFZiVzFvYkR2SWNwTFFFOFdIUUNRTWxY?=
 =?utf-8?B?NDFnRVRjb1hGbXpLSk9tTVNrS1FWbHd5aGs0dExjYTFoejlteTdJWFFHSC85?=
 =?utf-8?B?NEQ5amU4cVVtc2loblZpb1h2ejNvRDRkZDFNbzN3Q3BIR3RaUlEwT0Z0QXBy?=
 =?utf-8?B?Ky84YTF1N0RZV2VLeW5hVTllQVBiZzVlSkJ6dFd6dis5QkdYeEtYMXhmaExF?=
 =?utf-8?B?MnRzYTE2L0FsRExHWEcxVGxERWhabk90UW5ZTHVGc3hqWWlwZjhndGdxQVM3?=
 =?utf-8?B?clZYLzRubCtxQzNta3R4M2w2TmFKWThnWWNLWXEvTXBzQXN3VWR0VkhqZnhR?=
 =?utf-8?B?L0x5OGs0aWcxamF6aEtHNW42bVpteTNMK0lvcTlOb1FqYlNIMTgveUovWVpI?=
 =?utf-8?B?RHMvUGdFUHAva1ZvSWNnaUU1OFpvT1QxZEJYYmtoQ2NwcloySnpwTnBVdVNN?=
 =?utf-8?B?RmdURXJ1MWNOd21RQlo5NHZHckR0a0pxL2pYdjhiOGZhd0I3RVIvYTFlUnE2?=
 =?utf-8?B?cjYvN0h1M2U2NzRTUFdYaDd4NmVVd1orallZY2hxc1FQbzFsRUVqNzg5NWE2?=
 =?utf-8?B?aGU3bTJ6WHh4OGNzVS9GbHdkeFcwY3JlNWVMbTJwODZsc3l4MDFCUUF5cDRB?=
 =?utf-8?B?U3lWeEs4Q2krMndRckd2eVMweFhFa2JVVW9yUlYrU1g4b011SlNWMVRKcTNh?=
 =?utf-8?B?RmJIYjBYaFRnc2hweElSaDRxWFIrYTMvdVI1Vm9vY2NXdWt5UVBUdnNhU0tl?=
 =?utf-8?B?U293WTNiSDVhM1RUVTFUTUYxTVE1VXZSMmtxUERUM1ozcmFvbVEvMFd0VEZ1?=
 =?utf-8?B?bC9GQ0hPR1ZiMFF0dnFuRENYWmhjNTVmSVdZZlB3aFdqbDFZWjNJemhkR0FX?=
 =?utf-8?B?Q09WM050b0VjN2FkcjhXNGhVM3N5bFJ4U3UyM3ZYM3c1TmdBSGEzSVljNzJx?=
 =?utf-8?B?NU0yRWE2elNSbEtPWW9aYTh4bTZpZFF0UVExN1VTN3c3VEdLUlNmRWZ0WkR6?=
 =?utf-8?B?VjRuVzZhSlZsRWpZTWxMWk1iT3hxYXZLbnlkd1BKZ0ZFUkxkQkk3djRHei9O?=
 =?utf-8?B?VFlCb2VpWU5sYm9aakM5aVAvVmZHOUhpbnpERWZhUWI2dkJBM2k4bVVOQktn?=
 =?utf-8?B?bm1KRFUyREpJTS95aXdBN2NEVkhkUXFhaW9pOE1Rd25jaFRTM0UxMW5NekE2?=
 =?utf-8?B?clNoWFJXcVkvM1h0cGlkK2NNbzNNb3hGcDRPeC9nM09EL2d4YzUvR2FIQjlD?=
 =?utf-8?B?VUxTT0dEM05TV0N3b3BxQW04ZytYWHhLaDF3UW5Hc2JwUmVWYVhsSHBYS1Y2?=
 =?utf-8?B?Y0VGWjVNNk50UFEvQ0JVbEgrZ21TaFlrb0tpejBNMEFPLzgzY2pNTmY4UjU0?=
 =?utf-8?B?cmxKOVR1THBpTWFGM3o0OVk5TWl6R2ZKa2sxQi9vS3VOK05nTGFoWmtISzVn?=
 =?utf-8?B?dHRPaHZ0T0pkVXBXQ2wwTHVEZG5EaFEyWDVzN205eFdNK2h3ZkpsMmVBK2FD?=
 =?utf-8?B?aG5LU1VKMTFkVy9DaytVYjV4WFpPRHlXelN2MktqNEMvLzlnSFN2Ukt4czNr?=
 =?utf-8?B?ZWk3OEhrcUJ6ZGk3VFYvbnpCaVU5T3NZNGtuOGlRdk8wRUdjL2p0cjRnOHZo?=
 =?utf-8?B?RlVBNWtTSXZYVFQxUkxmN0o5NkxEQTBXQkZMa3FVODQwUXNRcEdiMWdkbHZ6?=
 =?utf-8?B?OTBnTDQ1Q2dwSHdwM2xFSGNkRzRKWmJCK3ppbXVxaEdnYVNFRnQzcStnVUxH?=
 =?utf-8?B?VUJicTN5My9WOUxWdTJVVzZtclJORVdVZGRRRkp1bktvUlRiT296cEdiL0x5?=
 =?utf-8?B?RU9nMHMwdk45MUJoMmQvWGFxajFSdytFVU4vSWtscW0wWXBwY0p4VHJhVDN4?=
 =?utf-8?B?MVRERU02cjNHcmFYM0xmTEkzdEJLR2NCalJmK3FzWW41TllZeGZnbzV4THdC?=
 =?utf-8?B?aCsxOWppSU9hc1lCcE9MTEtXb2xaRHpWU1NVWklzZ1lQSTZ5N2NQM3VhUjI5?=
 =?utf-8?B?WUwzalJNa08xTVZQcWdibXVtZU40c2lNa2VZbEFrOEFzdjYxTUpKeW9TRDEy?=
 =?utf-8?B?aGMyUVN5NWZ1VHRTRmljdWRqNDFzVHNqM3VLdFZrdmt6aVJ5NDZVN1dnUGth?=
 =?utf-8?B?d3JEVFFOQ241MEwrdHQ1VWZtUUpqdURNYXp3elQ2LzVGaHpmRXB0a3dCYzlq?=
 =?utf-8?B?eEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3424a612-789e-440a-423d-08dce20fa3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:53:18.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RthZtilfnt4IpRPUfeZae1AzDPWHqgVkKLp944T2TmqVYACFJsvfrnnFZ4HGe3jN5TDrHlmsCivlID8xBeBetxgGNKWzYZuv/u2EMOX4lkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7600
X-Proofpoint-ORIG-GUID: X4Jno6ipcQ68QGpa8gOd0Ynw9XO6M5D3
X-Proofpoint-GUID: X4Jno6ipcQ68QGpa8gOd0Ynw9XO6M5D3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=958 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010076

DQo+ID4gK3N0YXRpYyBpbnQgYWQ0ODV4X2dldF9jYWxpYmJpYXMoc3RydWN0IGFkNDg1eF9zdGF0
ZSAqc3QsIGludCBjaCwgaW50ICp2YWwsDQo+ID4gKwkJCQlpbnQgKnZhbDIpDQo+ID4gK3sNCj4g
PiArCXVuc2lnbmVkIGludCBsc2IsIG1pZCwgbXNiOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+
ID4gKwlndWFyZChtdXRleCkoJnN0LT5sb2NrKTsNCj4gPiArDQo+ID4gKwlyZXQgPSByZWdtYXBf
cmVhZChzdC0+cmVnbWFwLCBBRDQ4NVhfUkVHX0NIWF9PRkZTRVRfTVNCKGNoKSwNCj4gPiArCQkJ
ICAmbXNiKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
KwlyZXQgPSByZWdtYXBfcmVhZChzdC0+cmVnbWFwLCBBRDQ4NVhfUkVHX0NIWF9PRkZTRVRfTUlE
KGNoKSwNCj4gPiArCQkJICAmbWlkKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArDQo+ID4gKwlyZXQgPSByZWdtYXBfcmVhZChzdC0+cmVnbWFwLCBBRDQ4NVhfUkVH
X0NIWF9PRkZTRVRfTFNCKGNoKSwNCj4gPiArCQkJICAmbHNiKTsNCj4gPiArCWlmIChyZXQpDQo+
ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAoc3QtPmluZm8tPnJlc29sdXRpb24g
PT0gMTYpIHsNCj4gPiArCQkqdmFsID0gbXNiIDw8IDg7DQo+ID4gKwkJKnZhbCB8PSBtaWQ7DQo+
ID4gKwkJKnZhbCA9IHNpZ25fZXh0ZW5kMzIoKnZhbCwgMTUpOw0KPiA+ICsJfSBlbHNlIHsNCj4g
PiArCQkqdmFsID0gbXNiIDw8IDEyOw0KPiA+ICsJCSp2YWwgfD0gbWlkIDw8IDQ7DQo+ID4gKwkJ
KnZhbCB8PSBsc2IgPj4gNDsNCj4gQXMgYmVsb3cgSSdkIHVzZSBhIGJ5dGUgYXJyYXkgdGhlbiB5
b3UgY2FuIGRvIGdldF91bmFsaWduZWRfYmUyNCB0bw0KPiArIGEgcmlnaHQgc2hpZnQgYnkgNCBv
ZiB0aGUgd2hvbGUgdGhpbmcuDQpSZWdhcmRpbmcgdGhlIGJ1bGsgd3JpdGVzL3JlYWRzLCB0aGUg
bXNiL21pZC9sc2IgcmVnaXN0ZXJzIG5lZWQgdG8gYmUgcmVhZC93cml0ZSBpbiBhDQpzcGVjaWZp
YyBvcmRlciBhbmQgdGhlIGFkZHJlc3NlcyBhcmUgbm90IGluY3JlbWVudGFsLCBzbyBJIGFtIG5v
dCBzdXJlIGhvdyB0aGUgYnVsaw0KZnVuY3Rpb25zIGZpdC4gT24gdGhpcyBtYXR0ZXIsIHdlIHdp
bGwgbmVlZCB1bnNpZ25lZCBpbnQgKG5vdCB1OCkgdG8gc3RvcmUgdGhlIHZhbHVlcyByZWFkIHZp
YQ0KcmVnbWFwX3JlYWQsIGFuZCBpbiB0aGlzIGNhc2Ugd2Ugd2lsbCBuZWVkIGV4dHJhIGNhc3Rz
IGFuZCBhc3NpZ25tZW50cyB0byB1c2UgZ2V0X3VuYWxpZ25lZC4NCj4gDQo+ID4gKwkJKnZhbCA9
IHNpZ25fZXh0ZW5kMzIoKnZhbCwgMTkpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBJ
SU9fVkFMX0lOVDsNCj4gPiArfQ0KLi4uDQo=

