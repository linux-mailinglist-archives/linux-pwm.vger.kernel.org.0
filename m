Return-Path: <linux-pwm+bounces-8969-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAHyN4wtC2opEQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8969-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:17:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911056FC06
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F140C3011F17
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4737188B;
	Mon, 18 May 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UXpRR2DV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F1199EAD;
	Mon, 18 May 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117266; cv=fail; b=LOWRN7SjetiiZbKHjQeEZaLHYkPek1j4EnB0JrD6DLhE09Mvzq8d0LvhSXSA30HKxuSXINIJzr1ooSe691z9G/1dQ4OoRXYR0q1UFnO3rNL4n/azxqhsjqmE110bBKS0FC7fPRdsOMD1hIv9j84C9y8Pbzj+gY5oBPXdQcu4RBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117266; c=relaxed/simple;
	bh=pA97AL4sbz2jpGjpplz3MEFKri9rp9pdjU7Wzvgq91k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XW7IBznFD1iGtRZHVPEnKotWf17uUwHm5WtVEJTu8jcVkqR9nYE5QjRyewsIma6HnS5+ogQFnQy52INgQ07mw7kgEz6QIfvzlgIlsxq1xXLQhIGhNfWuZd9TwXJgi1f2l1arm09Qf0z8IuzEjGcx9ilzZBL6hn5ZTDRIp/15ulQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UXpRR2DV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDgsr31021099;
	Mon, 18 May 2026 11:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pA97A
	L4sbz2jpGjpplz3MEFKri9rp9pdjU7Wzvgq91k=; b=UXpRR2DVFy17Ay574wnZh
	LsAPRvrL6SsYXRAWbqUSECVl/poWOMcZZtdwgfWI6/q+GEVWYmkoVZtPvDCDbTN0
	b4JKiZN76xR2bm6GCJv3cIlo1yVX/bpMewdg8Hi97ku+L+iRQR04mV5uHQkFnbdC
	gHycAYaD9dZF1WAjHhyKqbDlWHdkBU4H2iBg/PsOhfNtq0+KR0FDOoSOmjW8G9hS
	1eXQ+1y4iLqLv/vlZRn4tQ7b5gznt1GZwrA8swMu6WTn1vzVrQy/Ed/3ZZEvkO7o
	3ZVTEDysfstHHRtFOO3nHe1IH2IfoJQfKG9cjCD5VqTiF6qmypdT4rT4VSY7G2fA
	g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e7ppd2js1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:14:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0z2m4iUvpz+CjaGM2RN6xJccalrNv6f+fB/4ivTIZyQ5gUdxF+f5jCeUcgjdkm6n6VDxLNb4sSFRRFuaEbAEZLD93JQl2vtU1e0Hl5+ZV8XJjUEmSo7JbQwM9U3Qtu4RsCilQOYyYi7XmNKf+nF6UsqZsnPuTAfFcQCY3hRYyj6APdsb+SAtEdOyItTCn/6XR1zbVALCekVI3VLZ39u8yCFxUZ/clTVNpi/7N15g1SF3aj5/dTl4ZVl1i+SrJBIlxemd5ngozmTSjQQVAKlZipub26461SJCqgnKYEeCxMJqCx3XbE5ko6WIZujkmM56tWAUK14nVySEev+HaBSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA97AL4sbz2jpGjpplz3MEFKri9rp9pdjU7Wzvgq91k=;
 b=SQgk9AcciBv6A7HPDnxEeRmROlfhQKVAR5W0HgfFqS8W4atVwdHXNfpnaRW3t1Aae2eCj4zdR4ky37ts0zOvqdpR4j9dLH3O2tfjBWSlrdFBFV50AYXjvyquQ0QIjXpo+rg1CMiFsypUJAyeFQwnJ0fMgEj/S/SFl+b9dzPNhqKF7xZTKMjToFmAyRwt/oL7oIC8cRq+MxaGl+HTn0tL7k0/6Kq+Y+662J2YIXK9ZW7st4x78USQuXZeQtYsMloR6dJC+yTeYPDqN2/jClPGQYY8pBH8mc/ibPtF5ipSAPjAHBBNZwlQoRXDZY+5KYheu4cQI/9AN7Q60fRRrSBpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by LV4PR03MB8187.namprd03.prod.outlook.com (2603:10b6:408:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:14:02 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 15:14:02 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v11 4/6] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v11 4/6] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHc5G8p9OqxXPnDyEqwg6OamJHQvbYQ8NqAgAL2u2A=
Date: Mon, 18 May 2026 15:14:02 +0000
Message-ID:
 <LV9PR03MB841418AEF0059E802F7A69B2F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-4-eab27d852ac2@analog.com>
 <80f61c0b-1f36-4fee-9f76-b93f63b87abe@baylibre.com>
In-Reply-To: <80f61c0b-1f36-4fee-9f76-b93f63b87abe@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|LV4PR03MB8187:EE_
x-ms-office365-filtering-correlation-id: 1c46da63-acf0-4242-2336-08deb4f0186e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|11063799003|3023799003|4143699003|22082099003|56012099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 ayQIp+Ih5zoPUVO7prCbwS5uX/fLSa0GsBA7MI2MUkUdWMZvcVIIejaO1Qw7ybk8sHAZ8XJpJ5Be6J0v/0El9ab+98rOwA0TRUaZrZbphlqQGhZUKitIZD4/crS4Iuon7FjCQmu3y4kKvK3FkAeEjS9xOq6xMhOO8vty6TbKZkM8tLNDM+aw5gTK42wOE658SEhkmG1H6wR2nZ+bXRVrQ8cYEF5kz6HDToG6vTP/nm6rQLNbyxZbojb3t2S7izHb327zIrLXWH5vie2bYfPtXdy1s3CT3II0QCw5LSi5LVJAn7ois1CBtsDXjiu6T/T06PbdQNNAjskGVcwN/Mb14K+CUyJahbcif7YEIXK2locDYokjLbwl6pxo6bMlJHlESM1fruYg/u7mFzD/a8Y8gb/H8GdnZy9+kslwhrbhHyMPyujsWQIIDaKwRWN0oJTF/w8Z8jG3fpE18dSKIDvoFpKNw4V+vghYUMy2AwEo/5D0bZ95Y+zeWBTFvuS0b5rrnfx9q1TwwhBgTnTawjCDXjiXUg+OIbl1WbAOXEb4aDwE9GS7+eJBPAuY6OCk2JlE04l8F3RFpMHdVwPeWR1SpmbSA/vRjK7rJHNOcyXgX5HQ8TL67wKKPDWp+JpDy9ETdNt6neHcyhZ9g4HlHl0VLC1zE/JlHfojVNukesYha8zhxAmCQrME2vEOfz3rLT4VHHNSBDAbpTk88nAePlUTow+Q+Vwn5gqw3rHhxES6g0NLU4cYgZqKqsmIYUvBh6n7Po6ZzrP/BPDKd2k3ZTYx6w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(11063799003)(3023799003)(4143699003)(22082099003)(56012099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGNkb3Bld3MyaVZLcnluMlduWHN3a2dxQ21lTWhuK3ZTVUFMOTMrV2hKYXRF?=
 =?utf-8?B?Qm1sOHZVOFdjRTRQd1IwWHNHSjNva1Y3WWUxdGwxOUlYdWp0eVZ2ME54VzRQ?=
 =?utf-8?B?eHFYZWlsSnN5SzVxV0hzTUVzK3c5aEJkUGV1elkvY3RndHVOZTF6cVJnMXFi?=
 =?utf-8?B?djczNkpBS2ZWOVhZbkk0WTYzeU5UMkFreEt5bHVkeG5RWTU3RTdrTjU4ZlFl?=
 =?utf-8?B?QUoxVFNreXJwdkFyYjhQbEFhMVYwWm5OTnF5RGhsL0pkM3BXTmp2Y1V6cjZQ?=
 =?utf-8?B?U3pESjdyWVZWVjNhMFRDaUdidFBIVGZtVTBTL3hqQlRZQ2xiNC9XU3lNejNE?=
 =?utf-8?B?TW80WDg3SzE1d1BWSlhjMWV2djE2NDhwYTZpaGV2MkZkWEl6M1dHekdTa1Mx?=
 =?utf-8?B?OCtldFdZTnlWekVoUDhQMmtoRjJwaTViRVExaWNBamdMMkQ4YytQSDJBcHQr?=
 =?utf-8?B?QTRqM0xIckQzeFJVcFl5OTVGazNnNmpGb2tYZWFRcTRsYU5DdXhZb25KNTBV?=
 =?utf-8?B?OFp3d0JvVm5XL0xFaGFrWkF3bVl6RFJmb01lM243THZ3QzQ5d0JJVVhMMEQ1?=
 =?utf-8?B?SFlueUdHUEh4Z0d6d3VZUzJSUEFLSXRTeVFKZ0FqT3YrSHkxY2h5MzVsZnZl?=
 =?utf-8?B?RUpLY1BTUUttT1JhK053aEpMNy85VyttZGErQ0h6K0ZkVXRDRjdpdmtSTmNK?=
 =?utf-8?B?eE5hdGY1dndNRzhiaVJ3R29zeEYrWUFrVEQ5K1ZBSk9hbXkxbVNVeXlZSExI?=
 =?utf-8?B?cE9raHBEY1AvL3FvMDVwV3BWZE9jamRBOXRBZ2tsM25FdHMxS2QveFJ3QXJ3?=
 =?utf-8?B?SzA2VXBIN2N5Wmc0MVM1VjBCRk9nSFQ0YTBHbGgwVzVENDB0SlUrck1FeFV2?=
 =?utf-8?B?SmJlckcxdU9qUHRPU01yalRuYUgwWnBPaEJiaWpVa3QrdmxOTlV4amZmR3ps?=
 =?utf-8?B?YzZ5RUJ4N1J3ZERQV3hSMGF6UUV4YTNZNi9qUVVHVG1PazN5V3BXSUhkUzVQ?=
 =?utf-8?B?Yjk2YnN2K2N1VGRDbjBydU9pUzFxc1hqbFBwZkt1REtvcXRKS1Q1VjNhc2Iy?=
 =?utf-8?B?UU9UNXRGYVdsd2NqeW81QmRMT0oxSzU0VHNVbW95UXkwWXRFQ1czLyttaFU4?=
 =?utf-8?B?eFlURGFrY1loNjB4RWYxNkhaQmJCQTFTcG4rYldzWUh2RFMwU21CcTU3RkFM?=
 =?utf-8?B?ZjExaENJSlRRODhBMnNscUdBS1dMck1SaytuK2w3NlcyaGJobVcveXpHNVNC?=
 =?utf-8?B?dHQ5a3Jnbjdob0tqdGRWa3JxT0h2YUxTdm9EekpjUUxQU1RaYktlOXM5Nm5o?=
 =?utf-8?B?MUlmRVhhVFgwRnBoM1JUWmMxZVpqNTZvcHNGOEQ0VU1IK0xlVkpKT0IrbVlv?=
 =?utf-8?B?YVMyNXNIUWNTWFFtMkhJb3JKUnVxWUVhRlh4R3JnRXhvZnFMSDFEK0ZNSGRm?=
 =?utf-8?B?S2thaE5JeGZ4K2dqMThRYVNFSGowbE5HZzBDNmxUWmxNejdLNysxbjRjaUI5?=
 =?utf-8?B?OU56bFluRDJwQUtYbXk1NEtPZThRRFNNZzlDSXNDNWNqTUExWExoNGFsczJF?=
 =?utf-8?B?a2VxcHRQNjRIQ3FsdUZsSDl2aHY3bVFBcHpMZWpBVVd4STNkN1ZHNG5XYTJP?=
 =?utf-8?B?TjlqY1I0M3hIeEhTTm5XN3MrcEZSbnpreGRCQWJqMFlYM2lwajczUnJwZkxB?=
 =?utf-8?B?VU9lUVdqSEFEUFp3SkR1M2tVY0JOdlVYU1J0SkNTVWc1Q25XOUhxV2JYajNj?=
 =?utf-8?B?Q1hOKzdlN0VvSzArckZieGphQTNsVW5lbXRhZTJSNFJyUk9RYzFkMEQwZWwv?=
 =?utf-8?B?dGRmZCtIWGZQWWthQ0JZWTF2OTFpRlllbWRzMHlneVN4ZkI5RXZrM2IrU0pU?=
 =?utf-8?B?clZIL292c0FzMUY5THcwWTZpUDcwN1FCWDRGWDN0bnd4NTEwSTN6UkIwL1lJ?=
 =?utf-8?B?Q2tscnMzMWN1Sk40NnFYM0NiVGRDVmhQR3FyamZ4Q1JaOWltKy9LR3g5anJr?=
 =?utf-8?B?ZFJQL3EzRktwaEVSZ3lrVU05T1dqYmcrRk9BTVNYRWV2N0NHOGM2eGIrVUN1?=
 =?utf-8?B?YXR3SWFZelN5UHdvRVdDU0xja1JGdllIMDBiTlByTlBSUFl3VENpbDVPd0hP?=
 =?utf-8?B?VEVaMWcrQisrdlFrZWVSK1g5bng1MlZCaVlSYlZkS0o4RzFMZ25GSFBpaGVG?=
 =?utf-8?B?YUZGT2JyejNpYldiaXBwSHRZMkF6MS8reFNaYzI0aFBHRGJNaUJlUVVuRmNT?=
 =?utf-8?B?TlZMNDkrcEtUMXJCTUQrUFFjU2dseGtBWHVJS3BZUDZaVE9ZM0V3cEp3UFZ0?=
 =?utf-8?Q?9zU4QwEp3HlBBkc3cT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jqo32pnQuf2DhItuWtb+nvmiNezAk7QWGtbxAFWQ6BUbfx8N4m9tLOs1908sqVchQfmrN5b5Ar7n0iNzH34mY+aqE2kADgvq/tkLFkVYocZEYzqq8Cjf0q4StIL6OtrS0staobt0eJs6D06Tn8iOCol0hotKzIbvzFlh5g3huiOzja0RRbuOSq4duiGyy2zmpFCC4jBhg7kUE1SdWN2zlA5hUaqw9qMKl6MBnQ0Ev9oXlEKnB7VN36ncm/ZUSCIWCVMeeG0GkaqzGsFMohV3yAo1QQ88iiMuPs2yerz+6K5T5lMSxkhF9F6QY3eHuSTuGr2rKnJRfW34ch9tbS4eYA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c46da63-acf0-4242-2336-08deb4f0186e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:14:02.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HuoT8GW/OtrdCvxJV9cDHxHOVLyAWq1C2Tk6WFzt12XG0dYUCpvUEEulAIItoIX5lhJw0/K4aRAGf1e6d7dwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1MCBTYWx0ZWRfX374z5SsNhLY0
 8j4mLJ28qFsr8PmaOr1dxiYOKgJJLwoAp/RyZ/Ziosh0JHGKL6p3ifhMvexRO1+fMmy8JvxMWtX
 vtit737o2Cn8D153C/T47LimDmRvD26Xfl5jgP3nKnKHGRFKaSRki+CSKzZP+7NzMMdg01EPksi
 Ydh5qksEhytnBXVaawrjHTskoLH+vLeoY/zpgOyBS54SaKU9aj0qUtZ9hqlfByzrDbhuABnEE9T
 GPhQX1s/xVtnuQrTWRq2mcO2lP90UtnFzXj7UTBchCI6IhhJ5kHsQn3jjJmCGgZTaYHBMZCaXih
 dxW4jRUotWLBIPRtHBkL8HNZvn+b7YjOdj6HAKiETP++K8b/8WYR9mT8OxOHItqTdwj8GlIsXOv
 ub90k5jAv8rs2NPRS6mpkIsm/px3CRMPfKQYyJB460UDxlaeW6L3lIDfIH6uWd3YxZAuatB5Ogl
 9c0kZBm6eP4dZkelXRw==
X-Proofpoint-GUID: Wc-fYjLulpIGgcUUe-Q_suowckTwTOVA
X-Proofpoint-ORIG-GUID: Wc-fYjLulpIGgcUUe-Q_suowckTwTOVA
X-Authority-Analysis: v=2.4 cv=LYsMLDfi c=1 sm=1 tr=0 ts=6a0b2cbe cx=c_pps
 a=/+xYJgQt7uUW31a/4HdwMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=IpJZQVW2AAAA:8 a=8OBH0jWXJ-2Z2woxt2wA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180150
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8969-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4911056FC06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMTYsIDIwMjYgODo1MyBQ
TQ0KDQouLi4NCg0KPiA+ICBzdGF0aWMgc3NpemVfdCBzYW1wbGluZ19mcmVxdWVuY3lfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gIAkJCQkgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsDQo+ID4gIAkJCQkgICAgICAgY2hhciAqYnVmKQ0KPiA+IEBAIC04ODAsNiArMTIy
OSw5IEBAIHN0YXRpYyBzc2l6ZV90IHNhbXBsaW5nX2ZyZXF1ZW5jeV9zaG93KHN0cnVjdA0KPiBk
ZXZpY2UgKmRldiwNCj4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBkZXZfdG9faWlv
X2RldihkZXYpOw0KPiA+ICAJc3RydWN0IGFkNDY5MV9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRp
b19kZXYpOw0KPiA+DQo+ID4gKwlpZiAoc3QtPm1hbnVhbF9tb2RlICYmIHN0LT5vZmZsb2FkKQ0K
PiA+ICsJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVsbHVcbiIsIFJFQURfT05DRShzdC0+b2Zm
bG9hZC0NCj4gPnRyaWdnZXJfaHopKTsNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIFJFQURfT05DRT8N
Cj4gDQoNCnRyaWdnZXJfaHogaXMgdTY0IGFuZCBpZiB0aGUgdGFyZ2V0IGlzIDMyLWJpdCwgYSA2
NC1iaXQgYWNjZXNzIGNvbXBpbGVzIHRvIHR3byAzMi1iaXQNCmluc3RydWN0aW9ucywgc28gc2hv
dygpIHJlYWRpbmcgaXQgd2l0aG91dCBhIGxvY2sgYW5kIHN0b3JlKCkgd3JpdGluZyBpdCBjb25j
dXJyZW50bHkNCmNhbiBwcm9kdWNlIGEgdG9ybiB2YWx1ZSBhdCB0aGUgY29tcGlsZXIgbGV2ZWwu
IFJFQURfT05DRS9XUklURV9PTkNFIHN1cHByZXNzDQp0aGUgY29tcGlsZXIgdHJhbnNmb3JtYXRp
b25zIHRoYXQgd291bGQgYWxsb3cgdGhhdCBzcGxpdHRpbmcgb3IgY2FjaGluZy4gV2UgY291bGQN
CmhhdmUgc3QtPmxvY2sgaW4gc2hvdygpIGluc3RlYWQsIGJ1dCB0aGF0IGZlbHQgaGVhdmllciB0
aGFuIG5lY2Vzc2FyeSBmb3IgYSBzaW5nbGUNCnNjYWxhciB3aGVyZSBhIHRyYW5zaWVudGx5IHN0
YWxlLWJ1dC13aG9sZSByZWFkIGlzIGZpbmUuDQoNCg==

