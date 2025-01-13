Return-Path: <linux-pwm+bounces-4593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CFA0B610
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E232161532
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6C1CAA87;
	Mon, 13 Jan 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QWdkTPdi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDC1BF33F;
	Mon, 13 Jan 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769009; cv=fail; b=Ys4sIKNDqeqrYygO5WzXwF5nKwcFjf3gby0OrfGt4F0UshVlscrkl6TMh3jlzKQ/Kvgz4UmWx5mYKW4C+b9ptz/ikJXlbnXI0ze3D2DSPllyu5N4vmcZr+0RlZdBOsWMnc+3MpEuO792svFnzQOuis5YcasqX6UDomSSYSfCK+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769009; c=relaxed/simple;
	bh=h0vuD/ODqpihMdXZ9G1y6MrdV45ud7EMKYuwJ5+bRr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFYEVI8CvtX3YyETjsYOQPbZiI9c8xFQVkBhllh+LgC/GC1vxnNHiuWX5Yc2bbZH3phdZFpzpGE/NI6Eco3jH58hQJaxHUt80+Z9X0jFEjHejmCAl2RdBtc2tR8VmCIcm2jS3pA+g/MjslnZVbXQHq3fXC17XEm6F/ibc5UdiEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QWdkTPdi; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DAg3r8010297;
	Mon, 13 Jan 2025 06:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h0vuD
	/ODqpihMdXZ9G1y6MrdV45ud7EMKYuwJ5+bRr0=; b=QWdkTPdiwuhJK6kben93u
	ylZ/3Hq0pfbKGf7kylBxCMvTrU6g1Fl6ASzE57io4TsEIp8htp2p92ko5Z2dUAa3
	FLqx+OBcMxU3iNQI3ocPbTnt1Ko7ItYHEi16rPY2R4H7J+mojbmIHOlbvlm5u0Ds
	Mufqz5jwFgit3YEHw5gECKPv3yOJLtEX9Xw6idK381vqFmfUbO/5dzYP536MH+1E
	mlJV5XotUECJnqH1jdolUT4/q3MOJI9uVo2DYC45dmB+LauWyDTt/3K9pU4v3vd/
	lqO0emc64Hxu9E24RSJWRjQK7953sMmBmCxPHZkOkklmWlI+uPrCZ3HdksWgd/As
	Q==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4451ae0609-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 06:50:03 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXKunnikFJDJuwetnNtl5DZIAaLP7Glpgj20CVzpd8eKMVaU0onQXnOimiDty10P+JwUnarvg49ySFkL1ftvVBIz2P5vIFQZUO3e7sWyZ1RiX8hovEa/yJKYNBn6tNALMEBrpQl7i2d+pQEnTNLSp4Hh4Z0DOPtBsbXtoVx7r6zz3mXLxnvOY3aBl8JrFYVXdn6I5xYLmOrPvOx4uCbhPUG5QASrczua/xvsHnPUPPiA6n6mrkNo8xziXKjZBz86hWkZ0nd8T7jAyOw6Rj4sl2IDEH3IrTtBKO7qlJPG84+htDCy0ExbYAVYFIV59TP8sum/nez4vZIw9jJZmTU1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0vuD/ODqpihMdXZ9G1y6MrdV45ud7EMKYuwJ5+bRr0=;
 b=nCVueldG7PuIlqlrh9BQSFquLv1bR6Rmn4qIc3uzGkQJFbJH3J1Axkt6CbOWEQbNU0D8RE9GCuSwATJRHt3iKzQOC03YFqxMd5V39Q7kYskkOwKXzxacoWyLPXkMu9GBkDYU5ZLXooqbP27Esp6kteXXKq4wWRn7D76+MoJzhKvp+UHSmZwcCGzj+n/h1Kh0XK/k3U/PLa9faB0J0O7uh5JzMGX/0SncScXBKA2+SA9tffy38yqWkOaCrUVuFzmzlbOFXPelHCA2vKiO53VBegwbtvaswJItnlSkAapcjBL/BKgI15yZNHalmCg2eA22PRu4Ne7M7/kS7dKAMTvy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BY1PR03MB7215.namprd03.prod.outlook.com (2603:10b6:a03:525::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Mon, 13 Jan
 2025 11:50:01 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 11:50:01 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
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
Thread-Index:
 AQHbYpudlLVpwmjmO0uuJhKC7L5nTLMUZ20AgAAV/ICAAAcvAIAAD5oAgAAB3wCAAAOpMA==
Date: Mon, 13 Jan 2025 11:50:01 +0000
Message-ID:
 <CY4PR03MB33993668E69121A9F786E5219B1F2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
 <20250109133707.3845-2-antoniu.miclaus@analog.com>
 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
 <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
 <499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
 <98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
 <f47bc5f9-cabc-4cbb-b641-693f3c729012@kernel.org>
In-Reply-To: <f47bc5f9-cabc-4cbb-b641-693f3c729012@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0TlRsak5ESXpOaTFrTVdFMExURXhaV1l0WWpBeE1DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjT0RVNVl6UXlNemN0WkRGaE5DMHhN?=
 =?utf-8?B?V1ZtTFdJd01UQXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNRFUySWlCMFBTSXhNek00TVRJME1qWXdNekUwTWpnMk5Ea2lJR2c5SW1w?=
 =?utf-8?B?Tk9GVXJUMHhKU2tsd1QzUllWa1pDVWxoUFoxWjZSV05uYnowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVhBNVEwcEpjMWRZWWtGa05rUjZUSFJWVjNKWGRE?=
 =?utf-8?B?TnZVRTExTVZKaGRHRXdSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BY1PR03MB7215:EE_
x-ms-office365-filtering-correlation-id: 25b22c4b-cc57-42c3-929d-08dd33c86961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OE92WFNDZlFUYVFVQWZhbHV5L21CVjJHWDdsN3pldXM4MUh3WG54MGRlTnBp?=
 =?utf-8?B?UDR0cHlFTkhkc0F3SXYxc2dUMVJka0NHbDMrUmFDL25MbzRzTGxlblNZWWRm?=
 =?utf-8?B?NEp2UDFRbGpRbFduc2FacysybGJlQXJSS0p1MUFURCtSWDI1cW5paWVOWnNG?=
 =?utf-8?B?ZVAxVU5DSmZ4K2lvOVFmNkZjSkdZZmVaN0ptMzlsRzBzdjN0cU9GbGxxS3Ba?=
 =?utf-8?B?QVZQZjJWd2dzb3ltMHRNOEw1eVFOaklpU0xHL042VGQ1LzNVVlRaY2Vxb2d1?=
 =?utf-8?B?UEVpNE10R1pWcWhEUlVpajFVQUhwbnNYaEJ3YjdSdHVhYlY4bURkY3pJcTJR?=
 =?utf-8?B?WE9tajh6TWRSK0lwUmo4U0M4b0sxNWV2TEx6WnhoM1N0NGVLWVhUQzFvZ1ov?=
 =?utf-8?B?Z3R3dHRsU0k1amo5eGVVN1dnb21raVh4aUgrM2ZXWDhuYWswWmt5OVhGakhm?=
 =?utf-8?B?WHVQT3Q4R09MOW03WFpRa09YZ3NUQTd2MUd3VW83alJ0aFhXNDdQWHllNk9h?=
 =?utf-8?B?bWI1dS9BdEt3MmVZaFg5UEwyN1hvQndkZ3hvbm11b2xJNmhHKzVRYktTWnZv?=
 =?utf-8?B?VW9ndmFmRUZHcmxSZWJJSU0xTGE5SjY3NlBWa2F0SE9FZlhKSk51L09KeGhq?=
 =?utf-8?B?dEdZdUpaQmxTWWRLNmw5M2pYRWFtWFJjQ3hSK3NIZk5hWkRSTUhpMFZEZmRK?=
 =?utf-8?B?MUpRUks5aXF3UW9KOU44ZWo2VEpRTE16cGZLVkhkcStiWndMUFJ1Q1dMem1v?=
 =?utf-8?B?ZzNYU2dRQ3Rvc3MyVmMrazhFSVJ3N0pyblh4QlJYVDFlQllaQmJLUStjOGhk?=
 =?utf-8?B?YVFiMDRCb0RBT3k5bnBURzFVYzNHS3FrQU8rZkdQSGpMbjN4OWJvdFhuOWth?=
 =?utf-8?B?ek5lbGxyb2VQVXNpSUdQMHZ6ZXdDYUd1STNJb0t2U1loNVA0VDlLZWxVK2E4?=
 =?utf-8?B?VmljNHZ3bndheWcyWW02WTBZSGJWbHMvejZWOXNuSXQydm9GZnlGb2JDMTQ0?=
 =?utf-8?B?YkdWZkhuWFA0amlheWwrd3R4N1R2ZW4vRjVoRTNUWHlmaFFxSkZ6VnNUNmV6?=
 =?utf-8?B?M0MvalB3ZFBrNUdaUGtjK1RjSTRrRTVxYmlTdGdjUWVTV01WVnQwNjNlVkxy?=
 =?utf-8?B?SlJOTzdvOFdtNy9VclVFNkdJNDYwT0tuRmpLL3I1VHlBZVRoOXFLaDNUTFR2?=
 =?utf-8?B?eGxacG1ZcGdaOExJN09PbGljRVR5N0dpTUlYV1VVNGpRNCswcURZcHFiSFJB?=
 =?utf-8?B?MzMzdzYvOTl6N091RTVML2EzTXBtTjM2S1dPenVUVW1PN094R3hvUzdpL0Jm?=
 =?utf-8?B?Vk1jM3BHSllIRUdwN1ZNT09pdUpscUhzNGoxbjdkNXkxZlMreEFKNFc1My9X?=
 =?utf-8?B?SWl1aGxGRzdzdmlFYnF3UWRIamU3U0VHcnRORUE3UlNuV2ZxU3NRSDlKK3Rx?=
 =?utf-8?B?UFNEVDI3a3Y1SG1CYTVCRERWOUhFWGZxejNuTHpJcnM2SWdCVDVPTjRZaE41?=
 =?utf-8?B?bGxsOWJPVUE2cDBzRkNUazVaWDd1SUxrZXQ4c3JOUjZHODZRLzVpTXFsNGRz?=
 =?utf-8?B?M3p5WnpsQjJ1cnBRL2IvaTB3cisyMnlRSUthR2RqazZxNEZyM3kzZGNzOHJK?=
 =?utf-8?B?S0kvWHVEai9MOCtuN2QyOGVQaWE2aVpITSs1VjBkTjhnQU9lWUtFKzFzUW11?=
 =?utf-8?B?UWR6N1QrYThxNk9wRXZ5ZW1pMUpxa1J0VmVpdlo1MHpzTnEySmdTbDVSRVRa?=
 =?utf-8?B?N25BZ1pBdUlMdzJKbUlkYkoxV1lSeDlObVZCRzlCaFRlZHdJREpkU2N0WjlV?=
 =?utf-8?B?QWtleWhpTGVMZGZIYW1TYTE4b1lFN20yeEs2cGcrT0VkRk9aazBTY2sxVk1X?=
 =?utf-8?B?a1JXVnc0STZiTnR0VngxYlU1MHEvdGl4cXVldlpEWHZ5ZUREcUprNmY1RUdh?=
 =?utf-8?Q?bxwQWj4vCj3LZRBHJJv4ZuLvIB18Dw+E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU00ZHg3RkF1Z1JId3paT1JVVUVqR2hyK2dnR3NkcmZRNlRXemIxQktlaEdy?=
 =?utf-8?B?cXI4clBMSTJ1dlhVVDR5K2lNWTF0VHB2RDdKNVhBVHJRVGpUZmhRVkJzSFF1?=
 =?utf-8?B?azVaWFJZRzVlV3I0c2xNNFhOSTRRWEpFWEVsOTR3SGJQSlRnWE5GeXBuaFV4?=
 =?utf-8?B?a1JtV29FTUpOZFZBcW9uTDQzdTFDYXNtSFdlOHZFSFJ2MTRRQ2dFWXZDQUps?=
 =?utf-8?B?WlBZUEJyMlRZT0cvZSs3YWx0V2ZZcURzSlRSNXdNdEZnWlZsQWluSzQ5WG5G?=
 =?utf-8?B?OGFlcXU2SkNjT2hLNmxEQmhzRjVRU1lEMTVHbUIyczZETGJ3dExsK2xLVGFI?=
 =?utf-8?B?aFlYNzBBalZhUjJWbWhOY1ZhMXAxSjhISkZXOFM0YkpOallPNTM3TWwxY2Uz?=
 =?utf-8?B?ZDJiNFUvSFkvK2ZoTy9PcUNhNXJoWFk3U0JGdWl3RlJXNENxTjd0ak96Znox?=
 =?utf-8?B?Z1NHUXVoTXNVcDJWUHhYbUlzRTQrTFM4dnRZa3lqZWtKSEtXYnR3OTh6Nk1w?=
 =?utf-8?B?RUxnRGlrWUFQbDN3SWNSL3BOc0FPZEczUGp0a0JvUkJSOEhlRjJSVGRRcjBy?=
 =?utf-8?B?c3dmQU5aMTFHdHVLNGhXclQ5NU9GUzBjcGZ4SFVMbTBEVk9FODRENVlFWisy?=
 =?utf-8?B?TUYzZjlCYzZyVUs1NlNwVFRoMkx6WFhQNDl2MFdBblk0L0JhVnFOMUlvNGNU?=
 =?utf-8?B?OTB6RkRvNWNheUtHQ3RnYjZVbXQxeDVnSmRpOS9qZXVuMEh1V082eVppUlBy?=
 =?utf-8?B?TXcySmVFTURhVmNUUDVqZEVBM0k3VXIyZ2VaS2k0VllrRnR1U0ZhOXp3YmJ4?=
 =?utf-8?B?cUFOVjlmMk12cGZjbUhxaFRDWmNGTFJDNkhjNWVnVEQ2d3A0bFdSa1hpTFpW?=
 =?utf-8?B?V1RkU1VoNE1hbmd6R3c5N3A0b0FqM0RwWDY1RUZRTEl5QmgyaWNuOVg4SmZH?=
 =?utf-8?B?bzF5ZHUvOExzQUdDS1gyMm5wb1N3QUdRZHF1M2xpclB5MFdidjdrNGNsS2k1?=
 =?utf-8?B?OFRURVRqUG9ZV2NLbzB2SXN3VVdxVEc2cEE3aHVTcFhCdUs0Tk43TG9ZMWNI?=
 =?utf-8?B?aGNHbXB6SGJmMlhhSFFIbzNreWJvSFVGMEJkTkJQNDVsMDVTVlUwcUhNMHow?=
 =?utf-8?B?SHpYRDdFV0YyVDd6cmZjRDZmMW1ZSVBEb1RGRFRhcnJwTGk5SUcwRXltY2ZK?=
 =?utf-8?B?SVdjdHNibG0yN2VFVURFZk0xOUxmMFBtL2pINHlyMU1FdDB6c0NkVi8xU0JL?=
 =?utf-8?B?SXdVcnBybnhYOWFla1lRdFh4c0E2dG9yeWx4dGwwVW9jMU16MGFZTkFRN1ND?=
 =?utf-8?B?bDNxNFEyUjdWUmE1NllXb0tTeVFuNkRMME5FMFUrQURRc0NESGZzVy9rNys1?=
 =?utf-8?B?YmVPdldLemh6d3ZPN1hISjFTNnFzYXhCMTF3bEpPR25KRXV4alNiVTZJbkpM?=
 =?utf-8?B?R2gvenRBMm9ZZVhwQ0h1NEM0N3hKcE9SMnFxRWdHa1MzbU5CbVo2MnFDYVM2?=
 =?utf-8?B?c0tvekFRS2Q2TjUrVW5yTlRmdnhtTHdqZ0VKenViMDVhOG1aaG1yVWJlY09x?=
 =?utf-8?B?YUM4ckV5Z3RicHlHSnhONnhwRVdEQTZyUzl5cVNORzNRSjFzQmpyLy8yb0dD?=
 =?utf-8?B?dldVZWdOY3RZOGxJOHc2a0RTR05TTlZPWnZVclp4TXFPUE1VNXh2Tjk4VkV3?=
 =?utf-8?B?T3pTTW5vNnRIVmlnR1FvV2lQcTlFNVNpSjJYamRaR3hPWHhaejR0YkdwNTdq?=
 =?utf-8?B?TFdyL0lxdmZJOWJTT2JIajZ5M3pTWERJcnNYN2R4bHNEU0VRR2V2cG16bGpE?=
 =?utf-8?B?QlQ3ZmVqU2ZMMml5MzRZbHNOSjFLejBiUHNYeVVPR0Z3cFdNU3NTdmZKWmkz?=
 =?utf-8?B?Zk5qd09EVDY4ZXRlTnV6b0s3UUhidURRK05RVjJFK2dvdG94VlRLUkxzclB6?=
 =?utf-8?B?alQ4VGtQVlNXc3JtdExXMjgxK0xteFRZY1FiNGw1VU9US0gyZGFtd0ZSOGxh?=
 =?utf-8?B?YzdUQkd1QlFWMTFCRXRiMDhsSllvaTVhMWU4V0xGOG1CYXZpMjFQOWRGQVpZ?=
 =?utf-8?B?QmZta2o2dE1hOVVSYjV2Nkozb0huek1FVWNwZ0pjUnljSUNleDBGUWJoSHJS?=
 =?utf-8?Q?JzsdCrGzouxi7Wx176g1Vkejg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b22c4b-cc57-42c3-929d-08dd33c86961
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 11:50:01.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crQeq2cq/kqb3Y+zhiGwS0TMyPjuZnroqI3KE+M+HAPv8AXJ8Kx0mP/9TIGAnCUm3hyoYifAXUEOjElAmcEJtD2zsPn9e9a/vN3qTw826eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7215
X-Proofpoint-GUID: Zvgb4e2OOWXb-YilQKvgtD2K-fBHxX9r
X-Proofpoint-ORIG-GUID: Zvgb4e2OOWXb-YilQKvgtD2K-fBHxX9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130099

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDEzLCAyMDI1IDE6MjQgUE0NCj4gVG86IE51bm8gU8OhIDxub25hbWUu
bnVub0BnbWFpbC5jb20+OyBNaWNsYXVzLCBBbnRvbml1DQo+IDxBbnRvbml1Lk1pY2xhdXNAYW5h
bG9nLmNvbT4NCj4gQ2M6IGppYzIzQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgY29ub3Ir
ZHRAa2VybmVsLm9yZzsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1w
d21Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8zXSBkdC1iaW5k
aW5nczogaWlvOiBhZGY0MzcxOiBhZGQgcmVmaW4gbW9kZQ0KPiANCj4gW0V4dGVybmFsXQ0KPiAN
Cj4gT24gMTMvMDEvMjAyNSAxMjoxNywgTnVubyBTw6Egd3JvdGU6DQo+ID4gT24gTW9uLCAyMDI1
LTAxLTEzIGF0IDExOjIxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+PiBP
biAxMy8wMS8yMDI1IDEwOjU1LCBOdW5vIFPDoSB3cm90ZToNCj4gPj4+IE9uIE1vbiwgMjAyNS0w
MS0xMyBhdCAwOTozNyArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4+PiBP
biBUaHUsIEphbiAwOSwgMjAyNSBhdCAwMzozNzowNVBNICswMjAwLCBBbnRvbml1IE1pY2xhdXMg
d3JvdGU6DQo+ID4+Pj4+IMKgwqAgY2xvY2stbmFtZXM6DQo+ID4+Pj4+IMKgwqDCoMKgIGRlc2Ny
aXB0aW9uOg0KPiA+Pj4+PiAtwqDCoMKgwqDCoCBNdXN0IGJlICJjbGtpbiINCj4gPj4+Pj4gLcKg
wqDCoCBtYXhJdGVtczogMQ0KPiA+Pj4+PiArwqDCoMKgwqDCoCBNdXN0IGJlICJjbGtpbiIgaWYg
dGhlIGlucHV0IHJlZmVyZW5jZSBpcyBzaW5nbGUgZW5kZWQgb3IgImNsa2luLQ0KPiA+Pj4+PiBk
aWZmIg0KPiA+Pj4+PiArwqDCoMKgwqDCoCBpZiB0aGUgaW5wdXQgcmVmZXJlbmNlIGlzIGRpZmZl
cmVudGlhbC4gQnkgZGVmYXVsdCBzaW5nbGUgZW5kZWQNCj4gPj4+Pj4gaW5wdXQNCj4gPj4+Pj4g
aXMNCj4gPj4+Pj4gK8KgwqDCoMKgwqAgYXBwbGllZC4NCj4gPj4+Pj4gK8KgwqDCoCBlbnVtOiBb
Y2xraW4sIGNsa2luLWRpZmZdDQo+ID4+Pj4+ICvCoMKgwqAgZGVmYXVsdDogY2xraW4NCj4gPj4+
Pg0KPiA+Pj4+IFdoaWNoIHBpbnMgYXJlIHRoZXNlPyBJIHdlbnQgdGhyb3VnaCBhZGY0MzcxIGRh
dGFzaGVldCBhbmQgbm8NCj4gcmVmZXJlbmNlDQo+ID4+Pj4gb24gY2xvY2sgaW5wdXRzIGxpa2Ug
Y2xraW4gb3IgY2xraW4tZGlmZi4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSG1tLCBJ
IGd1ZXNzIHdlIHNob3VsZCBjYWxsIHRoaXMgJ3JlZnAnIGFuZCAncmVmcC1uJyB0aGVuICh0aGUg
bGF0dGVyIHNlZW1zDQo+ID4+PiBhDQo+ID4+PiBiaXQgbW9yZSBvZGQpPyBPciBqdXN0ICdyZWYn
IGFuZCAncmVmLWRpZmYnPw0KPiA+Pg0KPiA+PiBUaGF0IG1pc3Rha2Ugd2FzIGRvbmUgYXQgdGhl
IGJlZ2lubmluZyAtIHRoZSAiY2xraW4iIGlzIGp1c3QgdXNlbGVzcw0KPiA+PiBuYW1lLiBJdCBj
YW5ub3QgYmUgImNsa291dCIgYW5kIGl0IGNhbm5vdCBiZSBhbnl0aGluZyBlbHNlIHRoYW4gY2xr
LCBzbw0KPiA+PiBpdCBpcyAxMDAlIHJlZHVuZGFudC4NCj4gPj4NCj4gPg0KPiA+IE9oIHN1cmUu
Li4gTWFrZXMgc2Vuc2UgYW5kIEkgZm9yZ290IHRoYXQgdGhlIHByb3BlcnR5IGlzIG5vdCBuZXcu
Li4NCj4gPg0KPiA+PiBCdXQgbG9va2luZyBmb3IgcGlucyBicm91Z2h0IHNlY29uZCBwb2ludCAt
IGhlcmUgeW91IGNsYWltIHRoZXNlIGFyZQ0KPiA+PiBtdXR1YWxseSBleGNsdXNpdmUgd2hpbGUg
ZGF0YXNoZWV0IHN1Z2dlc3RzIHRoYXQgYm90aCBpbnB1dHMgY2FuIGJlDQo+ID4+IGNvbm5lY3Rl
ZC4gVW5sZXNzIHRoZXkgY29tZSBmcm9tIHRoZSBzYW1lIHNvdXJjZSBhbHdheXM/DQo+ID4+DQo+
ID4NCj4gPiBJZiB5b3UgaGF2ZSBhIHNpbmdsZSBlbmRlZCBpbnB1dCB0aGVuIG9ubHkgb25lIHBp
biAodGhlIHBvc2l0aXZlIG9uZSkgd2lsbCBiZQ0KPiA+IHVzZWQuIElmIHRoZSBpbnB1dCBzaWdu
YWwgaXMgZGlmZmVyZW50aWFsLCB0aGVuIGJvdGggcGlucyB3aWxsIGJlIHVzZWQuIFNvIHRoZXkN
Cj4gDQo+IEJ1dCB0aGUgY2xvY2tzIGRlc2NyaWJlIGlucHV0IHBpbnMsIGF0IGxlYXN0IGluIHR5
cGljYWwgY2FzZSwgc28gdGhhdCdzDQo+IG15IHF1ZXN0aW9uOiBob3cgbWFueSBjbG9jayBzb3Vy
Y2VzIGRvIHlvdSBoYXZlIGhlcmU/IE9uZSBvciB0d28/DQo+IA0KPiA+IGFyZSBtdXR1YWxseSBl
eGNsdXNpdmUuLi4gWW91IGVpdGhlciBoYXZlIHNpbmdsZSBlbmRlZCBvciBhIGRpZmZlcmVudGlh
bCBpbnB1dC4NCj4gPiBBbmQgZGVwZW5kaW5nIG9uIHRoZSBpbnB1dCB0eXBlLCB0aGUgbGltaXQg
b2YgdGhlIGlucHV0IGZyZXF1ZW5jeSB2YXJpZXMuDQo+IA0KPiBCYXNlZCBvbiB0aGlzLCB0aGlz
IGlzIHRoZSBzYW1lIGNsb2NrLCBzbyB1c2luZyAiZGlmZiIgaXMgbm90IGEgcHJvcGVydHkNCj4g
b2YgImNsb2NrcyIuIExvb2sgYXQgb3RoZXIgYmluZGluZ3MgaG93IHRoZXkgZW5jb2RlIGRpZmZl
cmVudGlhbCBjaG9pY2UNCj4gZm9yIHNvbWUgc2lnbmFscyAtIHVzdWFsbHkgYm9vbCBwcm9wZXJ0
eSwgYnV0IG5vdCBhbHdheXMgLSBzZWUgb3RoZXINCj4gYWRpL2FkbXYgZGV2aWNlcy4NCg0KVGhp
cyBhcHByb2FjaCB0aGF0IHlvdSBzdWdnZXN0IHdhcyBpbXBsZW1lbnRlZCBpbiBwYXRjaCBzZXJp
ZXMgdjEgKGFzIGJvb2xlYW4pIC8gdjMgKGFzIGVudW0pLg0KQmFzZWQgb24gZmVlZGJhY2sgaW4g
djMgcmVjZWl2ZWQgZnJvbSBKb25hdGhhbiBJIHN3aXRjaGVkIHRvIHRoaXMuIFNob3VsZCBJIHJl
dmVydCBpdD8NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

