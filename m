Return-Path: <linux-pwm+bounces-4591-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB0A0B545
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBD23A6FEB
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956E22F155;
	Mon, 13 Jan 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f59ISNwY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAF14A09C;
	Mon, 13 Jan 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767097; cv=fail; b=JkAARI1bum6wxDb67mcnndUiuIv3SxRX+gxSy8IWQ0WP94JcEYDr0mRRy7TdbANotpE0ZU0+0OIdkFCbT4O8wZjbktP9A6gLddlcNwNc943NHXtfbi/viLWTfrPTIg8SASjcpEch/dmoxoE2iEzdkYK+U35BfwNsaU4SrlRKyPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767097; c=relaxed/simple;
	bh=RG9VL/abcVHkCdNh5dN5nDypSsVTlMhZJJLfYUhrzv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jELVCjk7Ir+MyR7UqhYDkQb2ylDAX7iDLtH2khhT5hztjZgUG7BnR4ZopfhA/9f9YtU+rx/qHr0HplNId9z2s30VGt5+ORz9Lmr4kNXjIkn6GQJqFlLXWIp1fywpnu+t4UjMyDFgosm4q+Iiorbx3bkQx6rqh58lQFZii6ebVaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f59ISNwY; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D7lMJx012859;
	Mon, 13 Jan 2025 05:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RG9VL
	/abcVHkCdNh5dN5nDypSsVTlMhZJJLfYUhrzv8=; b=f59ISNwYFENCbPUzyE8Bm
	0gGYB4+7kM6gI8OWDC6rHKVP/qxy7SefEm46vnROSijgtcp9Z7L1xmCKcLT//fa1
	QQsJnjEQ5j2rOPtYpaLLxCD9UbbbQw+P+cIpj4QZYZU0uoqQqeYMEUZM0Z+CeZje
	vD7k6XJlcdjxcyZJWDGCMvZJvzcAvoInP8Cpt2TLXDm2fXyTLU+X5N4ULZ0OfOzJ
	Zsh372dH3Ns8kUzQz7UGehSAr/hHhOl4GuZd2ffuRTQLi8kyrz/1GbK2kvtMjJdt
	k7nqItiH9IVxqrfqSGk/INo6b/Y4V4Pti0FPvwjPKZ9oA4IjTvCtjPs9DAZ7iTh7
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 444s4usmrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 05:08:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3PMg/zM4rtanA8/cDX6rz8do0pud5Oi0C/ihdd4ishn2zyh0Ruu7xKkGWzFKu90L9ImdhuABtWH3nqoqs8oa9SnDDhGh3pT+Dvv0Ha4AJJyKzyM9oL21+Yp1HqukyKqLlC2mZ40zbQ5O6wcchjOo+YaEyQLIgxik0nJ6t+LvBWJgf9P8SlWFHwfId+bRh9K5+2TdeLQwYHvcto4QPCdHFVKTSej98kiwEePBu7HAHSqVVL2XgKQqqwMs1NEhyc04bLlrhf7aXR84RdhGXITqhz/xuhOtTn1jPDMB/KRWM4K/FdgFW12tD4vUH8Cly4jTq1gAkUZbeuA+pHFcl70WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG9VL/abcVHkCdNh5dN5nDypSsVTlMhZJJLfYUhrzv8=;
 b=txysDtoLYRuqqx0wKVNOZrDkLNyMawz1+bBUFEyLe5Vv49er3s/APVF13iUDTnL+yC50tDmmb7VAY9kH7YnrhuhfvhMvrGWOrMDXzFMWG7SUisxp1bVSN03O4q0vyM6s0YmPyR4q6kZm0JPHolErEQ+l5wSljrGMTvE/Ii79zAlJYZSq3KpRleKdpe3iwqyXTTkKpaORkgpJd/uH7WxscKopaxXF/wpTGerxdebUujm2INvmRVnnzuhqQrPVwdXweLzATQPsdpu/rBdI9dyI7eBnHT5ctFasayC1CyxZUPKSGcw882l2Agx7OafZv09ACJSgOiotSf+reK1knvq7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA6PR03MB7735.namprd03.prod.outlook.com (2603:10b6:806:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 10:08:55 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 10:08:55 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Thread-Topic: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Thread-Index: AQHbYpudlLVpwmjmO0uuJhKC7L5nTLMUZ20AgAAV/ICAAAHm0A==
Date: Mon, 13 Jan 2025 10:08:54 +0000
Message-ID:
 <CY4PR03MB3399E6CE276DEA511132FC009B1F2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	 <20250109133707.3845-2-antoniu.miclaus@analog.com>
	 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
 <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
In-Reply-To: <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyTmpGaVlqTTROeTFrTVRrMkxURXhaV1l0WWpBeE1DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTmpZeFltSXpPRGt0WkRFNU5pMHhN?=
 =?utf-8?B?V1ZtTFdJd01UQXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOalUySWlCMFBTSXhNek00TVRJek5qVXpOekEwTVRZek5qVWlJR2c5SWtk?=
 =?utf-8?B?SlJVUlBMME5uU1hGVk1rTmljM013VUd4TFVVWmFTWFp6ZHowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkhSWVNGVnZiekpZWWtGWVdFZHhTMlJpV1doRE9X?=
 =?utf-8?B?UmpZVzl3TVhScFJVd3dSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA6PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: e1cbf9e7-ca40-43c3-15f1-08dd33ba49b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDR1R1BnNjg3NXFiRDF5NHdBL1pBQWtycldlVzlWYWxNMkx0Y1NXZWlsdGxU?=
 =?utf-8?B?K05yVzhRd3hpSldPMzlVVzZiY29Iam1Ga2UwVU05REtaR3NLMmt5cGNiV0hB?=
 =?utf-8?B?cnNVVDBVNDd3emxCUmxIdEltaWxMcTcwQlJCa0FrRGdjVVlXQ3lRczc2ZFVu?=
 =?utf-8?B?cWE5cWp0cEdnTDBnN0toUHdSNmgzaUx1SkVqdzl6dkVNNDJaOHB2MnFTTjdB?=
 =?utf-8?B?OE5jb3NoKzJCNUdiTWdVaWdCaE1yZndqWVF3REZsZkFicGJZSXhvNGxTUlRy?=
 =?utf-8?B?TjVpNVk2NkZiTzJwcEkrbWs2UzQySk8xTHNjSE9pYlJjdXJ1TWFkMFFXSm9h?=
 =?utf-8?B?MC9vM0ROeStmNkRUbWR2b295RmpwTzBjNkpiaFpxVEhualo4cG5FRUwvZXM4?=
 =?utf-8?B?KzRWRWxTYzNteUdNQm5qbmtZbXI3N1VEWEkwd1Y4RUE5dUh5eTdreFpySnJQ?=
 =?utf-8?B?WWJ4dFdMT0RscThUZC9meW9QSHVnT0Y5YjBYVE9qblEybk1sRzIwOWpjVDJt?=
 =?utf-8?B?T09yY28vWHJZbldVOVo4Z3Q5aEhIRzdpVGFBY1pZcmtwWVppSXpLWnMzeTZ4?=
 =?utf-8?B?MFRkQmw3QTJNL2dCNmhXK3pJaFhReWovbDNtb1ZoVFZxaVdOUHRBYVJGV2Zs?=
 =?utf-8?B?Ym0yakN6VlhBSGplVTZPd0plMW9MTjZDejlIdFoxUE1GTGRwVTgrenZlSHlz?=
 =?utf-8?B?M3dXeFBpYlZNMzdGRmFHRUNkSlZ0NWRoRkw4UUdsSWdoV1JKYkg2andMYi8w?=
 =?utf-8?B?YVdVSEVuaCtnQVZUQ3ZmajlIOHV2K3ViZDgvUDQ5eEkzUkVrYjQ4bVIxWEhu?=
 =?utf-8?B?WVQvekEyMW5hQXR2S1M4NzJqZ3NhMzJlNHVuSVJWSFlRbUpoQk9wWTNUaHB1?=
 =?utf-8?B?enVwTm1mTllQR2lRUk8rbmwwLzhPZCtPSytnVGtrbGZKaXpGM1dVUU1VemFE?=
 =?utf-8?B?RFlJbVZZUHh1VnpNV2krTWk5U0w1RFdkUVo4dkR4aVIzWGRqYVhYZDllbGtJ?=
 =?utf-8?B?elhHZExYSjBhVnA3R3loWGUzVEpjRGw0Vi9KZzlTZkVDem1zZUZHNE5ZT3pX?=
 =?utf-8?B?cEhFTDhOKzJENnhzT3hzWWR5VWVBajB3ZTgrWStQY3dBZHJMTzZxbXZscE5s?=
 =?utf-8?B?elJidDVSd0svQXprTXRhYUFwbUs1cnFmY0FsTFNFaDVZcFNPRlNrcGZRZkJM?=
 =?utf-8?B?Q0lxek5LYmI3TThWa2lWcmdFVkdRT0dmR0p0K3plSGNTVGJ6ZVVzYlNFK21Q?=
 =?utf-8?B?VWRoOVRiY2VvTjZ4eWdnMExTc0pPZEFHWW1TUG1FOUU5eGZRZFREaTNQTEg2?=
 =?utf-8?B?aWNvcUN0Ni9RNFVUeU5lZTFJa1pCSzVkb3BaRzB6SDhJYWpyeFJnMEFvMmRO?=
 =?utf-8?B?SlJRYUhHZ0ZXaUtRdkZ3M01rQnJKOTdQcHV2UFJNYVlIS3JRdFdEVUJDUElH?=
 =?utf-8?B?Qkx5QXN5K2xSSjVJa3RpaFNWYnFnaHMvWS92QTNXMW0xU0V2SXptODRmY2l2?=
 =?utf-8?B?ZEF4SStFcjQ1RHM3R0hZVDNwRlVRZ25jbTM4cEUvV0U0MXo1WElaMTUydkpl?=
 =?utf-8?B?UDZuUHBneXJuaVBna0xnajI3dkJ1RkhBTzVmL3RWRjZsdGlSTGdEdEFSWnpS?=
 =?utf-8?B?NFBvSlF5N1J5SlQ5UUJqQW8rU0ZyaG40b0pIRlNYV2ZMdzc5SHhQdWFLaHhP?=
 =?utf-8?B?amp4Rmx6cWk3RUlHRDNLWFU5bzFwUkdzTzRJbENiRHIvdFBYMXptb3U3WXJD?=
 =?utf-8?B?YkNxbExPK0NJSElhc2lpZWhGUFZnSktGb29GWWlUZ2VZTE5LbHVrYmM3cmNB?=
 =?utf-8?B?ajlBQmZMMzVQOStTOUc3Sm1LREVXNGl0WTRwNFRTelBxTkdBaWE5cnZ2cGxT?=
 =?utf-8?B?SmxnTEV2VlIydGVVVU93RTRqaXplbGFDektQVEpZREFQTU0yNDk4YlgyTVlN?=
 =?utf-8?Q?JrY3gzenJDtmfcbCtDIcusZY7OiR1ZDg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b05yTGZmczBtZ3prc3BnYTZkY3NKQ1RReEJ3cVhIekpYMHNuNWR1Z2p1b1B4?=
 =?utf-8?B?dWtjTXI3cHFPckpIVnBwWDRHQ0JCUy9yMmpMNlA5MTh5ZlcwcDBvRkJZcmtQ?=
 =?utf-8?B?MzZlalM4RkZrWE03djVjQU1LeWlHV25TZ2lFSFkvNXRyY0FOSU84QlNGV29V?=
 =?utf-8?B?KzcrMXIrVnNMWFJxS2R4UnNlQUdiU3VZVng1VnVnMGFhaFQ1aWl3cjhSWTJm?=
 =?utf-8?B?Z284MDUvQUZkODl3bGNiK1RMcUFhVTlzZExYNy92cjJQcFlpemJCQWJWTlhI?=
 =?utf-8?B?ZTdHM2Q5L0NMdnNjOWQrUGdCdUhmenNLZG1IQ2NEeHNyTGc0QUFQMGpkY3Ft?=
 =?utf-8?B?N0NhNC9qcHVvR3BUVmhZOElQYis3OFEzN2o0Rk5BMk9WS3dENjZ6NUZzeWg0?=
 =?utf-8?B?RU1yME1EWW95TUJNQXB2ZmhKK3BTVzR3VEJqUFZjOFc2V2daUGxiNWlvSEdt?=
 =?utf-8?B?aTAyM2JHK0dJTzR0K3lnL04wQUE4V3ZveHBtZUM3NC84WWVkZXdYOHd6ekFv?=
 =?utf-8?B?Sk9BWTJIYlNva2k0MHZmNkgvajdXTE00RFlEY1NaenVwakdXb040WVh0dkJD?=
 =?utf-8?B?VWVHWW4wd0NBNzVlWEhBalR3S3hYeWVQM0gzLzdoMFprOXI1clFHS3RCck5h?=
 =?utf-8?B?K3RuS0NtWG5iT1AyZ25uMkZwTkFaMzk2KzZWOEhySURrSEtBTTdrUXVmTWla?=
 =?utf-8?B?K3hpcDFBd2w0Z0QzeVNOV0ZHTDFab3J5R0YxWWdlOVF6QXNuOVg3WU9ibmZ6?=
 =?utf-8?B?Z1lBM3RudHM4WjRrRFFNZVVZQnBnaFhnampxaWw2Y21Vd29YM2hEaHVxV3gy?=
 =?utf-8?B?TXdoSFlKcHZKT1hTVVVaUkNER2N6eXpmWHFKc3hIZ2NHT1llVFhxNUxnMUxp?=
 =?utf-8?B?MHlPa2JUY1hVcDMzK25MUDQzN3p3dk5TR0VkQUxrNzhORUlVdTRCazBCUDRy?=
 =?utf-8?B?RnZFdk1iUVFYSjNKekJxZk5KNnIvSkFhMERwTnd2ZmtVM3d2cXRPc3MwNDRI?=
 =?utf-8?B?TFJTUXhGbkh0T1JUcmJXU3N1UDc1Y1Q5ZjYrb1drTTMxOHFhWldZSUYwQ3FD?=
 =?utf-8?B?aUZML0svN09kNDNJUll5Y0Ryd0k2WDY2eEZqM3BrODdyWnNsbUxaVHp3OU1N?=
 =?utf-8?B?NUdpK3RGMGxlcHpqNEY5QkZpcXRvcmllYnpoNk9yT285ZzdKMURQSHRHZnJQ?=
 =?utf-8?B?aUo3OVhOS3pZK050Y3dUK3lNUXV6ZUkwa3MrNWZBQU1wbCtHbklHd3B1NzFE?=
 =?utf-8?B?RysvOTB5c3JkQnNidk41ckliMnJ1SGlKbmxhNFBucHpFVkJiSkU4QkZvdTB3?=
 =?utf-8?B?Z0RvNnJUR3duWEdzN3JzMUg3NWxHMTFrK1ZGMkdQWnN0VXZaM2NvWGloMHJn?=
 =?utf-8?B?OHEyeW4yTU4xWnJaN3UzUHN2QkVwcXNKaFZVbWJleGpxOHMvaURsQ3p5L0NR?=
 =?utf-8?B?M0tBYXZUdFd0T2gxK3pZSUFvOUowanRoM1I2czNyY1piTStZck9aTXA5WGtS?=
 =?utf-8?B?Wk4wWEV1ajFNZEo2MUlCUXorVDNkcEJ6SkxURWFqU3hDR0M1cXJGUnVQN1E0?=
 =?utf-8?B?bTBLWWd1My9hNTJuRDBmeHpHZ2NQc3pOeXhJS2dNSFFTMHNjelIyUHF2VWtM?=
 =?utf-8?B?KzdkeDZBZFIrcGVnZHNKR0E4MHFvUUhxa0xoRkd3YlpmY2E2Nk9rTTYrRWtw?=
 =?utf-8?B?dDE5bmxzV1dvK24waWNPd2xZbWljc0wwam1nc0YydFE2QlFUbDFCSnJpT1la?=
 =?utf-8?B?Qzk0VmpvTjNtTTdVUUlBYiszS2drcmxuVUhRemtuSDZ4eU1FdjZoRjY1Ulpa?=
 =?utf-8?B?TXNPQk1zQTZ5d0hrKzhZOGlEQldkV1F0M0VGWmpUUE5wYUd2Q3VhTW4rQ1cz?=
 =?utf-8?B?ZTMvVXZEQzFXRTBLdk40YWpQb2x3aUp3aFdBMHg5Ums3cUsvSzRhTktCTnBY?=
 =?utf-8?B?UlhJTDdMbUF6UEJXclRwQlZFdGFiNW1JYXZxM0ZlZVNlaVo1RmpoSHlheVZE?=
 =?utf-8?B?MzU1NHA5QkxvamJ2WVNxdWpZd3Q5K1lzeVJ3ZXhYSnJPcmxpQTNBOFdRbDR0?=
 =?utf-8?B?aGZtNU1pYmRXOUxBaFlRdkNCaCs0ZEF5dTFaQ3NSSWpyUW9lNHNJTk5GRWFG?=
 =?utf-8?Q?oxWsiGXb0+Y2SXcUo28goaWL7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cbf9e7-ca40-43c3-15f1-08dd33ba49b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 10:08:54.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izvaLj3RuhDmO1WNXFpIVV6RZvV5yvAWJLpIIqsYs8bgEXxOYE9EToR7RBubBoFcJ2/hwe44PsJFzjvxgSLglo0QPeoQ8/s2RFaFreXzhPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7735
X-Proofpoint-ORIG-GUID: 8thAYzwda4wSQL6Ls-liLRStpuqpw1ZF
X-Proofpoint-GUID: 8thAYzwda4wSQL6Ls-liLRStpuqpw1ZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130086

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE51bm8gU8OhIDxub25hbWUubnVub0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSmFudWFyeSAxMywgMjAyNSAxMTo1NiBBTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPjsgTWljbGF1cywgQW50b25pdQ0KPiA8QW50b25pdS5NaWNsYXVzQGFu
YWxvZy5jb20+DQo+IENjOiBqaWMyM0BrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGNvbm9y
K2R0QGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBpaW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
cHdtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvM10gZHQtYmlu
ZGluZ3M6IGlpbzogYWRmNDM3MTogYWRkIHJlZmluIG1vZGUNCj4gDQo+IFtFeHRlcm5hbF0NCj4g
DQo+IE9uIE1vbiwgMjAyNS0wMS0xMyBhdCAwOTozNyArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAwOSwgMjAyNSBhdCAwMzozNzowNVBNICswMjAwLCBB
bnRvbml1IE1pY2xhdXMgd3JvdGU6DQo+ID4gPiDCoMKgIGNsb2NrLW5hbWVzOg0KPiA+ID4gwqDC
oMKgwqAgZGVzY3JpcHRpb246DQo+ID4gPiAtwqDCoMKgwqDCoCBNdXN0IGJlICJjbGtpbiINCj4g
PiA+IC3CoMKgwqAgbWF4SXRlbXM6IDENCj4gPiA+ICvCoMKgwqDCoMKgIE11c3QgYmUgImNsa2lu
IiBpZiB0aGUgaW5wdXQgcmVmZXJlbmNlIGlzIHNpbmdsZSBlbmRlZCBvciAiY2xraW4tDQo+ID4g
PiBkaWZmIg0KPiA+ID4gK8KgwqDCoMKgwqAgaWYgdGhlIGlucHV0IHJlZmVyZW5jZSBpcyBkaWZm
ZXJlbnRpYWwuIEJ5IGRlZmF1bHQgc2luZ2xlIGVuZGVkIGlucHV0DQo+ID4gPiBpcw0KPiA+ID4g
K8KgwqDCoMKgwqAgYXBwbGllZC4NCj4gPiA+ICvCoMKgwqAgZW51bTogW2Nsa2luLCBjbGtpbi1k
aWZmXQ0KPiA+ID4gK8KgwqDCoCBkZWZhdWx0OiBjbGtpbg0KPiA+DQo+ID4gV2hpY2ggcGlucyBh
cmUgdGhlc2U/IEkgd2VudCB0aHJvdWdoIGFkZjQzNzEgZGF0YXNoZWV0IGFuZCBubyByZWZlcmVu
Y2UNCj4gPiBvbiBjbG9jayBpbnB1dHMgbGlrZSBjbGtpbiBvciBjbGtpbi1kaWZmLg0KPiA+DQo+
ID4NCj4gDQo+IEhtbSwgSSBndWVzcyB3ZSBzaG91bGQgY2FsbCB0aGlzICdyZWZwJyBhbmQgJ3Jl
ZnAtbicgdGhlbiAodGhlIGxhdHRlciBzZWVtcyBhDQo+IGJpdCBtb3JlIG9kZCk/IE9yIGp1c3Qg
J3JlZicgYW5kICdyZWYtZGlmZic/DQoNClJlZ2FyZGluZyBib3RoIG5hbWluZyBhbmQgYXBwcm9h
Y2gsIEkgZm9sbG93ZWQgSm9uYXRoYW4ncyBzdWdnZXN0aW9uIGluIHYzLg0KSW5pdGlhbGx5IGl0
IHdhcyBhIHNlcGFyYXRlIHByb3BlcnR5IGZvciByZWZpbiBtb2RlIChzZWUgcHJldmlvdXMgdmVy
c2lvbnMpLg0KSWYgaGUgaXMgZmluZSB3aXRoIGNoYW5naW5nIGFnYWluIHRoZSBuYW1lL2FwcHJv
YWNoIEknbGwgZG8gaXQsIGJ1dCBJJ2Qgd2FpdCBmb3INCmhpcyBjb21tZW50Lg0KDQo+IC0gTnVu
byBTw6ENCg0K

