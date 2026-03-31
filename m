Return-Path: <linux-pwm+bounces-8447-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAxTC6eIy2kuIwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8447-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 10:41:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAB3664E6
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301C9302F39A
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96F3E3166;
	Tue, 31 Mar 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YetbTD5o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51D3D647F;
	Tue, 31 Mar 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946240; cv=fail; b=sDOoU83LxzBd9lm2nlhTj1F3NV3V3Wsu1ARX6n+Mancomxd52L+kUaqDjNak/r4QXtkCNkPNKff3j1vXYM5TLj9HDd4rSzP7VyZOBwH4Zt2w34CuJ/0vMzCcsfbwYWpn91NBFOHLBgk2dI2AN/96zi1TxBOGQCC7/xR4ksu4+0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946240; c=relaxed/simple;
	bh=hVb81G0KmN08Cg3Uex4WSfydLP6BQVRznEbp4k3V378=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ+50SQ+kK/ncMsB0GW9NEO8vma9D1NHC+b1cb+zv+FFB9Qgsqm0qcM+ISh7oUsuGgIGUARNNmN1bp1Fh9wIyNmSIS6wM8JASqdI7zQnSaST2ncejA53XowS0UZgxiRDu/WKvVxWUp64lslmyA4JW/co/Bogpsd/cNQR4s195Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YetbTD5o; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6QY8i457147;
	Tue, 31 Mar 2026 04:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hVb81
	G0KmN08Cg3Uex4WSfydLP6BQVRznEbp4k3V378=; b=YetbTD5oCL8hMm+oHxmV7
	GiiQpIEGQIYp8WfSUKzkfuSEuja3VBOVuxZXUZaFnWE8CQq36wAb9aLxIsSt+hbV
	05bVSk26VlZFans+XrF5zePo3sakaqny1PCROp7aP7G1l4tcdoQWl9vO4FQ6gm8H
	Vv1vhSd6cG3Kh5uhxLAxgfn/EimB4DgkGS/eIHoDwBtY8GbsFlz0tL03B77nmc4j
	n3PjjbHo5bFhqzmTgkRDK51kwVqT+zvqCpvQTw6kcsNyC/mHShG6q8cO1Gpxixv7
	zVIqP1oMoHacjezYx9bOg0aAwB5Q/jCfTCdndYwNH7lTtJ1I+tElkbAgPsTPtxK6
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6ykhfj0g-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 04:36:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxFu8UdriXN3eSUecEdXuq9vBRw6mNJkNa4mmKh8TcyiowRKE/90e4mv+vESyx729YBHKxEgt0JrBNzkKPvfFvxRxnwkWNiRL/H4wfWh3dpuca94PnnJ9Z3jKzKGLkv/ceCLMRj27j79A1r1Z+SybPM8IWXxt0Evq4Uw/TEfFVd6HKPdGUMDikz3/LPHugy1LQGQ1IHig7szlgrJR/tdOJ9iAcqC0Ll3YR/Swpp2Yu2rI8jGgYALtYrWEtHVxL+vHF7w+/Cocgkk4OvYcpORVi/dUljHf77dUB96UbbYIXYvAtlETEMsri4wYBbIX9zkR9oTZZKzRJDJyRIr97opTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVb81G0KmN08Cg3Uex4WSfydLP6BQVRznEbp4k3V378=;
 b=sl9OostTudH2XeDSIxGWPiqO4TpmhjcWzVxoze8WHbJ+AVX+lczH0I1XomtZFWrW0mkMTIuu651pR9wIEaaMPXnLCUuZARl/pQ/0/qzLkZY1e07NiO9MW2mrHdKwNW7/lE2UcNT+aOnVKoycTv6NXcLBNeFRuVeAlBqOJqr0FH3GOJ8eb1KLQI0MpUJs1O2nOc62UMpPcEn2wg37ov80yVSNkjRMvT3EJ3FSckIHNk3aZs9gkf2cHzIfUNaPulXnf22JKiyg49zuva6681aPvj0MH6YXckubB23/3nlXyOa6k2O3Jc8HXuPSyz9OZ2+as07xwuQ6FNUKWeQKj9rurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS0PR03MB8343.namprd03.prod.outlook.com (2603:10b6:8:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:36:42 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:36:42 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcvdoCw4o9rbwX3EeiToji+73F0LXCQCsAgATiWGCAADXSgIAA/dIw
Date: Tue, 31 Mar 2026 08:36:42 +0000
Message-ID:
 <LV9PR03MB8414CB05EB794F6974584C2AF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local>
 <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
In-Reply-To:
 <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS0PR03MB8343:EE_
x-ms-office365-filtering-correlation-id: 7790088e-3e02-41df-525b-08de8f00a2c0
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 4PlCtNEASXjXhhgeDjKjdykuhkrOiLGHlsfTA2qNOt1JBDzoHuc9tAnM6MZJSh3u7Lan6mgocdcL/VSeP+QvlpMpgZKCq9CRGKJ1jUGWzArtleDO9f6Xfda85kqE4PwXfXm6cfkm/FR8GSvNg/7mrIKX0eUlx9iRUHuPd13WoPs3CRuGXjPPpOiwA71u0eD82g3+g8trTSgo1Ct9GS56PHXoxDvWoVnkZisKLmR2har76dgw0Tjj+OZdk/x4YYaUxvscsZvBFFEJM0KPdmuapDnnd/mU+GEbZKC15RbE2v8l0lUo/pCvVzM0suaUtM4NZRmXpUdg4Eb0ujBZhbqTsKMsODPtov7migWPvTln5MstsWPmFvBe3vwOurJzey6qx1q8CP7pSVkilEXJw+Mxaa4bRp0LhXySBj4P6nWYADuHfgTu9tQVw62+0mE5/yQskpL4OzdHq620NzokJaZvVI4bRXH2hXTl6lT2fjuhJWmmR5/5tN3VGs7vb3u+RArImrXB8DrwsD2/xBof9kRifoOVMceLERBWUO4TnjACkTzmgpOGy+Qc3iAdSQDLJ1alRPx/niBlXVk/vs/krvt13lDPTDb53BFrEks+qZ+g45cqppDxH8PspHRJ9ju4tfA0VVGwekzM59IlQ8POMK5McgKZEtY23MQfGdmzAoDGI+lMKNn+BvcGtc5PrhzvRBHLoE4/lKnAH9+2LGvssKDyYN81R8o5xw3hTBVO/xLjuWDJglzQXAlh8flO9nXK9wcpQQ9fWSDDShAJkMIhUNnyFM/qXnrTvVwThh34V+ppQe8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0N6TXM4M0VJTjh0eFNBM1M5bmdQZEY5QS9zamhNWVRTVUNwVEZkeVVmZ0ZK?=
 =?utf-8?B?QkVabEdrTlV2UndSaDJGVmRIWTQveHh0TGtEN00zeS9kQ3l4akdOUytEdWZ5?=
 =?utf-8?B?YW56TDlnRklWL0R4OW1FVWhzUVVkUERaeFY5c1E4b2tQUGUySXNENGpDZmt6?=
 =?utf-8?B?TWduSHorVHN2VGhFbG5UYUMxNHVDMyttZGtwRm9xS3pHVVdTeUtTMjNoU2Ry?=
 =?utf-8?B?aG5zRVNpS3plMG80U1kxWGdpZzZwWEYvUXNPaXNDU3BaWm8rS1ZnQUFLRGJT?=
 =?utf-8?B?SWErVFNmdmxoVFdGYXB5UThpYmYrMU9TV0MwVktnWVpGakV4TG16T3ZBamN6?=
 =?utf-8?B?OExndDNzYlMwSlJTZkNrYjVWREZUc1BsZXlhamRqbHUyWS9aZXFMcktISU1C?=
 =?utf-8?B?Ty9wazBPZERLcWpXUlF3QytmUGJTU0trYkFLK0JFakhwSkwrY0pVM2psTlg0?=
 =?utf-8?B?VEFQRnNncHlnRmhEQVlTMXJtdk5JVHpYN0xtOS9ORDZHWjdNNHpkR1Rzajh6?=
 =?utf-8?B?UjVMQXBKcUpzcnZXZUZ0M3owY3BLNjljVEx2akN1L1ptVTgrZGx1ZVk4Mi93?=
 =?utf-8?B?d1FLcGg2Tk5IbHhUK2Nha1BzQVNPZ25PZHp1a3cxTlc5c0RmQ3U0Q0loZDlI?=
 =?utf-8?B?WFpsS1JyM2w2MFF2ZnU2VTFiMmFDcXZhT3RUdkt5dmhYY2lrbEptNzB3a1c5?=
 =?utf-8?B?ZFhDMk04Ym1LeDZMQ0cxY3dkRWtHKzdTZmhVNTQ4STVFdHNIOHNaQ1JEOG9G?=
 =?utf-8?B?Z3BNdVFBbU01S3ZmYTN3QnZCUmFUaE1JRGZZcG1qaHE0QWl0bmdGK0phVzcr?=
 =?utf-8?B?OHJyMDJyZHVwU1d0ZThRYS9RTDZGV1dranQ2L0poajJmaC9Ib3FycFBRMGQ2?=
 =?utf-8?B?b2xVODhLQ3F4cEpKcXJEZGpVT0NXR3YyUDVrbWIvRllBQTNnYmNSc2N1aHVL?=
 =?utf-8?B?UE4vdis5aTl0ZlBKY1oyZnoyTVdyeUZFVUp5OFpBRkQwS0MwVXJjK2lOenhE?=
 =?utf-8?B?a2FGRm9HbHpTYmMraHlIem1pc3I5a240MnZmOENWNWNFV1FiQnErYkxnaURk?=
 =?utf-8?B?c3pXd3dQN3FpdTh1R0JiZm9VMEJyLzl5SGNZVXlzQzhMdVlqUGh6NVF5MWMw?=
 =?utf-8?B?TkJycy92b04zWTFWRVNyTHRjRmdhMTdsSWt6QW1oWXpoRDFMdDFHRUZRTHlh?=
 =?utf-8?B?OHFyNVpIbUVNMTBYem0rbmNlUXBLK2VERGdoZ1RZNE4wdjM2dUtuZ2pUeHh6?=
 =?utf-8?B?cWJLUFVqV1N5TjczMjRCY3RhZ3ViQWRaeWRaRHo0L3BuTCtUNDBTOVoxTFcv?=
 =?utf-8?B?M3dISGxlVHNyamlhUVkzWG5URGJLcUpvajVFM3B0cVRkczBBU1pXelpUYW1u?=
 =?utf-8?B?K2hUd2U3ZDRtL1ZUYm00bDV5YjJDMWtGcHE0cFAwaC82MkRBaC9HcTVIdm5y?=
 =?utf-8?B?bFF2Q0srTjVZclN4MnZHbnNSS3RBcDFEUXg3L0FNUVptd21saFgwTW9PV0ZC?=
 =?utf-8?B?Mkx0QU9LZy84RDNaWnlBdWpNeWFGSnZOZysvdmhoOExhTVlwQ2FlUG95dWxv?=
 =?utf-8?B?ZTlxcHFOaW9CV1BtQXFCbytvSE0zbGkxTG8wOGRIYlVrU1ViYWxYNDcvU2k2?=
 =?utf-8?B?NEFoeDUxd0FlRERNM1VkanJTeVNvaUhUNGtUL1dvaUZFL3IwTnFrbmFKL0lZ?=
 =?utf-8?B?NGJyakwrRnhGa2o0TUc4dUtjZlhJNHlnb0Y1K055bWRKdTZWTVNYdk5UT3c0?=
 =?utf-8?B?U0RXNFZBYkdQTWhJQ2cxWUZFQ2E4UTJJcVVCcDBCcURRRE9CeFU3SXNYZUZM?=
 =?utf-8?B?V2preGpHakttWVlMN0c0RGFDSVZwdUJ1eUhiVmozRi8rV0FsV054Znp0S1Bi?=
 =?utf-8?B?Nk5Kb0ZKYXJHYm1kTXFtZUc5SDBoWmlNbE40QXBVVHBGTWZnQXp6V21wc1Br?=
 =?utf-8?B?b2xENzEwenhVenpsRlNaTEJHOFM5Y3lOelVZL0o2M1ZGdSt0Ukx3MDkvMzdv?=
 =?utf-8?B?YTQwQ1RFL1UxK0RCbE11MFc0TEZPM3djdjdkTVNyVS9VL1hUTXNvNlpMc29U?=
 =?utf-8?B?Y3VpLzYxTHFydVduZFNBSldzNlFiYUZabWc4ZUR3eGp1T0ROWmpXYTZSdWdJ?=
 =?utf-8?B?d1VWQ3dBeXhjM0Ura3lPL01YR05jSlRFN2orVEdHaXNUa29Qdkh0Q0d6aWU1?=
 =?utf-8?B?bFhUWUo2cU5JZUwrUThSSWFjakMxU3RRTHpDVG5Za0xUbm1UWHphZTRMbjNZ?=
 =?utf-8?B?bkF1SGJjV2xaY2V0cHdKamhpZG5PeVVxWDNveldqSTNxMzh5cmUrUmdidTB2?=
 =?utf-8?B?UkUxcTlOODdRR0IrblNKUFFCRDZKTEUwTUFtbVIzN3NxY2MwZXpmbXUzeHl1?=
 =?utf-8?Q?mnCrgeVXq976Q1/rw1e56g+uekw4lCCUrHpU6j6kVHnns?=
x-ms-exchange-antispam-messagedata-1: zeMWXsyNNvsDMg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VoPXuYLvhguXgE33BOKay4Ik4tPRR+bhlKuJhkzoI5qV3femsViCaPV9w5Tn0aZAicDOVgHlb31LQuZ4EM8lzkI3EvGUbQ6MbVG0SJlJTzINSFwrf0rSA+mirPDx6cCDsnkZf4Jwk+qUiZBtqFKa2mRM29AXPDswFL30H1hRTjaq+39bkU+cbxq4SXb0wzDEQmdlyticjRdVDn79xhPUfRtd7GTI9NLhMT2oGgmajpd/dtLdT514zIE7xcQavUZpmtv0TIgc43w/RdJg2fqpUKsF0jdfulOcinCC+U6jjlmlP/R3VMhGI5u62kccz0F5vzVPLH9BCvwNJ/PbG4gd7g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7790088e-3e02-41df-525b-08de8f00a2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 08:36:42.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ab3NUuRAt3CCYKazL0F5RAu+pxCjjkqLqIggraUeUUx5hLmM0Ucx41+cKLZ9nl9gVrLF1LSumOZ1wicGRQiqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8343
X-Authority-Analysis: v=2.4 cv=TprrRTXh c=1 sm=1 tr=0 ts=69cb879d cx=c_pps
 a=wVrytDogCwW2gNy9sPioUw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=THCq7PolAw0WD36Mbg0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ev8u3QMMg3hxlTj9WxfDBFDPpxLABrgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4MSBTYWx0ZWRfXy1MRZ8n4bZac
 asrUgCipixE0OtogqqCbNV58nldeKhgLG2bNvVMM5dZCIxJK+4L73rTj5H/3R5kZ9h9yeAOocvq
 5UV7LS/pxXg+6hPS0iv/YVlH3CbNTu16Nt9T6Q75XtHEUnvskNyy8Gvwc0DVxZqsWsqX9FT55f0
 iFa9HmJCZSzY1RQjb/xwH5v1sNraU133UEK1XPVSYcLqlYnsayVerXwpqMpPLULfIqeYlFrce8r
 +N2AOg2mDoU0sKriYaREjOuWJ7zLUBln5IsFvIdvolPGcSqFu8rPYBePm5L0XLHiP9n/XS/tyqY
 Lt39bJvEiiudlmWt/gGHBZZjSsqjcWiuVlC/wWxpxKg/xh5fU7xn/Y49ZTx3H9Ut4ateJwXghry
 fct2BQlABMQmMwLRLtwiadHrU3Jasg3ciVZx/qVIC2M+JWY5qwcVwybTjSDy7ostqAOD3menTiH
 JFQb/ma6rVrILBwQwig==
X-Proofpoint-GUID: ev8u3QMMg3hxlTj9WxfDBFDPpxLABrgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310081
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-8447-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C8AAB3664E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDMwLCAy
MDI2IDg6MjQgUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cu
Y29tPg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+
DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8
bGludXgvY2xlYW51cC5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4g
PiA+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4gPg0KPiA+ID4gSG1tLi4uIElzIGl0
IHVzZWQ/IE9yIHBlcmhhcHMgeW91IG5lZWQgb25seQ0KPiA+ID4gZGV2X3ByaW50ay5oDQo+ID4g
PiBkZXZpY2UvZGV2cmVzLmgNCj4gPiA+ID8NCj4gDQo+ID4gSSBoYXZlIGNoZWNrZWQgdGhpcyBv
dXQgYW5kIGl0IHNlZW1zIGRldmljZS5oIGRvZXNuJ3QgYWN0dWFsbHkgbmVlZA0KPiA+IHRvIGJl
IGluY2x1ZGVkIGFueXdheSBzaW5jZSBzcGkuaCBkaXJlY3RseSBpbmNsdWRlcyBkZXZpY2UuaCwg
YW5kIHNpbmNlDQo+ID4gdGhpcyBpcyBhIFNQSSBkcml2ZXIgdGhhdCdzIG5ldmVyIGdvaW5nIGF3
YXksIGl0J3MgY292ZXJlZC4gV2lsbCBkcm9wIGl0IQ0KPiANCj4gTm8sIHRoaXMgaXMgdGhlIHdy
b25nIGp1c3RpZmljYXRpb24uIElXWVUgcHJpbmNpcGxlIGlzIGFib3V0IGV4YWN0DQo+IG1hdGNo
IGJldHdlZW4gd2hhdCBpcyB1c2VkIGFuZCBpbmNsdWRlZCBpbiBhIGZpbGUgKG1vZHVsZSkuIHNw
aS5oIGlzDQo+IG5vdCBkZXZfKigpIHByb3ZpZGVyIGFuZCBtYXkgbm90IGJlIGNvbnNpZGVyZWQg
Zm9yIHRoYXQuDQo+IA0KDQpZb3UgYXJlIHJpZ2h0LCBteSBqdXN0aWZpY2F0aW9uIHdhcyBpbmNv
cnJlY3QuIFVuZGVyIElXWVUsIHJlbHlpbmcgb24NCnNwaS5oJ3MgdHJhbnNpdGl2ZSBwdWxsIG9m
IGRldmljZS5oIGlzIG5vdCB2YWxpZC4gSG93ZXZlciwgSSB0aGluayBkZXZpY2UuaA0KaXMgc3Rp
bGwgbmVlZGVkIGluIHRoaXMgY2FzZSBzaW5jZSBzdHJ1Y3QgZGV2aWNlIGlzIHVzZWQgZGlyZWN0
bHkgaW4gdGhlIGNvZGUNCmJvdGggYXMgbG9jYWwgdmFyaWFibGVzIGFuZCBpbiB0aGUgcmVnbWFw
IGNhbGxiYWNrcy4gQWxzbyBkZXZfZXJyX3Byb2JlKCkNCmlzIGNhbGxlZCBkaXJlY3RseSBhbmQg
bGl2ZXMgaW4gZGV2aWNlLmguDQoNCldoYXQncyB5b3VyIHRha2Ugb24gdGhpcz8NCg0KQmVzdCBS
ZWdhcmRzLA0KUmFkdQ0K

