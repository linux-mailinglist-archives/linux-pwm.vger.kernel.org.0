Return-Path: <linux-pwm+bounces-3700-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B89A36CF
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 09:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB549B251D9
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511518A6BC;
	Fri, 18 Oct 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wCjRJAUL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8E16F8EF;
	Fri, 18 Oct 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235655; cv=fail; b=MaVvj8yylnHsqSft2emoFjIia4p/k6LRAG0qYNNOUzXbHE0IQQ+OoOFbwUIA/If0GvwSaMCBwdS6RSHDBcs9/w0Tn3AmbRvmqPHfrivNULe/NV4Cw0WZ6QFE0Q/VxEZ7DbKxs/KjrbGaYGe+6UOOoMH0mnUDDlUAILkzo5qKces=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235655; c=relaxed/simple;
	bh=WRpfXfRbQZ1Gyn9mRorPKk6+DsYJHyJ01JUccAt8y/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3PcLnsJTNlkJiRh+GrStndT+caO/dp/7Cbxf1WYAadM9lKd0/eX9dwRZcMqc9Pc7klsp3fXN6XDm25v1eD7a7HLHcZmi0y3dkuawTu9cgn3SaVvZZkkNhc/nmeeepFGjTeng/daYWWY2hp8OVr2cnZ+1m6kEVTuluamYJ2u5A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wCjRJAUL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I3jeVo004498;
	Fri, 18 Oct 2024 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WRpfX
	fRbQZ1Gyn9mRorPKk6+DsYJHyJ01JUccAt8y/s=; b=wCjRJAULcJQPtxyNLGA3U
	AylrIavfw7J1suxXco/cp7m2KefT7+N0twzljMzv5bR4dPAVMJOAyt7k2CI1Wqy/
	EkE9tUeRg7mcD9miGQ5ppBuwNe9X3yBiAfbKKi1w+ObAjernp0TONBNEIBSHF/fv
	1EcX0KACvzzMjRBZogRfXhnTESkA0fXOeZX0E2O1ywGvdovr8T4s92Ig+UB3Tk+F
	H3lAuMyLxXC1+CS4PYrYiIMrXsy8OBH0BVhSeGHplnIflmSxYmZSLmcoOfTRcP03
	eaDAKZugJMLq/s/Dv0Pe7beaaR7nBoIR9UM4Oqt0bkqy2rO80ei3xESIafjChNmy
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42ax1rntdr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 03:13:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baptMmzQj0l3u4YEkXYTTOx25bANe4lLAAblQVZX6TG/tFYPmjE1/xfziXFSZGvoPzeX41QmpeMLmZp5/lWjQIckWLOXQSoz5rmt33QAUNqVUm4jz6oWbZFszPvsOhbDVky9Qw4WHClx3qjpzO8jsib+FJERT9E+CTpfJ4YUTWzzAkCAza5uMgPefhzpnnrEvkr87FEkdAGQf0PmCTj4HCQ9ULCDSw23PEciYZGsA7xxYICwFAA1/SHrDGQvIrBx9Bp2LoBCg6yWtt8qEsbXEP+vEVQcSTDenBuyU7EbAabJPtZ707hquqAIGj8PZORQt0JnPvJwc6fRZ2DWoFOaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRpfXfRbQZ1Gyn9mRorPKk6+DsYJHyJ01JUccAt8y/s=;
 b=L2khR6DiDn3N19t5XzqSFoDS3pCKFrLuJj0fH+ev5JaB4xeuNPITLhcGCM2enrUl/AolBSIB5wv8CW5q1xmdk2I7hqu+Mih3V4J25juSr1UIMjG5h2+XcgpPJnEKICGNDnRJIix0DqUYbWYNCvhtdtBQSTxd1Z9532L+lFa0YBgiTRa/Ku8kAEvo1L7fpY+7O1XxdUn0Xw/+uF+4MUpAUXEaYlZzjZ96xB4O1J+BOtC68R16efTzi4hKXcSSLt3270ve91ABMuJGZcqNSm9eYVTySav6F8PcynUwK2FvMU6LqruiyaWmipyW9o8yVZ314rZBMgimf4iwW9nrfzwocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5160.namprd03.prod.outlook.com (2603:10b6:610:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 07:13:57 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::1153:bbaa:df9a:188a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::1153:bbaa:df9a:188a%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 07:13:56 +0000
From: "Sa, Nuno" <Nuno.Sa@analog.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
CC: "ukleinek@kernel.org" <ukleinek@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Trevor Gamblin <tgamblin@baylibre.com>
Subject: RE: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
Thread-Topic: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
Thread-Index: AQHbILyvFtmLNWl5Nk6rkVwGF/40eLKMGOeg
Date: Fri, 18 Oct 2024 07:13:56 +0000
Message-ID:
 <SJ0PR03MB54693B55BDAB3E2D7EF5E72199402@SJ0PR03MB5469.namprd03.prod.outlook.com>
References: <20241017174744.902454-1-tgamblin@baylibre.com>
In-Reply-To: <20241017174744.902454-1-tgamblin@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzV6WVZ4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRnM09HUmlNbVkwTFRoa01qQXRNVEZsWmkxaU9ETTBMV0pq?=
 =?utf-8?B?WmpFM01XTTBOVGc0TWx4aGJXVXRkR1Z6ZEZ3NE56aGtZakptTmkwNFpESXdM?=
 =?utf-8?B?VEV4WldZdFlqZ3pOQzFpWTJZeE56RmpORFU0T0RKaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJakkxTmpZaUlIUTlJakV6TXpjek56QTVNak16T1RjeE9URTFOeUlnYUQw?=
 =?utf-8?B?aVNHZzBTMEpNTlc4eWVsVktaakZ2T0d4dVVHVTJSRWx0VW5sVlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSR2RFUVVGRU1USjZUa3RNVTBoaVFWUkVNMUZWT1ZoS2Iy?=
 =?utf-8?B?TlhUVkJrUWxReFkyMW9lRmxFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCVTJkSlFVRlBORUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRm1jSGxqVjJkQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlEwRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRkJR?=
 =?utf-8?B?VUY2WjBGQlFVRk5RVUZCUWs5QlFVRkJRVUZCUVVGSFJVRmFRVUp3UVVZNFFX?=
 =?utf-8?Q?N3QmxB?=
x-dg-rorf: true
x-dg-refone:
 R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0JtQUdFQWJBQnpBR1VBWHdCbUFHOEFjd0JwQUhRQWFRQjJBR1VBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJQUFBQT0iLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5160:EE_
x-ms-office365-filtering-correlation-id: 9faa9bc4-682d-4e91-f910-08dcef446e5f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUtWR0ZqNFFkYnNNODBJUEs1UlpGWDRQWEFDbHI3eWhONnVBWG1TZ0Z3anB3?=
 =?utf-8?B?TmxIOXl5ZTEwc3crdkRSV09oRHFHQVRKbWxXai9qMDFHTWp6T1NKRldnU2FD?=
 =?utf-8?B?MkU3V3lyT2dzeFY2YktGUThWWmxIWFp6b25BVjJMR0pNckR1UW5lQSsweUZJ?=
 =?utf-8?B?UXFWTUxwaHgwcmlyVDZyMnZjUzFxM2tzeUEvNFI0ZjBLUmh4WGxFVk9rYWhi?=
 =?utf-8?B?WCt2SHBuMkFCZUZMVWRBTHIrTy9SdVhZb0F0Nm1VdS8vWk13dGR4bGtOY1FQ?=
 =?utf-8?B?RGwrVTNLd2U1MU9sRVp6eUpWcEZNOWNvbHdwa254S1hMWWpWY1o3amQ0bHhl?=
 =?utf-8?B?UkNqcW52MDNqK0hlQ21MVUg5cVJtdWh3RElzOXRpY2piNGo1MGkraTc0Yzhp?=
 =?utf-8?B?ZDEzMmNiaVZpSzNsVnB5VDhyU0xDRE5ITlVKYk80QlM0WXFxK0xOVFlncFVY?=
 =?utf-8?B?SWUvUmhyejhHMXBST0NzUnErY081TlIvWjMxM0ZIMS9ENXdSOXFrQTZwMWhl?=
 =?utf-8?B?ZG4vQW5XTk14dFZISUhYZE1KdE8vcXBnaWRLZ2ZSNnlJTnd0R2NXdVRNVlcw?=
 =?utf-8?B?cGtGR2pUeElpUU93L2pXZnIwRitqYjlpZDZYOXEyT2c3WVNQRHliUlFQQzda?=
 =?utf-8?B?UjltRUlBZkd1QXoybi9pZkRjZjVYVWtzVDBoOG5odjNPYlMydFpFUVpxMyt4?=
 =?utf-8?B?WXZlSG1QVkd2UVo5Q2UvakU4VzNnM3hMOWJPNVp1eElHZFIxa1lrY1Zvdmpv?=
 =?utf-8?B?VXdabzZCRk9TZm85bnBXWGY0d3F3OXY0QUZVNFNWT1hkNU9JZ0dRUlkxOFY1?=
 =?utf-8?B?S29Lc2ZwUnhrcTlTMnZ0NVhrbDVVN1VFdE1RdFlKUU41c09mQ1FnbTRKbmJW?=
 =?utf-8?B?b3UwWTVkWGhTVXNpUXdxK2FibVY5NTJOdFE5dmtWcXpnSzIrM1NHK1N5ZEJB?=
 =?utf-8?B?SU1oU3kvZjJXR3ZZNW92NmlweWk2dTd2dHNaM1h2Q1hJTE95aEY0SmduVmFQ?=
 =?utf-8?B?YkdGcGpwTVoyMkhBcURCc3JoSmRKYVRGQXlqRzRCdi9XbkVjWWZlMGh3WmUz?=
 =?utf-8?B?a1B5Z3IyaHZoRVI3T3c3RDFJNSthcS9RcVh2WGlMTHAybjlYVGhkVDlMa0Nx?=
 =?utf-8?B?ZkpTbEY1eWNTM3ljYXJ2YStKNmJLejFvOWJUeVFOUmNkWTJGN05NWjFHYTNO?=
 =?utf-8?B?TCtyU2pSSU4vRGpYdnVYWTI4djE0Lyt6elpuU1JlMW8rRGM2eVRjWHdIZGhq?=
 =?utf-8?B?UFFLdDhaUEFoN3FoR2ltQTRCL0ZOYjJCdTZPb04zUnlYb3NlMkJLVEhPUXpk?=
 =?utf-8?B?cTBUeXdVU1dqNDJEQ3lUMmEzODlaVXBSY3Blejl6OWk2KzRFTEdmVXI0anRO?=
 =?utf-8?B?a25MU0VIWFJWMHRVeHJtZkxLaTBGZ1B0d25IbWNidE1iWjNFVHEvOTdEQmxD?=
 =?utf-8?B?OUx2MmE0MzFFcDhxRklKU1BDcldEeXZianpyaVZiemdCR3BMTXJvOWkvb3N5?=
 =?utf-8?B?Slczd2p6NHVFekU5UkxPWkZ0Ny9GOWRqYzVqZS93TzJpeGxEYUw2MHhRSkFu?=
 =?utf-8?B?SVpvcEhqaGJ6QU1RMUN5cFBna21OMWl0MGhxcC83NVM0cnhOUmZqZmtUd3h4?=
 =?utf-8?B?Vm9keDlFbEdMUlM2ZGFxbWdQNVoxMkNxUldyYUhIRytiNGsybHhCQkp5OGVn?=
 =?utf-8?B?NTIzOFdkaGN1WEtvd202UTgyalJTcGZtbjJ1eHZsTm9MN3d6UWh0djU4cjdW?=
 =?utf-8?B?M1gxTlY0RWZyaG5JWEpCZXpUQUxvWmxIaHUxRVVXSzZpUzRsOG90d1ByaDVW?=
 =?utf-8?B?dWFSRFZuTjZrbzY1YlBmZEs5YUNaaGZhdmg1d3IvbzFPNUJCVEtQVVkrQUVO?=
 =?utf-8?Q?O1+PxIrawfalI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzJ3WnZvUFpzb3puWlVaQSt1a05qY1NZK2RzeTl5RjRsSmxtdGl5UHAvYzM4?=
 =?utf-8?B?Z3c5S2hmZ1JBVEFBN05CVkhOU3A3WUpBdFlEVkdpVS8vN1lIb0dsbnZFS0JI?=
 =?utf-8?B?eFM5LzRtazRWR2MxNnovVDIyVlNlZEhkeE8wdHgxOUJpTE8weXhpa1hiT0NI?=
 =?utf-8?B?K0tYK3lUa1o3dUtlOHdQSTUyMlcwcjhTYXo3ckliRS82aWJYOHRmd1Jsb0kz?=
 =?utf-8?B?VE1iVjBTYmYyaUNkMlZlbVhIK1loL2RqYW9GTUZBUjFyR05uWTBTL0RVMjVh?=
 =?utf-8?B?MzA4L1RjTWNVZnFpRXFwaEtxYTZBemhhM0hHZlgxNmR2K0Y1blRlSzgzZ0VB?=
 =?utf-8?B?UUVhQnBiTVNSS1YraVNZaTM0Y2VYRkJVNVdHOEkzRjBYMUxSTzFXVmxDaDdX?=
 =?utf-8?B?WW83MzZBTTZnSUt6UzRqSW9BRnZsTEsxWC9iMFFuMVRVQVVZNTkrMGdMYzFR?=
 =?utf-8?B?bzdzelA5RGg0NExLODlTUElkOVBvT0dFQUVBSXdDM0tZazluZXUzQXV1eWFa?=
 =?utf-8?B?T2d3UWJ6MkJVQmFnRllHaiszSUJ4Qk9XaXRvazdCSEZMS0dOc3dxRitxdEhs?=
 =?utf-8?B?dXQyWDFEYTEwckJrNjdnSDdRaGhRcjdMSHU2TXE5bDFCZk82SmdOYlNsWTla?=
 =?utf-8?B?Z3pLcmRRbEpIbU8yei9kQWEvMUkyS1NCZG4xRWF5Qll3NVFnc1VsdG9MSURn?=
 =?utf-8?B?ZGJqWXI0eU9RNmJ3K3BYemhSL2gzVENleFJEM1FNeE1rVHY0OTVTdmpjZ05O?=
 =?utf-8?B?ZDBiN2FnazBsbDdIOUYxQjVlT29WaEo3Y0NkQ2dwTjllMjNBYTdoZ2ViN2N0?=
 =?utf-8?B?elUyWXg0MTJNRTIzUFdocFAzSE9Ec0RScjZTRlZBdFQ4Ny9VM2t2RzFnbFpM?=
 =?utf-8?B?REFxTW82UlM2U1pCdGtTeEI3NXpMbm84d242bFNRNWFLd0Z5UE55Tm5sUEwv?=
 =?utf-8?B?UUxZMnMvYjA2eW5wU3NNdFdxMjQ2aVppamJocDE2WEMxUVQ3ZGlDSk9ML2M3?=
 =?utf-8?B?ckNTS0c0T0Vqa1VZbHV6TEc5M1cwd1h6Zy9CS0hQUGpya3RTR0M4RTF6Yjhv?=
 =?utf-8?B?OFU5SllvQmFlYmh1alZYTmlUbmdsMGt6cDBBT0tIYTZkVEkvZEpwNTA5WTIv?=
 =?utf-8?B?UzVUN001RVcxdjJLWHVhQm5OcFAvaXgvQjZVNXRzNWtWL3JUVkdTMWdHUFJY?=
 =?utf-8?B?OFQyeUhJVGJOVVhZbHdQOFhJYmZLdjFuTmI1ODhSQ3k1VmY0NklvNFZDbzNn?=
 =?utf-8?B?ZlU1cysrSXZyS3ZuNElVWUNKZmpPZUdERDE1SnRIbUs0bjNrcTE3UjJHT0dq?=
 =?utf-8?B?RjZQVldWYWpDNWZEdFd5OTNhV1hyVUpQWHZMVk1rS3dOMVQ0SzBCSCtRZUNX?=
 =?utf-8?B?dy9lWXd5TzdBcGtKTUtUZGNsM2drUlk4bS85OFhIREYzbmF4VEJSTUZnRitV?=
 =?utf-8?B?elA2ekFwNHZpQjRlTXZ2MWxCajZhc1VmOWRNWS9jdXJ0eXpIUHRZTEtFdHhu?=
 =?utf-8?B?eVJYS3pWdlhvdFNUVU1JTFVlUmtFM2sxS3J2TVpTWmZnaFdncFVNVitSQmZM?=
 =?utf-8?B?R2NWWUlYZWFBcWtHUHJ5ejN0cTl4OEhwL2d0ck15RkRscEN2Z0drWlNiLzJp?=
 =?utf-8?B?UEpmcmlxdHYzcXJkZGc3OVVnSXk4anpMVktaV2JsMllndmU3QVk0QnNHQVBF?=
 =?utf-8?B?S3FZN3lUNERtOTRWY3FCVWVOLzBVSU1xL3FiVXZubDM5aXdYbVZzc1cyNFpZ?=
 =?utf-8?B?TTQ3ZDFEVTd1MGRjaUs3UnNub2pSYjMySkRpcVR3cmEwOWNKYVdlTTg4bTky?=
 =?utf-8?B?SUM5Q0kzZEU2K2tPZ0JQUkhxbmcrT0pKc2grRnMwK25nZ0dMT0cxb282anZS?=
 =?utf-8?B?bTFGQW5Wb2xQNGdPVjZCN1NwcFF6ajRIczVhRVdRTW4yYi9CSUVnWjc2OXFI?=
 =?utf-8?B?WGp6clJiNWxHczIwaG84WUZsTlF4aXo4Zmw4RENPaXVOWHZ5dDc4U3NsUlho?=
 =?utf-8?B?MWh4MVp4VGQvWkpmc1MxNk1PbjlOZU1pUUFBQlhwOE0wTzl5b0cwL3U4c2NS?=
 =?utf-8?B?ZytQR2Fram03UUZhSEd1NUJhN1NPV1ZCelRwR0tkTDJ2bmtXSUxWYXM5UzNp?=
 =?utf-8?Q?ZsQQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faa9bc4-682d-4e91-f910-08dcef446e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 07:13:56.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kAPE6ht0hz7tW7NjsBWZcQ43Dg7bpWWi9sOWbCSW34HOL/qmBDzxI64z12VrU5UhfdUEoKfW+jsCObmQ8Yqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-GUID: 3HCfxgmE7z2X-Yaj8x4I4WS4_kDlSk3l
X-Proofpoint-ORIG-GUID: 3HCfxgmE7z2X-Yaj8x4I4WS4_kDlSk3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180044

DQo+IEZyb206IFRyZXZvciBHYW1ibGluIDx0Z2FtYmxpbkBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDE3LCAyMDI0IDc6NDggUE0NCj4gVG86IGxpbnV4LXB3bUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IHVrbGVpbmVrQGtlcm5lbC5vcmc7IEhlbm5lcmljaCwgTWljaGFl
bA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNhQGFu
YWxvZy5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgVHJldm9yIEdhbWJs
aW4gPHRnYW1ibGluQGJheWxpYnJlLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBNQUlOVEFJTkVS
UzogYWRkIHNlbGYgYXMgcmV2aWV3ZXIgZm9yIEFYSSBQV00NCj4gR0VORVJBVE9SDQo+IA0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBUaGUgaW5pdGlhbCBhdXRob3Igb2YgdGhlIGRyaXZlciBoYXMgbW92
ZWQgb24sIHNvIGFkZCB0aGUgZmluYWwNCj4gc3VibWl0dGVyIChteXNlbGYpIGFzIHJldmlld2Vy
IGZvciB0aGUgQVhJIFBXTSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgR2Ft
YmxpbiA8dGdhbWJsaW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IE51bm8g
U2EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KPiAgTUFJTlRBSU5FUlMgfCAxICsNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJT
IGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggYzI3ZjMxOTA3MzdmLi5hNTA2ZmE0ZjY4MjUgMTAwNjQ0
DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zNzU4LDYg
KzM3NTgsNyBAQCBGOglkcml2ZXJzL3NwaS9zcGktYXhpLXNwaS1lbmdpbmUuYw0KPiAgQVhJIFBX
TSBHRU5FUkFUT1INCj4gIE06CU1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBh
bmFsb2cuY29tPg0KPiAgTToJTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gK1I6CVRy
ZXZvciBHYW1ibGluIDx0Z2FtYmxpbkBiYXlsaWJyZS5jb20+DQo+ICBMOglsaW51eC1wd21Admdl
ci5rZXJuZWwub3JnDQo+ICBTOglTdXBwb3J0ZWQNCj4gIFc6CWh0dHBzOi8vZXouYW5hbG9nLmNv
bS9saW51eC1zb2Z0d2FyZS1kcml2ZXJzDQo+IC0tDQo+IDIuMzkuNQ0KDQo=

