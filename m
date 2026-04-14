Return-Path: <linux-pwm+bounces-8576-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNwwG8sZ3mmFnAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8576-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 12:41:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7F3F8DF9
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07EA1305266A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2EF3D6691;
	Tue, 14 Apr 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OwNSrv6I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB93D6472;
	Tue, 14 Apr 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162569; cv=fail; b=S9d5oi4rOaY3tk5X6nJ6izTbnUhWV9NRkzsQipuJJdPJnsTX8nhjhZxqaaoP+lV/DnppTxsjK3GOJa8L5dWcoTchdrRrViDYjera1Vmbxu8T/+xOtEGYTlcvKGQ6q9JwNgreJo0qukkvpvd/7mYla8N+DvN8fEzsjTgs2ce7Liw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162569; c=relaxed/simple;
	bh=oS4b3Cpi60PTLjyvAZLqnFOus4eeioh1At+a1OcsjFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rs7yqcr+I1Aq5o1PLEUoz7v0e5LCkKvqFqOZuav7v8Sf9HoHAB7duFTuKSZsGhPY6Y8dAXXVrfC2VwJH6Qxi9VRmt+67TTRBP0hk3vVDmXOtdiwT/t8ruTjk8zSenKYFHG7N7z60+Plu5VB+uL8AS7fmZnneXz7tr2ynL0tS9ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OwNSrv6I; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6Csue282508;
	Tue, 14 Apr 2026 06:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oS4b3
	Cpi60PTLjyvAZLqnFOus4eeioh1At+a1OcsjFE=; b=OwNSrv6IPb4QIqd5Ztoih
	ZkR7TWM0CTLw/Arn+ppVDhHRAtwgOXeYNjlTbU+ErC/ugKEbkAkFWc8wuzgA5syS
	5ww/gQ/q2WnYQftnnqp/htzUDEopn2EZZOtAOk9mL0KjZpM+orffcjTDYMyX8GPi
	Op+fQXdxgEgZMH0Vaq+AxLE4lzW5PChac+SEXRukxWPJn8dgkFFe7BjuoQa/ZBnj
	htQpFg0WbSTZMh+tFonos1XmjKRBHiqUnbUsn7i8bmshFPLYZdVP1MWq/5rhphal
	PGuz3cu5jFklyFLNrcnjfQOGJu0Dhcc+0xuPDg3sWX+AiHaevJcz2uG9qyJjgfuk
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84randj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 06:29:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+LLDn05U2ACNxfcUq3jBAweBGfxQ+qyirgGwImaUXKm6sxnvYdqsrLomrklGxoxKpKmcFG372+CJNRqavv5C20JM7FfkpZF7Nox+kctWhcQWQGkfpVJh5MKcPnJqGLOf5x166xzyGBEb2gTEjzeCobHqHvRmUAuKVfRolm89Z14I43bE2vb21sIowqDAlqU10e2inCewDE6b6FmbyaBtQhBsfOrmyZ0+326DYwiI01OzAgWa//277Ug/Cv48sZNvEQtz4zz+Gu2fmml95emG183FwaCZGprQZrJwCV/tVZsqYgw4RTitEWKbR5Is484AnPRRBxNaTndLgKrxdPQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS4b3Cpi60PTLjyvAZLqnFOus4eeioh1At+a1OcsjFE=;
 b=kWNj0NOhv7lTCT6MmZZGg3ORVbb/L3NIspOrXlfyZx0uEwTF07als30zEHzuzbr75rMGFbVeo8MJL/4QoHJyHLcZAsC5gAF6ez9a/sYeEkF9p4THuP8s7/r7lZtI18GDwPX+FVrHdgJfPtslUZA4CJvw12E72sn8lVC+U/KYkHzPG1liRb+ByzhC5bXs/Tn2ENZ/+rxftWOC9ITi59nnazscB0Npw0isGSGLibRAh3NysEHNB0ayqCZKjYs75eGgMFAEEiWZ0/fyCHSYNcKBmFAU7RCIiXIncJwN6SG/ShpKtof8wVz6UvanFaCSPjABFw4tvPV3WIHu6TJdpPz4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB5693.namprd03.prod.outlook.com (2603:10b6:a03:2de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 10:28:57 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 10:28:57 +0000
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
Subject: RE: [PATCH v7 4/6] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v7 4/6] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHcyDWImft9W8q7/keMNWMQBvIBoLXYycQAgAWYEHA=
Date: Tue, 14 Apr 2026 10:28:57 +0000
Message-ID:
 <LV9PR03MB8414712F593721FD705AFDE3F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-4-be375d4df2c5@analog.com>
 <1170956f-da05-4280-990f-64306ca905c2@baylibre.com>
In-Reply-To: <1170956f-da05-4280-990f-64306ca905c2@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB5693:EE_
x-ms-office365-filtering-correlation-id: d327c09c-52f6-4c0f-4bda-08de9a10a2f1
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 Mp9ZbPIu0fn741iEwnaPMGPvJJt/w6oSLTu7UumedgvhzT6S3xBl7mmpip5AWJSxW+Irb5WaWP1QlI6eN+/CShy8pkvRvEF5jgfgHtI3iQmWif8KTxQGNabo5BRfSlXjWgqFbRWCjoOGfyFyvi8lbteR8z8nVrclUA5la8ED58j/QJD4XXRd/n2SqiokfchoezMP/uaJXXs47WIm0P8RWIzDv6mv1dtvbEVxLw5Ah7oVlRZ5Wi24IdFkx9nTds5g2BupVxWKYDgm8S0+p4JPQAyxm1m/2NuN5Cj2Gu4v6fMToe7VGsPOffbmUNKGqJP0QOc24hwtB1u6jVvVU8hJ4MfdR8fXYbt22mv5zRbDhQk2X4VcHAlwTII2d0dCCGgmsMIemnWlIJQZ+xLCIYwwp+EH/GzzWEmLoyUX0Z+QaWiXIIwUCy6KCkPdfeTkdXURH9+MtMY22ZlMO3gDceH62yx0en61YrapiMuUsJ7SC4Nqf1cbE5ofIxYiqSXGMxgWWj/Y4fP9t7eRvR7p0jIerOqwhF+m4klMMzPJ5T8xbJx469qbJI6d9YyA5OvVTWl9sekNcm2Jhnyf5bfmzEpkmN2pge1/JaLCccVPzl/bR3xn7noAcsu8VVwSUWyqPPu9MHXka3PEYqimLQ8xRIMg9SFPBljyieZPFNzsZKbRnOBqV2nKmoxr8b5bU8mFAB8F1ApNY1vhBWZqL7SmR8XmZjJo2iH0H3QK5/aF1rmgTh42BnPNRTILB75SqmAbQ7N1upoX8LF2O2QpIC4RPTQK/ezEqa1Xb11czerKva570o37XeXdRdcOdNfSB47fZ79Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWV0LzArZ1gwZmxzK09NZEFPaGF1aVI1alZWZmxVWlp3bmVOb2xrMW1IanJk?=
 =?utf-8?B?amR3Y21iN1BHM1FUS3pmbk1vQjJsMGFBUGd6U250elEwMVE0MnE2TEVFM3dn?=
 =?utf-8?B?VUhQT0YyOWZCcm9sYTB5Z0gva0xiazJudUhJd0dtSEZrNTlmNmJRV1RvZWli?=
 =?utf-8?B?djlqYWU2cUlOMzMyUmxDVDBCSDVWTE9QRC9KR28vajhJeTJhcXVtenU2eWpv?=
 =?utf-8?B?SHBUT0RxYTgvS2t5SzF5VVMxRzVFZG5ZOUhiUUpXeUJLL2daTUJqMDNkMjlQ?=
 =?utf-8?B?R25tNFJxekQ3K3FXcDVRODRrR2NJVWF2b0lBTzIweExnVFdiTndybndDTlVq?=
 =?utf-8?B?WittOXRFWEloMEJ3bE9zc3ZlaWtWVHV1NlQ5V3lHNVBockpXMFFUQURvdzNi?=
 =?utf-8?B?MjZreUFPRUwxR0FsaVg3M01BMmNrN05BdnhXZi9jYndXdjNHWDlqNVgyb3pz?=
 =?utf-8?B?YStBbnZTT0FnaEZ4M2pjcEM4MWZpR0RCcVZ1WFFjNlkxZ2NNQUo3cGtLV2Vy?=
 =?utf-8?B?NlRWcFdRZTdaem9KU0tiblhnbEMzN0UyYVBCbE5QL0lHR3dBN29ZN1JjbnlB?=
 =?utf-8?B?c0pVUnREd1JmSHBlZ2pJQjlKbW1tejNhbjQrKzF1ZTNHditEK1F3THNSWlY1?=
 =?utf-8?B?OFBQVWd0b01jSGV0b1VlK2R4VWhaRnZncSswd0hwcEJpKzJBQ3p4Y0YwVzN6?=
 =?utf-8?B?RFVSck1Ga2Uzb2UrTW80T2U3VHZOVGplSWthRE5HbGlnTENNcHhValQ5SFI4?=
 =?utf-8?B?QmRTeE5xOHB4NmxLRnJNQkQ2Vms0NWc4WkxYRVNhNWxudjNBeDhzdkVSS0ZV?=
 =?utf-8?B?TTJCUkcyR3RDcUVGUU9ZVlVPVVpQMU5OTU93NnBlcDlwUnl4bXlhRm4zbUhn?=
 =?utf-8?B?M08rSXk2ZEp5UU1xdVZjR2tvQmhCa1RER3hqejhOclh4NXZ6clAySGJXSjU1?=
 =?utf-8?B?TURLaW1uZW8waTU5cm52cTZNUVkrQTB0L2FmM1dXL2VDcjBLaGtWeTdNcnBm?=
 =?utf-8?B?ekFBUzNQd25KWW11YWxZeXRtc2ppNTdaWDdVVW8xcmVxczR5TW9zajFEQzhR?=
 =?utf-8?B?bVNETlVEbkdKcXY0N0JnQ2U4K0FnbU52bzlBUVVzcjlrZmJveWwyQnlVWkZw?=
 =?utf-8?B?cXJHeFg2UUxOdkZ6bzN4TFJYblBVdUZpUkRtNHVvU2FsQmFNWmRIc2U0enA1?=
 =?utf-8?B?bUw5TkpqTmg3eDhTSTIxemZUSGRTQjMzeWdFUmREUTRjT1hBTVlFZ0VqaVRH?=
 =?utf-8?B?YlBpWWx0U05udm1GdDVCS2FTMEtQQ3FZM1MzQWxDSldJMUVVNWNWNnpJZGFC?=
 =?utf-8?B?Z1ZRa0JrWWd4WFphWHU2a2ZnUHFnL2loVXdGMXNyQUtUeXBvR3pwY01tTDZB?=
 =?utf-8?B?c3lnTnFmcUVKTXdqL250SEZya1JHcTRqWnkzYTYyVzk5Z09tQ0xXRlJOdGlE?=
 =?utf-8?B?VXdkeEY3UVdEbGxlOGgzMVFKWHo1bWxIdllxRUNrT2kyWEF4M1IwYTh0WmIz?=
 =?utf-8?B?MExrL1h4V3Z1Ulh2R0w4VjNlWUNHdDJlY0RPYnc3aUF2bjhzWWZBTUFoM2ox?=
 =?utf-8?B?NCtyKzdxTHdzSytBNTVycCtXZDF6elFGNE5kT2JEdE1rSUNNZ1JLS2xPdTR0?=
 =?utf-8?B?ZVc1ajFKTTdPZk1qeHdzU1ppckpnaFZtUzhITm82ZFZMMWI0YnFpeUcrVnRl?=
 =?utf-8?B?OEUyL1VpbVkwVlgxMXdQSnNaSEdkWHhVbGw5cVFGREd1NTZSeGMwN1U0dlRh?=
 =?utf-8?B?ZXVRck9xTjI5cTFqNU50aGIvMUExMzBwYXNGWUswOEplMVVBcnN6c3plbkVJ?=
 =?utf-8?B?OTNCZlhpR1hXdXByNFRUdEVuYkZ6TEZyL3d2ZitTSktDaFNnbmthQXorRHhh?=
 =?utf-8?B?SXNmZXh4R202OHFDdzhpSUFxVUNNM1ZONldQckVtVDJaZG1qS05yclZWWEtu?=
 =?utf-8?B?ZVc5S3UyVlB6Y2F4MlgrMVdBem91YWRrZ2NydmxET2NybUJ1ZnU2b3RlVzdI?=
 =?utf-8?B?QW9icm1aNHlBdzVDT3RCK2xCWkd4SVJRQnhLMnVkb0gvcytTQTZSZ1ZTM2dm?=
 =?utf-8?B?Nm1KQTZvTnBZU2huNXVQN2gza2dpTkNLWm5XK1c3SnFGSGVsdVZDN0VIU0J0?=
 =?utf-8?B?ZzVtNEFZVS91MzJsME1zMlBhTFBBMVBGaWlhTXAzNEVxNVZVSVhXMGJ6cFNT?=
 =?utf-8?B?MWFzYnIxbTdjWmx1a1BZeUNNcStQUWcyU3I4L0ZmdkgrTGVNckp0NEVhbDUx?=
 =?utf-8?B?MkhPVkk5bWJpWmtFblhyQTJxRHdnSFdEQzYvNk9xejYrNG1pelZsWHJHZFJ0?=
 =?utf-8?B?aTIxVDZ4MFF2WUNSOXA5TmhJdE5vV1hINlFHU01VcTczaSs0RFkyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hjJ2tCafH/MOtwNab6WL09KrluhvL60EJnivVboO1qoNkYH2RVdyU/sqX43W/eW50dkBo7ZfxYlZyTVxMDQ7YF8p/SG4Vikjqw2skbk1HNZAS9ltYV05tce8GlQEpBegWmLTP2inuuvvztRqX9i0jePuRSe46h52alhjK7/dRDr6cyYJuVfPVMKQ3YFMo2M2hel+iPF1lf6eT9SUc3Jdqsj2EGCE9bxReBGzREvW4QSPhFMCn7gp7BSl+mM7p0O55mVbWKmXElfgta22RY5YPHU7kRRN4LBwv9vCVNnKf/injp1BszgpAnV3z5Sth3Wv0n4121B4Ju9mbcH2F25PUg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d327c09c-52f6-4c0f-4bda-08de9a10a2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 10:28:57.6967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5XxN5z+wYwCfln9FK0x1thGVHuzofKE7ukvF0moX2LJkRkffODsVFnUuhPm4klsdh5Rfw1aiHIDB94BGy4iLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5693
X-Proofpoint-GUID: jEjfU5oR_Ig0z91osXvHBH-ymYjp_HPn
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=69de16ec cx=c_pps
 a=mOf1MaddDbw/YSD//5QIpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=IpJZQVW2AAAA:8 a=KN-9bBXHH0KNpXBVv4EA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5NyBTYWx0ZWRfXwaqzdHuHHJlw
 O7BrC+YvkSfGGi7qlF8JMEczfdVqtVTBo9K0BV3MhEcqtKdrx/kR7pWn2aThSs2U0Ksu2NCXr4d
 bToBbwIQ5ld3OKI1pU6njb9c4d0naLz949EIihiorORZr0sKjJxEa54NW7uR7XSI1s2nEKM3VWa
 fMhoyGLCZSXMiF+wmkvUf0OckXnuvlPGEP4Sq3kUjI3QIPiki8xlGIuus+cfdLQNSTJK+eBpyz7
 CY/Tc/msUJP9m2Ph2HmtVbXbUqH2dfM7TDFUTN1+2yoBFO3cgDJvKOBUiGGziF+IIl41zcQn01R
 nXE30J5RXzZnnut2PF9J6LaYwGHUBANZb7H3nawkB9gYJLr+wy4ZDNwDoZ+eQyKfH+ZswbfC9ww
 cAvosS2gD7gaqirjREYLx0kJagSfpvU4uq1tUTvnAm74Pbg0DsPhbsAqRoENzsytkeMU/RBDDt9
 WBjU29tUktZiK+9eGdw==
X-Proofpoint-ORIG-GUID: jEjfU5oR_Ig0z91osXvHBH-ymYjp_HPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140097
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8576-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,baylibre.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62F7F3F8DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxMSwgMjAyNiAxMjow
MSBBTQ0KDQouLi4NCg0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWQ0NjkxX2NoaXBf
aW5mbyBhZDQ2OTRfY2hpcF9pbmZvID0gew0KPiA+ICAJLm5hbWUgPSAiYWQ0Njk0IiwNCj4gPiAg
CS5tYXhfcmF0ZSA9IDEgKiBIWl9QRVJfTUhaLA0KPiA+ICAJLnN3X2luZm8gPSAmYWQ0NjkzX3N3
X2luZm8sDQo+ID4gKwkub2ZmbG9hZF9pbmZvID0gJmFkNDY5M19vZmZsb2FkX2luZm8sDQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYWQ0NjkxX29mZmxvYWRfc3RhdGUgew0KPiA+ICsJc3Ry
dWN0IHNwaV9vZmZsb2FkICpzcGk7DQo+IA0KPiBJIHdvdWxkIGNhbGwgdGhpcyAib2ZmbG9hZCIg
b3IgImluc3RhbmNlIi4gInNwaSIgaXMgdXNhbGx5IHRoZSBTUEkNCj4gZGV2aWNlIGhhbmRsZS4N
Cg0KSSB0aG91Z2h0IGFib3V0IHRoaXMgdG9vLCB3aWxsIGltcGxlbWVudCBpdCBhcyBvZmZsb2Fk
IHRoZW4uDQoNCj4gDQo+ID4gKwlzdHJ1Y3Qgc3BpX29mZmxvYWRfdHJpZ2dlciAqdHJpZ2dlcjsN
Cj4gPiArCXU2NCB0cmlnZ2VyX2h6Ow0KPiA+ICsJdTggdHhfY21kWzE3XVsyXTsNCj4gPiArCXU4
IHR4X3Jlc2V0WzRdOw0KPiA+ICB9Ow0KPiA+DQo+IA0KPiAuLi4NCj4gDQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IGFkNDY5MV9jbnZfYnVyc3Rfb2ZmbG9hZF9idWZmZXJfcHJlZGlzYWJsZShzdHJ1
Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWQ0NjkxX3N0
YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKwlzdHJ1Y3QgYWQ0NjkxX29mZmxv
YWRfc3RhdGUgKm9mZmxvYWQgPSBzdC0+b2ZmbG9hZDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0K
PiA+ICsJc3BpX29mZmxvYWRfdHJpZ2dlcl9kaXNhYmxlKG9mZmxvYWQtPnNwaSwgb2ZmbG9hZC0+
dHJpZ2dlcik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gYWQ0NjkxX3NhbXBsaW5nX2VuYWJsZShzdCwg
ZmFsc2UpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAr
CXJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfU1REX1NFUV9DT05GSUcsDQo+
ID4gKwkJCSAgIEFENDY5MV9TRVFfQUxMX0NIQU5ORUxTX09GRik7DQo+IA0KPiBXaHkgdGhpcyBl
eHRyYSBzdGVwPyBXZSBkb24ndCBoYXZlIGl0IHdoZW4gdW53aW5kaW5nIGluIHRoZQ0KPiBlcnJv
ciBwYXRoIG9mIHRoZSBwb3N0ZW5hYmxlIGZ1bmN0aW9uLg0KDQpUaGlzIGlzIGEgbWlzdGFrZSBm
cm9tIG15IGVuZC4gUGVyaGFwcyB0aGlzIGNvdWxkIGJlIHJlbW92ZWQgc2luY2UNCnRoZSBzZXF1
ZW5jZXIgaXMgb3Zlci13cml0dGVuIHVwb24gbmV3IGJ1ZmZlcnMvcmF3IHJlYWRpbmdzIGFueXdh
eS4NCg0KPiANCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
KwlzcGlfdW5vcHRpbWl6ZV9tZXNzYWdlKCZzdC0+c2Nhbl9tc2cpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBhZDQ2OTFfZXhpdF9jb252ZXJzaW9uX21vZGUoc3QpOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzDQo+IGFkNDY5MV9jbnZf
YnVyc3Rfb2ZmbG9hZF9idWZmZXJfc2V0dXBfb3BzID0gew0KPiA+ICsJLnBvc3RlbmFibGUgPSAm
YWQ0NjkxX2Nudl9idXJzdF9vZmZsb2FkX2J1ZmZlcl9wb3N0ZW5hYmxlLA0KPiA+ICsJLnByZWRp
c2FibGUgPSAmYWQ0NjkxX2Nudl9idXJzdF9vZmZsb2FkX2J1ZmZlcl9wcmVkaXNhYmxlLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIHNzaXplX3Qgc2FtcGxpbmdfZnJlcXVlbmN5X3Nob3co
c3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAJCQkJICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KPiA+ICAJCQkJICAgICAgIGNoYXIgKmJ1ZikNCg==

