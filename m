Return-Path: <linux-pwm+bounces-3601-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68899A2AA
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF831F24AC6
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF78215F65;
	Fri, 11 Oct 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Yz47GDJU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76601CF5F1;
	Fri, 11 Oct 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646067; cv=fail; b=FyjEICq5RuWZCiUsmD1/6MpiP9l9jtuP6rAA+e9Bg+p6X3My1AEOJo6mzOpxPeUcJYy0CzOuFhz7PHkH4OT5BsdgtsqdFDPO5y2ljDVPl9LtzRiLH8L3/vGKtLS+QZ1CuxDlVfPFyFychOcFvaZ890gpmrrQ+L9gWMX0Xtu0Wog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646067; c=relaxed/simple;
	bh=6y56Mcir6uXqcW3rCTGGladICzd7m2FoUgTIJ+q2Y2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mpi6AsVlr8QaugmifKN94hYJF8sYBdXQOQXKO6+xZeM11YJFuXoYoETDQG5HgP7mLjntvvU4CefALd6ztQlzhwwa/SIsGMzxIpyLhsiFcZBEMGQVDk08E9sKhRuHt38AgcwWuNgH5+KyQjEir/tmksi304D/xpDiT3cdEvF3HfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Yz47GDJU; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BBH2tB026703;
	Fri, 11 Oct 2024 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6y56M
	cir6uXqcW3rCTGGladICzd7m2FoUgTIJ+q2Y2U=; b=Yz47GDJUIJHKytRVT2Dpd
	b7ln8xFWkJ+NHVlJUsKf0+QNZLyt7zsj+4BMHG7Cd5qTqnrvJv3GNC61cE1hvfG1
	r0JrohKrql5TOlFq5rBkGVYiSUGTbUiLTdYDxUj7pIDUkg/kCgWCVmmA0y00QkIE
	tI+gptNmHuEpME4RyzzcW1y6IwKuxslnhtwII+Y/LlSPAjIsWeWmKZE+TQBn6/D4
	ROLDJpvHCyOgyOkubhk91/UTtylxsil0Kdq6fsK3wtNHpfpzTfyYshXZzTu8wI5+
	Ke5dDzmia/3d5qMrnU3BmlBZxDXQcMPjL2+ycZZBOXt/dYanImqyPsXgNuYAcAm+
	A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 426qmwjgvt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 07:27:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIBrUBsQKKr5pqpOWVu4RIQQmZCDE6wmjsPo7YMV0xODgM/M4Gzyef1VkGARBxVRSSKa1jUDPb7MNu+GZkoniQtA9nhdZGNdb/K89l/ZTj8Rj7cS+Sy+dThLC3Gp21zNp2fDWav9LuuTPe5sYgAg23nBVfnoQ6R+/zBj7gYXlRgTH5vTiagBM31dDdyREjGnausrhvBo4Lq13EdInST6pYZKH/BbI7dpT6f4t9zQUc8BNry2agyfTOmhmMaaiDHRBcMBLWQOLFN2kZKyJCORD4YJVvqvlY0q/TQqoG7b8SHGbWMhXAiUWJNJr7BieW5WvqAbicgPwf4HPrSvJ9X9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y56Mcir6uXqcW3rCTGGladICzd7m2FoUgTIJ+q2Y2U=;
 b=VBRqrDnbCG6XmnvEjPC0QOBRtLURr+qw7H0XGsTsTdtA1Qu37oszjO/kZUHUll9UK1WgkKZMbXcmXxCIbwVzWqmABZ1fJDrRp7uL59aXGO9mA/ESzChHoyEvMUW+YQ08CrjavkcmLpPcRlDY0my33pRLCI0rtZG4kuqARfriVwqiTnzDTSQMO0qdzRacYdTkvUsNMVnUwJBtqVcAdT4wCG93ssZ50xPtbErHqbEa/Vy9Ya+KXCCoCLmimCSQk9l74pg61SYEcVdwJn4RmBmL/jk3luvvtRW9Jd8spuMDl1R2zNm/IEXlWr/6uj6ziOVznW8qGIj8on7gD40/Ofrr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA2PR03MB5753.namprd03.prod.outlook.com (2603:10b6:806:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 11:27:17 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:27:15 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
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
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Marius Cristea <marius.cristea@microchip.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        "Cuciurean,
 Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos"
	<Dragos.Bogdan@analog.com>,
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
Thread-Index: AQHbFmd2i/Hp4PBeYUypvnokWgp3WbJ4gweAgAQtsiCAA4+ZgIABCq3g
Date: Fri, 11 Oct 2024 11:27:15 +0000
Message-ID:
 <CY4PR03MB33992328530A8AC613C7A6C79B792@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
 <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
 <71c4a073-1b5e-42d3-8fee-a2a5215d5856@baylibre.com>
In-Reply-To: <71c4a073-1b5e-42d3-8fee-a2a5215d5856@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFqTWpNNE5qRTVZeTA0TjJNekxURXhaV1l0WVdaak15MWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWXpJek9EWXhPV1F0T0Rkak15MHhN?=
 =?utf-8?B?V1ZtTFdGbVl6TXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNRE0zSWlCMFBTSXhNek0zTXpFeE9UWXpNekkxTnpJMk56QWlJR2c5SWxR?=
 =?utf-8?B?elUzZ3ZhM0JyT1ZNMmVrOXVUMlV5VkdaVlNub3lRWEZqYnowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkN0bU9IRkZNRUoyWWtGa1UwVkxXRFF4UTBod2Fq?=
 =?utf-8?B?RkpVWEJtYWxWSlpXMU5SRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA2PR03MB5753:EE_
x-ms-office365-filtering-correlation-id: c131e3b2-e820-4ae1-5718-08dce9e7a8a8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFVzME1GNzJCQ1hXNzl0ZUhRM1RlV0poaW9ncGpSd1dwVFFQNnFCY3FpOVlM?=
 =?utf-8?B?K0ZXcmRDNTZLdXZPNUJrTVVQbWhsUUNmNVZjcE4xVDFReWxtcEhiV3YwU1RS?=
 =?utf-8?B?ZGVES2Rad2xMNVBxbUprVVR3VWUwZ1VXY0taQ2k4NTJSYTRIVXpzMXpGKzVL?=
 =?utf-8?B?YXNwbjNPMU04OTRrYXE2QUVKK2srbVlhSlJZZ1ZGVjJQZGFPR3lseE9LMUV5?=
 =?utf-8?B?NlNBQWd3bGN2TXVXRUFzcUljNWJrVjNZTElCelNqbEl3TWthNytsSll5bHpw?=
 =?utf-8?B?dzNhdndhN3Y4STNEZ2gvY0RwZ0Z3UWdLSVNERDQ2cnNwR1FTaUZUbG05ekFE?=
 =?utf-8?B?YVBLNkhTd1ZBd1NVNTgyZUhiMktMenZ1OW9OYUhTR2JMTUlCV2FVUjFEZXE2?=
 =?utf-8?B?bEJlZFFzcHU0NGVPam9Za1hCeXpZZmRrYnR5TkdwNUFBclhXV0tFQ1RqMWJX?=
 =?utf-8?B?TzJoZVFNUFZLZ2xtbTNvVnY4cVJ3MmhGM0lHWDQxUXV6S0NuTUVTTEN4bHIy?=
 =?utf-8?B?T0xlVGNIYno1U082ZDYvd1BRUXVnVTJhbTVSa21TcktCTlMrYTBlQjFXaUds?=
 =?utf-8?B?ZnQzb0o0d3ZReVBGRk8vTURGbE0zVndSNnN6MUhxMUVLV1h1MTR4ai8wemRM?=
 =?utf-8?B?UEVJcFRZc08rcTBXajd4M3RDVUE0aE1pZkdiSmQxL0xIWHROMHkzRXpJMEVH?=
 =?utf-8?B?ZWNPU0E3b3NZSWdOUUxic0lSQmNvMjdKazlRRjZUTk42OHdtMGhhY2phR0Q0?=
 =?utf-8?B?U0JkclBTbWMwM2xkdVR0U2duaDhOVW9SVGN6amh3U3VFT3cxU09iSFQvZHor?=
 =?utf-8?B?aEhnOVVBcmFtMjY3cjN0TlkwMHJFNGdxTTgzMWlTWVliUWRiUzZNMUdYNm1O?=
 =?utf-8?B?VTcrR2lqaTR3eWdRVVM5Tytqc3pxMDd6M2pHeDYxWDR3S3p6bG5YTStneFR6?=
 =?utf-8?B?T09KR0MzTmgycUpIYUQ4Z1d1Uzk1Sng1c29sM0t0azAzbmd0QWxaQnpHZGZr?=
 =?utf-8?B?cVRQemwrRUsxd2xQT0ZYa2xCd2RjeWtpVi9uVmpLc2RzN2RGb3ZIcXdhUHVC?=
 =?utf-8?B?cHJRN0IxUCtWcW81OFhuZVhOM0xuUHhPRHlKcEJac3FheC9GeVR2WW5wbGtP?=
 =?utf-8?B?QzFSdi9KWDllZXIyTlJCeUJSaktMZ3RGOGlCenRaNjJIVjJrUlkyc2h4U1lZ?=
 =?utf-8?B?dVBCVTM2TFhiS3F3SXFpSDQ5WExBQUNSNjJSTEt5elQxNEJJRE9xazl2YTA3?=
 =?utf-8?B?ZCtJbE5yWVZ2dFAzeDAwNlhNSHR2OUpaenhuaWhCZjdBc0p3bHRCd2FPMjA2?=
 =?utf-8?B?dk5rRGxYZHc3OVBEWjcxUkg2V2hHYysvK1ZhQm9hUzd3ZGxJZXU5WklGYW5U?=
 =?utf-8?B?TnpaUEV0Tnd0TVprdGVIVDNlRktoS2dMKzlmNWpOL1VHWGpkRENRYmtlVGtI?=
 =?utf-8?B?UjZNem9nc2NvZXBzVTVPUzR2YjE4eW9uck5LV3hScGlrMzRYbDU2dTJzL3dy?=
 =?utf-8?B?ZmZHKzN5bklBZ3lSSHkwZzZQY1pzc2F3eDdwdVlOWThaLy8wSlhVSmxkT2F0?=
 =?utf-8?B?ZmNob0NHdVNDWWFtUGhxQlh4ZkpOMzAyK2Yrbk9Xb0ptMVVsMEw0aXFuakhv?=
 =?utf-8?B?VU95UWtUYnhxZ1BOdHNhSXBlUHlQZlN3QTdqeUNCbkdVa1pUajVZa2hIK2kx?=
 =?utf-8?B?RFRiaWxoQVNlblZ6Uk4xL0E3Z2lhVUdPb0lFYmV1ZzlDS2NTQXRTTldZZTZm?=
 =?utf-8?B?cFlpVmQrOTB5bllSUzdqWjNqRFROTFBQaG1yYzA1WURqUVY1clBGZitoWnl2?=
 =?utf-8?B?ZVpJTW9zZmtsVzdBUU1rUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3laeW9BNEFONXNxZm52c25WWExMTEcvMzZzeVA4SGNQOEYxeUROaUNJc2pl?=
 =?utf-8?B?VzNSTjZWeXRkMVh2bTVrTlkvSTJxWjl4azA2ZUp6endCcXNzSXA0YUlTK3ht?=
 =?utf-8?B?RVZBVlBlQXNTMTRBVERXRytPQ2JiM3ZPcVZkM25NUWJCQ29iQ0NhTyt0SnJF?=
 =?utf-8?B?dUFVQjdabWVpZzVTYkl2STFoZi91a09ReHl0VGdFR2poNW5mYURaRVhsZjdi?=
 =?utf-8?B?L3VjSVMrTEI0Zlh5eUVvdmx6b3hiZ2lNMS96ckk4WnFvQUU4MXMzRDRmb3ZR?=
 =?utf-8?B?eFF1K0ZxZnNaOU5KQjVTbTcyTUM4VnIrWXo0eEcyKzFSVld4cDRDTC9lajRJ?=
 =?utf-8?B?Rm1zMDJWTjJNZ0NFL3JCM0dxTjExTlZQK05BQmdNTWljUmRKZkkwcmxiaFlK?=
 =?utf-8?B?Y1Yza0RiTjh2TnRLT0c1SmJIZEdlOWdZUnNuRDdKYzJybXh4eGt2WGs5VkZl?=
 =?utf-8?B?NGVNZlJZM1d6Q2NrSU5nQU1aT3hkSGpDNlkxcy9KR1kxNlE2dWx1OExnWVpy?=
 =?utf-8?B?dGVXSXdqbm5Hc2FNVm03UjlVbk1MTmVKeFgwNVhobVI4QTVFTkpiWW1RbS9G?=
 =?utf-8?B?MEtQK2RUaG9sN1l6OFdBUDhVRXg0UFRxQmJqbThXYUtCVmVjTXBjb0tPNXF1?=
 =?utf-8?B?VStEUWpzT2VkTzh1VWpSK09CdHk2SE1SUjNzWGZUMCt6NWVKeEp5Y1dzc3hJ?=
 =?utf-8?B?NEVKTFBtM2I1Vnc4ZmgraXQ2SC9aUE1Zc1hoTkl5U2E3ZVFDRmJpQ0I3eitT?=
 =?utf-8?B?bXpNdDFXQ2FjWVR3L2FxcktsQXAvTVFtcWJEVEtiOFFNQktiUklvSXd4SWcw?=
 =?utf-8?B?bWdvSUFQWnJNZ092YksyWDI3SXA3TG5yOHpydHE2cUlTbmMwbysxMi9leG83?=
 =?utf-8?B?ekdpUTNZNjJweTBCZ2U4alYxc0hxUUovU3QyQU5Sc2NjVVZFb1I3NjVDVHVu?=
 =?utf-8?B?V1kzK1FBRytNclMwR0hmd3VoRkJYNWRXZEJDSk0rK3hVaXhqeE5sc1hQeElS?=
 =?utf-8?B?czRKV1ByeFgrMEszQWc3T2JVN05tSjlCTVpHQmtyLzEzQUtvcTZBa1dYdGtn?=
 =?utf-8?B?UXI1NCs4MENPUXNuaWRTZDZ3d2Z4YUhsZEhURDdYaVJpNktSTzROSFQ3aUJp?=
 =?utf-8?B?UXdlUUVGZVYweWkxOUNoT3JxVUorTjBWNzNhYmJoZkZjNTFIZlVoOUFnWDNs?=
 =?utf-8?B?TDlDUXlLRmVpeVl4dHFpWTRKUkczemMwN2ZtOHlIN3IwZVQzNFNlSXM2b2U5?=
 =?utf-8?B?L1oyZHFxSTNKVmc0cTJIREQwK08xeEhyeFdSQnhVR3ZDT1daV2J1d3BJUGhN?=
 =?utf-8?B?M21rR2pyTHFxL0lkSXFwaWN5aktFRUZqYi9mSUl1aERGaEJJWktxeVROUlF3?=
 =?utf-8?B?NTd5SGZWWFNxNll0OHp3RnlydG4zQ0tha0RCZ3B0Y1UrZ3BnN3VIRUNlY3BI?=
 =?utf-8?B?THhoTzVlQTVvVTVFVDhMYUsrbVhkcktTcW5HMnROZE8wNXN2L2s5c0NNcXE2?=
 =?utf-8?B?c0xEcDhxeFlJc25MNWhFYndQcWFyejFhbmlNUHpMUWVnSEl5RStBVStpUEZO?=
 =?utf-8?B?K2g4cnRaejh3dStpeDNweVRaY29GckhFVU02YXdmL0FFazcwbCtGQnFCeFFP?=
 =?utf-8?B?ajJTTXlIVk5WVmFONld4cVRCbDR3dTlVR1lIR0lsYVE3ZlNTdzUra1NJL0la?=
 =?utf-8?B?Wmc3RXJVNVhrMmV4RWZ2dldTZUdod1FKakJmeUVGTkNqd2VzdmZHelBTcmtF?=
 =?utf-8?B?ZWF2bWJUTm5kbWYrdk5CNXYydTVWOHEvNWdzalIrNnZ4T0FudHRScmJRM3Yw?=
 =?utf-8?B?bDV3MVdWdjhUdndQYjZiWGNmei9CU205Q3hSRE95SWNRMzhBOTQxU1JaeHRE?=
 =?utf-8?B?NEpjR1JkMVVPM1c0blNyMTFaNGZjdExDR1dXODNWdlA1aVJ1SmRFb0cyN20z?=
 =?utf-8?B?czhuRVMrV1NxSUJhREpXRFBxMHMwSTB0RTVNd1VZcEovU0x6dkM0enN6Q1Z1?=
 =?utf-8?B?eFg3blJPOTAzMWtZWDBqajR5ekZRZnRxMFBXbFlvOW5yYnk0TlNYZjhYMzh1?=
 =?utf-8?B?T3ZMcDZkeWg4N2syeTl5TExadHhsaWFoUE9GaUpiT2pBblgxK0xrSUwwYjJx?=
 =?utf-8?B?OUJ5blIvcm1acU9SVlE2M3pCaUNnRlF6VzAwQzg3OFVBaWd2UjF4QVB4ZVNV?=
 =?utf-8?B?cmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c131e3b2-e820-4ae1-5718-08dce9e7a8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 11:27:15.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TMwjDRu2im5GHEviVB5SHoqvBnTANZGarjARYAIXd348EBRO/hWQcRdNK/jDR6oYPg1jWWsgJKinQzYTcpcK6pzI96+pKNz/MgQr/jGbq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5753
X-Proofpoint-ORIG-GUID: N9F5SNHxP59ft7xMlknfjbwGmHQglgDy
X-Proofpoint-GUID: N9F5SNHxP59ft7xMlknfjbwGmHQglgDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=565 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110078

PiBPbiAxMC84LzI0IDU6NDggQU0sIE1pY2xhdXMsIEFudG9uaXUgd3JvdGU6DQo+ID4+PiArc3Rh
dGljIGludCBhZDQ4NXhfZ2V0X2NhbGlic2NhbGUoc3RydWN0IGFkNDg1eF9zdGF0ZSAqc3QsIGlu
dCBjaCwgaW50ICp2YWwsDQo+IGludA0KPiA+PiAqdmFsMikNCj4gPj4+ICt7DQo+ID4+PiArICAg
ICAgIHVuc2lnbmVkIGludCByZWdfdmFsOw0KPiA+Pj4gKyAgICAgICBpbnQgZ2FpbjsNCj4gPj4N
Cj4gPj4gU2hvdWxkIGJlIHU4IGdhaW5bMl0gYW5kLi4uDQo+ID4NCj4gPiBBcyBkaXNjdXNzZWQg
aW4gcHJldmlvdXMgcGF0Y2ggc2VyaWVzLCB0aGUgYnVsayBvcGVyYXRpb25zIHdvbid0IHdvcmsg
Zm9yDQo+IHRoZXNlDQo+ID4gY2hpcHMuIFRoZSBDUyBuZWVkcyB0byBiZSByYWlzZWQgYmV0d2Vl
biBlYWNoIGJ5dGUgcmVhZC93cml0dGVuLg0KPiA+DQo+IA0KPiBTbyB0aGUgZGF0YXNoZWV0IGlz
IHdyb25nIGFuZCBTdHJlYW1pbmcgSW5zdHJ1Y3Rpb24gTW9kZSBkb2Vzbid0IGFjdHVhbGx5DQo+
IHdvcms/DQo+IA0KPiBUaGVyZSBpcyBhbHNvIE5vbnN0cmVhbWluZyBJbnN0cnVjdGlvbiBNb2Rl
IGlmIHdlIG5lZWQgdG8gcmVhZC93cml0ZQ0KPiBub25jb25zZWN1dGl2ZQ0KPiByZWdpc3RlcnMg
d2l0aG91dCBkZWFzc2VydGluZyBDUy4NCg0KVGhlIGNoaXAgd2FzIHNldCB0byBOb25zdHJlYW1p
bmcgSW5zdHJ1Y3Rpb24gTW9kZSBmcm9tIHRoZSBzdGFydCBpbiB0aGUgYWQ0ODV4X3NldHVwKCkg
ZnVuY3Rpb24uDQoNCkFuZCB0aGUgZGF0YXNoZWV0IHNwZWNpZmllcyAocGFnZSA0OSBvZiA3MCk6
DQoiSW4gbm9uc3RyZWFtaW5nIGluc3RydWN0aW9uIG1vZGUsIG9uZSBvciBtb3JlIFNQSSB0cmFu
c2FjdGlvbnMgY2FuIGJlIHByb3ZpZGVkIGluDQphIHNpbmdsZSBTUEkgZnJhbWUuIg0KDQpTbyBJ
IGd1ZXNzIGl0IGlzIGFuIGVycm9yIGluIHRoZSBkYXRhc2hlZXQuDQo=

